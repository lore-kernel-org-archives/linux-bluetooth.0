Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCH] android/pts: Update HID test results
Date: Tue, 19 May 2015 11:16:04 +0200
Message-Id: <1432026964-14205-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

PTS 6.1 and Android 5.1
---
 android/pics-hid.txt  | 63 +++++++++++++++++++++++++--------------------------
 android/pixit-hid.txt |  2 +-
 android/pts-hid.txt   |  7 +++---
 3 files changed, 35 insertions(+), 37 deletions(-)

diff --git a/android/pics-hid.txt b/android/pics-hid.txt
index ffd0aff..1304de4 100644
--- a/android/pics-hid.txt
+++ b/android/pics-hid.txt
@@ -1,6 +1,6 @@
 HID PICS for the PTS tool.
 
-PTS version: 6.0
+PTS version: 6.1
 
 * - different than PTS defaults
 # - not yet implemented/supported
@@ -24,13 +24,13 @@ O.1: It is Mandatory to support One of these roles.
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_HID_2_1	True (*)	Host: Establish HID connection (M.1)
-TSPC_HID_2_2	True (*)	Host: Accept HID connection (M.1)
-TSPC_HID_2_3	True (*)	Host: Terminate HID connection (M.1)
-TSPC_HID_2_4	True (*)	Host: Accept termination of HID connection (M.1)
-TSPC_HID_2_5	True (*)	Host: Support for virtual cables (M.1)
-TSPC_HID_2_6	True (*)	Host: HID initiated connection (M.1)
-TSPC_HID_2_7	True (*)	Host: Host initiated connection (M.1)
+TSPC_HID_2_1	True (*)	Host: Establish HID connection (C.4)
+TSPC_HID_2_2	True (*)	Host: Accept HID connection (C.4)
+TSPC_HID_2_3	True (*)	Host: Terminate HID connection (C.4)
+TSPC_HID_2_4	True (*)	Host: Accept termination of HID connection (C.4)
+TSPC_HID_2_5	True (*)	Host: Support for virtual cables (C.4)
+TSPC_HID_2_6	True (*)	Host: HID initiated connection (C.4)
+TSPC_HID_2_7	True (*)	Host: Host initiated connection (C.4)
 TSPC_HID_2_8	True (*)	Host: Host data transfer to HID (C.1)
 TSPC_HID_2_9	True (*)	Host: HID data transfer to Host (C.1)
 TSPC_HID_2_10	False		Host: Boot mode data transfer to Host (C.2)
@@ -44,11 +44,12 @@ TSPC_HID_2_14	False		Host : Support for sending HCI_CONTROL with
 TSPC_HID_2_15	False		Host : Support for receiving HCI_CONTROL with
 					VIRTUAL_CABLE_UNPLUG (C.3)
 -------------------------------------------------------------------------------
-M.1: Mandatory to support IF (TSPC_HID_1_1) supported.
-C.1: Optional for Boot Mode Only Hosts (TSPC_HID_1_3); otherwise Mandatory
-	for Host Role (TSPC_HID_1_1).
+C.1: Optional for Boot Mode Only Hosts (TSPC_HID_1_3); Mandatory for Host Role
+	(TSPC_HID_1_1); OTHERWISE Excluded.
 C.2: Mandatory for Boot Mode Only Hosts (TSPC_HID_1_3); otherwise Optional.
 C.3: Optional IF (TSPC_HID_2_5) supported, otherwise excluded.
+C.4: Mandatory IF TSPC_HID_1_1 (Host, Report protocol) is supported, otherwise
+	Optional.
 -------------------------------------------------------------------------------
 
 
@@ -57,15 +58,15 @@ C.3: Optional IF (TSPC_HID_2_5) supported, otherwise excluded.
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
 TSPC_HID_3_1	False		Host : Data reports larger than host MTU on
-					Control channel (C.1)
+					Control channel (O)
 TSPC_HID_3_2	True (*)	Host : Data reports larger than host MTU on
 					Interrupt channel (C.1)
