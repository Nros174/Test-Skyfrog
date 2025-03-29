*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${DEV_URL}                   https://test.skyfrog.co/Home
${BROWSER}                   chrome
${Valid_Username}            admin
${Valid_Password}            1234
${Invalid_Username}          admin11
${Invalid_Password_Number}   12345
${Invalid_Password_Text}     pass
${EMPTY}    

*** Test Cases ***

กรอกชื่อผู้ใช้งานและรหัสผ่านที่ถูกต้อง แต่ไม่กดปุ่ม Login
    เปิดหน้าเข้าสู่ระบบ
    ใส่ข้อมูลเข้าสู่ระบบ    ${Valid_Username}    ${Valid_Password}
    ปิดเบราว์เซอร์

เข้าสู่ระบบด้วยชื่อผู้ใช้งานและรหัสผ่านที่ถูกต้อง
    เข้าสู่ระบบ    ${Valid_Username}    ${Valid_Password}

เข้าสู่ระบบด้วยชื่อผู้ใช้งานที่ถูกต้องและรหัสผ่านผิด
    เข้าสู่ระบบ    ${Valid_Username}    ${Invalid_Password_Number}

เข้าสู่ระบบด้วยชื่อผู้ใช้งานที่ถูกต้องและไม่ใส่รหัสผ่าน
    เข้าสู่ระบบ    ${Valid_Username}    ${EMPTY}

เข้าสู่ระบบด้วยชื่อผู้ใช้งานผิดและรหัสผ่านถูกต้อง
    เข้าสู่ระบบ    ${Invalid_Username}    ${Valid_Password}

เข้าสู่ระบบด้วยชื่อผู้ใช้งานผิดและรหัสผ่านผิด
    เข้าสู่ระบบ    ${Invalid_Username}    ${Invalid_Password_Number}

เข้าสู่ระบบด้วยชื่อผู้ใช้งานผิดและไม่ใส่รหัสผ่าน
    เข้าสู่ระบบ    ${Invalid_Username}    ${EMPTY}

เข้าสู่ระบบด้วยรหัสผ่านถูกต้องและไม่ใส่ชื่อผู้ใช้
    เข้าสู่ระบบ    ${EMPTY}    ${Valid_Password}

เข้าสู่ระบบโดยไม่ใส่ชื่อผู้ใช้งานและรหัสผ่านผิด
    เข้าสู่ระบบ    ${EMPTY}    ${Invalid_Password_Text}

เข้าสู่ระบบโดยไม่ใส่ชื่อผู้ใช้งานและไม่ใส่รหัสผ่าน
    เข้าสู่ระบบ    ${EMPTY}    ${EMPTY}

*** Keywords ***
เปิดหน้าเข้าสู่ระบบ
    Open Browser    ${DEV_URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    xpath=/html/body/div[2]/form/div[1]/div/input    timeout=10s

ใส่ข้อมูลเข้าสู่ระบบ
    [Arguments]    ${username}    ${password}
    Input Text    xpath=/html/body/div[2]/form/div[1]/div/input    ${username}
    Input Text    xpath=/html/body/div[2]/form/div[2]/div/input    ${password}

เข้าสู่ระบบ
    [Arguments]    ${username}    ${password}
    เปิดหน้าเข้าสู่ระบบ
    ใส่ข้อมูลเข้าสู่ระบบ    ${username}    ${password}
    Click Element    xpath=/html/body/div[2]/form/div[3]/button/span
    ปิดเบราว์เซอร์

ปิดเบราว์เซอร์
    Close Browser
