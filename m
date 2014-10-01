Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv3 11/17] android/tester: Make AVRCP tests use generic pdu exchange mechanism
Date: Wed,  1 Oct 2014 11:01:33 +0200
Message-Id: <1412154099-28014-12-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1412154099-28014-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1412154099-28014-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

sdp_pdus is not constant as transaction ID is always overwritten before
SDP response is sent. This is to avoid using intermediate buffers.
---
 android/tester-avrcp.c | 112 +++++++++++++++++--------------------------------
 1 file changed, 38 insertions(+), 74 deletions(-)

diff --git a/android/tester-avrcp.c b/android/tester-avrcp.c
index 647c0fd..4a49bb0 100644
--- a/android/tester-avrcp.c
+++ b/android/tester-avrcp.c
@@ -24,35 +24,35 @@
 
 static struct queue *list;
 
-struct emu_cid_data {
-	uint16_t handle;
-	uint16_t cid;
+#define sdp_rsp_pdu	0x07, \
+			0x00, 0x00, \
+			0x00, 0x7f, \
+			0x00, 0x7c, \
+			0x36, 0x00, 0x79, 0x36, 0x00, 0x3b, 0x09, 0x00, 0x00, \
+			0x0a, 0x00, 0x01, 0x00, 0x04, 0x09, 0x00, 0x01, 0x35, \
+			0x06, 0x19, 0x11, 0x0e, 0x19, 0x11, 0x0f, 0x09, 0x00, \
+			0x04, 0x35, 0x10, 0x35, 0x06, 0x19, 0x01, 0x00, 0x09, \
+			0x00, 0x17, 0x35, 0x06, 0x19, 0x00, 0x17, 0x09, 0x01, \
+			0x03, 0x09, 0x00, 0x09, 0x35, 0x08, 0x35, 0x06, 0x19, \
+			0x11, 0x0e, 0x09, 0x01, 0x00, 0x09, 0x03, 0x11, 0x09, \
+			0x00, 0x01, 0x36, 0x00, 0x38, 0x09, 0x00, 0x00, 0x0a, \
+			0x00, 0x01, 0x00, 0x05, 0x09, 0x00, 0x01, 0x35, 0x03, \
+			0x19, 0x11, 0x0c, 0x09, 0x00, 0x04, 0x35, 0x10, 0x35, \
+			0x06, 0x19, 0x01, 0x00, 0x09, 0x00, 0x17, 0x35, 0x06, \
+			0x19, 0x00, 0x17, 0x09, 0x01, 0x03, 0x09, 0x00, 0x09, \
+			0x35, 0x08, 0x35, 0x06, 0x19, 0x11, 0x0e, 0x09, 0x01, \
+			0x04, 0x09, 0x03, 0x11, 0x09, 0x00, 0x02, \
+			0x00
+
+static struct pdu_set sdp_pdus[] = {
+	{ null_pdu, raw_pdu(sdp_rsp_pdu) },
+	{ null_pdu, null_pdu },
 };
 
-static struct emu_cid_data sdp_data;
-static struct emu_cid_data a2dp_data;
-static struct emu_cid_data avrcp_data;
-
-static struct pdu sdp_rsp_pdu = raw_pdu(
-			0x07, /* PDU id */
-			0x00, 0x00, /* Transaction id */
-			0x00, 0x7f, /* Response length */
-			0x00, 0x7c, /* Attributes length */
-			0x36, 0x00, 0x79, 0x36, 0x00, 0x3b, 0x09, 0x00, 0x00,
-			0x0a, 0x00, 0x01, 0x00, 0x04, 0x09, 0x00, 0x01, 0x35,
-			0x06, 0x19, 0x11, 0x0e, 0x19, 0x11, 0x0f, 0x09, 0x00,
-			0x04, 0x35, 0x10, 0x35, 0x06, 0x19, 0x01, 0x00, 0x09,
-			0x00, 0x17, 0x35, 0x06, 0x19, 0x00, 0x17, 0x09, 0x01,
-			0x03, 0x09, 0x00, 0x09, 0x35, 0x08, 0x35, 0x06, 0x19,
-			0x11, 0x0e, 0x09, 0x01, 0x00, 0x09, 0x03, 0x11, 0x09,
-			0x00, 0x01, 0x36, 0x00, 0x38, 0x09, 0x00, 0x00, 0x0a,
-			0x00, 0x01, 0x00, 0x05, 0x09, 0x00, 0x01, 0x35, 0x03,
-			0x19, 0x11, 0x0c, 0x09, 0x00, 0x04, 0x35, 0x10, 0x35,
-			0x06, 0x19, 0x01, 0x00, 0x09, 0x00, 0x17, 0x35, 0x06,
-			0x19, 0x00, 0x17, 0x09, 0x01, 0x03, 0x09, 0x00, 0x09,
-			0x35, 0x08, 0x35, 0x06, 0x19, 0x11, 0x0e, 0x09, 0x01,
-			0x04, 0x09, 0x03, 0x11, 0x09, 0x00, 0x02,
-			0x00); /* no continuation */
+static struct emu_l2cap_cid_data sdp_data = {
+	.pdu = sdp_pdus,
+	.is_sdp = TRUE,
+};
 
 #define req_dsc 0x00, 0x01
 #define rsp_dsc 0x02, 0x01, 0x04, 0x08
@@ -83,6 +83,12 @@ static struct pdu_set pdus[] = {
 	{ null_pdu, null_pdu },
 };
 
+static struct emu_l2cap_cid_data a2dp_data = {
+	.pdu = pdus,
+};
+
+static struct emu_l2cap_cid_data avrcp_data;
+
 static void print_avrcp(const char *str, void *user_data)
 {
 	tester_debug("avrcp: %s", str);
@@ -98,7 +104,7 @@ static void avrcp_connect_request_cb(uint16_t handle, uint16_t cid,
 {
 	struct test_data *data = tester_get_data();
 	struct bthost *bthost = hciemu_client_get_host(data->hciemu);
-	struct emu_cid_data *cid_data = user_data;
+	struct emu_l2cap_cid_data *cid_data = user_data;
 
 	cid_data->handle = handle;
 	cid_data->cid = cid;
@@ -112,41 +118,10 @@ static struct emu_set_l2cap_data avrcp_setup_data = {
 	.user_data = &avrcp_data,
 };
 
-static void print_a2dp(const char *str, void *user_data)
-{
-	tester_debug("a2dp: %s", str);
-}
-
-static void a2dp_cid_hook_cb(const void *data, uint16_t len, void *user_data)
-{
-	struct emu_cid_data *cid_data = user_data;
-	struct test_data *t_data = tester_get_data();
-	struct bthost *bthost = hciemu_client_get_host(t_data->hciemu);
-	int i;
-
-	util_hexdump('>', data, len, print_a2dp, NULL);
-
-	for (i = 0; pdus[i].req.data; i++) {
-		if (pdus[i].req.size != len)
-			continue;
-
-		if (memcmp(pdus[i].req.data, data, len))
-			continue;
-
-		util_hexdump('<', pdus[i].rsp.data, pdus[i].rsp.size,
-							print_a2dp, NULL);
-
-		bthost_send_cid(bthost, cid_data->handle, cid_data->cid,
-					pdus[i].rsp.data, pdus[i].rsp.size);
-	}
-}
-
 static void a2dp_connect_request_cb(uint16_t handle, uint16_t cid,
 							void *user_data)
 {
-	struct test_data *data = tester_get_data();
-	struct bthost *bthost = hciemu_client_get_host(data->hciemu);
-	struct emu_cid_data *cid_data = user_data;
+	struct emu_l2cap_cid_data *cid_data = user_data;
 
 	if (cid_data->handle)
 		return;
@@ -154,7 +129,7 @@ static void a2dp_connect_request_cb(uint16_t handle, uint16_t cid,
 	cid_data->handle = handle;
 	cid_data->cid = cid;
 
-	bthost_add_cid_hook(bthost, handle, cid, a2dp_cid_hook_cb, cid_data);
+	tester_handle_l2cap_data_exchange(cid_data);
 }
 
 static struct emu_set_l2cap_data a2dp_setup_data = {
@@ -163,26 +138,15 @@ static struct emu_set_l2cap_data a2dp_setup_data = {
 	.user_data = &a2dp_data,
 };
 
-static void sdp_cid_hook_cb(const void *data, uint16_t len, void *user_data)
-{
-	struct test_data *t_data = tester_get_data();
-	struct bthost *bthost = hciemu_client_get_host(t_data->hciemu);
-	struct emu_cid_data *cid_data = user_data;
-
-	bthost_send_cid(bthost, cid_data->handle, cid_data->cid,
-					sdp_rsp_pdu.data, sdp_rsp_pdu.size);
-}
 static void sdp_connect_request_cb(uint16_t handle, uint16_t cid,
 							void *user_data)
 {
-	struct test_data *data = tester_get_data();
-	struct bthost *bthost = hciemu_client_get_host(data->hciemu);
-	struct emu_cid_data *cid_data = user_data;
+	struct emu_l2cap_cid_data *cid_data = user_data;
 
 	cid_data->handle = handle;
 	cid_data->cid = cid;
 
-	bthost_add_cid_hook(bthost, handle, cid, sdp_cid_hook_cb, cid_data);
+	tester_handle_l2cap_data_exchange(cid_data);
 }
 
 static struct emu_set_l2cap_data sdp_setup_data = {
-- 
1.9.1

