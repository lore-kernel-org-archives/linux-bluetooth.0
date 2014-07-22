Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/pts: Update PTS files for HOGP
Date: Tue, 22 Jul 2014 16:08:57 +0200
Message-Id: <1406038137-2730-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

PICS and PIXITs updated to PTS 5.2. Regression done for Android
4.4.4.
---
 android/pics-hogp.txt  | 190 +++++++++++++++++++++++++------------------------
 android/pixit-hogp.txt |   2 +-
 android/pts-hogp.txt   |   6 +-
 3 files changed, 101 insertions(+), 97 deletions(-)

diff --git a/android/pics-hogp.txt b/android/pics-hogp.txt
index 17965de..d7192bf 100644
--- a/android/pics-hogp.txt
+++ b/android/pics-hogp.txt
@@ -1,6 +1,6 @@
 HOGP PICS for the PTS tool.
 
-PTS version: 5.1
+PTS version: 5.2
 
 * - different than PTS defaults
 # - not yet implemented/supported
@@ -12,12 +12,14 @@ O - optional
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_HOGP_1_1	False (*)	HID Device (C.1)
-TSPC_HOGP_1_2	True		Report Host (C.1)
-TSPC_HOGP_1_3	False (*)	Boot Host (C.1)
+TSPC_HOGP_1_1	False (*)	HID Device (Server) (C.1)
+TSPC_HOGP_1_2	True		Report Host (Client) (C.1, C.2)
+TSPC_HOGP_1_3	False (*)	Boot Host (Client) (C.1, C.3)
 -------------------------------------------------------------------------------
 C.1: Mandatory to support at least one of TSPC_HOGP_1_1 or TSPC_HOGP_1_2
 	or TSPC_HOGP_1_3.
+C.2: Excluded if TSPC_HOGP_1_3 is supported.
+C.3: Excluded if TSPC_HOGP_1_2 is supported.
 -------------------------------------------------------------------------------
 
 
@@ -103,10 +105,12 @@ M.1: Mandatory if TSPC_HOGP_1_1 selected
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_HOGP_7_1	True		HID Service (M)
-TSPC_HOGP_7_2	True		Battery Service (M)
-TSPC_HOGP_7_3	True		Device Information Service (M)
-TSPC_HOGP_7_4	True		Scan Parameters Service (M)
+TSPC_HOGP_7_1	True		HID Service (M.1)
+TSPC_HOGP_7_2	True		Battery Service (M.1)
+TSPC_HOGP_7_3	True		Device Information Service (M.1)
+TSPC_HOGP_7_4	True		Scan Parameters Service (M.1)
+-------------------------------------------------------------------------------
+M.1: Mandatory if TSPC_HOGP_1_2 selected
 -------------------------------------------------------------------------------
 
 
@@ -114,7 +118,9 @@ TSPC_HOGP_7_4	True		Scan Parameters Service (M)
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_HOGP_7a_1	True		Scan Parameters Profile (M)
+TSPC_HOGP_7a_1	True		Scan Parameters Profile (M.1)
+-------------------------------------------------------------------------------
+M.1: Mandatory if TSPC_HOGP_1_2 selected
 -------------------------------------------------------------------------------
 
 
@@ -134,38 +140,42 @@ M.1: Mandatory if TSPC_HOGP_1_3 selected
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_HOGP_9_1	True		Discover HID Service (M)
-TSPC_HOGP_9_2	True		Discover Battery Service (M)
-TSPC_HOGP_9_3	True		Discover Device Information Service (M)
-TSPC_HOGP_9_4	True		Discover Scan Parameters Service (M)
+TSPC_HOGP_9_1	True		Discover HID Service (M.1)
+TSPC_HOGP_9_2	True		Discover Battery Service (M.1)
+TSPC_HOGP_9_3	True		Discover Device Information Service (M.1)
+TSPC_HOGP_9_4	True		Discover Scan Parameters Service (M.1)
 TSPC_HOGP_9_5	True		Discover HID Service characteristic: Report Map
-					(M)
+					(M.1)
 TSPC_HOGP_9_6	True		Discover HID Service characteristic: Report Map
 					- External Report Reference
-					characteristic descriptor (M)
-TSPC_HOGP_9_7	True		Discover HID Service characteristic: Report (M)
-TSPC_HOGP_9_8	True		Discover HID Service characteristic: Report (M)
+					characteristic descriptor (M.1)
+TSPC_HOGP_9_7	True		Discover HID Service characteristic: Report
+					(M.1)
+TSPC_HOGP_9_8	True		Discover HID Service characteristic: Report
 					- Client Characteristic Configuration
