Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv2 16/16] android-tester: Use generic connect callback for simple cases
Date: Fri, 26 Sep 2014 08:31:17 +0200
Message-Id: <1411713077-19757-17-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1411713077-19757-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1411713077-19757-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is usefull when no custom behavior and just simple pdu exchange
is needed.
---
 android/tester-avrcp.c   | 13 +------------
 android/tester-hdp.c     | 32 ++------------------------------
 android/tester-hidhost.c | 12 +-----------
 android/tester-main.c    | 10 ++++++++++
 android/tester-main.h    |  1 +
 android/tester-pan.c     | 13 +------------
 6 files changed, 16 insertions(+), 65 deletions(-)

diff --git a/android/tester-avrcp.c b/android/tester-avrcp.c
index 4a49bb0..a2ceff6 100644
--- a/android/tester-avrcp.c
+++ b/android/tester-avrcp.c
@@ -138,20 +138,9 @@ static struct emu_set_l2cap_data a2dp_setup_data = {
 	.user_data = &a2dp_data,
 };
 
-static void sdp_connect_request_cb(uint16_t handle, uint16_t cid,
-							void *user_data)
-{
-	struct emu_l2cap_cid_data *cid_data = user_data;
-
-	cid_data->handle = handle;
-	cid_data->cid = cid;
-
-	tester_handle_l2cap_data_exchange(cid_data);
-}
-
 static struct emu_set_l2cap_data sdp_setup_data = {
 	.psm = 1,
-	.func = sdp_connect_request_cb,
+	.func = tester_generic_connect_cb,
 	.user_data = &sdp_data,
 };
 
diff --git a/android/tester-hdp.c b/android/tester-hdp.c
index f021943..c9c5a78 100644
--- a/android/tester-hdp.c
+++ b/android/tester-hdp.c
@@ -243,16 +243,6 @@ static void hdp_unregister_app_action(void)
 	schedule_action_verification(step);
 }
 
-static void hdp_sdp_search_cb(uint16_t handle, uint16_t cid, void *user_data)
-{
-	struct emu_l2cap_cid_data *cid_data = user_data;
-
-	cid_data->handle = handle;
-	cid_data->cid = cid;
-
-	tester_handle_l2cap_data_exchange(cid_data);
-}
-
 static void mcap_ctrl_cid_hook_cb(const void *data, uint16_t len,
 							void *user_data)
 {
@@ -315,28 +305,10 @@ static void mcap_ctrl_connect_cb(uint16_t handle, uint16_t cid, void *user_data)
 								cid_data);
 }
 
-static void mcap_data_cid_hook_cb(const void *data, uint16_t len,
-							void *user_data)
-{
-}
-
-static void mcap_data_connect_cb(uint16_t handle, uint16_t cid, void *user_data)
-{
-	struct test_data *data = tester_get_data();
-	struct bthost *bthost = hciemu_client_get_host(data->hciemu);
-	struct emu_l2cap_cid_data *cid_data = user_data;
-
-	cid_data->handle = handle;
-	cid_data->cid = cid;
-
-	bthost_add_cid_hook(bthost, handle, cid, mcap_data_cid_hook_cb,
-								cid_data);
-}
-
 /* Emulate SDP (PSM = 1) */
 static struct emu_set_l2cap_data l2cap_setup_sdp_data = {
 	.psm = 1,
-	.func = hdp_sdp_search_cb,
+	.func = tester_generic_connect_cb,
 	.user_data = &sdp_cid_data,
 };
 
@@ -350,7 +322,7 @@ static struct emu_set_l2cap_data l2cap_setup_cc_data = {
 /* Emulate Data Channel (PSM = 0x1003) */
 static struct emu_set_l2cap_data l2cap_setup_dc_data = {
 	.psm = 0x1003,
-	.func = mcap_data_connect_cb,
+	.func = tester_generic_connect_cb,
 	.user_data = &data_cid_data,
 };
 
diff --git a/android/tester-hidhost.c b/android/tester-hidhost.c
index 9ee026a..4c8b4c6 100644
--- a/android/tester-hidhost.c
+++ b/android/tester-hidhost.c
@@ -135,16 +135,6 @@ static struct emu_l2cap_cid_data sdp_cid_data = {
 static struct emu_l2cap_cid_data ctrl_cid_data;
 static struct emu_l2cap_cid_data intr_cid_data;
 
-static void hid_sdp_search_cb(uint16_t handle, uint16_t cid, void *user_data)
-{
-	struct emu_l2cap_cid_data *cid_data = user_data;
-
-	cid_data->handle = handle;
-	cid_data->cid = cid;
-
-	tester_handle_l2cap_data_exchange(cid_data);
-}
-
 static void hid_prepare_reply_protocol_mode(struct emu_l2cap_cid_data *cid_data)
 {
 	struct test_data *t_data = tester_get_data();
@@ -247,7 +237,7 @@ static void hid_intr_connect_cb(uint16_t handle, uint16_t cid, void *user_data)
 /* Emulate SDP (PSM = 1) */
 static struct emu_set_l2cap_data l2cap_setup_sdp_data = {
 	.psm = 1,
-	.func = hid_sdp_search_cb,
+	.func = tester_generic_connect_cb,
 	.user_data = &sdp_cid_data,
 };
 
diff --git a/android/tester-main.c b/android/tester-main.c
index d2bf3d8..c9b8a10 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -2059,6 +2059,16 @@ void tester_handle_l2cap_data_exchange(struct emu_l2cap_cid_data *cid_data)
 					emu_generic_cid_hook_cb, cid_data);
 }
 
+void tester_generic_connect_cb(uint16_t handle, uint16_t cid, void *user_data)
+{
+	struct emu_l2cap_cid_data *cid_data = user_data;
+
+	cid_data->handle = handle;
+	cid_data->cid = cid;
+
+	tester_handle_l2cap_data_exchange(cid_data);
+}
+
 static void rfcomm_connect_cb(uint16_t handle, uint16_t cid, void *user_data,
 								bool status)
 {
diff --git a/android/tester-main.h b/android/tester-main.h
index 167d5d1..a27fa38 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -514,6 +514,7 @@ struct test_case {
 };
 
 void tester_handle_l2cap_data_exchange(struct emu_l2cap_cid_data *cid_data);
+void tester_generic_connect_cb(uint16_t handle, uint16_t cid, void *user_data);
 
 /* Get, remove test cases API */
 struct queue *get_bluetooth_tests(void);
diff --git a/android/tester-pan.c b/android/tester-pan.c
index 503b9ed..4c9354a 100644
--- a/android/tester-pan.c
+++ b/android/tester-pan.c
@@ -35,20 +35,9 @@ static struct emu_l2cap_cid_data cid_data = {
 	.pdu = pdus,
 };
 
-static void pan_connect_request_cb(uint16_t handle, uint16_t cid,
-							void *user_data)
-{
-	struct emu_l2cap_cid_data *cid_data = user_data;
-
-	cid_data->handle = handle;
-	cid_data->cid = cid;
-
-	tester_handle_l2cap_data_exchange(cid_data);
-}
-
 static struct emu_set_l2cap_data l2cap_setup_data = {
 	.psm = 15,
-	.func = pan_connect_request_cb,
+	.func = tester_generic_connect_cb,
 	.user_data = &cid_data,
 };
 
-- 
1.9.1

