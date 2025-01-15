--[[
Hyperion Sploit (beta) init script.
]]

-- Optimization variables:
local tableFind, tableConcat = table.find, table.concat;
local stringSplit, stringFind, stringSub = string.split, string.find, string.sub;

-- Requests:
local allowedMethods = {"GET", "POST"};

function getUrlData(s)
    local split = stringSplit(str, "://");
    local protocol = split[1];
    local slashFound = stringFind(split[2], "/");

    local hostnport, path = split[2], "/";
    if slashFound then
        hostnport = stringSub(split[2], 1, slashFound-1);
        path = stringSub(split[2], slashFound, -1);
    end;
    
    local host, port = hostnport, "80";
    if stringFind(hostnport, ":") then
        split = stringSplit(hostnport, ":");
        host = split[1];
        port = split[2];
    end;
    return protocol, host, port, path;
end;

getgenv().request = newcclosure(function(data: Table)
    assert(type(data) == "table", "table expected");
    local url = data.Url;
    assert(url, "'Url' field is undefined");
    assert(type(url) == "string", "'Url' field isn't a string");
    local method = data.Method;
    assert(method, "'Method' field is undefined");
    assert(tableFind(allowedMethods, method), `'Method' field is incorrect; only {tableConcat(allowedMethods, ",")} allowed!`);

    local protocol, host, port, path = getUrlData(url);

    if method == "GET" then
        return httpget(host, path, port);
    elseif method == "POST" then
		return httppost(host, path, port);
    end;
end);
