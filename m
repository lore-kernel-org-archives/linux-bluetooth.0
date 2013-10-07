Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 1/2] Bluetooth: Use HCI request for LE connection
Date: Mon,  7 Oct 2013 13:59:07 -0300
Message-Id: <1381165148-14156-2-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1381165148-14156-1-git-send-email-andre.guedes@openbossa.org>
References: <1381165148-14156-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch introduces a new helper, which uses the HCI request
framework, for creating LE connectons. All the handling is now
done by this function so we can remove the hci_cs_le_create_conn()
event handler.

This patch also removes the old hci_le_create_connection() since
it is not used anymore.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |  2 ++
 net/bluetooth/hci_conn.c         | 30 +++++-----------------
 net/bluetooth/hci_core.c         | 55 ++++++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_event.c        | 31 ----------------------
 4 files changed, 63 insertions(+), 55 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index c065527..6ac542c 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1188,6 +1188,8 @@ void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __u8 rand[8],
 
 u8 bdaddr_to_le(u8 bdaddr_type);
 
+int hci_create_le_conn(struct hci_dev *hdev, bdaddr_t *addr, u8 type);
+
 #define SCO_AIRMODE_MASK       0x0003
 #define SCO_AIRMODE_CVSD       0x0000
 #define SCO_AIRMODE_TRANSP     0x0003
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 2a220a8..31f6712 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -49,29 +49,6 @@ static const struct sco_param sco_param_wideband[] = {
 	{ EDR_ESCO_MASK | ESCO_EV3,   0x0008 }, /* T1 */
 };
 
-static void hci_le_create_connection(struct hci_conn *conn)
-{
-	struct hci_dev *hdev = conn->hdev;
-	struct hci_cp_le_create_conn cp;
-
-	memset(&cp, 0, sizeof(cp));
-	cp.scan_interval = __constant_cpu_to_le16(0x0060);
-	cp.scan_window = __constant_cpu_to_le16(0x0030);
-	bacpy(&cp.peer_addr, &conn->dst);
-	cp.peer_addr_type = conn->dst_type;
-	if (bacmp(&hdev->bdaddr, BDADDR_ANY))
-		cp.own_address_type = ADDR_LE_DEV_PUBLIC;
-	else
-		cp.own_address_type = ADDR_LE_DEV_RANDOM;
-	cp.conn_interval_min = __constant_cpu_to_le16(0x0028);
-	cp.conn_interval_max = __constant_cpu_to_le16(0x0038);
-	cp.supervision_timeout = __constant_cpu_to_le16(0x002a);
-	cp.min_ce_len = __constant_cpu_to_le16(0x0000);
-	cp.max_ce_len = __constant_cpu_to_le16(0x0000);
-
-	hci_send_cmd(hdev, HCI_OP_LE_CREATE_CONN, sizeof(cp), &cp);
-}
-
 static void hci_le_create_connection_cancel(struct hci_conn *conn)
 {
 	hci_send_cmd(conn->hdev, HCI_OP_LE_CREATE_CONN_CANCEL, 0, NULL);
@@ -549,6 +526,7 @@ static struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 				    u8 dst_type, u8 sec_level, u8 auth_type)
 {
 	struct hci_conn *conn;
+	int err;
 
 	if (test_bit(HCI_ADVERTISING, &hdev->flags))
 		return ERR_PTR(-ENOTSUPP);
@@ -569,7 +547,11 @@ static struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 		conn->link_mode |= HCI_LM_MASTER;
 		conn->sec_level = BT_SECURITY_LOW;
 
-		hci_le_create_connection(conn);
+		err = hci_create_le_conn(hdev, &conn->dst, conn->dst_type);
+		if (err) {
+			hci_conn_del(conn);
+			return ERR_PTR(err);
+		}
 	}
 
 	conn->pending_sec_level = sec_level;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 0c636ba..8cd8486 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3702,3 +3702,58 @@ u8 bdaddr_to_le(u8 bdaddr_type)
 		return ADDR_LE_DEV_RANDOM;
 	}
 }
