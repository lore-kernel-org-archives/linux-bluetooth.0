Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCH] android/pts: Update HOGP test results
Date: Wed, 20 May 2015 15:21:43 +0200
Message-Id: <1432128103-5210-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

PTS 6.1 and Android 5.1
---
 android/pics-hogp.txt  | 73 +++++++++++++++++++++++++++-----------------------
 android/pixit-hogp.txt |  4 +--
 android/pts-hogp.txt   |  8 +++---
 3 files changed, 45 insertions(+), 40 deletions(-)

diff --git a/android/pics-hogp.txt b/android/pics-hogp.txt
index e656e0c..bd9c9f9 100644
--- a/android/pics-hogp.txt
+++ b/android/pics-hogp.txt
@@ -1,6 +1,6 @@
 HOGP PICS for the PTS tool.
 
-PTS version: 6.0
+PTS version: 6.1
 
 * - different than PTS defaults
 # - not yet implemented/supported
@@ -13,13 +13,11 @@ O - optional
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
 TSPC_HOGP_1_1	False (*)	HID Device (Server) (C.1)
-TSPC_HOGP_1_2	True		Report Host (Client) (C.1, C.2)
-TSPC_HOGP_1_3	False (*)	Boot Host (Client) (C.1, C.3)
+TSPC_HOGP_1_2	True		Report Host (Client) (C.1)
+TSPC_HOGP_1_3	False (*)	Boot Host (Client) (C.1)
 -------------------------------------------------------------------------------
 C.1: Mandatory to support at least one of TSPC_HOGP_1_1 or TSPC_HOGP_1_2
 	or TSPC_HOGP_1_3.
-C.2: Excluded if TSPC_HOGP_1_3 is supported.
-C.3: Excluded if TSPC_HOGP_1_2 is supported.
 -------------------------------------------------------------------------------
 
 
@@ -91,7 +89,8 @@ M.1: Mandatory if TSPC_HOGP_1_1 selected
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_HOGP_6_1	False (*)	SM 2.3.1 (M.1)
+TSPC_HOGP_6_1	False (*)	No security
+					(LE Security Level 1) (M.1)
 TSPC_HOGP_6_2	False (*)	Unauthenticated no MITM protection
 					(LE Security Level 2, Just Works) (M.1)
 TSPC_HOGP_6_3	False (*)	Authenticated MITM protection
@@ -335,24 +334,26 @@ C.2: Mandatory to support if TSPC_HOGP_10_8 is supported, else excluded.
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_HOGP_13_1	True		Attribute Protocol supported over LE Transport (M)
-TSPC_HOGP_13_2	True		Generic Attribute Profile Client (M)
+TSPC_HOGP_13_1	True		Attribute Protocol supported over LE Transport
+					(M.1)
+TSPC_HOGP_13_2	True		Generic Attribute Profile Client (M.1)
 TSPC_HOGP_13_3	True		Discover All Primary Services (C.1)
 TSPC_HOGP_13_4	False (*)	Discover Primary Services by Service UUID (C.1)
-TSPC_HOGP_13_5	True		Find Included Services (M)
+TSPC_HOGP_13_5	True		Find Included Services (M.1)
 TSPC_HOGP_13_6	True		Discover All Characteristics of a Service (C.2)
 TSPC_HOGP_13_7	False (*)	Discover Characteristics by UUID (C.2)
-TSPC_HOGP_13_8	True		Discover All Characteristic Descriptors (M)
-TSPC_HOGP_13_9	True		Read Characteristic Value (M)
+TSPC_HOGP_13_8	True		Discover All Characteristic Descriptors (M.1)
+TSPC_HOGP_13_9	True		Read Characteristic Value (M.1)
 TSPC_HOGP_13_10	True		Read using Characteristic UUID (O)
-TSPC_HOGP_13_11	True		Read Long Characteristic Value (M)
-TSPC_HOGP_13_12	True		Read Characteristic Descriptors (M)
-TSPC_HOGP_13_13	True		Write without Response (M)
-TSPC_HOGP_13_14	True		Write Characteristic Value (M)
-TSPC_HOGP_13_15	True		Write Characteristic Descriptors (M)
-TSPC_HOGP_13_16	True		Notifications (M)
-TSPC_HOGP_13_17	True		Exchange MTU (M)
+TSPC_HOGP_13_11	True		Read Long Characteristic Value (M.1)
+TSPC_HOGP_13_12	True		Read Characteristic Descriptors (M.1)
+TSPC_HOGP_13_13	True		Write without Response (M.1)
+TSPC_HOGP_13_14	True		Write Characteristic Value (M.1)
+TSPC_HOGP_13_15	True		Write Characteristic Descriptors (M.1)
+TSPC_HOGP_13_16	True		Notifications (M.1)
+TSPC_HOGP_13_17	True		Exchange MTU (M.1)
 -------------------------------------------------------------------------------
+M.1: Mandatory if TSPC_HOGP_1_2 selected
 C.1: Mandatory to support at least one of these features.
 C.2: Mandatory to support at least one of these features.
 -------------------------------------------------------------------------------
