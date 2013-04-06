Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo@padovan.org>,
	David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH v4 11/16] Bluetooth: hidp: remove old session-management
Date: Sat,  6 Apr 2013 20:28:47 +0200
Message-Id: <1365272932-571-12-git-send-email-dh.herrmann@gmail.com>
In-Reply-To: <1365272932-571-1-git-send-email-dh.herrmann@gmail.com>
References: <1365166670-3271-1-git-send-email-dh.herrmann@gmail.com>
 <1365272932-571-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We have the full new session-management now available so lets switch over
and remove all the old code. Few semantics changed, so we need to adjust
the sock.c callers a bit. But this mostly simplifies the logic.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hidp/core.c | 339 ++--------------------------------------------
 net/bluetooth/hidp/hidp.h |   6 -
 net/bluetooth/hidp/sock.c |  21 +--
 3 files changed, 18 insertions(+), 348 deletions(-)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 8d30a33..481bbb8 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -77,21 +77,7 @@ static inline void hidp_schedule(struct hidp_session *session)
 	wake_up_interruptible(sk_sleep(intr_sk));
 }
 
-static struct hidp_session *__hidp_get_session(bdaddr_t *bdaddr)
-{
-	struct hidp_session *session;
-
-	BT_DBG("");
-
-	list_for_each_entry(session, &hidp_session_list, list) {
-		if (!bacmp(bdaddr, &session->bdaddr))
-			return session;
-	}
-
-	return NULL;
-}
-
-static void __hidp_copy_session(struct hidp_session *session, struct hidp_conninfo *ci)
+static void hidp_copy_session(struct hidp_session *session, struct hidp_conninfo *ci)
 {
 	memset(ci, 0, sizeof(*ci));
 	bacpy(&ci->bdaddr, &session->bdaddr);
@@ -456,8 +442,7 @@ static void hidp_idle_timeout(unsigned long arg)
 {
 	struct hidp_session *session = (struct hidp_session *) arg;
 
-	atomic_inc(&session->terminate);
-	wake_up_process(session->task);
+	hidp_session_terminate(session);
 }
 
 static void hidp_set_timer(struct hidp_session *session)
@@ -525,8 +510,7 @@ static void hidp_process_hid_control(struct hidp_session *session,
 		skb_queue_purge(&session->ctrl_transmit);
 		skb_queue_purge(&session->intr_transmit);
 
-		atomic_inc(&session->terminate);
-		wake_up_process(current);
+		hidp_session_terminate(session);
 	}
 }
 
@@ -686,120 +670,6 @@ static void hidp_process_ctrl_transmit(struct hidp_session *session)
 	}
 }
 
