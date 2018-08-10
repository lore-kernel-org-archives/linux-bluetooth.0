Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Inga Stotland <inga.stotland@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] doc: Fix URL for linux kernel coding style
Date: Thu,  9 Aug 2018 19:03:09 -0700
Message-Id: <20180810020309.22409-1-inga.stotland@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/coding-style.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/doc/coding-style.txt b/doc/coding-style.txt
index f0bf880e3..b59b0df10 100644
--- a/doc/coding-style.txt
+++ b/doc/coding-style.txt
@@ -7,10 +7,10 @@ some level of consistency among developers so that code can be easily
 understood and maintained.
 
 First of all, BlueZ coding style must follow every rule for Linux kernel
-(http://www.kernel.org/doc/Documentation/CodingStyle). There also exists a tool
-named checkpatch.pl to help you check the compliance with it. Just type
-"checkpatch.pl --no-tree patch_name" to check your patch. In theory, you need
-to clean up all the warnings and errors except this one: "ERROR: Missing
+(http://www.kernel.org/doc/Documentation/process/coding-style.rst). There also
+exists a tool named checkpatch.pl to help you check the compliance with it. Just
+type "checkpatch.pl --no-tree patch_name" to check your patch. In theory, you
+need to clean up all the warnings and errors except this one: "ERROR: Missing
 Signed-off-by: line(s)". BlueZ does not used Signed-Off lines, so including
 them is actually an error.  In certain circumstances one can ignore the 80
 character per line limit.  This is generally only allowed if the alternative
-- 
2.14.4
