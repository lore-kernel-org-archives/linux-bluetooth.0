Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH v3 12/18] Bluetooth: hidp: add new session-management helpers
Date: Fri,  5 Apr 2013 14:57:44 +0200
Message-Id: <1365166670-3271-13-git-send-email-dh.herrmann@gmail.com>
In-Reply-To: <1365166670-3271-1-git-send-email-dh.herrmann@gmail.com>
References: <1365166670-3271-1-git-send-email-dh.herrmann@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This is a rewrite of the HIDP session management. It implements HIDP as an
l2cap_user sub-module so we get proper notification when the underlying
connection goes away.

The helpers are not yet used but only added in this commit. The old
session management is still used and will be removed in a following patch.

The old session-management was flawed. Hotplugging is horribly broken and
we have no way of getting notified when the underlying connection goes
down. The whole idea of removing the HID/input sub-devices from within the
session itself is broken and suffers from major dead-locks. We never can
guarantee that the session can unregister itself as long as we use
synchronous shutdowns. This can only work with asynchronous shutdowns.
However, in this case we _must_ be able to unregister the session from the
outside as otherwise the l2cap_conn object might be unlinked before we
are.

The new session-management is based on l2cap_user. There is only one
way how to add a session and how to delete a session: "probe" and "remove"
callbacks from l2cap_user.
This guarantees that the session can be registered and unregistered at
_any_ time without any synchronous shutdown.
On the other hand, much work has been put into proper session-refcounting.
We can unregister/unlink the session only if we can guarantee that it will
stay alive. But for asynchronous shutdowns we never know when the last
user goes away so we must use proper ref-counting.

The old ->conn field has been renamed to ->hconn so we can reuse ->conn in
the new session management. No other existing HIDP code is modified.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 net/bluetooth/hidp/core.c | 555 +++++++++++++++++++++++++++++++++++++++++++++-
 net/bluetooth/hidp/hidp.h |  53 +++--
 2 files changed, 583 insertions(+), 25 deletions(-)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index a16474a..43131d2 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -1,6 +1,7 @@
 /*
    HIDP implementation for Linux Bluetooth stack (BlueZ).
    Copyright (C) 2003-2004 Marcel Holtmann <marcel@holtmann.org>
+   Copyright (C) 2013 David Herrmann <dh.herrmann@gmail.com>
 
    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License version 2 as
@@ -20,6 +21,7 @@
    SOFTWARE IS DISCLAIMED.
 */
 
+#include <linux/kref.h>
 #include <linux/module.h>
 #include <linux/file.h>
 #include <linux/kthread.h>
