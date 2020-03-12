Return-Path: <SRS0=41cZ=45=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7865BC2BB1D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Mar 2020 22:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4789F206CD
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Mar 2020 22:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VEkwMykM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgCLWZA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 Mar 2020 18:25:00 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34999 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbgCLWY7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 Mar 2020 18:24:59 -0400
Received: by mail-pf1-f193.google.com with SMTP id u68so3974802pfb.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Mar 2020 15:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=UfpKScryq+b+Dq0jYYgZlZOtV9tXDIHCtot1ZFAOB4k=;
        b=VEkwMykMtYGLrJgiVqC4TF/d8F3aGKZyqy2mO7ZNM+1K4Ybx65O5F1y9rPAijEvHdo
         43qX5jYkH52rJqr31+N6td11moCRq29SwjVUsDCM9J9ZKF8Wn/fi5HI5j83bvfCYw/xC
         oDbRGQRoKPlInHpR/rXZtgMfvmg3A7V2RMinQLYalpX7Afy15M5K3WBbUxTwe3nF4B8y
         18Qee7aW8O91aA+ZBRO+HeLwnKq431Lk5ZP1pFEamQFZs3vNLeGsh9nNmUm7DSupWCnI
         nVJDUUnlV8T9oXJ6wk/l0zWVoffaUn2pfW0XNoLhtmGjPj38aWBKRjiGk4SJN9oV4mcy
         hbIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UfpKScryq+b+Dq0jYYgZlZOtV9tXDIHCtot1ZFAOB4k=;
        b=kFw06axDvI5krdtmpC93Mzzx1HIjCCrOR4KNKaxlZPtXyU4yT8kpU74UUEVMmsWYKF
         Dv6Glfu5l45pm9h0xO76PqsWTNXRgGNb6gnCYRDcCYNJ1Vx2DdXfSOrguqomgaitiVjJ
         mBPZGsJxOoJ4oVtv6FdHvzovWZuaVKCK2ZVRCakcnh0Bjb7c5MCQM4O8BQwx4a8OKdP7
         l6N0yVB6YidxDBQRvLcDeKMotWZDwBd8+xI9UcVZNpLfb+OMCe7Xo5n0kZ03QqD/WS61
         7ktdUjARFSstXvwKU2Jze31uQ8kTeiV6vNmqjGvLibzsE53LCRVZiUPBeq/dUn0Ivxjc
         i4Hw==
X-Gm-Message-State: ANhLgQ0+jMqycqUj/eBeCTS2v9NSbZH7y4nAN8wm064wSsHllDHdM+9z
        +EVSVpTrrhs8QwBwsH8zTrMII+ErHS8=
X-Google-Smtp-Source: ADFU+vvjxHzXANGPhTHYqrfimidAE7wjQcJxr54mPYeD8d7XxaU7hEGOK8ZCtEZk0jvJ7ti9LysFlQ==
X-Received: by 2002:aa7:9811:: with SMTP id e17mr10003281pfl.33.1584051897861;
        Thu, 12 Mar 2020 15:24:57 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id x190sm56827659pfb.96.2020.03.12.15.24.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 15:24:56 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: L2CAP: Use DEFER_SETUP to group ECRED connections
Date:   Thu, 12 Mar 2020 15:24:53 -0700
Message-Id: <20200312222454.5079-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200312222454.5079-1-luiz.dentz@gmail.com>
References: <20200312222454.5079-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This uses the DEFER_SETUP flag to group channels with
L2CAP_CREDIT_BASED_CONNECTION_REQ.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/l2cap.h |   5 ++
 net/bluetooth/l2cap_core.c    | 130 +++++++++++++++++++++++++++++++---
 net/bluetooth/l2cap_sock.c    |  13 ++--
 3 files changed, 133 insertions(+), 15 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 537aaead259f..dada14d0622c 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -47,6 +47,7 @@
 #define L2CAP_DEFAULT_ACC_LAT		0xFFFFFFFF
 #define L2CAP_BREDR_MAX_PAYLOAD		1019    /* 3-DH5 packet */
 #define L2CAP_LE_MIN_MTU		23
+#define L2CAP_ECRED_CONN_SCID_MAX	5
 
 #define L2CAP_DISC_TIMEOUT		msecs_to_jiffies(100)
 #define L2CAP_DISC_REJ_TIMEOUT		msecs_to_jiffies(5000)
