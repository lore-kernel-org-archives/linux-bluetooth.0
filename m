Return-Path: <cyrus@holtmann.org>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [RFC 3/5] Bluetooth: Add unset controller data MGMT command
Date: Fri, 10 Aug 2012 17:01:45 -0400
Message-Id: <1344632507-21381-4-git-send-email-jefferson.delfes@openbossa.org>
In-Reply-To: <1344632507-21381-1-git-send-email-jefferson.delfes@openbossa.org>
References: <1344632507-21381-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This command will remove controller data from EIR and/or AD.

Signed-off-by: Jefferson Delfes <jefferson.delfes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |  1 +
 include/net/bluetooth/mgmt.h     |  6 ++++++
 net/bluetooth/hci_core.c         | 16 ++++++++++++++++
 net/bluetooth/mgmt.c             | 16 ++++++++++++++++
 4 files changed, 39 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 3a61227..5e6b477 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -728,6 +728,7 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 int hci_controller_data_add(struct hci_dev *hdev, u8 flags, u8 data_type,
 			    u8 data_length, u8 *data);
 int hci_controller_data_clear(struct hci_dev *hdev);
+int hci_controller_data_remove(struct hci_dev *hdev, u8 data_type);
 
 #define SET_HCIDEV_DEV(hdev, pdev) ((hdev)->dev.parent = (pdev))
 
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 1afa399..eda2755 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -361,6 +361,12 @@ struct mgmt_cp_set_controller_data {
 } __packed;
 #define MGMT_SET_CONTROLLER_DATA_SIZE	3
 
+#define MGMT_OP_UNSET_CONTROLLER_DATA	0x002A
+struct mgmt_cp_unset_controller_data {
+	__u8	data_type;
+} __packed;
+#define MGMT_UNSET_CONTROLLER_DATA_SIZE	1
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 2e38a1b..80280fa 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1471,6 +1471,22 @@ int hci_controller_data_clear(struct hci_dev *hdev)
 	return 0;
 }
 
+int hci_controller_data_remove(struct hci_dev *hdev, u8 data_type)
+{
+	struct controller_data *match, *n;
+	int matches = 0;
+
+	list_for_each_entry_safe(match, n, &hdev->controller_data, list) {
+		if (data_type == match->data_type) {
+			list_del(&match->list);
+			kfree(match);
+			matches++;
+		}
+	}
+
+	return matches;
+}
+
 struct bdaddr_list *hci_blacklist_lookup(struct hci_dev *hdev, bdaddr_t *bdaddr)
 {
 	struct bdaddr_list *b;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 9e9702a..51d0e2f 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2716,6 +2716,21 @@ static int set_controller_data(struct sock *sk, struct hci_dev *hdev,
 			    0);
 }
 
+static int unset_controller_data(struct sock *sk, struct hci_dev *hdev,
+				 void *data, u16 len)
+{
+	struct mgmt_cp_unset_controller_data *cp = data;
+
+	BT_DBG("%s type:0x%02x", hdev->name, cp->data_type);
+
+	hci_dev_lock(hdev);
+	hci_controller_data_remove(hdev, cp->data_type);
+	hci_dev_unlock(hdev);
+
+	return cmd_complete(sk, hdev->id, MGMT_OP_UNSET_CONTROLLER_DATA, 0,
+			    NULL, 0);
+}
+
 static const struct mgmt_handler {
 	int (*func) (struct sock *sk, struct hci_dev *hdev, void *data,
 		     u16 data_len);
@@ -2764,6 +2779,7 @@ static const struct mgmt_handler {
 	{ unblock_device,         false, MGMT_UNBLOCK_DEVICE_SIZE },
 	{ set_device_id,          false, MGMT_SET_DEVICE_ID_SIZE },
 	{ set_controller_data,    true,  MGMT_SET_CONTROLLER_DATA_SIZE },
+	{ unset_controller_data,  false, MGMT_UNSET_CONTROLLER_DATA_SIZE },
 };
 
 
-- 
1.7.11.4

