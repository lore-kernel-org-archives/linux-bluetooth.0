Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<henrik.possung@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 03/10] Bluetooth: Add optional data parameter to mgmt_ev_cmd_status event
Date: Thu, 17 Feb 2011 14:16:34 +0100
Message-ID: <1297948601-12723-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1297948601-12723-1-git-send-email-szymon.janc@tieto.com>
References: <1297948601-12723-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In managment interface command status event is used to report command failure.
Some commands (i.e. Read Local Oob Data) should be able to provide extra data
on failure.

Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
---
 include/net/bluetooth/mgmt.h |    1 +
 net/bluetooth/mgmt.c         |   95 ++++++++++++++++++++++++------------------
 2 files changed, 56 insertions(+), 40 deletions(-)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 44ac55c..a5cc1e0 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -170,6 +170,7 @@ struct mgmt_ev_cmd_complete {
 struct mgmt_ev_cmd_status {
 	__u8 status;
 	__le16 opcode;
+	__u8 data[0];
 } __packed;
 
 #define MGMT_EV_CONTROLLER_ERROR	0x0003
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index f5ef7a3..aee1da6 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -42,7 +42,8 @@ struct pending_cmd {
 
 LIST_HEAD(cmd_list);
 
-static int cmd_status(struct sock *sk, u16 cmd, u8 status)
+static int cmd_status(struct sock *sk, u16 cmd, u8 status, void *data,
+								size_t data_len)
 {
 	struct sk_buff *skb;
 	struct mgmt_hdr *hdr;
@@ -50,19 +51,22 @@ static int cmd_status(struct sock *sk, u16 cmd, u8 status)
 
 	BT_DBG("sock %p", sk);
 
-	skb = alloc_skb(sizeof(*hdr) + sizeof(*ev), GFP_ATOMIC);
+	skb = alloc_skb(sizeof(*hdr) + sizeof(*ev) + data_len, GFP_ATOMIC);
 	if (!skb)
 		return -ENOMEM;
 
 	hdr = (void *) skb_put(skb, sizeof(*hdr));
 
 	hdr->opcode = cpu_to_le16(MGMT_EV_CMD_STATUS);
-	hdr->len = cpu_to_le16(sizeof(*ev));
+	hdr->len = cpu_to_le16(sizeof(*ev) + data_len);
 
-	ev = (void *) skb_put(skb, sizeof(*ev));
+	ev = (void *) skb_put(skb, sizeof(*ev) + data_len);
 	ev->status = status;
 	put_unaligned_le16(cmd, &ev->opcode);
 
+	if (data)
+		memcpy(ev->data, data, data_len);
+
 	if (sock_queue_rcv_skb(sk, skb) < 0)
 		kfree_skb(skb);
 
@@ -168,7 +172,7 @@ static int read_controller_info(struct sock *sk, unsigned char *data, u16 len)
 	BT_DBG("sock %p", sk);
 
 	if (len != 2)
-		return cmd_status(sk, MGMT_OP_READ_INFO, EINVAL);
+		return cmd_status(sk, MGMT_OP_READ_INFO, EINVAL, NULL, 0);
 
 	dev_id = get_unaligned_le16(&cp->index);
 
@@ -176,7 +180,7 @@ static int read_controller_info(struct sock *sk, unsigned char *data, u16 len)
 
 	hdev = hci_dev_get(dev_id);
 	if (!hdev)
-		return cmd_status(sk, MGMT_OP_READ_INFO, ENODEV);
+		return cmd_status(sk, MGMT_OP_READ_INFO, ENODEV, NULL, 0);
 
 	hci_del_off_timer(hdev);
 
@@ -315,18 +319,18 @@ static int set_powered(struct sock *sk, unsigned char *data, u16 len)
 
 	hdev = hci_dev_get(dev_id);
 	if (!hdev)
-		return cmd_status(sk, MGMT_OP_SET_POWERED, ENODEV);
+		return cmd_status(sk, MGMT_OP_SET_POWERED, ENODEV, NULL, 0);
 
 	hci_dev_lock_bh(hdev);
 
 	up = test_bit(HCI_UP, &hdev->flags);
 	if ((cp->val && up) || (!cp->val && !up)) {
-		ret = cmd_status(sk, MGMT_OP_SET_POWERED, EALREADY);
+		ret = cmd_status(sk, MGMT_OP_SET_POWERED, EALREADY, NULL, 0);
 		goto failed;
 	}
 
 	if (mgmt_pending_find(MGMT_OP_SET_POWERED, dev_id)) {
-		ret = cmd_status(sk, MGMT_OP_SET_POWERED, EBUSY);
+		ret = cmd_status(sk, MGMT_OP_SET_POWERED, EBUSY, NULL, 0);
 		goto failed;
 	}
 
@@ -362,24 +366,27 @@ static int set_discoverable(struct sock *sk, unsigned char *data, u16 len)
 
 	hdev = hci_dev_get(dev_id);
 	if (!hdev)
-		return cmd_status(sk, MGMT_OP_SET_DISCOVERABLE, ENODEV);
+		return cmd_status(sk, MGMT_OP_SET_DISCOVERABLE, ENODEV, NULL,
+									0);
 
 	hci_dev_lock_bh(hdev);
 
 	if (!test_bit(HCI_UP, &hdev->flags)) {
-		err = cmd_status(sk, MGMT_OP_SET_DISCOVERABLE, ENETDOWN);
+		err = cmd_status(sk, MGMT_OP_SET_DISCOVERABLE, ENETDOWN, NULL,
+									0);
 		goto failed;
 	}
 
 	if (mgmt_pending_find(MGMT_OP_SET_DISCOVERABLE, dev_id) ||
 			mgmt_pending_find(MGMT_OP_SET_CONNECTABLE, dev_id)) {
-		err = cmd_status(sk, MGMT_OP_SET_DISCOVERABLE, EBUSY);
+		err = cmd_status(sk, MGMT_OP_SET_DISCOVERABLE, EBUSY, NULL, 0);
 		goto failed;
 	}
 
 	if (cp->val == test_bit(HCI_ISCAN, &hdev->flags) &&
 					test_bit(HCI_PSCAN, &hdev->flags)) {
-		err = cmd_status(sk, MGMT_OP_SET_DISCOVERABLE, EALREADY);
+		err = cmd_status(sk, MGMT_OP_SET_DISCOVERABLE, EALREADY, NULL,
+									0);
 		goto failed;
 	}
 
@@ -418,23 +425,25 @@ static int set_connectable(struct sock *sk, unsigned char *data, u16 len)
 
 	hdev = hci_dev_get(dev_id);
 	if (!hdev)
-		return cmd_status(sk, MGMT_OP_SET_CONNECTABLE, ENODEV);
+		return cmd_status(sk, MGMT_OP_SET_CONNECTABLE, ENODEV, NULL, 0);
 
 	hci_dev_lock_bh(hdev);
 
 	if (!test_bit(HCI_UP, &hdev->flags)) {
-		err = cmd_status(sk, MGMT_OP_SET_CONNECTABLE, ENETDOWN);
+		err = cmd_status(sk, MGMT_OP_SET_CONNECTABLE, ENETDOWN, NULL,
+									0);
 		goto failed;
 	}
 
 	if (mgmt_pending_find(MGMT_OP_SET_DISCOVERABLE, dev_id) ||
 			mgmt_pending_find(MGMT_OP_SET_CONNECTABLE, dev_id)) {
-		err = cmd_status(sk, MGMT_OP_SET_CONNECTABLE, EBUSY);
+		err = cmd_status(sk, MGMT_OP_SET_CONNECTABLE, EBUSY, NULL, 0);
 		goto failed;
 	}
 
 	if (cp->val == test_bit(HCI_PSCAN, &hdev->flags)) {
-		err = cmd_status(sk, MGMT_OP_SET_CONNECTABLE, EALREADY);
+		err = cmd_status(sk, MGMT_OP_SET_CONNECTABLE, EALREADY, NULL,
+									0);
 		goto failed;
 	}
 
@@ -505,7 +514,7 @@ static int set_pairable(struct sock *sk, unsigned char *data, u16 len)
 
 	hdev = hci_dev_get(dev_id);
 	if (!hdev)
-		return cmd_status(sk, MGMT_OP_SET_PAIRABLE, ENODEV);
+		return cmd_status(sk, MGMT_OP_SET_PAIRABLE, ENODEV, NULL, 0);
 
 	hci_dev_lock_bh(hdev);
 
@@ -578,7 +587,7 @@ static int add_uuid(struct sock *sk, unsigned char *data, u16 len)
 
 	hdev = hci_dev_get(dev_id);
 	if (!hdev)
-		return cmd_status(sk, MGMT_OP_ADD_UUID, ENODEV);
+		return cmd_status(sk, MGMT_OP_ADD_UUID, ENODEV, NULL, 0);
 
 	hci_dev_lock_bh(hdev);
 
@@ -622,7 +631,7 @@ static int remove_uuid(struct sock *sk, unsigned char *data, u16 len)
 
 	hdev = hci_dev_get(dev_id);
 	if (!hdev)
-		return cmd_status(sk, MGMT_OP_REMOVE_UUID, ENODEV);
+		return cmd_status(sk, MGMT_OP_REMOVE_UUID, ENODEV, NULL, 0);
 
 	hci_dev_lock_bh(hdev);
 
@@ -644,7 +653,7 @@ static int remove_uuid(struct sock *sk, unsigned char *data, u16 len)
 	}
 
 	if (found == 0) {
-		err = cmd_status(sk, MGMT_OP_REMOVE_UUID, ENOENT);
+		err = cmd_status(sk, MGMT_OP_REMOVE_UUID, ENOENT, NULL, 0);
 		goto unlock;
 	}
 
@@ -675,7 +684,7 @@ static int set_dev_class(struct sock *sk, unsigned char *data, u16 len)
 
 	hdev = hci_dev_get(dev_id);
 	if (!hdev)
-		return cmd_status(sk, MGMT_OP_SET_DEV_CLASS, ENODEV);
+		return cmd_status(sk, MGMT_OP_SET_DEV_CLASS, ENODEV, NULL, 0);
 
 	hci_dev_lock_bh(hdev);
 
@@ -706,7 +715,8 @@ static int set_service_cache(struct sock *sk, unsigned char *data, u16 len)
 
 	hdev = hci_dev_get(dev_id);
 	if (!hdev)
-		return cmd_status(sk, MGMT_OP_SET_SERVICE_CACHE, ENODEV);
+		return cmd_status(sk, MGMT_OP_SET_SERVICE_CACHE, ENODEV, NULL,
+									0);
 
 	hci_dev_lock_bh(hdev);
 
@@ -750,7 +760,7 @@ static int load_keys(struct sock *sk, unsigned char *data, u16 len)
 
 	hdev = hci_dev_get(dev_id);
 	if (!hdev)
-		return cmd_status(sk, MGMT_OP_LOAD_KEYS, ENODEV);
+		return cmd_status(sk, MGMT_OP_LOAD_KEYS, ENODEV, NULL, 0);
 
 	BT_DBG("hci%u debug_keys %u key_count %u", dev_id, cp->debug_keys,
 								key_count);
@@ -792,13 +802,13 @@ static int remove_key(struct sock *sk, unsigned char *data, u16 len)
 
 	hdev = hci_dev_get(dev_id);
 	if (!hdev)
-		return cmd_status(sk, MGMT_OP_REMOVE_KEY, ENODEV);
+		return cmd_status(sk, MGMT_OP_REMOVE_KEY, ENODEV, NULL, 0);
 
 	hci_dev_lock_bh(hdev);
 
 	err = hci_remove_link_key(hdev, &cp->bdaddr);
 	if (err < 0) {
-		err = cmd_status(sk, MGMT_OP_REMOVE_KEY, -err);
+		err = cmd_status(sk, MGMT_OP_REMOVE_KEY, -err, NULL, 0);
 		goto unlock;
 	}
 
@@ -839,23 +849,23 @@ static int disconnect(struct sock *sk, unsigned char *data, u16 len)
 
 	hdev = hci_dev_get(dev_id);
 	if (!hdev)
-		return cmd_status(sk, MGMT_OP_DISCONNECT, ENODEV);
+		return cmd_status(sk, MGMT_OP_DISCONNECT, ENODEV, NULL, 0);
 
 	hci_dev_lock_bh(hdev);
 
 	if (!test_bit(HCI_UP, &hdev->flags)) {
-		err = cmd_status(sk, MGMT_OP_DISCONNECT, ENETDOWN);
+		err = cmd_status(sk, MGMT_OP_DISCONNECT, ENETDOWN, NULL, 0);
 		goto failed;
 	}
 
 	if (mgmt_pending_find(MGMT_OP_DISCONNECT, dev_id)) {
-		err = cmd_status(sk, MGMT_OP_DISCONNECT, EBUSY);
+		err = cmd_status(sk, MGMT_OP_DISCONNECT, EBUSY, NULL, 0);
 		goto failed;
 	}
 
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &cp->bdaddr);
 	if (!conn) {
-		err = cmd_status(sk, MGMT_OP_DISCONNECT, ENOTCONN);
+		err = cmd_status(sk, MGMT_OP_DISCONNECT, ENOTCONN, NULL, 0);
 		goto failed;
 	}
 
@@ -894,7 +904,7 @@ static int get_connections(struct sock *sk, unsigned char *data, u16 len)
 
 	hdev = hci_dev_get(dev_id);
 	if (!hdev)
-		return cmd_status(sk, MGMT_OP_GET_CONNECTIONS, ENODEV);
+		return cmd_status(sk, MGMT_OP_GET_CONNECTIONS, ENODEV, NULL, 0);
 
 	hci_dev_lock_bh(hdev);
 
@@ -948,12 +958,12 @@ static int pin_code_reply(struct sock *sk, unsigned char *data, u16 len)
 
 	hdev = hci_dev_get(dev_id);
 	if (!hdev)
-		return cmd_status(sk, MGMT_OP_DISCONNECT, ENODEV);
+		return cmd_status(sk, MGMT_OP_DISCONNECT, ENODEV, NULL, 0);
 
 	hci_dev_lock_bh(hdev);
 
 	if (!test_bit(HCI_UP, &hdev->flags)) {
-		err = cmd_status(sk, MGMT_OP_PIN_CODE_REPLY, ENETDOWN);
+		err = cmd_status(sk, MGMT_OP_PIN_CODE_REPLY, ENETDOWN, NULL, 0);
 		goto failed;
 	}
 
@@ -990,12 +1000,14 @@ static int pin_code_neg_reply(struct sock *sk, unsigned char *data, u16 len)
 
 	hdev = hci_dev_get(dev_id);
 	if (!hdev)
-		return cmd_status(sk, MGMT_OP_PIN_CODE_NEG_REPLY, ENODEV);
+		return cmd_status(sk, MGMT_OP_PIN_CODE_NEG_REPLY, ENODEV, NULL,
+									0);
 
 	hci_dev_lock_bh(hdev);
 
 	if (!test_bit(HCI_UP, &hdev->flags)) {
-		err = cmd_status(sk, MGMT_OP_PIN_CODE_NEG_REPLY, ENETDOWN);
+		err = cmd_status(sk, MGMT_OP_PIN_CODE_NEG_REPLY, ENETDOWN, NULL,
+									0);
 		goto failed;
 	}
 
@@ -1029,7 +1041,8 @@ static int set_io_capability(struct sock *sk, unsigned char *data, u16 len)
 
 	hdev = hci_dev_get(dev_id);
 	if (!hdev)
-		return cmd_status(sk, MGMT_OP_SET_IO_CAPABILITY, ENODEV);
+		return cmd_status(sk, MGMT_OP_SET_IO_CAPABILITY, ENODEV, NULL,
+									0);
 
 	hci_dev_lock_bh(hdev);
 
@@ -1132,7 +1145,7 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 		break;
 	default:
 		BT_DBG("Unknown op %u", opcode);
-		err = cmd_status(sk, opcode, 0x01);
+		err = cmd_status(sk, opcode, 0x01, NULL, 0);
 		break;
 	}
 
