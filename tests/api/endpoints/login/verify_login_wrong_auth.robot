*** Settings ***
Resource  ../../../../testdata/variables/imports.resource
Resource  ../../../../keywords/imports.resource

Library  RequestsLibrary

Test Template  Custom Test Template

*** Test Cases ***                              USERNAME        PASSWORD
Verify Login With Wrong Password Returns 401    admin           wrongPass

Verify Login With Wrong Username Returns 401    guest           masterPass

Verify Login With Empty Data Returns 401        ${Empty}        ${Empty}

Verify Login With Wrong Username And Password Returns 401    guest           wrongPass

*** Keywords ***
Custom Test Template
  [Arguments]  ${username}  ${password}
  Log To Console    \nSending Request To ${Global_ENDPOINT_LOGIN}\n
  Log    \nSending Request To ${Global_ENDPOINT_LOGIN}\n
  &{jsonBody}  Create Dictionary  username=${username}  password=${password}
  ${response}  POST  url=${Global_ENDPOINT_LOGIN}  json=${jsonBody}  expected_status=401
  Validate Schema    inputJson=${response.json()}    referenceSchemaPath=${GLOBAL_SCHEMA_ERROR}