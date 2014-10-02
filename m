Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv4 02/13] android/tester: Expose structs holding request pdu and response pdu
Date: Thu,  2 Oct 2014 10:10:50 +0200
Message-Id: <1412237461-20373-3-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1412237461-20373-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1412237461-20373-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This exposes the structs holding request and response pdus from a2dp
and avrcp testers and makes it available to other testers. It also
makes it use iovectors. Some helper macros were also extracted from
gatt tester and reused.
---
 android/tester-a2dp.c  | 73 +++++++++++++++++++++-----------------------
 android/tester-avrcp.c | 83 ++++++++++++++++++++++++--------------------------
 android/tester-gatt.c  | 10 ------
 android/tester-main.h  | 15 +++++++++
 4 files changed, 89 insertions(+), 92 deletions(-)

diff --git a/android/tester-a2dp.c b/android/tester-a2dp.c
index 1b2a8ce..1ff628e 100644
--- a/android/tester-a2dp.c
+++ b/android/tester-a2dp.c
@@ -32,38 +32,33 @@ struct emu_cid_data {
 
 static struct emu_cid_data cid_data;
 
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
-
-const struct pdu {
-	const uint8_t *req;
-	size_t req_len;
-	const uint8_t *rsp;
-	size_t rsp_len;
-} pdus[] = {
-	{ req_dsc, sizeof(req_dsc), rsp_dsc, sizeof(rsp_dsc) },
-	{ req_get, sizeof(req_get), rsp_get, sizeof(rsp_get) },
-	{ req_cfg, sizeof(req_cfg), rsp_cfg, sizeof(rsp_cfg) },
-	{ req_open, sizeof(req_open), rsp_open, sizeof(rsp_open) },
-	{ req_close, sizeof(req_close), rsp_close, sizeof(rsp_close) },
-	{ req_start, sizeof(req_start), rsp_start, sizeof(rsp_start) },
-	{ req_suspend, sizeof(req_suspend), rsp_suspend, sizeof(rsp_start) },
-	{ },
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
+
+static const struct pdu_set pdus[] = {
+	{ raw_pdu(req_dsc), raw_pdu(rsp_dsc) },
+	{ raw_pdu(req_get), raw_pdu(rsp_get) },
+	{ raw_pdu(req_cfg), raw_pdu(rsp_cfg) },
+	{ raw_pdu(req_open), raw_pdu(rsp_open) },
+	{ raw_pdu(req_close), raw_pdu(rsp_close) },
+	{ raw_pdu(req_start), raw_pdu(rsp_start) },
+	{ raw_pdu(req_suspend), raw_pdu(rsp_suspend) },
+	{ end_pdu, end_pdu },
 };
 
 static void print_data(const char *str, void *user_data)
@@ -80,18 +75,18 @@ static void a2dp_cid_hook_cb(const void *data, uint16_t len, void *user_data)
 
 	util_hexdump('>', data, len, print_data, NULL);
 
-	for (i = 0; pdus[i].req; i++) {
-		if (pdus[i].req_len != len)
+	for (i = 0; pdus[i].req.iov_base; i++) {
+		if (pdus[i].req.iov_len != len)
 			continue;
 
-		if (memcmp(pdus[i].req, data, len))
+		if (memcmp(pdus[i].req.iov_base, data, len))
 			continue;
 
-		util_hexdump('<', pdus[i].rsp, pdus[i].rsp_len, print_data,
-									NULL);
+		util_hexdump('<', pdus[i].rsp.iov_base, pdus[i].rsp.iov_len,
+							print_data, NULL);
 
-		bthost_send_cid(bthost, cid_data->handle, cid_data->cid,
-						pdus[i].rsp, pdus[i].rsp_len);
+		bthost_send_cid_v(bthost, cid_data->handle, cid_data->cid,
+							&pdus[i].rsp, 1);
 	}
 }
 
diff --git a/android/tester-avrcp.c b/android/tester-avrcp.c
index 07b95f5..dfcf801 100644
--- a/android/tester-avrcp.c
+++ b/android/tester-avrcp.c
@@ -34,7 +34,8 @@ static struct emu_cid_data sdp_data;
 static struct emu_cid_data a2dp_data;
 static struct emu_cid_data avrcp_data;
 
-static const uint8_t sdp_rsp_pdu[] = { 0x07, /* PDU id */
+static const struct iovec sdp_rsp_pdu = raw_pdu(
+			0x07, /* PDU id */
 			0x00, 0x00, /* Transaction id */
 			0x00, 0x7f, /* Response length */
 			0x00, 0x7c, /* Attributes length */
@@ -52,39 +53,35 @@ static const uint8_t sdp_rsp_pdu[] = { 0x07, /* PDU id */
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
-
-static const struct pdu {
-	const uint8_t *req;
-	size_t req_len;
-	const uint8_t *rsp;
-	size_t rsp_len;
-} pdus[] = {
-	{ req_dsc, sizeof(req_dsc), rsp_dsc, sizeof(rsp_dsc) },
-	{ req_get, sizeof(req_get), rsp_get, sizeof(rsp_get) },
-	{ req_cfg, sizeof(req_cfg), rsp_cfg, sizeof(rsp_cfg) },
-	{ req_open, sizeof(req_open), rsp_open, sizeof(rsp_open) },
-	{ req_close, sizeof(req_close), rsp_close, sizeof(rsp_close) },
-	{ req_start, sizeof(req_start), rsp_start, sizeof(rsp_start) },
-	{ req_suspend, sizeof(req_suspend), rsp_suspend, sizeof(rsp_start) },
-	{ },
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
+
+static const struct pdu_set pdus[] = {
+	{ raw_pdu(req_dsc), raw_pdu(rsp_dsc) },
+	{ raw_pdu(req_get), raw_pdu(rsp_get) },
+	{ raw_pdu(req_cfg), raw_pdu(rsp_cfg) },
+	{ raw_pdu(req_open), raw_pdu(rsp_open) },
+	{ raw_pdu(req_close), raw_pdu(rsp_close) },
+	{ raw_pdu(req_start), raw_pdu(rsp_start) },
+	{ raw_pdu(req_suspend), raw_pdu(rsp_suspend) },
+	{ end_pdu, end_pdu },
 };
 
 static void print_avrcp(const char *str, void *user_data)
@@ -130,18 +127,18 @@ static void a2dp_cid_hook_cb(const void *data, uint16_t len, void *user_data)
 
 	util_hexdump('>', data, len, print_a2dp, NULL);
 
-	for (i = 0; pdus[i].req; i++) {
-		if (pdus[i].req_len != len)
+	for (i = 0; pdus[i].req.iov_base; i++) {
+		if (pdus[i].req.iov_len != len)
 			continue;
 
-		if (memcmp(pdus[i].req, data, len))
+		if (memcmp(pdus[i].req.iov_base, data, len))
 			continue;
 
-		util_hexdump('<', pdus[i].rsp, pdus[i].rsp_len, print_a2dp,
-									NULL);
+		util_hexdump('<', pdus[i].rsp.iov_base, pdus[i].rsp.iov_len,
+							print_a2dp, NULL);
 
-		bthost_send_cid(bthost, cid_data->handle, cid_data->cid,
-						pdus[i].rsp, pdus[i].rsp_len);
+		bthost_send_cid_v(bthost, cid_data->handle, cid_data->cid,
+							&pdus[i].rsp, 1);
 	}
 }
 
@@ -173,8 +170,8 @@ static void sdp_cid_hook_cb(const void *data, uint16_t len, void *user_data)
 	struct bthost *bthost = hciemu_client_get_host(t_data->hciemu);
 	struct emu_cid_data *cid_data = user_data;
 
-	bthost_send_cid(bthost, cid_data->handle, cid_data->cid,
-					sdp_rsp_pdu, sizeof(sdp_rsp_pdu));
+	bthost_send_cid_v(bthost, cid_data->handle, cid_data->cid, &sdp_rsp_pdu,
+									1);
 }
 static void sdp_connect_request_cb(uint16_t handle, uint16_t cid,
 							void *user_data)
diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index 6b7eaf9..cb0b377 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -34,16 +34,6 @@
 #define CONN1_ID	1
 #define CONN2_ID	2
 
-#define raw_data(args...) ((unsigned char[]) { args })
-
-#define raw_pdu(args...)					\
-	{							\
-		.iov_base = raw_data(args),			\
-		.iov_len = sizeof(raw_data(args)),		\
-	}
-
-#define end_pdu { .iov_base = NULL }
-
 static struct queue *list; /* List of gatt test cases */
 
 static bt_uuid_t app1_uuid = {
diff --git a/android/tester-main.h b/android/tester-main.h
index e152ff3..3ebad2b 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -55,6 +55,21 @@
 #include <hardware/bt_gatt_client.h>
 #include <hardware/bt_gatt_server.h>
 
+struct pdu_set {
+	struct iovec req;
+	struct iovec rsp;
+};
+
+#define raw_data(args...) ((unsigned char[]) { args })
+
+#define raw_pdu(args...)					\
+	{							\
+		.iov_base = raw_data(args),			\
+		.iov_len = sizeof(raw_data(args)),		\
+	}
+
+#define end_pdu { .iov_base = NULL }
+
 #define TEST_CASE_BREDR(text, ...) { \
 		HCIEMU_TYPE_BREDR, \
 		text, \
-- 
1.9.1

