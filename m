Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Mike Ryan <mikeryan@lacklustre.net>
To: linux-bluetooth@vger.kernel.org
Cc: Mike Ryan <mikeryan@lacklustre.net>
Subject: [PATCH] tools: escape double quotes in company names
Date: Wed, 10 Aug 2016 07:52:57 -0700
Message-Id: <1470840777-71172-1-git-send-email-mikeryan@lacklustre.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Double quotes in company names are properly escaped so that they are
valid C string literals.
---
 tools/parse_companies.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/parse_companies.pl b/tools/parse_companies.pl
index f755390..99d3f31 100755
--- a/tools/parse_companies.pl
+++ b/tools/parse_companies.pl
@@ -51,6 +51,7 @@ while (<>) {
         my $name = uri_decode($1);
         $name =~ s/^\s+//g; # kill leading
         $name =~ s/\s+$//g; # and trailing space
+        $name =~ s/"/\\"/g; # escape double quotes
         my $id = hex($identifier);
         if ($id != 65535) {
             print "\tcase $id:\n";
-- 
2.1.4

