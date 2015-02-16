Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCH 1/2] android/pts: Update HOGP PIXIT, PICS for PTS 6.0
Date: Mon, 16 Feb 2015 09:43:56 +0100
Message-Id: <1424076237-28349-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pics-hogp.txt  | 75 ++++++++++++++++++++++++++------------------------
 android/pixit-hogp.txt |  3 +-
 2 files changed, 41 insertions(+), 37 deletions(-)

diff --git a/android/pics-hogp.txt b/android/pics-hogp.txt
index 61cf56a..e656e0c 100644
--- a/android/pics-hogp.txt
+++ b/android/pics-hogp.txt
@@ -1,6 +1,6 @@
 HOGP PICS for the PTS tool.
 
-PTS version: 5.3
+PTS version: 6.0
 
 * - different than PTS defaults
 # - not yet implemented/supported
@@ -249,7 +249,7 @@ TSPC_HOGP_11_10	True		Read Report characteristic: Input Report:
 TSPC_HOGP_11_11	True		Report characteristic configuration with 0x0001
 					(M.1)
 TSPC_HOGP_11_11a True		Report characteristic configuration with 0x0000
-					(M.1)
+					(O)
 TSPC_HOGP_11_12	True		Read HID Information characteristic (M.1)
 TSPC_HOGP_11_13	False (*)	Suspend State (O)
 TSPC_HOGP_11_14	False (*)	Exit Suspend State (C.1)
@@ -335,23 +335,26 @@ C.2: Mandatory to support if TSPC_HOGP_10_8 is supported, else excluded.
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_HOGP_13_1	True		Attribute Protocol supported over LE Transport
-TSPC_HOGP_13_2	True		Generic Attribute Profile Client
-TSPC_HOGP_13_3	True		Discover All Primary Services
-TSPC_HOGP_13_4	False (*)	Discover Primary Services by Service UUID
-TSPC_HOGP_13_5	True		Find Included Services
-TSPC_HOGP_13_6	True		Discover All Characteristics of a Service
-TSPC_HOGP_13_7	False (*)	Discover Characteristics by UUID
-TSPC_HOGP_13_8	True		Discover All Characteristic Descriptors
-TSPC_HOGP_13_9	True		Read Characteristic Value
-TSPC_HOGP_13_10	True		Read using Characteristic UUID
-TSPC_HOGP_13_11	True		Read Long Characteristic Value
-TSPC_HOGP_13_12	True		Read Characteristic Descriptors
-TSPC_HOGP_13_13	True		Write without Response
-TSPC_HOGP_13_14	True		Write Characteristic Value
-TSPC_HOGP_13_15	True		Write Characteristic Descriptors
-TSPC_HOGP_13_16	True		Notifications
-TSPC_HOGP_13_17	True		Exchange MTU
+TSPC_HOGP_13_1	True		Attribute Protocol supported over LE Transport (M)
+TSPC_HOGP_13_2	True		Generic Attribute Profile Client (M)
+TSPC_HOGP_13_3	True		Discover All Primary Services (C.1)
+TSPC_HOGP_13_4	False (*)	Discover Primary Services by Service UUID (C.1)
+TSPC_HOGP_13_5	True		Find Included Services (M)
+TSPC_HOGP_13_6	True		Discover All Characteristics of a Service (C.2)
+TSPC_HOGP_13_7	False (*)	Discover Characteristics by UUID (C.2)
+TSPC_HOGP_13_8	True		Discover All Characteristic Descriptors (M)
+TSPC_HOGP_13_9	True		Read Characteristic Value (M)
+TSPC_HOGP_13_10	True		Read using Characteristic UUID (O)
+TSPC_HOGP_13_11	True		Read Long Characteristic Value (M)
+TSPC_HOGP_13_12	True		Read Characteristic Descriptors (M)
+TSPC_HOGP_13_13	True		Write without Response (M)
+TSPC_HOGP_13_14	True		Write Characteristic Value (M)
+TSPC_HOGP_13_15	True		Write Characteristic Descriptors (M)
+TSPC_HOGP_13_16	True		Notifications (M)
+TSPC_HOGP_13_17	True		Exchange MTU (M)
+-------------------------------------------------------------------------------
+C.1: Mandatory to support at least one of these features.
+C.2: Mandatory to support at least one of these features.
 -------------------------------------------------------------------------------
 
 
