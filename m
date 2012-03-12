Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: Fix broken usage of put_unaligned_le16
Date: Mon, 12 Mar 2012 10:33:45 -0700
Message-Id: <1331573625-3916-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In case the struct is already __packed, there is no need to use unaligned
access to the data. So just use cpu_to_le16 or __constant_cpu_to_le16 in
these cases.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c |   33 ++++++++++++++++-----------------
 1 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 6fb1418..2c09f0a 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -224,7 +224,7 @@ static int cmd_status(struct sock *sk, u16 index, u16 cmd, u8 status)
 
 	ev = (void *) skb_put(skb, sizeof(*ev));
 	ev->status = status;
-	put_unaligned_le16(cmd, &ev->opcode);
+	ev->opcode = cpu_to_le16(cmd);
 
 	err = sock_queue_rcv_skb(sk, skb);
 	if (err < 0)
@@ -254,7 +254,7 @@ static int cmd_complete(struct sock *sk, u16 index, u16 cmd, u8 status,
 	hdr->len = cpu_to_le16(sizeof(*ev) + rp_len);
 
 	ev = (void *) skb_put(skb, sizeof(*ev) + rp_len);
-	put_unaligned_le16(cmd, &ev->opcode);
+	ev->opcode = cpu_to_le16(cmd);
 	ev->status = status;
 
 	if (rp)
@@ -275,7 +275,7 @@ static int read_version(struct sock *sk, struct hci_dev *hdev, void *data,
 	BT_DBG("sock %p", sk);
 
 	rp.version = MGMT_VERSION;
-	put_unaligned_le16(MGMT_REVISION, &rp.revision);
+	rp.revision = __constant_cpu_to_le16(MGMT_REVISION);
 
 	return cmd_complete(sk, MGMT_INDEX_NONE, MGMT_OP_READ_VERSION, 0, &rp,
 			    sizeof(rp));
@@ -285,8 +285,8 @@ static int read_commands(struct sock *sk, struct hci_dev *hdev, void *data,
 			 u16 data_len)
 {
 	struct mgmt_rp_read_commands *rp;
-	u16 num_commands = ARRAY_SIZE(mgmt_commands);
-	u16 num_events = ARRAY_SIZE(mgmt_events);
+	const u16 num_commands = ARRAY_SIZE(mgmt_commands);
+	const u16 num_events = ARRAY_SIZE(mgmt_events);
 	u16 *opcode;
 	size_t rp_size;
 	int i, err;
@@ -299,8 +299,8 @@ static int read_commands(struct sock *sk, struct hci_dev *hdev, void *data,
 	if (!rp)
 		return -ENOMEM;
 
-	put_unaligned_le16(num_commands, &rp->num_commands);
-	put_unaligned_le16(num_events, &rp->num_events);
+	rp->num_commands = __constant_cpu_to_le16(num_commands);
+	rp->num_events = __constant_cpu_to_le16(num_events);
 
 	for (i = 0, opcode = rp->opcodes; i < num_commands; i++, opcode++)
 		put_unaligned_le16(mgmt_commands[i], opcode);
@@ -341,14 +341,14 @@ static int read_index_list(struct sock *sk, struct hci_dev *hdev, void *data,
 		return -ENOMEM;
 	}
 
-	put_unaligned_le16(count, &rp->num_controllers);
+	rp->num_controllers = cpu_to_le16(count);
 
 	i = 0;
 	list_for_each_entry(d, &hci_dev_list, list) {
 		if (test_bit(HCI_SETUP, &d->dev_flags))
 			continue;
 
-		put_unaligned_le16(d->id, &rp->index[i++]);
+		rp->index[i++] = cpu_to_le16(d->id);
 		BT_DBG("Added hci%u", d->id);
 	}
 
@@ -664,8 +664,7 @@ static int read_controller_info(struct sock *sk, struct hci_dev *hdev,
 	bacpy(&rp.bdaddr, &hdev->bdaddr);
 
 	rp.version = hdev->hci_ver;
-
-	put_unaligned_le16(hdev->manufacturer, &rp.manufacturer);
+	rp.manufacturer = cpu_to_le16(hdev->manufacturer);
 
 	rp.supported_settings = cpu_to_le32(get_supported_settings(hdev));
 	rp.current_settings = cpu_to_le32(get_current_settings(hdev));
@@ -1570,7 +1569,7 @@ static int unpair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto unlock;
 	}
 
-	put_unaligned_le16(conn->handle, &dc.handle);
+	dc.handle = cpu_to_le16(conn->handle);
 	dc.reason = 0x13; /* Remote User Terminated Connection */
 	err = hci_send_cmd(hdev, HCI_OP_DISCONNECT, sizeof(dc), &dc);
 	if (err < 0)
@@ -1623,7 +1622,7 @@ static int disconnect(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto failed;
 	}
 
-	put_unaligned_le16(conn->handle, &dc.handle);
+	dc.handle = cpu_to_le16(conn->handle);
 	dc.reason = 0x13; /* Remote User Terminated Connection */
 
 	err = hci_send_cmd(hdev, HCI_OP_DISCONNECT, sizeof(dc), &dc);
@@ -1697,7 +1696,7 @@ static int get_connections(struct sock *sk, struct hci_dev *hdev, void *data,
 		i++;
 	}
 
-	put_unaligned_le16(i, &rp->conn_count);
+	rp->conn_count = cpu_to_le16(i);
 
 	/* Recalculate length in case of filtered SCO connections, etc */
 	rp_len = sizeof(*rp) + (i * sizeof(struct mgmt_addr_info));
@@ -2961,7 +2960,7 @@ int mgmt_device_connected(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 		eir_len = eir_append_data(&ev->eir[eir_len], eir_len,
 					  EIR_CLASS_OF_DEV, dev_class, 3);
 
-	put_unaligned_le16(eir_len, &ev->eir_len);
+	ev->eir_len = cpu_to_le16(eir_len);
 
 	return mgmt_event(MGMT_EV_DEVICE_CONNECTED, hdev, buf,
 			  sizeof(*ev) + eir_len, NULL);
@@ -3486,7 +3485,7 @@ int mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 		eir_len = eir_append_data(ev->eir, eir_len, EIR_CLASS_OF_DEV,
 					  dev_class, 3);
 
-	put_unaligned_le16(eir_len, &ev->eir_len);
+	ev->eir_len = cpu_to_le16(eir_len);
 
 	ev_size = sizeof(*ev) + eir_len;
 
@@ -3511,7 +3510,7 @@ int mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 	eir_len = eir_append_data(ev->eir, 0, EIR_NAME_COMPLETE, name,
 				  name_len);
 
-	put_unaligned_le16(eir_len, &ev->eir_len);
+	ev->eir_len = cpu_to_le16(eir_len);
 
 	return mgmt_event(MGMT_EV_DEVICE_FOUND, hdev, ev,
 			  sizeof(*ev) + eir_len, NULL);
-- 
1.7.7.6

