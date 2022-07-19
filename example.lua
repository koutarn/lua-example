-- コメント

-- [[
-- [[]]で
-- マルチラインコメントになる
--]]

-- =========================
-- variable
-- =========================


-- localを付けないとglobal扱い
adsf = 50

-- local変数
local num = 39

local s = 'string'
local t = "double-quotes"
local u = [[
muleti
    line
        strings
]]

local nil_ = nil

if num > 40 then
    print('over 40')
else
    print('lower 40')
end

if s ~= 'asdf' then
    print('~はnot equalです')
end

print('..を使うと' .. '文字結合が出来ます')

-- 未定義変数はnil
local foo = bar
print(foo)

foo = false
print(foo)

if nil or false then
else 
    print('nilとfalseはfalsy')
end

if 0 or '' then
    print('0と空白はtrue')
end

-- sum = 0
-- for i = 1, 100 do
--     sum = sum + i
--     print(sum)
-- end

-- =========================
-- function
-- =========================

function print_table(a)
    for key, value in pairs(a) do
        print(key,value)
    end
end

function add(a,b)
    return a + b
end
print(add(10,20))

function adder(x)
    return function(y)return x + y end
end

a1 = adder(9)
a2 = adder(36)
print(a1(16))
print(a2(64))

-- 複数入れたり戻せたりする。入りきれないものはnilになる
x,y,z,zz = 1,2,3
print(x,y,z,zz)

function bar(a,b,c)
    print(a,b,c)
    return 4
end

x,y = bar('zaphod')
print(x,y)

-- 関数は第一級関数
local function f(x)
    return x * x
end
local fv = function (x) return x * x end

print(f(10))
print(fv(20))

local function g(x)
    return math.sin(x)
end
local g;g = function (x) return math.sin(x) end
local aaa = function (x) return math.sin(x) end

-- 引数が文字列一つならカッコを省略可能
print 'hello'

-- =========================
-- table
-- =========================

-- keyを.fooまたは['bar']でアクセス出来る
dic = {key1 = 'value1',key2 = false}
print(dic)
print(dic.key1)
print(dic['key1'])

dic.key2 = nil
print(dic.key2)

dic2 = {['@!#'] = 'qbert',[{}] = 1729,[6.28] = 'tau'}
print(dic2['@!#'])
print(dic2[{}])
print(dic2[6.28])

function h(x) print(x.key1) end
h{key1 = 'Sonmi~451'}

-- pairsで取りだせる
-- goにちとにてる
for key, value in pairs(dic2) do
    print(key,value)
end

-- 定義する際にkey = valueではなく、valueだけにすると配列のようにあつかえる
-- これはなにも書かなければ、keyがintの1から連番になるためっぽい
v =  {'value1','value2',1.21,'gigawatts'}

-- #vでvのlengthを取りだせる
for i = 1,#v do
    print(v[i])
end

for key, value in pairs(v) do
    print(key,value)
end

----------------------------------------------------
-- Metatables and metamethods.
----------------------------------------------------
f1 = {a = 1,b = 2}
f2 = {a = 2,b = 3}


metafraction = {}
function metafraction.__add(f1,f2)
    sum = {}
    sum.b = f1.b * f2.b
    sum.a = f1.b * f2.b + f2.b * f1.b
    return sum
end

setmetatable(f1, metafraction)
setmetatable(f2, metafraction)

s = f1 + f2
print("s",s.a,s.b)

print('*** f1')
print_table(f1)

print('*** f2')
print_table(f2)

-- An __index on a metatable overloads dot lookups:
defaultFavs = {animal = 'gru', food = 'donuts'}
myFavs = {food = 'pizza'}
setmetatable(myFavs, {__index = defaultFavs})
eatenBy = myFavs.food  -- works! thanks, metatable

print_table(defaultFavs)
print_table(myFavs)
print(eatenBy)

function sub_table(a,b)
    sum = {}
    sum.sub_a = a.a - b.a
    sum.sub_b = a.b - b.b
    return sum
end

f3 = {a = 10,b = 20}
f4 = {a = 5,b = 10}
setmetatable(f3,{__sub = sub_table})
f5 = f3 - f4
print_table(f5)

----------------------------------------------------
-- Class-like tables and inheritance.
----------------------------------------------------

-- classはサポートされていない。テーブルで実装する

Dog = {}

function Dog:new()
    newObj = {sound = 'わおーん'}

    -- Dogとインスタンス(newObj)に__indexを指定すると関数とかもろもろコピーされるっぽい
    self.__index = self
    return setmetatable(newObj,self)
end

function Dog:makeSound()
    print('I say ' .. self.sound)
end

mrDog = Dog:new()
mrDog:makeSound()

-- 継承

LoudDog = Dog:new()

function LoudDog:makeSound()
    s = self.sound .. ' '
    print(s .. s .. s)
end

-- LoudDog.newでDog.newしたLoudDogの性質をコピー出来る。
seymour = LoudDog:new()
seymour:makeSound()

-- 場合によっては継承のクラスもnewを設定してあげるとよい
function LoudDog:new()
    newObj = {}
    self.__index = self
    return setmetatable(newObj,self)
end
