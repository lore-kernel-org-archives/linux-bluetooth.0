Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] android/pts: Update AVRCP pics, pixits for PTS 6.0
Date: Wed, 21 Jan 2015 16:35:43 +0100
Message-Id: <1421854544-17726-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch updates pics and pixits for PTS 6.0
---
 android/pics-avrcp.txt  | 317 +++++++++++++++++++++++++-----------------------
 android/pixit-avrcp.txt |   4 +-
 2 files changed, 165 insertions(+), 156 deletions(-)

diff --git a/android/pics-avrcp.txt b/android/pics-avrcp.txt
index da72fe1..a25579e 100644
--- a/android/pics-avrcp.txt
+++ b/android/pics-avrcp.txt
@@ -1,6 +1,6 @@
 AVRCP PICS for the PTS tool.
 
-PTS version: 5.3
+PTS version: 6.0
 
 * - different than PTS defaults
 # - not yet implemented/supported
@@ -24,12 +24,14 @@ C.1: Mandatory to support at least one of the defined roles.
 Parameter Name    Selected	Description
 -------------------------------------------------------------------------------
 TSPC_AVRCP_2_1    False (*)	CT: Initiating connection establishment (M)
-TSPC_AVRCP_2_2    False (*)	CT: Accepting connection establishment (M)
+TSPC_AVRCP_2_2    False (*)	CT: Accepting connection establishment for
+						control initiated by TG (M)
 TSPC_AVRCP_2_3    False (*)	CT: Initiating connection release (M)
-TSPC_AVRCP_2_4    False (*)	CT: Accepting connection release (M)
+TSPC_AVRCP_2_4    False (*)	CT: Accepting connection release for control
+							initiated by TG (M)
 TSPC_AVRCP_2_5    False		CT: Sending UNIT INFO (O)
 TSPC_AVRCP_2_6    False		CT: Sending SUBUNIT INFO (O)
-TSPC_AVRCP_2_7    False	CT: Sending PASS THROUGH command category 1
+TSPC_AVRCP_2_7    False		CT: Sending PASS THROUGH command category 1
 					(C.1)
 TSPC_AVRCP_2_8    False		CT: Sending PASS THROUGH command category 2
 					(C.1)
@@ -45,8 +47,9 @@ TSPC_AVRCP_2_14   False		CT: Get Current Player Application Setting
 					(C.10)
 TSPC_AVRCP_2_15   False		CT: Set Player Application Setting Value (C.10)
 TSPC_AVRCP_2_16   False		CT: Get Player Application Setting
-						Attribute (O)
-TSPC_AVRCP_2_17   False		CT: Get Player Application Setting Value (O)
+						Attribute Text (O)
+TSPC_AVRCP_2_17   False		CT: Get Player Application Setting Value Text
+					(O)
 TSPC_AVRCP_2_18   False		CT: Inform Displayable Character Set (O)
 TSPC_AVRCP_2_19   False		CT: Inform Battery Status of CT (O)
 TSPC_AVRCP_2_20   False		CT: Get Element Attributes (O)
@@ -89,14 +92,14 @@ TSPC_AVRCP_2_52   False (*)	CT: Discoverable Mode (M)
 TSPC_AVRCP_2_53   False		CT: PASSTHROUGH operation supporting press
 					and hold (O)
 TSPC_AVRCP_2_54   False		CT: Cover Art (O)
-TSPC_AVRCP_2_55   False		CT: GetCapabilities, Cover Art (C.10)
-TSPC_AVRCP_2_56   False		CT: GetImageProperties, Cover Art (C.10)
-TSPC_AVRCP_2_57   False		CT: GetImage, Cover Art (C.9)
-TSPC_AVRCP_2_58   False		CT: GetLinkedThumbnail, CoverArt (C.9)
+TSPC_AVRCP_2_55   False		CT: GetImageProperties (C.14)
+TSPC_AVRCP_2_56   False		CT: GetImage (C.13)
+TSPC_AVRCP_2_57   False		CT: GetLinkedThumbnail (C.13)
 -------------------------------------------------------------------------------
 C.1: Mandatory to support at least one of the defined categories
 	(TSPC_AVRCP_2_7 through TSPC_AVRCP_2_10).
-C.2: Mandatory if TSPC_AVRCP_2_20 is supported, otherwise Optional.
+C.2: Mandatory to support at least one of TSPC_AVRCP_2_23 or TSPC_AVRC_2_24
+			if TSPC_AVRCP_2_20 is supported, otherwise Optional.
 C.3: Mandatory if TSPC_AVRCP_2_8 is supported, otherwise Excluded.
 C.4: Mandatory if TSPC_AVRCP_2_32 is supported, otherwise Excluded.
 C.5: Mandatory if TSPC_AVRCP_2_27 is supported, otherwise Excluded.
@@ -112,12 +115,15 @@ C.10: Mandatory to support either Get or Set Player Application Settings
 	or TSPC_AVRCP_2_15 must be supported if Player Application Settings
 	feature is supported, in accordance with Player Application Settings
 	support requirements.