-					characteristic descriptor (M)
+					characteristic descriptor (M.1)
 TSPC_HOGP_9_9	True		Discover HID Service characteristic: Report
 					- Report Reference characteristic
-					descriptor (M)
+					descriptor (M.1)
 TSPC_HOGP_9_10	True		Discover HID Service characteristic: HID
-					Information (M)
+					Information (M.1)
 TSPC_HOGP_9_11	True		Discover HID Service characteristic: HID
-					Control Point (M)
+					Control Point (M.1)
 TSPC_HOGP_9_12	True		Discover HID Service characteristic: Protocol
 					Mode (O)
 TSPC_HOGP_9_13	True		Discover Battery Service characteristic: Battery
-					Level (M)
+					Level (M.1)
 TSPC_HOGP_9_14	True		Discover Battery Service characteristic: Battery
 					Level - Client Characteristic
 					Configuration characteristic descriptor
-					(M)
+					(M.1)
 TSPC_HOGP_9_15	True		Discover Device Information Service
-					characteristic: PnP ID (M)
+					characteristic: PnP ID (M.1)
 TSPC_HOGP_9_16	True		Discover non-HID Service characteristic: Report
-					Reference characteristic descriptor (M)
+					Reference characteristic descriptor
+					(M.1)
+-------------------------------------------------------------------------------
+M.1: Mandatory if TSPC_HOGP_1_2 selected
 -------------------------------------------------------------------------------
 
 
@@ -215,35 +225,32 @@ C.4: Mandatory to support if TSPC_HOGP_10_8 is supported, else excluded.
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_HOGP_11_1	True		Read Report Map characteristic (M)
+TSPC_HOGP_11_1	True		Read Report Map characteristic (M.1)
 TSPC_HOGP_11_2	True		Read Report Map characteristic: External
 					Report Reference characteristic
-					descriptor (M)
+					descriptor (M.1)
 TSPC_HOGP_11_3	True		Read Report characteristic: Report Type:
-					Input Report (M)
+					Input Report (M.1)
 TSPC_HOGP_11_4	True		Write Report characteristic: Report Type:
-					Input Report (M)
+					Input Report (M.1)
 TSPC_HOGP_11_5	True		Read Report characteristic: Report Type:
-					Output Report (M)
+					Output Report (M.1)
 TSPC_HOGP_11_6	True		Write HID Report characteristic: Report Type:
-					Output Report (M)
+					Output Report (M.1)
 TSPC_HOGP_11_7	True		Read HID Report characteristic: Report Type:
-					Feature Report (M)
+					Feature Report (M.1)
 TSPC_HOGP_11_8	True		Write HID Report characteristic: Report Type:
-					Feature Report (M)
-TSPC_HOGP_11_9	True		Read Report characteristic: Report
-					Reference characteristic descriptor (M)
+					Feature Report (M.1)
+TSPC_HOGP_11_9	True		Read Report characteristic: Report Reference
+					characteristic descriptor (M.1)
 TSPC_HOGP_11_10	True		Read Report characteristic: Input Report:
 					Client Characteristic Configuration
-					characteristic descriptor (M)
+					characteristic descriptor (M.1)
 TSPC_HOGP_11_11	True		Report characteristic configuration with 0x0001
-					(M)
-
+					(M.1)
 TSPC_HOGP_11_11a True		Report characteristic configuration with 0x0000
-					(?)
-
-TSPC_HOGP_11_12	True		Read HID Information characteristic
-					(M)
+					(M.1)
+TSPC_HOGP_11_12	True		Read HID Information characteristic (M.1)
 TSPC_HOGP_11_13	False (*)	Suspend State (O)
 TSPC_HOGP_11_14	False (*)	Exit Suspend State (C.1)
 TSPC_HOGP_11_15	False (*)	Write HID Control Point characteristic: Suspend
@@ -254,18 +261,20 @@ TSPC_HOGP_11_17	False (*)	Read Protocol Mode characteristic: Get Protocol
 					command (O)
 TSPC_HOGP_11_18	False (*)	Write Protocol Mode characteristic: Set Report
 					Protocol Mode command (O)
-TSPC_HOGP_11_19	True		Read Battery Level characteristic (M)
+TSPC_HOGP_11_19	True		Read Battery Level characteristic (M.1)
 TSPC_HOGP_11_20	True		Read Battery Level characteristic: Client
 					Characteristic Configuration
-					characteristic descriptor (M)
+					characteristic descriptor (M.1)
 TSPC_HOGP_11_21	True		Battery Level characteristic configuration with
-					0x0000 0r 0x0001 (M)
+					0x0000 0r 0x0001 (M.1)
 TSPC_HOGP_11_22	True		Read non-HID Service characteristic: Report
