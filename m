Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ] tools: Fix update_compids.sh to avoid non-ASCII output
Date: Tue,  1 Oct 2013 11:46:06 -0400
Message-Id: <1380642366-5726-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some distros have html2text patches that may generate non-ASCII output
even when -ascii is used. This patch adds another case (seen in Fedora)
where HTML entity &#160; (non-breaking space) is converted into a
multibyte whitespace.

Also add a sanity check to make sure non-ASCII text is not introduced in
lib/bluetooth.c.
---
 tools/update_compids.sh |   17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/tools/update_compids.sh b/tools/update_compids.sh
index 332fb16..38d1fff 100755
--- a/tools/update_compids.sh
+++ b/tools/update_compids.sh
@@ -21,13 +21,16 @@ cd $tmpdir
 
 path=en-us/specification/assigned-numbers/company-identifiers
 # Use "iconv -c" to strip unwanted unicode characters
-# Also strip <input> tags of type checkbox because html2text generates UTF-8
-# for them in some distros even when using -ascii (e.g. Fedora 18)
+# Fixups:
+# - strip <input> tags of type "checkbox" because html2text generates UTF-8 for
+#   them in some distros even when using -ascii (e.g. Fedora)
+# - replace "&#160;" (non-breaking space) with whitespace manually, because
+#   some versions incorrectly convert it into "\xC2\xA0"
 curl https://www.bluetooth.org/$path | iconv -c -f utf8 -t ascii | \
-    sed '/<input.*type="checkbox"/d' | \
+    sed '/<input.*type="checkbox"/d; s/&#160;/ /g' | \
     html2text -ascii -o identifiers.txt >/dev/null
 
-# Some versions of html2text do not replace &amp; (e.g. Fedora 18)
+# Some versions of html2text do not replace &amp; (e.g. Fedora)
 sed -i 's/&amp;/\&/g' identifiers.txt
 
 sed -n '/^const char \*bt_compidtostr(int compid)/,/^}/p' \
@@ -41,6 +44,12 @@ if ! grep -q "return \"" new.c; then
     echo "ERROR: could not parse company IDs from bluetooth.org" >&2
     exit 1
 fi
+if [ -n "$(tr -d '[:print:]\t\n' < new.c)" ]; then
+    echo -n "ERROR: invalid non-ASCII characters found while parsing" >&2
+    echo -n " company IDs. Please identify offending sequence and fix" >&2
+    echo " tools/update_compids.sh accordingly." >&2
+    exit 1
+fi
 echo -e '\tcase 65535:\n\t\treturn "internal use";' >> new.c
 echo -e '\tdefault:\n\t\treturn "not assigned";\n\t}\n}' >> new.c
 
-- 
1.7.9.5