-C.11: Mandatory if TSPC_AVRCP_2_7 or (TSPC_AVRCP_2_8 AND TSPC_AVRCP_2_49)
-	or TSPC_AVRCP_2_9 is supported, otherwise Optional.
+C.11: Mandatory if TSPC_AVRCP_2_20 or TSPC_AVRCP_2_49 is supported, otherwise
+	Optional.
 C.12: Mandatory if Basic Group Navigation Feature supported. If any item
 	TSPC_AVRCP_2_25 or TSPC_AVRCP_2_26 is supported it is mandatory to
 	support both, in accordance with Basic Group Navigation support
 	requirements, otherwise Excluded.
+C.13: Mandatory to support at least one of the functions if TSPC_AVRCP_2_54
+	(Cover Art) is support, otherwise Excluded.
+C.14: Optional if TSPC_AVRCP_2_54 (Cover Art) is supported, otherwise Excluded.
 -------------------------------------------------------------------------------
 
 
@@ -177,7 +183,6 @@ TSPC_AVRCP_3_30   False		CT: category 1 - Operation id: F1 (C.1)
 TSPC_AVRCP_3_31   False		CT: category 1 - Operation id: F2 (C.1)
 TSPC_AVRCP_3_32   False		CT: category 1 - Operation id: F3 (C.1)
 TSPC_AVRCP_3_33   False		CT: category 1 - Operation id: F4 (C.1)
-TSPC_AVRCP_3_33a  False		CT: category 1 - Operation id: F5 (C.1)
 TSPC_AVRCP_3_34   False		CT: category 1 - Operation id: vendor_unique
 					(C.1)
 -------------------------------------------------------------------------------
@@ -190,39 +195,38 @@ C.1: Mandatory to support at least one of these operation_ids if the device
 -------------------------------------------------------------------------------
 Parameter Name    Selected	Description
 -------------------------------------------------------------------------------
-TSPC_AVRCP_4_1    False		CT: category 2 - Operation id: 0 (C.2)
-TSPC_AVRCP_4_2    False		CT: category 2 - Operation id: 1 (C.2)
-TSPC_AVRCP_4_3    False		CT: category 2 - Operation id: 2 (C.2)
-TSPC_AVRCP_4_4    False		CT: category 2 - Operation id: 3 (C.2)
-TSPC_AVRCP_4_5    False		CT: category 2 - Operation id: 4 (C.2)
-TSPC_AVRCP_4_6    False		CT: category 2 - Operation id: 5 (C.2)
-TSPC_AVRCP_4_7    False		CT: category 2 - Operation id: 6 (C.2)
-TSPC_AVRCP_4_8    False		CT: category 2 - Operation id: 7 (C.2)
-TSPC_AVRCP_4_9    False		CT: category 2 - Operation id: 8 (C.2)
-TSPC_AVRCP_4_10   False		CT: category 2 - Operation id: 9 (C.2)
-TSPC_AVRCP_4_11   False		CT: category 2 - Operation id: dot (C.2)
-TSPC_AVRCP_4_12   False		CT: category 2 - Operation id: enter (C.2)
-TSPC_AVRCP_4_13   False		CT: category 2 - Operation id: clear (C.2)
+TSPC_AVRCP_4_1    False		CT: category 2 - Operation id: 0 (C.1)
+TSPC_AVRCP_4_2    False		CT: category 2 - Operation id: 1 (C.1)
+TSPC_AVRCP_4_3    False		CT: category 2 - Operation id: 2 (C.1)
+TSPC_AVRCP_4_4    False		CT: category 2 - Operation id: 3 (C.1)
+TSPC_AVRCP_4_5    False		CT: category 2 - Operation id: 4 (C.1)
+TSPC_AVRCP_4_6    False		CT: category 2 - Operation id: 5 (C.1)
+TSPC_AVRCP_4_7    False		CT: category 2 - Operation id: 6 (C.1)
+TSPC_AVRCP_4_8    False		CT: category 2 - Operation id: 7 (C.1)
+TSPC_AVRCP_4_9    False		CT: category 2 - Operation id: 8 (C.1)
+TSPC_AVRCP_4_10   False		CT: category 2 - Operation id: 9 (C.1)
+TSPC_AVRCP_4_11   False		CT: category 2 - Operation id: dot (C.1)
+TSPC_AVRCP_4_12   False		CT: category 2 - Operation id: enter (C.1)
+TSPC_AVRCP_4_13   False		CT: category 2 - Operation id: clear (C.1)
 TSPC_AVRCP_4_14   False		CT: category 2 - Operation id: sound_select
-					(C.2)
+					(C.1)
 TSPC_AVRCP_4_15   False		CT: category 2 - Operation id: input_select
-					(C.2)
+					(C.1)
 TSPC_AVRCP_4_16   False		CT: category 2 - Operation id:
