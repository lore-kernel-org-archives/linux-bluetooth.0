Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Mike Ryan <mikeryan@lacklustre.net>
To: linux-bluetooth@vger.kernel.org
Cc: Mike Ryan <mikeryan@lacklustre.net>
Subject: [PATCH] tools: add more entities and better error handling to parse_companies
Date: Thu, 11 Aug 2016 13:19:45 -0700
Message-Id: <1470946785-92700-1-git-send-email-mikeryan@lacklustre.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add the remaining lowercase acute accented vowel HTML entities to
parse_companies.pl. On unknown entity, print an error to STDERR so the
maintainer can more clearly understand the failure.
---
 tools/parse_companies.pl | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/parse_companies.pl b/tools/parse_companies.pl
index 99d3f31..d5b2815 100755
--- a/tools/parse_companies.pl
+++ b/tools/parse_companies.pl
@@ -8,7 +8,11 @@ use strict;
 
 my %known_entities = (
     'nbsp' => ' ',
+    'aacute' => 'á',
     'eacute' => 'é',
+    'iacute' => 'í',
+    'oacute' => 'ó',
+    'uacute' => 'ú',
     'auml' => 'ä',
     'uuml' => 'ü',
     'Uuml' => 'Ü',
@@ -23,8 +27,7 @@ sub uri_decode {
     }
     foreach my $entity (map { lc $_ } $name =~ /&([^;]+);/g) {
         if ($entity ne 'amp') {
-            print "Unable to convert &$entity;, giving up\n";
-            exit 1;
+            die "\nparse_companies.pl: Unable to convert &$entity; giving up\n";
         }
     }
     $name =~ s/&amp;/&/ig;
-- 
2.1.4

