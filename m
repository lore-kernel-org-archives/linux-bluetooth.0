Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6340B1EF15
	for <linux-bluetooth@vger.kernel.org>; Sun,  7 Apr 2024 15:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712503073; cv=pass; b=IX1An5kGgg4JMYZ2oyQn4yxIvnOhm78/zcnM85JmTLnYmzYrf/+yqAPLfYp1GyynwVaBbOGOi1qF8v2L2WRn1O4hlyI+tjWCNN4cDq2IyxtQOJDxO2WAwXWJ0d9JeZ2XL4ucY1j29gTVWCpw8dUCz696HizLWgc9pfCNhZ8PIcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712503073; c=relaxed/simple;
	bh=21FdVstP12iuV2U3KnXL2HY7XhXLjzqxYDZ4q379gUg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZpHiihQAVoWbiT2NegBj5+ogXjz2QER5WqdKoEUkhp/m6oBOppypMxmX9Ehk6ipJhCgVcKa1pWKe+phtOk6DNcrgOW94J5a4PnYQxxlQRvZ8kzSBFuNCC6xxFldJznr8OvFIq/ykcP0UKG9J3zIKJokn06wZxsWTmnUnTN9qFNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=WkdMWnaq; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="WkdMWnaq"
Received: from monolith.lan (unknown [193.138.7.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4VCG785w0tz49Pyv;
	Sun,  7 Apr 2024 18:17:40 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1712503061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=d4M1ABqNRlAE4UfF4P02uciRJysjWEv8Ls2Xj3inFY0=;
	b=WkdMWnaqMfGHvpUIIKc0566+/Fz1lXuZbvK9wb3lFTaECDu/QOp0UH263xYSVmKgNPuntT
	BhNLnHPSoQkPD+pXIZ9x/Aj1WgT6R7qEghCIT0pHEQNV3p99K+aAoTBxrocHZ0tCmcCYub
	9UZtTbD6YmgwxRL0YjtGcjUmjbWOrJHa5GE3lGdUd77VHgvupj3zXjs0F32F+moS+pK5aY
	NZip3S8yak5ltX8xZeUJHvW4aapAAlLOFdb5jpYw8fV9JV/Fy+sG7KlCDqA1PKPm9fYdyW
	kM8wJg2zxDZwB3vksDexOe/uDHzN3X0yPSOMez1RCUjM1u+vThUSBVHDPytK1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1712503061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=d4M1ABqNRlAE4UfF4P02uciRJysjWEv8Ls2Xj3inFY0=;
	b=k/HsXnsl02LtCUbuV8Pkew+YG3L7ZvmohfNgGPpb2X6dgPVDweYveD8kQJfRrhiYTw1jhS
	HlRCrT1yP6gmYwwdWGSDZME12aaRNUAcshFs1JxlhIBrhOJ+++5akhdt9SdoI1cZqYu7gw
	HAmiDJF7Ngd6GYRxgldOAcTmXM2gAwOS32ETdj0sEeGyPrFVMh6+mMkH8YCALTOPZUJ2xk
	ciIYpyEitPLIX3tAdlFv8ylqSp4YS+V+B0ZnCYLmHAq+hxFVrkoDUXCRQ6LoyZlLrB961X
	n5iD6iD9rkp1Yhc5aVHntFx5aP25TCp/PizRaHlO0zll+8IGNAy2GP0fcOI87w==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1712503061; a=rsa-sha256;
	cv=none;
	b=cgQbVLiFB0cwSJ430folLWCgnwa4wrnJLvr79Ka4PaW668TDmYB66lgh9vN2lBNwNoDi48
	oxftNKLi1x798I5dv98YFgCSFqXfIsRsh7jHJPocWJaq3kmk+j4H1xI5OIYg0QZ/E1utlk
	PqNfprUHQy41JoiITmyWoAwxAELhoGnbzMbRRa5wZrhlggCFCuBRaKRKYihAHN6ge+ew/6
	5nzOSfJkkQjKPKgCFIlg006+vAROqefF2po+tYFf0WWW75QQAxSfYtjCHKo4f8ws1IMBXd
	jrylEhFm29GOFYi5tyfQLuF/ONKabslUaBXF0clXHq+hw61ixPPkquLcjgNYtQ==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH] Bluetooth: add experimental BT_POLL_ERRQUEUE socket option
Date: Sun,  7 Apr 2024 18:17:19 +0300
Message-ID: <f57e065bb571d633f811610d273711c7047af335.1712499936.git.pav@iki.fi>
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

It is a socket option as it enables a deviation from the common net/
errqueue API.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 include/net/bluetooth/bluetooth.h |  12 +++-
 net/bluetooth/af_bluetooth.c      | 115 +++++++++++++++++++++++++++++-
 net/bluetooth/iso.c               |   8 +--
 net/bluetooth/l2cap_sock.c        |   8 +--
 net/bluetooth/mgmt.c              |  65 ++++++++++++++++-
 net/bluetooth/sco.c               |   8 +--
 6 files changed, 200 insertions(+), 16 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 1ada4f85e982..2106a3e137e4 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -242,6 +242,8 @@ struct bt_codecs {
 
 #define BT_ISO_BASE		20
 
+#define BT_POLL_ERRQUEUE	21
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
+	BT_SK_NO_POLL_ERRQUEUE
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
 
+int bt_poll_errqueue_set_enabled(bool enabled);
+bool bt_poll_errqueue_enabled(void);
+
 #endif /* __BLUETOOTH_H */
diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 67604ccec2f4..773d479f376e 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -68,6 +68,9 @@ static const char *const bt_slock_key_strings[BT_MAX_PROTO] = {
 	"slock-AF_BLUETOOTH-BTPROTO_ISO",
 };
 
+static bool poll_errqueue_enabled;
+static DEFINE_SPINLOCK(poll_errqueue_enabled_lock);
+
 void bt_sock_reclassify_lock(struct sock *sk, int proto)
 {
 	BUG_ON(!sk);
@@ -500,6 +503,43 @@ static inline __poll_t bt_accept_poll(struct sock *parent)
 	return 0;
 }
 
+int bt_poll_errqueue_set_enabled(bool enabled)
+{
+	int err = 0;
+
+	spin_lock(&poll_errqueue_enabled_lock);
+	if (enabled != poll_errqueue_enabled)
+		poll_errqueue_enabled = enabled;
+	else
+		err = -EALREADY;
+	spin_unlock(&poll_errqueue_enabled_lock);
+	return err;
+}
+
+bool bt_poll_errqueue_enabled(void)
+{
+	bool ret;
+
+	spin_lock(&poll_errqueue_enabled_lock);
+	ret = poll_errqueue_enabled;
+	spin_unlock(&poll_errqueue_enabled_lock);
+	return ret;
+}
+
+static bool bt_sock_error_queue_poll(struct sock *sk)
+{
+	if (skb_queue_empty_lockless(&sk->sk_error_queue))
+		return false;
+
+	/* Prevent probably impossible in practice race where NO_POLL_ERRQUEUE
+	 * is set before TX timestamping is enabled (ordered by lock), but this
+	 * propagates to us after (reordered) test_bit but before queue_empty.
+	 */
+	smp_rmb();
+
+	return !test_bit(BT_SK_NO_POLL_ERRQUEUE, &bt_sk(sk)->flags);
+}
+
 __poll_t bt_sock_poll(struct file *file, struct socket *sock,
 		      poll_table *wait)
 {
@@ -511,7 +551,7 @@ __poll_t bt_sock_poll(struct file *file, struct socket *sock,
 	if (sk->sk_state == BT_LISTEN)
 		return bt_accept_poll(sk);
 
-	if (sk->sk_err || !skb_queue_empty_lockless(&sk->sk_error_queue))
+	if (sk->sk_err || bt_sock_error_queue_poll(sk))
 		mask |= EPOLLERR |
 			(sock_flag(sk, SOCK_SELECT_ERR_QUEUE) ? EPOLLPRI : 0);
 
@@ -582,6 +622,79 @@ int bt_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 }
 EXPORT_SYMBOL(bt_sock_ioctl);
 
+int bt_sock_setsockopt(struct socket *sock, int level, int optname,
+		       sockptr_t optval, unsigned int optlen)
+{
+	struct sock *sk = sock->sk;
+	u32 opt;
+
+	if (level != SOL_BLUETOOTH)
+		return -ENOPROTOOPT;
+
+	switch (optname) {
+	case BT_POLL_ERRQUEUE:
+		if (!bt_poll_errqueue_enabled())
+			return -ENOPROTOOPT;
+		if (optlen < sizeof(opt))
+			return -EINVAL;
+		if (copy_from_sockptr(&opt, optval, sizeof(opt)))
+			return -EFAULT;
+
+		lock_sock(sk);
+
+		if (opt)
+			clear_bit(BT_SK_NO_POLL_ERRQUEUE, &bt_sk(sk)->flags);
+		else
+			set_bit(BT_SK_NO_POLL_ERRQUEUE, &bt_sk(sk)->flags);
+
+		release_sock(sk);
+		break;
+
+	default:
+		return -ENOPROTOOPT;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(bt_sock_setsockopt);
+
+int bt_sock_getsockopt(struct socket *sock, int level, int optname,
+		       char __user *optval, int __user *optlen)
+{
+	struct sock *sk = sock->sk;
+	int len;
+	u32 opt;
+
+	if (level != SOL_BLUETOOTH)
+		return -ENOPROTOOPT;
+
+	if (get_user(len, optlen))
+		return -EFAULT;
+
+	switch (optname) {
+	case BT_POLL_ERRQUEUE:
+		if (!bt_poll_errqueue_enabled())
+			return -ENOPROTOOPT;
+		if (len < sizeof(opt))
+			return -EINVAL;
+
+		len = sizeof(opt);
+		opt = !test_bit(BT_SK_NO_POLL_ERRQUEUE, &bt_sk(sk)->flags);
+
+		if (put_user(opt, (u32 __user *)optval))
+			return -EFAULT;
+		if (put_user(len, optlen))
+			return -EFAULT;
+		break;
+
+	default:
+		return -ENOPROTOOPT;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(bt_sock_getsockopt);
+
 /* This function expects the sk lock to be held when called */
 int bt_sock_wait_state(struct sock *sk, int state, unsigned long timeo)
 {
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 0dda77e2e52c..37a38b1c1231 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1587,8 +1587,8 @@ static int iso_sock_setsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	default:
-		err = -ENOPROTOOPT;
-		break;
+		release_sock(sk);
+		return bt_sock_setsockopt(sock, level, optname, optval, optlen);
 	}
 
 	release_sock(sk);
@@ -1658,8 +1658,8 @@ static int iso_sock_getsockopt(struct socket *sock, int level, int optname,
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
index 32ed6e9245a3..7129e70a0253 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4339,6 +4339,12 @@ static const u8 mgmt_mesh_uuid[16] = {
 	0x8d, 0x4d, 0x03, 0x7a, 0xd7, 0x63, 0xe4, 0x2c,
 };
 
+/* 69518c4c-b69f-4679-8bc1-c021b47b5733 */
+static const u8 poll_errqueue_uuid[16] = {
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
@@ -4429,6 +4435,13 @@ static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
 		idx++;
 	}
 
+	if (!hdev) {
+		flags = bt_poll_errqueue_enabled() ? BIT(0) : 0;
+		memcpy(rp->features[idx].uuid, poll_errqueue_uuid, 16);
+		rp->features[idx].flags = cpu_to_le32(flags);
+		idx++;
+	}
+
 	rp->feature_count = cpu_to_le16(idx);
 
 	/* After reading the experimental features information, enable
@@ -4926,6 +4939,53 @@ static int set_iso_socket_func(struct sock *sk, struct hci_dev *hdev,
 }
 #endif
 
+static int set_poll_errqueue_func(struct sock *sk, struct hci_dev *hdev,
+				  struct mgmt_cp_set_exp_feature *cp,
+				  u16 data_len)
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
+	err = bt_poll_errqueue_set_enabled(val);
+	if (!err)
+		changed = true;
+
+	memcpy(rp.uuid, poll_errqueue_uuid, 16);
+	rp.flags = cpu_to_le32(val ? BIT(0) : 0);
+
+	hci_sock_set_flag(sk, HCI_MGMT_EXP_FEATURE_EVENTS);
+
+	err = mgmt_cmd_complete(sk, MGMT_INDEX_NONE,
+				MGMT_OP_SET_EXP_FEATURE, 0,
+				&rp, sizeof(rp));
+
+	if (changed)
+		exp_feature_changed(hdev, poll_errqueue_uuid, val, sk);
+
+	return err;
+}
+
 static const struct mgmt_exp_feature {
 	const u8 *uuid;
 	int (*set_func)(struct sock *sk, struct hci_dev *hdev,
@@ -4943,6 +5003,7 @@ static const struct mgmt_exp_feature {
 #ifdef CONFIG_BT_LE
 	EXP_FEAT(iso_socket_uuid, set_iso_socket_func),
 #endif
+	EXP_FEAT(poll_errqueue_uuid, set_poll_errqueue_func),
 
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

