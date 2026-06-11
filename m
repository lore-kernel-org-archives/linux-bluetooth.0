Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5034E318EE7
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 15:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781190522; cv=none; b=V6tMxn7s7f4iy8aIYAVJ2CjJ0J33gejwH+i8MVwH9QLE851kzmYPhBMN7Gd+iog2jUOkexeSWQyhO3R+Gnna+D8xLIpbEW9eZocni91k4HyyaNL0a19Xn3V+537OMvu98J/QkqR65V+G8lHdW5Boe3CmoytF0I3IjIlsQZXFYtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781190522; c=relaxed/simple;
	bh=9U7DOaQ5+16iyM8JXubh0cFPPhcyNpomEnoKYe4ea3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X0N8WnprjhtY+xajiin2LpcIEs/uwhURH5SyV/oY1lueHlZM5yyveKyQL0s+E2jVoA2feeJB3CPHvp6Dxu4AlvVFdcrEy29Esw28w1jjsXe3rjmEuSKi2qUtXW9y8tmf54Gy5tawFPkuSLoKLAutP6gsLzxiWrc+f2ptTu6aSFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=Sc1K97yf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TLlkegCm; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="Sc1K97yf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TLlkegCm"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 96EBDEC0180;
	Thu, 11 Jun 2026 11:08:39 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Thu, 11 Jun 2026 11:08:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1781190519; x=
	1781276919; bh=xfwh/hLId7uyHqoouJ63emjgWR35uT1PqTS3ZFk3t9g=; b=S
	c1K97yfBAaw21+69Fi8a4Qf4p8iLsJwRZ8yMccKbp91pr4+2rTJTU5DOaXlipUkf
	+9SuGrWxDvKwEfGWVJ/AYdBrkkobpHAzWEt4Zfbx9u8iGHWHRGsFQ4XyhHP7sx62
	Qf68FMIazjR2rOSPxjlzVBKiRq37kwNNEEOvXryzR0iyYdAKfe0rhbzvwgeTqp5N
	AnylRQ7QgzQiGX2i9n7YepHMCNSwuOUDVtisGyQEZm0ZnAupFHu/zHSW7fAZiqAZ
	bhUqmQACamfcaq+mY/fUxR0pEq1yUqtYBG2pycI7Pgp7eEusGC5+N1V+QyW+xCiD
	g9meMQH3xYHrWWpkF+UFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1781190519; x=1781276919; bh=x
	fwh/hLId7uyHqoouJ63emjgWR35uT1PqTS3ZFk3t9g=; b=TLlkegCmrnVuVd5fS
	FpbckcYros7uGF2PU+KGkYDidI9Pnr1WI/XK7WQwyrwKSJte9Zlv3EHRl17s+2KG
	omtwJEDZa5f9syFknk9xoKJRWycXqTe8HbMU79aNyt/0eRBDoxQ8REdLw/0hsrpc
	jDtfSElehj+cbjvJ/W7ctI+ltQFoXOdW2ZyVZXj0qFdCKsBgBKQuR2oGJ6Ek5CmM
	ob7TeY1rXJX/frUWsD8z7c/RPQOWu4AgqOMVN3BlV/VqvowlaiKqTbyL2bu2YanQ
	VE3p6md2IX/fR36y49WN516BhbgGs7M2wja5noQ4novMcppiKT/QzBfuw3ID2tca
	29N0g==
X-ME-Sender: <xms:d88qavdKc05-yqTc9dxOANez57goxuCTO05SGiRq58V_CYZjRw5hSw>
    <xme:d88qasrM9vuaRcuGByunppCl6LzXmDmSUxkM_jVxLPJIEI86JL_fATJp9sSFrRbH-
    1gIg6scFK1_qtEwijFJHII9DMJPNy1BAU6t3d11LIdOQIeMbJBKGK0>