@@ -660,6 +661,7 @@ struct l2cap_ops {
 	void			(*suspend) (struct l2cap_chan *chan);
 	void			(*set_shutdown) (struct l2cap_chan *chan);
 	long			(*get_sndtimeo) (struct l2cap_chan *chan);
+	struct pid		*(*get_peer_pid) (struct l2cap_chan *chan);
 	struct sk_buff		*(*alloc_skb) (struct l2cap_chan *chan,
 					       unsigned long hdr_len,
 					       unsigned long len, int nb);
@@ -983,6 +985,9 @@ void l2cap_chan_set_defaults(struct l2cap_chan *chan);
 int l2cap_ertm_init(struct l2cap_chan *chan);
 void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan);
 void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan);
+typedef void (*l2cap_chan_func_t)(struct l2cap_chan *chan, void *data);
+void l2cap_chan_list(struct l2cap_conn *conn, l2cap_chan_func_t func,
+		     void *data);
 void l2cap_chan_del(struct l2cap_chan *chan, int err);
 void l2cap_send_conn_req(struct l2cap_chan *chan);
 void l2cap_move_start(struct l2cap_chan *chan);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 5e6e35ab44dd..20c1d5f9c238 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -678,6 +678,29 @@ void l2cap_chan_del(struct l2cap_chan *chan, int err)
 }
 EXPORT_SYMBOL_GPL(l2cap_chan_del);
 
+static void __l2cap_chan_list(struct l2cap_conn *conn, l2cap_chan_func_t func,
+			      void *data)
+{
+	struct l2cap_chan *chan;
+
+	list_for_each_entry(chan, &conn->chan_l, list) {
+		func(chan, data);
+	}
+}
+
+void l2cap_chan_list(struct l2cap_conn *conn, l2cap_chan_func_t func,
+		     void *data)
+{
+	if (!conn)
+		return;
+
+	mutex_lock(&conn->chan_lock);
+	__l2cap_chan_list(conn, func, data);
+	mutex_unlock(&conn->chan_lock);
+}
+
+EXPORT_SYMBOL_GPL(l2cap_chan_list);
+
 static void l2cap_conn_update_id_addr(struct work_struct *work)
 {
 	struct l2cap_conn *conn = container_of(work, struct l2cap_conn,
@@ -1356,29 +1379,77 @@ static void l2cap_le_connect(struct l2cap_chan *chan)
 		       sizeof(req), &req);
 }
 
-static void l2cap_ecred_connect(struct l2cap_chan *chan)
-{
-	struct l2cap_conn *conn = chan->conn;
+struct l2cap_ecred_conn_data {
 	struct {
 		struct l2cap_ecred_conn_req req;
-		__le16 scid;
+		__le16 scid[5];
 	} __packed pdu;
+	struct l2cap_chan *chan;
+	struct pid *pid;
+	int count;
+};
+
+static void l2cap_ecred_defer_connect(struct l2cap_chan *chan, void *data)
+{
+	struct l2cap_ecred_conn_data *conn = data;
+	struct pid *pid;
+
+	if (chan == conn->chan)
+		return;
+
+	if (!test_and_clear_bit(FLAG_DEFER_SETUP, &chan->flags))
+		return;
+
+	pid = chan->ops->get_peer_pid(chan);
+
+	/* Only add deferred channels with the same PID/PSM */
+	if (conn->pid != pid || chan->psm != conn->chan->psm || chan->ident ||
+	    chan->mode != L2CAP_MODE_EXT_FLOWCTL || chan->state != BT_CONNECT)
+		return;
+
+	if (test_and_set_bit(FLAG_ECRED_CONN_REQ_SENT, &chan->flags))
+		return;
+
+	/* Set the same ident so we can match on the rsp */
+	chan->ident = conn->chan->ident;
+
+	/* Include all channels deferred */
+	conn->pdu.scid[conn->count] = cpu_to_le16(chan->scid);
+
+	conn->count++;
+}
+
+static void l2cap_ecred_connect(struct l2cap_chan *chan)
+{
+	struct l2cap_conn *conn = chan->conn;
+	struct l2cap_ecred_conn_data data;
+
+	if (test_bit(FLAG_DEFER_SETUP, &chan->flags))
+		return;
 
 	if (test_and_set_bit(FLAG_ECRED_CONN_REQ_SENT, &chan->flags))
 		return;
 
 	l2cap_ecred_init(chan, 0);
 
-	pdu.req.psm     = chan->psm;
-	pdu.req.mtu     = cpu_to_le16(chan->imtu);
-	pdu.req.mps     = cpu_to_le16(chan->mps);
-	pdu.req.credits = cpu_to_le16(chan->rx_credits);
-	pdu.scid        = cpu_to_le16(chan->scid);
+	data.pdu.req.psm     = chan->psm;
+	data.pdu.req.mtu     = cpu_to_le16(chan->imtu);
+	data.pdu.req.mps     = cpu_to_le16(chan->mps);
+	data.pdu.req.credits = cpu_to_le16(chan->rx_credits);
+	data.pdu.scid[0]     = cpu_to_le16(chan->scid);
 
 	chan->ident = l2cap_get_ident(conn);
+	data.pid = chan->ops->get_peer_pid(chan);
+
+	data.count = 1;
+	data.chan = chan;
+	data.pid = chan->ops->get_peer_pid(chan);
+
+	__l2cap_chan_list(conn, l2cap_ecred_defer_connect, &data);
 
 	l2cap_send_cmd(conn, chan->ident, L2CAP_ECRED_CONN_REQ,
-		       sizeof(pdu), &pdu);
+		       sizeof(data.pdu.req) + data.count * sizeof(__le16),
+		       &data.pdu);
 }
 
 static void l2cap_le_start(struct l2cap_chan *chan)
