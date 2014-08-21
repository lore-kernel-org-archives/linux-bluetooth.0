Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/pts: Update GAP PTS test results
Date: Thu, 21 Aug 2014 12:23:15 +0200
Message-Id: <1408616595-25940-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pts-gap.txt | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/android/pts-gap.txt b/android/pts-gap.txt
index 3076310..05a2ddb 100644
--- a/android/pts-gap.txt
+++ b/android/pts-gap.txt
@@ -172,10 +172,17 @@ TC_BOND_NBON_BV_02_C	PASS	haltest: gattc register_client
 				bluetooth create_bond <address>
 				bluetooth remove_bond <address>
 TC_BOND_NBON_BV_03_C	PASS	haltest: gattc listen
-TC_BOND_BON_BV_01_C	INC	gattc register_client
-				gattc listen 1
-				bluetooth create_bond <pts_bdaddr>
-				JIRA #BA-68
+TC_BOND_BON_BV_01_C	PASS	#12503 however it is possible to pass it without
+				entering securid (Bonding - No MITM):
+				btmgmt power on
+				btmgmt le on
+				btmgmt ssp on
+				btmgmt connectable on
+				btmgmt discov on
+				btmgmt advertising on
+				btmgmt pairable on
+				To bond with PTS execute
+				btmgmt pair -t 0x01 -c 0x03 <PTS addr>
 TC_BOND_BON_BV_02_C	PASS
 TC_BOND_BON_BV_03_C	PASS	gattc register_client
 				gattc listen 1
-- 
1.9.3

