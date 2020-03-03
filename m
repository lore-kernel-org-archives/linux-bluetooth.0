Return-Path: <SRS0=ag/l=4U=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF8CFC3F2D7
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Mar 2020 00:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E8B72467E
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Mar 2020 00:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ut5YC1Aw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgCCA43 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Mar 2020 19:56:29 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35541 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbgCCA42 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Mar 2020 19:56:28 -0500
Received: by mail-pf1-f196.google.com with SMTP id i19so573059pfa.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Mar 2020 16:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=AbdE2xlf1LtxSX3D72FzYEiNxId+WkswFKGvwSLQacc=;
        b=Ut5YC1AwB/aQFvpcW2O1JER1+gmr3xhmF1S/MiSmlcu3xEzB/u7uzBGIwq5a+ocWDU
         43eLqiZpFxMQDAUtRtfSRl9BhLawz7JrVQZmouMBwrskWHDtsi4levR+CYv5ldO4YVTI
         sY5oe5LJuGRh0rUXbS4qZ4tJ1dpDosusD1YuqsqWrylC4rYsFoSVwcjAC6QivWfqJbvY
         6ZCdhIAOu61m8yFIripEWSAVViTtYB6sMxeGZAxywpwiwCv77uzbI960SeUeuaB1DDWe
         SEQISneJWObg96ILbSJaSDFyGc8qA6WVDJyiFNvER0wVjmvyYfedVgr2eBxouMCW7Qte
         3t+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AbdE2xlf1LtxSX3D72FzYEiNxId+WkswFKGvwSLQacc=;
        b=rG4Tb9AI0VKwgKa9KlbiXmbKZH8c5OGygB8+i1FKStoumeODfIK35n6gl0q3D9Qeud
         9BqRBa1yWC0LFyZMQC7wEGUC9OT6UPzI3bwOq7Jg/YgxCD7Ti6ySNq58Vev37Gaub8Qg
         oAFm4T3keVsHV5gxxt5ISE0ESVMbWVXbANGcViPGp40XOdG4UVqNS6+DFndg8Y+6DApy
         UzW4IgywZdvfKlMqPWYNANhZ3hii2HW5r5kRi1hCgcZ+5X2JFhj7yYwNgAtURMC2JT2I
         QiPh1wzEn+001Z5sgiOn9/e5XWm9BH88GpV41sEOVVBMKNfs9wK/u3W9Xf908TbAj+MJ
         1IXA==
X-Gm-Message-State: ANhLgQ0oLHWx5chIu2O9/ld6FRVEf4h0RCWiP5iaDfxhHSKyeqr7Sw7p
        srXWwOUUh8JJkq2NUp3myRk6FcJ4OF8=
X-Google-Smtp-Source: ADFU+vtkDHS2IFTMIrY9oXm7WTFU3AxruvOwGW24Q4CgnWJZ+YlKVigUIlLEgAi2k6vMgVvFXJR0/Q==
X-Received: by 2002:a62:a515:: with SMTP id v21mr1663292pfm.128.1583196987189;
        Mon, 02 Mar 2020 16:56:27 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id b21sm23218500pfp.0.2020.03.02.16.56.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 16:56:26 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 4/5] Bluetooth: L2CAP: Use DEFER_SETUP to group ECRED connections
Date:   Mon,  2 Mar 2020 16:56:22 -0800
Message-Id: <20200303005623.18917-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200303005623.18917-1-luiz.dentz@gmail.com>
References: <20200303005623.18917-1-luiz.dentz@gmail.com>
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
index 0c636be3469e..958c1575d4f2 100644
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
@@ -1504,6 +1535,13 @@ static long l2cap_sock_get_sndtimeo_cb(struct l2cap_chan *chan)
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
@@ -1525,6 +1563,7 @@ static const struct l2cap_ops l2cap_chan_ops = {
 	.suspend		= l2cap_sock_suspend_cb,
 	.set_shutdown		= l2cap_sock_set_shutdown_cb,
 	.get_sndtimeo		= l2cap_sock_get_sndtimeo_cb,
+	.get_peer_pid		= l2cap_sock_get_peer_pid_cb,
 	.alloc_skb		= l2cap_sock_alloc_skb_cb,
 };
 
-- 
2.21.1