-TSPC_HID_3_3	True (*)	Host : Data reports to host (C.2)
-TSPC_HID_3_4	False		Host : Boot mode reports to host (O)
+TSPC_HID_3_3	True (*)	Host : Data reports to host (C.1)
+TSPC_HID_3_4	False		Host : Boot mode reports to host (C.2)
 -------------------------------------------------------------------------------
-C.1: Excluded for Boot Mode Only Hosts (TSPC_HID_1_3); otherwise Optional
-C.2: Excluded for Boot Mode Only Hosts (TSPC_HID_1_3); otherwise Mandatory for
-	Host Role (TSPC_HID_1_1)
+C.1: Excluded for Boot Mode Only Hosts (TSPC_HID_1_3); Mandatory IF
+	TSPC_HID_2_12 is supported, otherwise Optional.
+C.2: Mandatory IF TSPC_HID_1_3 is supported, otherwise Optional.
 -------------------------------------------------------------------------------
 
 
@@ -97,9 +98,8 @@ TSPC_HID_5_4	False		Host : Get_Idle command (O)
 TSPC_HID_5_5	False		Host : Set_Report command (C.2)
 TSPC_HID_5_6	False		Host : Get_Report command (C.3)
 -------------------------------------------------------------------------------
-C.2: Mandatory IF (TSPC_HID_1_1) supported AND (TSPC_HID_2_13) supported.
 C.1: Mandatory for Boot Mode Only Hosts (TSPC_HID_1_3); otherwise Optional.
-	If either Set_Protocol or Get_Protocol supported, both are Mandatory.
+C.2: Mandatory IF (TSPC_HID_1_1) supported AND (TSPC_HID_2_13) supported.
 C.3: Mandatory IF (TSPC_HID_1_1) Supported AND (TSPC_HID_2_12) Supported
 C.4: Mandatory to support TSPC_HID_5_1 (Set_Protocol command) AND TSPC_HID_5_2
 	(Get_Protocol command) IF one of TSPC_HID_5_1 (Set_Protocol command)
@@ -123,19 +123,19 @@ TSPC_HID_6_4	False		Host : Initiate pairing after connection
 TSPC_HID_6_5	False		Host : Encryption (O)
 TSPC_HID_6_6	False		Host : Initiate encryption (C.3)
 TSPC_HID_6_7	False		Host : Accept encryption requests (C.3)
-TSPC_HID_6_8	True (*)	Host : Role switch (Master/Slave) (M.1)
-TSPC_HID_6_9	True (*)	Host : Request Master Slave switch (M.1)
-TSPC_HID_6_10	True (*)	Host : Accept Master Slave switch requests (M.1)
+TSPC_HID_6_8	True (*)	Host : Role switch (Master/Slave) (C.4)
+TSPC_HID_6_9	True (*)	Host : Request Master Slave switch (C.4)
+TSPC_HID_6_10	True (*)	Host : Accept Master Slave switch requests (C.4)
 TSPC_HID_6_11	False		Host : Hold mode (O)
-TSPC_HID_6_12	True (*)	Host : Sniff mode (M.1)
+TSPC_HID_6_12	True (*)	Host : Sniff mode (C.4)
 TSPC_HID_6_13	False		Host : Park mode (O)
 -------------------------------------------------------------------------------
-C.1: If Host Authentication supported, both (TSPC_HID_6_1) AND (TSPC_HID_6_2)
-	must be supported.
+C.1: Mandatory to support TSPC_HID_6_1 AND TSPC_HID_6_2 IF GAP 2/3 
+	(Initiate LMP-Authentication) is supported, otherwise Excluded.
 C.2: If Pairing supported both (TSPC_HID_6_3) AND (TSPC_HID_6_4) must
 	be supported.
-M.1: Mandatory IF (TSPC_HID_1_1) supported.
 C.3: Mandatory IF (TSPC_HID_6_5) encryption supported.
+C.4: Mandatory IF (TSPC_HID_1_1) supported, otherwise Excluded.
 -------------------------------------------------------------------------------
 
 
