Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCH 2/2] android/pts: Update GATT PIXIT, PICS for PTS 6.0
Date: Wed, 11 Feb 2015 14:28:12 +0100
Message-Id: <1423661292-16660-2-git-send-email-mariusz.skamra@tieto.com>
In-Reply-To: <1423661292-16660-1-git-send-email-mariusz.skamra@tieto.com>
References: <1423661292-16660-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pics-gatt.txt  | 27 ++++++++++++++++++++-------
 android/pixit-gatt.txt |  1 +
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/android/pics-gatt.txt b/android/pics-gatt.txt
index 6ff9c55..b404798 100644
--- a/android/pics-gatt.txt
+++ b/android/pics-gatt.txt
@@ -1,6 +1,6 @@
 GATT PICS for the PTS tool.
 
-PTS version: 5.3
+PTS version: 6.0.1
 
 * - different than PTS defaults
 
@@ -13,8 +13,8 @@ Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
 TSPC_GATT_1_1	True		Generic Attribute Profile Client (C.1)
 TSPC_GATT_1_2	True		Generic Attribute Profile Server (C.2)
-TSPC_GATT_1A_1	True		Complete GATT client (C.3)
-TSPC_GATT_1A_2	True		Complete GATT server (C.4)
+TSPC_GATT_1_3	True		Complete GATT client (C.3)
+TSPC_GATT_1_4	True		Complete GATT server (C.4)
 -------------------------------------------------------------------------------
 C.1: Optional to support IF TSPC_GATT_2_2; else IF TSPC_GATT_2_1 it is mandatory
 	to support at least one of TSPC_GATT_1_1 OR TSPC_GATT_1_2
@@ -45,7 +45,7 @@ C.2: Mandatory IF (SUM ICS 12/7 OR SUM ICS 12/9) is supported, otherwise
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_GATT_3_1	True		Client: Exchange MTU (C.1)
+TSPC_GATT_3_1	True		Client: Exchange MTU (C.2)
 TSPC_GATT_3_2	True		Client: Discover All Primary Services (C.1)
 TSPC_GATT_3_3	True		Client: Discover Primary Services Service
 					UUID (C.1)
@@ -118,7 +118,9 @@ TSPC_GATT_3B_36	True		Client: Characteristic Format: utf8s (M)
 TSPC_GATT_3B_37	True		Client: Characteristic Format: utf16s (M)
 TSPC_GATT_3B_38	True		Client: Characteristic Format: struct (M)
 -------------------------------------------------------------------------------
-C.1: Mandatory IF TSPC_GATT_1A_1 is supported, otherwise Optional
+C.1: Mandatory IF TSPC_GATT_1_3 is supported, otherwise Optional
+C.2: Mandatory IF TSPC_GATT_1_3 AND TSPC_GATT_2_2 is supported, otherwise
+	Excluded
 -------------------------------------------------------------------------------
 
 
@@ -162,7 +164,7 @@ C.1: Mandatory IF service definitions on the server can be added, changed, or
 	removed, otherwise Optional
 C.2: Mandatory IF GATT TSPC_GATT_4_13 is supported, otherwise Optional
 C.3: Mandatory IF GATT TSPC_GATT_4_15 is supported, otherwise Optional
-C.4: Mandatory IF GATT TSPC_GATT_1A_2 is supported, otherwise Optional
+C.4: Mandatory IF GATT TSPC_GATT_1_4 is supported, otherwise Optional
 -------------------------------------------------------------------------------
 
 
@@ -246,6 +248,15 @@ C.2: Optional IF TSPC_GATT_2_2 is supported, otherwise Excluded
 -------------------------------------------------------------------------------
 
 
+                Attribute Protocol Client Messages
+-------------------------------------------------------------------------------
+Parameter Name  Selected        Description
+-------------------------------------------------------------------------------
+TSPC_GATT_8_1    True            Support for Multiple ATT bearers from same
+	device (O)
+-------------------------------------------------------------------------------
+
+
 		Attribute Protocol Client Messages
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
@@ -266,6 +277,7 @@ TSPC_ATT_3_21	True		Signed Write Command (O)
 TSPC_ATT_3_22	True		Prepare Write Request (O)
 TSPC_ATT_3_24	True		Execute Write Request (C.8)
 TSPC_ATT_3_26	True		Handle Value Notification (M)
+TSPC_ATT_3_28	True		Handle Value Confirmation (M)
 -------------------------------------------------------------------------------
 C.6: Mandatory IF TSPC_ATT_3_16 is supported, otherwise Excluded
 C.8: Mandatory IF TSPC_ATT_3_22 is supported, otherwise Excluded
@@ -288,8 +300,9 @@ TSPC_ATT_4_19	True		Write Response (C.3)
 TSPC_ATT_4_20	True		Write Command (O)
 TSPC_ATT_4_21	True		Signed Write Command (O)
 TSPC_ATT_4_23	True		Prepare Write Response (C.4)
-TSPC_ATT_4_25	True		Execute Write Response (C.5)
+TSPC_ATT_4_25	True		Execute Write Response (C.4)
 TSPC_ATT_4_26	True		Handle Value Notification (O)
+TSPC_ATT_4_27	True		Handle Value Indication	(O)
 -------------------------------------------------------------------------------
 C.2: Mandatory IF TSPC_ATT_4_14 is supported, otherwise Excluded
 C.3: Mandatory IF TSPC_ATT_4_18 is supported, otherwise Excluded
diff --git a/android/pixit-gatt.txt b/android/pixit-gatt.txt
index 191e2c9..5699999 100644
--- a/android/pixit-gatt.txt
+++ b/android/pixit-gatt.txt
@@ -28,4 +28,5 @@ TSPX_use_dynamic_pin					FALSE
 TSPX_delete_ltk						FALSE
 TSPX_characteristic_readable				FALSE
 TSPX_tester_appearance					0000
+TSPX_iut_use_resolvable_random_access			FALSE
 -------------------------------------------------------------------------------
-- 
1.9.1

