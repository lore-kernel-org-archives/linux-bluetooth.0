Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v10 06/10] Bluetooth: Introduce LE auto connection infrastructure
Date: Tue, 18 Feb 2014 17:15:30 -0300
Message-Id: <1392754534-12747-6-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1392754534-12747-1-git-send-email-andre.guedes@openbossa.org>
References: <1392754534-12747-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch introduces the LE auto connection infrastructure which
will be used to implement the LE auto connection options.

In summary, the auto connection mechanism works as follows: Once the
first pending LE connection is created, the background scanning is
started. When the target device is found in range, the kernel
autonomously starts the connection attempt. If connection is
established successfully, that pending LE connection is deleted and
the background is stopped.

To achieve that, this patch introduces the hci_update_background_scan()
which controls the background scanning state. This function starts or
stops the background scanning based on the hdev->pend_le_conns list. If
there is no pending LE connection, the background scanning is stopped.
Otherwise, we start the background scanning.

Then, every time a pending LE connection is added we call hci_update_
background_scan() so the background scanning is started (in case it is
not already running). Likewise, every time a pending LE connection is
deleted we call hci_update_background_scan() so the background scanning
is stopped (in case this was the last pending LE connection) or it is
started again (in case we have more pending LE connections). Finally,
we also call hci_update_background_scan() in hci_le_conn_failed() so
the background scan is restarted in case the connection establishment
fails. This way the background scanning keeps running until all pending
LE connection are established.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |  2 +
 net/bluetooth/hci_conn.c         |  5 +++
 net/bluetooth/hci_core.c         | 83 +++++++++++++++++++++++++++++++++++++++-
 net/bluetooth/hci_event.c        | 44 +++++++++++++++++++++
 4 files changed, 132 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index f0617ab..297b954 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -788,6 +788,8 @@ void hci_pend_le_conn_add(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type);
 void hci_pend_le_conn_del(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type);
 void hci_pend_le_conns_clear(struct hci_dev *hdev);
 
+void hci_update_background_scan(struct hci_dev *hdev);
+
 void hci_uuids_clear(struct hci_dev *hdev);
 
 void hci_link_keys_clear(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 0ae7692..e291d68 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -527,6 +527,11 @@ void hci_le_conn_failed(struct hci_conn *conn, u8 status)
 	hci_proto_connect_cfm(conn, status);
 
 	hci_conn_del(conn);
+
+	/* Since we may have temporarily stopped the background scanning in
+	 * favor of connection establishment, we should restart it.
+	 */
+	hci_update_background_scan(hdev);
 }
 
 static void create_le_conn_complete(struct hci_dev *hdev, u8 status)
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 992f9ea..18ef960 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3114,7 +3114,7 @@ void hci_pend_le_conn_add(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type)
 
 	entry = hci_pend_le_conn_lookup(hdev, addr, addr_type);
 	if (entry)
-		return;
+		goto done;
 
 	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
 	if (!entry) {
@@ -3128,6 +3128,9 @@ void hci_pend_le_conn_add(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type)
 	list_add(&entry->list, &hdev->pend_le_conns);
 
 	BT_DBG("addr %pMR (type %u)", addr, addr_type);
+
+done:
+	hci_update_background_scan(hdev);
 }
 
 /* This function requires the caller holds hdev->lock */
@@ -3137,12 +3140,15 @@ void hci_pend_le_conn_del(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type)
 
 	entry = hci_pend_le_conn_lookup(hdev, addr, addr_type);
 	if (!entry)
-		return;
+		goto done;
 
 	list_del(&entry->list);
 	kfree(entry);
 
 	BT_DBG("addr %pMR (type %u)", addr, addr_type);
+
+done:
+	hci_update_background_scan(hdev);
 }
 
 /* This function requires the caller holds hdev->lock */
@@ -4706,3 +4712,76 @@ void hci_req_add_le_scan_disable(struct hci_request *req)
 	cp.enable = LE_SCAN_DISABLE;
 	hci_req_add(req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
 }
