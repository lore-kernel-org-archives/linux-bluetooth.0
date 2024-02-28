Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5775C74426
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Feb 2024 20:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709150644; cv=pass; b=sChufF6nHoyTiA7aje0VvZNrSNx0GtIaEwVvV37t+sTPgKCN9QLg/EuhzAbu8ab6mpGeclg8iXbnm29hNB9TxHLBu6LXCkDRxPATTYh0ybOgawFmPim/VeON2daZ0eF3sIW5JQwJWTqr2Y5Iu0ewwN54toXOhhfPWuKsskVx6ac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709150644; c=relaxed/simple;
	bh=Xpgw8RzfiOV7c607k6YknS+aKHFD32znYo7Mdenl2OA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S+OL+2Q0GWFlSq/g5tMjvvVPVYbyw0MjjFh5sfT5Mf82AYaA4VzlOh7wC+lRlgCHkRHZG++mzpUBOoXLJrln49SodAkn++9sXdqDFXckIwYKQmcARj1BEwWHFfF8BQpIG+8gGl1YsyN6AcufbDoz7c6+RZby8WiIYngB0Gle0PA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=V1CeytCc; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="V1CeytCc"
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4TlQKW6ZqNzyyw;
	Wed, 28 Feb 2024 22:03:59 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1709150640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YCy+DFVmyNrdCZXqYvszAitDkeet40gm8286NI506HU=;
	b=V1CeytCcdArOz8/qfqTDYVExJzsugoySyWpk8tFSN0PvDAyeFltjN/su/DE5KtqDHcnf5b
	qhckOiPAhQ4g4YXVK85B29gbo8SOr29lMiiL9b1rUZZmQlF/1XoN78Hi/R2rD55hcJVQgT
	m3Xt2VHkKOE6sS1GKq/6+0ZhBZ53/NY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1709150640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YCy+DFVmyNrdCZXqYvszAitDkeet40gm8286NI506HU=;
	b=SY16Zr0QuLVfXx4bAEdU9yORBZBsh7zH/1u+T6M3vY8FFNkstaKQMu/F4pI7jOXfHUisfL
	5JW1jFIGzG0eXKo7/u6ZLBIjTzUbGVUoQUqqpWa6lwv5Mnc0Q44/wqhS/pdWRiUP6n5xf/
	7Nhh8sOEmSTW/dXcAig8PL8cpnDVsp0=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1709150640; a=rsa-sha256; cv=none;
	b=i1NhawL3fS5Nb0yac3oov2/G3E4DsHCGpXRrdiqBIlJgA00pE0jOFgHM/eiKMyPaRPWBH6
	I5QcFhAV2Ijv1CzSzZt+ooeVQcAvDOUxVDvOuQudWA/jNortGhJyM/O19z9lUGgbzPhjgl
	7kxvMAEDe5TOUzRkZYnmK5kOwTyQdb0=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [RFC PATCH 3/3] Bluetooth: L2CAP: add new ioctl() for reading tx latency
Date: Wed, 28 Feb 2024 22:03:41 +0200
Message-ID: <abe7d76d2cdc1d328da65770fa08150d285d318f.1709150574.git.pav@iki.fi>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1709150574.git.pav@iki.fi>
References: <cover.1709150574.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ioctl BTGETTXINFO to read information of a previous packet
completion event concerning a given L2CAP socket.

Mark skbs submitted so that hci_core updates latency info in the
hci_chan.  Read the information in the ioctl.

The ioctl is the same as for ISO sockets.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 include/net/bluetooth/bluetooth.h |  2 +-
 net/bluetooth/l2cap_core.c        | 12 ++++++++
 net/bluetooth/l2cap_sock.c        | 50 ++++++++++++++++++++++++++++++-
 3 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index ff4230d15461..480f5cbc24e4 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -244,7 +244,7 @@ struct bt_codecs {
  * Produces information of a previous event when a packet was sent, and the
  * length of packet queue at that time.
  *
- * Applicable to: Bluetooth ISO sockets.
+ * Applicable to: Bluetooth ISO and L2CAP sockets.
  *
  * Input: Zero-initialize reserved flag bits and other fields.
  *
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 467b242d8be0..c70f935d9242 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -2488,6 +2488,13 @@ static void l2cap_le_flowctl_send(struct l2cap_chan *chan)
 	       skb_queue_len(&chan->tx_q));
 }
 