@@ -59,6 +61,13 @@ static unsigned char hidp_keycode[256] = {
 
 static unsigned char hidp_mkeyspat[] = { 0x01, 0x01, 0x01, 0x01, 0x01, 0x01 };
 
+static int hidp_session_probe(struct l2cap_conn *conn,
+			      struct l2cap_user *user);
+static void hidp_session_remove(struct l2cap_conn *conn,
+				struct l2cap_user *user);
+static int hidp_session_thread(void *arg);
+static void hidp_session_terminate(struct hidp_session *s);
+
 static inline void hidp_schedule(struct hidp_session *session)
 {
 	struct sock *ctrl_sk = session->ctrl_sock->sk;
@@ -834,7 +843,7 @@ static int hidp_setup_input(struct hidp_session *session,
 		input->relbit[0] |= BIT_MASK(REL_WHEEL);
 	}
 
-	input->dev.parent = &session->conn->dev;
+	input->dev.parent = &session->hconn->dev;
 
 	input->event = hidp_input_event;
 
@@ -938,7 +947,7 @@ static int hidp_setup_hid(struct hidp_session *session,
 	snprintf(hid->uniq, sizeof(hid->uniq), "%pMR",
 		 &bt_sk(session->ctrl_sock->sk)->dst);
 
-	hid->dev.parent = &session->conn->dev;
+	hid->dev.parent = &session->hconn->dev;
 	hid->ll_driver = &hidp_hid_driver;
 
 	hid->hid_get_raw_report = hidp_get_raw_report;
@@ -960,6 +969,543 @@ fault:
 	return err;
 }
 
+/* initialize session devices */
+static int hidp_session_dev_init(struct hidp_session *session,
+				 struct hidp_connadd_req *req)
+{
+	int ret;
+
+	if (req->rd_size > 0) {
+		ret = hidp_setup_hid(session, req);
+		if (ret && ret != -ENODEV)
+			return ret;
+	}
+
+	if (!session->hid) {
+		ret = hidp_setup_input(session, req);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
+/* destroy session devices */
+static void hidp_session_dev_destroy(struct hidp_session *session)
+{
+	if (session->hid)
+		put_device(&session->hid->dev);
+	else if (session->input)
+		input_put_device(session->input);
+
+	kfree(session->rd_data);
+	session->rd_data = NULL;
+}
+
+/* add HID/input devices to their underlying bus systems */
+static int hidp_session_dev_add(struct hidp_session *session)
+{
+	int ret;
+
+	/* Both HID and input systems drop a ref-count when unregistering the
+	 * device but they don't take a ref-count when registering them. Work
+	 * around this by explicitly taking a refcount during registration
+	 * which is dropped automatically by unregistering the devices. */
+
+	if (session->hid) {
+		ret = hid_add_device(session->hid);
+		if (ret)
+			return ret;
+		get_device(&session->hid->dev);
+	} else if (session->input) {
+		ret = input_register_device(session->input);
+		if (ret)
+			return ret;
+		input_get_device(session->input);
+	}
+
+	return 0;
+}
+
+/* remove HID/input devices from their bus systems */
+static void hidp_session_dev_del(struct hidp_session *session)
+{
+	if (session->hid)
+		hid_destroy_device(session->hid);
+	else if (session->input)
+		input_unregister_device(session->input);
+}
+
+/*
+ * Create new session object
+ * Allocate session object, initialize static fields, copy input data into the
+ * object and take a reference to all sub-objects.
+ * This returns 0 on success and puts a pointer to the new session object in
+ * \out. Otherwise, an error code is returned.
+ * The new session object has an initial ref-count of 1.
+ */
+static int hidp_session_new(struct hidp_session **out, const bdaddr_t *bdaddr,
+			    struct socket *ctrl_sock,
+			    struct socket *intr_sock,
+			    struct hidp_connadd_req *req,
+			    struct l2cap_conn *conn)
+{
+	struct hidp_session *session;
+	int ret;
+	struct bt_sock *ctrl, *intr;
+
+	ctrl = bt_sk(ctrl_sock->sk);
+	intr = bt_sk(intr_sock->sk);
+
+	session = kzalloc(sizeof(*session), GFP_KERNEL);
+	if (!session)
+		return -ENOMEM;
+
+	/* object and runtime management */
+	kref_init(&session->ref);
+	atomic_set(&session->state, HIDP_SESSION_IDLING);
+	init_waitqueue_head(&session->state_queue);
+	session->flags = req->flags & (1 << HIDP_BLUETOOTH_VENDOR_ID);
+
+	/* connection management */
+	bacpy(&session->bdaddr, bdaddr);
+	session->conn = conn;
+	session->user.probe = hidp_session_probe;
+	session->user.remove = hidp_session_remove;
+	session->ctrl_sock = ctrl_sock;
+	session->intr_sock = intr_sock;
+	skb_queue_head_init(&session->ctrl_transmit);
+	skb_queue_head_init(&session->intr_transmit);
+	session->ctrl_mtu = min_t(uint, l2cap_pi(ctrl)->chan->omtu,
+					l2cap_pi(ctrl)->chan->imtu);
+	session->intr_mtu = min_t(uint, l2cap_pi(intr)->chan->omtu,
+					l2cap_pi(intr)->chan->imtu);
+	session->idle_to = req->idle_to;
+
+	/* device management */
+	setup_timer(&session->timer, hidp_idle_timeout,
+		    (unsigned long)session);
+
+	/* session data */
+	mutex_init(&session->report_mutex);
+	init_waitqueue_head(&session->report_queue);
+
+	ret = hidp_session_dev_init(session, req);
+	if (ret)
+		goto err_free;
+
+	l2cap_conn_get(session->conn);
+	get_file(session->intr_sock->file);
+	get_file(session->ctrl_sock->file);
+	*out = session;
+	return 0;
+
+err_free:
+	kfree(session);
+	return ret;
+}
+
+/* increase ref-count of the given session by one */
+static void hidp_session_get(struct hidp_session *session)
+{
+	kref_get(&session->ref);
+}
+
+/* release callback */
+static void session_free(struct kref *ref)
+{
+	struct hidp_session *session = container_of(ref, struct hidp_session,
+						    ref);
+
+	hidp_session_dev_destroy(session);
+	skb_queue_purge(&session->ctrl_transmit);
+	skb_queue_purge(&session->intr_transmit);
+	fput(session->intr_sock->file);
+	fput(session->ctrl_sock->file);
+	l2cap_conn_put(session->conn);
+	kfree(session);
+}
+
+/* decrease ref-count of the given session by one */
+static void hidp_session_put(struct hidp_session *session)
+{
+	kref_put(&session->ref, session_free);
+}
+
+/*
+ * Search the list of active sessions for a session with target address
+ * \bdaddr. You must hold at least a read-lock on \hidp_session_sem. As long as
+ * you do not release this lock, the session objects cannot vanish and you can
+ * safely take a reference to the session yourself.
+ */
+static struct hidp_session *__hidp_session_find(const bdaddr_t *bdaddr)
+{
+	struct hidp_session *session;
+
+	list_for_each_entry(session, &hidp_session_list, list) {
+		if (!bacmp(bdaddr, &session->bdaddr))
+			return session;
+	}
+
+	return NULL;
+}
+
+/*
+ * Same as __hidp_session_find() but no locks must be held. This also takes a
+ * reference of the returned session (if non-NULL) so you must drop this
+ * reference if you no longer use the object.
+ */
+static struct hidp_session *hidp_session_find(const bdaddr_t *bdaddr)
+{
+	struct hidp_session *session;
+
+	down_read(&hidp_session_sem);
+
+	session = __hidp_session_find(bdaddr);
+	if (session)
+		hidp_session_get(session);
+
+	up_read(&hidp_session_sem);
+
+	return session;
+}
+
+/*
+ * Start session synchronously
+ * This starts a session thread and waits until initialization
+ * is done or returns an error if it couldn't be started.
+ * If this returns 0 the session thread is up and running. You must call
+ * hipd_session_stop_sync() before deleting any runtime resources.
+ */
+static int hidp_session_start_sync(struct hidp_session *session)
+{
+	unsigned int vendor, product;
+
+	if (session->hid) {
+		vendor  = session->hid->vendor;
+		product = session->hid->product;
+	} else if (session->input) {
+		vendor  = session->input->id.vendor;
+		product = session->input->id.product;
+	} else {
+		vendor = 0x0000;
+		product = 0x0000;
+	}
+
+	session->task = kthread_run(hidp_session_thread, session,
+				    "khidpd_%04x%04x", vendor, product);
+	if (IS_ERR(session->task))
+		return PTR_ERR(session->task);
+
+	while (atomic_read(&session->state) <= HIDP_SESSION_IDLING)
+		wait_event(session->state_queue,
+			   atomic_read(&session->state) > HIDP_SESSION_IDLING);
+
+	return 0;
+}
+
+/*
+ * Terminate session thread
+ * Wake up session thread and notify it to stop. This is asynchronous and
+ * returns immediately. Call this whenever a runtime error occurs and you want
+ * the session to stop.
+ * Note: wake_up_process() performs any necessary memory-barriers for us.
+ */
+static void hidp_session_terminate(struct hidp_session *session)
+{
+	atomic_inc(&session->terminate);
+	wake_up_process(session->task);
+}
+
+/*
+ * Probe HIDP session
+ * This is called from the l2cap_conn core when our l2cap_user object is bound
+ * to the hci-connection. We get the session via the \user object and can now
+ * start the session thread, register the HID/input devices and link it into
+ * the global session list.
+ * The global session-list owns its own reference to the session object so you
+ * can drop your own reference after registering the l2cap_user object.
+ */
+static int hidp_session_probe(struct l2cap_conn *conn,
+			      struct l2cap_user *user)
+{
+	struct hidp_session *session = container_of(user,
+						    struct hidp_session,
+						    user);
+	struct hidp_session *s;
+	int ret;
+
+	down_write(&hidp_session_sem);
+
+	/* check that no other session for this device exists */
+	s = __hidp_session_find(&session->bdaddr);
+	if (s) {
+		ret = -EEXIST;
+		goto out_unlock;
+	}
+
+	ret = hidp_session_start_sync(session);
+	if (ret)
+		goto out_unlock;
+
+	ret = hidp_session_dev_add(session);
+	if (ret)
+		goto out_stop;
+
+	hidp_session_get(session);
+	list_add(&session->list, &hidp_session_list);
+	ret = 0;
+	goto out_unlock;
+
+out_stop:
+	hidp_session_terminate(session);
+out_unlock:
+	up_write(&hidp_session_sem);
+	return ret;
+}
+
+/*
+ * Remove HIDP session
+ * Called from the l2cap_conn core when either we explicitly unregistered
+ * the l2cap_user object or if the underlying connection is shut down.
+ * We signal the hidp-session thread to shut down, unregister the HID/input
+ * devices and unlink the session from the global list.
+ * This drops the reference to the session that is owned by the global
+ * session-list.
+ * Note: We _must_ not synchronosly wait for the session-thread to shut down.
+ * This is, because the session-thread might be waiting for an HCI lock that is
+ * held while we are called. Therefore, we only unregister the devices and
+ * notify the session-thread to terminate. The thread itself owns a reference
+ * to the session object so it can safely shut down.
+ */
+static void hidp_session_remove(struct l2cap_conn *conn,
+				struct l2cap_user *user)
+{
+	struct hidp_session *session = container_of(user,
+						    struct hidp_session,
+						    user);
+
+	down_write(&hidp_session_sem);
+
+	hidp_session_terminate(session);
+	hidp_session_dev_del(session);
+	list_del(&session->list);
+
+	up_write(&hidp_session_sem);
+
+	hidp_session_put(session);
+}
+
+/*
+ * Session Worker
+ * This performs the actual main-loop of the HIDP worker. We first check
+ * whether the underlying connection is still alive, then parse all pending
+ * messages and finally send all outstanding messages.
+ */
+static void hidp_session_run(struct hidp_session *session)
+{
+	struct sock *ctrl_sk = session->ctrl_sock->sk;
+	struct sock *intr_sk = session->intr_sock->sk;
+	struct sk_buff *skb;
+
+	for (;;) {
+		/*
+		 * This thread can be woken up two ways:
+		 *  - You call hidp_session_terminate() which sets the
+		 *    session->terminate flag and wakes this thread up.
+		 *  - Via modifying the socket state of ctrl/intr_sock. This
+		 *    thread is woken up by ->sk_state_changed().
+		 *
+		 * Note: set_current_state() performs any necessary
+		 * memory-barriers for us.
+		 */
+		set_current_state(TASK_INTERRUPTIBLE);
+
+		if (atomic_read(&session->terminate))
+			break;
+
+		if (ctrl_sk->sk_state != BT_CONNECTED ||
+		    intr_sk->sk_state != BT_CONNECTED)
+			break;
+
+		/* parse incoming intr-skbs */
+		while ((skb = skb_dequeue(&intr_sk->sk_receive_queue))) {
+			skb_orphan(skb);
+			if (!skb_linearize(skb))
+				hidp_recv_intr_frame(session, skb);
+			else
+				kfree_skb(skb);
+		}
+
+		/* send pending intr-skbs */
+		hidp_process_intr_transmit(session);
+
+		/* parse incoming ctrl-skbs */
+		while ((skb = skb_dequeue(&ctrl_sk->sk_receive_queue))) {
+			skb_orphan(skb);
+			if (!skb_linearize(skb))
+				hidp_recv_ctrl_frame(session, skb);
+			else
+				kfree_skb(skb);
+		}
+
+		/* send pending ctrl-skbs */
+		hidp_process_ctrl_transmit(session);
+
+		schedule();
+	}
+
+	atomic_inc(&session->terminate);
+	set_current_state(TASK_RUNNING);
+}
+
+/*
+ * HIDP session thread
+ * This thread runs the I/O for a single HIDP session. Startup is synchronous
+ * which allows us to take references to ourself here instead of doing that in
+ * the caller.
+ * When we are ready to run we notify the caller and call hidp_session_run().
+ */
+static int hidp_session_thread(void *arg)
+{
+	struct hidp_session *session = arg;
+	wait_queue_t ctrl_wait, intr_wait;
+
+	BT_DBG("session %p", session);
+
+	/* initialize runtime environment */
+	hidp_session_get(session);
+	__module_get(THIS_MODULE);
+	set_user_nice(current, -15);
+	hidp_set_timer(session);
+
+	init_waitqueue_entry(&ctrl_wait, current);
+	init_waitqueue_entry(&intr_wait, current);
+	add_wait_queue(sk_sleep(session->ctrl_sock->sk), &ctrl_wait);
+	add_wait_queue(sk_sleep(session->intr_sock->sk), &intr_wait);
+	/* This memory barrier is paired with wq_has_sleeper(). See
+	 * sock_poll_wait() for more information why this is needed. */
+	smp_mb();
+
+	/* notify synchronous startup that we're ready */
+	atomic_inc(&session->state);
+	wake_up(&session->state_queue);
+
+	/* run session */
+	hidp_session_run(session);
+
+	/* cleanup runtime environment */
+	remove_wait_queue(sk_sleep(session->intr_sock->sk), &intr_wait);
+	remove_wait_queue(sk_sleep(session->intr_sock->sk), &ctrl_wait);
+	wake_up_interruptible(&session->report_queue);
+	hidp_del_timer(session);
+
+	/*
+	 * If we stopped ourself due to any internal signal, we should try to
+	 * unregister our own session here to avoid having it linger until the
+	 * parent l2cap_conn dies or user-space cleans it up.
+	 * This does not deadlock as we don't do any synchronous shutdown.
+	 * Instead, this call has the same semantics as if user-space tried to
+	 * delete the session.
+	 */
+	l2cap_unregister_user(session->conn, &session->user);
+	hidp_session_put(session);
+
+	module_put_and_exit(0);
+	return 0;
+}
+
+static int hidp_verify_sockets(struct socket *ctrl_sock,
+			       struct socket *intr_sock)
+{
+	struct bt_sock *ctrl, *intr;
+	struct hidp_session *session;
+
+	if (!l2cap_is_socket(ctrl_sock) || !l2cap_is_socket(intr_sock))
+		return -EINVAL;
+
+	ctrl = bt_sk(ctrl_sock->sk);
+	intr = bt_sk(intr_sock->sk);
+
+	if (bacmp(&ctrl->src, &intr->src) || bacmp(&ctrl->dst, &intr->dst))
+		return -ENOTUNIQ;
+	if (ctrl->sk.sk_state != BT_CONNECTED ||
+	    intr->sk.sk_state != BT_CONNECTED)
+		return -EBADFD;
+
+	/* early session check, we check again during session registration */
+	session = hidp_session_find(&ctrl->dst);
+	if (session) {
+		hidp_session_put(session);
+		return -EEXIST;
+	}
+
+	return 0;
+}
+
+int hidp_connection_add(struct hidp_connadd_req *req,
+			struct socket *ctrl_sock,
+			struct socket *intr_sock)
+{
+	struct hidp_session *session;
+	struct l2cap_conn *conn;
+	struct l2cap_chan *chan = l2cap_pi(ctrl_sock->sk)->chan;
+	int ret;
+
+	ret = hidp_verify_sockets(ctrl_sock, intr_sock);
+	if (ret)
+		return ret;
+
+	conn = NULL;
+	l2cap_chan_lock(chan);
+	if (chan->conn) {
+		l2cap_conn_get(chan->conn);
+		conn = chan->conn;
+	}
+	l2cap_chan_unlock(chan);
+
+	if (!conn)
+		return -EBADFD;
+
+	ret = hidp_session_new(&session, &bt_sk(ctrl_sock->sk)->dst, ctrl_sock,
+			       intr_sock, req, conn);
+	if (ret)
+		goto out_conn;
+
+	ret = l2cap_register_user(conn, &session->user);
+	if (ret)
+		goto out_session;
+
+	ret = 0;
+
+out_session:
+	hidp_session_put(session);
+out_conn:
+	l2cap_conn_put(conn);
+	return ret;
+}
+
+int hidp_connection_del(struct hidp_conndel_req *req)
+{
+	struct hidp_session *session;
+
+	session = hidp_session_find(&req->bdaddr);
+	if (!session)
+		return -ENOENT;
+
+	if (req->flags & (1 << HIDP_VIRTUAL_CABLE_UNPLUG))
+		hidp_send_ctrl_message(session,
+				       HIDP_TRANS_HID_CONTROL |
+				         HIDP_CTRL_VIRTUAL_CABLE_UNPLUG,
+				       NULL, 0);
+	else
+		l2cap_unregister_user(session->conn, &session->user);
+
+	hidp_session_put(session);
+
+	return 0;
+}
+
 int hidp_add_connection(struct hidp_connadd_req *req, struct socket *ctrl_sock, struct socket *intr_sock)
 {
 	struct hidp_session *session, *s;
@@ -1002,8 +1548,8 @@ int hidp_add_connection(struct hidp_connadd_req *req, struct socket *ctrl_sock,
 	session->ctrl_sock = ctrl_sock;
 	session->intr_sock = intr_sock;
 
-	session->conn = hidp_get_connection(session);
-	if (!session->conn) {
+	session->hconn = hidp_get_connection(session);
+	if (!session->hconn) {
 		err = -ENOTCONN;
 		goto failed;
 	}
@@ -1204,6 +1750,7 @@ module_init(hidp_init);
 module_exit(hidp_exit);
 
 MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
+MODULE_AUTHOR("David Herrmann <dh.herrmann@gmail.com>");
 MODULE_DESCRIPTION("Bluetooth HIDP ver " VERSION);
 MODULE_VERSION(VERSION);
 MODULE_LICENSE("GPL");
diff --git a/net/bluetooth/hidp/hidp.h b/net/bluetooth/hidp/hidp.h
index c844420..c4fb980 100644
--- a/net/bluetooth/hidp/hidp.h
+++ b/net/bluetooth/hidp/hidp.h
@@ -24,7 +24,9 @@
 #define __HIDP_H
 
 #include <linux/types.h>
+#include <linux/kref.h>
 #include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/l2cap.h>
 
 /* HIDP header masks */
 #define HIDP_HEADER_TRANS_MASK			0xf0
@@ -119,42 +121,55 @@ struct hidp_connlist_req {
 	struct hidp_conninfo __user *ci;
 };
 
+int hidp_connection_add(struct hidp_connadd_req *req, struct socket *ctrl_sock, struct socket *intr_sock);
+int hidp_connection_del(struct hidp_conndel_req *req);
 int hidp_add_connection(struct hidp_connadd_req *req, struct socket *ctrl_sock, struct socket *intr_sock);
 int hidp_del_connection(struct hidp_conndel_req *req);
 int hidp_get_connlist(struct hidp_connlist_req *req);
 int hidp_get_conninfo(struct hidp_conninfo *ci);
 
+enum hidp_session_state {
+	HIDP_SESSION_IDLING,
+	HIDP_SESSION_RUNNING,
+};
+
 /* HIDP session defines */
 struct hidp_session {
 	struct list_head list;
+	struct kref ref;
 
-	struct hci_conn *conn;
+	/* runtime management */
+	atomic_t state;
+	wait_queue_head_t state_queue;
+	atomic_t terminate;
+	struct task_struct *task;
+	unsigned long flags;
 
+	/* connection management */
+	bdaddr_t bdaddr;
+	struct hci_conn *hconn;
+	struct l2cap_conn *conn;
+	struct l2cap_user user;
 	struct socket *ctrl_sock;
 	struct socket *intr_sock;
-
-	bdaddr_t bdaddr;
-
-	unsigned long flags;
-	unsigned long idle_to;
-
+	struct sk_buff_head ctrl_transmit;
+	struct sk_buff_head intr_transmit;
 	uint ctrl_mtu;
 	uint intr_mtu;
+	unsigned long idle_to;
 
-	atomic_t terminate;
-	struct task_struct *task;
-
-	unsigned char keys[8];
-	unsigned char leds;
-
+	/* device management */
 	struct input_dev *input;
-
 	struct hid_device *hid;
-
 	struct timer_list timer;
 
-	struct sk_buff_head ctrl_transmit;
-	struct sk_buff_head intr_transmit;
+	/* Report descriptor */
+	__u8 *rd_data;
+	uint rd_size;
+
+	/* session data */
+	unsigned char keys[8];
+	unsigned char leds;
 
 	/* Used in hidp_get_raw_report() */
 	int waiting_report_type; /* HIDP_DATA_RTYPE_* */
@@ -166,10 +181,6 @@ struct hidp_session {
 	/* Used in hidp_output_raw_report() */
 	int output_report_success; /* boolean */
 
-	/* Report descriptor */
-	__u8 *rd_data;
-	uint rd_size;
-
 	wait_queue_head_t startup_queue;
 	int waiting_for_startup;
 };
-- 
1.8.2