@@ -362,20 +363,23 @@ C.2: Mandatory to support at least one of these features.
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_HOGP_14_1	False (*)	Attribute Protocol supported over LE Transport (M)
-TSPC_HOGP_14_2	False (*)	Generic Attribute Profile Client (M)
+TSPC_HOGP_14_1	False (*)	Attribute Protocol supported over LE Transport
+					(M.1)
+TSPC_HOGP_14_2	False (*)	Generic Attribute Profile Client (M.1)
 TSPC_HOGP_14_3	False (*)	Discover All Primary Services (C.1)
 TSPC_HOGP_14_4	False (*)	Discover Primary Services by Service UUID (C.1)
 TSPC_HOGP_14_5	False (*)	Discover All Characteristics of a Service (O)
 TSPC_HOGP_14_6	False (*)	Discover Characteristics by UUID (O)
-TSPC_HOGP_14_7	False (*)	Discover All Characteristic Descriptors (M)
-TSPC_HOGP_14_8	False (*)	Read Characteristic Value (M)
-TSPC_HOGP_14_9	False (*)	Read using Characteristic UUID (M)
-TSPC_HOGP_14_10	False (*)	Read Characteristic Descriptors (M)
-TSPC_HOGP_14_11	False (*)	Write without Response (M)
-TSPC_HOGP_14_12	False (*)	Write Characteristic Value (M)
-TSPC_HOGP_14_13	False (*)	Write Characteristic Descriptors (M)
-TSPC_HOGP_14_14	False (*)	Notifications (M)
+TSPC_HOGP_14_7	False (*)	Discover All Characteristic Descriptors (M.1)
+TSPC_HOGP_14_8	False (*)	Read Characteristic Value (M.1)
+TSPC_HOGP_14_9	False (*)	Read using Characteristic UUID (M.1)
+TSPC_HOGP_14_10	False (*)	Read Characteristic Descriptors (M.1)
+TSPC_HOGP_14_11	False (*)	Write without Response (M.1)
+TSPC_HOGP_14_12	False (*)	Write Characteristic Value (M.1)
+TSPC_HOGP_14_13	False (*)	Write Characteristic Descriptors (M.1)
+TSPC_HOGP_14_14	False (*)	Notifications (M.1)
+-------------------------------------------------------------------------------
+M.1: Mandatory if TSPC_HOGP_1_3 selected
 -------------------------------------------------------------------------------
 
 
@@ -383,11 +387,10 @@ TSPC_HOGP_14_14	False (*)	Notifications (M)
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_HOGP_15_1	True		Central (M.1 or M.2)
-TSPC_HOGP_15_2	True		LE Security Mode 1 (central) (M.1 or M.2)
+TSPC_HOGP_15_1	True		Central (M.1)
+TSPC_HOGP_15_2	True		LE Security Mode 1 (central) (M.1)
 -------------------------------------------------------------------------------
-M.1: Mandatory if TSPC_HOGP_1_2 selected
-M.2: Mandatory if TSPC_HOGP_1_3 selected
+M.1: Mandatory if TSPC_HOGP_1_2 or TSPC_HOGP_1_3 is selected
 -------------------------------------------------------------------------------
 
 
@@ -396,9 +399,11 @@ M.2: Mandatory if TSPC_HOGP_1_3 selected
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
 TSPC_HOGP_16_1	True		No Security Requirements (LE Security Level 1,
-					No Security) (M)
+					No Security) (M.1)
 TSPC_HOGP_16_2	True		Unauthenticated no MITM protection (LE Security
-					Level 2, Just Works) (M)
+					Level 2, Just Works) (M.1)
 TSPC_HOGP_16_3	True		Authenticated MITM protection (LE Security
 					Level 3, Passkey) (O)
 -------------------------------------------------------------------------------
+M.1: Mandatory if TSPC_HOGP_1_2 or TSPC_HOGP_1_3 is selected
+-------------------------------------------------------------------------------
diff --git a/android/pixit-hogp.txt b/android/pixit-hogp.txt
index e72948e..6a38d19 100644
--- a/android/pixit-hogp.txt
+++ b/android/pixit-hogp.txt
@@ -1,6 +1,6 @@
 HOGP PIXIT for the PTS tool.
 
-PTS version: 6.0
+PTS version: 6.1
 
 * - different than PTS defaults
 & - should be set to IUT Bluetooth address
@@ -25,5 +25,5 @@ TSPX_input_report_data					CDA6F8B3AA
 TSPX_output_report_data					001234567890EF
 TSPX_feature_report_data				872D3F45EA
 TSPX_tester_appearance					03C0
-TSPX_iut_use_resolvable_random_address	FALSE
+TSPX_iut_use_resolvable_random_address			FALSE
 -------------------------------------------------------------------------------
diff --git a/android/pts-hogp.txt b/android/pts-hogp.txt
index 827e9b4..a6b8dc1 100644
--- a/android/pts-hogp.txt
+++ b/android/pts-hogp.txt
@@ -1,8 +1,8 @@
 PTS test results for HoG
 
-PTS version: 6.0
-Tested: 24-February-2015
-Android version: 5.0
+PTS version: 6.1
+Tested: 20-May-2015
+Android version: 5.1
 
 Results:
 PASS	test passed
@@ -93,7 +93,7 @@ TC_HGCF_BH_BV_03_I	N/A
 TC_HGCF_BH_BV_04_I	N/A
 TC_HGCF_BH_BV_05_I	N/A
 TC_HGCF_BH_BV_06_I	N/A
-TC_HGNF_RH_BV_01_I	PASS	PTS issue #12878
+TC_HGNF_RH_BV_01_I	PASS
 TC_HGNF_RH_BI_01_I	PASS
 TC_HGNF_RH_BI_01_I	PASS
 TC_HGNF_BH_BV_02_I	N/A
-- 
1.9.1

