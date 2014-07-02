Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Add support for Read Unconfigured Index List command
Date: Wed,  2 Jul 2014 22:10:52 +0200
Message-Id: <1404331852-40619-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This command allows to get the list of currently known controller that
are in unconfigured state.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/mgmt.h |  7 ++++
 net/bluetooth/mgmt.c         | 91 +++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 88 insertions(+), 10 deletions(-)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 651993213bd9..e0786cfa5490 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -464,6 +464,13 @@ struct mgmt_cp_load_conn_param {
 } __packed;
 #define MGMT_LOAD_CONN_PARAM_SIZE	2
 
+#define MGMT_OP_READ_UNCONF_INDEX_LIST	0x0036
+#define MGMT_READ_UNCONF_INDEX_LIST_SIZE 0
+struct mgmt_rp_read_unconf_index_list {
+	__le16	num_controllers;
+	__le16	index[0];
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 1a78d26b0049..d05d64240d99 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -89,6 +89,7 @@ static const u16 mgmt_commands[] = {
 	MGMT_OP_ADD_DEVICE,
 	MGMT_OP_REMOVE_DEVICE,
 	MGMT_OP_LOAD_CONN_PARAM,
+	MGMT_OP_READ_UNCONF_INDEX_LIST,
 };
 
 static const u16 mgmt_events[] = {
@@ -336,7 +337,8 @@ static int read_index_list(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	count = 0;
 	list_for_each_entry(d, &hci_dev_list, list) {
-		if (d->dev_type == HCI_BREDR)
+		if (d->dev_type == HCI_BREDR &&
+		    !test_bit(HCI_UNCONFIGURED, &d->dev_flags))
 			count++;
 	}
 
@@ -349,16 +351,18 @@ static int read_index_list(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	count = 0;
 	list_for_each_entry(d, &hci_dev_list, list) {
-		if (test_bit(HCI_SETUP, &d->dev_flags))
+		if (test_bit(HCI_SETUP, &d->dev_flags) ||
+		    test_bit(HCI_USER_CHANNEL, &d->dev_flags))
 			continue;
 
-		if (test_bit(HCI_USER_CHANNEL, &d->dev_flags))
-			continue;
-
-		if (test_bit(HCI_UNCONFIGURED, &d->dev_flags))
+		/* Devices marked as raw-only are neither configured
+		 * nor unconfigured controllers.
+		 */
+		if (test_bit(HCI_QUIRK_RAW_DEVICE, &d->quirks))
 			continue;
 
-		if (d->dev_type == HCI_BREDR) {
+		if (d->dev_type == HCI_BREDR &&
+		    !test_bit(HCI_UNCONFIGURED, &d->dev_flags)) {
 			rp->index[count++] = cpu_to_le16(d->id);
 			BT_DBG("Added hci%u", d->id);
 		}
@@ -377,6 +381,65 @@ static int read_index_list(struct sock *sk, struct hci_dev *hdev, void *data,
 	return err;
 }
 
+static int read_unconf_index_list(struct sock *sk, struct hci_dev *hdev,
+				  void *data, u16 data_len)
+{
+	struct mgmt_rp_read_unconf_index_list *rp;
+	struct hci_dev *d;
+	size_t rp_len;
+	u16 count;
+	int err;
+
+	BT_DBG("sock %p", sk);
+
+	read_lock(&hci_dev_list_lock);
+
+	count = 0;
+	list_for_each_entry(d, &hci_dev_list, list) {
+		if (d->dev_type == HCI_BREDR &&
+		    test_bit(HCI_UNCONFIGURED, &d->dev_flags))
+			count++;
+	}
+
+	rp_len = sizeof(*rp) + (2 * count);
+	rp = kmalloc(rp_len, GFP_ATOMIC);
+	if (!rp) {
+		read_unlock(&hci_dev_list_lock);
+		return -ENOMEM;
+	}
+
+	count = 0;
+	list_for_each_entry(d, &hci_dev_list, list) {
+		if (test_bit(HCI_SETUP, &d->dev_flags) ||
+		    test_bit(HCI_USER_CHANNEL, &d->dev_flags))
+			continue;
+
+		/* Devices marked as raw-only are neither configured
+		 * nor unconfigured controllers.
+		 */
+		if (test_bit(HCI_QUIRK_RAW_DEVICE, &d->quirks))
+			continue;
+
+		if (d->dev_type == HCI_BREDR &&
+		    test_bit(HCI_UNCONFIGURED, &d->dev_flags)) {
+			rp->index[count++] = cpu_to_le16(d->id);
+			BT_DBG("Added hci%u", d->id);
+		}
+	}
+
+	rp->num_controllers = cpu_to_le16(count);
+	rp_len = sizeof(*rp) + (2 * count);
+
+	read_unlock(&hci_dev_list_lock);
+
+	err = cmd_complete(sk, MGMT_INDEX_NONE, MGMT_OP_READ_UNCONF_INDEX_LIST,
+			   0, rp, rp_len);
+
+	kfree(rp);
+
+	return err;
+}
+
 static u32 get_supported_settings(struct hci_dev *hdev)
 {
 	u32 settings = 0;
@@ -5273,7 +5336,8 @@ static const struct mgmt_handler {
 	{ get_clock_info,         false, MGMT_GET_CLOCK_INFO_SIZE },
 	{ add_device,             false, MGMT_ADD_DEVICE_SIZE },
 	{ remove_device,          false, MGMT_REMOVE_DEVICE_SIZE },
-	{ load_conn_param,        true, MGMT_LOAD_CONN_PARAM_SIZE },
+	{ load_conn_param,        true,  MGMT_LOAD_CONN_PARAM_SIZE },
+	{ read_unconf_index_list, false, MGMT_READ_UNCONF_INDEX_LIST_SIZE },
 };
 
 int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
@@ -5335,8 +5399,15 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 		goto done;
 	}
 
-	if ((hdev && opcode < MGMT_OP_READ_INFO) ||
-	    (!hdev && opcode >= MGMT_OP_READ_INFO)) {
+	if (hdev && (opcode <= MGMT_OP_READ_INDEX_LIST ||
+		     opcode == MGMT_OP_READ_UNCONF_INDEX_LIST)) {
+		err = cmd_status(sk, index, opcode,
+				 MGMT_STATUS_INVALID_INDEX);
+		goto done;
+	}
+
+	if (!hdev && opcode > MGMT_OP_READ_INDEX_LIST &&
+		     opcode != MGMT_OP_READ_UNCONF_INDEX_LIST) {
 		err = cmd_status(sk, index, opcode,
 				 MGMT_STATUS_INVALID_INDEX);
 		goto done;
-- 
1.9.3

