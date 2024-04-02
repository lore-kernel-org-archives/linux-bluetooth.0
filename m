Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442132AD1E
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Apr 2024 16:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712076064; cv=pass; b=f1ev5DTU+vwd9U3Y3TwWAHQJ7cKEWjdXIhLbVD9dTIRmDodPJeqCRPbUNONCW1665BOZ7tKdJb/HGHfUbyUs7booF/DTjt+3H76W4kNlmaTL9aypyhhpQNbniTJFbAj+x4i1kBAtShdRXywmxWbhkqElYB6IebzDJz+h9HvV5ek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712076064; c=relaxed/simple;
	bh=gMk6hvUrzX931m8cOMBtdq9DXtsge25P0fdn6rgxXEg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mtr/wp7erH7rpVCV11et8p7xqfIOLho8BaR2JBE0IryVPaqKFXmdaoe8dq8G7F7B04VQVulfnwWZKPTgQ1ugS/f08tyOk2SsBeXT9/X70hI2uoHD85Biqoi9XczQlqMvZhok18Pj0Sk8JYXxoXO6mdqGafZb5wm9ohN86bV+UNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=xW+wFaI8; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="xW+wFaI8"
Received: from monolith.lan (unknown [193.138.7.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4V8DCZ2t5jzyTX;
	Tue,  2 Apr 2024 19:40:57 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1712076058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JyV7eRIR6EiXL48GfuLXfS+DrZBcS6sG++T8+sQ4+DQ=;
	b=xW+wFaI8iY7Bc8Ivb10/bU//mQdApbjwVNP7DXZQurIqk7poiY62njxx1YBTH66n8xVDdA
	lCT0G4lXLLcFTZ95MQjnRnCkrGgNj3lz5fASvHPLhtvdhLnQoPh/n24dBKbdkSs+I6TU5t
	hWWYS7d7o3D/cctJOx4JcAhEiSq0X/I=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1712076058; a=rsa-sha256; cv=none;
	b=mkGQor4uIJg16AKy1UR7GMl9NeJGWIZ9LRnhFGcUPe99vKD+7RfBBBae1JPV5Qj8dgjTGE
	AGSu1lcU2eHdVw734nxSQjeLF8zalnadwBzel4HPn0f4xVGmcdG41AJhzUYSktC1a0Nxhm
	ao+7A9SnNCmTG8Ea8u4IknJjc4KTu9Q=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1712076058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JyV7eRIR6EiXL48GfuLXfS+DrZBcS6sG++T8+sQ4+DQ=;
	b=bqSCWzf7yeczl63m4cErHiDi06skUBv8hElKJ2duguzyOjSr16/RPaLY3UGhWB4bQn9c2S
	N9MQLOxxHoW+iOU1rXiyO/X60pYYNMN1NLM9z4i4Nx/l+SwLbs2rUwiQ+ZRBIbJIsV3fMk
	0cVHTEv026DzL56Gl4XqQ6ZBQRvFQug=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH v3] Bluetooth: add experimental BT_NO_ERRQUEUE_POLL socket option
Date: Tue,  2 Apr 2024 19:40:47 +0300
Message-ID: <b44e1da7ebbfe99b74c136b8750981a4fb0ab243.1712075760.git.pav@iki.fi>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add experimental feature that enables a SOL_BLUETOOTH socket option to
disable POLLERR on non-empty socket error queue.  Add corresponding MGMT
experimental feature UUID for it.

This is intended to allow applications disable the POLLERR wakeups due
to TX timestamps, and allow upper layers of the stack to enable and
consume TX timestamps, without needing to complicate the lower layer
POLLERR handling which is only interested in real socket errors.

It is a socket option disabled by default, as it enables a deviation
from the common net/ TX timestamping API.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 include/net/bluetooth/bluetooth.h | 12 +++-
 net/bluetooth/af_bluetooth.c      | 98 ++++++++++++++++++++++++++++++-
 net/bluetooth/iso.c               |  8 +--
 net/bluetooth/l2cap_sock.c        |  8 +--
 net/bluetooth/mgmt.c              | 63 +++++++++++++++++++-
 net/bluetooth/sco.c               |  8 +--
 6 files changed, 181 insertions(+), 16 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index c95afcd9c605..0f11b436e5b3 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -242,6 +242,8 @@ struct bt_codecs {
 
 #define BT_ISO_BASE		20
 
+#define BT_NO_ERRQUEUE_POLL	21
+
 __printf(1, 2)
 void bt_info(const char *fmt, ...);
 __printf(1, 2)
@@ -389,7 +391,8 @@ struct bt_sock {
 enum {
 	BT_SK_DEFER_SETUP,
 	BT_SK_SUSPEND,
-	BT_SK_PKT_STATUS
+	BT_SK_PKT_STATUS,
+	BT_SK_NO_ERRQUEUE_POLL
 };
 
 struct bt_sock_list {
@@ -412,6 +415,10 @@ int  bt_sock_stream_recvmsg(struct socket *sock, struct msghdr *msg,
 			    size_t len, int flags);
 __poll_t bt_sock_poll(struct file *file, struct socket *sock, poll_table *wait);
 int  bt_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg);
+int bt_sock_setsockopt(struct socket *sock, int level, int optname,
+		       sockptr_t optval, unsigned int optlen);
+int bt_sock_getsockopt(struct socket *sock, int level, int optname,
+		       char __user *optval, int __user *optlen);
 int  bt_sock_wait_state(struct sock *sk, int state, unsigned long timeo);
 int  bt_sock_wait_ready(struct sock *sk, unsigned int msg_flags);
 
@@ -652,4 +659,7 @@ void mgmt_cleanup(struct sock *sk);
 
 void bt_sock_reclassify_lock(struct sock *sk, int proto);
 
+int bt_no_errqueue_poll_set_enabled(bool enabled);
+bool bt_no_errqueue_poll_enabled(void);
+
 #endif /* __BLUETOOTH_H */
diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 67604ccec2f4..cee4814f2aae 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -68,6 +68,8 @@ static const char *const bt_slock_key_strings[BT_MAX_PROTO] = {
 	"slock-AF_BLUETOOTH-BTPROTO_ISO",
 };
 
+static bool no_errqueue_poll_enabled;
+
 void bt_sock_reclassify_lock(struct sock *sk, int proto)
 {
 	BUG_ON(!sk);
@@ -500,6 +502,26 @@ static inline __poll_t bt_accept_poll(struct sock *parent)
 	return 0;
 }
 
+int bt_no_errqueue_poll_set_enabled(bool enabled)
+{
+	if (enabled != no_errqueue_poll_enabled) {
+		WRITE_ONCE(no_errqueue_poll_enabled, enabled);
+		return 0;
+	}
+	return 1;
+}
+
+bool bt_no_errqueue_poll_enabled(void)
+{
+	return READ_ONCE(no_errqueue_poll_enabled);
+}
+
+static bool bt_sock_error_queue_poll(struct sock *sk)
+{
+	return !test_bit(BT_SK_NO_ERRQUEUE_POLL, &bt_sk(sk)->flags) &&
+		!skb_queue_empty_lockless(&sk->sk_error_queue);
+}
+
 __poll_t bt_sock_poll(struct file *file, struct socket *sock,
 		      poll_table *wait)
 {
@@ -511,7 +533,7 @@ __poll_t bt_sock_poll(struct file *file, struct socket *sock,
 	if (sk->sk_state == BT_LISTEN)
 		return bt_accept_poll(sk);
 
-	if (sk->sk_err || !skb_queue_empty_lockless(&sk->sk_error_queue))
+	if (sk->sk_err || bt_sock_error_queue_poll(sk))
 		mask |= EPOLLERR |
 			(sock_flag(sk, SOCK_SELECT_ERR_QUEUE) ? EPOLLPRI : 0);
 
@@ -582,6 +604,80 @@ int bt_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
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
+		if (!bt_no_errqueue_poll_enabled()) {
+			err = -ENOPROTOOPT;
+			break;
+		}
+
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
+		if (!bt_no_errqueue_poll_enabled()) {
+			err = -ENOPROTOOPT;
+			break;
+		}
+
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
index 42b4495e019e..3c5cf7789d38 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1602,8 +1602,8 @@ static int iso_sock_setsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	default:
-		err = -ENOPROTOOPT;
-		break;
+		release_sock(sk);
+		return bt_sock_setsockopt(sock, level, optname, optval, optlen);
 	}
 
 	release_sock(sk);
@@ -1673,8 +1673,8 @@ static int iso_sock_getsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	default:
-		err = -ENOPROTOOPT;
-		break;
+		release_sock(sk);
+		return bt_sock_getsockopt(sock, level, optname, optval, optlen);
 	}
 
 	release_sock(sk);
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 7846a068bf60..a0f7c1bcdec8 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -698,8 +698,8 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	default:
-		err = -ENOPROTOOPT;
-		break;
+		release_sock(sk);
+		return bt_sock_getsockopt(sock, level, optname, optval, optlen);
 	}
 
 	release_sock(sk);
@@ -1103,8 +1103,8 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	default:
-		err = -ENOPROTOOPT;
-		break;
+		release_sock(sk);
+		return bt_sock_setsockopt(sock, level, optname, optval, optlen);
 	}
 
 	release_sock(sk);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 32ed6e9245a3..8f62850023a0 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4339,6 +4339,12 @@ static const u8 mgmt_mesh_uuid[16] = {
 	0x8d, 0x4d, 0x03, 0x7a, 0xd7, 0x63, 0xe4, 0x2c,
 };
 
+/* 69518c4c-b69f-4679-8bc1-c021b47b5733 */
+static const u8 no_errqueue_poll_uuid[16] = {
+	0x33, 0x57, 0x7b, 0xb4, 0x21, 0xc0, 0xc1, 0x8b,
+	0x79, 0x46, 0x9f, 0xb6, 0x4c, 0x8c, 0x51, 0x69,
+};
+
 static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
 				  void *data, u16 data_len)
 {
@@ -4350,8 +4356,8 @@ static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
 
 	bt_dev_dbg(hdev, "sock %p", sk);
 
-	/* Enough space for 7 features */
-	len = sizeof(*rp) + (sizeof(rp->features[0]) * 7);
+	/* Enough space for 8 features */
+	len = sizeof(*rp) + (sizeof(rp->features[0]) * 8);
 	rp = kzalloc(len, GFP_KERNEL);
 	if (!rp)
 		return -ENOMEM;
@@ -4429,6 +4435,11 @@ static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
 		idx++;
 	}
 