X-ME-Received: <xmr:d88qal62yC5LLMMxcc47AoR7gOfyE2GA8NOjcmiJhSYyeijkwU65G3ZdCCkzIRFSjvtDBOw>
X-ME-Proxy-Cause: dmFkZTGBcLZIhsV5LuzKUuKugE9hczacjF04XZjkElLCHJ7KbeF2/pkpwbH9E1mxvQGqqT
    pMtmiOGXeD2jpqv0E1u2QOMxvnJa8VQ2q5eW8p7Ah7zmZn1h1Y5ElutwVkzxMODuo7qvMH
    dbSd27O1KUx91oQtnPkAYhIcpAMTEP854sZFTAF9NVONM1JzDLocG8z75fC7gtKCwKtblE
    gMes2sL/Gj4aV/dEx388lXDBU6Vi5Rw8bvw/2VrgxqP11a7Kc8S31xr+75NXzbKT7RMRtJ
    /N+QOgzoKisJOs7tHQWdD3woNi968kfSyx2uQBf1/xh+l0ODaN0J2OUEJ/TqiAHo27wlFR
    OwJwsP/YtAZma1TnxU7X3s2rfXKeYakgG/1Tf27CVyCEEFuf2K1EOy2FRVjHN8Af76rmKN
    iwHzmlesvBjQWC4kluful2Y5dOcFV+5FtQ/Ji52HObFmduZkpR8UckKdDFf8jOcPHVVmOc
    nWq2MuSI0nbT3HLe/jGs69pbFSJ/n8pOL55seHOn+7AAMY4BHcjbFOjEoyvQHiH56YqW3T
    GujA9UHX9alZmWIDaEQ3mNvd6JxORQUeqweZOiBUEeX6Mm7rmTi3+SXIqap7fQthkiVkKy
    Tz/S3jN3Mi4Q+gZ8ZvlhAXP/hJtw6YbXEYdhL/C1iSyMICAs4EY31M/xmG5A
X-ME-Proxy: <xmx:d88qaqqdwMpXVBWKDBVn6wgoiKJ_wP7yUT916ohYVUUtpl7v2ZnuTw>
    <xmx:d88qavhYw5CgE5o_vuHxPipGi87OGQ_3OuJuuKcE7tXIL0TI7-4usw>
    <xmx:d88qasIyTUQMqWAsV5RbRYIBjjQViLE4fdoBz_zFESQsLfvAlCGlSQ>
    <xmx:d88qanDyI-WxdvmOszrkqiW-Z_vj5LVjJABBpIOAsoyNOFnOF2AX6g>
    <xmx:d88qaoqXzro4BW2QFbnOdesj3AEjPcNZtKDiagrDKrWwSXOMBqHA88_S>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jun 2026 11:08:39 -0400 (EDT)
From: Siwei Zhang <oss@fourdim.xyz>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Siwei Zhang <oss@fourdim.xyz>
Subject: [PATCH v10 1/1] Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_new_connection_cb()
Date: Thu, 11 Jun 2026 11:08:05 -0400
Message-ID: <20260611150822.2166160-2-oss@fourdim.xyz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611150822.2166160-1-oss@fourdim.xyz>
References: <20260611150822.2166160-1-oss@fourdim.xyz>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

l2cap_sock_new_connection_cb() returned l2cap_pi(sk)->chan after
release_sock(parent). Once the parent lock is dropped the newly
enqueued child socket sk is reachable via the accept queue, so another
task can accept and free it before the callback dereferences sk,
resulting in a use-after-free.

Rework the ->new_connection() op so the core, rather than the callback,
owns the child channel's lifetime. The op now receives a pre-allocated
new_chan and returns an errno instead of allocating and returning a
channel. l2cap_new_connection() allocates the child channel and links
it into the conn list via __l2cap_chan_add() before invoking the
callback, so the conn-list reference keeps the channel alive once
release_sock(parent) exposes the socket to other tasks.

Channel configuration that was duplicated in l2cap_sock_init() and the
various new_connection callbacks is consolidated into
l2cap_chan_set_defaults(), which now inherits from the parent channel
when one is supplied.

