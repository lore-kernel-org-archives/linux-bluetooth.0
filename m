Return-Path: <SRS0=zBEa=4N=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD336C35DFA
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Feb 2020 07:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A949F21556
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Feb 2020 07:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qAH3mcUm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbgBYHep (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Feb 2020 02:34:45 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44987 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728978AbgBYHeo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Feb 2020 02:34:44 -0500
Received: by mail-pl1-f195.google.com with SMTP id d9so5122392plo.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Feb 2020 23:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Hp+0qwGkrzfKZN0Z2QFev4gemFzE4pAmbHXzWgyKMT4=;
        b=qAH3mcUmDKDgq4w2u/xwFT2K+jSn4o4rz6L6ma1DUEYZUo6pQSz3IUM2XzQkYbHv4x
         JZu6vKMWi5x6afB18iCxbvjhokiDiwtn2IhG6q12G0BwV42olPBiu2VwDyENLq9T+129
         2QU6iptbikf7mNyRM5+eW1Vi/tpycs6MvkoPcWmpElNBWskUzVgnQ03tQ2NnzMC6VrA7
         PdBJg2XMcl0f+QnLm6D4LKmUlMPgQIpJGlzIHS+ZjbtcUNUgphJAq011KU5b/LuK8mPm
         GKnFPtVcGd6tQ07WLskSXh41h4Va2I/ze2hTUaS8FrnjuNGo9lsJma+yLDFvwg8khEpN
         JZLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hp+0qwGkrzfKZN0Z2QFev4gemFzE4pAmbHXzWgyKMT4=;
        b=bKu7QuFoNDBv2+ayWgZfg9CcwyT8oxtlM/jDaVcCXeuRQaFakUk5Vha5IE+egMbdDw
         qtHjdGwfvR2sVmZxh3lV+tLkspI0PuKlvrnx8+lP25ej5QgK7SGHc3XR5yEgCPuyzo2c
         F9JqjPK7xSXPRIlYhw7gIcfUxmPKYF7kU+Uo6IwWtDgs/reAUXFgbURCr2umbzBCj2HK
         SI8W0Dh9ON7RQQi/4JmVuuZkGmYte707X916HpDww08rQiORi2mzrLBefFVRwiKWgdb0
         xdegO7skJ/MaGOuLUeCNYc4SNpAdsTgOR/3VHAO0QUpwZTUxVNKu1RxYrMy3Yr6k0mXW
         3OUw==
X-Gm-Message-State: APjAAAX9X2vXtylJfkxb7VByuzsM2pI5LnhARDYmYmK/qNGtTPk5Rw6L
        v/N8mKTYHxn7tU1FRTdXGtKysp0b8pI=
X-Google-Smtp-Source: APXvYqxBcFUWOVSOcQ6/sg2U9cot8m+II+o/M1wB8Wm5EXPwPP2r6hME+jNW1X68M6kTDJB515LMHQ==
X-Received: by 2002:a17:90a:a385:: with SMTP id x5mr3721623pjp.102.1582616083681;
        Mon, 24 Feb 2020 23:34:43 -0800 (PST)
Received: from vudentzs-t460s.amr.corp.intel.com ([2601:1c0:6800:1640::3287])
        by smtp.gmail.com with ESMTPSA id j125sm15642787pfg.160.2020.02.24.23.34.42
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 23:34:42 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC 5/5] Bluetooth: L2CAP: Use DEFER_SETUP to group ECRED connections
Date:   Mon, 24 Feb 2020 23:34:37 -0800
Message-Id: <20200225073437.11212-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200225073437.11212-1-luiz.dentz@gmail.com>
References: <20200225073437.11212-1-luiz.dentz@gmail.com>
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
 include/net/bluetooth/l2cap.h |  5 +++
 net/bluetooth/l2cap_core.c    | 81 ++++++++++++++++++++++++++++++-----
 net/bluetooth/l2cap_sock.c    | 49 ++++++++++++++++++---
 3 files changed, 120 insertions(+), 15 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 1644c9651a35..1b7be429f63c 100644
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
+void l2cap_chan_list(struct l2cap_conn *conn,
+		     void (*func)(struct l2cap_chan *chan, void *data),
+		     void *data);
 void l2cap_chan_del(struct l2cap_chan *chan, int err);
 void l2cap_send_conn_req(struct l2cap_chan *chan);
 void l2cap_move_start(struct l2cap_chan *chan);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index badfbbcc0de4..8eb483948565 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -678,6 +678,23 @@ void l2cap_chan_del(struct l2cap_chan *chan, int err)
 }
 EXPORT_SYMBOL_GPL(l2cap_chan_del);
 
