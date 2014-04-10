Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH 1/4] android/pts: Bump PTS version for PAN
Date: Thu, 10 Apr 2014 09:59:24 +0200
Message-Id: <1397116767-18192-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pics-pan.txt  | 4 ++--
 android/pixit-pan.txt | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/android/pics-pan.txt b/android/pics-pan.txt
index 0caa629..f78fc10 100644
--- a/android/pics-pan.txt
+++ b/android/pics-pan.txt
@@ -1,6 +1,6 @@
 PAN PICS for the PTS tool.
 
-PTS version: 5.0
+PTS version: 5.1
 
 * - different than PTS defaults
 # - not yet implemented/supported
@@ -120,7 +120,7 @@ C.4: Mandatory to support if (TSPC_PAN_3_10) is supported.
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
 TSPC_PAN_4_1	True		PANU: Support BNEP (M)
-TSPC_PAN_4_2	True		PANU: Support IPv4 (C.1)
+TSPC_PAN_4_2	True (*)	PANU: Support IPv4 (C.1)
 TSPC_PAN_4_3	False		PANU: Support ping client for IPv4 (O)
 TSPC_PAN_4_4	False		PANU: Support DHCP client for  IPv4 (O)
 TSPC_PAN_4_5	False		PANU: Support DNS/LLMNR Resolver for IPv4 (O)
diff --git a/android/pixit-pan.txt b/android/pixit-pan.txt
index 21434fb..9053715 100644
--- a/android/pixit-pan.txt
+++ b/android/pixit-pan.txt
@@ -1,6 +1,6 @@
 PAN PIXIT for the PTS tool.
 
-PTS version: 5.0
+PTS version: 5.1
 
 * - different than PTS defaults
 & - should be set to IUT or PTS Bluetooth address respectively
-- 
1.8.5.3

