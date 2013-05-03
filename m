Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH v2 BlueZ] tools: Add script for updating bt_compidtostr() implementation
Date: Fri,  3 May 2013 16:19:31 -0400
Message-Id: <1367612371-20930-1-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1365706752-4442-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1365706752-4442-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This script uses curl and html2text to fetch company IDs from
bluetooth.org's "Assigned Numbers" section.
---

v2:

* Use iconv to strip unrelated UTF-8 text from the HTML prior to passing it to
  html2text.
* Add simple sanity check for when HTML parsing fails.


 tools/update_compids.sh |   42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100755 tools/update_compids.sh

diff --git a/tools/update_compids.sh b/tools/update_compids.sh
new file mode 100755
index 0000000..296e32f
--- /dev/null
+++ b/tools/update_compids.sh
@@ -0,0 +1,42 @@
+#!/bin/bash
+# Download the list of company IDs from bluetooth.org and generate a diff which
+# can be applied to source tree to update bt_compidtostr(). Usage:
+#
+# 1) ./tools/update_compids.sh | git apply -p0
+# 2) Inspect changes to make sure they are sane
+# 3) git commit -m "lib: Update list of company identifiers" lib/bluetooth.c
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
+# Use "iconv -c" to strip unwanted unicode characters
+curl https://www.bluetooth.org/$path | iconv -c -f UTF-8 -t ISO-8859-1 | \
+    html2text -ascii -o identifiers.txt
+
+sed -n '/^const char \*bt_compidtostr(int compid)/,/^}/p' \
+    lib/bluetooth.c > old.c
+
+echo -e 'const char *bt_compidtostr(int compid)\n{\n\tswitch (compid) {' > new.c
+cat identifiers.txt |
+    perl -ne 'm/^(\d+)\s+0x[0-9a-f]+\s+(.*)/i &&
+        print "\tcase $1:\n\t\treturn \"$2\";\n"' >> new.c
+if ! grep -q "return \"" new.c; then
+    echo "ERROR: could not parse company IDs from bluetooth.org" >&2
+    exit 1
+fi
+echo -e '\tcase 65535:\n\t\treturn "internal use";' >> new.c
+echo -e '\tdefault:\n\t\treturn "not assigned";\n\t}\n}' >> new.c
+
+diff -Naur old.c new.c | patch -sp0 lib/bluetooth.c
+diff -Naur lib/bluetooth.c.orig lib/bluetooth.c
-- 
1.7.9.5

