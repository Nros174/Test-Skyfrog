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
    เข้าสู่ระบบและตรวจสอบความสำเร็จ    ${Valid_Username}    ${Valid_Password}

เข้าสู่ระบบด้วยชื่อผู้ใช้งานที่ถูกต้องและรหัสผ่านผิด
    เข้าสู่ระบบและตรวจสอบความล้มเหลว    ${Valid_Username}    ${Invalid_Password_Number}    password-error

เข้าสู่ระบบด้วยชื่อผู้ใช้งานที่ถูกต้องและไม่ใส่รหัสผ่าน
    เข้าสู่ระบบและตรวจสอบความล้มเหลว    ${Valid_Username}    ${EMPTY}    Password-error

เข้าสู่ระบบด้วยชื่อผู้ใช้งานผิดและรหัสผ่านถูกต้อง
    เข้าสู่ระบบและตรวจสอบความล้มเหลว    ${Invalid_Username}    ${Valid_Password}    password-error

เข้าสู่ระบบด้วยชื่อผู้ใช้งานผิดและรหัสผ่านผิด
    เข้าสู่ระบบและตรวจสอบความล้มเหลว    ${Invalid_Username}    ${Invalid_Password_Number}    password-error

เข้าสู่ระบบด้วยชื่อผู้ใช้งานผิดและไม่ใส่รหัสผ่าน
    เข้าสู่ระบบและตรวจสอบความล้มเหลว    ${Invalid_Username}    ${EMPTY}    Password-error

เข้าสู่ระบบด้วยรหัสผ่านถูกต้องและไม่ใส่ชื่อผู้ใช้
    เข้าสู่ระบบและตรวจสอบความล้มเหลว    ${EMPTY}    ${Valid_Password}    Username-error

เข้าสู่ระบบโดยไม่ใส่ชื่อผู้ใช้งานและรหัสผ่านผิด
    เข้าสู่ระบบและตรวจสอบความล้มเหลว    ${EMPTY}    ${Invalid_Password_Text}    Username-error

เข้าสู่ระบบโดยไม่ใส่ชื่อผู้ใช้งานและไม่ใส่รหัสผ่าน
    เข้าสู่ระบบและตรวจสอบหลายข้อผิดพลาด    ${EMPTY}    ${EMPTY}

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
    Close Browser

เข้าสู่หน้าหลัก
    Wait Until Element Is Visible    xpath=/html/body/div[1]/div[1]/div/div[2]/ul/li/a    timeout=10s


ตรวจสอบข้อความผิดพลาด
    [Arguments]    ${element_id}
    Wait Until Element Is Visible    id=${element_id}    timeout=5s
    Run Keyword If    '${element_id}'=='Username-error'    Element Text Should Be    id=Username-error    Please enter your Username.
    Run Keyword If    '${element_id}'=='Password-error'    Element Text Should Be    id=Password-error    Please enter your Password.
    Run Keyword If    '${element_id}'=='password-error'       Element Text Should Be    id=password-error    username or password is incorrect


ตรวจสอบหลายข้อความผิดพลาด
    Element Text Should Be    id=Username-error    Please enter your Username.
    Element Text Should Be    id=Password-error    Please enter your Password.

เข้าสู่ระบบและตรวจสอบความสำเร็จ
    [Arguments]    ${username}    ${password}
    เข้าสู่ระบบ    ${username}    ${password}
    เข้าสู่หน้าหลัก
    ปิดเบราว์เซอร์

เข้าสู่ระบบและตรวจสอบความล้มเหลว
    [Arguments]    ${username}    ${password}    ${error_id}
    เข้าสู่ระบบ    ${username}    ${password}
    ตรวจสอบข้อความผิดพลาด    ${error_id}
    ปิดเบราว์เซอร์

เข้าสู่ระบบและตรวจสอบหลายข้อผิดพลาด
    [Arguments]    ${username}    ${password}
    เข้าสู่ระบบ    ${username}    ${password}
    ตรวจสอบหลายข้อความผิดพลาด
    ปิดเบราว์เซอร์

