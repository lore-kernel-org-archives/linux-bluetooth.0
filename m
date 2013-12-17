Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] android/pts: Add PTS PICS and PIXIT for MAP
Date: Tue, 17 Dec 2013 11:53:52 +0100
Message-Id: <1387277633-6008-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add PICS and PIXIT targetting Android 4.4 and PTS version 5.0.
---
 android/Makefile.am   |   3 +-
 android/pics-map.txt  | 175 ++++++++++++++++++++++++++++++++++++++++++++++++++
 android/pixit-map.txt |  45 +++++++++++++
 3 files changed, 222 insertions(+), 1 deletion(-)
 create mode 100644 android/pics-map.txt
 create mode 100644 android/pixit-map.txt

diff --git a/android/Makefile.am b/android/Makefile.am
index 0034487..abeda84 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -122,4 +122,5 @@ EXTRA_DIST += android/Android.mk android/hal-ipc-api.txt android/README \
 		android/pixit-opp.txt android/pixit-pan.txt \
 		android/pixit-pbap.txt android/pts-gap.txt android/pts-hid.txt \
 		android/pts-opp.txt android/pts-pbap.txt \
-		android/audio-ipc-api.txt
+		android/audio-ipc-api.txt android/pics-map.txt \
+		android/pixit-map.txt
diff --git a/android/pics-map.txt b/android/pics-map.txt
new file mode 100644
index 0000000..2875885
--- /dev/null
+++ b/android/pics-map.txt
@@ -0,0 +1,175 @@
+MAP PICS for the PTS tool.
+
+PTS version: 5.0
+
+* - different than PTS defaults
+# - not yet implemented/supported
+
+M - mandatory
+O - optional
+
+	Profile Version
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_MAP_0_1	False		Role: Map 1.0 (C1)
+TSPC_MAP_0_2	True (*)	Role: Map 1.1 (C1)
+TSPC_MAP_0_3	False		Role: Map 1.2 (C1)
+-------------------------------------------------------------------------------
+C.1: Mandatory to support only one Profile version.
+-------------------------------------------------------------------------------
+
+
+	Roles
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_MAP_1_1	True (*)	Role: Messaging Server Equipment (C1)
+TSPC_MAP_1_2	False		Role: Messaging Client Equipment (C1)
+-------------------------------------------------------------------------------
+C.1: It is mandatory to support at least one of the defined roles.
+-------------------------------------------------------------------------------
+
+
+	Supported features MCE
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_MAP_2_1	False		MCE: Message Notification (C1)
+TSPC_MAP_2_1a	False		MCE: SendEvent (C4)
+TSPC_MAP_2_2	False		MCE: Message Browsing (C1)
+TSPC_MAP_2_2a	False		MCE: SetFolder (C5)
+TSPC_MAP_2_2b	False		MCE: GetFoldersListing (C5)
+TSPC_MAP_2_2c	False		MCE: GetMessagesListing (C5)
+TSPC_MAP_2_2d	False		MCE: GetMessage (O)
+TSPC_MAP_2_2e	False		MCE: SetMessageStatus (O)
+TSPC_MAP_2_2f	False		MCE: UpdateInbox (O)
+TSPC_MAP_2_2g	False		MCE: Filtering (O)
+TSPC_MAP_2_2h	False		MCE: Multiple simultaneous MAS instances (O)
+TSPC_MAP_2_3	False		MCE: Message Uploading (O)
+TSPC_MAP_2_3a	False		MCE: SetFolder (C6)
+TSPC_MAP_2_3b	False		MCE: GetFoldersListing (C6)
+TSPC_MAP_2_3c	False		MCE: PushMessage (C6)
+TSPC_MAP_2_4	False		MCE: Message Delete (O)
+TSPC_MAP_2_4a	False		MCE: SetMessageStatus (C7)
+TSPC_MAP_2_5	False		MCE: Notification Registration (C2)
+TSPC_MAP_2_5a	False		MCE: SetNotificationRegistration off (O)
+TSPC_MAP_2_5b	False		MCE: SetNotificationRegistration on (C8)
+TSPC_MAP_2_6	False		MCE: Supported Message Types
+TSPC_MAP_2_6a	False (*)	MCE: EMAIL (C3)
+TSPC_MAP_2_6b	False (*)	MCE: SMS_GSM (C3)
+TSPC_MAP_2_6c	False (*)	MCE: SMS_CDMA (C3)
+TSPC_MAP_2_6d	False (*)	MCE: MMS (C3)
+TSPC_MAP_2_7	False		MCE: Instance Information (Not Supported)
+TSPC_MAP_2_7a	False (*)	MCE: GetMASInstanceInformation (Not Supported)
+TSPC_MAP_2_8	False		MCE: Extended MAP-Event-Report (Not Supported)
+TSPC_MAP_2_8a	False (*)	MCE: MAP-Event-Report: Version 1.1
+					(Not Supported)
+-------------------------------------------------------------------------------
+C.1: Mandatory to support at least one of the defined features TSPC_MAP_2_1 or
+	TSPC_MAP_2_2.
+C.2: Mandatory to support TSPC_MAP_2_5 if TSPC_MAP_2_1 is supported.
+C.3: Mandatory to support at least one of the defined message types
+	TSPC_MAP_2_6a to TSPC_MAP_2_6d IF TSPC_MAP_2_2 or TSPC_MAP_2_3 is
+	supported.
+C.4: Support of functionality TSPC_MAP_2_1a mandatory IF related feature
+	TSPC_MAP_2_1 supported.
+C.5: Support of functionality mandatory IF TSPC_MAP_2_2 supported.
+C.6: Support of functionality mandatory IF TSPC_MAP_2_3 supported.
+C.7: Support of functionality mandatory IF TSPC_MAP_2_4 supported.
+C.8: Mandatory to support IF TSPC_MAP_2_5 (Notification Registration) is
+	supported, otherwise excluded.
+C.9: Optional to support IF TSPC_MAP_0_3 (MAP v1.2) is supported, otherwise
+	excluded.
+C.10: Mandatory to support IF TSPC_MAP_0_3 (MAP v1.2) and TSPC_MAP_2_1
+	(Message Notification) is supported, otherwise excluded.
+-------------------------------------------------------------------------------
+
+
+	Supported features MSE
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_MAP_3_1	True		MSE: Message Notification (M)
+TSPC_MAP_3_1a	True		MSE: SendEvent (M)
+TSPC_MAP_3_2	True		MSE: Message Browsing (M)
+TSPC_MAP_3_2a	True		MSE: SetFolder (M)
+TSPC_MAP_3_2b	True		MSE: GetFoldersListing (M)
+TSPC_MAP_3_2c	True		MSE: GetMessagesListing (M)
+TSPC_MAP_3_2d	True		MSE: GetMessage (M)
+TSPC_MAP_3_2e	True		MSE: SetMessageStatus (M)
+TSPC_MAP_3_2f	True		MSE: UpdateInbox (M)
+TSPC_MAP_3_2g	False		MSE: Multiple simultaneous MAS instances (O)
+TSPC_MAP_3_3	True		MSE: Message Uploading (M)
+TSPC_MAP_3_3a	True		MSE: SetFolder (M)
+TSPC_MAP_3_3b	True		MSE: GetFoldersListing (M)
+TSPC_MAP_3_3c	True		MSE: PushMessage (M)
+TSPC_MAP_3_4	True		MSE: Message Delete (M)
+TSPC_MAP_3_4a	True		MSE: SetMessageStatus (M)
+TSPC_MAP_3_5	True		MSE: Notification Registration (M)
+TSPC_MAP_3_5a	True		MSE: SetNotificationRegistration (M)
+TSPC_MAP_3_6	False		MSE: Supported Message Types
+TSPC_MAP_3_6a	False		MSE: EMAIL (C1)
+TSPC_MAP_3_6b	True		MSE: SMS_GSM (C1)
+TSPC_MAP_3_6c	False		MSE: SMS_CDMA (C1)
+TSPC_MAP_3_6d	False (*)	MSE: MMS (C1)
+TSPC_MAP_3_7	False		MSE: Instance Information (Not Supported)
+TSPC_MAP_3_7a	False (*)	MSE: GetMASInstanceInformation (Not Supported)
+TSPC_MAP_3_8	False		MSE: Extended MAP-Event-Report (Not Supported)
+TSPC_MAP_3_8a	False (*)	MSE: MAP-Event-Report: Version 1.1
+					(Not Supported)
+-------------------------------------------------------------------------------
+C.1: Mandatory to support at least one of the defined message types
+	TSPC_MAP_3_6a to TSPC_MAP_3_6d IF TSPC_MAP_3_2 or TSPC_MAP_3_3
+	is supported.
+C.2: Mandatory to support IF TSPC_MAP_0_3 (MAP v1.2) is supported,
+	otherwise excluded.
+-------------------------------------------------------------------------------
+
+
+	GOEP v2.0 or later Features
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_MAP_7b_1	False		GOEP v2.0 or later (C1)
+TSPC_MAP_7b_2	False		GOEP v2 Backwards Compatibility (C1)
+TSPC_MAP_7b_3	False		OBEX over L2CAP (C1)
+-------------------------------------------------------------------------------
+C.1: Mandatory if TSPC_MAP_0_3 (MAP v1.2) is supported else excluded.
+-------------------------------------------------------------------------------
+
+
+	MCE OBEX Header Support
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_MAP_10_1	False (*)	Name (M)
+TSPC_MAP_10_2	False (*)	Typr (M)
+TSPC_MAP_10_3	False (*)	Body (M)
+TSPC_MAP_10_4	False (*)	End of Body (M)
+TSPC_MAP_10_5	False (*)	Target (M)
+TSPC_MAP_10_6	False (*)	Who (M)
+TSPC_MAP_10_7	False (*)	Connection ID (M)
+TSPC_MAP_10_8	False (*)	Application Parameters (M)
+TSPC_MAP_10_9	False		SRM (C2)
+TSPC_MAP_10_10	False		Receive SRMP (C2)
+TSPC_MAP_10_11	False		Send SRMP (C2)
+-------------------------------------------------------------------------------
+C.1: Mandatory if TSPC_MAP_0_3 (MAP v1.2) is supported else excluded.
+C.2: Optional if TSPC_MAP_0_3 (MAP v1.2) is supported else excluded.
+-------------------------------------------------------------------------------
+
+
+	GetMessagesListing Filtering Parameter Support
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_MAP_20_1	False (*)	MCE: FilterMessageType (O)
+TSPC_MAP_20_2	False (*)	MCE: FilterPeriodBegin (O)
+TSPC_MAP_20_3	False (*)	MCE: FilterPeriodEnd (O)
+TSPC_MAP_20_4	False (*)	MCE: FilterReadStatus (O)
+TSPC_MAP_20_5	False (*)	MCE: FilterRecipient (O)
+TSPC_MAP_20_6	False (*)	MCE: FilterOriginator (O)
+TSPC_MAP_20_7	False (*)	MCE: FilterPriority (O)
+TSPC_ALL	False (*)	Turns on all the test cases
+-------------------------------------------------------------------------------
diff --git a/android/pixit-map.txt b/android/pixit-map.txt
new file mode 100644
index 0000000..c8e2591
--- /dev/null
+++ b/android/pixit-map.txt
@@ -0,0 +1,45 @@
+MAP PIXIT for the PTS tool.
+
+PTS version: 5.0
+
+* - different than PTS defaults
+& - should be set to IUT Bluetooth address
+
+		Required PIXIT settings
+-------------------------------------------------------------------------------
+Parameter Name						Value
+-------------------------------------------------------------------------------
+TSPX_auth_password					0000
+TSPX_auth_user_id					PTS
+TSPX_bd_addr_iut					08606E414394 (*&)
+TSPX_client_class_of_device				100204
+TSPX_delete_link_key					FALSE
+TSPX_get_object_name					put.gif
+TSPX_initial_path
+TSPX_l2cap_psm						1001
+TSPX_no_confirmations					FALSE
+TSPX_pin_code						0000
+TSPX_rfcomm_channel					8
+TSPX_secure_simple_pairing_pass_key_confirmation	FALSE
+TSPX_security_enabled					TRUE
+TSPX_server_class_of_device				100204
+TSPX_time_guard						300000
+TSPX_use_implicit_send					TRUE
+TSPX_Message_Access_rfcomm_channel			1
+TSPX_Message_Notification_rfcomm_channel		2
+TSPX_SPP_rfcomm_channel					03
+TSPX_filter_period_begin				20100101T000000
+TSPX_filter_period_end					20111231T125959
+TSPX_filter_recipient					PTS
+TSPX_filter_originator					PTS
+TSPX_default_message_upload_folder_in_msg		draft
+TSPX_default_test_folder_in_msg				inbox
+TSPX_use_fixed_MASInstanceID				FALSE
+TSPX_MASInstanceID_SMS					0
+TSPX_MASInstanceID_MMS					0
+TSPX_MASInstanceID_Email				0
+TSPX_message_notification_l2cap_psm			1003
+TSPX_message_notification_rfcomm_channel		9
+TSPX_upload_msg_phonenumber				123456789
+TSPX_upload_msg_emailaddress				PTS_Test@bluetooth.com
+-------------------------------------------------------------------------------
-- 
1.8.5

