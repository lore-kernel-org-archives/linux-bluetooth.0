Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7B875804
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Mar 2024 18:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710440463; cv=pass; b=RNTqFhVorMTtL3lwz+47j+yPaK3xMYBqUTFaQwNJ4SkeL7HL5LtzJO7gsn0+IQa9Efnki5mdoRokz3ncJq6Ymk53WY7/FTSMOnfUM2GjX02J6lAhUSuqGEzGVQb1tg0zM/9syIqZ6CV3ZEWJFUrUFIZwsfEYDi8yxMkavPz8kZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710440463; c=relaxed/simple;
	bh=/LznObNaPw8hTW2dJJ6L+d8MgRNxsa8QbYXpBPQjbJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fvF6HXqAkDueUaV/bn+AwWU6G3S8cj9Qp498kHSN2FovpXSnYU6KGvognd6kwKn2T90dTDD1GNpW1KBXXAMZEwg4QcjDX/0PMU2M5ULKXUHTM+LjXSmSpJVB7IcrOAHp1VZlM0qHI/7T0eUZalna4MovfieIms09k+mP+Soddy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=UWY+ilr8; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="UWY+ilr8"
Received: from monolith.lan (unknown [193.138.7.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4TwbKg0yLqzyys;
	Thu, 14 Mar 2024 20:20:54 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1710440455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0tJRiAvnv73H8u/BQU9KyuNNXjlbFcWzO5jS/x7ilRU=;
	b=UWY+ilr8TXKrVk4NUtVy/uup1iWf0vwbUkeNG7FPWERZ1fNqO/6nJU5ewBHQ/pJN+hkG8V
	YC/htTgMeiVTfbQUgUarSDQ1OUyoUD9AfEimXhjay938s3H+advIWVXwlOiDJwnyNS9glD
	TH+eyabuY9ty4BQ0Z2+0xnK9qlY/8nI=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1710440455; a=rsa-sha256; cv=none;
	b=KVdymywA7/ogQUo6tE5+LAVoBTdB5R660pdoCu6havYp430ZS2faxOdClSN6EIfrmLPam/
	HDfU0tH4Ju/ejANLuJTdOjXICekwTOJMD/qD4Zx/Av27aOCRK8bRltf3UK9hdf+yLOMXC9
	0N/eDegS/+g9k/PKHL3+5ZqRB+f+R78=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1710440455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0tJRiAvnv73H8u/BQU9KyuNNXjlbFcWzO5jS/x7ilRU=;
	b=MMlrQeOeoW6FV6LQq7FYs/TnxX7VpXW+oHBM03EiPyJhfecyQE09+tVATTrtaxLWdroxxo
	NOa8TaM75mv0dKfxRM8fEKVMm8f1K9SMY40VAJo1lfO6VSgc05ivxlEQTCAmk+NkUpJPdX
	wbjbdm6xk2s+tgAbWJYHbnFl5x+Ynp8=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH v2 5/5] Bluetooth: add BT_NO_ERRQUEUE_POLL socket option
Date: Thu, 14 Mar 2024 20:20:21 +0200
Message-ID: <134027f3cbaeb7095d080c27cd4b1053d2eb560e.1710440392.git.pav@iki.fi>
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

Add socket option to disable POLLERR on non-empty socket error queue.

Applications can use this for sleeping socket error POLLERR waits, also
when using TX timestamping. This is useful when multiple layers of the
stack are using the same socket.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 include/net/bluetooth/bluetooth.h |  9 +++-
 net/bluetooth/af_bluetooth.c      | 72 ++++++++++++++++++++++++++++++-
 net/bluetooth/iso.c               |  8 ++--
 net/bluetooth/l2cap_sock.c        |  8 ++--
 net/bluetooth/sco.c               |  8 ++--
 5 files changed, 91 insertions(+), 14 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 9280e72093ee..dcee5384d715 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -240,6 +240,8 @@ struct bt_codecs {
 
 #define BT_ISO_BASE		20
 
+#define BT_NO_ERRQUEUE_POLL	21
+
 __printf(1, 2)
 void bt_info(const char *fmt, ...);
 __printf(1, 2)
@@ -387,7 +389,8 @@ struct bt_sock {
 enum {
 	BT_SK_DEFER_SETUP,
 	BT_SK_SUSPEND,
-	BT_SK_PKT_STATUS
+	BT_SK_PKT_STATUS,
+	BT_SK_NO_ERRQUEUE_POLL
 };
 
 struct bt_sock_list {
@@ -410,6 +413,10 @@ int  bt_sock_stream_recvmsg(struct socket *sock, struct msghdr *msg,
 			    size_t len, int flags);
 __poll_t bt_sock_poll(struct file *file, struct socket *sock, poll_table *wait);
 int  bt_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg);
+int bt_sock_setsockopt(struct socket *sock, int level, int optname,
+		       sockptr_t optval, unsigned int optlen);
+int bt_sock_getsockopt(struct socket *sock, int level, int optname,
+		       char __user *optval, int __user *optlen);
 int  bt_sock_wait_state(struct sock *sk, int state, unsigned long timeo);
 int  bt_sock_wait_ready(struct sock *sk, unsigned int msg_flags);
 
diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 67604ccec2f4..997197aa7b48 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -500,6 +500,12 @@ static inline __poll_t bt_accept_poll(struct sock *parent)
 	return 0;
 }
 
+static bool bt_sock_error_queue_poll(struct sock *sk)
+{
+	return !test_bit(BT_SK_NO_ERRQUEUE_POLL, &bt_sk(sk)->flags) &&
+		!skb_queue_empty_lockless(&sk->sk_error_queue);
+}
+
 __poll_t bt_sock_poll(struct file *file, struct socket *sock,
 		      poll_table *wait)
 {
@@ -511,7 +517,7 @@ __poll_t bt_sock_poll(struct file *file, struct socket *sock,
 	if (sk->sk_state == BT_LISTEN)
 		return bt_accept_poll(sk);
 
-	if (sk->sk_err || !skb_queue_empty_lockless(&sk->sk_error_queue))
+	if (sk->sk_err || bt_sock_error_queue_poll(sk))
 		mask |= EPOLLERR |
 			(sock_flag(sk, SOCK_SELECT_ERR_QUEUE) ? EPOLLPRI : 0);
 
@@ -582,6 +588,70 @@ int bt_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 }
 EXPORT_SYMBOL(bt_sock_ioctl);
 
+int bt_sock_setsockopt(struct socket *sock, int level, int optname,
+		       sockptr_t optval, unsigned int optlen)
+{
+	struct sock *sk = sock->sk;
+	int err = 0;
+	u32 opt;
+
+	if (level != SOL_BLUETOOTH)
+		return -ENOPROTOOPT;
+
+	lock_sock(sk);
+
+	switch (optname) {
+	case BT_NO_ERRQUEUE_POLL:
+		if (copy_from_sockptr(&opt, optval, sizeof(opt))) {
+			err = -EFAULT;
+			break;
+		}
+
+		if (opt)
+			set_bit(BT_SK_NO_ERRQUEUE_POLL, &bt_sk(sk)->flags);
+		else
+			clear_bit(BT_SK_NO_ERRQUEUE_POLL, &bt_sk(sk)->flags);
+		break;
+
+	default:
+		err = -ENOPROTOOPT;
+		break;
+	}
+
+	release_sock(sk);
+	return err;
+}
+EXPORT_SYMBOL(bt_sock_setsockopt);
+
+int bt_sock_getsockopt(struct socket *sock, int level, int optname,
+		       char __user *optval, int __user *optlen)
+{
+	struct sock *sk = sock->sk;
+	int err = 0;
+	u32 opt;
+
+	if (level != SOL_BLUETOOTH)
+		return -ENOPROTOOPT;
+
+	lock_sock(sk);
+
+	switch (optname) {
+	case BT_NO_ERRQUEUE_POLL:
+		opt = test_bit(BT_SK_NO_ERRQUEUE_POLL, &bt_sk(sk)->flags);
+		if (put_user(opt, (u32 __user *)optval))
+			err = -EFAULT;
+		break;
+
+	default:
+		err = -ENOPROTOOPT;
+		break;
+	}
+
+	release_sock(sk);
+	return err;
+}
+EXPORT_SYMBOL(bt_sock_getsockopt);
+
 /* This function expects the sk lock to be held when called */
 int bt_sock_wait_state(struct sock *sk, int state, unsigned long timeo)
 {
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index a77ab9df7994..6f5af549a8cc 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1596,8 +1596,8 @@ static int iso_sock_setsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	default:
-		err = -ENOPROTOOPT;
-		break;
+		release_sock(sk);
+		return bt_sock_setsockopt(sock, level, optname, optval, optlen);
 	}
 
 	release_sock(sk);
@@ -1667,8 +1667,8 @@ static int iso_sock_getsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	default:
-		err = -ENOPROTOOPT;
-		break;
+		release_sock(sk);
+		return bt_sock_getsockopt(sock, level, optname, optval, optlen);
 	}
 
 	release_sock(sk);
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 9a9f933a748b..06277ce1fd6b 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -697,8 +697,8 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	default:
-		err = -ENOPROTOOPT;
-		break;
+		release_sock(sk);
+		return bt_sock_getsockopt(sock, level, optname, optval, optlen);
 	}
 
 	release_sock(sk);
@@ -1102,8 +1102,8 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	default:
-		err = -ENOPROTOOPT;
-		break;
+		release_sock(sk);
+		return bt_sock_setsockopt(sock, level, optname, optval, optlen);
 	}
 
 	release_sock(sk);
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index b3c2af7c7d67..b8b1b314aed4 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -968,8 +968,8 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	default:
-		err = -ENOPROTOOPT;
-		break;
+		release_sock(sk);
+		return bt_sock_setsockopt(sock, level, optname, optval, optlen);
 	}
 
 	release_sock(sk);
@@ -1211,8 +1211,8 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	default:
-		err = -ENOPROTOOPT;
-		break;
+		release_sock(sk);
+		return bt_sock_getsockopt(sock, level, optname, optval, optlen);
 	}
 
 	release_sock(sk);
-- 
2.44.0

