Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH v3 BlueZ] tools: Add script for updating bt_compidtostr() implementation
Date: Fri, 17 May 2013 10:21:59 -0400
Message-Id: <1368800519-20187-1-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1367612371-20930-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1367612371-20930-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This script uses curl and html2text to fetch company IDs from
bluetooth.org's "Assigned Numbers" section.
---

v3:

* Make the script work better with modified html2text versions.
(it is unfortunate that in this case the upstream unmodified version works
better than the distro one).

I should report a bug to Fedora as time permits...


 tools/update_compids.sh |   48 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100755 tools/update_compids.sh

diff --git a/tools/update_compids.sh b/tools/update_compids.sh
new file mode 100755
index 0000000..38d7032
--- /dev/null
+++ b/tools/update_compids.sh
@@ -0,0 +1,48 @@
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
+# Also strip <input> tags of type checkbox because html2text generates UTF-8
+# for them in some distros even when using -ascii (e.g. Fedora 18)
+curl https://www.bluetooth.org/$path | iconv -c -f utf8 -t ascii | \
+    sed '/<input.*type="checkbox"/d' | \
+    html2text -ascii -o identifiers.txt >/dev/null
+
+# Some versions of html2text do not replace &amp; (e.g. Fedora 18)
+sed -i 's/&amp;/\&/g' identifiers.txt
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

