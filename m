Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv3 02/17] android/tester: Make AVRCP tests use generic pdu struct
Date: Wed,  1 Oct 2014 11:01:24 +0200
Message-Id: <1412154099-28014-3-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1412154099-28014-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1412154099-28014-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

SDP pdus are made not const, so that transaction ID can be replaced
in-place just before response to SDP request is send.
---
 android/tester-avrcp.c | 76 +++++++++++++++++++++++++-------------------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/android/tester-avrcp.c b/android/tester-avrcp.c
index b539e0e..fab6dfc 100644
--- a/android/tester-avrcp.c
+++ b/android/tester-avrcp.c
@@ -34,7 +34,8 @@ static struct emu_cid_data sdp_data;
 static struct emu_cid_data a2dp_data;
 static struct emu_cid_data avrcp_data;
 
-static const uint8_t sdp_rsp_pdu[] = { 0x07, /* PDU id */
+static struct pdu sdp_rsp_pdu = raw_pdu(
+			0x07, /* PDU id */
 			0x00, 0x00, /* Transaction id */
 			0x00, 0x7f, /* Response length */
 			0x00, 0x7c, /* Attributes length */
@@ -52,39 +53,38 @@ static const uint8_t sdp_rsp_pdu[] = { 0x07, /* PDU id */
 			0x19, 0x00, 0x17, 0x09, 0x01, 0x03, 0x09, 0x00, 0x09,
 			0x35, 0x08, 0x35, 0x06, 0x19, 0x11, 0x0e, 0x09, 0x01,
 			0x04, 0x09, 0x03, 0x11, 0x09, 0x00, 0x02,
-			0x00}; /* no continuation */
-static const uint8_t req_dsc[] = { 0x00, 0x01 };
-static const uint8_t rsp_dsc[] = { 0x02, 0x01, 0x04, 0x08 };
-static const uint8_t req_get[] = { 0x10, 0x02, 0x04 };
-static const uint8_t rsp_get[] = { 0x12, 0x02, 0x01, 0x00, 0x07, 0x06, 0x00,
-						0x00, 0xff, 0xff, 0x02, 0x40 };
-static const uint8_t req_cfg[] = { 0x20, 0x03, 0x04, 0x04, 0x01, 0x00, 0x07,
-					0x06, 0x00, 0x00, 0x21, 0x15, 0x02,
-					0x40 };
-static const uint8_t rsp_cfg[] = { 0x22, 0x03 };
-static const uint8_t req_open[] = { 0x30, 0x06, 0x04 };
-static const uint8_t rsp_open[] = { 0x32, 0x06 };
-static const uint8_t req_close[] = { 0x40, 0x08, 0x04 };
-static const uint8_t rsp_close[] = { 0x42, 0x08 };
-static const uint8_t req_start[] = { 0x40, 0x07, 0x04 };
-static const uint8_t rsp_start[] = { 0x42, 0x07 };
-static const uint8_t req_suspend[] = { 0x50, 0x09, 0x04 };
-static const uint8_t rsp_suspend[] = { 0x52, 0x09 };
+			0x00); /* no continuation */
+
+#define req_dsc 0x00, 0x01
+#define rsp_dsc 0x02, 0x01, 0x04, 0x08
+#define req_get 0x10, 0x02, 0x04
+#define rsp_get 0x12, 0x02, 0x01, 0x00, 0x07, 0x06, 0x00, \
+						0x00, 0xff, 0xff, 0x02, 0x40
+#define req_cfg 0x20, 0x03, 0x04, 0x04, 0x01, 0x00, 0x07, \
+					0x06, 0x00, 0x00, 0x21, 0x15, 0x02, \
+					0x40
+#define rsp_cfg 0x22, 0x03
+#define req_open 0x30, 0x06, 0x04
+#define rsp_open 0x32, 0x06
+#define req_close 0x40, 0x08, 0x04
+#define rsp_close 0x42, 0x08
+#define req_start 0x40, 0x07, 0x04
+#define rsp_start 0x42, 0x07
+#define req_suspend 0x50, 0x09, 0x04
+#define rsp_suspend 0x52, 0x09
 
 static const struct pdu_set {
-	const uint8_t *req;
-	size_t req_len;
-	const uint8_t *rsp;
-	size_t rsp_len;
+	const struct pdu req;
+	const struct pdu rsp;
 } pdus[] = {
-	{ req_dsc, sizeof(req_dsc), rsp_dsc, sizeof(rsp_dsc) },
-	{ req_get, sizeof(req_get), rsp_get, sizeof(rsp_get) },
-	{ req_cfg, sizeof(req_cfg), rsp_cfg, sizeof(rsp_cfg) },
-	{ req_open, sizeof(req_open), rsp_open, sizeof(rsp_open) },
-	{ req_close, sizeof(req_close), rsp_close, sizeof(rsp_close) },
-	{ req_start, sizeof(req_start), rsp_start, sizeof(rsp_start) },
-	{ req_suspend, sizeof(req_suspend), rsp_suspend, sizeof(rsp_start) },
-	{ },
+	{ raw_pdu(req_dsc), raw_pdu(rsp_dsc) },
+	{ raw_pdu(req_get), raw_pdu(rsp_get) },
+	{ raw_pdu(req_cfg), raw_pdu(rsp_cfg) },
+	{ raw_pdu(req_open), raw_pdu(rsp_open) },
+	{ raw_pdu(req_close), raw_pdu(rsp_close) },
+	{ raw_pdu(req_start), raw_pdu(rsp_start) },
+	{ raw_pdu(req_suspend), raw_pdu(rsp_suspend) },
+	{ null_pdu, null_pdu },
 };
 
 static void print_avrcp(const char *str, void *user_data)
@@ -130,18 +130,18 @@ static void a2dp_cid_hook_cb(const void *data, uint16_t len, void *user_data)
 
 	util_hexdump('>', data, len, print_a2dp, NULL);
 
-	for (i = 0; pdus[i].req; i++) {
-		if (pdus[i].req_len != len)
+	for (i = 0; pdus[i].req.data; i++) {
+		if (pdus[i].req.size != len)
 			continue;
 
-		if (memcmp(pdus[i].req, data, len))
+		if (memcmp(pdus[i].req.data, data, len))
 			continue;
 
-		util_hexdump('<', pdus[i].rsp, pdus[i].rsp_len, print_a2dp,
-									NULL);
+		util_hexdump('<', pdus[i].rsp.data, pdus[i].rsp.size,
+							print_a2dp, NULL);
 
 		bthost_send_cid(bthost, cid_data->handle, cid_data->cid,
-						pdus[i].rsp, pdus[i].rsp_len);
+					pdus[i].rsp.data, pdus[i].rsp.size);
 	}
 }
 
@@ -174,7 +174,7 @@ static void sdp_cid_hook_cb(const void *data, uint16_t len, void *user_data)
 	struct emu_cid_data *cid_data = user_data;
 
 	bthost_send_cid(bthost, cid_data->handle, cid_data->cid,
-					sdp_rsp_pdu, sizeof(sdp_rsp_pdu));
+					sdp_rsp_pdu.data, sdp_rsp_pdu.size);
 }
 static void sdp_connect_request_cb(uint16_t handle, uint16_t cid,
 							void *user_data)
-- 
1.9.1

