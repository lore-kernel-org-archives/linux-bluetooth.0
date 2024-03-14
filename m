Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A4176EEC
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Mar 2024 18:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710440461; cv=pass; b=JAFQGRSz73YMwVqMjdknIsGkLMVUWQDyToiya7abKjqBfK8e76bl5wV3zUexHmznjhWDcFfO1NJ/C+gotib/wQyCQx4rq3A7wB98JEqidjVfr0P4PqTyh/vITxWqmhZJ3jKho6z6oE3faKVxVY/mum3mpSdd9nssuG4p1vLGCYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710440461; c=relaxed/simple;
	bh=upwLDxZeHoJ7y9p4wA1PGl0wvgGS07qfkAPnl5l4fTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mvHAzZ17MYO5qnpeD9eLF5SnIuxi1iLAUbNVOqR3bOA7fGBFo2+j7chtd11EY47I+XLqRwMN4s3Lli2NSFAY91/wKVlo0tTKbMj5fAN3bJV6nebIK5U8ygqWIaNRJttsNOkT3V8F+P2Kem9qQx984rBOGIUZx4Lo3+X1X9vN3ec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=NyGoqq7x; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="NyGoqq7x"
Received: from monolith.lan (unknown [193.138.7.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4TwbKZ6xhlz1026;
	Thu, 14 Mar 2024 20:20:50 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1710440451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qqAbdeHgbf6SrAl4IQ4INi2J0n7FCiKQNKklcsCW2+I=;
	b=NyGoqq7x1aqviyAGnMdQR2iCBrZkRli8h4IdgGgK9IUr9po5WKTj8zG/mjwlQgbHDC4ryU
	KewIC2nfNS/tNN99U0iOUnnDos9dhe4uStd64WQek/ct8hG+3UAHC44ULmiI7g6GIazsBN
	mhmwiM3sfyIlNHRM/3inZUL/HoaAfdw=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1710440451; a=rsa-sha256; cv=none;
	b=BYRGPS8UdSwnE3JUoyqeNIgT5g7s2yDUgsRtQ8alDVJu4CHY3SsVSOW0Z5bnIlFgxny46E
	cy3EDo6qypMocaZgUAooe9DkcKLyKsRGdjExdJx4X3sOSMvTdwYYaAGgo0oEZxOnLl+yDl
	l9Ng3R9ZmNLMWz173BtSKkvtaeKFeKI=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1710440451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qqAbdeHgbf6SrAl4IQ4INi2J0n7FCiKQNKklcsCW2+I=;
	b=dlm4e1Qvk8q8DWN+/v1lKNYh+24MsVM5bh81FqdzbHJwHQcmpe0KTrUiIP20ZQPIx4ORXi
	sYjj+X+ZJ7ne7VS4zpEtdrnovt2KbvC9C2f30A6sUGteikycCjNGflmDyy6NvqBkQusFCW
	H/wXdeTY/HadOf7/Fn0VVS7H4hp7bBU=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH v2 2/5] Bluetooth: ISO: add TX timestamping
Date: Thu, 14 Mar 2024 20:20:18 +0200
Message-ID: <05534fa39b2e6106bda98e1835a84e49821d6f58.1710440392.git.pav@iki.fi>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1710440392.git.pav@iki.fi>
References: <cover.1710440392.git.pav@iki.fi>
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
index 8af75d37b14c..a77ab9df7994 100644
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

