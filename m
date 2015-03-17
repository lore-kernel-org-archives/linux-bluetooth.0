Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/5] Bluetooth: Move generic mgmt command dispatcher to hci_sock.c
Date: Tue, 17 Mar 2015 13:48:50 +0200
Message-Id: <1426592930-5842-6-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1426592930-5842-1-git-send-email-johan.hedberg@gmail.com>
References: <1426592930-5842-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The mgmt.c file should be reserved purely for HCI_CHANNEL_CONTROL. The
mgmt_control() function in it is already completely generic and has a
single user in hci_sock.c. This patch moves the function there and
renames it a bit more appropriately to hci_mgmt_cmd() (as it's a command
dispatcher).

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |   3 -
 net/bluetooth/hci_sock.c         | 116 ++++++++++++++++++++++++++++++++++++++-
 net/bluetooth/mgmt.c             | 111 -------------------------------------
 3 files changed, 115 insertions(+), 115 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 93e7b2b05a17..b65c53de6a69 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1330,9 +1330,6 @@ void hci_mgmt_chan_unregister(struct hci_mgmt_chan *c);
 #define DISCOV_BREDR_INQUIRY_LEN	0x08
 #define DISCOV_LE_RESTART_DELAY		msecs_to_jiffies(200)	/* msec */
 
-int mgmt_control(struct hci_mgmt_chan *chan, struct sock *sk,
-		 struct msghdr *msg, size_t msglen);
-
 int mgmt_new_settings(struct hci_dev *hdev);
 void mgmt_index_added(struct hci_dev *hdev);
 void mgmt_index_removed(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 9ba1a2667eaa..85a44a7dc150 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -30,6 +30,9 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/hci_mon.h>
+#include <net/bluetooth/mgmt.h>
+
+#include "mgmt_util.h"
 
 static LIST_HEAD(mgmt_chan_list);
 static DEFINE_MUTEX(mgmt_chan_list_lock);
@@ -951,6 +954,117 @@ static int hci_sock_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 	return err ? : copied;
 }
 
