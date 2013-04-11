Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 1/2] tools: Add script for updating bt_compidtostr() implementation
Date: Thu, 11 Apr 2013 14:59:11 -0400
Message-Id: <1365706752-4442-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This script uses curl and html2text to fetch company IDs from
bluetooth.org's "Assigned Numbers" section.
---
 tools/update_compids.sh |   37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100755 tools/update_compids.sh

diff --git a/tools/update_compids.sh b/tools/update_compids.sh
new file mode 100755
index 0000000..8a0aa3c
--- /dev/null
+++ b/tools/update_compids.sh
@@ -0,0 +1,37 @@
+#!/bin/bash
+# Download the list of company IDs from bluetooth.org and generate a diff which
+# can be applied to source tree to update bt_compidtostr(). Usage:
+#
+# $ ./tools/update_compids.sh | git apply -p0
+# (inspect changes to make sure they are sane)
+# $ git commit -m "lib: Update list of company identifiers" lib/bluetooth.c
+#
+# Requires html2text: http://www.mbayer.de/html2text/
+#
+set -e -u
+
+tmpdir=$(mktemp -d)
+trap "rm -rf $tmpdir" EXIT
+
+mkdir $tmpdir/lib
+cp lib/bluetooth.c $tmpdir/lib/bluetooth.c.orig
+cp lib/bluetooth.c $tmpdir/lib/bluetooth.c
+
+cd $tmpdir
+
+path=en-us/specification/assigned-numbers-overview/company-identifiers
+curl https://www.bluetooth.org/$path | html2text -ascii -o identifiers.txt
+
+sed -n '/^const char \*bt_compidtostr(int compid)/,/^}/p' \
+    lib/bluetooth.c > old.c
+
+echo -e 'const char *bt_compidtostr(int compid)\n{\n\tswitch (compid) {' > new.c
+cat identifiers.txt |
+    # remove Unicode character 'ZERO WIDTH SPACE' (U+200B)
+    perl -ne 's/\xe2\x80\x8b//g; m/^(\d+)\s+0x[0-9a-f]+\s+(.*)/i &&
+        print "\tcase $1:\n\t\treturn \"$2\";\n"' >> new.c
+echo -e '\tcase 65535:\n\t\treturn "internal use";' >> new.c
+echo -e '\tdefault:\n\t\treturn "not assigned";\n\t}\n}' >> new.c
+
+diff -Naur old.c new.c | patch -sp0 lib/bluetooth.c
+diff -Naur lib/bluetooth.c.orig lib/bluetooth.c
-- 
1.7.9.5

