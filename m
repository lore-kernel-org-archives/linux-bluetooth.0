Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v6 4/4] Bluetooth: Add directed advertising support through connect()
Date: Mon, 24 Mar 2014 20:21:53 +0200
Message-Id: <1395685313-26085-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1395685313-26085-1-git-send-email-johan.hedberg@gmail.com>
References: <1395685313-26085-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When we're in peripheral mode (HCI_ADVERTISING flag is set) the most
natural mapping of connect() is to perform directed advertising to the
peer device.

This patch does the necessary changes to enable directed advertising and
keeps the hci_conn state as BT_CONNECT in a similar way as is done for
central or BR/EDR connection initiation.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci.h |  1 +
 net/bluetooth/hci_conn.c    | 77 ++++++++++++++++++++++++++++++++++++++++-----
 net/bluetooth/hci_event.c   | 19 +++++++++--
 3 files changed, 87 insertions(+), 10 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index be150cf8cd43..4261a67682c0 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -367,6 +367,7 @@ enum {
 #define HCI_ERROR_REMOTE_POWER_OFF	0x15
 #define HCI_ERROR_LOCAL_HOST_TERM	0x16
 #define HCI_ERROR_PAIRING_NOT_ALLOWED	0x18
+#define HCI_ERROR_ADVERTISING_TIMEOUT	0x3c
 
 /* Flow control modes */
 #define HCI_FLOW_CTL_MODE_PACKET_BASED	0x00
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 129c22a85ccf..b2500f48b373 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -367,9 +367,23 @@ static void le_conn_timeout(struct work_struct *work)
 {
 	struct hci_conn *conn = container_of(work, struct hci_conn,
 					     le_conn_timeout.work);
+	struct hci_dev *hdev = conn->hdev;
 
 	BT_DBG("");
 
+	/* We could end up here due to having done directed advertising,
+	 * so clean up the state if necessary. This should however only
+	 * happen with broken hardware or if low duty cycle was used
+	 * (which doesn't have a timeout of its own).
+	 */
+	if (test_bit(HCI_ADVERTISING, &hdev->dev_flags)) {
+		u8 enable = 0x00;
+		hci_send_cmd(hdev, HCI_OP_LE_SET_ADV_ENABLE, sizeof(enable),
+			     &enable);
+		hci_le_conn_failed(conn, HCI_ERROR_ADVERTISING_TIMEOUT);
+		return;
+	}
+
 	hci_le_create_connection_cancel(conn);
 }
 
@@ -549,6 +563,11 @@ void hci_le_conn_failed(struct hci_conn *conn, u8 status)
 	 * favor of connection establishment, we should restart it.
 	 */
 	hci_update_background_scan(hdev);
+
+	/* Re-enable advertising in case this was a failed connection
+	 * attempt as a peripheral.
+	 */
+	mgmt_reenable_advertising(hdev);
 }
 
 static void create_le_conn_complete(struct hci_dev *hdev, u8 status)
@@ -609,6 +628,45 @@ static void hci_req_add_le_create_conn(struct hci_request *req,
 	conn->state = BT_CONNECT;
 }
 
+static void hci_req_directed_advertising(struct hci_request *req,
+					 struct hci_conn *conn)
+{
+	struct hci_dev *hdev = req->hdev;
+	struct hci_cp_le_set_adv_param cp;
+	u8 own_addr_type;
+	u8 enable;
+
+	enable = 0x00;
+	hci_req_add(req, HCI_OP_LE_SET_ADV_ENABLE, sizeof(enable), &enable);
+
+	/* Clear the HCI_ADVERTISING bit temporarily so that the
+	 * hci_update_random_address knows that it's safe to go ahead
+	 * and write a new random address. The flag will be set back on
+	 * as soon as the SET_ADV_ENABLE HCI command completes.
+	 */
+	clear_bit(HCI_ADVERTISING, &hdev->dev_flags);
+
+	/* Set require_privacy to false so that the remote device has a
+	 * chance of identifying us.
+	 */
+	if (hci_update_random_address(req, false, &own_addr_type) < 0)
+		return;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.type = 0x01;
+	cp.own_address_type = own_addr_type;
+	cp.direct_addr_type = conn->dst_type;
+	bacpy(&cp.direct_addr, &conn->dst);
+	cp.channel_map = hdev->le_adv_channel_map;
+
+	hci_req_add(req, HCI_OP_LE_SET_ADV_PARAM, sizeof(cp), &cp);
+
+	enable = 0x01;
+	hci_req_add(req, HCI_OP_LE_SET_ADV_ENABLE, sizeof(enable), &enable);
+
+	conn->state = BT_CONNECT;
+}
+
 struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 				u8 dst_type, u8 sec_level, u8 auth_type)
 {
@@ -618,9 +676,6 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 	struct hci_request req;
 	int err;
 
-	if (test_bit(HCI_ADVERTISING, &hdev->flags))
-		return ERR_PTR(-ENOTSUPP);
-
 	/* Some devices send ATT messages as soon as the physical link is
 	 * established. To be able to handle these ATT messages, the user-
 	 * space first establishes the connection and then starts the pairing
@@ -668,13 +723,20 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 		return ERR_PTR(-ENOMEM);
 
 	conn->dst_type = dst_type;
-
-	conn->out = true;
-	conn->link_mode |= HCI_LM_MASTER;
 	conn->sec_level = BT_SECURITY_LOW;
 	conn->pending_sec_level = sec_level;
 	conn->auth_type = auth_type;
 
+	hci_req_init(&req, hdev);
+
+	if (test_bit(HCI_ADVERTISING, &hdev->dev_flags)) {
+		hci_req_directed_advertising(&req, conn);
+		goto create_conn;
+	}
+
+	conn->out = true;
+	conn->link_mode |= HCI_LM_MASTER;
+
 	params = hci_conn_params_lookup(hdev, &conn->dst, conn->dst_type);
 	if (params) {
 		conn->le_conn_min_interval = params->conn_min_interval;
@@ -684,8 +746,6 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 		conn->le_conn_max_interval = hdev->le_conn_max_interval;
 	}
 
-	hci_req_init(&req, hdev);
-
 	/* If controller is scanning, we stop it since some controllers are
 	 * not able to scan and connect at the same time. Also set the
 	 * HCI_LE_SCAN_INTERRUPTED flag so that the command complete
@@ -699,6 +759,7 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 
 	hci_req_add_le_create_conn(&req, conn);
 
+create_conn:
 	err = hci_req_run(&req, create_le_conn_complete);
 	if (err) {
 		hci_conn_del(conn);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 224eecfc0ecd..c91eeff68324 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -991,10 +991,25 @@ static void hci_cc_le_set_adv_enable(struct hci_dev *hdev, struct sk_buff *skb)
 	if (!sent)
 		return;
 
+	if (status)
+		return;
+
 	hci_dev_lock(hdev);
 
-	if (!status)
-		mgmt_advertising(hdev, *sent);
+	/* If we're doing connection initation as peripheral. Set a
+	 * timeout in case something goes wrong.
+	 */
+	if (*sent) {
+		struct hci_conn *conn;
+
+		conn = hci_conn_hash_lookup_state(hdev, LE_LINK, BT_CONNECT);
+		if (conn)
+			queue_delayed_work(hdev->workqueue,
+					   &conn->le_conn_timeout,
+					   HCI_LE_CONN_TIMEOUT);
+	}
+
+	mgmt_advertising(hdev, *sent);
 
 	hci_dev_unlock(hdev);
 }
-- 
1.8.5.3

