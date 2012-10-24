Return-Path: <cyrus@holtmann.org>
From: Aloisio Almeida Jr <aloisio.almeida@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>,
	Aloisio Almeida Jr <aloisio.almeida@openbossa.org>
Subject: [RFC 5/9] Bluetooth: Add unset controller data MGMT command
Date: Wed, 24 Oct 2012 12:58:11 -0300
Message-Id: <1351094295-10418-6-git-send-email-aloisio.almeida@openbossa.org>
In-Reply-To: <1351094295-10418-1-git-send-email-aloisio.almeida@openbossa.org>
References: <1351094295-10418-1-git-send-email-aloisio.almeida@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Jefferson Delfes <jefferson.delfes@openbossa.org>

Unset controller data allows user to remove some data previously set to be
advertised via set controller data MGMT command.

If LE_ENABLED is set, the HCI_OP_LE_SET_ADV_DATA command will be sent.

This command is available on the powered off state.

Signed-off-by: Aloisio Almeida Jr <aloisio.almeida@openbossa.org>
---
 include/net/bluetooth/hci_core.h |    1 +
 include/net/bluetooth/mgmt.h     |    6 ++++++
 net/bluetooth/hci_core.c         |   19 +++++++++++++++++++
 net/bluetooth/mgmt.c             |   22 ++++++++++++++++++++++
 4 files changed, 48 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 4046111..d5d4dc4 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -761,6 +761,7 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 int hci_controller_data_add(struct hci_dev *hdev, u8 flags, u8 type, u8 length,
 			    u8 *data);
 int hci_controller_data_clear(struct hci_dev *hdev);
+int hci_controller_data_remove(struct hci_dev *hdev, u8 type);
 
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
index e5ab961..2c2f3aa 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1439,6 +1439,25 @@ int hci_controller_data_clear(struct hci_dev *hdev)
 	return 0;
 }
 
+int hci_controller_data_remove(struct hci_dev *hdev, u8 type)
+{
+	struct controller_data *match, *n;
+	int matches = 0;
+
+	list_for_each_entry_safe(match, n, &hdev->controller_data, list) {
+		if (type != match->type)
+			continue;
+
+		list_del(&match->list);
+		hdev->adv_data_len -= sizeof(match->length) +
+				      sizeof(match->type) + match->length;
+		kfree(match);
+		matches++;
+	}
+
+	return matches;
+}
+
 struct bdaddr_list *hci_blacklist_lookup(struct hci_dev *hdev, bdaddr_t *bdaddr)
 {
 	struct bdaddr_list *b;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 1ada019..a094ef3 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2755,6 +2755,27 @@ static int set_controller_data(struct sock *sk, struct hci_dev *hdev,
 			    0);
 }
 
+static int unset_controller_data(struct sock *sk, struct hci_dev *hdev,
+				 void *data, u16 len)
+{
+	struct mgmt_cp_unset_controller_data *cp = data;
+	int removed;
+
+	BT_DBG("%s type:0x%02x", hdev->name, cp->type);
+
+	hci_dev_lock(hdev);
+
+	removed = hci_controller_data_remove(hdev, cp->type);
+
+	if (removed && test_bit(HCI_LE_ENABLED, &hdev->dev_flags))
+		update_adv_data(hdev);
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
@@ -2803,6 +2824,7 @@ static const struct mgmt_handler {
 	{ unblock_device,         false, MGMT_UNBLOCK_DEVICE_SIZE },
 	{ set_device_id,          false, MGMT_SET_DEVICE_ID_SIZE },
 	{ set_controller_data,    true,  MGMT_SET_CONTROLLER_DATA_SIZE },
+	{ unset_controller_data,  false, MGMT_UNSET_CONTROLLER_DATA_SIZE },
 };
 
 
-- 
1.7.10.4