-					display_information (C.2)
-TSPC_AVRCP_4_17   False		CT: category 2 - Operation id: help (C.2)
-TSPC_AVRCP_4_18   False		CT: category 2 - Operation id: power (C.2)
-TSPC_AVRCP_4_19   False		CT: category 2 - Operation id: volume_up (C.2)
-TSPC_AVRCP_4_20   False		CT: category 2 - Operation id: volume_down (C.2)
-TSPC_AVRCP_4_21   False		CT: category 2 - Operation id: mute (C.2)
-TSPC_AVRCP_4_22   False		CT: category 2 - Operation id: F1 (C.2)
-TSPC_AVRCP_4_23   False		CT: category 2 - Operation id: F2 (C.2)
-TSPC_AVRCP_4_24   False		CT: category 2 - Operation id: F3 (C.2)
-TSPC_AVRCP_4_25   False		CT: category 2 - Operation id: F4 (C.2)
-TSPC_AVRCP_4_25a  False		CT: category 2 - Operation id: F5 (C.2)
+					display_information (C.1)
+TSPC_AVRCP_4_17   False		CT: category 2 - Operation id: help (C.1)
+TSPC_AVRCP_4_18   False		CT: category 2 - Operation id: power (C.1)
+TSPC_AVRCP_4_19   False		CT: category 2 - Operation id: volume_up (C.1)
+TSPC_AVRCP_4_20   False		CT: category 2 - Operation id: volume_down (C.1)
+TSPC_AVRCP_4_21   False		CT: category 2 - Operation id: mute (C.1)
+TSPC_AVRCP_4_22   False		CT: category 2 - Operation id: F1 (C.1)
+TSPC_AVRCP_4_23   False		CT: category 2 - Operation id: F2 (C.1)
+TSPC_AVRCP_4_24   False		CT: category 2 - Operation id: F3 (C.1)
+TSPC_AVRCP_4_25   False		CT: category 2 - Operation id: F4 (C.1)
 TSPC_AVRCP_4_26   False		CT: category 2 - Operation id: vendor_unique
-					(C.2)
+					(C.1)
 -------------------------------------------------------------------------------
-C.2: Mandatory to support at least one of these operation_ids if the device
+C.1: Mandatory to support at least one of these operation_ids if the device
 	supports category 2 (TSPC_AVRCP_2_8).
 -------------------------------------------------------------------------------
 
@@ -231,43 +235,42 @@ C.2: Mandatory to support at least one of these operation_ids if the device
 -------------------------------------------------------------------------------
 Parameter Name    Selected	Description
 -------------------------------------------------------------------------------
-TSPC_AVRCP_5_1    False		CT: category 3 - Operation id: 0 (C.3)
-TSPC_AVRCP_5_2    False		CT: category 3 - Operation id: 1 (C.3)
-TSPC_AVRCP_5_3    False		CT: category 3 - Operation id: 2 (C.3)
-TSPC_AVRCP_5_4    False		CT: category 3 - Operation id: 3 (C.3)
-TSPC_AVRCP_5_5    False		CT: category 3 - Operation id: 4 (C.3)
-TSPC_AVRCP_5_6    False		CT: category 3 - Operation id: 5 (C.3)
-TSPC_AVRCP_5_7    False		CT: category 3 - Operation id: 6 (C.3)
-TSPC_AVRCP_5_8    False		CT: category 3 - Operation id: 7 (C.3)
-TSPC_AVRCP_5_9    False		CT: category 3 - Operation id: 8 (C.3)
-TSPC_AVRCP_5_10   False		CT: category 3 - Operation id: 9 (C.3)
-TSPC_AVRCP_5_11   False		CT: category 3 - Operation id: dot (C.3)
-TSPC_AVRCP_5_12   False		CT: category 3 - Operation id: enter (C.3)
-TSPC_AVRCP_5_13   False		CT: category 3 - Operation id: clear (C.3)
-TSPC_AVRCP_5_14   False		CT: category 3 - Operation id: channel up (C.3)
+TSPC_AVRCP_5_1    False		CT: category 3 - Operation id: 0 (C.1)
+TSPC_AVRCP_5_2    False		CT: category 3 - Operation id: 1 (C.1)
+TSPC_AVRCP_5_3    False		CT: category 3 - Operation id: 2 (C.1)
+TSPC_AVRCP_5_4    False		CT: category 3 - Operation id: 3 (C.1)
+TSPC_AVRCP_5_5    False		CT: category 3 - Operation id: 4 (C.1)
+TSPC_AVRCP_5_6    False		CT: category 3 - Operation id: 5 (C.1)
+TSPC_AVRCP_5_7    False		CT: category 3 - Operation id: 6 (C.1)
+TSPC_AVRCP_5_8    False		CT: category 3 - Operation id: 7 (C.1)
+TSPC_AVRCP_5_9    False		CT: category 3 - Operation id: 8 (C.1)
+TSPC_AVRCP_5_10   False		CT: category 3 - Operation id: 9 (C.1)
+TSPC_AVRCP_5_11   False		CT: category 3 - Operation id: dot (C.1)
+TSPC_AVRCP_5_12   False		CT: category 3 - Operation id: enter (C.1)
+TSPC_AVRCP_5_13   False		CT: category 3 - Operation id: clear (C.1)
+TSPC_AVRCP_5_14   False		CT: category 3 - Operation id: channel up (C.1)
 TSPC_AVRCP_5_15   False		CT: category 3 - Operation id: channel down
-					(C.3)
+					(C.1)
 TSPC_AVRCP_5_16   False		CT: category 3 - Operation id: previous channel
-					(C.3)
+					(C.1)
 TSPC_AVRCP_5_17   False		CT: category 3 - Operation id: sound_select
