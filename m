Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv3 04/17] android/tester: Make GATT tests use generic pdu struct
Date: Wed,  1 Oct 2014 11:01:26 +0200
Message-Id: <1412154099-28014-5-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1412154099-28014-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1412154099-28014-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/tester-gatt.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index 654ccd7..f182c56 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -146,8 +146,8 @@ static struct gatt_search_service_data search_services_1 = {
 	.filter_uuid = NULL,
 };
 
-static const uint8_t exchange_mtu_req_pdu[] = { 0x02, 0xa0, 0x02 };
-static const uint8_t exchange_mtu_resp_pdu[] = { 0x03, 0xa0, 0x02 };
+static const struct pdu exchange_mtu_req_pdu = raw_pdu(0x02, 0xa0, 0x02);
+static const struct pdu exchange_mtu_resp_pdu = raw_pdu(0x03, 0xa0, 0x02);
 
 static struct bt_action_data bearer_type = {
 	.bearer_type = BDADDR_LE_PUBLIC,
@@ -862,10 +862,10 @@ static void gatt_cid_hook_cb(const void *data, uint16_t len, void *user_data)
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
1.9.1

