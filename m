Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv3 03/17] android/tester: Make A2DP tests use generic pdu struct
Date: Wed,  1 Oct 2014 11:01:25 +0200
Message-Id: <1412154099-28014-4-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1412154099-28014-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1412154099-28014-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/tester-a2dp.c | 68 +++++++++++++++++++++++++--------------------------
 1 file changed, 33 insertions(+), 35 deletions(-)

diff --git a/android/tester-a2dp.c b/android/tester-a2dp.c
index ab3936e..047822e 100644
--- a/android/tester-a2dp.c
+++ b/android/tester-a2dp.c
@@ -32,38 +32,36 @@ struct emu_cid_data {
 
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
+#define req_dsc		0x00, 0x01
+#define rsp_dsc		0x02, 0x01, 0x04, 0x08
+#define req_get		0x10, 0x02, 0x04
+#define rsp_get		0x12, 0x02, 0x01, 0x00, 0x07, 0x06, 0x00, \
+						0x00, 0xff, 0xff, 0x02, 0x40
+#define req_cfg		0x20, 0x03, 0x04, 0x04, 0x01, 0x00, 0x07, \
+					0x06, 0x00, 0x00, 0x21, 0x15, 0x02, \
+					0x40
+#define rsp_cfg		0x22, 0x03
+#define req_open	0x30, 0x06, 0x04
+#define rsp_open	0x32, 0x06
+#define req_close	0x40, 0x08, 0x04
+#define rsp_close	0x42, 0x08
+#define req_start	0x40, 0x07, 0x04
+#define rsp_start	0x42, 0x07
+#define req_suspend	0x50, 0x09, 0x04
+#define rsp_suspend	0x52, 0x09
 
 const struct pdu_set {
-	const uint8_t *req;
-	size_t req_len;
-	const uint8_t *rsp;
-	size_t rsp_len;
+	struct pdu req;
+	struct pdu rsp;
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
 
 static void print_data(const char *str, void *user_data)
@@ -80,18 +78,18 @@ static void a2dp_cid_hook_cb(const void *data, uint16_t len, void *user_data)
 
 	util_hexdump('>', data, len, print_data, NULL);
 
-	for (i = 0; pdus[i].req; i++) {
-		if (pdus[i].req_len != len)
+	for (i = 0; pdus[i].req.data; i++) {
+		if (pdus[i].req.size != len)
 			continue;
 
-		if (memcmp(pdus[i].req, data, len))
+		if (memcmp(pdus[i].req.data, data, len))
 			continue;
 
-		util_hexdump('<', pdus[i].rsp, pdus[i].rsp_len, print_data,
-									NULL);
+		util_hexdump('<', pdus[i].rsp.data, pdus[i].rsp.size,
+							print_data, NULL);
 
 		bthost_send_cid(bthost, cid_data->handle, cid_data->cid,
-						pdus[i].rsp, pdus[i].rsp_len);
+					pdus[i].rsp.data, pdus[i].rsp.size);
 	}
 }
 
-- 
1.9.1