-					Reference characteristic descriptor (M)
-TSPC_HOGP_11_23	True		Read PnP ID characteristic (M)
-TSPC_HOGP_11_24	True		Notify Report characteristic (M)
-TSPC_HOGP_11_25	True		Notify Battery Level characteristic (M)
+					Reference characteristic descriptor
+					(M.1)
+TSPC_HOGP_11_23	True		Read PnP ID characteristic (M.1)
+TSPC_HOGP_11_24	True		Notify Report characteristic (M.1)
+TSPC_HOGP_11_25	True		Notify Battery Level characteristic (M.1)
 -------------------------------------------------------------------------------
+M.1: Mandatory if TSPC_HOGP_1_2 selected
 C.1: Mandatory to support if TSPC_HOGP_11_13 is supported, else excluded.
 -------------------------------------------------------------------------------
 
@@ -316,9 +325,9 @@ TSPC_HOGP_12_18	False (*)	Notify Battery Level characteristic (O)
 TSPC_HOGP_12_19	False (*)	Read PnP ID characteristic (O)
 -------------------------------------------------------------------------------
 M.1: Mandatory if TSPC_HOGP_1_3 selected
-C.1: Mandatory to support if TSPC_HOGP_12_5 or TSPC_HOGP_12_7 is supported,
+C.1: Mandatory to support if TSPC_HOGP_10_5 or TSPC_HOGP_10_7 is supported,
 	else excluded.
-C.2: Mandatory to support if TSPC_HOGP_12_8 is supported, else excluded.
+C.2: Mandatory to support if TSPC_HOGP_10_8 is supported, else excluded.
 -------------------------------------------------------------------------------
 
 
@@ -327,26 +336,22 @@ C.2: Mandatory to support if TSPC_HOGP_12_8 is supported, else excluded.
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
 TSPC_HOGP_13_1	True		Attribute Protocol supported over LE Transport
-				(M)
-TSPC_HOGP_13_2	True		Generic Attribute Profile Client (M)
-TSPC_HOGP_13_3	True		Discover All Primary Services (C.1)
-TSPC_HOGP_13_4	False (*)	Discover Primary Services by Service UUID (C.1)
-TSPC_HOGP_13_5	True		Find Included Services (M)
-TSPC_HOGP_13_6	True		Discover All Characteristics of a Service (C.2)
-TSPC_HOGP_13_7	False (*)	Discover Characteristics by UUID (C.2)
-TSPC_HOGP_13_8	True		Discover All Characteristic Descriptors (M)
-TSPC_HOGP_13_9	True		Read Characteristic Value (M)
-TSPC_HOGP_13_10	True		Read using Characteristic UUID (O)
-TSPC_HOGP_13_11	True		Read Long Characteristic Value (M)
-TSPC_HOGP_13_12	True		Read Characteristic Descriptors (M)
-TSPC_HOGP_13_13	True		Write without Response (M)
-TSPC_HOGP_13_14	True		Write Characteristic Value (M)
-TSPC_HOGP_13_15	True		Write Characteristic Descriptors (M)
-TSPC_HOGP_13_16	True		Notifications (M)
-TSPC_HOGP_13_17	True		Exchange MTU (M)
--------------------------------------------------------------------------------
-C.1: Mandatory to support at least one of these features.
-C.2: Mandatory to support at least one of these features.
+TSPC_HOGP_13_2	True		Generic Attribute Profile Client
+TSPC_HOGP_13_3	True		Discover All Primary Services
+TSPC_HOGP_13_4	False (*)	Discover Primary Services by Service UUID
+TSPC_HOGP_13_5	True		Find Included Services
+TSPC_HOGP_13_6	True		Discover All Characteristics of a Service
+TSPC_HOGP_13_7	False (*)	Discover Characteristics by UUID
+TSPC_HOGP_13_8	True		Discover All Characteristic Descriptors
+TSPC_HOGP_13_9	True		Read Characteristic Value
+TSPC_HOGP_13_10	True		Read using Characteristic UUID
+TSPC_HOGP_13_11	True		Read Long Characteristic Value
+TSPC_HOGP_13_12	True		Read Characteristic Descriptors
+TSPC_HOGP_13_13	True		Write without Response
+TSPC_HOGP_13_14	True		Write Characteristic Value
+TSPC_HOGP_13_15	True		Write Characteristic Descriptors
+TSPC_HOGP_13_16	True		Notifications
+TSPC_HOGP_13_17	True		Exchange MTU
 -------------------------------------------------------------------------------
 
 
@@ -355,23 +360,19 @@ C.2: Mandatory to support at least one of these features.
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
 TSPC_HOGP_14_1	False (*)	Attribute Protocol supported over LE Transport