Fixes: 8ffb929098a5 ("Bluetooth: Remove parent socket usage from l2cap_core.c")
Cc: stable@kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
---
 include/net/bluetooth/l2cap.h |  10 ++--
 net/bluetooth/6lowpan.c       |  18 +-----
 net/bluetooth/l2cap_core.c    |  78 ++++++++++++++++++++-----
 net/bluetooth/l2cap_sock.c    | 103 ++++++++++++++++------------------
 net/bluetooth/smp.c           |  27 ++-------
 5 files changed, 127 insertions(+), 109 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index e0a1f2293679..27acfedf5c79 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -620,7 +620,8 @@ struct l2cap_chan {
 struct l2cap_ops {
 	char			*name;
 
-	struct l2cap_chan	*(*new_connection) (struct l2cap_chan *chan);
+	int			(*new_connection)(struct l2cap_chan *chan,
+						  struct l2cap_chan *new_chan);
 	int			(*recv) (struct l2cap_chan * chan,
 					 struct sk_buff *skb);
 	void			(*teardown) (struct l2cap_chan *chan, int err);
@@ -884,9 +885,10 @@ static inline __u16 __next_seq(struct l2cap_chan *chan, __u16 seq)
 	return (seq + 1) % (chan->tx_win_max + 1);
 }
 
-static inline struct l2cap_chan *l2cap_chan_no_new_connection(struct l2cap_chan *chan)
+static inline int l2cap_chan_no_new_connection(struct l2cap_chan *chan,
+					       struct l2cap_chan *new_chan)
 {
-	return NULL;
+	return -EOPNOTSUPP;
 }
 
 static inline int l2cap_chan_no_recv(struct l2cap_chan *chan, struct sk_buff *skb)
@@ -963,7 +965,7 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
 void l2cap_chan_busy(struct l2cap_chan *chan, int busy);
 void l2cap_chan_rx_avail(struct l2cap_chan *chan, ssize_t rx_avail);
 int l2cap_chan_check_security(struct l2cap_chan *chan, bool initiator);
-void l2cap_chan_set_defaults(struct l2cap_chan *chan);
+void l2cap_chan_set_defaults(struct l2cap_chan *chan, struct l2cap_chan *pchan);
 int l2cap_ertm_init(struct l2cap_chan *chan);
 void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan);
 void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan);
diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index cb1e329d66fd..6e57b4b95c94 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -632,7 +632,7 @@ static struct l2cap_chan *chan_create(void)
 	if (!chan)
 		return NULL;
 
-	l2cap_chan_set_defaults(chan);
+	l2cap_chan_set_defaults(chan, NULL);
 
 	chan->chan_type = L2CAP_CHAN_CONN_ORIENTED;
 	chan->mode = L2CAP_MODE_LE_FLOWCTL;
@@ -745,21 +745,6 @@ static inline void chan_ready_cb(struct l2cap_chan *chan)
 	ifup(dev->netdev);
 }
 