-					(C.3)
+					(C.1)
 TSPC_AVRCP_5_18   False		CT: category 3 - Operation id: input_select
-					(C.3)
+					(C.1)
 TSPC_AVRCP_5_19   False		CT: category 3 - Operation id:
-					display_information (C.3)
-TSPC_AVRCP_5_20   False		CT: category 3 - Operation id: help (C.3)
-TSPC_AVRCP_5_21   False		CT: category 3 - Operation id: power (C.3)
-TSPC_AVRCP_5_22   False		CT: category 3 - Operation id: angle (C.3)
-TSPC_AVRCP_5_23   False		CT: category 3 - Operation id: subpicture(C.3)
-TSPC_AVRCP_5_24   False		CT: category 3 - Operation id: F1 (C.3)
-TSPC_AVRCP_5_25   False		CT: category 3 - Operation id: F2 (C.3)
-TSPC_AVRCP_5_26   False		CT: category 3 - Operation id: F3 (C.3)
-TSPC_AVRCP_5_27   False		CT: category 3 - Operation id: F4 (C.3)
-TSPC_AVRCP_5_27a  False		CT: category 3 - Operation id: F5 (C.3)
+					display_information (C.1)
+TSPC_AVRCP_5_20   False		CT: category 3 - Operation id: help (C.1)
+TSPC_AVRCP_5_21   False		CT: category 3 - Operation id: power (C.1)
+TSPC_AVRCP_5_22   False		CT: category 3 - Operation id: angle (C.1)
+TSPC_AVRCP_5_23   False		CT: category 3 - Operation id: subpicture(C.1)
+TSPC_AVRCP_5_24   False		CT: category 3 - Operation id: F1 (C.1)
+TSPC_AVRCP_5_25   False		CT: category 3 - Operation id: F2 (C.1)
+TSPC_AVRCP_5_26   False		CT: category 3 - Operation id: F3 (C.1)
+TSPC_AVRCP_5_27   False		CT: category 3 - Operation id: F4 (C.1)
 TSPC_AVRCP_5_28   False		CT: category 3 - Operation id: vendor_unique
-					(C.3)
+					(C.1)
 -------------------------------------------------------------------------------
-C.3: Mandatory to support at least one of these operation_ids if the device
+C.1: Mandatory to support at least one of these operation_ids if the device
 	supports category 3 (TSPC_AVRCP_2_9).
 -------------------------------------------------------------------------------
 
@@ -276,51 +279,50 @@ C.3: Mandatory to support at least one of these operation_ids if the device
 -------------------------------------------------------------------------------
 Parameter Name    Selected	Description
 -------------------------------------------------------------------------------
-TSPC_AVRCP_6_1    False		CT: category 4 - Operation id: select (C.4)
-TSPC_AVRCP_6_2    False		CT: category 4 - Operation id: up (C.4)
-TSPC_AVRCP_6_3    False		CT: category 4 - Operation id: down (C.4)
-TSPC_AVRCP_6_4    False		CT: category 4 - Operation id: left (C.4)
-TSPC_AVRCP_6_5    False		CT: category 4 - Operation id: right (C.4)
-TSPC_AVRCP_6_6    False		CT: category 4 - Operation id: right up (C.4)
-TSPC_AVRCP_6_7    False		CT: category 4 - Operation id: right down (C.4)
-TSPC_AVRCP_6_8    False		CT: category 4 - Operation id: left up (C.4)
-TSPC_AVRCP_6_9    False		CT: category 4 - Operation id: left down (C.4)
-TSPC_AVRCP_6_10   False		CT: category 4 - Operation id: root menu (C.4)
-TSPC_AVRCP_6_11   False		CT: category 4 - Operation id: setup menu (C.4)
+TSPC_AVRCP_6_1    False		CT: category 4 - Operation id: select (C.1)
+TSPC_AVRCP_6_2    False		CT: category 4 - Operation id: up (C.1)
+TSPC_AVRCP_6_3    False		CT: category 4 - Operation id: down (C.1)
+TSPC_AVRCP_6_4    False		CT: category 4 - Operation id: left (C.1)
+TSPC_AVRCP_6_5    False		CT: category 4 - Operation id: right (C.1)
+TSPC_AVRCP_6_6    False		CT: category 4 - Operation id: right up (C.1)
+TSPC_AVRCP_6_7    False		CT: category 4 - Operation id: right down (C.1)
+TSPC_AVRCP_6_8    False		CT: category 4 - Operation id: left up (C.1)
+TSPC_AVRCP_6_9    False		CT: category 4 - Operation id: left down (C.1)
+TSPC_AVRCP_6_10   False		CT: category 4 - Operation id: root menu (C.1)
+TSPC_AVRCP_6_11   False		CT: category 4 - Operation id: setup menu (C.1)
 TSPC_AVRCP_6_12   False		CT: category 4 - Operation id: contents menu
-					(C.4)
+					(C.1)
 TSPC_AVRCP_6_13   False		CT: category 4 - Operation id: favorite menu
