Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/pts: Update SM pixits, pics and test results for PTS 6.0
Date: Wed, 11 Feb 2015 13:51:38 +0100
Message-Id: <1423659098-3053-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch updates test pixits, pics, test results and their
instructions for SM profile against android 5.0
---
 android/pics-sm.txt  |  2 +-
 android/pixit-sm.txt |  2 +-
 android/pts-sm.txt   | 59 +++++++++++++++++++++++++++++++++-------------------
 3 files changed, 40 insertions(+), 23 deletions(-)

diff --git a/android/pics-sm.txt b/android/pics-sm.txt
index c1bfe0e..c5caec6 100644
--- a/android/pics-sm.txt
+++ b/android/pics-sm.txt
@@ -1,6 +1,6 @@
 SM PICS for the PTS tool.
 
-PTS version: 5.3
+PTS version: 6.0
 
 * - different than PTS defaults
 
diff --git a/android/pixit-sm.txt b/android/pixit-sm.txt
index 2d1442b..98e2ab5 100644
--- a/android/pixit-sm.txt
+++ b/android/pixit-sm.txt
@@ -1,6 +1,6 @@
 SM PIXIT for the PTS tool.
 
-PTS version: 5.3
+PTS version: 6.0
 
 * - different than PTS defaults
 & - should be set to IUT Bluetooth address
diff --git a/android/pts-sm.txt b/android/pts-sm.txt
index 1ea0570..91737cc 100644
--- a/android/pts-sm.txt
+++ b/android/pts-sm.txt
@@ -1,9 +1,9 @@
 PTS test results for SM
 
-PTS version: 5.3
-Tested: 28-November-2014
+PTS version: 6.0
+Tested: 11-February-2015
 Android version: 5.0
-kernel version: 3.18
+kernel version: 3.20
 
 Results:
 PASS	test passed
@@ -20,10 +20,10 @@ TC_PROT_BV_02_C		PASS	btmgmt advertising on
 				btmgmt pair -c 0x03 -t 0x01 <addr>
 TC_JW_BV_01_C		PASS	btmgmt pairable off
 				btmgmt pair -c 0x03 -t 0x01 <addr>
-TC_JW_BV_02_C		PASS
+TC_JW_BV_02_C		PASS	btmgmt advertising on
 TC_JW_BV_05_C		PASS	btmgmt pair -c 0x03 -t 0x01 <addr>
-TC_JW_BI_01_C		PASS
-TC_JW_BI_02_C		PASS
+TC_JW_BI_01_C		PASS	btmgmt pair -c 0x03 -t 0x01 <addr>
+TC_JW_BI_02_C		PASS	btmgmt pairable on
 TC_JW_BI_03_C		PASS	bluetoothd is NOT running
 				btmgmt power on
 				btmgmt le on
@@ -56,25 +56,39 @@ TC_OOB_BV_01_C		N/A
 TC_OOB_BV_02_C		N/A
 TC_OOB_BV_03_C		N/A
 TC_OOB_BV_04_C		N/A
-TC_OOB_BV_05_C		PASS
-TC_OOB_BV_06_C		PASS
-TC_OOB_BV_07_C		PASS
-TC_OOB_BV_08_C		PASS
+TC_OOB_BV_05_C		PASS	btmgmt pair -c 0x04 -t 0x01 <addr>
+				Note: Enter valid passkey in PTS
+TC_OOB_BV_06_C		PASS	btmgmt advertising on
+				btmgmt monitor
+				Note: Enter valid passkey in PTS
+TC_OOB_BV_07_C		PASS	btmgmt pair -c 0x04 -t 0x01 <addr>
+TC_OOB_BV_08_C		PASS	btmgmt advertising on
+				btmgmt monitor
+				Note: Accept pairing in btmgmt monitor
 TC_OOB_BV_09_C		N/A
 TC_OOB_BV_10_C		N/A
 TC_OOB_BI_01_C		N/A
 TC_OOB_BI_02_C		N/A
-TC_EKS_BV_01_C		PASS
-TC_EKS_BV_02_C		PASS
+TC_EKS_BV_01_C		PASS	btmgmt pair -c 0x04 -t 0x01 <addr>
+				Note: Enter valid passkey in PTS
+TC_EKS_BV_02_C		PASS	btmgmt advertising on
+				btmgmt monitor
+				Note: Accept pairing in btmgmt monitor
 TC_EKS_BI_01_C		PASS	btmgmt io-cap 0x03
-TC_EKS_BI_02_C		PASS
+				btmgmt pair -c 0x03 -t 0x01 <addr>
+TC_EKS_BI_02_C		PASS	btmgmt advertising on
 TC_SIGN_BV_01_C		INC	PTS issue #12305
-TC_SIGN_BV_03_C		PASS	haltest
-				gattc listen
-
-TC_SIGN_BI_01_C		PASS	haltest
-				gattc listen
+TC_SIGN_BV_03_C		PASS	haltest:
+				gattc register_client 1234
+				gattc listen 1 1
+				Note: IUT must be connectable and discoverable
+TC_SIGN_BI_01_C		PASS	haltest:
+				gattc register client 1234
+				gattc listen 1 1
+				Note: IUT must be connectable and discoverable
 TC_KDU_BV_01_C		PASS	btmgmt pairable on
+				btmgmt advertising on
+				btmgmt connectable on
 TC_KDU_BV_02_C		PASS	PTS issue #12302
 				Note: Can pass it with following instructions:
 				btmgmt privacy on
@@ -93,7 +107,10 @@ TC_KDU_BV_05_C		PASS	PTS issue #12302
 				Set PIXIT TSPX_peer_type to 01
 TC_KDU_BV_06_C		PASS	btmgmt pair -c 0x03 -t 0x01 <addr>
 TC_KDU_BV_07_C		PASS	btmgmt pairable on
-TC_SIP_BV_01_C		PASS	btmgmt pair -c 0x03 -t 0x01 <addr>
-TC_SIP_BV_02_C		PASS	l2test -n -J4 -V le_public <addr>
-TC_SIE_BV_01_C		PASS	btmgmt pair -c 0x03 -t 0x01 <addr>
+TC_SIP_BV_01_C		PASS	btmgmt advertising on
+				btmgmt pair -c 0x03 -t 0x01 <addr>
+TC_SIP_BV_02_C		PASS	btmgmt advertising off
+				l2test -n -J4 -V le_public <addr>
+TC_SIE_BV_01_C		PASS	btmgmt advertising on
+				btmgmt pair -c 0x03 -t 0x01 <addr>
 -------------------------------------------------------------------------------
-- 
1.9.3

