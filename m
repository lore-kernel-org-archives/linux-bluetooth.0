Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Android/pts: Update PTS files for HID
Date: Fri, 18 Jul 2014 13:59:56 +0200
Message-Id: <1405684796-1902-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

PICS and PIXITs updated to PTS 5.2. Regression done for Android
4.4.4.
---
 android/pics-hid.txt  | 83 +++++++++++++++++++++++++++------------------------
 android/pixit-hid.txt |  2 +-
 android/pts-hid.txt   |  4 +--
 3 files changed, 47 insertions(+), 42 deletions(-)

diff --git a/android/pics-hid.txt b/android/pics-hid.txt
index f1645cc..3ed4e73 100644
--- a/android/pics-hid.txt
+++ b/android/pics-hid.txt
@@ -1,6 +1,6 @@
 HID PICS for the PTS tool.
 
-PTS version: 5.1
+PTS version: 5.2
 
 * - different than PTS defaults
 # - not yet implemented/supported
@@ -24,15 +24,15 @@ O.1: It is Mandatory to support One of these roles.
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_HID_2_1	True		Host: Establish HID connection (M.1)
-TSPC_HID_2_2	True		Host: Accept HID connection (M.1)
-TSPC_HID_2_3	True		Host: Terminate HID connection (M.1)
-TSPC_HID_2_4	True		Host: Accept termination of HID connection (M.1)
-TSPC_HID_2_5	True		Host: Support for virtual cables (M.1)
-TSPC_HID_2_6	True		Host: HID initiated connection (M.1)
-TSPC_HID_2_7	True		Host: Host initiated connection (M.1)
-TSPC_HID_2_8	True		Host: Host data transfer to HID (C.1)
-TSPC_HID_2_9	True		Host: HID data transfer to Host (C.1)
+TSPC_HID_2_1	True (*)	Host: Establish HID connection (M.1)
+TSPC_HID_2_2	True (*)	Host: Accept HID connection (M.1)
+TSPC_HID_2_3	True (*)	Host: Terminate HID connection (M.1)
+TSPC_HID_2_4	True (*)	Host: Accept termination of HID connection (M.1)
+TSPC_HID_2_5	True (*)	Host: Support for virtual cables (M.1)
+TSPC_HID_2_6	True (*)	Host: HID initiated connection (M.1)
+TSPC_HID_2_7	True (*)	Host: Host initiated connection (M.1)
+TSPC_HID_2_8	True (*)	Host: Host data transfer to HID (C.1)
+TSPC_HID_2_9	True (*)	Host: HID data transfer to Host (C.1)
 TSPC_HID_2_10	False		Host: Boot mode data transfer to Host (C.2)
 TSPC_HID_2_11	False		Host : Boot mode data transfer to HID (C.2)
 TSPC_HID_2_12	False		Host : Support for Application to send
@@ -42,7 +42,7 @@ TSPC_HID_2_13	False		Host : Support for Application to send
 TSPC_HID_2_14	False		Host : Support for sending HCI_CONTROL with
 					VIRTUAL_CABLE_UNPLUG (C.3)
 TSPC_HID_2_15	False		Host : Support for receiving HCI_CONTROL with
-					VIRTUAL_CABLE_UNPLUG (C.2)
+					VIRTUAL_CABLE_UNPLUG (C.3)
 -------------------------------------------------------------------------------
 M.1: Mandatory to support IF (TSPC_HID_1_1) supported.
 C.1: Optional for Boot Mode Only Hosts (TSPC_HID_1_3); otherwise Mandatory
@@ -57,15 +57,15 @@ C.3: Optional IF (TSPC_HID_2_5) supported, otherwise excluded.
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
 TSPC_HID_3_1	False		Host : Data reports larger than host MTU on
-					Control channel (O)
+					Control channel (C.1)
 TSPC_HID_3_2	True (*)	Host : Data reports larger than host MTU on
 					Interrupt channel (C.1)
-TSPC_HID_3_3	True (*)	Host : Data reports to host (C.1)
-TSPC_HID_3_4	False		Host : Boot mode reports to host (C.2)
+TSPC_HID_3_3	True (*)	Host : Data reports to host (C.2)
+TSPC_HID_3_4	False		Host : Boot mode reports to host (O)
 -------------------------------------------------------------------------------
-C.1: Excluded for Boot Mode Only Hosts (TSPC_HID_1_3); otherwise Mandatory if
-	(TSPC_HID_2_12), otherwise Optional.
-C.2: Mandatory for Boot Mode Only Hosts (TSPC_HID_1_3); otherwise Optional.
+C.1: Excluded for Boot Mode Only Hosts (TSPC_HID_1_3); otherwise Optional
+C.2: Excluded for Boot Mode Only Hosts (TSPC_HID_1_3); otherwise Mandatory for
+	Host Role (TSPC_HID_1_1)
 -------------------------------------------------------------------------------
 
 