-					(C.4)
-TSPC_AVRCP_6_14   False		CT: category 4 - Operation id: exit (C.4)
-TSPC_AVRCP_6_15   False		CT: category 4 - Operation id: 0 (C.4)
-TSPC_AVRCP_6_16   False		CT: category 4 - Operation id: 1 (C.4)
-TSPC_AVRCP_6_17   False		CT: category 4 - Operation id: 2 (C.4)
-TSPC_AVRCP_6_18   False		CT: category 4 - Operation id: 3 (C.4)
-TSPC_AVRCP_6_19   False		CT: category 4 - Operation id: 4 (C.4)
-TSPC_AVRCP_6_20   False		CT: category 4 - Operation id: 5 (C.4)
-TSPC_AVRCP_6_21   False		CT: category 4 - Operation id: 6 (C.4)
-TSPC_AVRCP_6_22   False		CT: category 4 - Operation id: 7 (C.4)
-TSPC_AVRCP_6_23   False		CT: category 4 - Operation id: 8 (C.4)
-TSPC_AVRCP_6_24   False		CT: category 4 - Operation id: 9 (C.4)
-TSPC_AVRCP_6_25   False		CT: category 4 - Operation id: dot (C.4)
-TSPC_AVRCP_6_26   False		CT: category 4 - Operation id: enter (C.4)
-TSPC_AVRCP_6_27   False		CT: category 4 - Operation id: clear (C.4)
+					(C.1)
+TSPC_AVRCP_6_14   False		CT: category 4 - Operation id: exit (C.1)
+TSPC_AVRCP_6_15   False		CT: category 4 - Operation id: 0 (C.1)
+TSPC_AVRCP_6_16   False		CT: category 4 - Operation id: 1 (C.1)
+TSPC_AVRCP_6_17   False		CT: category 4 - Operation id: 2 (C.1)
+TSPC_AVRCP_6_18   False		CT: category 4 - Operation id: 3 (C.1)
+TSPC_AVRCP_6_19   False		CT: category 4 - Operation id: 4 (C.1)
+TSPC_AVRCP_6_20   False		CT: category 4 - Operation id: 5 (C.1)
+TSPC_AVRCP_6_21   False		CT: category 4 - Operation id: 6 (C.1)
+TSPC_AVRCP_6_22   False		CT: category 4 - Operation id: 7 (C.1)
+TSPC_AVRCP_6_23   False		CT: category 4 - Operation id: 8 (C.1)
+TSPC_AVRCP_6_24   False		CT: category 4 - Operation id: 9 (C.1)
+TSPC_AVRCP_6_25   False		CT: category 4 - Operation id: dot (C.1)
+TSPC_AVRCP_6_26   False		CT: category 4 - Operation id: enter (C.1)
+TSPC_AVRCP_6_27   False		CT: category 4 - Operation id: clear (C.1)
 TSPC_AVRCP_6_28   False		CT: category 4 - Operation id:
-					display_information (C.4)
-TSPC_AVRCP_6_29   False		CT: category 4 - Operation id: help (C.4)
-TSPC_AVRCP_6_30   False		CT: category 4 - Operation id: page up (C.4)
-TSPC_AVRCP_6_31   False		CT: category 4 - Operation id: page down (C.4)
-TSPC_AVRCP_6_32   False		CT: category 4 - Operation id: power (C.4)
-TSPC_AVRCP_6_33   False		CT: category 4 - Operation id: F1 (C.4)
-TSPC_AVRCP_6_34   False		CT: category 4 - Operation id: F2 (C.4)
-TSPC_AVRCP_6_35   False		CT: category 4 - Operation id: F3 (C.4)
-TSPC_AVRCP_6_36   False		CT: category 4 - Operation id: F4 (C.4)
-TSPC_AVRCP_6_36a  False		CT: category 4 - Operation id: F5 (C.4)
+					display_information (C.1)
+TSPC_AVRCP_6_29   False		CT: category 4 - Operation id: help (C.1)
+TSPC_AVRCP_6_30   False		CT: category 4 - Operation id: page up (C.1)
+TSPC_AVRCP_6_31   False		CT: category 4 - Operation id: page down (C.1)
+TSPC_AVRCP_6_32   False		CT: category 4 - Operation id: power (C.1)
+TSPC_AVRCP_6_33   False		CT: category 4 - Operation id: F1 (C.1)
+TSPC_AVRCP_6_34   False		CT: category 4 - Operation id: F2 (C.1)
+TSPC_AVRCP_6_35   False		CT: category 4 - Operation id: F3 (C.1)
+TSPC_AVRCP_6_36   False		CT: category 4 - Operation id: F4 (C.1)
 TSPC_AVRCP_6_37   False		CT: category 4 - Operation id: vendor_unique
-					(C.4)
+					(C.1)
 -------------------------------------------------------------------------------
-C.4: Mandatory to support at least one of these operation_ids if the device
-	supports category 4 (TSPC_AVRCP_2_9).
+C.1: Mandatory to support at least one of these operation_ids if the device
+	supports category 4 (TSPC_AVRCP_2_10).
 -------------------------------------------------------------------------------
 
 
@@ -328,8 +330,10 @@ C.4: Mandatory to support at least one of these operation_ids if the device
 -------------------------------------------------------------------------------
 Parameter Name    Selected	Description
 -------------------------------------------------------------------------------
