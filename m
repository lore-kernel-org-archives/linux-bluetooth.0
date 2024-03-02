Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14175405DC
	for <linux-bluetooth@vger.kernel.org>; Sat,  2 Mar 2024 20:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709410073; cv=pass; b=QMbVKh+5ZFor27fF+SdJAjwvB1b+5T/SKLvY8AfMThYNifSqqWiTa7xjU5nqMcGEIPpybb6nsFfUvjPmi7Il96HrVIyRP5PBebSDDHlFelxbWKW6Oame8fYyaPbFzlKnebThwYAJ1lexkvgWOzJ3GrUyR1IGykkvpAAlrvXtnOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709410073; c=relaxed/simple;
	bh=u7QC6sL64UDDNUT0h12AYOazbJmmDxqQxw0iFueGfRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nfuPPFU2z7PoMlmAZftai+vTNIOkQB+pxWN5Vn+Ma6SybMsAQ/FUPua6ZrMem15+U/+gVe6L7Pl8+yipYo7xoPBdh6y5jUadYGcVH2/C2Q/Ohj10H9nMwqIohkb6UjPKnIPhlcoJZZBSWsIepaZyMKcRpax+pzfAm7bB9xfshmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=nSqK+fc0; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="nSqK+fc0"
Received: from monolith.lan (unknown [193.138.7.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4TnGGY20tXz101J;
	Sat,  2 Mar 2024 22:07:49 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1709410070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sO3iKgGZFl9k7ukd0+W8p10Wm7ZC/0YzcmUduBWXufA=;
	b=nSqK+fc0Y5SvDVWfn+CtK8e3TSUsBVbCDuIQgPI2e+9m7A0fyZzZAjR7uepUI7WPkP0WHY
	hwul/cSFsZoz1HVi+WUhZOYCiIv1GPBNLzVkcSykibN5/+HZuLsAhXtL2Ql3PO3CRcZPxN
	gEMhWEAqePCAQwSoWJfZysn3rfBL0UM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1709410070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sO3iKgGZFl9k7ukd0+W8p10Wm7ZC/0YzcmUduBWXufA=;
	b=JogKPYlomdxDM/lA4m5RZpjl5rR4315pwSfJ1M8ui7XX9beHI3tQVd6zPji0dNtyH5Jtd0
	Rh/N58u0dGya8WWPCWIjxsMZnfsyHJdjhD8jnBzWW/LJduVJRgjVc2W+aswyDTGvwFu9Jh
	HRggNWUe9fhdX0ppYBXRwm3RweiDZBw=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1709410070; a=rsa-sha256; cv=none;
	b=H55YlO1xkio0jzZNoonrwlATJBHRYgrOBpbJZ7WHzI97n+lmj/xdDHjdI34qNZgkyLpWxc
	OjI2VhusNpkDuavrR4FuqKITcsbYANhtSklGz6G6yTDf4T/GOlKnUwtsq7HTGIi9ptPj0B
	DGpDYEDLnISUfxbkX6hvTGzLFROBgCA=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH 2/3] Bluetooth: ISO: add TX timestamping
Date: Sat,  2 Mar 2024 22:07:37 +0200
Message-ID: <35bfe39b6d494fe93e656e8bd62e845d7ea7ee74.1709409547.git.pav@iki.fi>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1709409547.git.pav@iki.fi>
References: <cover.1709409547.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add BT_SCM_ERROR socket CMSG type.

Support TX timestamping in ISO sockets.

Support MSG_ERRQUEUE in ISO recvmsg.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 include/net/bluetooth/bluetooth.h |  1 +
 net/bluetooth/iso.c               | 24 ++++++++++++++++++++----
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 7ffa8c192c3f..9280e72093ee 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -155,6 +155,7 @@ struct bt_voice {
 #define BT_PKT_STATUS           16
 
 #define BT_SCM_PKT_STATUS	0x03
+#define BT_SCM_ERROR		0x04
 
 #define BT_ISO_QOS		17
 
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 30c777c469f9..f610fa04f329 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -489,7 +489,8 @@ static struct bt_iso_qos *iso_sock_get_qos(struct sock *sk)
 	return &iso_pi(sk)->qos;
 }
 
-static int iso_send_frame(struct sock *sk, struct sk_buff *skb)
+static int iso_send_frame(struct sock *sk, struct sk_buff *skb,
+			  const struct sockcm_cookie *sockc)
 {
 	struct iso_conn *conn = iso_pi(sk)->conn;
 	struct bt_iso_qos *qos = iso_sock_get_qos(sk);
@@ -509,10 +510,12 @@ static int iso_send_frame(struct sock *sk, struct sk_buff *skb)
 	hdr->slen = cpu_to_le16(hci_iso_data_len_pack(len,
 						      HCI_ISO_STATUS_VALID));
 
-	if (sk->sk_state == BT_CONNECTED)
+	if (sk->sk_state == BT_CONNECTED) {
+		hci_tx_timestamp(skb, sockc);
 		hci_send_iso(conn->hcon, skb);
-	else
+	} else {
 		len = -ENOTCONN;
+	}
 
 	return len;
 }
@@ -1266,6 +1269,7 @@ static int iso_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 {
 	struct sock *sk = sock->sk;
 	struct sk_buff *skb, **frag;
+	struct sockcm_cookie sockc;
 	size_t mtu;
 	int err;
 
@@ -1278,6 +1282,14 @@ static int iso_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 	if (msg->msg_flags & MSG_OOB)
 		return -EOPNOTSUPP;
 
+	sockcm_init(&sockc, sk);
+
+	if (msg->msg_controllen) {
+		err = sock_cmsg_send(sk, msg, &sockc);
+		if (err)
+			return err;
+	}
+
 	lock_sock(sk);
 
 	if (sk->sk_state != BT_CONNECTED) {
@@ -1323,7 +1335,7 @@ static int iso_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 	lock_sock(sk);
 
 	if (sk->sk_state == BT_CONNECTED)
-		err = iso_send_frame(sk, skb);
+		err = iso_send_frame(sk, skb, &sockc);
 	else
 		err = -ENOTCONN;
 
@@ -1379,6 +1391,10 @@ static int iso_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 
 	BT_DBG("sk %p", sk);
 
+	if (unlikely(flags & MSG_ERRQUEUE))
+		return sock_recv_errqueue(sk, msg, len, SOL_BLUETOOTH,
+					  BT_SCM_ERROR);
+
 	if (test_and_clear_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags)) {
 		lock_sock(sk);
 		switch (sk->sk_state) {
-- 
2.44.0

