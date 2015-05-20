Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCHv2] android/pts: Update SM test results
Date: Wed, 20 May 2015 11:55:03 +0200
Message-Id: <1432115703-30609-1-git-send-email-mariusz.skamra@tieto.com>
In-Reply-To: <2648839.tQezcmsJ0R@leonov>
References: <2648839.tQezcmsJ0R@leonov>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

PTS 6.1 and Android 5.1
---
 android/pics-sm.txt  | 23 ++++++++++++++---------
 android/pixit-sm.txt |  2 +-
 android/pts-sm.txt   | 36 +++++++++++-------------------------
 3 files changed, 26 insertions(+), 35 deletions(-)

diff --git a/android/pics-sm.txt b/android/pics-sm.txt
index c5caec6..c31fe76 100644
--- a/android/pics-sm.txt
+++ b/android/pics-sm.txt
@@ -1,8 +1,9 @@
 SM PICS for the PTS tool.
 
-PTS version: 6.0
+PTS version: 6.1
 
 * - different than PTS defaults
+^ - field not available on PTS
 
 M - mandatory
 O - optional
@@ -12,9 +13,11 @@ O - optional
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
 TSPC_SM_1_1	True		Master Role (Initiator) (C.1)
-TSPC_SM_1_2	True		Slave Role (Responder) (C.1)
+TSPC_SM_1_2	True		Slave Role (Responder) (C.2)
 -------------------------------------------------------------------------------
-C.1: At least one of these features shall be supported.
+C.1: Mandatory to support if TSPC_SM_1_2 is NOT supported, otherwise Optional
+C.2: Optional IF ((4.0 OR 4.0+HS) AND TSPC_GAP_5_3) OR ((4.1 OR 4.1+HS OR 4.2
+	OR 4.2+HS) AND (TSPC_GAP_5_3 OR TSPC_GAP_38_3)))
 -------------------------------------------------------------------------------
 
 
@@ -26,8 +29,10 @@ TSPC_SM_2_1	True		Authenticated MITM protection (O)
 TSPC_SM_2_2	True		Unauthenticated no MITM protection (C.1)
 TSPC_SM_2_3	True		No security requirements (M)
 TSPC_SM_2_4	False (*)	OOB supported (O)
+TSPC_SM_2_5	(^)		LE Secure Connections (C.2)
 -------------------------------------------------------------------------------
 C.1: If TSPC_SM_2_1 is supported then Mandatory, else Optional
+C.2: Optional IF Core 4.2 OR Core 4.2+HS are supported, otherwise Excluded
 -------------------------------------------------------------------------------
 
 
@@ -47,8 +52,8 @@ TSPC_SM_4_1	True		Just Works (O)
 TSPC_SM_4_2	True		Passkey Entry (C.1)
 TSPC_SM_4_3	False (*)	Out of Band (C.1)
 -------------------------------------------------------------------------------
-C.1: If TSPC_SM_2_1 is supported, at least one of these features shall be
-	supported.
+C.1: Mandatory to support at least one of the defined methods IF TSPC_SM_2_1 is
+	supported, otherwise Excluded.
 -------------------------------------------------------------------------------
 
 
@@ -63,7 +68,7 @@ TSPC_SM_5_4	True		Slave Initiated Security – Master response(C.2)
 -------------------------------------------------------------------------------
 C.1: Mandatory if TSPC_SM_1_2 is supported, otherwise Excluded
 C.2: Mandatory if TSPC_SM_1_1 is supported, otherwise Excluded
-C.3: Mandatory IF TSPC_SM_2_1 OR TSPC_SM_2_1 OR TSPC_SM_2_4 is supported,
+C.3: Mandatory IF TSPC_SM_2_1 OR TSPC_SM_2_2 OR TSPC_SM_2_4 is supported,
 	otherwise Excluded
 -------------------------------------------------------------------------------
 
@@ -85,7 +90,7 @@ TSPC_SM_7_1	True		Encryption Key (C.1)
 TSPC_SM_7_2	True		Identity Key (C.2)
 TSPC_SM_7_3	True		Signing Key (C.3)
 -------------------------------------------------------------------------------
-C.1: Mandatory if GAP (24/2 OR 42/6) is supported, ELSE Optional
-C.2: Mandatory if GAP (26/3) is supported, ELSE Optional
-C.3: Mandatory if GAP (25/6 OR 35/6) is supported, ELSE Optional
+C.1: Mandatory if TSPC_GAP_24_2 OR TSPC_GAP_42_6 is supported, ELSE Optional
+C.2: Mandatory if TSPC_GAP_26_3 is supported, ELSE Optional
+C.3: Mandatory if TSPC_GAP_25_6 OR TSPC_GAP_35_6 is supported, ELSE Optional
 -------------------------------------------------------------------------------
diff --git a/android/pixit-sm.txt b/android/pixit-sm.txt
index 98e2ab5..6facbb8 100644
--- a/android/pixit-sm.txt
+++ b/android/pixit-sm.txt
@@ -1,6 +1,6 @@
 SM PIXIT for the PTS tool.
 
-PTS version: 6.0
+PTS version: 6.1
 
 * - different than PTS defaults
 & - should be set to IUT Bluetooth address