-TSPC_AVRCP_7_1    True (*)	TG: Initiating connection establishment (O)
-TSPC_AVRCP_7_2    True		TG: Accept connection establishment (M)
+TSPC_AVRCP_7_1    True (*)	TG: Initiating connection establishment for
+					Control (O)
+TSPC_AVRCP_7_2    True		TG: Accept connection establishment for Control
+					initiated by CT (M)
 TSPC_AVRCP_7_3    True (*)	TG: Initiating connection release (M)
 TSPC_AVRCP_7_4    True		TG: Accepting connection release (M)
 TSPC_AVRCP_7_5    True		TG: Receiving UNIT INFO (M)
@@ -343,16 +347,20 @@ TSPC_AVRCP_7_9    False		TG: Receiving PASS THROUGH command category 3
 TSPC_AVRCP_7_10   False		TG: Receiving PASS THROUGH command category 4
 					(C.1)
 TSPC_AVRCP_7_11   True (*)	TG: Get Capabilities Response (C.3)
-TSPC_AVRCP_7_12   False		TG: List Player Application Settings (C.14)
+TSPC_AVRCP_7_12   False		TG: List Player Application Settings Attributes
+					Response (C.14)
 TSPC_AVRCP_7_13   False		TG: List Player Application Setting Values
-					(C.14)
+					Response (C.14)
 TSPC_AVRCP_7_14   False		TG: Get Current Player Application Settings
-					(C.14)
-TSPC_AVRCP_7_15   False		TG: Set Player Application Setting Value (C.14)
+					Value Response (C.14)
+TSPC_AVRCP_7_15   False		TG: Set Player Application Setting Value
+					Response (C.14)
 TSPC_AVRCP_7_16   False		TG: Get Player Application Setting Attribute
+					Text Response (O)
+TSPC_AVRCP_7_17   False		TG: Get Player Application Setting Value Text
+					Response (O)
+TSPC_AVRCP_7_18   False		TG: Inform Displayable Character Set Response
 					(O)
-TSPC_AVRCP_7_17   False		TG: Get Player Application Setting Value (O)
-TSPC_AVRCP_7_18   False		TG: Inform Displayable Character Set (O)
 TSPC_AVRCP_7_19   False		TG: Inform Battery Status Of CT Response (O)
 TSPC_AVRCP_7_20   True (*)	TG: Get Element Attributes Response (C.3)
 TSPC_AVRCP_7_21   True (*)	TG: Get Play Status Response (C.2)
@@ -371,7 +379,7 @@ TSPC_AVRCP_7_29   False		TG: Notify Event Response: SYSTEM_STATUS_CHANGED
 					(O)
 TSPC_AVRCP_7_30   False		TG: Notify Event Response:
 					PLAYER_APPLICATION_SETTING_CHANGED (O)
-TSPC_AVRCP_7_31   True (*)	TG: Request ContinuingResponse (C.2)
+TSPC_AVRCP_7_31   True (*)	TG: Request Continuing Response (C.2)
 TSPC_AVRCP_7_32   True (*)	TG: Abort ContinuingResponse Response (C.2)
 TSPC_AVRCP_7_34   False		TG: Next Group (C.15)
 TSPC_AVRCP_7_35   False		TG: Previous Group (C.15)
@@ -383,8 +391,8 @@ TSPC_AVRCP_7_39   False		TG: EVENT_AVAILABLE_PLAYERS_CHANGED (C.8)
 TSPC_AVRCP_7_40   False		TG: EVENT_ADDRESSED_PLAYER_CHANGED (C.8)
 TSPC_AVRCP_7_41   False		TG: Supports Multiple Players (O)
 TSPC_AVRCP_7_42   False		TG: Browsing (O)
-TSPC_AVRCP_7_42a  False		TG: Supports initiation of browsing channel
-					establishment (O)
+TSPC_AVRCP_7_42a  False		TG: Initiating connection establishment for
+					browsing channel (O)
 TSPC_AVRCP_7_43   False		TG: SetBrowsedPlayer (C.6)
 TSPC_AVRCP_7_44   False		TG: ChangePath (C.6)
 TSPC_AVRCP_7_45   False		TG: GetFolderItems(Filesystem) (C.6)
@@ -414,9 +422,9 @@ TSPC_AVRCP_7_65   True		TG: Discoverable Mode (M)
 TSPC_AVRCP_7_66   False		TG: PASSTHROUGH operation supporting press
 					and hold (O)
 TSPC_AVRCP_7_67   False		TG: Cover Art (O)
-TSPC_AVRCP_7_68   False		TG: GetImageProperties, Cover Art (C.16)
-TSPC_AVRCP_7_69   False		TG: GetImage, Cover Art (C.16)
-TSPC_AVRCP_7_70   False		TG: GetLinkedThumbnail, Cover Art (C.16)
+TSPC_AVRCP_7_68   False		TG: GetImageProperties (C.16)
+TSPC_AVRCP_7_69   False		TG: GetImage (C.16)
+TSPC_AVRCP_7_70   False		TG: GetLinkedThumbnail (C.16)
 -------------------------------------------------------------------------------
 C.1: Mandatory to support at least one of the categories. Supported
 	operation_id's are shown in Table 8 to Table 11.
