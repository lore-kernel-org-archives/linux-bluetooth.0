Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020DA25C818
	for <linux-bluetooth@vger.kernel.org>; Sat,  1 Nov 2025 19:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762026972; cv=pass; b=Hb9HXWBv22ErdAUkUyTZ0ABnNwzUTPN0ryED7jBK0xkBiAPylaXKa5zKNHSEPUSXgydYk9do/GqTxrKsIhjXvyxOrPF5siYjNTzxMtcAHL2z1IcBObNvS/2ng2O4kd0R4hm3pJBF+5NGStX8B7hbe+AJ44O3/i154d5FM2C6Zmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762026972; c=relaxed/simple;
	bh=cwk0iBv1nkR13h6BPZnnVFdlRRS4xzsxkHlu1VRaX4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aAu02UYGDawkswx4hjKENJLXHB37LbGtPMOpJ6cKIwAapkpyPz3arhsuUIFrzLhY9KOROrtiICGRV801kVjEveZJiJ18XkH6blSSf3wGFekY/LkBxMrTqu15/Rfg6txGxzv6CKMAs29fEUiHdboKS9RWD4erl8TDQbPaaxXO38k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=ICVVN+OS; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="ICVVN+OS"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4czT9x0RYNzyQm;
	Sat,  1 Nov 2025 21:56:04 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1762026966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jmio2XT99ow4AEaUur9+17y+NBFBjpq4dWE8Bn2rLo8=;
	b=ICVVN+OS/dFv6Oe0mYLiL5GhOurQX6VVmZXw+ZVGMW17zdzM+6BjqOusn/am3f4TXINJSw
	dS8WGnmSrriSwZWwgXSfQBEoMjwWlxgDBEAz/oHl+PZOC4ch8Qiso0U14/hQ0EOG8mGH8C
	kpLVhwMgelhsmgww+pZHqcis+kZJsYI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1762026966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jmio2XT99ow4AEaUur9+17y+NBFBjpq4dWE8Bn2rLo8=;
	b=AZ6EFgyt82RBr4VNWiWf2ZWqKwLqkV620lyXHD3cGRVpxY4gqTGB2pOt/zqeZPSM4eaGkO
	VTSH/jJiQPxdr+jzDVlrBuYiPR8Ho+pjATDa2BVrIGPMyGBqpgXmqrwAPbf6YF76svj2dC
	kVIOK0OfDK87czImv9DF3B0qiUbzJEk=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1762026966; a=rsa-sha256; cv=none;
	b=pbTzFXHRDWid02tP03T3NFnzSbfOuzPMPhHT2iPz3yrIwqzbvNmSfkvn4q/qTHsTNc0sur
	upJ919tFAnE51uSCgrVHFtO3bfpOR8js9/W+LX10nq2VrFlIytm+Wherk4Fn19iqgqnsax
	/QIqyj3+4T4n//KD6owtDUkRQKE/oGA=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	zzzccc427@163.com
Subject: [RFC PATCH] Bluetooth: SCO: make locking more systematic and fix missing locks
Date: Sat,  1 Nov 2025 21:55:56 +0200
Message-ID: <9ca502845fc793f3f76c02aef316a273d3b6929c.1762026583.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <44091d60.3570.19a40a89dd8.Coremail.zzzccc427@163.com>
References: <44091d60.3570.19a40a89dd8.Coremail.zzzccc427@163.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Accesses to sco_conn::sk and hcon fields are missing locks in several
places.  Similarly for accesses to hci_conn::sco_data and
sco_pinfo::conn. kref_get_unless_zero() is used, but with no RCU or lock
in the struct it's accessing, which is incorrect. All of these can lead
to UAF.

Make locking systematic: add accessor functions for these with lockdep
asserts. Make direct access annoying with __private attribute to make
Sparse complain.  Document who owns what, and inc/dec refcounts when
assigning there.  Remove some useless refcount inc/dec.