-static inline struct l2cap_chan *chan_new_conn_cb(struct l2cap_chan *pchan)
-{
-	struct l2cap_chan *chan;
-
-	chan = chan_create();
-	if (!chan)
-		return NULL;
-
-	chan->ops = pchan->ops;
-
-	BT_DBG("chan %p pchan %p", chan, pchan);
-
-	return chan;
-}
-
 static void unregister_dev(struct lowpan_btle_dev *dev)
 {
 	struct hci_dev *hdev = READ_ONCE(dev->hdev);
@@ -901,7 +886,6 @@ static long chan_get_sndtimeo_cb(struct l2cap_chan *chan)
 
 static const struct l2cap_ops bt_6lowpan_chan_ops = {
 	.name			= "L2CAP 6LoWPAN channel",
-	.new_connection		= chan_new_conn_cb,
 	.recv			= chan_recv_cb,
 	.close			= chan_close_cb,
 	.state_change		= chan_state_change_cb,
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index c4ccfbda9d78..78ea7cdcc906 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -519,7 +519,10 @@ void l2cap_chan_put(struct l2cap_chan *c)
 }
 EXPORT_SYMBOL_GPL(l2cap_chan_put);
 
-void l2cap_chan_set_defaults(struct l2cap_chan *chan)
+/* Initialise @chan with default values, inheriting from the parent channel
+ * @pchan when it is given.
+ */
+void l2cap_chan_set_defaults(struct l2cap_chan *chan, struct l2cap_chan *pchan)
 {
 	chan->fcs  = L2CAP_FCS_CRC16;
 	chan->max_tx = L2CAP_DEFAULT_MAX_TX;
@@ -533,6 +536,31 @@ void l2cap_chan_set_defaults(struct l2cap_chan *chan)
 	chan->retrans_timeout = L2CAP_DEFAULT_RETRANS_TO;
 	chan->monitor_timeout = L2CAP_DEFAULT_MONITOR_TO;
 
+	if (pchan) {
+		BT_DBG("chan %p pchan %p", chan, pchan);
+
+		chan->chan_type = pchan->chan_type;
+		chan->imtu = pchan->imtu;
+		chan->omtu = pchan->omtu;
+		chan->mode = pchan->mode;
+		chan->fcs = pchan->fcs;
+		chan->max_tx = pchan->max_tx;
+		chan->tx_win = pchan->tx_win;
+		chan->tx_win_max = pchan->tx_win_max;
+		chan->sec_level = pchan->sec_level;
+		chan->conf_state = pchan->conf_state;
+		chan->flags = pchan->flags;
+		chan->tx_credits = pchan->tx_credits;
+		chan->rx_credits = pchan->rx_credits;
+
+		if (chan->chan_type == L2CAP_CHAN_FIXED) {
+			chan->scid = pchan->scid;
+			chan->dcid = pchan->scid;
+		}
+
+		return;
+	}
+
 	chan->conf_state = 0;
 	set_bit(CONF_NOT_COMPLETE, &chan->conf_state);
 
@@ -4007,6 +4035,38 @@ static inline int l2cap_command_rej(struct l2cap_conn *conn,
 	return 0;
 }
 
+/* Allocate and initialise a channel for an incoming connection.
+ *
+ * The channel inherits its configuration from @pchan and is linked into @conn
+ * before ->new_connection() runs, so the conn list reference keeps it alive if
+ * the callback exposes it (e.g. via the socket accept queue) before this
+ * returns. The l2cap_chan_create() reference is taken over by the subsystem on
+ * success and dropped here on failure.
+ */
+static struct l2cap_chan *l2cap_new_connection(struct l2cap_conn *conn,
+					       struct l2cap_chan *pchan)
+{
+	struct l2cap_chan *chan;
+
+	chan = l2cap_chan_create();
+	if (!chan)
+		return NULL;
+
+	l2cap_chan_set_defaults(chan, pchan);
+	chan->ops = pchan->ops;
+
+	__l2cap_chan_add(conn, chan);
+
+	if (pchan->ops->new_connection &&
+	    pchan->ops->new_connection(pchan, chan) < 0) {
+		l2cap_chan_del(chan, 0);
+		l2cap_chan_put(chan);
+		return NULL;
+	}
+
+	return chan;
+}
+
 static void l2cap_connect(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd,
 			  u8 *data, u8 rsp_code)
 {
@@ -4053,7 +4113,7 @@ static void l2cap_connect(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd,
 		goto response;
 	}
 
-	chan = pchan->ops->new_connection(pchan);
+	chan = l2cap_new_connection(conn, pchan);
 	if (!chan)
 		goto response;
 
@@ -4071,8 +4131,6 @@ static void l2cap_connect(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd,
 	chan->psm  = psm;
 	chan->dcid = scid;
 
-	__l2cap_chan_add(conn, chan);
-
 	dcid = chan->scid;
 
 	__set_chan_timer(chan, chan->ops->get_sndtimeo(chan));
@@ -4955,7 +5013,7 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
 		goto response_unlock;
 	}
 
-	chan = pchan->ops->new_connection(pchan);
+	chan = l2cap_new_connection(conn, pchan);
 	if (!chan) {
 		result = L2CAP_CR_LE_NO_MEM;
 		goto response_unlock;
@@ -4970,8 +5028,6 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
 	chan->omtu = mtu;
 	chan->remote_mps = mps;
 
-	__l2cap_chan_add(conn, chan);
-
 	l2cap_le_flowctl_init(chan, __le16_to_cpu(req->credits));
 
 	dcid = chan->scid;
@@ -5179,7 +5235,7 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 			continue;
 		}
 
-		chan = pchan->ops->new_connection(pchan);
+		chan = l2cap_new_connection(conn, pchan);
 		if (!chan) {
 			result = L2CAP_CR_LE_NO_MEM;
 			continue;
@@ -5194,8 +5250,6 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 		chan->omtu = mtu;
 		chan->remote_mps = mps;
 
-		__l2cap_chan_add(conn, chan);
-
 		l2cap_ecred_init(chan, __le16_to_cpu(req->credits));
 
 		/* Init response */
@@ -7470,14 +7524,12 @@ static void l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
 			goto next;
 
 		l2cap_chan_lock(pchan);
-		chan = pchan->ops->new_connection(pchan);
+		chan = l2cap_new_connection(conn, pchan);
 		if (chan) {
 			bacpy(&chan->src, &hcon->src);
 			bacpy(&chan->dst, &hcon->dst);
 			chan->src_type = bdaddr_src_type(hcon);
 			chan->dst_type = dst_type;
-
-			__l2cap_chan_add(conn, chan);
 		}
 
 		l2cap_chan_unlock(pchan);
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 025329636353..7370f2b4d28e 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -46,7 +46,8 @@ static struct bt_sock_list l2cap_sk_list = {
 static const struct proto_ops l2cap_sock_ops;
 static void l2cap_sock_init(struct sock *sk, struct sock *parent);
 static struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
-				     int proto, gfp_t prio, int kern);
+				     int proto, gfp_t prio, int kern,
+				     struct l2cap_chan *chan);
 static void l2cap_sock_cleanup_listen(struct sock *parent);
 
 bool l2cap_is_socket(struct socket *sock)
@@ -1287,6 +1288,23 @@ static int l2cap_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 	return err;
 }
 
+/* Release the sock's ref on chan and clear the pointer so that the ref is
+ * dropped exactly once even if both l2cap_sock_kill() and
+ * l2cap_sock_destruct() run. Setting chan->data to NULL first stops any other
+ * task from dereferencing the now-dead sock pointer.
+ */
+static void l2cap_sock_put_chan(struct sock *sk)
+{
+	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
+
+	if (!chan)
+		return;
+
+	chan->data = NULL;
+	l2cap_pi(sk)->chan = NULL;
+	l2cap_chan_put(chan);
+}
+
 /* Kill socket (only if zapped and orphan)
  * Must be called on unlocked socket, with l2cap channel lock.
  */
@@ -1297,13 +1315,9 @@ static void l2cap_sock_kill(struct sock *sk)
 
 	BT_DBG("sk %p state %s", sk, state_to_string(sk->sk_state));
 
-	/* Sock is dead, so set chan data to NULL, avoid other task use invalid
-	 * sock pointer.
-	 */
-	l2cap_pi(sk)->chan->data = NULL;
-	/* Kill poor orphan */
+	l2cap_sock_put_chan(sk);
 
-	l2cap_chan_put(l2cap_pi(sk)->chan);
+	/* Kill poor orphan */
 	sock_set_flag(sk, SOCK_DEAD);
 	sock_put(sk);
 }
@@ -1546,12 +1560,13 @@ static void l2cap_sock_cleanup_listen(struct sock *parent)
 	}
 }
 
