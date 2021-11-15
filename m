Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2244C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Nov 2021 06:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A807963218
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Nov 2021 06:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbhKOGrS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Nov 2021 01:47:18 -0500
Received: from mga02.intel.com ([134.134.136.20]:7198 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230166AbhKOGq4 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Nov 2021 01:46:56 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10168"; a="220598251"
X-IronPort-AV: E=Sophos;i="5.87,235,1631602800"; 
   d="scan'208";a="220598251"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2021 22:43:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,235,1631602800"; 
   d="scan'208";a="453725993"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orsmga003.jf.intel.com with ESMTP; 14 Nov 2021 22:43:56 -0800
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        luiz.von.dentz@intel.com, Kiran K <kiran.k@intel.com>
Subject: [PATCH v3 10/13] Bluetooth: Handle MSFT avdtp open event
Date:   Mon, 15 Nov 2021 12:19:11 +0530
Message-Id: <20211115064914.2345-10-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211115064914.2345-1-kiran.k@intel.com>
References: <20211115064914.2345-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On receiving MSFT avdtp open event, cache avdtp handle and
signal the task waiting on avdtp handle.

Signed-off-by: Kiran K <kiran.k@intel.com>
Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
---
 include/net/bluetooth/bluetooth.h |  3 +++
 include/net/bluetooth/hci.h       |  1 +
 include/net/bluetooth/l2cap.h     |  4 ++++
 net/bluetooth/af_bluetooth.c      | 36 +++++++++++++++++++++++++++++++
 net/bluetooth/hci_codec.c         |  6 ++++--
 net/bluetooth/hci_codec.h         |  2 +-
 net/bluetooth/hci_event.c         |  5 +++++
 net/bluetooth/l2cap_core.c        | 15 +++++++++++++
 net/bluetooth/l2cap_sock.c        | 17 ++++++++++++++-
 9 files changed, 85 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 5e07cfed941d..230fe8cbc1df 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -317,6 +317,7 @@ struct bt_sock {
 	struct list_head accept_q;
 	struct sock *parent;
 	unsigned long flags;
+	u16 avdtp_handle;
 	void (*skb_msg_name)(struct sk_buff *, void *, int *);
 	void (*skb_put_cmsg)(struct sk_buff *, struct msghdr *, struct sock *);
 };
@@ -324,6 +325,7 @@ struct bt_sock {
 enum {
 	BT_SK_DEFER_SETUP,
 	BT_SK_SUSPEND,
+	BT_SK_AVDTP_PEND,
 };
 
 struct bt_sock_list {
@@ -346,6 +348,7 @@ __poll_t bt_sock_poll(struct file *file, struct socket *sock, poll_table *wait);
 int  bt_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg);
 int  bt_sock_wait_state(struct sock *sk, int state, unsigned long timeo);
 int  bt_sock_wait_ready(struct sock *sk, unsigned long flags);
+int bt_sock_wait_for_avdtp_hndl(struct sock *sk, unsigned long timeo);
 
 void bt_accept_enqueue(struct sock *parent, struct sock *sk, bool bh);
 void bt_accept_unlink(struct sock *sk);
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index dc863d055056..5dd5b63f4154 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -347,6 +347,7 @@ enum {
 #define HCI_POWER_OFF_TIMEOUT	msecs_to_jiffies(5000)	/* 5 seconds */
 #define HCI_LE_CONN_TIMEOUT	msecs_to_jiffies(20000)	/* 20 seconds */
 #define HCI_LE_AUTOCONN_TIMEOUT	msecs_to_jiffies(4000)	/* 4 seconds */
+#define MSFT_AVDTP_TIMEOUT      msecs_to_jiffies(500) /* 0.5 seconds */
 
 /* HCI data types */
 #define HCI_COMMAND_PKT		0x01
diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 3c4f550e5a8b..62705273d2eb 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -669,6 +669,8 @@ struct l2cap_ops {
 					       unsigned long len, int nb);
 	int			(*filter) (struct l2cap_chan * chan,
 					   struct sk_buff *skb);
+	void			(*avdtp_wakeup) (struct l2cap_chan *chan,
+						 u8 status, u16 handle);
 };
 
 struct l2cap_conn {
@@ -1001,6 +1003,8 @@ void __l2cap_physical_cfm(struct l2cap_chan *chan, int result);
 
 struct l2cap_conn *l2cap_conn_get(struct l2cap_conn *conn);
 void l2cap_conn_put(struct l2cap_conn *conn);
+void l2cap_avdtp_wakeup(struct l2cap_conn *conn, u16 dcid, u8 status,
+			u16 handle);
 
 int l2cap_register_user(struct l2cap_conn *conn, struct l2cap_user *user);
 void l2cap_unregister_user(struct l2cap_conn *conn, struct l2cap_user *user);
diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 1661979b6a6e..62bfd88d05b2 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -607,6 +607,42 @@ int bt_sock_wait_ready(struct sock *sk, unsigned long flags)
 }
 EXPORT_SYMBOL(bt_sock_wait_ready);
 
+/* This function expects the sk lock to be held when called */
+int bt_sock_wait_for_avdtp_hndl(struct sock *sk, unsigned long timeo)
+{
+	DECLARE_WAITQUEUE(wait, current);
+	int err = 0;
+
+	BT_DBG("sk %p", sk);
+
+	add_wait_queue(sk_sleep(sk), &wait);
+	set_current_state(TASK_INTERRUPTIBLE);
+	while (test_bit(BT_SK_AVDTP_PEND, &bt_sk(sk)->flags)) {
+		if (!timeo) {
+			err = -EINPROGRESS;
+			break;
+		}
+
+		if (signal_pending(current)) {
+			err = sock_intr_errno(timeo);
+			break;
+		}
+
+		release_sock(sk);
+		timeo = schedule_timeout(timeo);
+		lock_sock(sk);
+		set_current_state(TASK_INTERRUPTIBLE);
+
+		err = sock_error(sk);
+		if (err)
+			break;
+	}
+	__set_current_state(TASK_RUNNING);
+	remove_wait_queue(sk_sleep(sk), &wait);
+	return err;
+}
+EXPORT_SYMBOL(bt_sock_wait_for_avdtp_hndl);
+
 #ifdef CONFIG_PROC_FS
 static void *bt_seq_start(struct seq_file *seq, loff_t *pos)
 	__acquires(seq->private->l->lock)
diff --git a/net/bluetooth/hci_codec.c b/net/bluetooth/hci_codec.c
index e179f3bfb494..0a29dd39dda3 100644
--- a/net/bluetooth/hci_codec.c
+++ b/net/bluetooth/hci_codec.c
@@ -357,7 +357,7 @@ int hci_get_supported_codecs(struct hci_dev *hdev, u8 type, char __user *optval,
 }
 
 int hci_configure_msft_avdtp_open(struct hci_dev *hdev, struct l2cap_chan *chan,
-				  sockptr_t optval, int optlen)
+				 sockptr_t optval, int optlen, struct sock *sk)
 {
 	struct msft_cp_avdtp_open *cmd = NULL;
 	struct hci_media_service_caps *caps;
@@ -392,7 +392,9 @@ int hci_configure_msft_avdtp_open(struct hci_dev *hdev, struct l2cap_chan *chan,
 
 	hci_send_cmd(hdev, HCI_MSFT_AVDTP_CMD, sizeof(*cmd) + optlen, cmd);
 
-	/* wait until we get avdtp handle or timeout */
+	set_bit(BT_SK_AVDTP_PEND, &bt_sk(sk)->flags);
+
+	err = bt_sock_wait_for_avdtp_hndl(sk, MSFT_AVDTP_TIMEOUT);
 
 fail:
 	kfree(cmd);
diff --git a/net/bluetooth/hci_codec.h b/net/bluetooth/hci_codec.h
index 123b46a6a8ce..121f262e5924 100644
--- a/net/bluetooth/hci_codec.h
+++ b/net/bluetooth/hci_codec.h
@@ -10,4 +10,4 @@ void hci_codec_list_clear(struct list_head *codec_list);
 int hci_get_supported_codecs(struct hci_dev *hdev, u8 type, char __user *optval,
 			     int __user *optlen, int len);
 int hci_configure_msft_avdtp_open(struct hci_dev *hdev, struct l2cap_chan *chan,
-				  sockptr_t optval, int optlen);
+				  sockptr_t optval, int optlen, struct sock *sk);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index b7ef4e8dae6c..bbf90fc33156 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1450,6 +1450,7 @@ static void hci_cc_msft_avdtp_open(struct hci_dev *hdev, struct sk_buff *skb)
 	struct msft_rp_avdtp_open *rp;
 	struct msft_cp_avdtp_open *sent;
 	struct hci_conn *hconn;
+	struct l2cap_conn *conn;
 
 	if (skb->len < sizeof(*rp))
 		return;
@@ -1463,7 +1464,11 @@ static void hci_cc_msft_avdtp_open(struct hci_dev *hdev, struct sk_buff *skb)
 	if (!hconn)
 		return;
 
+	conn = hconn->l2cap_data;
+
 	/* wake up the task waiting on avdtp handle */
+	l2cap_avdtp_wakeup(conn, sent->dcid, rp->status,
+			   rp->status ? 0 : __le16_to_cpu(rp->avdtp_handle));
 }
 
 static void hci_cc_msft_avdtp_cmd(struct hci_dev *hdev, struct sk_buff *skb)
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 4f8f37599962..32b69c9432aa 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -8507,6 +8507,21 @@ int __init l2cap_init(void)
 	return 0;
 }
 