Add locks and NULL checks where they were missing.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

    As seen in https://lore.kernel.org/linux-bluetooth/44091d60.3570.19a40a89dd8.Coremail.zzzccc427@163.com/
    that hcon->sco_data is cleared in sco_conn_free() without holding
    hdev->lock causes race condition with sco_conn_del() (which holds the
    lock) and UAF.
    
    It could be better to rethink the locking & ownership a bit, and have
    hcon->sco_data own a reference, and use lockdep & sparse to make sure
    right locks are held, as e.g. done here so these don't need to be hunted
    down with syzkaller.
    
#syz test git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master

 include/net/bluetooth/hci_core.h |   2 +-
 net/bluetooth/sco.c              | 311 +++++++++++++++++++++----------
 2 files changed, 217 insertions(+), 96 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index a0ad136b2108..9135ed40f602 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -768,7 +768,7 @@ struct hci_conn {
 
 	struct hci_dev	*hdev;
 	void		*l2cap_data;
-	void		*sco_data;
+	void		*__private sco_data;
 	void		*iso_data;
 
 	struct list_head link_list;
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index ab0cf442d57b..c416b49c1bbb 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -43,10 +43,10 @@ static struct bt_sock_list sco_sk_list = {
 
 /* ---- SCO connections ---- */
 struct sco_conn {
-	struct hci_conn	*hcon;
+	struct hci_conn	*__private hcon;
 
 	spinlock_t	lock;
-	struct sock	*sk;
+	struct sock	*__private sk;
 
 	struct delayed_work	timeout_work;
 
@@ -70,9 +70,41 @@ struct sco_pinfo {
 	__u32		flags;
 	__u16		setting;
 	struct bt_codec codec;
-	struct sco_conn	*conn;
+	struct sco_conn	*__private conn;
 };
 
+static inline struct sco_conn *sk_conn(struct sock *sk)
+{
+	lockdep_assert(lockdep_sock_is_held(sk));
+
+	/* sco_pi(sk) owns a reference, if non-NULL */
+	return ACCESS_PRIVATE(sco_pi(sk), conn);
+}
+
+static inline struct sco_conn *hcon_conn(struct hci_conn *hcon)
+{
+	lockdep_assert_held(&hcon->hdev->lock);
+
+	/* hcon owns a reference, if non-NULL */
+	return ACCESS_PRIVATE(hcon, sco_data);
+}
+
+static inline struct sock *conn_sk(struct sco_conn *conn)
+{
+	lockdep_assert_held(&conn->lock);
+
+	/* conn does not own a reference, may be NULL */
+	return ACCESS_PRIVATE(conn, sk);
+}
+
+static inline struct hci_conn *conn_hcon(struct sco_conn *conn)
+{
+	lockdep_assert_held(&conn->lock);
+
+	/* conn does not own reference, only hci_conn_hold/drop, may be NULL */
+	return ACCESS_PRIVATE(conn, hcon);
+}
+
 /* ---- SCO timers ---- */
 #define SCO_CONN_TIMEOUT	(HZ * 40)
 #define SCO_DISCONN_TIMEOUT	(HZ * 2)
@@ -83,13 +115,8 @@ static void sco_conn_free(struct kref *ref)
 
 	BT_DBG("conn %p", conn);
 
-	if (conn->sk)
-		sco_pi(conn->sk)->conn = NULL;
-
-	if (conn->hcon) {
-		conn->hcon->sco_data = NULL;
-		hci_conn_drop(conn->hcon);
-	}
+	WARN_ON(ACCESS_PRIVATE(conn, sk));
+	WARN_ON(ACCESS_PRIVATE(conn, hcon));
 
 	/* Ensure no more work items will run since hci_conn has been dropped */
 	disable_delayed_work_sync(&conn->timeout_work);
@@ -109,33 +136,63 @@ static void sco_conn_put(struct sco_conn *conn)
 
 static struct sco_conn *sco_conn_hold(struct sco_conn *conn)
 {
+	if (!conn)
+		return NULL;
+
 	BT_DBG("conn %p refcnt %u", conn, kref_read(&conn->ref));
 
 	kref_get(&conn->ref);
 	return conn;
 }
 
-static struct sco_conn *sco_conn_hold_unless_zero(struct sco_conn *conn)
+static struct sock *sco_sock_hold(struct sco_conn *conn)
 {
+	struct sock *sk;
+
 	if (!conn)
 		return NULL;
 
-	BT_DBG("conn %p refcnt %u", conn, kref_read(&conn->ref));
-
-	if (!kref_get_unless_zero(&conn->ref))
+	sk = conn_sk(conn);
+	if (!sk)
 		return NULL;
 
-	return conn;
+	sock_hold(sk);
+	return sk;
 }
 
-static struct sock *sco_sock_hold(struct sco_conn *conn)
+static inline void detach_sk_conn(struct sock *sk)
 {
-	if (!conn || !bt_sock_linked(&sco_sk_list, conn->sk))
-		return NULL;
+	struct sco_conn *conn = sk_conn(sk);
 
-	sock_hold(conn->sk);
+	if (conn) {
+		struct hci_conn *hcon;
 
-	return conn->sk;
+		sco_conn_lock(conn);
+		ACCESS_PRIVATE(conn, sk) = NULL;
+		hcon = conn_hcon(conn);
+		if (hcon)
+			hci_conn_drop(hcon);
+		sco_conn_unlock(conn);
+
+		sco_conn_put(conn);
+	}
+
+	ACCESS_PRIVATE(sco_pi(sk), conn) = NULL;
+}
+
+static inline void detach_hcon_conn(struct hci_conn *hcon)
+{
+	struct sco_conn *conn = hcon_conn(hcon);
+
+	if (conn) {
+		sco_conn_lock(conn);
+		ACCESS_PRIVATE(conn, hcon) = NULL;
+		sco_conn_unlock(conn);
+
+		sco_conn_put(conn);
+	}
+
+	ACCESS_PRIVATE(hcon, sco_data) = NULL;
 }
 
 static void sco_sock_timeout(struct work_struct *work)
@@ -144,19 +201,13 @@ static void sco_sock_timeout(struct work_struct *work)
 					     timeout_work.work);
 	struct sock *sk;
 
-	conn = sco_conn_hold_unless_zero(conn);
-	if (!conn)
-		return;
-
 	sco_conn_lock(conn);
-	if (!conn->hcon) {
+	if (!conn_hcon(conn)) {
 		sco_conn_unlock(conn);
-		sco_conn_put(conn);
 		return;
 	}
 	sk = sco_sock_hold(conn);
 	sco_conn_unlock(conn);
-	sco_conn_put(conn);
 
 	if (!sk)
 		return;
@@ -172,35 +223,35 @@ static void sco_sock_timeout(struct work_struct *work)
 
 static void sco_sock_set_timer(struct sock *sk, long timeout)
 {
-	if (!sco_pi(sk)->conn)
+	struct sco_conn *conn = sk_conn(sk);
+
+	if (!conn)
 		return;
 
 	BT_DBG("sock %p state %d timeout %ld", sk, sk->sk_state, timeout);
-	cancel_delayed_work(&sco_pi(sk)->conn->timeout_work);
-	schedule_delayed_work(&sco_pi(sk)->conn->timeout_work, timeout);
+	cancel_delayed_work(&conn->timeout_work);
+	schedule_delayed_work(&conn->timeout_work, timeout);
 }
 
 static void sco_sock_clear_timer(struct sock *sk)
 {
-	if (!sco_pi(sk)->conn)
+	struct sco_conn *conn = sk_conn(sk);
+
+	if (!conn)
 		return;
 
 	BT_DBG("sock %p state %d", sk, sk->sk_state);
-	cancel_delayed_work(&sco_pi(sk)->conn->timeout_work);
+	cancel_delayed_work(&conn->timeout_work);
 }
 
 /* ---- SCO connections ---- */
 static struct sco_conn *sco_conn_add(struct hci_conn *hcon)
 {
-	struct sco_conn *conn = hcon->sco_data;
+	struct sco_conn *conn = hcon_conn(hcon);
 
-	conn = sco_conn_hold_unless_zero(conn);
 	if (conn) {
-		if (!conn->hcon) {
-			sco_conn_lock(conn);
-			conn->hcon = hcon;
-			sco_conn_unlock(conn);
-		}
+		if (WARN_ON(ACCESS_PRIVATE(conn, hcon) != hcon))
+			return NULL;
 		return conn;
 	}
 
@@ -212,8 +263,8 @@ static struct sco_conn *sco_conn_add(struct hci_conn *hcon)
 	spin_lock_init(&conn->lock);
 	INIT_DELAYED_WORK(&conn->timeout_work, sco_sock_timeout);
 
-	hcon->sco_data = conn;
-	conn->hcon = hcon;
+	ACCESS_PRIVATE(hcon, sco_data) = conn;
+	ACCESS_PRIVATE(conn, hcon) = hcon;
 	conn->mtu = hcon->mtu;
 
 	if (hcon->mtu > 0)
@@ -230,19 +281,11 @@ static struct sco_conn *sco_conn_add(struct hci_conn *hcon)
  * Must be called on the locked socket. */
 static void sco_chan_del(struct sock *sk, int err)
 {
-	struct sco_conn *conn;
+	lockdep_assert(lockdep_sock_is_held(sk));
 
-	conn = sco_pi(sk)->conn;
-	sco_pi(sk)->conn = NULL;
+	BT_DBG("sk %p, conn %p, err %d", sk, sk_conn(sk), err);
 
-	BT_DBG("sk %p, conn %p, err %d", sk, conn, err);
-
-	if (conn) {
-		sco_conn_lock(conn);
-		conn->sk = NULL;
-		sco_conn_unlock(conn);
-		sco_conn_put(conn);
-	}
+	detach_sk_conn(sk);
 
 	sk->sk_state = BT_CLOSED;
 	sk->sk_err   = err;
@@ -253,10 +296,9 @@ static void sco_chan_del(struct sock *sk, int err)
 
 static void sco_conn_del(struct hci_conn *hcon, int err)
 {
-	struct sco_conn *conn = hcon->sco_data;
+	struct sco_conn *conn = hcon_conn(hcon);
 	struct sock *sk;
 
-	conn = sco_conn_hold_unless_zero(conn);
 	if (!conn)
 		return;
 
@@ -265,12 +307,11 @@ static void sco_conn_del(struct hci_conn *hcon, int err)
 	sco_conn_lock(conn);
 	sk = sco_sock_hold(conn);
 	sco_conn_unlock(conn);
-	sco_conn_put(conn);
 
-	if (!sk) {
-		sco_conn_put(conn);
+	detach_hcon_conn(hcon);
+
+	if (!sk)
 		return;
-	}
 
 	/* Kill socket */
 	lock_sock(sk);
@@ -285,8 +326,13 @@ static void __sco_chan_add(struct sco_conn *conn, struct sock *sk,
 {
 	BT_DBG("conn %p", conn);
 
-	sco_pi(sk)->conn = conn;
-	conn->sk = sk;
+	lockdep_assert_held(&conn->lock);
+	lockdep_assert(lockdep_sock_is_held(sk));
+
+	ACCESS_PRIVATE(sco_pi(sk), conn) = sco_conn_hold(conn);
+	ACCESS_PRIVATE(conn, sk) = sk;
+
+	hci_conn_hold(conn_hcon(conn));
 
 	if (parent)
 		bt_accept_enqueue(parent, sk, true);
@@ -297,9 +343,14 @@ static int sco_chan_add(struct sco_conn *conn, struct sock *sk,
 {
 	int err = 0;
 
+	lockdep_assert(lockdep_sock_is_held(sk));
+
 	sco_conn_lock(conn);
-	if (conn->sk)
+
+	if (conn_sk(conn) || sk_conn(sk))
 		err = -EBUSY;
+	else if (!conn_hcon(conn))
+		err = -EIO;
 	else
 		__sco_chan_add(conn, sk, parent);
 
@@ -354,6 +405,7 @@ static int sco_connect(struct sock *sk)
 	lock_sock(sk);
 
 	err = sco_chan_add(conn, sk, NULL);
+	hci_conn_drop(hcon);
 	if (err) {
 		release_sock(sk);
 		goto unlock;
@@ -381,7 +433,8 @@ static int sco_connect(struct sock *sk)
 static int sco_send_frame(struct sock *sk, struct sk_buff *skb,
 			  const struct sockcm_cookie *sockc)
 {
-	struct sco_conn *conn = sco_pi(sk)->conn;
+	struct sco_conn *conn = sk_conn(sk);
+	struct hci_conn *hcon;
 	int len = skb->len;
 
 	/* Check outgoing MTU */
@@ -391,7 +444,12 @@ static int sco_send_frame(struct sock *sk, struct sk_buff *skb,
 	BT_DBG("sk %p len %d", sk, len);
 
 	hci_setup_tx_timestamp(skb, 1, sockc);
-	hci_send_sco(conn->hcon, skb);
+
+	sco_conn_lock(conn);
+	hcon = conn_hcon(conn);
+	if (hcon)
+		hci_send_sco(hcon, skb);
+	sco_conn_unlock(conn);
 
 	return len;
 }
@@ -401,7 +459,7 @@ static void sco_recv_frame(struct sco_conn *conn, struct sk_buff *skb)
 	struct sock *sk;
 
 	sco_conn_lock(conn);
-	sk = conn->sk;
+	sk = sco_sock_hold(conn);
 	sco_conn_unlock(conn);
 
 	if (!sk)
@@ -413,10 +471,13 @@ static void sco_recv_frame(struct sco_conn *conn, struct sk_buff *skb)
 		goto drop;
 
 	if (!sock_queue_rcv_skb(sk, skb))
-		return;
+		goto done;
 
 drop:
 	kfree_skb(skb);
+done:
+	if (sk)
+		sock_put(sk);
 }
 
 /* -------- Socket interface ---------- */
@@ -466,7 +527,9 @@ static void sco_sock_destruct(struct sock *sk)
 {
 	BT_DBG("sk %p", sk);
 
-	sco_conn_put(sco_pi(sk)->conn);
+	lock_sock(sk);
+	detach_sk_conn(sk);
+	release_sock(sk);
 
 	skb_queue_purge(&sk->sk_receive_queue);
 	skb_queue_purge(&sk->sk_write_queue);
@@ -498,12 +561,9 @@ static void sco_sock_kill(struct sock *sk)
 
 	BT_DBG("sk %p state %d", sk, sk->sk_state);
 
-	/* Sock is dead, so set conn->sk to NULL to avoid possible UAF */
-	if (sco_pi(sk)->conn) {
-		sco_conn_lock(sco_pi(sk)->conn);
-		sco_pi(sk)->conn->sk = NULL;
-		sco_conn_unlock(sco_pi(sk)->conn);
-	}
+	lock_sock(sk);
+	detach_sk_conn(sk);
+	release_sock(sk);
 
 	/* Kill poor orphan */
 	bt_sock_unlink(&sco_sk_list, sk);
@@ -884,7 +944,6 @@ static int sco_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 			    size_t len, int flags)
 {
 	struct sock *sk = sock->sk;
-	struct sco_pinfo *pi = sco_pi(sk);
 
 	if (unlikely(flags & MSG_ERRQUEUE))
 		return sock_recv_errqueue(sk, msg, len, SOL_BLUETOOTH,
@@ -894,7 +953,15 @@ static int sco_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 
 	if (sk->sk_state == BT_CONNECT2 &&
 	    test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags)) {
-		sco_conn_defer_accept(pi->conn->hcon, pi->setting);
+		struct sco_conn *conn = sk_conn(sk);
+		struct hci_conn *hcon;
+
+		sco_conn_lock(conn);
+		hcon = conn_hcon(conn);
+		if (hcon)
+			sco_conn_defer_accept(hcon, sco_pi(sk)->setting);
+		sco_conn_unlock(conn);
+
 		sk->sk_state = BT_CONFIG;
 
 		release_sock(sk);
@@ -1047,6 +1114,8 @@ static int sco_sock_getsockopt_old(struct socket *sock, int optname,
 				   char __user *optval, int __user *optlen)
 {
 	struct sock *sk = sock->sk;
+	struct sco_conn *conn;
+	struct hci_conn *hcon;
 	struct sco_options opts;
 	struct sco_conninfo cinfo;
 	int err = 0;
@@ -1059,6 +1128,8 @@ static int sco_sock_getsockopt_old(struct socket *sock, int optname,
 
 	lock_sock(sk);
 
+	conn = sk_conn(sk);
+
 	switch (optname) {
 	case SCO_OPTIONS:
 		if (sk->sk_state != BT_CONNECTED &&
@@ -1068,7 +1139,12 @@ static int sco_sock_getsockopt_old(struct socket *sock, int optname,
 			break;
 		}
 
-		opts.mtu = sco_pi(sk)->conn->mtu;
+		if (!conn) {
+			err = -ENOTCONN;
+			break;
+		}
+
+		opts.mtu = conn->mtu;
 
 		BT_DBG("mtu %u", opts.mtu);
 
@@ -1086,9 +1162,27 @@ static int sco_sock_getsockopt_old(struct socket *sock, int optname,
 			break;
 		}
 
+		err = 0;
+
+		if (!conn) {
+			err = -ENOTCONN;
+			break;
+		}
+
+		sco_conn_lock(conn);
+
+		hcon = conn_hcon(conn);
+		if (!hcon) {
+			err = -ENOTCONN;
+			sco_conn_unlock(conn);
+			break;
+		}
+
 		memset(&cinfo, 0, sizeof(cinfo));
-		cinfo.hci_handle = sco_pi(sk)->conn->hcon->handle;
-		memcpy(cinfo.dev_class, sco_pi(sk)->conn->hcon->dev_class, 3);
+		cinfo.hci_handle = hcon->handle;
+		memcpy(cinfo.dev_class, hcon->dev_class, 3);
+
+		sco_conn_unlock(conn);
 
 		len = min(len, sizeof(cinfo));
 		if (copy_to_user(optval, (char *)&cinfo, len))
@@ -1118,6 +1212,8 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname,
 	struct hci_dev *hdev;
 	struct hci_codec_caps *caps;
 	struct bt_codec codec;
+	struct sco_conn *conn;
+	struct hci_conn *hcon;
 
 	BT_DBG("sk %p", sk);
 
@@ -1129,6 +1225,8 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname,
 
 	lock_sock(sk);
 
+	conn = sk_conn(sk);
+
 	switch (optname) {
 
 	case BT_DEFER_SETUP:
@@ -1153,12 +1251,23 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case BT_PHY:
-		if (sk->sk_state != BT_CONNECTED) {
+		if (sk->sk_state != BT_CONNECTED || !conn) {
 			err = -ENOTCONN;
 			break;
 		}
 
-		phys = hci_conn_get_phy(sco_pi(sk)->conn->hcon);
+		err = 0;
+
+		sco_conn_lock(conn);
+		hcon = conn_hcon(conn);
+		if (hcon)
+			phys = hci_conn_get_phy(hcon);
+		else
+			err = -ENOTCONN;
+		sco_conn_unlock(conn);
+
+		if (err)
+			break;
 
 		if (put_user(phys, (u32 __user *) optval))
 			err = -EFAULT;
@@ -1177,7 +1286,7 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		if (put_user(sco_pi(sk)->conn->mtu, (u32 __user *)optval))
+		if (put_user(conn->mtu, (u32 __user *)optval))
 			err = -EFAULT;
 		break;
 
@@ -1344,10 +1453,14 @@ static int sco_sock_release(struct socket *sock)
 static void sco_conn_ready(struct sco_conn *conn)
 {
 	struct sock *parent;
-	struct sock *sk = conn->sk;
+	struct sock *sk;
 
 	BT_DBG("conn %p", conn);
 
+	sco_conn_lock(conn);
+	sk = sco_sock_hold(conn);
+	sco_conn_unlock(conn);
+
 	if (sk) {
 		lock_sock(sk);
 		sco_sock_clear_timer(sk);
@@ -1355,17 +1468,20 @@ static void sco_conn_ready(struct sco_conn *conn)
 		sk->sk_state_change(sk);
 		release_sock(sk);
 	} else {
+		struct hci_conn *hcon;
+
 		sco_conn_lock(conn);
 
-		if (!conn->hcon) {
+		hcon = conn_hcon(conn);
+		if (!hcon) {
 			sco_conn_unlock(conn);
-			return;
+			goto done;
 		}
 
-		parent = sco_get_sock_listen(&conn->hcon->src);
+		parent = sco_get_sock_listen(&hcon->src);
 		if (!parent) {
 			sco_conn_unlock(conn);
-			return;
+			goto done;
 		}
 
 		lock_sock(parent);
@@ -1375,16 +1491,14 @@ static void sco_conn_ready(struct sco_conn *conn)
 		if (!sk) {
 			release_sock(parent);
 			sco_conn_unlock(conn);
-			return;
+			goto done;
 		}
 
 		sco_sock_init(sk, parent);
 
-		bacpy(&sco_pi(sk)->src, &conn->hcon->src);
-		bacpy(&sco_pi(sk)->dst, &conn->hcon->dst);
+		bacpy(&sco_pi(sk)->src, &hcon->src);
+		bacpy(&sco_pi(sk)->dst, &hcon->dst);
 
-		sco_conn_hold(conn);
-		hci_conn_hold(conn->hcon);
 		__sco_chan_add(conn, sk, parent);
 
 		if (test_bit(BT_SK_DEFER_SETUP, &bt_sk(parent)->flags))
@@ -1399,6 +1513,9 @@ static void sco_conn_ready(struct sco_conn *conn)
 
 		sco_conn_unlock(conn);
 	}
+
+done:
+	sock_put(sk);
 }
 
 /* ----- SCO interface with lower layer (HCI) ----- */
@@ -1440,10 +1557,8 @@ static void sco_connect_cfm(struct hci_conn *hcon, __u8 status)
 		struct sco_conn *conn;
 
 		conn = sco_conn_add(hcon);
-		if (conn) {
+		if (conn)
 			sco_conn_ready(conn);
-			sco_conn_put(conn);
-		}
 	} else
 		sco_conn_del(hcon, bt_to_errno(status));
 }
@@ -1460,20 +1575,26 @@ static void sco_disconn_cfm(struct hci_conn *hcon, __u8 reason)
 
 void sco_recv_scodata(struct hci_conn *hcon, struct sk_buff *skb)
 {
-	struct sco_conn *conn = hcon->sco_data;
+	struct sco_conn *conn;
+
+	hci_dev_lock(hcon->hdev);
+	conn = sco_conn_hold(hcon_conn(hcon));
+	hci_dev_unlock(hcon->hdev);
 
 	if (!conn)
 		goto drop;
 
 	BT_DBG("conn %p len %u", conn, skb->len);
 
-	if (skb->len) {
+	if (conn && skb->len) {
 		sco_recv_frame(conn, skb);
+		sco_conn_put(conn);
 		return;
 	}
 
 drop:
 	kfree_skb(skb);
+	sco_conn_put(conn);
 }
 
 static struct hci_cb sco_cb = {
-- 
2.51.1

