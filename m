Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv4 01/13] android/tester: Replace gatt-tester's pdu structs with io vectors
Date: Thu,  2 Oct 2014 10:10:49 +0200
Message-Id: <1412237461-20373-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1412237461-20373-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1412237461-20373-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is the first step in unifying the way pdu is handled.
---
 android/tester-gatt.c | 81 ++++++++++++++++++++++++---------------------------
 1 file changed, 38 insertions(+), 43 deletions(-)

diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index 693a8a3..6b7eaf9 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -34,23 +34,18 @@
 #define CONN1_ID	1
 #define CONN2_ID	2
 
-#define data(args...) ((const unsigned char[]) { args })
+#define raw_data(args...) ((unsigned char[]) { args })
 
 #define raw_pdu(args...)					\
 	{							\
-		.data = data(args),				\
-		.size = sizeof(data(args)),			\
+		.iov_base = raw_data(args),			\
+		.iov_len = sizeof(raw_data(args)),		\
 	}
 
-#define end_pdu { .data = NULL }
+#define end_pdu { .iov_base = NULL }
 
 static struct queue *list; /* List of gatt test cases */
 
-struct pdu {
-	const uint8_t *data;
-	uint16_t size;
-};
-
 static bt_uuid_t app1_uuid = {
 	.uu = { 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01,
 				0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01 },
@@ -161,8 +156,8 @@ static struct gatt_search_service_data search_services_1 = {
 	.filter_uuid = NULL,
 };
 
-static const uint8_t exchange_mtu_req_pdu[] = { 0x02, 0xa0, 0x02 };
-static const uint8_t exchange_mtu_resp_pdu[] = { 0x03, 0xa0, 0x02 };
+static const struct iovec exchange_mtu_req_pdu = raw_pdu(0x02, 0xa0, 0x02);
+static const struct iovec exchange_mtu_resp_pdu = raw_pdu(0x03, 0xa0, 0x02);
 
 static struct bt_action_data bearer_type = {
 	.bearer_type = BDADDR_LE_PUBLIC,
@@ -392,7 +387,7 @@ static struct set_write_params set_write_param_3 = {
 	.status = 0x01
 };
 
-static struct pdu search_service[] = {
+static struct iovec search_service[] = {
 	raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
 	raw_pdu(0x11, 0x06, 0x01, 0x00, 0x10, 0x00, 0x00, 0x18),
 	raw_pdu(0x10, 0x11, 0x00, 0xff, 0xff, 0x00, 0x28),
@@ -400,7 +395,7 @@ static struct pdu search_service[] = {
 	end_pdu
 };
 
-static struct pdu search_service_2[] = {
+static struct iovec search_service_2[] = {
 	raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
 	raw_pdu(0x11, 0x06, 0x01, 0x00, 0x10, 0x00, 0x00, 0x18),
 	raw_pdu(0x10, 0x11, 0x00, 0xff, 0xff, 0x00, 0x28),
@@ -410,13 +405,13 @@ static struct pdu search_service_2[] = {
 	end_pdu
 };
 
-static struct pdu search_service_3[] = {
+static struct iovec search_service_3[] = {
 	raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
 	raw_pdu(0x01, 0x08, 0x01, 0x00, 0x0a),
 	end_pdu
 };
 
-static struct pdu get_characteristic_1[] = {
+static struct iovec get_characteristic_1[] = {
 	raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
 	raw_pdu(0x11, 0x06, 0x01, 0x00, 0x10, 0x00, 0x00, 0x18),
 	raw_pdu(0x10, 0x11, 0x00, 0xff, 0xff, 0x00, 0x28),
@@ -428,7 +423,7 @@ static struct pdu get_characteristic_1[] = {
 	end_pdu
 };
 
-static struct pdu get_descriptor_1[] = {
+static struct iovec get_descriptor_1[] = {
 	raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
 	raw_pdu(0x11, 0x06, 0x01, 0x00, 0x10, 0x00, 0x00, 0x18),
 	raw_pdu(0x10, 0x11, 0x00, 0xff, 0xff, 0x00, 0x28),
@@ -444,7 +439,7 @@ static struct pdu get_descriptor_1[] = {
 	end_pdu
 };
 
-static struct pdu get_descriptor_2[] = {
+static struct iovec get_descriptor_2[] = {
 	raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
 	raw_pdu(0x11, 0x06, 0x01, 0x00, 0x10, 0x00, 0x00, 0x18),
 	raw_pdu(0x10, 0x11, 0x00, 0xff, 0xff, 0x00, 0x28),
@@ -460,7 +455,7 @@ static struct pdu get_descriptor_2[] = {
 	end_pdu
 };
 
-static struct pdu get_descriptor_3[] = {
+static struct iovec get_descriptor_3[] = {
 	raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
 	raw_pdu(0x11, 0x06, 0x01, 0x00, 0x10, 0x00, 0x00, 0x18),
 	raw_pdu(0x10, 0x11, 0x00, 0xff, 0xff, 0x00, 0x28),
@@ -474,7 +469,7 @@ static struct pdu get_descriptor_3[] = {
 	end_pdu
 };
 
-static struct pdu get_included_1[] = {
+static struct iovec get_included_1[] = {
 	raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
 	raw_pdu(0x11, 0x06, 0x01, 0x00, 0x10, 0x00, 0x00, 0x18),
 	raw_pdu(0x10, 0x11, 0x00, 0xff, 0xff, 0x00, 0x28),
@@ -486,7 +481,7 @@ static struct pdu get_included_1[] = {
 	end_pdu
 };
 
-static struct pdu get_included_2[] = {
+static struct iovec get_included_2[] = {
 	raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
 	raw_pdu(0x11, 0x06, 0x01, 0x00, 0x10, 0x00, 0x00, 0x18),
 	raw_pdu(0x10, 0x11, 0x00, 0xff, 0xff, 0x00, 0x28),
@@ -501,7 +496,7 @@ static struct pdu get_included_2[] = {
 	end_pdu
 };
 
-static struct pdu get_included_3[] = {
+static struct iovec get_included_3[] = {
 	raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
 	raw_pdu(0x11, 0x06, 0x01, 0x00, 0x10, 0x00, 0x00, 0x18),
 	raw_pdu(0x10, 0x11, 0x00, 0xff, 0xff, 0x00, 0x28),
@@ -511,7 +506,7 @@ static struct pdu get_included_3[] = {
 	end_pdu
 };
 
-static struct pdu read_characteristic_1[] = {
+static struct iovec read_characteristic_1[] = {
 	raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
 	raw_pdu(0x11, 0x06, 0x01, 0x00, 0x10, 0x00, 0x00, 0x18),
 	raw_pdu(0x10, 0x11, 0x00, 0xff, 0xff, 0x00, 0x28),
@@ -525,7 +520,7 @@ static struct pdu read_characteristic_1[] = {
 	end_pdu
 };
 
-static struct pdu read_characteristic_2[] = {
+static struct iovec read_characteristic_2[] = {
 	raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
 	raw_pdu(0x11, 0x06, 0x01, 0x00, 0x10, 0x00, 0x00, 0x18),
 	raw_pdu(0x10, 0x11, 0x00, 0xff, 0xff, 0x00, 0x28),
@@ -539,7 +534,7 @@ static struct pdu read_characteristic_2[] = {
 	end_pdu
 };
 
-static struct pdu read_descriptor_1[] = {
+static struct iovec read_descriptor_1[] = {
 	raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
 	raw_pdu(0x11, 0x06, 0x01, 0x00, 0x10, 0x00, 0x00, 0x18),
 	raw_pdu(0x10, 0x11, 0x00, 0xff, 0xff, 0x00, 0x28),
@@ -557,7 +552,7 @@ static struct pdu read_descriptor_1[] = {
 	end_pdu
 };
 
-static struct pdu read_descriptor_2[] = {
+static struct iovec read_descriptor_2[] = {
 	raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
 	raw_pdu(0x11, 0x06, 0x01, 0x00, 0x10, 0x00, 0x00, 0x18),
 	raw_pdu(0x10, 0x11, 0x00, 0xff, 0xff, 0x00, 0x28),
@@ -575,7 +570,7 @@ static struct pdu read_descriptor_2[] = {
 	end_pdu
 };
 
-static struct pdu write_characteristic_1[] = {
+static struct iovec write_characteristic_1[] = {
 	raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
 	raw_pdu(0x11, 0x06, 0x01, 0x00, 0x10, 0x00, 0x00, 0x18),
 	raw_pdu(0x10, 0x11, 0x00, 0xff, 0xff, 0x00, 0x28),
@@ -588,7 +583,7 @@ static struct pdu write_characteristic_1[] = {
 	end_pdu
 };
 
-static struct pdu write_characteristic_2[] = {
+static struct iovec write_characteristic_2[] = {
 	raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
 	raw_pdu(0x11, 0x06, 0x01, 0x00, 0x10, 0x00, 0x00, 0x18),
 	raw_pdu(0x10, 0x11, 0x00, 0xff, 0xff, 0x00, 0x28),
@@ -602,7 +597,7 @@ static struct pdu write_characteristic_2[] = {
 	end_pdu
 };
 
-static struct pdu write_characteristic_3[] = {
+static struct iovec write_characteristic_3[] = {
 	raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
 	raw_pdu(0x11, 0x06, 0x01, 0x00, 0x10, 0x00, 0x00, 0x18),
 	raw_pdu(0x10, 0x11, 0x00, 0xff, 0xff, 0x00, 0x28),
@@ -871,16 +866,16 @@ static void gatt_cid_hook_cb(const void *data, uint16_t len, void *user_data)
 	struct bthost *bthost = hciemu_client_get_host(t_data->hciemu);
 	struct emu_cid_data *cid_data = user_data;
 	const uint8_t *pdu = data;
-	struct pdu *gatt_pdu = queue_peek_head(t_data->pdus);
+	struct iovec *gatt_pdu = queue_peek_head(t_data->pdus);
 
 	switch (pdu[0]) {
 	case L2CAP_ATT_EXCHANGE_MTU_REQ:
 		tester_print("Exchange MTU request received.");
 
-		if (!memcmp(exchange_mtu_req_pdu, pdu, len))
-			bthost_send_cid(bthost, cid_data->handle, cid_data->cid,
-						exchange_mtu_resp_pdu,
-						sizeof(exchange_mtu_resp_pdu));
+		if (!memcmp(exchange_mtu_req_pdu.iov_base, pdu, len))
+			bthost_send_cid_v(bthost, cid_data->handle,
+						cid_data->cid,
+						&exchange_mtu_resp_pdu, 1);
 
 		break;
 	case L2CAP_ATT_EXCHANGE_MTU_RSP:
@@ -888,29 +883,29 @@ static void gatt_cid_hook_cb(const void *data, uint16_t len, void *user_data)
 
 		break;
 	default:
-		if (!gatt_pdu || !gatt_pdu->data) {
+		if (!gatt_pdu || !gatt_pdu->iov_base) {
 			tester_print("Unknown ATT packet.");
 			break;
 		}
 
-		if (gatt_pdu->size != len) {
+		if (gatt_pdu->iov_len != len) {
 			tester_print("Size of incoming frame is not valid");
-			tester_print("Expected size = %d incoming size = %d",
-							gatt_pdu->size, len);
+			tester_print("Expected size = %zd incoming size = %d",
+							gatt_pdu->iov_len, len);
 			break;
 		}
 
-		if (memcmp(gatt_pdu->data, data, len)) {
+		if (memcmp(gatt_pdu->iov_base, data, len)) {
 			tester_print("Incoming data mismatch");
 			break;
 		}
 		queue_pop_head(t_data->pdus);
 		gatt_pdu = queue_pop_head(t_data->pdus);
-		if (!gatt_pdu || !gatt_pdu->data)
+		if (!gatt_pdu || !gatt_pdu->iov_base)
 			break;
 
-		bthost_send_cid(bthost, cid_data->handle, cid_data->cid,
-						gatt_pdu->data, gatt_pdu->size);
+		bthost_send_cid_v(bthost, cid_data->handle, cid_data->cid,
+								gatt_pdu, 1);
 
 		break;
 	}
@@ -957,9 +952,9 @@ static void init_pdus(void)
 	struct test_data *data = tester_get_data();
 	struct step *current_data_step = queue_peek_head(data->steps);
 	struct step *step = g_new0(struct step, 1);
-	struct pdu *pdu = current_data_step->set_data;
+	struct iovec *pdu = current_data_step->set_data;
 
-	while (pdu->data) {
+	while (pdu->iov_base) {
 		queue_push_tail(data->pdus, pdu);
 		pdu++;
 	}
-- 
1.9.1

