local M = {}

local function sayMyName()
    print('koutarn')
end

function M.sayHello()
    print('Whey hello there')
    sayMyName()
end

return M
