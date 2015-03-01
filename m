Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/7] Bluetooth: Convert mgmt to use HCI chan registration API
Date: Sun,  1 Mar 2015 09:39:01 +0200
Message-Id: <1425195546-8647-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1425195546-8647-1-git-send-email-johan.hedberg@gmail.com>
References: <1425195546-8647-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch converts the existing mgmt code to use the newly introduced
generic API for registering HCI channels with mgmt-like semantics.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/bluetooth.h |  3 +++
 include/net/bluetooth/hci_core.h  |  4 +++-
 net/bluetooth/af_bluetooth.c      |  9 +++++++++
 net/bluetooth/hci_sock.c          | 19 +------------------
 net/bluetooth/mgmt.c              | 34 +++++++++++++++++++++++-----------
 5 files changed, 39 insertions(+), 30 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index e00455aab18c..124c6afd0c2f 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -358,6 +358,9 @@ void l2cap_exit(void);
 int sco_init(void);
 void sco_exit(void);
 
+int mgmt_init(void);
+void mgmt_exit(void);
+
 void bt_sock_reclassify_lock(struct sock *sk, int proto);
 
 #endif /* __BLUETOOTH_H */
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index c3ba6a0fe58a..bc70830cf7d3 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1307,7 +1307,9 @@ void hci_mgmt_chan_unregister(struct hci_mgmt_chan *c);
 #define DISCOV_BREDR_INQUIRY_LEN	0x08
 #define DISCOV_LE_RESTART_DELAY		msecs_to_jiffies(200)	/* msec */
 
-int mgmt_control(struct sock *sk, struct msghdr *msg, size_t len);
+int mgmt_control(struct hci_mgmt_chan *chan, struct sock *sk,
+		 struct msghdr *msg, size_t msglen);
+
 int mgmt_new_settings(struct hci_dev *hdev);
 void mgmt_index_added(struct hci_dev *hdev);
 void mgmt_index_removed(struct hci_dev *hdev);
diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index ce22e0cfa923..2653ef2d5607 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -750,6 +750,13 @@ static int __init bt_init(void)
 		goto sock_err;
 	}
 
+	err = mgmt_init();
+	if (err < 0) {
+		sco_exit();
+		l2cap_exit();
+		goto sock_err;
+	}
+
 	return 0;
 
 sock_err:
@@ -764,6 +771,8 @@ error:
 
 static void __exit bt_exit(void)
 {
+	mgmt_exit();
+
 	sco_exit();
 
 	l2cap_exit();
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index a352366dfb93..36266b785376 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -741,19 +741,6 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr,
 		hci_pi(sk)->hdev = hdev;
 		break;
 
-	case HCI_CHANNEL_CONTROL:
-		if (haddr.hci_dev != HCI_DEV_NONE) {
-			err = -EINVAL;
-			goto done;
-		}
-
-		if (!capable(CAP_NET_ADMIN)) {
-			err = -EPERM;
-			goto done;
-		}
-
-		break;
-
 	case HCI_CHANNEL_MONITOR:
 		if (haddr.hci_dev != HCI_DEV_NONE) {
 			err = -EINVAL;
@@ -900,7 +887,6 @@ static int hci_sock_recvmsg(struct kiocb *iocb, struct socket *sock,
 		hci_sock_cmsg(sk, msg, skb);
 		break;
 	case HCI_CHANNEL_USER:
-	case HCI_CHANNEL_CONTROL:
 	case HCI_CHANNEL_MONITOR:
 		sock_recv_timestamp(msg, sk, skb);
 		break;
@@ -941,9 +927,6 @@ static int hci_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
 	case HCI_CHANNEL_RAW:
 	case HCI_CHANNEL_USER:
 		break;
-	case HCI_CHANNEL_CONTROL:
-		err = mgmt_control(sk, msg, len);
-		goto done;
 	case HCI_CHANNEL_MONITOR:
 		err = -EOPNOTSUPP;
 		goto done;
@@ -951,7 +934,7 @@ static int hci_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
 		mutex_lock(&mgmt_chan_list_lock);
 		chan = __hci_mgmt_chan_find(hci_pi(sk)->channel);
 		if (chan)
-			err = -ENOSYS; /* FIXME: call handler */
+			err = mgmt_control(chan, sk, msg, len);
 		else
 			err = -EINVAL;
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 1e4635a3374d..ccb725de8c39 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6106,12 +6106,7 @@ unlock:
 	return err;
 }
 
-static const struct mgmt_handler {
-	int (*func) (struct sock *sk, struct hci_dev *hdev, void *data,
-		     u16 data_len);
-	bool var_len;
-	size_t data_len;
-} mgmt_handlers[] = {
+static const struct hci_mgmt_handler mgmt_handlers[] = {
 	{ NULL }, /* 0x0000 (no command) */
 	{ read_version,           false, MGMT_READ_VERSION_SIZE },
 	{ read_commands,          false, MGMT_READ_COMMANDS_SIZE },
@@ -6173,14 +6168,15 @@ static const struct mgmt_handler {
 	{ start_service_discovery,true,  MGMT_START_SERVICE_DISCOVERY_SIZE },
 };
 
-int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
+int mgmt_control(struct hci_mgmt_chan *chan, struct sock *sk,
+		 struct msghdr *msg, size_t msglen)
 {
 	void *buf;
 	u8 *cp;
 	struct mgmt_hdr *hdr;
 	u16 opcode, index, len;
 	struct hci_dev *hdev = NULL;
-	const struct mgmt_handler *handler;
+	const struct hci_mgmt_handler *handler;
 	int err;
 
 	BT_DBG("got %zu bytes", msglen);
@@ -6233,8 +6229,8 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 		}
 	}
 
-	if (opcode >= ARRAY_SIZE(mgmt_handlers) ||
-	    mgmt_handlers[opcode].func == NULL) {
+	if (opcode >= chan->handler_count ||
+	    chan->handlers[opcode].func == NULL) {
 		BT_DBG("Unknown op %u", opcode);
 		err = cmd_status(sk, index, opcode,
 				 MGMT_STATUS_UNKNOWN_COMMAND);
@@ -6255,7 +6251,7 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 		goto done;
 	}
 
-	handler = &mgmt_handlers[opcode];
+	handler = &chan->handlers[opcode];
 
 	if ((handler->var_len && len < handler->data_len) ||
 	    (!handler->var_len && len != handler->data_len)) {
@@ -7481,3 +7477,19 @@ void mgmt_reenable_advertising(struct hci_dev *hdev)
 	enable_advertising(&req);
 	hci_req_run(&req, adv_enable_complete);
 }
+
+static struct hci_mgmt_chan chan = {
+	.channel	= HCI_CHANNEL_CONTROL,
+	.handler_count	= ARRAY_SIZE(mgmt_handlers),
+	.handlers	= mgmt_handlers,
+};
+
+int mgmt_init(void)
+{
+	return hci_mgmt_chan_register(&chan);
+}
+
+void mgmt_exit(void)
+{
+	hci_mgmt_chan_unregister(&chan);
+}
-- 
2.1.0