@@ -1320,7 +1333,7 @@ int mgmt_disconnect_failed(u16 index)
 	if (!cmd)
 		return -ENOENT;
 
-	err = cmd_status(cmd->sk, MGMT_OP_DISCONNECT, EIO);
+	err = cmd_status(cmd->sk, MGMT_OP_DISCONNECT, EIO, NULL, 0);
 
 	list_del(&cmd->list);
 	mgmt_pending_free(cmd);
@@ -1359,7 +1372,8 @@ int mgmt_pin_code_reply_complete(u16 index, bdaddr_t *bdaddr, u8 status)
 		return -ENOENT;
 
 	if (status != 0)
-		err = cmd_status(cmd->sk, MGMT_OP_PIN_CODE_REPLY, status);
+		err = cmd_status(cmd->sk, MGMT_OP_PIN_CODE_REPLY, status, NULL,
+									0);
 	else
 		err = cmd_complete(cmd->sk, MGMT_OP_PIN_CODE_REPLY,
 						bdaddr, sizeof(*bdaddr));
@@ -1380,7 +1394,8 @@ int mgmt_pin_code_neg_reply_complete(u16 index, bdaddr_t *bdaddr, u8 status)
 		return -ENOENT;
 
 	if (status != 0)
-		err = cmd_status(cmd->sk, MGMT_OP_PIN_CODE_NEG_REPLY, status);
+		err = cmd_status(cmd->sk, MGMT_OP_PIN_CODE_NEG_REPLY, status,
+								NULL, 0);
 	else
 		err = cmd_complete(cmd->sk, MGMT_OP_PIN_CODE_NEG_REPLY,
 						bdaddr, sizeof(*bdaddr));
-- 
1.7.0.4