@@ -90,17 +90,21 @@ C.2: Excluded for Boot Mode Only Hosts (TSPC_HID_1_3); otherwise Mandatory for
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_HID_5_1	False		Host : Set_Protocol command (C.1)
-TSPC_HID_5_2	False		Host : Get_Protocol command (C.1)
+TSPC_HID_5_1	False		Host : Set_Protocol command (C.1, C.4)
+TSPC_HID_5_2	False		Host : Get_Protocol command (C.1, C.4)
 TSPC_HID_5_3	False		Host : Set_Idle command (O)
 TSPC_HID_5_4	False		Host : Get_Idle command (O)
-TSPC_HID_5_5	False (*)	Host : Set_Report command (M.1)
-TSPC_HID_5_6	False (*)	Host : Get_Report command (M.2)
+TSPC_HID_5_5	False		Host : Set_Report command (C.2)
+TSPC_HID_5_6	False		Host : Get_Report command (C.3)
 -------------------------------------------------------------------------------
-M.1: Mandatory IF (TSPC_HID_1_1) supported AND (TSPC_HID_2_13) supported.
+C.2: Mandatory IF (TSPC_HID_1_1) supported AND (TSPC_HID_2_13) supported.
 C.1: Mandatory for Boot Mode Only Hosts (TSPC_HID_1_3); otherwise Optional.
 	If either Set_Protocol or Get_Protocol supported, both are Mandatory.
-M.2: Mandatory IF (TSPC_HID_1_1) Supported AND (TSPC_HID_2_12) Supported
+C.3: Mandatory IF (TSPC_HID_1_1) Supported AND (TSPC_HID_2_12) Supported
+C.4: Mandatory to support TSPC_HID_5_1 (Set_Protocol command) AND TSPC_HID_5_2
+	(Get_Protocol command) IF one of TSPC_HID_5_1 (Set_Protocol command)
+	OR TSPC_HID_5_2 (Get_Protocol command) is supported, otherwise
+	Excluded.
 -------------------------------------------------------------------------------
 
 
@@ -119,11 +123,11 @@ TSPC_HID_6_4	False		Host : Initiate pairing after connection
 TSPC_HID_6_5	False		Host : Encryption (O)
 TSPC_HID_6_6	False		Host : Initiate encryption (C.3)
 TSPC_HID_6_7	False		Host : Accept encryption requests (C.3)
-TSPC_HID_6_8	True		Host : Role switch (Master/Slave) (M.1)
-TSPC_HID_6_9	True		Host : Request Master Slave switch (M.1)
-TSPC_HID_6_10	True		Host : Accept Master Slave switch requests (M.1)
+TSPC_HID_6_8	True (*)	Host : Role switch (Master/Slave) (M.1)
+TSPC_HID_6_9	True (*)	Host : Request Master Slave switch (M.1)
+TSPC_HID_6_10	True (*)	Host : Accept Master Slave switch requests (M.1)
 TSPC_HID_6_11	False		Host : Hold mode (O)
-TSPC_HID_6_12	True		Host : Sniff mode (M.1)
+TSPC_HID_6_12	True (*)	Host : Sniff mode (M.1)
 TSPC_HID_6_13	False		Host : Park mode (O)
 -------------------------------------------------------------------------------
 C.1: If Host Authentication supported, both (TSPC_HID_6_1) AND (TSPC_HID_6_2)
@@ -139,11 +143,11 @@ C.3: Mandatory IF (TSPC_HID_6_5) encryption supported.
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_HID_7_1	True		Host : Supports inquiry, 79 channel (M.1)
-TSPC_HID_7_2	False (*)	Host : Supports inquiry scan, 79 channel (X)
+TSPC_HID_7_1	True (*)	Host : Supports inquiry, 79 channel (M.1)
+TSPC_HID_7_2	False		Host : Supports inquiry scan, 79 channel (C.2)
 -------------------------------------------------------------------------------
 M.1: Mandatory to support IF (TSPC_HID_1_1) supported.
-X: Feature should not be used by a Host, but can be supported in LM.
+C.2: Feature should not be used by a Host, but can be supported in LM.
 -------------------------------------------------------------------------------
 
 
@@ -190,7 +194,7 @@ C.1: One of these is Mandatory IF (TSPC_HID_9_5) is supported
 C.2: One of these is Mandatory.
 C.3: Mandatory IF (TSPC_HID_8_1) OR (TSPC_HID_8_2) is selected
 C.4: Mandatory IF (TSPC_HID_8_2) is supported (for status indicators)
