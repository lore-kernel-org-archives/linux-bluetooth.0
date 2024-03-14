Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A1076EE3
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Mar 2024 18:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710440458; cv=pass; b=WirDhIuuDubBuZflPTEbsCnzip6FgzkShDGv79JAvXCwr5LxfHN1Nx0sKJUqQ+zn/HJqfvmZQiinoEoZi4U/OkwW6f3tdJCO+TEWq8eNfTFg9XvFnj6CuW916UFOac0D7zKowjX4EX0vndbrbiGX2DgNZjLRhG1rXR7ewhCPtko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710440458; c=relaxed/simple;
	bh=5l5lVmkPCMAqPndGYLPsYc9wx7ul86FMxgJiWYc7tjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S0iG1b3Tdslxcm5e/TQJeWqKeBtgU7DjKM/5/3VNSGCbWzyBiWy6854dS7GGjxKMZ3q0YOH87OvP0mTM+DHTgdYcnuw0PmdSk66VYNMWVwnQ1hY5Yjm4db6FjGu+tGixONrVYs+fBz9RFChYc+ufgCO5NtTvF0MmW5bdNsEe+Jg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=vD+Tsnjr; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="vD+Tsnjr"
Received: from monolith.lan (unknown [193.138.7.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4TwbKd5Plcz102l;
	Thu, 14 Mar 2024 20:20:53 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1710440454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vm+2/qQtsRuUHHsvP/c9vsHK3L46fAqkcZCyeDjF61Q=;
	b=vD+TsnjrzBRKqAq06mDWMmGx3q21TQ/em4sEhwsOmAM8LYqsmWb3uugeVDnkePsAbnNOIh
	HfeJcMlFYP0Q6IIWdQ6F9Nus7wwXek5MWSoVc03MiEKlX58Elr0k2qi6aE6CcwXzpwSjW6
	cN7NGI4YkU8/2cnSxyirgIcaB8FeNzo=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1710440454; a=rsa-sha256; cv=none;
	b=Nh3Pwq2OhqtFKBKneGPlbYDjkqHOvkJ2UQWkMfOgZ65447l3Fs0xb9FdjWsZhgXggRxpiR
	Cu85lwxD6rFmtY/yDhbeU+BVNdLb26GXTT9Nde8yvaSeEh9VjaWSdYEapniQskeSLXak9n
	FDpcLIqAfUUpI+zACFKg7x/evkkvM3A=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1710440454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vm+2/qQtsRuUHHsvP/c9vsHK3L46fAqkcZCyeDjF61Q=;
	b=Yb/nzs8nAJbiIEyYjJhLGBMk3uusm5jIDpB1vFuakuMUA0P14WANST0PSEupea3B+5fTJS
	nMt7iDJjeN4hMTbi/Ha3h4dfdiFVeHohsBoDobn/qFFqHiZsJXZ74LiBv0tbaew5CIGFcb
	f7+4ETyDwqH+w/RtcOjbB73KI4l6Trg=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH v2 4/5] Bluetooth: SCO: add TX timestamping
Date: Thu, 14 Mar 2024 20:20:20 +0200
Message-ID: <f64c7329ec80058d75b9bac91395a781ee9f52d2.1710440392.git.pav@iki.fi>
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

Support TX timestamping in SCO sockets.

Support MSG_ERRQUEUE in SCO recvmsg.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/sco.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 43daf965a01e..b3c2af7c7d67 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -305,7 +305,8 @@ static int sco_connect(struct sock *sk)
 	return err;
 }
 
-static int sco_send_frame(struct sock *sk, struct sk_buff *skb)
+static int sco_send_frame(struct sock *sk, struct sk_buff *skb,
+			  const struct sockcm_cookie *sockc)
 {
 	struct sco_conn *conn = sco_pi(sk)->conn;
 	int len = skb->len;
@@ -316,6 +317,7 @@ static int sco_send_frame(struct sock *sk, struct sk_buff *skb)
 
 	BT_DBG("sk %p len %d", sk, len);
 
+	hci_tx_timestamp(skb, sockc);
 	hci_send_sco(conn->hcon, skb);
 
 	return len;
@@ -720,6 +722,7 @@ static int sco_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 {
 	struct sock *sk = sock->sk;
 	struct sk_buff *skb;
+	struct sockcm_cookie sockc;
 	int err;
 
 	BT_DBG("sock %p, sk %p", sock, sk);
@@ -731,6 +734,14 @@ static int sco_sock_sendmsg(struct socket *sock, struct msghdr *msg,
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
 	skb = bt_skb_sendmsg(sk, msg, len, len, 0, 0);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
@@ -738,7 +749,7 @@ static int sco_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 	lock_sock(sk);
 
 	if (sk->sk_state == BT_CONNECTED)
-		err = sco_send_frame(sk, skb);
+		err = sco_send_frame(sk, skb, &sockc);
 	else
 		err = -ENOTCONN;
 
@@ -804,6 +815,10 @@ static int sco_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 	struct sock *sk = sock->sk;
 	struct sco_pinfo *pi = sco_pi(sk);
 
+	if (unlikely(flags & MSG_ERRQUEUE))
+		return sock_recv_errqueue(sk, msg, len, SOL_BLUETOOTH,
+					  BT_SCM_ERROR);
+
 	lock_sock(sk);
 
 	if (sk->sk_state == BT_CONNECT2 &&
-- 
2.44.0

