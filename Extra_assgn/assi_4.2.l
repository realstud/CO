%{
#include <stdio.h>
#include <string.h>

int digits = 0, letters = 0, specials = 0;
%}

%%
[0-9]              { digits++; }
[a-zA-Z]           { letters++; }
[^a-zA-Z0-9 \n\t]  { specials++; }
.|\n               ;   // Ignore spaces, tabs, etc.
%%

int yywrap() { return 1; }

int main() {
    char input[1024];

    printf("Enter input: ");
    if (fgets(input, sizeof(input), stdin)) {
        YY_BUFFER_STATE buffer = yy_scan_string(input);
        yylex();
        yy_delete_buffer(buffer);

        printf("Digits: %d, Letters: %d, Special Characters: %d\n", digits, letters, specials);
    }

    return 0;
}