+void l2cap_avdtp_wakeup(struct l2cap_conn *conn, u16 cid, u8 status,
+			u16 handle)
+{
+	struct l2cap_chan *chan;
+
+	chan = l2cap_get_chan_by_dcid(conn, cid);
+
+	if (!chan)
+		return;
+
+	chan->ops->avdtp_wakeup(chan, status, handle);
+
+	l2cap_chan_unlock(chan);
+}
+
 void l2cap_exit(void)
 {
 	debugfs_remove(l2cap_debugfs);
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index fa689e576576..c68093c23c9f 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1157,7 +1157,8 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		err = hci_configure_msft_avdtp_open(hdev, chan, optval, optlen);
+		err = hci_configure_msft_avdtp_open(hdev, chan, optval,
+						    optlen, sk);
 		hci_dev_put(hdev);
 		break;
 
@@ -1748,6 +1749,19 @@ static int l2cap_sock_filter(struct l2cap_chan *chan, struct sk_buff *skb)
 	return 0;
 }
 
+static void l2cap_sock_avdtp_wakeup(struct l2cap_chan *chan, u8 status,
+				    u16 handle)
+{
+	struct sock *sk = chan->data;
+
+	if (test_bit(BT_SK_AVDTP_PEND, &bt_sk(sk)->flags)) {
+		bt_sk(sk)->avdtp_handle = handle;
+		sk->sk_err = -bt_to_errno(status);
+		clear_bit(BT_SK_AVDTP_PEND, &bt_sk(sk)->flags);
+		sk->sk_state_change(sk);
+	}
+}
+
 static const struct l2cap_ops l2cap_chan_ops = {
 	.name			= "L2CAP Socket Interface",
 	.new_connection		= l2cap_sock_new_connection_cb,
@@ -1764,6 +1778,7 @@ static const struct l2cap_ops l2cap_chan_ops = {
 	.get_peer_pid		= l2cap_sock_get_peer_pid_cb,
 	.alloc_skb		= l2cap_sock_alloc_skb_cb,
 	.filter			= l2cap_sock_filter,
+	.avdtp_wakeup		= l2cap_sock_avdtp_wakeup,
 };
 
 static void l2cap_sock_destruct(struct sock *sk)
-- 
2.17.1