@@ -440,6 +448,7 @@ C.15: Mandatory if Basic Group Navigation Feature supported. If any item
 	7/34 or 7/35 is supported it is mandatory to support both,
 	in accordance with Basic Group Navigation support requirements,
 	otherwise Excluded.
+C.16: Mandatory if 7/67 (Cover Art) is supported, otherwise Excluded.
 -------------------------------------------------------------------------------
 
 		Target Profile Version
@@ -494,8 +503,8 @@ TSPC_AVRCP_8_30   False		TG: category 1 - Operation id: F1 (O)
 TSPC_AVRCP_8_31   False		TG: category 1 - Operation id: F2 (O)
 TSPC_AVRCP_8_32   False		TG: category 1 - Operation id: F3 (O)
 TSPC_AVRCP_8_33   False		TG: category 1 - Operation id: F4 (O)
-TSPC_AVRCP_8_34   False		TG: category 1 - Operation id: F5 (O)
-TSPC_AVRCP_8_35   False		TG: category 1 - Operation id: vendor unique (O)
+TSPC_AVRCP_8_33a  False		TG: category 1 - Operation id: F5 (O)
+TSPC_AVRCP_8_34   False		TG: category 1 - Operation id: vendor unique (O)
 -------------------------------------------------------------------------------
 
 
@@ -525,12 +534,12 @@ TSPC_AVRCP_9_18	  False		TG: category 2 - Operation id: power (O)
 TSPC_AVRCP_9_19   True		TG: category 2 - Operation id: volume up (C.2)
 TSPC_AVRCP_9_20   True		TG: category 2 - Operation id: volume down (C.2)
 TSPC_AVRCP_9_21   False		TG: category 2 - Operation id: mute (O)
-TSPC_AVRCP_9_22   False		TG: category 2 - Operation id: F1 (O)
-TSPC_AVRCP_9_23   False		TG: category 2 - Operation id: F2 (O)
-TSPC_AVRCP_9_24   False		TG: category 2 - Operation id: F3 (O)
-TSPC_AVRCP_9_25   False		TG: category 2 - Operation id: F4 (O)
-TSPC_AVRCP_9_26   False		TG: category 2 - Operation id: F5 (O)
-TSPC_AVRCP_9_27   False		TG: category 2 - Operation id: vendor unique (O)
+TSPC_AVRCP_9_24   False		TG: category 2 - Operation id: F1 (O)
+TSPC_AVRCP_9_25   False		TG: category 2 - Operation id: F2 (O)
+TSPC_AVRCP_9_26   False		TG: category 2 - Operation id: F3 (O)
+TSPC_AVRCP_9_27   False		TG: category 2 - Operation id: F4 (O)
+TSPC_AVRCP_9_27a  False		TG: category 2 - Operation id: F5 (O)
+TSPC_AVRCP_9_28   False		TG: category 2 - Operation id: vendor unique (O)
 -------------------------------------------------------------------------------
 C.2: Mandatory to support if the device supports category 2 (TSPC_AVRCP_7_8).
 -------------------------------------------------------------------------------
@@ -553,8 +562,8 @@ TSPC_AVRCP_10_10  False		TG: category 3 - Operation id: 9 (O)
 TSPC_AVRCP_10_11  False		TG: category 3 - Operation id: dot (O)
 TSPC_AVRCP_10_12  False		TG: category 3 - Operation id: enter (O)
 TSPC_AVRCP_10_13  False		TG: category 3 - Operation id: clear (O)
-TSPC_AVRCP_10_14  False (*)		TG: category 3 - Operation id: channel up (C.3)
-TSPC_AVRCP_10_15  False (*)		TG: category 3 - Operation id: channel down
+TSPC_AVRCP_10_14  False (*)	TG: category 3 - Operation id: channel up (C.3)
+TSPC_AVRCP_10_15  False (*)	TG: category 3 - Operation id: channel down
 					(C.3)
 TSPC_AVRCP_10_16  False		TG: category 3 - Operation id: previous channel
 					(O)
@@ -564,14 +573,14 @@ TSPC_AVRCP_10_19  False		TG: category 3 - Operation id: display
 					information (O)
 TSPC_AVRCP_10_20  False		TG: category 3 - Operation id: help (O)
 TSPC_AVRCP_10_21  False		TG: category 3 - Operation id: power (O)
-TSPC_AVRCP_10_22  False		TG: category 3 - Operation id: angle (O)
-TSPC_AVRCP_10_23  False		TG: category 3 - Operation id: subpicture (O)
-TSPC_AVRCP_10_24  False		TG: category 3 - Operation id: F1 (O)
-TSPC_AVRCP_10_25  False		TG: category 3 - Operation id: F2 (O)
-TSPC_AVRCP_10_26  False		TG: category 3 - Operation id: F3 (O)
-TSPC_AVRCP_10_27  False		TG: category 3 - Operation id: F4 (O)
-TSPC_AVRCP_10_28  False		TG: category 3 - Operation id: F5 (O)
-TSPC_AVRCP_10_29  False		TG: category 3 - Operation id: vendor unique (O)
+TSPC_AVRCP_10_21a False		TG: category 3 - Operation id: angle (O)
+TSPC_AVRCP_10_21b False		TG: category 3 - Operation id: subpicture (O)
+TSPC_AVRCP_10_22  False		TG: category 3 - Operation id: F1 (O)
+TSPC_AVRCP_10_23  False		TG: category 3 - Operation id: F2 (O)
+TSPC_AVRCP_10_24  False		TG: category 3 - Operation id: F3 (O)
+TSPC_AVRCP_10_25  False		TG: category 3 - Operation id: F4 (O)
+TSPC_AVRCP_10_25a False		TG: category 3 - Operation id: F5 (O)
+TSPC_AVRCP_10_26  False		TG: category 3 - Operation id: vendor unique (O)
 -------------------------------------------------------------------------------
 C.3: Mandatory to support if the device supports category 3 (TSPC_AVRCP_7_9).
 -------------------------------------------------------------------------------