-C.5: Optional IF (TSPC_HID_9_2) supported, otherwise excluded.
+C.5: Optional IF (TSPC_HID_9_5) supported, otherwise excluded.
 -------------------------------------------------------------------------------
 
 
@@ -229,8 +233,8 @@ C.1: Mandatory IF (TSPC_HID_8_2) is supported. Optional for other HIDs.
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_HID_12_1	False		Hid : Set_Protocol command (C.1)
-TSPC_HID_12_2	False		Hid : Get_Protocol command (C.1)
+TSPC_HID_12_1	False		Hid : Set_Protocol command (C.1, C.5)
+TSPC_HID_12_2	False		Hid : Get_Protocol command (C.1, C.5)
 TSPC_HID_12_3	False		Hid : Set_Idle command (C.2)
 TSPC_HID_12_4	False		Hid : Get_Idle command (C.2)
 TSPC_HID_12_5	False		Hid : Set_Report command (C.3)
@@ -242,6 +246,10 @@ C.1: Mandatory IF (TSPC_HID_8_1) OR (TSPC_HID_8_2) is supported.
 C.2: Mandatory IF (TSPC_HID_8_2) Keyboard is selected. Optional for other HIDs.
 C.3: Mandatory IF (TSPC_HID_9_12) or (TSPC_HID_9_14) supported.
 C.4: Mandatory IF (TSPC_HID_9_13) or (TSPC_HID_9_14) supported
+C.5: If either TSPC_HID_12_1 (Set_Protocol command) OR TSPC_HID_12_2
+	(Get_Protocol command) is supported, both TSPC_HID_12_1
+	(Set_Protocol command) AND TSPC_HID_12_2 (Get_Protocol command) are
+	Mandatory to support
 -------------------------------------------------------------------------------
 
 
@@ -253,10 +261,8 @@ TSPC_HID_13_1	False		Hid : Host initiated Authentication before
 					connection completed (C.1)
 TSPC_HID_13_2	False		Hid : Host initiated Authentication after
 					connection completed (C.1)
-TSPC_HID_13_3	False		Hid : Initiate pairing before connection
-					completed (X)
-TSPC_HID_13_4	False		Hid : Initiate pairing after connection
-					completed (X)
+TSPC_HID_13_3	False		Hid : Item no longer used (N/A)
+TSPC_HID_13_4	False		Hid : Item no longer used (N/A)
 TSPC_HID_13_5	False		Hid : Encryption (C.1)
 TSPC_HID_13_6	False		Hid : Initiate encryption (O)
 TSPC_HID_13_7	False		Hid : Accept encryption requests (C.2)
@@ -271,7 +277,6 @@ C.1: Mandatory IF (TSPC_HID_8_2) OR (TSPC_HID_8_3) is selected. Optional
 	for other HIDs.
 C.2: Mandatory IF (TSPC_HID_13_5) supported.
 C.3: Mandatory IF (TSPC_HID_9_6) is supported.
-X: Feature should not be used by a HID device, but can be supported in LM.
 -------------------------------------------------------------------------------
 
 
@@ -280,7 +285,7 @@ X: Feature should not be used by a HID device, but can be supported in LM.
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
 TSPC_HID_14_1	False		Hid : Supports inquiry, 79 channel (O)
-TSPC_HID_14_2	False (*)	Hid : Supports inquiry scan, 79 channel (M.1)
+TSPC_HID_14_2	False		Hid : Supports inquiry scan, 79 channel (M.1)
 TSPC_ALL	False		Enables all test cases when set to true.
 -------------------------------------------------------------------------------
 M.1: Mandatory IF (TSPC_HID_1_2) is supported.
diff --git a/android/pixit-hid.txt b/android/pixit-hid.txt
index 44e4363..3c54abf 100644
--- a/android/pixit-hid.txt
+++ b/android/pixit-hid.txt
@@ -1,6 +1,6 @@
 HID PIXIT for the PTS tool.
 
-PTS version: 5.1
+PTS version: 5.2
 
 * - different than PTS defaults
 & - should be set to IUT Bluetooth address
diff --git a/android/pts-hid.txt b/android/pts-hid.txt
index a7990e1..16c9aec 100644
--- a/android/pts-hid.txt
+++ b/android/pts-hid.txt
@@ -1,7 +1,7 @@
 PTS test results for HID
 
-PTS version: 5.1
-Tested: 07-April-2014
+PTS version: 5.2
+Tested: 18-July-2014
 
 Results:
 PASS	test passed
-- 
1.9.3