-				(M.1)
-TSPC_HOGP_14_2	False (*)	Generic Attribute Profile Client (M.1)
-TSPC_HOGP_14_3	False (*)	Discover All Primary Services (C.1)
-TSPC_HOGP_14_4	False (*)	Discover Primary Services by Service UUID (C.1)
-TSPC_HOGP_14_5	False (*)	Discover All Characteristics of a Service (O)
-TSPC_HOGP_14_6	False (*)	Discover Characteristics by UUID (O)
-TSPC_HOGP_14_7	False (*)	Discover All Characteristic Descriptors (M.1)
-TSPC_HOGP_14_8	False (*)	Read Characteristic Value (M.1)
-TSPC_HOGP_14_9	False (*)	Read using Characteristic UUID (M.1)
-TSPC_HOGP_14_10	False (*)	Read Characteristic Descriptors (M.1)
-TSPC_HOGP_14_11	False (*)	Write without Response (M.1)
-TSPC_HOGP_14_12	False (*)	Write Characteristic Value (M.1)
-TSPC_HOGP_14_13	False (*)	Write Characteristic Descriptors (M.1)
-TSPC_HOGP_14_14	False (*)	Notifications (M.1)
--------------------------------------------------------------------------------
-M.1: Mandatory if TSPC_HOGP_1_3 selected
-C.1: Mandatory to support at least one of these features.
+TSPC_HOGP_14_2	False (*)	Generic Attribute Profile Client
+TSPC_HOGP_14_3	False (*)	Discover All Primary Services
+TSPC_HOGP_14_4	False (*)	Discover Primary Services by Service UUID
+TSPC_HOGP_14_5	False (*)	Discover All Characteristics of a Service
+TSPC_HOGP_14_6	False (*)	Discover Characteristics by UUID
+TSPC_HOGP_14_7	False (*)	Discover All Characteristic Descriptors
+TSPC_HOGP_14_8	False (*)	Read Characteristic Value
+TSPC_HOGP_14_9	False (*)	Read using Characteristic UUID
+TSPC_HOGP_14_10	False (*)	Read Characteristic Descriptors
+TSPC_HOGP_14_11	False (*)	Write without Response
+TSPC_HOGP_14_12	False (*)	Write Characteristic Value
+TSPC_HOGP_14_13	False (*)	Write Characteristic Descriptors
+TSPC_HOGP_14_14	False (*)	Notifications
 -------------------------------------------------------------------------------
 
 
@@ -379,8 +380,11 @@ C.1: Mandatory to support at least one of these features.
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_HOGP_15_1	True		Central (M)
-TSPC_HOGP_15_2	True		LE Security Mode 1 (central) (M)
+TSPC_HOGP_15_1	True		Central (M.1 or M.2)
+TSPC_HOGP_15_2	True		LE Security Mode 1 (central) (M.1 or M.2)
+-------------------------------------------------------------------------------
+M.1: Mandatory if TSPC_HOGP_1_2 selected
+M.2: Mandatory if TSPC_HOGP_1_3 selected
 -------------------------------------------------------------------------------
 
 
@@ -389,9 +393,9 @@ TSPC_HOGP_15_2	True		LE Security Mode 1 (central) (M)
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
 TSPC_HOGP_16_1	True		No Security Requirements (LE Security Level 1,
-					No Security) (M)
+					No Security)
 TSPC_HOGP_16_2	True		Unauthenticated no MITM protection (LE Security
-					Level 2, Just Works) (M)
+					Level 2, Just Works)
 TSPC_HOGP_16_3	True		Authenticated MITM protection (LE Security
-					Level 3, Passkey) (O)
+					Level 3, Passkey)
 -------------------------------------------------------------------------------
diff --git a/android/pixit-hogp.txt b/android/pixit-hogp.txt
index 4fe1e0f..067c280 100644
--- a/android/pixit-hogp.txt
+++ b/android/pixit-hogp.txt
@@ -1,6 +1,6 @@
 HOGP PIXIT for the PTS tool.
 
-PTS version: 5.1
+PTS version: 5.2
 
 * - different than PTS defaults
 & - should be set to IUT Bluetooth address
diff --git a/android/pts-hogp.txt b/android/pts-hogp.txt
index 9ab7872..19292d1 100644
--- a/android/pts-hogp.txt
+++ b/android/pts-hogp.txt
@@ -1,8 +1,8 @@
 PTS test results for HoG
 
-PTS version: 5.1
-Tested: 17-June-2014
-Android version: 4.4.2
+PTS version: 5.2
+Tested: 22-July-2014
+Android version: 4.4.4
 
 Results:
 PASS	test passed
-- 
1.9.3