diff --git a/android/pts-sm.txt b/android/pts-sm.txt
index 91737cc..1fad305 100644
--- a/android/pts-sm.txt
+++ b/android/pts-sm.txt
@@ -1,9 +1,9 @@
 PTS test results for SM
 
-PTS version: 6.0
-Tested: 11-February-2015
-Android version: 5.0
-kernel version: 3.20
+PTS version: 6.1
+Tested: 04-May-2015
+Android version: 5.1
+kernel version: 4.1
 
 Results:
 PASS	test passed
@@ -24,12 +24,7 @@ TC_JW_BV_02_C		PASS	btmgmt advertising on
 TC_JW_BV_05_C		PASS	btmgmt pair -c 0x03 -t 0x01 <addr>
 TC_JW_BI_01_C		PASS	btmgmt pair -c 0x03 -t 0x01 <addr>
 TC_JW_BI_02_C		PASS	btmgmt pairable on
-TC_JW_BI_03_C		PASS	bluetoothd is NOT running
-				btmgmt power on
-				btmgmt le on
-				btmgmt connectable on
-				btmgmt pairable on
-				btmgmt discov on
+TC_JW_BI_03_C		PASS	btmgmt pairable on
 				btmgmt advertising on
 TC_JW_BI_04_C		PASS	btmgmt pairable off
 				btmgmg pair -c 0x03 -t 0x01 <addr>
@@ -38,8 +33,6 @@ TC_PKE_BV_01_C		PASS	btmgmt pairable off
 				Note: provide passkey to PTS
 TC_PKE_BV_02_C		PASS	btmgmt pairable off
 				btmgmt io-cap 0x04
-				btmgmt advertising on
-				btmgmt monitor
 				Note: provide passkey
 TC_PKE_BV_04_C		PASS	btmgmt pair -c 0x04 -t 0x01 <addr>
 TC_PKE_BV_05_C		PASS	btmgmt io-cap 0x04
@@ -50,7 +43,6 @@ TC_PKE_BI_02_C		PASS	btmgmt pair -c 0x04 -t 0x01 <addr>
 				Note: provide passkey
 TC_PKE_BI_03_C		PASS	btmgmt io-cap 0x04
 				btmgmt advertising on
-				btmgmt monitor
 				Note: Enter invalid passkey in PTS
 TC_OOB_BV_01_C		N/A
 TC_OOB_BV_02_C		N/A
@@ -59,12 +51,10 @@ TC_OOB_BV_04_C		N/A
 TC_OOB_BV_05_C		PASS	btmgmt pair -c 0x04 -t 0x01 <addr>
 				Note: Enter valid passkey in PTS
 TC_OOB_BV_06_C		PASS	btmgmt advertising on
-				btmgmt monitor
 				Note: Enter valid passkey in PTS
 TC_OOB_BV_07_C		PASS	btmgmt pair -c 0x04 -t 0x01 <addr>
 TC_OOB_BV_08_C		PASS	btmgmt advertising on
-				btmgmt monitor
-				Note: Accept pairing in btmgmt monitor
+				Note: Accept pairing in btmgmt
 TC_OOB_BV_09_C		N/A
 TC_OOB_BV_10_C		N/A
 TC_OOB_BI_01_C		N/A
@@ -72,10 +62,8 @@ TC_OOB_BI_02_C		N/A
 TC_EKS_BV_01_C		PASS	btmgmt pair -c 0x04 -t 0x01 <addr>
 				Note: Enter valid passkey in PTS
 TC_EKS_BV_02_C		PASS	btmgmt advertising on
-				btmgmt monitor
-				Note: Accept pairing in btmgmt monitor
-TC_EKS_BI_01_C		PASS	btmgmt io-cap 0x03
-				btmgmt pair -c 0x03 -t 0x01 <addr>
+				Note: Accept pairing in btmgmt
+TC_EKS_BI_01_C		PASS	btmgmt pair -c 0x03 -t 0x01 <addr>
 TC_EKS_BI_02_C		PASS	btmgmt advertising on
 TC_SIGN_BV_01_C		INC	PTS issue #12305
 TC_SIGN_BV_03_C		PASS	haltest:
@@ -108,9 +96,7 @@ TC_KDU_BV_05_C		PASS	PTS issue #12302
 TC_KDU_BV_06_C		PASS	btmgmt pair -c 0x03 -t 0x01 <addr>
 TC_KDU_BV_07_C		PASS	btmgmt pairable on
 TC_SIP_BV_01_C		PASS	btmgmt advertising on
-				btmgmt pair -c 0x03 -t 0x01 <addr>
-TC_SIP_BV_02_C		PASS	btmgmt advertising off
-				l2test -n -J4 -V le_public <addr>
-TC_SIE_BV_01_C		PASS	btmgmt advertising on
-				btmgmt pair -c 0x03 -t 0x01 <addr>
+TC_SIP_BV_02_C		PASS	btmgmt pair -c 0x03 -t 0x01 <addr>
+TC_SIE_BV_01_C		PASS	btmgmt io-cap 0x03
+				btmgmt advertising on
 -------------------------------------------------------------------------------
-- 
1.9.1

