Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67BD74412
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Feb 2024 20:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709150643; cv=pass; b=mvp8vDiUUXnXMcP8oZ5OJe3eZczFccAD2iaeeFGoB4XiiPcl8u8vmQSEcgmYBvNIHP6wulRiMKdxVFMIcI/t+Eh2wN1e5D2i87SlaqdI829RyKdA73ISJskV9rdgwNlFu5aUc8qIa8pEYk9hPuoMTn4RMZ/ShKGm33F1J1tB7O8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709150643; c=relaxed/simple;
	bh=dJ2QqBvUOy/j0pSEoZu6dOKIEiu58XqmvjqDqFAcriM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A/IOZuf5zVWFRMHYj4HqR1zO7p8+Kt0Z+z0GB2WuQ3QHj3ajta/o7dtt42Pzn9ggYByiTDIY4gLbQnizkZmf/co81ayqD3BUysATRFVvPcikLZUcZVvOaVcIctoMmrwUYpPEHzs7atTE6YrLiCTWlYKlBCSnvrKkDoiuhh3kzUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=X9GKiMyz; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="X9GKiMyz"
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4TlQKW00snzyxR;
	Wed, 28 Feb 2024 22:03:58 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1709150639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w4G0jAuJ8gvFLcHu+ubt+Ek1wrUKLqbuD+fTQ4Z84og=;
	b=X9GKiMyzUHyPyYUNMn+58c2XFP6E7K2GnAAbAblWTxNFecK6qgH+BvAoNOyOrK1DKIViFI
	61y0e3ygmoocastlK8oXvwLtOSSWHbIoYxB1l0EYMob+lR2uqh29E7A6qvWgvopR5KvwYe
	qxI/AxURhl+x0QrDK92+tfB8Z/3U//E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1709150639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w4G0jAuJ8gvFLcHu+ubt+Ek1wrUKLqbuD+fTQ4Z84og=;
	b=sCFkplaVs+ZTf7neOq7bxSC52PfSYDeISMMJQK2GgOhSplauSMexdakkcJIJpnaM1QJa2c
	vbcvOVaCQ+SFG40/TYdbbHeZuxoBc3X12JoEWS9M3OtW6nM+MyaEsNxfs8c2rPmp2XWb0T
	IxMpZnX600ix3HyNO7nr2xPnPvwo7cM=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1709150639; a=rsa-sha256; cv=none;
	b=ctg3Q/DpYu4/KsUFmLZ17kLumbfHr3Fko/5Dz1V73KK5C99AKoMsqlBl+REytFgnVjLgEl
	STxx972wzTRAVQHYWiLqJJCXePVMPMda5HEzJubqfmbc2pCABIO5VZxKi/tK3iPgbcp0i1
	CsOXQLhVoTstQNhBqt0Nk+w3zmjx55c=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [RFC PATCH 2/3] Bluetooth: ISO: add new ioctl() for reading tx latency
Date: Wed, 28 Feb 2024 22:03:40 +0200
Message-ID: <8e5df7837d596cbedcfa04d766ce1caba50d853b.1709150574.git.pav@iki.fi>
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
completion event concerning a given ISO socket.

It contains sufficient information so the user can know which previous
sendmsg() the packet corresponds to and what was its completion time in
monotonic clock, so latency can be calculated.  The user can then also
know the packet queue length (in units of their sendmsg packets).

Mark submitted skb so that hci_core updates the latency information, and
read it in the ioctl.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 include/net/bluetooth/bluetooth.h | 37 ++++++++++++++++++++
 net/bluetooth/iso.c               | 58 ++++++++++++++++++++++++++++---
 2 files changed, 90 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index f6bdd040adaa..ff4230d15461 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -239,6 +239,43 @@ struct bt_codecs {
 
 #define BT_ISO_BASE		20
 
+/* BTGETTXINFO: Transmission latency information.
+ *
+ * Produces information of a previous event when a packet was sent, and the
+ * length of packet queue at that time.
+ *
+ * Applicable to: Bluetooth ISO sockets.
+ *
+ * Input: Zero-initialize reserved flag bits and other fields.
+ *
+ * Output:
+ *
+ * Fails with ENOENT if no packet has been sent.
+ *
+ * - flags: currently always 0, all bits reserved for extensions.
+ *
+ * - queue: total number of packets in queue (controller and socket buffers)
+ *   at the time of the event.
+ *
+ * - time: reference event timestamp (nsec, in system monotonic clock).
+ *
+ * - offset: offset (nsec) of actual packet timing from the reference timestamp.
+ *   Currently always 0.
+ *
+ * For packet latencies in nanoseconds, the application can track timestamps
+ * t[j] when it sent packet j. Then, given t[k] < tx_info.time < t[k + 1],
+ * event packet j = k - tx.queue and ref_latency_nsec = tx_info.time - t[j].
+ */
+
+#define BTGETTXINFO	_IOWR('B', 100, struct bt_tx_info)
+
+struct bt_tx_info {
+	__u32	flags;
+	__u32	queue;
+	__s64	time;
+	__s64	offset;
+} __packed;
+
 __printf(1, 2)
 void bt_info(const char *fmt, ...);
 __printf(1, 2)
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 30c777c469f9..4953c987e4fd 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -500,6 +500,8 @@ static int iso_send_frame(struct sock *sk, struct sk_buff *skb)
 
 	if (skb->len > qos->ucast.out.sdu)
 		return -EMSGSIZE;
+	if (sk->sk_state != BT_CONNECTED)
+		return -ENOTCONN;
 
 	len = skb->len;
 
@@ -509,10 +511,9 @@ static int iso_send_frame(struct sock *sk, struct sk_buff *skb)
 	hdr->slen = cpu_to_le16(hci_iso_data_len_pack(len,
 						      HCI_ISO_STATUS_VALID));
 
-	if (sk->sk_state == BT_CONNECTED)
-		hci_send_iso(conn->hcon, skb);
-	else
-		len = -ENOTCONN;
+	hci_mark_tx_latency(&conn->hcon->tx_latency, skb);
+
+	hci_send_iso(conn->hcon, skb);
 
 	return len;
 }
@@ -2232,6 +2233,53 @@ void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 	kfree_skb(skb);
 }
 
+static int iso_sock_ioctl(struct socket *sock, unsigned int cmd,
+			  unsigned long arg)
+{
+	struct sock *sk = sock->sk;
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
+		if (sk->sk_state != BT_CONNECTED) {
+			release_sock(sk);
+			return -EINVAL;
+		}
+
+		hci_copy_tx_latency(&latency,
+				    &iso_pi(sk)->conn->hcon->tx_latency);
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
 static struct hci_cb iso_cb = {
 	.name		= "ISO",
 	.connect_cfm	= iso_connect_cfm,
@@ -2270,7 +2318,7 @@ static const struct proto_ops iso_sock_ops = {
 	.sendmsg	= iso_sock_sendmsg,
 	.recvmsg	= iso_sock_recvmsg,
 	.poll		= bt_sock_poll,
-	.ioctl		= bt_sock_ioctl,
+	.ioctl		= iso_sock_ioctl,
 	.mmap		= sock_no_mmap,
 	.socketpair	= sock_no_socketpair,
 	.shutdown	= iso_sock_shutdown,
-- 
2.44.0

