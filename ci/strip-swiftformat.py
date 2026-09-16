import re
import sys

p = 'HDrezka.xcodeproj/project.pbxproj'
s = open(p, encoding='utf-8').read()

# Remove SwiftFormat shell script phase
pat = re.compile(r'\t\t[A-F0-9]{24} /\* ShellScript \*/ = \{\n.*?shellScript = "SWIFTFROMAT.*?\n\t\t\};\n', re.S)
s, n = pat.subn('', s)

# Remove buildPhase ref
pat2 = re.compile(r'\t\t\t\t[A-F0-9]{24} /\* ShellScript \*/,\n', re.M)
s, n2 = pat2.subn('', s)

# Remove SwiftFormat package + product refs
for iid in ['DE3DCCE42DFB92050062CF81', 'DE3DCCE52DFB92050062CF81', 'DE3DCCE62DFB92050062CF81']:
    s, n3 = re.compile(r'^\s*' + iid + r'.*?\n', re.M).subn('', s)

open(p, 'w', encoding='utf-8', newline='\n').write(s)
print(f'ok swiftformat removed: phases={n} refs={n2} braces={s.count("{")}/{s.count("}")}')