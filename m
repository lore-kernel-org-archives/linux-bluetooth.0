Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH] android/pts: Regression tests on SM against PTS 5.2
Date: Fri, 25 Jul 2014 13:01:16 +0200
Message-Id: <1406286076-29536-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pics-sm.txt  |  2 +-
 android/pixit-sm.txt |  4 +++-
 android/pts-sm.txt   | 24 ++++++++++++++----------
 3 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/android/pics-sm.txt b/android/pics-sm.txt
index 239f568..dcdfff8 100644
--- a/android/pics-sm.txt
+++ b/android/pics-sm.txt
@@ -1,6 +1,6 @@
 SM PICS for the PTS tool.
 
-PTS version: 5.1
+PTS version: 5.2
 
 * - different than PTS defaults
 
diff --git a/android/pixit-sm.txt b/android/pixit-sm.txt
index 607a3ce..2526e29 100644
--- a/android/pixit-sm.txt
+++ b/android/pixit-sm.txt
@@ -1,6 +1,6 @@
 SM PIXIT for the PTS tool.
 
-PTS version: 5.1
+PTS version: 5.2
 
 * - different than PTS defaults
 & - should be set to IUT Bluetooth address
@@ -67,4 +67,6 @@ TSPX_use_implicit_send					TRUE
 TSPX_use_dynamic_pin					FALSE
 TSPX_iut_SDU_size_in_bytes				144
 TSPX_secure_simple_pairing_pass_key_confirmation	FALSE
+TSPX_Min_Encryption_Key_Length				07
+TSPX_Bonding_Flags					00
 -------------------------------------------------------------------------------
diff --git a/android/pts-sm.txt b/android/pts-sm.txt
index ff713cc..af892ef 100644
--- a/android/pts-sm.txt
+++ b/android/pts-sm.txt
@@ -1,7 +1,7 @@
 PTS test results for SM
 
-PTS version: 5.1
-Tested: 14-May-2014
+PTS version: 5.2
+Tested: 25-July-2014
 Android version: 4.4.2
 kernel version: 3.17
 
@@ -16,8 +16,8 @@ NONE	test result is none
 Test Name		Result	Notes
 -------------------------------------------------------------------------------
 TC_PROT_BV_01_C		PASS
-TC_PROT_BV_02_C		PASS
-				btmgmt advertising on
+TC_PROT_BV_02_C		PASS	btmgmt advertising on
+				btmgmt pair -c 0x03 -t 0x01 <addr>
 TC_JW_BV_01_C		PASS	btmgmt pairable off
 				btmgmt pair -c 0x03 -t 0x01 <addr>
 TC_JW_BV_02_C		PASS
@@ -46,7 +46,8 @@ TC_PKE_BV_05_C		PASS	btmgmt io-cap 0x04
 				l2test -r -J4 -AES -V le_public
 TC_PKE_BI_01_C		PASS	btmgmt pair -c 0x04 -t 0x01 <addr>
 				Note: Enter invalid passkey in PTS
-TC_PKE_BI_02_C		PASS
+TC_PKE_BI_02_C		PASS	btmgmt pair -c 0x04 -t 0x01 <addr>
+				Note: provide passkey
 TC_PKE_BI_03_C		PASS	btmgmt io-cap 0x04
 				btmgmt advertising on
 				btmgmt monitor
@@ -65,7 +66,7 @@ TC_OOB_BI_01_C		NA
 TC_OOB_BI_02_C		NA
 TC_EKS_BV_01_C		PASS
 TC_EKS_BV_02_C		PASS
-TC_EKS_BI_01_C		PASS	btmgmt io-cap 0x03
+TC_EKS_BI_01_C		INC	btmgmt io-cap 0x03
 TC_EKS_BI_02_C		PASS
 TC_SIGN_BV_01_C		INC	PTS issue #12305
 TC_SIGN_BV_03_C		PASS	haltest
@@ -84,17 +85,20 @@ TC_KDU_BV_02_C		PASS	PTS issue #12302
 TC_KDU_BV_03_C		PASS	btmgmt pairable on
 				btmgmt advertising on
 
-TC_KDU_BV_04_C		INC	PTS issue #12301
+TC_KDU_BV_04_C		PASS	btmgmt pair -c 0x03 -t 0x01 <addr>
+
+
 TC_KDU_BV_05_C		PASS	PTS issue #12302
 				Note: Can pass it with following instructions:
 				btmgmt privacy on
 				Check our random address (valid for 15 min)
 				Set PIXIT TSPX_bd_addr_iut to random address
 				Set PIXIT TSPX_peer_type to 01
-TC_KDU_BV_06_C		FAIL	PTS issue #12301
-				PTS issue #12302
+TC_KDU_BV_06_C		PASS	btmgmt pair -c 0x03 -t 0x01 <addr>
 TC_KDU_BV_07_C		PASS	btmgmt pairable on
+
+
 TC_SIP_BV_01_C		PASS	btmgmt pair -c 0x03 -t 0x01 <addr>
 TC_SIP_BV_02_C		PASS	l2test -n -J4 -V le_public <addr>
-TC_SIE_BV_01_C		INC	PTS issue #12306
+TC_SIE_BV_01_C		PASS	btmgmt pair -c 0x03 -t 0x01 <addr>
 -------------------------------------------------------------------------------
-- 
1.8.5.3

