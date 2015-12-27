Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: mikeryan@lacklustre.net
To: linux-bluetooth@vger.kernel.org
Cc: Mike Ryan <mikeryan@lacklustre.net>
Subject: [PATCH] tools: fix update_compids to parse newly formatted page from SIG
Date: Sun, 27 Dec 2015 13:31:00 -0800
Message-Id: <1451251860-12691-1-git-send-email-mikeryan@lacklustre.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mike Ryan <mikeryan@lacklustre.net>

This patch adds tools/parse_companies.pl, a twisted Perl script that
parses the SIG's HTML page in poor taste using regex. Improvements also
include support for non-ASCII entities such as &eacute; as well as full
unicode support for Chinese names.
---
 tools/parse_companies.pl | 59 ++++++++++++++++++++++++++++++++++++++++++++++++
 tools/update_compids.sh  | 35 ++++++++--------------------
 2 files changed, 69 insertions(+), 25 deletions(-)
 create mode 100755 tools/parse_companies.pl

diff --git a/tools/parse_companies.pl b/tools/parse_companies.pl
new file mode 100755
index 0000000..6dc358e
--- /dev/null
+++ b/tools/parse_companies.pl
@@ -0,0 +1,59 @@
+#!/usr/bin/perl
+
+# parse companies from
+# https://www.bluetooth.com/specifications/assigned-numbers/company-identifiers
+
+use strict;
+# use URI::Encode qw(uri_decode);
+
+my %known_entities = (
+    'nbsp' => ' ',
+    'eacute' => 'é',
+    'auml' => 'ä',
+);
+
+# better to use URI::Encode if you have it
+sub uri_decode {
+    my $name = $_[0];
+    foreach my $entity (keys %known_entities) {
+        my $to = $known_entities{$entity};
+        $name =~ s/&$entity;/$to/g;
+    }
+    foreach my $entity (map { lc $_ } $name =~ /&([^;]+);/g) {
+        if ($entity ne 'amp') {
+            print "Unable to convert &$entity;, giving up\n";
+            exit 1;
+        }
+    }
+    $name =~ s/&amp;/&/ig;
+    $name =~ s/&nbsp;/ /ig;
+    return $name;
+}
+
+# never parse HTML with regex!
+# except when you should
+
+my $identifier;
+my $next_is_name = 0;
+
+while (<>) {
+    s/\xe2\x80\x8b//g; # kill zero width space
+
+    # grab identifier (in hex)
+    if (/\<td.*(0x[0-9A-F]{4})/i) {
+        $identifier = $1;
+        $next_is_name = 1;
+
+    # next <td> should be company name
+    } elsif ($next_is_name && m|\<td.*\>(.*)\</td\>|) {
+        my $name = uri_decode($1);
+        $name =~ s/^\s+//g; # kill leading
+        $name =~ s/\s+$//g; # and trailing space
+        my $id = hex($identifier);
+        if ($id != 65535) {
+            print "\tcase $id:\n";
+            print "\t\treturn \"$name\";\n";
+        }
+        $next_is_name = 0;
+    }
+}
diff --git a/tools/update_compids.sh b/tools/update_compids.sh
index 95c961d..7c4cc12 100755
--- a/tools/update_compids.sh
+++ b/tools/update_compids.sh
@@ -13,45 +13,30 @@ set -e -u
 tmpdir=$(mktemp -d)
 trap "rm -rf $tmpdir" EXIT
 
+scriptdir=$(pwd)
+
 mkdir $tmpdir/lib
 cp lib/bluetooth.c $tmpdir/lib/bluetooth.c.orig
 cp lib/bluetooth.c $tmpdir/lib/bluetooth.c
 
 cd $tmpdir
 
-path=en-us/specification/assigned-numbers/company-identifiers
-# Use "iconv -c" to strip unwanted unicode characters
-# Fixups:
-# - strip <input> tags of type "checkbox" because html2text generates UTF-8 for
-#   them in some distros even when using -ascii (e.g. Fedora)
-# - replace "&#160;" (non-breaking space) with whitespace manually, because
-#   some versions incorrectly convert it into "\xC2\xA0"
-curl https://www.bluetooth.org/$path | iconv -c -f utf8 -t ascii | \
-    sed '/<input.*type="checkbox"/d; s/&#160;/ /g' | \
-    html2text -ascii -width 160 -o identifiers.txt >/dev/null
-
-# Some versions of html2text do not replace &amp; (e.g. Fedora)
-sed -i 's/&amp;/\&/g' identifiers.txt
+echo -e 'const char *bt_compidtostr(int compid)\n{\n\tswitch (compid) {' > new.c
 
-sed -n '/^const char \*bt_compidtostr(int compid)/,/^}/p' \
-    lib/bluetooth.c > old.c
+path=specifications/assigned-numbers/company-identifiers
+# Use "iconv -c" to strip unwanted unicode characters
+curl https://www.bluetooth.com/$path | \
+    $scriptdir/tools/parse_companies.pl >> new.c
 
-echo -e 'const char *bt_compidtostr(int compid)\n{\n\tswitch (compid) {' > new.c
-cat identifiers.txt |
-    perl -ne 'm/^(\d+)\s+0x[0-9a-f]+\s+(.*)/i &&
-        print "\tcase $1:\n\t\treturn \"$2\";\n"' >> new.c
 if ! grep -q "return \"" new.c; then
     echo "ERROR: could not parse company IDs from bluetooth.org" >&2
     exit 1
 fi
-if [ -n "$(tr -d '[:print:]\t\n' < new.c)" ]; then
-    echo -n "ERROR: invalid non-ASCII characters found while parsing" >&2
-    echo -n " company IDs. Please identify offending sequence and fix" >&2
-    echo " tools/update_compids.sh accordingly." >&2
-    exit 1
-fi
 echo -e '\tcase 65535:\n\t\treturn "internal use";' >> new.c
 echo -e '\tdefault:\n\t\treturn "not assigned";\n\t}\n}' >> new.c
 
+sed -n '/^const char \*bt_compidtostr(int compid)/,/^}/p' \
+    lib/bluetooth.c > old.c
+
 diff -Naur old.c new.c | patch -sp0 lib/bluetooth.c
 diff -Naur lib/bluetooth.c.orig lib/bluetooth.c
-- 
2.1.4