@@ -143,10 +143,10 @@ C.3: Mandatory IF (TSPC_HID_6_5) encryption supported.
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_HID_7_1	True (*)	Host : Supports inquiry, 79 channel (M.1)
+TSPC_HID_7_1	True (*)	Host : Supports inquiry, 79 channel (C.1)
 TSPC_HID_7_2	False		Host : Supports inquiry scan, 79 channel (C.2)
 -------------------------------------------------------------------------------
-M.1: Mandatory to support IF (TSPC_HID_1_1) supported.
+C.1: Mandatory to support IF (TSPC_HID_1_1) supported, otherwise Excluded.
 C.2: Feature should not be used by a Host, but can be supported in LM.
 -------------------------------------------------------------------------------
 
@@ -170,9 +170,9 @@ O.1: It is Mandatory to support One of these roles IF (TSPC_HID_1_2)
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
 TSPC_HID_9_1	False		Hid : Establish HID connection (O)
-TSPC_HID_9_2	False (*)	Hid : Accept HID connection (M.1)
+TSPC_HID_9_2	False (*)	Hid : Accept HID connection (M)
 TSPC_HID_9_3	False		Hid : Terminate HID connection (O)
-TSPC_HID_9_4	False (*)	Hid : Accept Termination of HID connection (M.1)
+TSPC_HID_9_4	False (*)	Hid : Accept Termination of HID connection (M)
 TSPC_HID_9_5	False		Hid : Support for virtual cables (O)
 TSPC_HID_9_6	False		Hid : HID initiated reconnection (C.1)
 TSPC_HID_9_7	False		Hid : Host initiated reconnection (C.1)
@@ -188,10 +188,9 @@ TSPC_HID_9_15	False		Hid : Support for sending HCI_CONTROL with
 TSPC_HID_9_16	False		Hid : Support for receiving HCI_CONTROL with
 					VIRTUAL_CABLE_UNPLUG (C.5)
 -------------------------------------------------------------------------------
-M.1: Mandatory IF (TSPC_HID_1_2) supported.
 C.1: One of these is Mandatory IF (TSPC_HID_9_5) is supported
 	(SDP attribute 0x204=True)
-C.2: One of these is Mandatory.
+C.2: One of these is Mandatory if TSPC_HID_1_2 (HID Role) is supported.
 C.3: Mandatory IF (TSPC_HID_8_1) OR (TSPC_HID_8_2) is selected
 C.4: Mandatory IF (TSPC_HID_8_2) is supported (for status indicators)
 C.5: Optional IF (TSPC_HID_9_5) supported, otherwise excluded.
diff --git a/android/pixit-hid.txt b/android/pixit-hid.txt
index 3c93fca..511957b 100644
--- a/android/pixit-hid.txt
+++ b/android/pixit-hid.txt
@@ -1,6 +1,6 @@
 HID PIXIT for the PTS tool.
 
-PTS version: 6.0
+PTS version: 6.1
 
 * - different than PTS defaults
 & - should be set to IUT Bluetooth address
diff --git a/android/pts-hid.txt b/android/pts-hid.txt
index 7918650..80f11e8 100644
--- a/android/pts-hid.txt
+++ b/android/pts-hid.txt
@@ -1,8 +1,8 @@
 PTS test results for HID
 
-PTS version: 6.0
-Tested: 30-January-2015
-Android version: 5.0
+PTS version: 6.1
+Tested: 19-May-2015
+Android version: 5.1
 
 Results:
 PASS	test passed
@@ -14,7 +14,6 @@ N/A	test is disabled due to PICS setup
 Test Name		Result	Notes
 -------------------------------------------------------------------------------
 TC_HOS_HCE_BV_01_I	PASS
-TC_HOS_HCE_BV_02_I	PASS
 TC_HOS_HCE_BV_03_I	PASS
 TC_HOS_HCE_BV_04_I	PASS
 TC_HOS_HCR_BV_01_I	PASS
-- 
1.9.1

