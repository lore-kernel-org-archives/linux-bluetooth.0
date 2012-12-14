Return-Path: <cyrus@holtmann.org>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>,
	Aloisio Almeida Jr <aloisio.almeida@openbossa.org>
Subject: [PATCH 04/12] Bluetooth: Add unset controller data MGMT command
Date: Fri, 14 Dec 2012 14:51:30 -0400
Message-Id: <1355511098-10190-5-git-send-email-jefferson.delfes@openbossa.org>
In-Reply-To: <1355511098-10190-1-git-send-email-jefferson.delfes@openbossa.org>
References: <1355511098-10190-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Unset controller data allows user to remove some data previously set to be
broadcasted via set controller data MGMT command.

Signed-off-by: Jefferson Delfes <jefferson.delfes@openbossa.org>
Signed-off-by: Aloisio Almeida Jr <aloisio.almeida@openbossa.org>
---
 include/net/bluetooth/hci_core.h |  1 +
 include/net/bluetooth/mgmt.h     |  6 ++++++
 net/bluetooth/hci_core.c         | 19 +++++++++++++++++++
 net/bluetooth/mgmt.c             | 24 ++++++++++++++++++++++++
 4 files changed, 50 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 49a9ead..cf8d125 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -765,6 +765,7 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 
 int hci_broadcast_data_add(struct hci_dev *hdev, u8 flags, u8 type, u8 length,
 			   u8 *data);
+int hci_broadcast_data_remove(struct hci_dev *hdev, u8 type);
 int hci_broadcast_data_clear(struct hci_dev *hdev);
 
 #define SET_HCIDEV_DEV(hdev, pdev) ((hdev)->dev.parent = (pdev))
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index f99e0a8..bbb4b4a 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -359,6 +359,12 @@ struct mgmt_cp_set_controller_data {
 } __packed;
 #define MGMT_SET_CONTROLLER_DATA_SIZE	3
 
+#define MGMT_OP_UNSET_CONTROLLER_DATA	0x002A
+struct mgmt_cp_unset_controller_data {
+	__u8	type;
+} __packed;
+#define MGMT_UNSET_CONTROLLER_DATA_SIZE	1
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 6d6ee0c..d015e1f 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1524,6 +1524,25 @@ int hci_broadcast_data_add(struct hci_dev *hdev, u8 flags, u8 type, u8 length,
 	return 0;
 }
 
+int hci_broadcast_data_remove(struct hci_dev *hdev, u8 type)
+{
+	struct broadcast_data *match, *n;
+	int matches = 0;
+
+	list_for_each_entry_safe(match, n, &hdev->broadcast_data, list) {
+		if (type != match->type)
+			continue;
+
+		list_del(&match->list);
+		hdev->broadcast_data_len -= sizeof(match->length) +
+					    sizeof(match->type) + match->length;
+		kfree(match);
+		matches++;
+	}
+
+	return matches;
+}
+
 int hci_broadcast_data_clear(struct hci_dev *hdev)
 {
 	struct broadcast_data *b_data, *n;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 4623cf0..0aa96bb 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2739,6 +2739,29 @@ static int set_controller_data(struct sock *sk, struct hci_dev *hdev,
 			    0);
 }
 
+static int unset_controller_data(struct sock *sk, struct hci_dev *hdev,
+				 void *data, u16 len)
+{
+	struct mgmt_cp_unset_controller_data *cp = data;
+
+	BT_DBG("%s type:0x%02x", hdev->name, cp->type);
+
+	hci_dev_lock(hdev);
+
+	if (!hdev_is_powered(hdev)) {
+		hci_dev_unlock(hdev);
+		return cmd_status(sk, hdev->id, MGMT_OP_UNSET_CONTROLLER_DATA,
+				  MGMT_STATUS_NOT_POWERED);
+	}
+
+	hci_broadcast_data_remove(hdev, cp->type);
+
+	hci_dev_unlock(hdev);
+
+	return cmd_complete(sk, hdev->id, MGMT_OP_UNSET_CONTROLLER_DATA, 0,
+			    NULL, 0);
+}
+
 static const struct mgmt_handler {
 	int (*func) (struct sock *sk, struct hci_dev *hdev, void *data,
 		     u16 data_len);
@@ -2787,6 +2810,7 @@ static const struct mgmt_handler {
 	{ unblock_device,         false, MGMT_UNBLOCK_DEVICE_SIZE },
 	{ set_device_id,          false, MGMT_SET_DEVICE_ID_SIZE },
 	{ set_controller_data,    true,  MGMT_SET_CONTROLLER_DATA_SIZE },
+	{ unset_controller_data,  false, MGMT_UNSET_CONTROLLER_DATA_SIZE },
 };
 
 
-- 
1.8.0.2