@@ -7694,6 +7765,29 @@ static bool is_valid_psm(u16 psm, u8 dst_type) {
 	return ((psm & 0x0101) == 0x0001);
 }
 
+struct l2cap_chan_data {
+	struct l2cap_chan *chan;
+	struct pid *pid;
+	int count;
+};
+
+static void l2cap_chan_by_pid(struct l2cap_chan *chan, void *data)
+{
+	struct l2cap_chan_data *d = data;
+
+	if (chan == d->chan)
+		return;
+
+	/* Only count deferred channels with the same PID/PSM */
+	if (d->pid != chan->ops->get_peer_pid(chan) ||
+	    !test_bit(FLAG_DEFER_SETUP, &chan->flags) ||
+	    chan->psm != d->chan->psm || chan->ident ||
+	    chan->state != BT_CONNECT)
+		return;
+
+	d->count++;
+}
+
 int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 		       bdaddr_t *dst, u8 dst_type)
 {
@@ -7813,6 +7907,22 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 		goto done;
 	}
 
+	if (chan->mode == L2CAP_MODE_EXT_FLOWCTL) {
+		struct l2cap_chan_data data;
+
+		data.chan = chan;
+		data.pid = chan->ops->get_peer_pid(chan);
+		data.count = 0;
+
+		l2cap_chan_list(conn, l2cap_chan_by_pid, &data);
+		/* Check if there isn't too many channels being connected */
+		if (!(data.count < L2CAP_ECRED_CONN_SCID_MAX - 1)) {
+			hci_conn_drop(hcon);
+			err = -EPROTO;
+			goto done;
+		}
+	}
+
 	mutex_lock(&conn->chan_lock);
 	l2cap_chan_lock(chan);
 
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 40fb10b591bd..e43a90e05972 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -549,11 +549,6 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case BT_DEFER_SETUP:
-		if (sk->sk_state != BT_BOUND && sk->sk_state != BT_LISTEN) {
-			err = -EINVAL;
-			break;
-		}
-
 		if (put_user(test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags),
 			     (u32 __user *) optval))
 			err = -EFAULT;
@@ -1504,6 +1499,13 @@ static long l2cap_sock_get_sndtimeo_cb(struct l2cap_chan *chan)
 	return sk->sk_sndtimeo;
 }
 
+static struct pid *l2cap_sock_get_peer_pid_cb(struct l2cap_chan *chan)
+{
+	struct sock *sk = chan->data;
+
+	return sk->sk_peer_pid;
+}
+
 static void l2cap_sock_suspend_cb(struct l2cap_chan *chan)
 {
 	struct sock *sk = chan->data;
@@ -1525,6 +1527,7 @@ static const struct l2cap_ops l2cap_chan_ops = {
 	.suspend		= l2cap_sock_suspend_cb,
 	.set_shutdown		= l2cap_sock_set_shutdown_cb,
 	.get_sndtimeo		= l2cap_sock_get_sndtimeo_cb,
+	.get_peer_pid		= l2cap_sock_get_peer_pid_cb,
 	.alloc_skb		= l2cap_sock_alloc_skb_cb,
 };
 
-- 
2.21.1

