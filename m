Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/3] android/pts: Remove PIXIT info from DID PICS file
Date: Wed, 11 Dec 2013 13:49:37 +0100
Message-Id: <1386766179-8812-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

PIXIT values will be stored in separate file.
---
 android/pics-did.txt | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/android/pics-did.txt b/android/pics-did.txt
index e8c914a..8f92bc1 100644
--- a/android/pics-did.txt
+++ b/android/pics-did.txt
@@ -29,14 +29,3 @@ TSPC_DID_1_5	True		Primary Record (M)
 TSPC_DID_1_6	True		Vendor ID Source (M)
 TSPC_ALL	False		Turns on all the test cases
 -------------------------------------------------------------------------------
-
-
-		Required PIXIT settings
--------------------------------------------------------------------------------
-Parameter Name			Value
--------------------------------------------------------------------------------
-TSPX_ClientExecutableURL	False
-TSPX_ServiceDescription		False
-TSPX_DocumentationURL		False
--------------------------------------------------------------------------------
-Other should be set according to Tester's test environment.
-- 
1.8.3.2

