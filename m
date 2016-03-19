Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Fri, 18 Mar 2016 20:48:48 -0700
From: Mike Ryan <mikeryan@lacklustre.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] tools: make parse_companies.pl more forgiving of weird HTML
Message-ID: <20160319034848.GO22136@lacklustre.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Several company identifier lines do not end in a </td> but rather <br/>
followed by newline followed by </td>. This dirty hack is more forgiving
of HTML weirdnesses in the SIGs company identifiers page.
---
 tools/parse_companies.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/parse_companies.pl b/tools/parse_companies.pl
index 6dc358e..1746222 100755
--- a/tools/parse_companies.pl
+++ b/tools/parse_companies.pl
@@ -45,7 +45,7 @@ while (<>) {
         $next_is_name = 1;
 
     # next <td> should be company name
-    } elsif ($next_is_name && m|\<td.*\>(.*)\</td\>|) {
+    } elsif ($next_is_name && m|\<td.*\>(.*)\<|) {
         my $name = uri_decode($1);
         $name =~ s/^\s+//g; # kill leading
         $name =~ s/\s+$//g; # and trailing space
-- 
2.1.4
