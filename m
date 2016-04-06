Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Mike Ryan <mikeryan@lacklustre.net>
To: linux-bluetooth@vger.kernel.org
Cc: Mike Ryan <mikeryan@lacklustre.net>
Subject: [PATCH] tools: add more entities to company ID parser
Date: Wed,  6 Apr 2016 11:40:44 -0700
Message-Id: <1459968044-29298-1-git-send-email-mikeryan@lacklustre.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds lower and uppercase u with umlaut.
---
 tools/parse_companies.pl | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/parse_companies.pl b/tools/parse_companies.pl
index 1746222..f755390 100755
--- a/tools/parse_companies.pl
+++ b/tools/parse_companies.pl
@@ -10,6 +10,8 @@ my %known_entities = (
     'nbsp' => ' ',
     'eacute' => 'é',
     'auml' => 'ä',
+    'uuml' => 'ü',
+    'Uuml' => 'Ü',
 );
 
 # better to use URI::Encode if you have it
-- 
2.1.4

