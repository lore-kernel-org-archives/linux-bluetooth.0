Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC] android/tester: Add disconnect A2DP steps to AVRCP test cases
Date: Wed,  3 Dec 2014 15:54:58 +0100
Message-Id: <1417618498-15530-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

While teardown, services are unregistered (A2DP, AVRCP) and
notification with a2dp link state comes. This can trigger an
IPC error (handle notification on unregistered service) if
service is unregistered and then notification wants to be handled
by IPC. To avoid changing link state in teardown phase A2DP connection
needs to be disconnected in test phase.
---
 android/tester-avrcp.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/android/tester-avrcp.c b/android/tester-avrcp.c
index 7c02ec2..7044bc8 100644
--- a/android/tester-avrcp.c
+++ b/android/tester-avrcp.c
@@ -341,24 +341,7 @@ static struct test_case test_cases[] = {
 	TEST_CASE_BREDRLE("AVRCP Init",
 		ACTION_SUCCESS(dummy_action, NULL),
 	),
-	TEST_CASE_BREDRLE("AVRCP Connect - Success",
-		ACTION_SUCCESS(bluetooth_enable_action, NULL),
-		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
-		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
-		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
-		ACTION_SUCCESS(set_default_ssp_request_handler, NULL),
-		ACTION_SUCCESS(emu_add_l2cap_server_action, &sdp_setup_data),
-		ACTION_SUCCESS(emu_add_l2cap_server_action, &a2dp_setup_data),
-		ACTION_SUCCESS(emu_add_l2cap_server_action, &avrcp_setup_data),
-		ACTION_SUCCESS(avrcp_connect_action, NULL),
-		CALLBACK_AV_CONN_STATE(CB_A2DP_CONN_STATE,
-					BTAV_CONNECTION_STATE_CONNECTING),
-		CALLBACK_AV_CONN_STATE(CB_A2DP_CONN_STATE,
-					BTAV_CONNECTION_STATE_CONNECTED),
-		ACTION_SUCCESS(bluetooth_disable_action, NULL),
-		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
-	),
-	TEST_CASE_BREDRLE("AVRCP Disconnect - Success",
+	TEST_CASE_BREDRLE("AVRCP Connect/Disconnect - Success",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
@@ -399,6 +382,11 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(avrcp_get_play_status_rsp, NULL),
 		CALLBACK_RC_PLAY_STATUS(CB_AVRCP_PLAY_STATUS_RSP, 0xbbbbbbbb,
 							0xaaaaaaaa, 0x00),
+		ACTION_SUCCESS(avrcp_disconnect_action, NULL),
+		CALLBACK_AV_CONN_STATE(CB_A2DP_CONN_STATE,
+					BTAV_CONNECTION_STATE_DISCONNECTING),
+		CALLBACK_AV_CONN_STATE(CB_A2DP_CONN_STATE,
+					BTAV_CONNECTION_STATE_DISCONNECTED),
 		ACTION_SUCCESS(bluetooth_disable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
 	),
@@ -421,6 +409,11 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(avrcp_reg_notif_track_changed_rsp, NULL),
 		CALLBACK_RC_REG_NOTIF_TRACK_CHANGED(CB_AVRCP_REG_NOTIF_RSP,
 							0xffffffffffffffff),
+		ACTION_SUCCESS(avrcp_disconnect_action, NULL),
+		CALLBACK_AV_CONN_STATE(CB_A2DP_CONN_STATE,
+					BTAV_CONNECTION_STATE_DISCONNECTING),
+		CALLBACK_AV_CONN_STATE(CB_A2DP_CONN_STATE,
+					BTAV_CONNECTION_STATE_DISCONNECTED),
 		ACTION_SUCCESS(bluetooth_disable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
 	),
@@ -443,6 +436,11 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(avrcp_get_element_attributes_rsp, NULL),
 		CALLBACK_RC_GET_ELEMENT_ATTRIBUTES(CB_AVRCP_GET_ATTR_RSP, 2,
 								ele_attrs),
+		ACTION_SUCCESS(avrcp_disconnect_action, NULL),
+		CALLBACK_AV_CONN_STATE(CB_A2DP_CONN_STATE,
+					BTAV_CONNECTION_STATE_DISCONNECTING),
+		CALLBACK_AV_CONN_STATE(CB_A2DP_CONN_STATE,
+					BTAV_CONNECTION_STATE_DISCONNECTED),
 		ACTION_SUCCESS(bluetooth_disable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
 	),
-- 
1.9.3