+
+static void create_le_conn_complete(struct hci_dev *hdev, u8 status)
+{
+	struct hci_conn *conn;
+
+	if (status == 0)
+		return;
+
+	BT_ERR("HCI request failed to create LE connection: status 0x%2.2x",
+	       status);
+
+	hci_dev_lock(hdev);
+
+	conn = hci_conn_hash_lookup_state(hdev, LE_LINK, BT_CONNECT);
+	if (!conn)
+		goto done;
+
+	conn->state = BT_CLOSED;
+
+	mgmt_connect_failed(hdev, &conn->dst, conn->type, conn->dst_type,
+			    status);
+
+	hci_proto_connect_cfm(conn, status);
+
+	hci_conn_del(conn);
+
+done:
+	hci_dev_unlock(hdev);
+}
+
+int hci_create_le_conn(struct hci_dev *hdev, bdaddr_t *addr, u8 type)
+{
+	struct hci_cp_le_create_conn cp;
+	struct hci_request req;
+
+	hci_req_init(&req, hdev);
+
+	memset(&cp, 0, sizeof(cp));
+	cp.scan_interval = __constant_cpu_to_le16(0x0060);
+	cp.scan_window = __constant_cpu_to_le16(0x0030);
+	bacpy(&cp.peer_addr, addr);
+	cp.peer_addr_type = type;
+	if (bacmp(&hdev->bdaddr, BDADDR_ANY))
+		cp.own_address_type = ADDR_LE_DEV_PUBLIC;
+	else
+		cp.own_address_type = ADDR_LE_DEV_RANDOM;
+	cp.conn_interval_min = __constant_cpu_to_le16(0x0028);
+	cp.conn_interval_max = __constant_cpu_to_le16(0x0038);
+	cp.supervision_timeout = __constant_cpu_to_le16(0x002a);
+	cp.min_ce_len = __constant_cpu_to_le16(0x0000);
+	cp.max_ce_len = __constant_cpu_to_le16(0x0000);
+	hci_req_add(&req, HCI_OP_LE_CREATE_CONN, sizeof(cp), &cp);
+
+	return hci_req_run(&req, create_le_conn_complete);
+}
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 224210c..655d5ca 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1470,33 +1470,6 @@ static void hci_cs_disconnect(struct hci_dev *hdev, u8 status)
 	hci_dev_unlock(hdev);
 }
 
-static void hci_cs_le_create_conn(struct hci_dev *hdev, __u8 status)
-{
-	struct hci_conn *conn;
-
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
-
-	if (status) {
-		hci_dev_lock(hdev);
-
-		conn = hci_conn_hash_lookup_state(hdev, LE_LINK, BT_CONNECT);
-		if (!conn) {
-			hci_dev_unlock(hdev);
-			return;
-		}
-
-		BT_DBG("%s bdaddr %pMR conn %p", hdev->name, &conn->dst, conn);
-
-		conn->state = BT_CLOSED;
-		mgmt_connect_failed(hdev, &conn->dst, conn->type,
-				    conn->dst_type, status);
-		hci_proto_connect_cfm(conn, status);
-		hci_conn_del(conn);
-
-		hci_dev_unlock(hdev);
-	}
-}
-
 static void hci_cs_create_phylink(struct hci_dev *hdev, u8 status)
 {
 	struct hci_cp_create_phy_link *cp;
@@ -2362,10 +2335,6 @@ static void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_cs_disconnect(hdev, ev->status);
 		break;
 
-	case HCI_OP_LE_CREATE_CONN:
-		hci_cs_le_create_conn(hdev, ev->status);
-		break;
-
 	case HCI_OP_CREATE_PHY_LINK:
 		hci_cs_create_phylink(hdev, ev->status);
 		break;
-- 
1.8.4

