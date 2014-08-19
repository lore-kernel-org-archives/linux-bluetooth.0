Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/pts: Update GAP PTS test results
Date: Tue, 19 Aug 2014 09:50:55 +0200
Message-Id: <1408434655-3490-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pts-gap.txt | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/android/pts-gap.txt b/android/pts-gap.txt
index af75dff..6e0936a 100644
--- a/android/pts-gap.txt
+++ b/android/pts-gap.txt
@@ -3,7 +3,7 @@ PTS test results for GAP
 PTS version: 5.2
 Tested: 01-August-2014
 Android version: 4.4.4
-Kernel version: 3.17
+Kernel version: 3.18
 
 Results:
 PASS	test passed
@@ -397,14 +397,30 @@ TC_DM_LEP_BV_05_C	PASS	btmgmt find -b
 TC_DM_LEP_BV_06_C	PASS
 TC_DM_LEP_BV_07_C	PASS
 TC_DM_LEP_BV_08_C	PASS
-TC_DM_LEP_BV_09_C	INC	JIRA #BA-64
-TC_DM_LEP_BV_10_C	INC	haltest:
-				gattc listen 1
-				gattc listen 1 0
+TC_DM_LEP_BV_09_C	PASS	haltest:
+				bluetooth enable
+				bluetooth set_adapter_property
+					BT_PROPERTY_ADAPTER_SCAN_MODE
+					BT_SCAN_MODE_CONNECTABLE_DISCOVERABLE
+				gattc register_client
 				bluetooth start_discovery
-				bluetooth cancel_discovery
-				gattc listen 1
-				gattc listen 1 0
-				bluetooth create_bond
-TC_DM_LEP_BV_11_C	INC
+				gattc connect
+				l2test -n -P 31 <PTS addr>
+				disconnect
+TC_DM_LEP_BV_10_C	PASS	haltest:
+				bluetooth enable
+				bluetooth set_adapter_property
+					BT_PROPERTY_ADAPTER_SCAN_MODE
+					BT_SCAN_MODE_CONNECTABLE_DISCOVERABLE
+				gattc register_client
+				gattc listen
+				bluetooth start_discovery
+				l2test -n -P 31 <PTS addr>
+TC_DM_LEP_BV_11_C	PASS	haltest:
+				bluetooth enable
+				bluetooth set_adapter_property
+					BT_PROPERTY_ADAPTER_SCAN_MODE
+					BT_SCAN_MODE_CONNECTABLE_DISCOVERABLE
+				gattc register_client
+				gattc connect
 -------------------------------------------------------------------------------
-- 
1.9.3