-static int hidp_session(void *arg)
-{
-	struct hidp_session *session = arg;
-	struct sock *ctrl_sk = session->ctrl_sock->sk;
-	struct sock *intr_sk = session->intr_sock->sk;
-	struct sk_buff *skb;
-	wait_queue_t ctrl_wait, intr_wait;
-
-	BT_DBG("session %p", session);
-
-	__module_get(THIS_MODULE);
-	set_user_nice(current, -15);
-
-	init_waitqueue_entry(&ctrl_wait, current);
-	init_waitqueue_entry(&intr_wait, current);
-	add_wait_queue(sk_sleep(ctrl_sk), &ctrl_wait);
-	add_wait_queue(sk_sleep(intr_sk), &intr_wait);
-	session->waiting_for_startup = 0;
-	wake_up_interruptible(&session->startup_queue);
-	set_current_state(TASK_INTERRUPTIBLE);
-	while (!atomic_read(&session->terminate)) {
-		if (ctrl_sk->sk_state != BT_CONNECTED ||
-				intr_sk->sk_state != BT_CONNECTED)
-			break;
-
-		while ((skb = skb_dequeue(&intr_sk->sk_receive_queue))) {
-			skb_orphan(skb);
-			if (!skb_linearize(skb))
-				hidp_recv_intr_frame(session, skb);
-			else
-				kfree_skb(skb);
-		}
-
-		hidp_process_intr_transmit(session);
-
-		while ((skb = skb_dequeue(&ctrl_sk->sk_receive_queue))) {
-			skb_orphan(skb);
-			if (!skb_linearize(skb))
-				hidp_recv_ctrl_frame(session, skb);
-			else
-				kfree_skb(skb);
-		}
-
-		hidp_process_ctrl_transmit(session);
-
-		schedule();
-		set_current_state(TASK_INTERRUPTIBLE);
-	}
-	set_current_state(TASK_RUNNING);
-	atomic_inc(&session->terminate);
-	remove_wait_queue(sk_sleep(intr_sk), &intr_wait);
-	remove_wait_queue(sk_sleep(ctrl_sk), &ctrl_wait);
-
-	clear_bit(HIDP_WAITING_FOR_SEND_ACK, &session->flags);
-	clear_bit(HIDP_WAITING_FOR_RETURN, &session->flags);
-	wake_up_interruptible(&session->report_queue);
-
-	down_write(&hidp_session_sem);
-
-	hidp_del_timer(session);
-
-	if (session->input) {
-		input_unregister_device(session->input);
-		session->input = NULL;
-	}
-
-	if (session->hid) {
-		hid_destroy_device(session->hid);
-		session->hid = NULL;
-	}
-
-	/* Wakeup user-space polling for socket errors */
-	session->intr_sock->sk->sk_err = EUNATCH;
-	session->ctrl_sock->sk->sk_err = EUNATCH;
-
-	hidp_schedule(session);
-
-	fput(session->intr_sock->file);
-
-	wait_event_timeout(*(sk_sleep(ctrl_sk)),
-		(ctrl_sk->sk_state == BT_CLOSED), msecs_to_jiffies(500));
-
-	fput(session->ctrl_sock->file);
-
-	list_del(&session->list);
-
-	up_write(&hidp_session_sem);
-
-	kfree(session->rd_data);
-	kfree(session);
-	module_put_and_exit(0);
-	return 0;
-}
-
-static struct hci_conn *hidp_get_connection(struct hidp_session *session)
-{
-	bdaddr_t *src = &bt_sk(session->ctrl_sock->sk)->src;
-	bdaddr_t *dst = &bt_sk(session->ctrl_sock->sk)->dst;
-	struct hci_conn *conn;
-	struct hci_dev *hdev;
-
-	hdev = hci_get_route(dst, src);
-	if (!hdev)
-		return NULL;
-
-	hci_dev_lock(hdev);
-	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, dst);
-	hci_dev_unlock(hdev);
-
-	hci_dev_put(hdev);
-
-	return conn;
-}
-
 static int hidp_setup_input(struct hidp_session *session,
 				struct hidp_connadd_req *req)
 {
@@ -847,7 +717,7 @@ static int hidp_setup_input(struct hidp_session *session,
 		input->relbit[0] |= BIT_MASK(REL_WHEEL);
 	}
 
-	input->dev.parent = &session->hconn->dev;
+	input->dev.parent = &session->conn->hcon->dev;
 
 	input->event = hidp_input_event;
 
@@ -951,7 +821,7 @@ static int hidp_setup_hid(struct hidp_session *session,
 	snprintf(hid->uniq, sizeof(hid->uniq), "%pMR",
 		 &bt_sk(session->ctrl_sock->sk)->dst);
 
-	hid->dev.parent = &session->hconn->dev;
+	hid->dev.parent = &session->conn->hcon->dev;
 	hid->ll_driver = &hidp_hid_driver;
 
 	hid->hid_get_raw_report = hidp_get_raw_report;
@@ -1510,187 +1380,6 @@ int hidp_connection_del(struct hidp_conndel_req *req)
 	return 0;
 }
 
-int hidp_add_connection(struct hidp_connadd_req *req, struct socket *ctrl_sock, struct socket *intr_sock)
-{
-	struct hidp_session *session, *s;
-	int vendor, product;
-	int err;
-
-	BT_DBG("");
-
-	if (!l2cap_is_socket(ctrl_sock) || !l2cap_is_socket(intr_sock))
-		return -EINVAL;
-	if (bacmp(&bt_sk(ctrl_sock->sk)->src, &bt_sk(intr_sock->sk)->src) ||
-			bacmp(&bt_sk(ctrl_sock->sk)->dst, &bt_sk(intr_sock->sk)->dst))
-		return -ENOTUNIQ;
-
-	BT_DBG("rd_data %p rd_size %d", req->rd_data, req->rd_size);
-
-	down_write(&hidp_session_sem);
-
-	s = __hidp_get_session(&bt_sk(ctrl_sock->sk)->dst);
-	if (s) {
-		up_write(&hidp_session_sem);
-		return -EEXIST;
-	}
-
-	session = kzalloc(sizeof(struct hidp_session), GFP_KERNEL);
-	if (!session) {
-		up_write(&hidp_session_sem);
-		return -ENOMEM;
-	}
-
-	bacpy(&session->bdaddr, &bt_sk(ctrl_sock->sk)->dst);
-
-	session->ctrl_mtu = min_t(uint, l2cap_pi(ctrl_sock->sk)->chan->omtu,
-					l2cap_pi(ctrl_sock->sk)->chan->imtu);
-	session->intr_mtu = min_t(uint, l2cap_pi(intr_sock->sk)->chan->omtu,
-					l2cap_pi(intr_sock->sk)->chan->imtu);
-
-	BT_DBG("ctrl mtu %d intr mtu %d", session->ctrl_mtu, session->intr_mtu);
-
-	session->ctrl_sock = ctrl_sock;
-	session->intr_sock = intr_sock;
-
-	session->hconn = hidp_get_connection(session);
-	if (!session->hconn) {
-		err = -ENOTCONN;
-		goto failed;
-	}
-
-	setup_timer(&session->timer, hidp_idle_timeout, (unsigned long)session);
-
-	skb_queue_head_init(&session->ctrl_transmit);
-	skb_queue_head_init(&session->intr_transmit);
-
-	mutex_init(&session->report_mutex);
-	init_waitqueue_head(&session->report_queue);
-	init_waitqueue_head(&session->startup_queue);
-	session->waiting_for_startup = 1;
-	session->flags   = req->flags & (1 << HIDP_BLUETOOTH_VENDOR_ID);
-	session->idle_to = req->idle_to;
-
-	list_add(&session->list, &hidp_session_list);
-
-	if (req->rd_size > 0) {
-		err = hidp_setup_hid(session, req);
-		if (err && err != -ENODEV)
-			goto purge;
-	}
-
-	if (!session->hid) {
-		err = hidp_setup_input(session, req);
-		if (err < 0)
-			goto purge;
-	}
-
-	hidp_set_timer(session);
-
-	if (session->hid) {
-		vendor  = session->hid->vendor;
-		product = session->hid->product;
-	} else if (session->input) {
-		vendor  = session->input->id.vendor;
-		product = session->input->id.product;
-	} else {
-		vendor = 0x0000;
-		product = 0x0000;
-	}
-
-	session->task = kthread_run(hidp_session, session, "khidpd_%04x%04x",
-							vendor, product);
-	if (IS_ERR(session->task)) {
-		err = PTR_ERR(session->task);
-		goto unlink;
-	}
-
-	while (session->waiting_for_startup) {
-		wait_event_interruptible(session->startup_queue,
-			!session->waiting_for_startup);
-	}
-
-	if (session->hid)
-		err = hid_add_device(session->hid);
-	else
-		err = input_register_device(session->input);
-
-	if (err < 0) {
-		atomic_inc(&session->terminate);
-		wake_up_process(session->task);
-		up_write(&hidp_session_sem);
-		return err;
-	}
-
-	if (session->input) {
-		hidp_send_ctrl_message(session,
-			HIDP_TRANS_SET_PROTOCOL | HIDP_PROTO_BOOT, NULL, 0);
-		session->flags |= (1 << HIDP_BOOT_PROTOCOL_MODE);
-
-		session->leds = 0xff;
-		hidp_input_event(session->input, EV_LED, 0, 0);
-	}
-
-	up_write(&hidp_session_sem);
-	return 0;
-
-unlink:
-	hidp_del_timer(session);
-
-	if (session->input) {
-		input_unregister_device(session->input);
-		session->input = NULL;
-	}
-
-	if (session->hid) {
-		hid_destroy_device(session->hid);
-		session->hid = NULL;
-	}
-
-	kfree(session->rd_data);
-	session->rd_data = NULL;
-
-purge:
-	list_del(&session->list);
-
-	skb_queue_purge(&session->ctrl_transmit);
-	skb_queue_purge(&session->intr_transmit);
-
-failed:
-	up_write(&hidp_session_sem);
-
-	kfree(session);
-	return err;
-}
-
-int hidp_del_connection(struct hidp_conndel_req *req)
-{
-	struct hidp_session *session;
-	int err = 0;
-
-	BT_DBG("");
-
-	down_read(&hidp_session_sem);
-
-	session = __hidp_get_session(&req->bdaddr);
-	if (session) {
-		if (req->flags & (1 << HIDP_VIRTUAL_CABLE_UNPLUG)) {
-			hidp_send_ctrl_message(session,
-				HIDP_TRANS_HID_CONTROL | HIDP_CTRL_VIRTUAL_CABLE_UNPLUG, NULL, 0);
-		} else {
-			/* Flush the transmit queues */
-			skb_queue_purge(&session->ctrl_transmit);
-			skb_queue_purge(&session->intr_transmit);
-
-			atomic_inc(&session->terminate);
-			wake_up_process(session->task);
-		}
-	} else
-		err = -ENOENT;
-
-	up_read(&hidp_session_sem);
-	return err;
-}
-
 int hidp_get_connlist(struct hidp_connlist_req *req)
 {
 	struct hidp_session *session;
@@ -1703,7 +1392,7 @@ int hidp_get_connlist(struct hidp_connlist_req *req)
 	list_for_each_entry(session, &hidp_session_list, list) {
 		struct hidp_conninfo ci;
 
-		__hidp_copy_session(session, &ci);
+		hidp_copy_session(session, &ci);
 
 		if (copy_to_user(req->ci, &ci, sizeof(ci))) {
 			err = -EFAULT;
@@ -1724,18 +1413,14 @@ int hidp_get_connlist(struct hidp_connlist_req *req)
 int hidp_get_conninfo(struct hidp_conninfo *ci)
 {
 	struct hidp_session *session;
-	int err = 0;
 
-	down_read(&hidp_session_sem);
-
-	session = __hidp_get_session(&ci->bdaddr);
-	if (session)
-		__hidp_copy_session(session, ci);
-	else
-		err = -ENOENT;
+	session = hidp_session_find(&ci->bdaddr);
+	if (session) {
+		hidp_copy_session(session, ci);
+		hidp_session_put(session);
+	}
 
-	up_read(&hidp_session_sem);
-	return err;
+	return session ? 0 : -ENOENT;
 }
 
 static int __init hidp_init(void)
diff --git a/net/bluetooth/hidp/hidp.h b/net/bluetooth/hidp/hidp.h
index c4fb980..6162ce8 100644
--- a/net/bluetooth/hidp/hidp.h
+++ b/net/bluetooth/hidp/hidp.h
@@ -123,8 +123,6 @@ struct hidp_connlist_req {
 
 int hidp_connection_add(struct hidp_connadd_req *req, struct socket *ctrl_sock, struct socket *intr_sock);
 int hidp_connection_del(struct hidp_conndel_req *req);
-int hidp_add_connection(struct hidp_connadd_req *req, struct socket *ctrl_sock, struct socket *intr_sock);
-int hidp_del_connection(struct hidp_conndel_req *req);
 int hidp_get_connlist(struct hidp_connlist_req *req);
 int hidp_get_conninfo(struct hidp_conninfo *ci);
 
@@ -147,7 +145,6 @@ struct hidp_session {
 
 	/* connection management */
 	bdaddr_t bdaddr;
-	struct hci_conn *hconn;
 	struct l2cap_conn *conn;
 	struct l2cap_user user;
 	struct socket *ctrl_sock;
@@ -180,9 +177,6 @@ struct hidp_session {
 
 	/* Used in hidp_output_raw_report() */
 	int output_report_success; /* boolean */
-
-	wait_queue_head_t startup_queue;
-	int waiting_for_startup;
 };
 
 /* HIDP init defines */
diff --git a/net/bluetooth/hidp/sock.c b/net/bluetooth/hidp/sock.c
index e6bf36a..2f4cbb0 100644
--- a/net/bluetooth/hidp/sock.c
+++ b/net/bluetooth/hidp/sock.c
@@ -77,21 +77,12 @@ static int hidp_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long
 			return err;
 		}
 
-		if (csock->sk->sk_state != BT_CONNECTED ||
-				isock->sk->sk_state != BT_CONNECTED) {
-			sockfd_put(csock);
-			sockfd_put(isock);
-			return -EBADFD;
-		}
+		err = hidp_connection_add(&ca, csock, isock);
+		if (!err && copy_to_user(argp, &ca, sizeof(ca)))
+			err = -EFAULT;
 
-		err = hidp_add_connection(&ca, csock, isock);
-		if (!err) {
-			if (copy_to_user(argp, &ca, sizeof(ca)))
-				err = -EFAULT;
-		} else {
-			sockfd_put(csock);
-			sockfd_put(isock);
-		}
+		sockfd_put(csock);
+		sockfd_put(isock);
 
 		return err;
 
@@ -102,7 +93,7 @@ static int hidp_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long
 		if (copy_from_user(&cd, argp, sizeof(cd)))
 			return -EFAULT;
 
-		return hidp_del_connection(&cd);
+		return hidp_connection_del(&cd);
 
 	case HIDPGETCONNLIST:
 		if (copy_from_user(&cl, argp, sizeof(cl)))
-- 
1.8.2

