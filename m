Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 2/2] android/pts: Update SM PTS results
Date: Tue, 17 Jun 2014 00:39:57 +0200
Message-Id: <1402958397-1415-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1402958397-1415-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1402958397-1415-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
One testcase actually uses l2test which need fix:
[PATCH] tools/l2test: Fix setopts and getopts functions

 android/pts-sm.txt | 107 ++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 68 insertions(+), 39 deletions(-)

diff --git a/android/pts-sm.txt b/android/pts-sm.txt
index 7afc11c..d7e90c9 100644
--- a/android/pts-sm.txt
+++ b/android/pts-sm.txt
@@ -3,6 +3,7 @@ PTS test results for SM
 PTS version: 5.1
 Tested: 14-May-2014
 Android version: 4.4.2
+kernel version: 3.17
 
 Results:
 PASS	test passed
@@ -15,11 +16,12 @@ NONE	test result is none
 Test Name		Result	Notes
 -------------------------------------------------------------------------------
 TC_PROT_BV_01_C		PASS
-TC_PROT_BV_02_C		FAIL	JIRA: BZ-24
+TC_PROT_BV_02_C		PASS
 				btmgmt advertising on
-TC_JW_BV_01_C		FAIL	JIRA: BZ-25
+TC_JW_BV_01_C		PASS	btmgmt pairable off
+				btmgmt pair -c 0x03 -t 0x01 <addr>
 TC_JW_BV_02_C		PASS
-TC_JW_BV_05_C		INC
+TC_JW_BV_05_C		FAIL	Out of tree kernel patch required
 TC_JW_BI_01_C		PASS
 TC_JW_BI_02_C		PASS
 TC_JW_BI_03_C		PASS	bluetoothd is NOT running
@@ -29,41 +31,68 @@ TC_JW_BI_03_C		PASS	bluetoothd is NOT running
 				btmgmt pairable on
 				btmgmt discov on
 				btmgmt advertising on
-TC_JW_BI_04_C		FAIL
-TC_PKE_BV_01_C		FAIL
-TC_PKE_BV_02_C		INC
-TC_PKE_BV_04_C		FAIL
-TC_PKE_BV_05_C		INC
-TC_PKE_BI_01_C		INC
+TC_JW_BI_04_C		PASS	btmgmt pairable off
+				btmgmg pair -c 0x03 -t 0x01 <addr>
+TC_PKE_BV_01_C		PASS	btmgmt pairable off
+				btmgmt pair -c 0x04 -t 0x01 <addr>
+				Note: provide passkey to PTS
+TC_PKE_BV_02_C		PASS	btmgmt pairable off
+				btmgmt io-cap 0x04
+				btmgmt advertising on
+				btmgmt monitor
+				Note: provide passkey
+TC_PKE_BV_04_C		PASS	btmgmt pair -c 0x04 -t 0x01 <addr>
+TC_PKE_BV_05_C		FAIL	MITM-only required
+TC_PKE_BI_01_C		PASS	btmgmt pair -c 0x04 -t 0x01 <addr>
+				Note: Enter invalid passkey in PTS
 TC_PKE_BI_02_C		PASS
-TC_PKE_BI_03_C		INC
-TC_OOB_BV_01_C		FAIL
-TC_OOB_BV_02_C		INC
-TC_OOB_BV_03_C		FAIL
-TC_OOB_BV_04_C		INC
-TC_OOB_BV_05_C		INC
-TC_OOB_BV_06_C		INC
-TC_OOB_BV_07_C		INC
-TC_OOB_BV_08_C		INC
-TC_OOB_BV_09_C		INC
-TC_OOB_BV_10_C		INC
-TC_OOB_BI_01_C		INC
-TC_OOB_BI_02_C		INC
-TC_EKS_BV_01_C		INC
-TC_EKS_BV_02_C		INC
-TC_EKS_BI_01_C		INC
-TC_EKS_BI_02_C		INC
-TC_SIGN_BV_01_C		INC
-TC_SIGN_BV_03_C		INC
-TC_SIGN_BI_01_C		INC
-TC_KDU_BV_01_C		INC
-TC_KDU_BV_02_C		INC
-TC_KDU_BV_03_C		INC
-TC_KDU_BV_04_C		INC
-TC_KDU_BV_05_C		INC
-TC_KDU_BV_06_C		INC
-TC_KDU_BV_07_C		INC
-TC_SIP_BV_01_C		INC
-TC_SIP_BV_02_C		FAIL
-TC_SIE_BV_01_C		INC
+TC_PKE_BI_03_C		PASS	btmgmt io-cap 0x04
+				btmgmt advertising on
+				btmgmt monitor
+				Note: Enter invalid passkey in PTS
+TC_OOB_BV_01_C		NA
+TC_OOB_BV_02_C		NA
+TC_OOB_BV_03_C		NA
+TC_OOB_BV_04_C		NA
+TC_OOB_BV_05_C		PASS
+TC_OOB_BV_06_C		PASS
+TC_OOB_BV_07_C		PASS
+TC_OOB_BV_08_C		PASS
+TC_OOB_BV_09_C		NA
+TC_OOB_BV_10_C		NA
+TC_OOB_BI_01_C		NA
+TC_OOB_BI_02_C		NA
+TC_EKS_BV_01_C		PASS
+TC_EKS_BV_02_C		PASS
+TC_EKS_BI_01_C		PASS	btmgmt io-cap 0x03
+TC_EKS_BI_02_C		PASS
+TC_SIGN_BV_01_C		INC	PTS issue ID: 12305
+TC_SIGN_BV_03_C		PASS	haltest
+				gattc listen
+
+TC_SIGN_BI_01_C		PASS	haltest
+				gattc listen
+TC_KDU_BV_01_C		PASS	btmgmt pairable on
+TC_KDU_BV_02_C		PASS	PTS issue: ID 12302
+				Note: Can pass it with following instructions:
+				btmgmt privacy on
+				btmgmt advetising on
+				Check our random address (valid for 15 min)
+				Set PIXIT TSPX_bd_addr_iut to random address
+				Set PIXIT TSPX_peer_type to 01
+TC_KDU_BV_03_C		PASS	btmgmt pairable on
+				btmgmt advertising on
+
+TC_KDU_BV_04_C		INC	PTS issue: ID: 12301
+TC_KDU_BV_05_C		PASS	PTS issue: ID: 12302
+				Note: Can pass it with following instructions:
+				btmgmt privacy on
+				Check our random address (valid for 15 min)
+				Set PIXIT TSPX_bd_addr_iut to random address
+				Set PIXIT TSPX_peer_type to 01
+TC_KDU_BV_06_C		FAIL	PTS issue: ID: 12301, 12302
+TC_KDU_BV_07_C		PASS	btmgmt pairable on
+TC_SIP_BV_01_C		PASS	btmgmt pair -c 0x03 -t 0x01 <addr>
+TC_SIP_BV_02_C		PASS	l2test -n -J 4 -V le_public <addr>
+TC_SIE_BV_01_C		INC	PTS issue: ID: 12306
 -------------------------------------------------------------------------------
-- 
1.8.4

