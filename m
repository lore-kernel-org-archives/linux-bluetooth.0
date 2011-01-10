Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Do not use assignments in IF conditions
Date: Mon, 10 Jan 2011 17:12:28 +0200
Message-Id: <1294672348-5619-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>

Fix checkpatch warnings concerning assignments in if conditions.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
---
 net/bluetooth/af_bluetooth.c |    6 ++++--
 net/bluetooth/cmtp/capi.c    |    3 ++-
 net/bluetooth/cmtp/core.c    |    9 ++++++---
 net/bluetooth/hci_core.c     |   12 +++++++++---
 net/bluetooth/hci_event.c    |   22 ++++++++++++++--------
 net/bluetooth/hidp/core.c    |    9 ++++++---
 net/bluetooth/l2cap.c        |    6 +++++-
 7 files changed, 46 insertions(+), 21 deletions(-)

diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index c4cf3f5..a6732b5 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -240,7 +240,8 @@ int bt_sock_recvmsg(struct kiocb *iocb, struct socket *sock,
 	if (flags & (MSG_OOB))
 		return -EOPNOTSUPP;
 
-	if (!(skb = skb_recv_datagram(sk, flags, noblock, &err))) {
+	skb = skb_recv_datagram(sk, flags, noblock, &err);
+	if (!skb) {
 		if (sk->sk_shutdown & RCV_SHUTDOWN)
 			return 0;
 		return err;
@@ -323,7 +324,8 @@ int bt_sock_stream_recvmsg(struct kiocb *iocb, struct socket *sock,
 			if (copied >= target)
 				break;
 
-			if ((err = sock_error(sk)) != 0)
+			err = sock_error(sk);
+			if (err)
 				break;
 			if (sk->sk_shutdown & RCV_SHUTDOWN)
 				break;
diff --git a/net/bluetooth/cmtp/capi.c b/net/bluetooth/cmtp/capi.c
index 3487cfe..67cff81 100644
--- a/net/bluetooth/cmtp/capi.c
+++ b/net/bluetooth/cmtp/capi.c
@@ -155,7 +155,8 @@ static void cmtp_send_interopmsg(struct cmtp_session *session,
 
 	BT_DBG("session %p subcmd 0x%02x appl %d msgnum %d", session, subcmd, appl, msgnum);
 
-	if (!(skb = alloc_skb(CAPI_MSG_BASELEN + 6 + len, GFP_ATOMIC))) {
+	skb = alloc_skb(CAPI_MSG_BASELEN + 6 + len, GFP_ATOMIC);
+	if (!skb) {
 		BT_ERR("Can't allocate memory for interoperability packet");
 		return;
 	}
diff --git a/net/bluetooth/cmtp/core.c b/net/bluetooth/cmtp/core.c
index 8e5f292..d8b08ba 100644
--- a/net/bluetooth/cmtp/core.c
+++ b/net/bluetooth/cmtp/core.c
@@ -115,7 +115,8 @@ static inline void cmtp_add_msgpart(struct cmtp_session *session, int id, const
 
 	size = (skb) ? skb->len + count : count;
 
-	if (!(nskb = alloc_skb(size, GFP_ATOMIC))) {
+	nskb = alloc_skb(size, GFP_ATOMIC);
+	if (!nskb) {
 		BT_ERR("Can't allocate memory for CAPI message");
 		return;
 	}
@@ -216,7 +217,8 @@ static void cmtp_process_transmit(struct cmtp_session *session)
 
 	BT_DBG("session %p", session);
 
-	if (!(nskb = alloc_skb(session->mtu, GFP_ATOMIC))) {
+	nskb = alloc_skb(session->mtu, GFP_ATOMIC);
+	if (!nskb) {
 		BT_ERR("Can't allocate memory for new frame");
 		return;
 	}
@@ -224,7 +226,8 @@ static void cmtp_process_transmit(struct cmtp_session *session)
 	while ((skb = skb_dequeue(&session->transmit))) {
 		struct cmtp_scb *scb = (void *) skb->cb;
 
-		if ((tail = (session->mtu - nskb->len)) < 5) {
+		tail = (session->mtu - nskb->len);
+		if (tail < 5) {
 			cmtp_send_frame(session, nskb->data, nskb->len);
 			skb_trim(nskb, 0);
 			tail = session->mtu;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 8b602d8..bf7f4a7 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -429,7 +429,8 @@ int hci_inquiry(void __user *arg)
 	if (copy_from_user(&ir, ptr, sizeof(ir)))
 		return -EFAULT;
 
-	if (!(hdev = hci_dev_get(ir.dev_id)))
+	hdev = hci_dev_get(ir.dev_id);
+	if (!hdev)
 		return -ENODEV;
 
 	hci_dev_lock_bh(hdev);
@@ -489,7 +490,8 @@ int hci_dev_open(__u16 dev)
 	struct hci_dev *hdev;
 	int ret = 0;
 
-	if (!(hdev = hci_dev_get(dev)))
+	hdev = hci_dev_get(dev);
+	if (!hdev)
 		return -ENODEV;
 
 	BT_DBG("%s %p", hdev->name, hdev);
@@ -1752,7 +1754,11 @@ static void hci_cmd_task(unsigned long arg)
 	}
 
 	/* Send queued commands */
-	if (atomic_read(&hdev->cmd_cnt) && (skb = skb_dequeue(&hdev->cmd_q))) {
+	if (atomic_read(&hdev->cmd_cnt)) {
+		skb = skb_dequeue(&hdev->cmd_q);
+		if (!skb)
+			return;
+
 		kfree_skb(hdev->sent_cmd);
 
 		hdev->sent_cmd = skb_clone(skb, GFP_ATOMIC);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 3810017..44e8516 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -622,11 +622,14 @@ static void hci_cs_add_sco(struct hci_dev *hdev, __u8 status)
 	hci_dev_lock(hdev);
 
 	acl = hci_conn_hash_lookup_handle(hdev, handle);
-	if (acl && (sco = acl->link)) {
-		sco->state = BT_CLOSED;
+	if (acl) {
+		sco = acl->link;
+		if (sco) {
+			sco->state = BT_CLOSED;
 
-		hci_proto_connect_cfm(sco, status);
-		hci_conn_del(sco);
+			hci_proto_connect_cfm(sco, status);
+			hci_conn_del(sco);
+		}
 	}
 
 	hci_dev_unlock(hdev);
@@ -808,11 +811,14 @@ static void hci_cs_setup_sync_conn(struct hci_dev *hdev, __u8 status)
 	hci_dev_lock(hdev);
 
 	acl = hci_conn_hash_lookup_handle(hdev, handle);
-	if (acl && (sco = acl->link)) {
-		sco->state = BT_CLOSED;
+	if (acl) {
+		sco = acl->link;
+		if (sco) {
+			sco->state = BT_CLOSED;
 
-		hci_proto_connect_cfm(sco, status);
-		hci_conn_del(sco);
+			hci_proto_connect_cfm(sco, status);
+			hci_conn_del(sco);
+		}
 	}
 
 	hci_dev_unlock(hdev);
diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 29544c2..e0de929 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -157,7 +157,8 @@ static int hidp_queue_event(struct hidp_session *session, struct input_dev *dev,
 
 	session->leds = newleds;
 
-	if (!(skb = alloc_skb(3, GFP_ATOMIC))) {
+	skb = alloc_skb(3, GFP_ATOMIC);
+	if (!skb) {
 		BT_ERR("Can't allocate memory for new frame");
 		return -ENOMEM;
 	}
@@ -250,7 +251,8 @@ static int __hidp_send_ctrl_message(struct hidp_session *session,
 
 	BT_DBG("session %p data %p size %d", session, data, size);
 
-	if (!(skb = alloc_skb(size + 1, GFP_ATOMIC))) {
+	skb = alloc_skb(size + 1, GFP_ATOMIC);
+	if (!skb) {
 		BT_ERR("Can't allocate memory for new frame");
 		return -ENOMEM;
 	}
@@ -283,7 +285,8 @@ static int hidp_queue_report(struct hidp_session *session,
 
 	BT_DBG("session %p hid %p data %p size %d", session, session->hid, data, size);
 
-	if (!(skb = alloc_skb(size + 1, GFP_ATOMIC))) {
+	skb = alloc_skb(size + 1, GFP_ATOMIC);
+	if (!skb) {
 		BT_ERR("Can't allocate memory for new frame");
 		return -ENOMEM;
 	}
diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index c791fcd..3f080fa 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -4692,7 +4692,11 @@ static int l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 fl
 {
 	struct l2cap_conn *conn = hcon->l2cap_data;
 
-	if (!conn && !(conn = l2cap_conn_add(hcon, 0)))
+	if (!conn)
+		goto drop;
+
+	conn = l2cap_conn_add(hcon, 0);
+	if (!conn)
 		goto drop;
 
 	BT_DBG("conn %p len %d flags 0x%x", conn, skb->len, flags);
-- 
1.7.1