+static int hci_mgmt_cmd(struct hci_mgmt_chan *chan, struct sock *sk,
+			struct msghdr *msg, size_t msglen)
+{
+	void *buf;
+	u8 *cp;
+	struct mgmt_hdr *hdr;
+	u16 opcode, index, len;
+	struct hci_dev *hdev = NULL;
+	const struct hci_mgmt_handler *handler;
+	bool var_len, no_hdev;
+	int err;
+
+	BT_DBG("got %zu bytes", msglen);
+
+	if (msglen < sizeof(*hdr))
+		return -EINVAL;
+
+	buf = kmalloc(msglen, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	if (memcpy_from_msg(buf, msg, msglen)) {
+		err = -EFAULT;
+		goto done;
+	}
+
+	hdr = buf;
+	opcode = __le16_to_cpu(hdr->opcode);
+	index = __le16_to_cpu(hdr->index);
+	len = __le16_to_cpu(hdr->len);
+
+	if (len != msglen - sizeof(*hdr)) {
+		err = -EINVAL;
+		goto done;
+	}
+
+	if (opcode >= chan->handler_count ||
+	    chan->handlers[opcode].func == NULL) {
+		BT_DBG("Unknown op %u", opcode);
+		err = mgmt_cmd_status(sk, index, opcode,
+				      MGMT_STATUS_UNKNOWN_COMMAND);
+		goto done;
+	}
+
+	handler = &chan->handlers[opcode];
+
+	if (!hci_sock_test_flag(sk, HCI_SOCK_TRUSTED) &&
+	    !(handler->flags & HCI_MGMT_UNTRUSTED)) {
+		err = mgmt_cmd_status(sk, index, opcode,
+				      MGMT_STATUS_PERMISSION_DENIED);
+		goto done;
+	}
+
+	if (index != MGMT_INDEX_NONE) {
+		hdev = hci_dev_get(index);
+		if (!hdev) {
+			err = mgmt_cmd_status(sk, index, opcode,
+					      MGMT_STATUS_INVALID_INDEX);
+			goto done;
+		}
+
+		if (hci_dev_test_flag(hdev, HCI_SETUP) ||
+		    hci_dev_test_flag(hdev, HCI_CONFIG) ||
+		    hci_dev_test_flag(hdev, HCI_USER_CHANNEL)) {
+			err = mgmt_cmd_status(sk, index, opcode,
+					      MGMT_STATUS_INVALID_INDEX);
+			goto done;
+		}
+
+		if (hci_dev_test_flag(hdev, HCI_UNCONFIGURED) &&
+		    !(handler->flags & HCI_MGMT_UNCONFIGURED)) {
+			err = mgmt_cmd_status(sk, index, opcode,
+					      MGMT_STATUS_INVALID_INDEX);
+			goto done;
+		}
+	}
+
+	no_hdev = (handler->flags & HCI_MGMT_NO_HDEV);
+	if (no_hdev != !hdev) {
+		err = mgmt_cmd_status(sk, index, opcode,
+				      MGMT_STATUS_INVALID_INDEX);
+		goto done;
+	}
+
+	var_len = (handler->flags & HCI_MGMT_VAR_LEN);
+	if ((var_len && len < handler->data_len) ||
+	    (!var_len && len != handler->data_len)) {
+		err = mgmt_cmd_status(sk, index, opcode,
+				      MGMT_STATUS_INVALID_PARAMS);
+		goto done;
+	}
+
+	if (hdev && chan->hdev_init)
+		chan->hdev_init(sk, hdev);
+
+	cp = buf + sizeof(*hdr);
+
+	err = handler->func(sk, hdev, cp, len);
+	if (err < 0)
+		goto done;
+
+	err = msglen;
+
+done:
+	if (hdev)
+		hci_dev_put(hdev);
+
+	kfree(buf);
+	return err;
+}
+
 static int hci_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 			    size_t len)
 {
@@ -984,7 +1098,7 @@ static int hci_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 		mutex_lock(&mgmt_chan_list_lock);
 		chan = __hci_mgmt_chan_find(hci_pi(sk)->channel);
 		if (chan)
-			err = mgmt_control(chan, sk, msg, len);
+			err = hci_mgmt_cmd(chan, sk, msg, len);
 		else
 			err = -EINVAL;
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 363a4348c40b..cb302f81e39c 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6353,117 +6353,6 @@ static const struct hci_mgmt_handler mgmt_handlers[] = {
 	{ read_adv_features,       MGMT_READ_ADV_FEATURES_SIZE },
 };
 
-int mgmt_control(struct hci_mgmt_chan *chan, struct sock *sk,
-		 struct msghdr *msg, size_t msglen)
-{
-	void *buf;
-	u8 *cp;
-	struct mgmt_hdr *hdr;
-	u16 opcode, index, len;
-	struct hci_dev *hdev = NULL;
-	const struct hci_mgmt_handler *handler;
-	bool var_len, no_hdev;
-	int err;
-
-	BT_DBG("got %zu bytes", msglen);
-
-	if (msglen < sizeof(*hdr))
-		return -EINVAL;
-
-	buf = kmalloc(msglen, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	if (memcpy_from_msg(buf, msg, msglen)) {
-		err = -EFAULT;
-		goto done;
-	}
-
-	hdr = buf;
-	opcode = __le16_to_cpu(hdr->opcode);
-	index = __le16_to_cpu(hdr->index);
-	len = __le16_to_cpu(hdr->len);
-
-	if (len != msglen - sizeof(*hdr)) {
-		err = -EINVAL;
-		goto done;
-	}
-
-	if (opcode >= chan->handler_count ||
-	    chan->handlers[opcode].func == NULL) {
-		BT_DBG("Unknown op %u", opcode);
-		err = mgmt_cmd_status(sk, index, opcode,
-				      MGMT_STATUS_UNKNOWN_COMMAND);
-		goto done;
-	}
-
-	handler = &chan->handlers[opcode];
-
-	if (!hci_sock_test_flag(sk, HCI_SOCK_TRUSTED) &&
-	    !(handler->flags & HCI_MGMT_UNTRUSTED)) {
-		err = mgmt_cmd_status(sk, index, opcode,
-				      MGMT_STATUS_PERMISSION_DENIED);
-		goto done;
-	}
-
-	if (index != MGMT_INDEX_NONE) {
-		hdev = hci_dev_get(index);
-		if (!hdev) {
-			err = mgmt_cmd_status(sk, index, opcode,
-					      MGMT_STATUS_INVALID_INDEX);
-			goto done;
-		}
-
-		if (hci_dev_test_flag(hdev, HCI_SETUP) ||
-		    hci_dev_test_flag(hdev, HCI_CONFIG) ||
-		    hci_dev_test_flag(hdev, HCI_USER_CHANNEL)) {
-			err = mgmt_cmd_status(sk, index, opcode,
-					      MGMT_STATUS_INVALID_INDEX);
-			goto done;
-		}
-
-		if (hci_dev_test_flag(hdev, HCI_UNCONFIGURED) &&
-		    !(handler->flags & HCI_MGMT_UNCONFIGURED)) {
-			err = mgmt_cmd_status(sk, index, opcode,
-					      MGMT_STATUS_INVALID_INDEX);
-			goto done;
-		}
-	}
-
-	no_hdev = (handler->flags & HCI_MGMT_NO_HDEV);
-	if (no_hdev != !hdev) {
-		err = mgmt_cmd_status(sk, index, opcode,
-				      MGMT_STATUS_INVALID_INDEX);
-		goto done;
-	}
-
-	var_len = (handler->flags & HCI_MGMT_VAR_LEN);
-	if ((var_len && len < handler->data_len) ||
-	    (!var_len && len != handler->data_len)) {
-		err = mgmt_cmd_status(sk, index, opcode,
-				      MGMT_STATUS_INVALID_PARAMS);
-		goto done;
-	}
-
-	if (hdev && chan->hdev_init)
-		chan->hdev_init(sk, hdev);
-
-	cp = buf + sizeof(*hdr);
-
-	err = handler->func(sk, hdev, cp, len);
-	if (err < 0)
-		goto done;
-
-	err = msglen;
-
-done:
-	if (hdev)
-		hci_dev_put(hdev);
-
-	kfree(buf);
-	return err;
-}
-
 void mgmt_index_added(struct hci_dev *hdev)
 {
 	struct mgmt_ev_ext_index ev;
-- 
2.1.0

