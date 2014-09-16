Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 4/8] android/tester: Make GATT tests use generic pdu struct
Date: Tue, 16 Sep 2014 10:49:33 +0200
Message-Id: <1410857377-3162-5-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1410857377-3162-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1410857377-3162-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/tester-gatt.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index 3b7297c..5defce0 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -120,8 +120,8 @@ static struct gatt_search_service_data search_services_1 = {
 	.filter_uuid = NULL,
 };
 
-static const uint8_t exchange_mtu_req_pdu[] = { 0x02, 0xa0, 0x02 };
-static const uint8_t exchange_mtu_resp_pdu[] = { 0x03, 0xa0, 0x02 };
+static const struct pdu exchange_mtu_req_pdu = raw_pdu(0x02, 0xa0, 0x02);
+static const struct pdu exchange_mtu_resp_pdu = raw_pdu(0x03, 0xa0, 0x02);
 
 static struct bt_action_data bearer_type = {
 	.bearer_type = BDADDR_LE_PUBLIC,
@@ -501,10 +501,10 @@ static void gatt_cid_hook_cb(const void *data, uint16_t len, void *user_data)
 	case L2CAP_ATT_EXCHANGE_MTU_REQ:
 		tester_print("Exchange MTU request received.");
 
-		if (!memcmp(exchange_mtu_req_pdu, pdu, len))
+		if (!memcmp(exchange_mtu_req_pdu.data, pdu, len))
 			bthost_send_cid(bthost, cid_data->handle, cid_data->cid,
-						exchange_mtu_resp_pdu,
-						sizeof(exchange_mtu_resp_pdu));
+						exchange_mtu_resp_pdu.data,
+						exchange_mtu_resp_pdu.size);
 
 		break;
 	case L2CAP_ATT_EXCHANGE_MTU_RSP:
-- 
1.9.3

