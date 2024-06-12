grammar Main;

@members {
    boolean checkName1Equality(String n1, String n2) {
        if (!n1.equals(n2)) {
            String errorMsg = String.format("Error: '%s' and '%s' are not equal", n1, n2);
            throw new RuntimeException(errorMsg);
        }
        return true;
    }

    boolean keyWord(String n1) {
        if (n1.equals("import")|n1.equals("let")|n1.equals("var")|n1.equals("const")|n1.equals("for")|n1.equals("from")
        |n1.equals("as")|n1.equals("in")|n1.equals("of")|n1.equals("while")|n1.equals("do")|n1.equals("if")
        |n1.equals("else if")|n1.equals("else")|n1.equals("return")|n1.equals("switch")|n1.equals("match")|n1.equals("default")
        |n1.equals("case")|n1.equals("break")|n1.equals("class")|n1.equals("constructor")|n1.equals("this")|n1.equals("function")
        |n1.equals("Null")|n1.equals("try")|n1.equals("catch")|n1.equals("finally")|n1.equals("err")) {
            String errorMsg = String.format("Error: '%s' are not key word!", n1);
            throw new RuntimeException(errorMsg);
        }
        return true;
    }

}

start:('$import'((StringStatement)|(((',')?Name1)*('*'?'as')?(('defaultExport')?((',')?Name1)*)'from' StringStatement ))';')+ (classDef)+;



classDef:'class'namevar'{'constructor (variable|function)* ('void''main''('')''{'statement'}')? '}';

variable:variable3|variable1|variable4;
variable1:('$'('var'|'let'|'const'))?namevar(','namevar)*(('+'|'/'|'*'|'-')?'='equation(','equation)*)?';'|(namevar'.'namevar('('')'))';';
variable3:('$'('var'|'let'|'const'))?namevar(','namevar)*(('+'|'/'|'*'|'-')?'='(namevar'.'namevar('('')')))?';';
variable4:namevar('('namevar')')?'='StringStatement;

equation:	equation('**')equation|equation('~')equation|equation('+'|'-')|equation ('*'|'/'|'//'|'%') equation|equation ('+'|'-') equation
|equation ('<<'|'>>') equation|equation ('&'|'^'|'|') equation |(namevar|Number|ScientificNum|FloatNum)|'(' equation ')';

function:function1|function2;
function1:'function' namevar '(' namelistFunction')''{'statementfunct'}';
function2:'$'('var'|'let'|'const') namevar'=''(' namelistFunction')''=>'(namevar|equation|ifSingle)';';
namelistFunction: ('var'|'let'|'const')namevar(','('var'|'let'|'const') namevar)*;

constructor:'constructor' '(' namelist')' '{' code+ '}';
code: 'this' '.' namevar '=' namevar ';';
namelist:namevar(',' namevar)*;

namevar:n3=Name1{keyWord($n3.text);};

loopForWhile:(forNormStatement|forIn|forOf|whileLoop|doWhile);

forNormStatement:'for''('('$'('var'|'let'|'const'))?(namevar'='(equation|namevar))(','namevar'='(equation|namevar))*';'mainCondition';'incdec(','incdec)*')''{'statement'}';
mainCondition:mainCondition( '!'| '||' |'&&')mainCondition|(condition)|'(' mainCondition ')';
condition:condition('=='|'==='|'!='|'<>')condition|condition('<'| '>'| '<=' |'>=')condition|(namevar|Number|ScientificNum|FloatNum|equation)|'(' condition ')';
incdec:((namevar('+'|'/'|'*'|'-')?'='equation)|(namevar('++'|'--'))|(('++'|'--')namevar))';'?;
forIn:'for'namevar'in'namevar'{'statement'}';
forOf:'for'namevar'of'namevar'{'statement'}';

whileLoop:'while''('('$'('var'|'let'|'const'))?('!')? mainCondition')''{'statement'}';
doWhile:'do''{''}''while''('('$'('var'|'let'|'const'))? mainCondition')'';';

ifStatement:(ifSingle|ifNormStatement);
ifNormStatement:'if''('mainCondition')''{'statement'}'('else if''('mainCondition')''{'statement'}')*('else''{'statement'}')?;
ifSingle:(('$'('var'|'let'|'const')namevar'=')|namevar'=')?mainCondition'?'(namevar|Number|StringStatement)':'(namevar|Number|StringStatement)';';

tryStatement:'try''{'statement'}'((('catch''(''Exception'Name1')''{'statement'}'))(('finally''{'(statement)'}')|('finally''{''}'))?);

variable2:namevar|(namevar'.'namevar);
switchStatement:'switch'(StringStatement|variable2|equation)'{'('case'(Number|StringStatement)':' (statement)('break'?)(';')?)+('default'':'statement)?'}';

print:'console.log' '(' (StringStatement|equation|variable) ')' ';';

callObj:namevar'.'namevar'('variable')'';';

callFunction:namevar'('(namelist)*')'';';

reeturne:'return' (namevar|equation|ifSingle|'Null')';';
reeturnne:'return' (namevar|equation|ifSingle|'Null')';';


statement:(variable|switchStatement|tryStatement|ifStatement|loopForWhile|incdec|equation|print|reeturnne)*;
statementfunct:(variable|switchStatement|tryStatement|ifStatement|loopForWhile|incdec|equation|print|reeturne)*;


//********* lexer rule

Number: ('-')?DIGIT+ ;
ScientificNum:('-')?(DIGIT)?'.'Number'e''-'? Number;
FloatNum:('-')?(DIGIT)*'.'(DIGIT)+;
Name1: LETTER (LETTER | DIGIT | '-'|'$')+;
StringStatement:'"'(LETTER|DIGIT|'.'|'?'|'!'|' ')+'"';



Variable:(LETTER|DIGIT) (LETTER | DIGIT | '_'|'$')+;

/*Import:'import';
Var:('let'|'var'|'const');
For:'for';
From:'from';
As:'as';
IN:'in';
Of:'of';
Do:'do';
While:'while';
If:'if';
Else:'else';
Constructor:'constructor';
Return:'return';
Switch:'switch';
Match:'match';
Case:'case';
Default:'default';
Break:'break';
Class:'class';
This:'this';
Function:'function';
Null:'Null';
Try:'try';
Catch:'catch';
Finally:'finally';*/





fragment LETTER: [a-zA-Z];
fragment DIGIT: [0-9]; 
WS: [ \t\r\n]+ -> skip ;
Comment: '//' ~[\r\n]* -> skip;
MultiComment: '/*' .*? '*/' -> skip;