@@ -359,20 +362,20 @@ TSPC_HOGP_13_17	True		Exchange MTU
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_HOGP_14_1	False (*)	Attribute Protocol supported over LE Transport
-TSPC_HOGP_14_2	False (*)	Generic Attribute Profile Client
-TSPC_HOGP_14_3	False (*)	Discover All Primary Services
-TSPC_HOGP_14_4	False (*)	Discover Primary Services by Service UUID
-TSPC_HOGP_14_5	False (*)	Discover All Characteristics of a Service
-TSPC_HOGP_14_6	False (*)	Discover Characteristics by UUID
-TSPC_HOGP_14_7	False (*)	Discover All Characteristic Descriptors
-TSPC_HOGP_14_8	False (*)	Read Characteristic Value
-TSPC_HOGP_14_9	False (*)	Read using Characteristic UUID
-TSPC_HOGP_14_10	False (*)	Read Characteristic Descriptors
-TSPC_HOGP_14_11	False (*)	Write without Response
-TSPC_HOGP_14_12	False (*)	Write Characteristic Value
-TSPC_HOGP_14_13	False (*)	Write Characteristic Descriptors
-TSPC_HOGP_14_14	False (*)	Notifications
+TSPC_HOGP_14_1	False (*)	Attribute Protocol supported over LE Transport (M)
+TSPC_HOGP_14_2	False (*)	Generic Attribute Profile Client (M)
+TSPC_HOGP_14_3	False (*)	Discover All Primary Services (C.1)
+TSPC_HOGP_14_4	False (*)	Discover Primary Services by Service UUID (C.1)
+TSPC_HOGP_14_5	False (*)	Discover All Characteristics of a Service (O)
+TSPC_HOGP_14_6	False (*)	Discover Characteristics by UUID (O)
+TSPC_HOGP_14_7	False (*)	Discover All Characteristic Descriptors (M)
+TSPC_HOGP_14_8	False (*)	Read Characteristic Value (M)
+TSPC_HOGP_14_9	False (*)	Read using Characteristic UUID (M)
+TSPC_HOGP_14_10	False (*)	Read Characteristic Descriptors (M)
+TSPC_HOGP_14_11	False (*)	Write without Response (M)
+TSPC_HOGP_14_12	False (*)	Write Characteristic Value (M)
+TSPC_HOGP_14_13	False (*)	Write Characteristic Descriptors (M)
+TSPC_HOGP_14_14	False (*)	Notifications (M)
 -------------------------------------------------------------------------------
 
 
@@ -393,9 +396,9 @@ M.2: Mandatory if TSPC_HOGP_1_3 selected
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
 TSPC_HOGP_16_1	True		No Security Requirements (LE Security Level 1,
-					No Security)
+					No Security) (M)
 TSPC_HOGP_16_2	True		Unauthenticated no MITM protection (LE Security
-					Level 2, Just Works)
+					Level 2, Just Works) (M)
 TSPC_HOGP_16_3	True		Authenticated MITM protection (LE Security
-					Level 3, Passkey)
+					Level 3, Passkey) (O)
 -------------------------------------------------------------------------------
diff --git a/android/pixit-hogp.txt b/android/pixit-hogp.txt
index d32fe69..e72948e 100644
--- a/android/pixit-hogp.txt
+++ b/android/pixit-hogp.txt
@@ -1,6 +1,6 @@
 HOGP PIXIT for the PTS tool.
 
-PTS version: 5.3
+PTS version: 6.0
 
 * - different than PTS defaults
 & - should be set to IUT Bluetooth address
@@ -25,4 +25,5 @@ TSPX_input_report_data					CDA6F8B3AA
 TSPX_output_report_data					001234567890EF
 TSPX_feature_report_data				872D3F45EA
 TSPX_tester_appearance					03C0
+TSPX_iut_use_resolvable_random_address	FALSE
 -------------------------------------------------------------------------------
-- 
1.9.1