+void l2cap_chan_list(struct l2cap_conn *conn,
+		     void (*func)(struct l2cap_chan *chan, void *data),
+		     void *data)
+{
+	struct l2cap_chan *chan;
+
+	mutex_lock(&conn->chan_lock);
+
+	list_for_each_entry(chan, &conn->chan_l, list) {
+		func(chan, data);
+	}
+
+	mutex_unlock(&conn->chan_lock);
+}
+
+EXPORT_SYMBOL_GPL(l2cap_chan_list);
+
 static void l2cap_conn_update_id_addr(struct work_struct *work)
 {
 	struct l2cap_conn *conn = container_of(work, struct l2cap_conn,
@@ -1356,29 +1373,73 @@ static void l2cap_le_connect(struct l2cap_chan *chan)
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
+
+	if (chan == conn->chan)
+		return;
+
+	/* Only add deferred channels with the same PID/PSM */
+	if (conn->pid != chan->ops->get_peer_pid(chan) ||
+	    chan->psm != conn->chan->psm || chan->ident ||
+	    chan->mode != L2CAP_MODE_EXT_FLOWCTL ||
+	    chan->state != BT_CONNECT)
+		return;
+
+	if (!test_and_clear_bit(FLAG_DEFER_SETUP, &chan->flags))
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
+	data.pdu.scid[0]   = cpu_to_le16(chan->scid);
 
 	chan->ident = l2cap_get_ident(conn);
+	data.pid = chan->ops->get_peer_pid(chan);
+
+	data.count = 1;
+	data.chan = chan;
+	data.pid = chan->ops->get_peer_pid(chan);
+
+	l2cap_chan_list(chan->conn, l2cap_ecred_defer_connect, &data);
 
 	l2cap_send_cmd(conn, chan->ident, L2CAP_ECRED_CONN_REQ,
-		       sizeof(pdu), &pdu);
+		       sizeof(data.pdu.req) + data.count * sizeof(__le16),
+		       &data.pdu);
 }
 
 static void l2cap_le_start(struct l2cap_chan *chan)
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 7ed0b79dd832..67a52fc2273e 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -172,6 +172,29 @@ static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
 	return err;
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
 static int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr,
 			      int alen, int flags)
 {
@@ -235,6 +258,19 @@ static int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr,
 	if (chan->psm && bdaddr_type_is_le(chan->src_type) && !chan->mode)
 		chan->mode = L2CAP_MODE_LE_FLOWCTL;
 
+	if (chan->mode == L2CAP_MODE_EXT_FLOWCTL) {
+		struct l2cap_chan_data data;
+
+		data.chan = chan;
+		data.pid = chan->ops->get_peer_pid(chan);
+		data.count = 0;
+
+		l2cap_chan_list(chan->conn, l2cap_chan_by_pid, &data);
+		/* Check if there isn't too many channels being connected */
+		if (!(data.count < L2CAP_ECRED_CONN_SCID_MAX - 1))
+			return -EINVAL;
+	}
+
 	err = l2cap_chan_connect(chan, la.l2_psm, __le16_to_cpu(la.l2_cid),
 				 &la.l2_bdaddr, la.l2_bdaddr_type);
 	if (err)
@@ -549,11 +585,6 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname,
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
@@ -1546,6 +1577,13 @@ static long l2cap_sock_get_sndtimeo_cb(struct l2cap_chan *chan)
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
@@ -1567,6 +1605,7 @@ static const struct l2cap_ops l2cap_chan_ops = {
 	.suspend		= l2cap_sock_suspend_cb,
 	.set_shutdown		= l2cap_sock_set_shutdown_cb,
 	.get_sndtimeo		= l2cap_sock_get_sndtimeo_cb,
+	.get_peer_pid		= l2cap_sock_get_peer_pid_cb,
 	.alloc_skb		= l2cap_sock_alloc_skb_cb,
 };
 
-- 
2.21.1