+	flags = bt_no_errqueue_poll_enabled() ? BIT(0) : 0;
+	memcpy(rp->features[idx].uuid, no_errqueue_poll_uuid, 16);
+	rp->features[idx].flags = cpu_to_le32(flags);
+	idx++;
+
 	rp->feature_count = cpu_to_le16(idx);
 
 	/* After reading the experimental features information, enable
@@ -4926,6 +4937,53 @@ static int set_iso_socket_func(struct sock *sk, struct hci_dev *hdev,
 }
 #endif
 
+static int set_no_errqueue_poll_func(struct sock *sk, struct hci_dev *hdev,
+				     struct mgmt_cp_set_exp_feature *cp,
+				     u16 data_len)
+{
+	struct mgmt_rp_set_exp_feature rp;
+	bool val, changed = false;
+	int err;
+
+	/* Command requires to use the non-controller index */
+	if (hdev)
+		return mgmt_cmd_status(sk, hdev->id,
+				       MGMT_OP_SET_EXP_FEATURE,
+				       MGMT_STATUS_INVALID_INDEX);
+
+	/* Parameters are limited to a single octet */
+	if (data_len != MGMT_SET_EXP_FEATURE_SIZE + 1)
+		return mgmt_cmd_status(sk, MGMT_INDEX_NONE,
+				       MGMT_OP_SET_EXP_FEATURE,
+				       MGMT_STATUS_INVALID_PARAMS);
+
+	/* Only boolean on/off is supported */
+	if (cp->param[0] != 0x00 && cp->param[0] != 0x01)
+		return mgmt_cmd_status(sk, MGMT_INDEX_NONE,
+				       MGMT_OP_SET_EXP_FEATURE,
+				       MGMT_STATUS_INVALID_PARAMS);
+
+	val = cp->param[0] ? true : false;
+
+	err = bt_no_errqueue_poll_set_enabled(val);
+	if (!err)
+		changed = true;
+
+	memcpy(rp.uuid, no_errqueue_poll_uuid, 16);
+	rp.flags = cpu_to_le32(val ? BIT(0) : 0);
+
+	hci_sock_set_flag(sk, HCI_MGMT_EXP_FEATURE_EVENTS);
+
+	err = mgmt_cmd_complete(sk, MGMT_INDEX_NONE,
+				MGMT_OP_SET_EXP_FEATURE, 0,
+				&rp, sizeof(rp));
+
+	if (changed)
+		exp_feature_changed(hdev, no_errqueue_poll_uuid, val, sk);
+
+	return err;
+}
+
 static const struct mgmt_exp_feature {
 	const u8 *uuid;
 	int (*set_func)(struct sock *sk, struct hci_dev *hdev,
@@ -4943,6 +5001,7 @@ static const struct mgmt_exp_feature {
 #ifdef CONFIG_BT_LE
 	EXP_FEAT(iso_socket_uuid, set_iso_socket_func),
 #endif
+	EXP_FEAT(no_errqueue_poll_uuid, set_no_errqueue_poll_func),
 
 	/* end with a null feature */
 	EXP_FEAT(NULL, NULL)
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 99c2b713d826..d4697f147b5a 100644
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
@@ -1212,8 +1212,8 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname,
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