-static struct l2cap_chan *l2cap_sock_new_connection_cb(struct l2cap_chan *chan)
+static int l2cap_sock_new_connection_cb(struct l2cap_chan *chan,
+					struct l2cap_chan *new_chan)
 {
 	struct sock *sk, *parent = chan->data;
 
 	if (!parent)
-		return NULL;
+		return -EINVAL;
 
 	lock_sock(parent);
 
@@ -1559,25 +1574,28 @@ static struct l2cap_chan *l2cap_sock_new_connection_cb(struct l2cap_chan *chan)
 	if (sk_acceptq_is_full(parent)) {
 		BT_DBG("backlog full %d", parent->sk_ack_backlog);
 		release_sock(parent);
-		return NULL;
+		return -ENOBUFS;
 	}
 
 	sk = l2cap_sock_alloc(sock_net(parent), NULL, BTPROTO_L2CAP,
-			      GFP_ATOMIC, 0);
+			      GFP_ATOMIC, 0, new_chan);
 	if (!sk) {
 		release_sock(parent);
-		return NULL;
-        }
+		return -ENOMEM;
+	}
 
 	bt_sock_reclassify_lock(sk, BTPROTO_L2CAP);
 
 	l2cap_sock_init(sk, parent);
 
+	/* The conn list reference taken by l2cap_new_connection() keeps new_chan
+	 * alive once release_sock() lets another task free this socket.
+	 */
 	bt_accept_enqueue(parent, sk, false);
 
 	release_sock(parent);
 
