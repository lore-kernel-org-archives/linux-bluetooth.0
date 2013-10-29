Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v2 11/15] Bluetooth: Auto connection and power on
Date: Tue, 29 Oct 2013 10:25:56 -0300
Message-Id: <1383053160-10175-12-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1383053160-10175-1-git-send-email-andre.guedes@openbossa.org>
References: <1383053160-10175-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch implements a fixup required by auto connection mechanism
in order to work properly after a power on.

When hdev is closed (e.g. Mgmt power off command, RFKILL or controller
is reset), the ongoing active connections are silently dropped by the
controller (no Disconnection Complete Event is sent to host). For that
reason, the devices that require HCI_AUTO_CONN_ALWAYS are not added to
hdev->pending_auto_conn list and they won't auto connect. So to fix
this issue, after adapter is powered on, we should add all HCI_AUTO_
CONN_ALWAYS address to hdev->pending_auto_conn list. Besides that, we
always have to check if there are pending auto connections and start
the background scanning if it is the case.

This way, the auto connection mechanism works propely after a power
off and power on sequence as well as RFKILL block/unblock.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |  2 ++
 net/bluetooth/hci_core.c         | 49 ++++++++++++++++++++++++++++++++++++++++
 net/bluetooth/mgmt.c             |  2 ++
 3 files changed, 53 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 322918f..379bb36 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -786,6 +786,8 @@ bool hci_is_scan_and_conn_supported(struct hci_dev *hdev);
 
 void hci_check_background_scan(struct hci_dev *hdev);
 
+void __hci_fixup_auto_conn(struct hci_dev *hdev);
+
 int hci_uuids_clear(struct hci_dev *hdev);
 
 int hci_link_keys_clear(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 44d3f99..63a56f5 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3090,6 +3090,55 @@ void hci_check_background_scan(struct hci_dev *hdev)
 		BT_ERR("Failed to start background scanning: err %d", err);
 }
 
+/* This functions implements a fixup required by auto connection mechanism
+ * in order to work properly after a power on.
+ *
+ * When hdev is closed (e.g. Mgmt power off command, RFKILL or controller is
+ * reset), the ongoing active connections are silently dropped by the
+ * by the controller (no Disconnection Complete Event is sent to host). For
+ * that reason, the devices that require HCI_AUTO_CONN_ALWAYS are not add to
+ * hdev->pending_auto_conn list and they won't auto connect. So to fix this
+ * issue, after adapter is powered on, we should add all HCI_AUTO_CONN_ALWAYS
+ * address to hdev->pending_auto_conn list. Besides that, we always have to
+ * check if there are pending auto connections and start the background
+ * scanning if it is the case.
+ *
+ * This function requires the caller holds hdev->lock.
+ */
+void __hci_fixup_auto_conn(struct hci_dev *hdev)
+{
+	struct hci_conn_params *p;
+	struct bdaddr_list *entry;
+
+	list_for_each_entry(p, &hdev->conn_params, list) {
+		if (p->auto_connect != HCI_AUTO_CONN_ALWAYS)
+			continue;
+
+		entry = __find_pending_auto_conn(hdev, &p->addr, p->addr_type);
+		if (entry)
+			continue;
+
+		entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+		if (!entry) {
+			BT_ERR("Out of memory of auto connection");
+			return;
+		}
+
+		bacpy(&entry->bdaddr, &p->addr);
+		entry->bdaddr_type = p->addr_type;
+		list_add(&entry->list, &hdev->pending_auto_conn);
+	}
+
+	if (!list_empty(&hdev->pending_auto_conn)) {
+		int err;
+
+		err = start_background_scan(hdev);
+		if (err)
+			BT_ERR("Failed to start background scanning: err %d",
+			       err);
+	}
+}
+
 static void inquiry_complete(struct hci_dev *hdev, u8 status)
 {
 	if (status) {
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 0e329e5..d396e47 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4255,6 +4255,8 @@ static void powered_complete(struct hci_dev *hdev, u8 status)
 
 	hci_dev_lock(hdev);
 
+	__hci_fixup_auto_conn(hdev);
+
 	mgmt_pending_foreach(MGMT_OP_SET_POWERED, hdev, settings_rsp, &match);
 
 	new_settings(hdev, match.sk);
-- 
1.8.4

