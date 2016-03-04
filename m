Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] shared/gatt-client: Don't send Exchange MTU for default value
Date: Fri,  4 Mar 2016 14:24:26 +0200
Message-Id: <1457094267-5925-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If the MTU to be exchange is the default there is no pointing in sending
it since the remote already assumes it anyway.
---
 src/shared/gatt-client.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index b255175..45acf7b 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -1544,6 +1544,11 @@ static bool gatt_client_init(struct bt_gatt_client *client, uint16_t mtu)
 	if (!op)
 		return false;
 
+	/* Check if MTU needs to be send */
+	mtu = MAX(BT_ATT_DEFAULT_LE_MTU, mtu);
+	if (mtu == BT_ATT_DEFAULT_LE_MTU)
+		goto discover;
+
 	/* Configure the MTU */
 	client->mtu_req_id = bt_gatt_exchange_mtu(client->att,
 						MAX(BT_ATT_DEFAULT_LE_MTU, mtu),
@@ -1558,6 +1563,20 @@ static bool gatt_client_init(struct bt_gatt_client *client, uint16_t mtu)
 	client->in_init = true;
 
 	return true;
+
+discover:
+	client->discovery_req = bt_gatt_discover_all_primary_services(
+							client->att, NULL,
+							discover_primary_cb,
+							discovery_op_ref(op),
+							discovery_op_unref);
+	if (!client->discovery_req) {
+		discovery_op_free(op);
+		return false;
+	}
+
+	client->in_init = true;
+	return true;
 }
 
 struct pdu_data {
-- 
2.5.0