+
+static void update_background_scan_complete(struct hci_dev *hdev, u8 status)
+{
+	if (status)
+		BT_DBG("HCI request failed to update background scanning: "
+		       "status 0x%2.2x", status);
+}
+
+/* This function controls the background scanning based on hdev->pend_le_conns
+ * list. If there are pending LE connection we start the background scanning,
+ * otherwise we stop it.
+ *
+ * This function requires the caller holds hdev->lock.
+ */
+void hci_update_background_scan(struct hci_dev *hdev)
+{
+	struct hci_cp_le_set_scan_param param_cp;
+	struct hci_cp_le_set_scan_enable enable_cp;
+	struct hci_request req;
+	struct hci_conn *conn;
+	int err;
+
+	hci_req_init(&req, hdev);
+
+	if (list_empty(&hdev->pend_le_conns)) {
+		/* If there is no pending LE connections, we should stop
+		 * the background scanning.
+		 */
+
+		/* If controller is not scanning we are done. */
+		if (!test_bit(HCI_LE_SCAN, &hdev->dev_flags))
+			return;
+
+		hci_req_add_le_scan_disable(&req);
+
+		BT_DBG("%s stopping background scanning", hdev->name);
+	} else {
+		/* If there is at least one pending LE connection, we should
+		 * keep the background scan running.
+		 */
+
+		/* If controller is already scanning we are done. */
+		if (test_bit(HCI_LE_SCAN, &hdev->dev_flags))
+			return;
+
+		/* If controller is connecting, we should not start scanning
+		 * since some controllers are not able to scan and connect at
+		 * the same time.
+		 */
+		conn = hci_conn_hash_lookup_state(hdev, LE_LINK, BT_CONNECT);
+		if (conn)
+			return;
+
+		memset(&param_cp, 0, sizeof(param_cp));
+		param_cp.type = LE_SCAN_PASSIVE;
+		param_cp.interval = cpu_to_le16(hdev->le_scan_interval);
+		param_cp.window = cpu_to_le16(hdev->le_scan_window);
+		hci_req_add(&req, HCI_OP_LE_SET_SCAN_PARAM, sizeof(param_cp),
+			    &param_cp);
+
+		memset(&enable_cp, 0, sizeof(enable_cp));
+		enable_cp.enable = LE_SCAN_ENABLE;
+		enable_cp.filter_dup = LE_SCAN_FILTER_DUP_DISABLE;
+		hci_req_add(&req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(enable_cp),
+			    &enable_cp);
+
+		BT_DBG("%s starting background scanning", hdev->name);
+	}
+
+	err = hci_req_run(&req, update_background_scan_complete);
+	if (err)
+		BT_ERR("Failed to run HCI request: err %d", err);
+}
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 87baf21..b25cefd 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3628,25 +3628,69 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 	hci_proto_connect_cfm(conn, ev->status);
 
+	hci_pend_le_conn_del(hdev, &ev->bdaddr, ev->bdaddr_type);
+
 unlock:
 	hci_dev_unlock(hdev);
 }
 
+/* This function requires the caller holds hdev->lock */
+static void check_pending_le_conn(struct hci_dev *hdev, bdaddr_t *addr,
+				  u8 addr_type)
+{
+	struct hci_conn *conn;
+	u8 bdaddr_type;
+
+	if (!hci_pend_le_conn_lookup(hdev, addr, addr_type))
+		return;
+
+	if (addr_type == ADDR_LE_DEV_PUBLIC)
+		bdaddr_type = BDADDR_LE_PUBLIC;
+	else
+		bdaddr_type = BDADDR_LE_RANDOM;
+
+	conn = hci_connect(hdev, LE_LINK, addr, bdaddr_type, BT_SECURITY_LOW,
+			   HCI_AT_NO_BONDING);
+	if (!IS_ERR(conn))
+		return;
+
+	switch (PTR_ERR(conn)) {
+	case -EBUSY:
+		/* If hci_connect() returns -EBUSY it means there is already
+		 * an LE connection attempt going on. Since controllers don't
+		 * support more than one connection attempt at the time, we
+		 * don't consider this an error case.
+		 */
+		break;
+	default:
+		BT_DBG("Failed to connect: err %ld", PTR_ERR(conn));
+	}
+}
+
 static void hci_le_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	u8 num_reports = skb->data[0];
 	void *ptr = &skb->data[1];
 	s8 rssi;
 
+	hci_dev_lock(hdev);
+
 	while (num_reports--) {
 		struct hci_ev_le_advertising_info *ev = ptr;
 
+		if (ev->evt_type == LE_ADV_IND ||
+		    ev->evt_type == LE_ADV_DIRECT_IND)
+			check_pending_le_conn(hdev, &ev->bdaddr,
+					      ev->bdaddr_type);
+
 		rssi = ev->data[ev->length];
 		mgmt_device_found(hdev, &ev->bdaddr, LE_LINK, ev->bdaddr_type,
 				  NULL, rssi, 0, 1, ev->data, ev->length);
 
 		ptr += sizeof(*ev) + ev->length + 1;
 	}
+
+	hci_dev_unlock(hdev);
 }
 
 static void hci_le_ltk_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
-- 
1.8.5.4

