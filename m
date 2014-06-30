Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 4/5] Bluetooth: Provide function to create and set connection parameters
Date: Mon, 30 Jun 2014 12:34:39 +0200
Message-Id: <1404124480-60343-4-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In some cases it is useful to not overwrite connection parametes and
instead just create default ones if they don't exist. This function
does exactly that. hci_conn_params_add will allow to create new
default connection parameters. hci_conn_params_set will set the
values and also create new parameters if they don't exist.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |  3 ++-
 net/bluetooth/hci_core.c         | 36 +++++++++++++++++++++++++++++++++++-
 net/bluetooth/mgmt.c             |  5 ++++-
 3 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index ed842c7e5cf1..c0d2506e2019 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -852,7 +852,8 @@ int hci_white_list_del(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
 
 struct hci_conn_params *hci_conn_params_lookup(struct hci_dev *hdev,
 					       bdaddr_t *addr, u8 addr_type);
-int hci_conn_params_add(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type,
+int hci_conn_params_add(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type);
+int hci_conn_params_set(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type,
 			u8 auto_connect, u16 conn_min_interval,
 			u16 conn_max_interval);
 void hci_conn_params_del(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 6c28687c9286..adea7de95633 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3472,7 +3472,41 @@ void hci_pend_le_conns_clear(struct hci_dev *hdev)
 }
 
 /* This function requires the caller holds hdev->lock */
-int hci_conn_params_add(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type,
+int hci_conn_params_add(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type)
+{
+	struct hci_conn_params *params;
+
+	if (!is_identity_address(addr, addr_type))
+		return -EINVAL;
+
+	params = hci_conn_params_lookup(hdev, addr, addr_type);
+	if (params)
+		return 0;
+
+	params = kzalloc(sizeof(*params), GFP_KERNEL);
+	if (!params) {
+		BT_ERR("Out of memory");
+		return -ENOMEM;
+	}
+
+	bacpy(&params->addr, addr);
+	params->addr_type = addr_type;
+
+	list_add(&params->list, &hdev->le_conn_params);
+
+	params->conn_min_interval = hdev->le_conn_min_interval;
+	params->conn_max_interval = hdev->le_conn_max_interval;
+	params->conn_latency = hdev->le_conn_latency;
+	params->supervision_timeout = hdev->le_supv_timeout;
+	params->auto_connect = HCI_AUTO_CONN_DISABLED;
+
+	BT_DBG("addr %pMR (type %u)", addr, addr_type);
+
+	return 0;
+}
+
+/* This function requires the caller holds hdev->lock */
+int hci_conn_params_set(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type,
 			u8 auto_connect, u16 conn_min_interval,
 			u16 conn_max_interval)
 {
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index d83197f9e727..e30d0ebb5018 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5014,7 +5014,10 @@ static int add_device(struct sock *sk, struct hci_dev *hdev,
 	else
 		auto_conn = HCI_AUTO_CONN_DISABLED;
 
-	if (hci_conn_params_add(hdev, &cp->addr.bdaddr, addr_type, auto_conn,
+	/* If the connection parameters don't exist for this device,
+	 * they will be created and configured with defaults.
+	 */
+	if (hci_conn_params_set(hdev, &cp->addr.bdaddr, addr_type, auto_conn,
 				hdev->le_conn_min_interval,
 				hdev->le_conn_max_interval) < 0) {
 		err = cmd_complete(sk, hdev->id, MGMT_OP_ADD_DEVICE,
-- 
1.9.3

