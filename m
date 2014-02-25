Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 10/17] Bluetooth: Connection parameters and auto connection
Date: Tue, 25 Feb 2014 18:01:37 -0300
Message-Id: <1393362104-12175-11-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1393362104-12175-1-git-send-email-andre.guedes@openbossa.org>
References: <1393362104-12175-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch modifies hci_conn_params_add() and hci_conn_params_del() so
they also add/delete pending LE connections according to the auto_
connect option. This way, background scan is automatically triggered/
untriggered when connection parameters are added/removed.

For instance, when a new connection parameters with HCI_AUTO_CONN_ALWAYS
option is added and we are not connected to the device, we add a pending
LE connection for that device.

Likewise, when the connection parameters are updated we add or delete
a pending LE connection according to its new auto_connect option.

Finally, when the connection parameter is deleted we also delete the
pending LE connection (if any).

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_core.c | 42 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 7b4f315..82042d3 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3200,6 +3200,23 @@ struct hci_conn_params *hci_conn_params_lookup(struct hci_dev *hdev,
 	return NULL;
 }
 
+static bool is_connected(struct hci_dev *hdev, bdaddr_t *addr, u8 type)
+{
+	struct hci_conn *conn;
+
+	conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, addr);
+	if (!conn)
+		return false;
+
+	if (conn->dst_type != type)
+		return false;
+
+	if (conn->state != BT_CONNECTED)
+		return false;
+
+	return true;
+}
+
 /* This function requires the caller holds hdev->lock */
 void hci_conn_params_add(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type,
 			 u8 auto_connect, u16 conn_min_interval,
@@ -3208,12 +3225,8 @@ void hci_conn_params_add(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type,
 	struct hci_conn_params *params;
 
 	params = hci_conn_params_lookup(hdev, addr, addr_type);
-	if (params) {
-		params->conn_min_interval = conn_min_interval;
-		params->conn_max_interval = conn_max_interval;
-		params->auto_connect = auto_connect;
-		return;
-	}
+	if (params)
+		goto update;
 
 	params = kzalloc(sizeof(*params), GFP_KERNEL);
 	if (!params) {
@@ -3223,11 +3236,24 @@ void hci_conn_params_add(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type,
 
 	bacpy(&params->addr, addr);
 	params->addr_type = addr_type;
+
+	list_add(&params->list, &hdev->le_conn_params);
+
+update:
 	params->conn_min_interval = conn_min_interval;
 	params->conn_max_interval = conn_max_interval;
 	params->auto_connect = auto_connect;
 
-	list_add(&params->list, &hdev->le_conn_params);
+	switch (auto_connect) {
+	case HCI_AUTO_CONN_DISABLED:
+	case HCI_AUTO_CONN_LINK_LOSS:
+		hci_pend_le_conn_del(hdev, addr, addr_type);
+		break;
+	case HCI_AUTO_CONN_ALWAYS:
+		if (!is_connected(hdev, addr, addr_type))
+			hci_pend_le_conn_add(hdev, addr, addr_type);
+		break;
+	}
 
 	BT_DBG("addr %pMR (type %u) auto_connect %u conn_min_interval 0x%.4x "
 	       "conn_max_interval 0x%.4x", addr, addr_type, auto_connect,
@@ -3243,6 +3269,8 @@ void hci_conn_params_del(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type)
 	if (!params)
 		return;
 
+	hci_pend_le_conn_del(hdev, addr, addr_type);
+
 	list_del(&params->list);
 	kfree(params);
 
-- 
1.8.5.4