@@ -581,16 +590,16 @@ C.3: Mandatory to support if the device supports category 3 (TSPC_AVRCP_7_9).
 -------------------------------------------------------------------------------
 Parameter Name    Selected	Description
 -------------------------------------------------------------------------------
-TSPC_AVRCP_11_1   False (*)		TG: category 4 - Operation id: select (C.4)
-TSPC_AVRCP_11_2   False (*)		TG: category 4 - Operation id: up (C.4)
-TSPC_AVRCP_11_3   False (*)		TG: category 4 - Operation id: down (C.4)
-TSPC_AVRCP_11_4   False (*)		TG: category 4 - Operation id: left (C.4)
-TSPC_AVRCP_11_5   False (*)		TG: category 4 - Operation id: right (C.4)
+TSPC_AVRCP_11_1   False (*)	TG: category 4 - Operation id: select (C.4)
+TSPC_AVRCP_11_2   False (*)	TG: category 4 - Operation id: up (C.4)
+TSPC_AVRCP_11_3   False (*)	TG: category 4 - Operation id: down (C.4)
+TSPC_AVRCP_11_4   False (*)	TG: category 4 - Operation id: left (C.4)
+TSPC_AVRCP_11_5   False (*)	TG: category 4 - Operation id: right (C.4)
 TSPC_AVRCP_11_6   False		TG: category 4 - Operation id: right up (O)
 TSPC_AVRCP_11_7   False		TG: category 4 - Operation id: right down (O)
 TSPC_AVRCP_11_8   False		TG: category 4 - Operation id: left up (O)
 TSPC_AVRCP_11_9   False		TG: category 4 - Operation id: left down (O)
-TSPC_AVRCP_11_10  False (*)		TG: category 4 - Operation id: root menu (C.4)
+TSPC_AVRCP_11_10  False (*)	TG: category 4 - Operation id: root menu (C.4)
 TSPC_AVRCP_11_11  False		TG: category 4 - Operation id: setup menu (O)
 TSPC_AVRCP_11_12  False		TG: category 4 - Operation id: contents menu (O)
 TSPC_AVRCP_11_13  False		TG: category 4 - Operation id: favorite menu (O)
@@ -617,11 +626,11 @@ TSPC_AVRCP_11_33  False		TG: category 4 - Operation id: F1 (O)
 TSPC_AVRCP_11_34  False		TG: category 4 - Operation id: F2 (O)
 TSPC_AVRCP_11_35  False		TG: category 4 - Operation id: F3 (O)
 TSPC_AVRCP_11_36  False		TG: category 4 - Operation id: F4 (O)
-TSPC_AVRCP_11_37  False		TG: category 4 - Operation id: F5 (O)
-TSPC_AVRCP_11_38  False		TG: category 4 - Operation id: vendor unique (O)
+TSPC_AVRCP_11_36a False		TG: category 4 - Operation id: F5 (O)
+TSPC_AVRCP_11_37  False		TG: category 4 - Operation id: vendor unique (O)
 
-TSPC_AVRCP_12_1   True			General discoverable mode
-TSPC_AVRCP_13_1   True			General discoverable mode
+TSPC_AVRCP_12_1   True		General discoverable mode (M)
+TSPC_AVRCP_13_1   True		General discoverable mode (M)
 TSPC_AVRCP_14_1   False		OBEX Connect operation (C.1)
 TSPC_AVRCP_14_2   False		OBEX Get operation (C.1)
 TSPC_AVRCP_14_3   False		OBEX Disconnect operation (C.1)
diff --git a/android/pixit-avrcp.txt b/android/pixit-avrcp.txt
index f576bd0..c429828 100644
--- a/android/pixit-avrcp.txt
+++ b/android/pixit-avrcp.txt
@@ -1,6 +1,6 @@
 AVRCP PIXIT for the PTS tool.
 
-PTS version: 5.3
+PTS version: 6.0
 
 * - different than PTS defaults
 & - should be set to IUT Bluetooth address
@@ -18,7 +18,7 @@ TSPX_pin_code			0000
 TSPX_delete_link_key		FALSE
 TSPX_time_guard			300000
 TSPX_avrcp_only			FALSE
-TSPX_search_string		tomorrow
+TSPX_search_string		3
 TSPX_max_avc_fragments		10
 TSPX_establish_avdtp_stream	TRUE
 TSPX_use_implicit_send		TRUE
-- 
1.9.3

