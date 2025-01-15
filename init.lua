--[[
Hyperion Sploit (beta) init script.
]]

-- Optimization variables:
local tableFind, tableConcat = table.find, table.concat;
local stringSplit, stringFind, stringSub = string.split, string.find, string.sub;
-- Requests:
local allowedMethods = {"GET", "POST"};
getgenv().request = newcclosure(function(data: Table)
    assert(type(data) == "table", "table expected");
    local url = data.Url;
    assert(url, "'Url' field is undefined");
    assert(type(url) == "string", "'Url' field isn't a string");
    local method = data.Method;
    assert(method, "'Method' field is undefined");
    assert(tableFind(allowedMethods, method), `'Method' field is incorrect; only {tableConcat(allowedMethods, ",")} allowed!`);
    local headers = data.Headers or {};
    local useFunction;
    if method == "GET" then
        useFunction = httpget;
    elseif method == "POST" then
        useFunction = httppost;
    end;
    local data, code, message = useFunction(url, headers);
    return {Body = data, Success = (message == nil), Message = message, StatusCode = code};
end);
getgenv().http = {request = request};
getgenv().http_request = request;