+static void mark_tx_latency(struct l2cap_chan *chan, struct sk_buff *skb)
+{
+	struct hci_chan *hchan = chan->conn->hchan;
+
+	hci_mark_tx_latency(&hchan->tx_latency, skb);
+}
+
 int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len)
 {
 	struct sk_buff *skb;
@@ -2526,6 +2533,8 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len)
 		if (err)
 			return err;
 
+		mark_tx_latency(chan, skb_peek(&seg_queue));
+
 		skb_queue_splice_tail_init(&seg_queue, &chan->tx_q);
 
 		l2cap_le_flowctl_send(chan);
@@ -2547,6 +2556,7 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len)
 		if (IS_ERR(skb))
 			return PTR_ERR(skb);
 
+		mark_tx_latency(chan, skb);
 		l2cap_do_send(chan, skb);
 		err = len;
 		break;
@@ -2570,6 +2580,8 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len)
 		if (err)
 			break;
 
+		mark_tx_latency(chan, skb_peek(&seg_queue));
+
 		if (chan->mode == L2CAP_MODE_ERTM)
 			l2cap_tx(chan, NULL, &seg_queue, L2CAP_EV_DATA_REQUEST);
 		else
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 4287aa6cc988..08c130bd8b98 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1207,6 +1207,54 @@ static int l2cap_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 	return err;
 }
 
+static int l2cap_sock_ioctl(struct socket *sock, unsigned int cmd,
+			    unsigned long arg)
+{
+	struct sock *sk = sock->sk;
+	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
+	struct tx_latency latency;
+	struct bt_tx_info info;
+
+	BT_DBG("sk %p cmd %x arg %lx", sk, cmd, arg);
+
+	switch (cmd) {
+	case BTGETTXINFO:
+		/* Require zero-initialized, to allow later extensions */
+		if (copy_from_user(&info, (void __user *)arg, sizeof(info)))
+			return -EFAULT;
+		if (info.flags || info.queue || info.time || info.offset)
+			return -EINVAL;
+
+		memset(&info, 0, sizeof(info));
+
+		lock_sock(sk);
+
+		if (sk->sk_state != BT_CONNECTED || !chan->conn ||
+		    !chan->conn->hchan) {
+			release_sock(sk);
+			return -EINVAL;
+		}
+
+		hci_copy_tx_latency(&latency, &chan->conn->hchan->tx_latency);
+
+		release_sock(sk);
+
+		if (!latency.now.time)
+			return -ENOENT;
+
+		info.queue = latency.now.queue;
+		info.time = ktime_to_ns(latency.now.time);
+		info.offset = latency.now.offset;
+
+		if (copy_to_user((void __user *)arg, &info, sizeof(info)))
+			return -EFAULT;
+
+		return 0;
+	}
+
+	return bt_sock_ioctl(sock, cmd, arg);
+}
+
 /* Kill socket (only if zapped and orphan)
  * Must be called on unlocked socket, with l2cap channel lock.
  */
@@ -1883,7 +1931,7 @@ static const struct proto_ops l2cap_sock_ops = {
 	.sendmsg	= l2cap_sock_sendmsg,
 	.recvmsg	= l2cap_sock_recvmsg,
 	.poll		= bt_sock_poll,
-	.ioctl		= bt_sock_ioctl,
+	.ioctl		= l2cap_sock_ioctl,
 	.gettstamp	= sock_gettstamp,
 	.mmap		= sock_no_mmap,
 	.socketpair	= sock_no_socketpair,
-- 
2.44.0