-	return l2cap_pi(sk)->chan;
+	return 0;
 }
 
 static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
@@ -1874,10 +1892,7 @@ static void l2cap_sock_destruct(struct sock *sk)
 
 	BT_DBG("sk %p", sk);
 
-	if (l2cap_pi(sk)->chan) {
-		l2cap_pi(sk)->chan->data = NULL;
-		l2cap_chan_put(l2cap_pi(sk)->chan);
-	}
+	l2cap_sock_put_chan(sk);
 
 	list_for_each_entry_safe(rx_busy, next, &l2cap_pi(sk)->rx_busy, list) {
 		kfree_skb(rx_busy->skb);
@@ -1910,30 +1925,12 @@ static void l2cap_sock_init(struct sock *sk, struct sock *parent)
 	BT_DBG("sk %p", sk);
 
 	if (parent) {
-		struct l2cap_chan *pchan = l2cap_pi(parent)->chan;
-
 		sk->sk_type = parent->sk_type;
 		bt_sk(sk)->flags = bt_sk(parent)->flags;
 
-		chan->chan_type = pchan->chan_type;
-		chan->imtu = pchan->imtu;
-		chan->omtu = pchan->omtu;
-		chan->conf_state = pchan->conf_state;
-		chan->mode = pchan->mode;
-		chan->fcs  = pchan->fcs;
-		chan->max_tx = pchan->max_tx;
-		chan->tx_win = pchan->tx_win;
-		chan->tx_win_max = pchan->tx_win_max;
-		chan->sec_level = pchan->sec_level;
-		chan->flags = pchan->flags;
-		chan->tx_credits = pchan->tx_credits;
-		chan->rx_credits = pchan->rx_credits;
-
-		if (chan->chan_type == L2CAP_CHAN_FIXED) {
-			chan->scid = pchan->scid;
-			chan->dcid = pchan->scid;
-		}
-
+		/* Channel configuration is inherited from the parent by
+		 * l2cap_new_connection().
+		 */
 		security_sk_clone(parent, sk);
 	} else {
 		switch (sk->sk_type) {
@@ -1959,7 +1956,7 @@ static void l2cap_sock_init(struct sock *sk, struct sock *parent)
 			chan->mode = L2CAP_MODE_BASIC;
 		}
 
-		l2cap_chan_set_defaults(chan);
+		l2cap_chan_set_defaults(chan, NULL);
 	}
 
 	/* Default config options */
@@ -1978,10 +1975,10 @@ static struct proto l2cap_proto = {
 };
 
 static struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
-				     int proto, gfp_t prio, int kern)
+				     int proto, gfp_t prio, int kern,
+				     struct l2cap_chan *chan)
 {
 	struct sock *sk;
-	struct l2cap_chan *chan;
 
 	sk = bt_sock_alloc(net, sock, &l2cap_proto, proto, prio, kern);
 	if (!sk)
@@ -1992,16 +1989,7 @@ static struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
 
 	INIT_LIST_HEAD(&l2cap_pi(sk)->rx_busy);
 
-	chan = l2cap_chan_create();
-	if (!chan) {
-		sk_free(sk);
-		if (sock)
-			sock->sk = NULL;
-		return NULL;
-	}
-
-	l2cap_chan_hold(chan);
-
+	/* The sock takes ownership of the caller's reference on chan. */
 	l2cap_pi(sk)->chan = chan;
 
 	return sk;
@@ -2011,6 +1999,7 @@ static int l2cap_sock_create(struct net *net, struct socket *sock, int protocol,
 			     int kern)
 {
 	struct sock *sk;
+	struct l2cap_chan *chan;
 
 	BT_DBG("sock %p", sock);
 
@@ -2025,10 +2014,16 @@ static int l2cap_sock_create(struct net *net, struct socket *sock, int protocol,
 
 	sock->ops = &l2cap_sock_ops;
 
-	sk = l2cap_sock_alloc(net, sock, protocol, GFP_ATOMIC, kern);
-	if (!sk)
+	chan = l2cap_chan_create();
+	if (!chan)
 		return -ENOMEM;
 
+	sk = l2cap_sock_alloc(net, sock, protocol, GFP_ATOMIC, kern, chan);
+	if (!sk) {
+		l2cap_chan_put(chan);
+		return -ENOMEM;
+	}
+
 	l2cap_sock_init(sk, NULL);
 	bt_sock_link(&l2cap_sk_list, sk);
 	return 0;
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 1739c1989dbd..d3f9207a026d 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -3204,34 +3204,19 @@ static const struct l2cap_ops smp_chan_ops = {
 	.get_sndtimeo		= l2cap_chan_no_get_sndtimeo,
 };
 
-static inline struct l2cap_chan *smp_new_conn_cb(struct l2cap_chan *pchan)
+static inline int smp_new_conn_cb(struct l2cap_chan *chan,
+				  struct l2cap_chan *new_chan)
 {
-	struct l2cap_chan *chan;
-
-	BT_DBG("pchan %p", pchan);
-
-	chan = l2cap_chan_create();
-	if (!chan)
-		return NULL;
-
-	chan->chan_type	= pchan->chan_type;
-	chan->ops	= &smp_chan_ops;
-	chan->scid	= pchan->scid;
-	chan->dcid	= chan->scid;
-	chan->imtu	= pchan->imtu;
-	chan->omtu	= pchan->omtu;
-	chan->mode	= pchan->mode;
+	new_chan->ops = &smp_chan_ops;
 
 	/* Other L2CAP channels may request SMP routines in order to
 	 * change the security level. This means that the SMP channel
 	 * lock must be considered in its own category to avoid lockdep
 	 * warnings.
 	 */
-	atomic_set(&chan->nesting, L2CAP_NESTING_SMP);
-
-	BT_DBG("created chan %p", chan);
+	atomic_set(&new_chan->nesting, L2CAP_NESTING_SMP);
 
-	return chan;
+	return 0;
 }
 
 static const struct l2cap_ops smp_root_chan_ops = {
@@ -3291,7 +3276,7 @@ static struct l2cap_chan *smp_add_cid(struct hci_dev *hdev, u16 cid)
 
 	l2cap_add_scid(chan, cid);
 
-	l2cap_chan_set_defaults(chan);
+	l2cap_chan_set_defaults(chan, NULL);
 
 	if (cid == L2CAP_CID_SMP) {
 		u8 bdaddr_type;
-- 
2.54.0

