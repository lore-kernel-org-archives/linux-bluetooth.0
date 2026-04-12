Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7103226A08F
	for <linux-bluetooth@vger.kernel.org>; Sun, 12 Apr 2026 20:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776025152; cv=pass; b=VbIBixVu5NhPrUI0EGy8zaznAcBUU3f0O5EJ2NI4PGzokfndJXU1ujnn3ySGN7WsmOuFradox5BXXwsdMOlThOgvVhM9uyByqzGufCpoRkS0MJTN/lZRGH8AQWUmiepZFnnkvLFsERexSQMk4T2usdpYuySNYapkhxyAbCbqmyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776025152; c=relaxed/simple;
	bh=hX1dgOxr/tgDAJm8GI/Xv5nwExE4feI5gwtwiLY3wiU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sSMt8HMLIahIRt/9DkvMUzySSIN6qouGFtJOsJODbBA8rDdqbowvlNp+MY2OIAN4hvUNSN/LwU8Vw8LBbd7TvH57Yn2Yct1eDTLfcseuZ3kNzwpg27ohdNn4aHtF81WV8yza50w7vNT7JahcsJrp0L8k/KIoRWJZr7lkXfF7/FY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=S/5KMNzA; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="S/5KMNzA"
Received: from monolith.lan (mobile-access-2e844b-114.dhcp.inet.fi [46.132.75.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4fv21k24FYzyPt;
	Sun, 12 Apr 2026 23:19:06 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1776025146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lT9qMpnjLDN4RMiLZ+oBZ011rodafJ80RTUT0UX9yE0=;
	b=S/5KMNzAXl/tueY2TMlGowru1ptEdz4B7d0hmypkrUmVudW8gGhmxNNAenvFTlnPN8AL+U
	EE8+JFUKufj/WBGRR/G5jcn/FBeUMOKBatm7DmM4e1epkcACUhHDvOZxxjXsb6/tHMZzVi
	rhaaX+TgpbncDJ9tq6+NttMNVx6k8Jw=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1776025146;
	b=UkJnFTJ/eoeyd/oPDRXubWmQXs2sRAzlt09K3hJMSAUZr0j+mRuwa49lIbQlEzS8QOz+Yb
	bVa7m3hkKajYm04dTCZHdaDpnvQFiYTtOdj7OueK3HKzwNeET+Z9iroC24DxKTcmjWWZm5
	sJIbQdJnbOjMTLvsy77dOLB4GXS8Htg=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1776025146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lT9qMpnjLDN4RMiLZ+oBZ011rodafJ80RTUT0UX9yE0=;
	b=OynXZ/BRtrSxERf2+sarpP9LMar95omJvW8nE/EcZ0PhKusdw/e32YhxOLQEvbIYOCBVHW
	XTJViTDsBLl1HzH0XgEmjlfQ7/K+eXPPB+3iYp1+OSIrpPYyHzSmU+Bjscqt/3JEVAvCCs
	k5jWhK8TwglWckaS99oSsyzCI4DHAbA=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [RFC PATCH] Bluetooth: SCO: remove sco_conn and simplify locking scheme
Date: Sun, 12 Apr 2026 23:18:59 +0300
Message-ID: <5ac8c40b96052cb320c4ee1083d37818ac5d90cc.1776025103.git.pav@iki.fi>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sco_conn struct is not needed, as every SCO hci_conn is associated
with at most one SCO socket at a time. It adds unnecessary complexity in
lifetime and locking management, which has led to bugs.  E.g. access to
hci_conn::sco_data currently has a race in sco_conn_hold_unless_zero vs.
sco_conn_put->sco_conn_free in sco_chan_del.

Simplify by removing sco_conn and moving all fields to sco_pi.
The sco_pi(sk)->hcon field is guarded by lock_sock(sk).

Add lock hci_conn::proto_lock for protocols to use.  Make
hci_conn::sco_data guarded by RCU, and use that lock for updates.  The
RCU usage relies on SOCK_RCU_FREE, which moves destruct to call_rcu, so
it can be paired with refcount_inc_not_zero(&sk->sk_refcnt) as done in
other net/ protocols.

sk owns hci_conn_hold logical refcount when sco_pi(sk)->hcon != NULL.

Enable Clang context analysis for sco.c, and add relevant __must_hold
and lockdep markers.

This fixes: race on sco_data, calling sleeping functions under spinlock
in sco_conn_ready, dubious sco_conn locking & sk refcounting in
sco_conn_ready, missing locking in getsockopt / setsockopt.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    It's probably possible to get rid of the proto_lock, but this requires
    some custom memory ordering reasoning, so probably best avoided.

 include/net/bluetooth/hci_core.h |   6 +-
 net/bluetooth/Makefile           |   2 +
 net/bluetooth/hci_conn.c         |   2 +
 net/bluetooth/sco.c              | 458 +++++++++++++------------------
 4 files changed, 196 insertions(+), 272 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index a7bffb908c1e..555c2ce2dd15 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -770,8 +770,12 @@ struct hci_conn {
 	struct dentry	*debugfs;
 
 	struct hci_dev	*hdev;
+
+	/* Spinlock to guard sco_data */
+	spinlock_t	proto_lock;
+
 	void		*l2cap_data;
-	void		*sco_data;
+	void __rcu	*sco_data;
 	void		*iso_data;
 
 	struct list_head link_list;
diff --git a/net/bluetooth/Makefile b/net/bluetooth/Makefile
index a7eede7616d8..5fcc93fdd54e 100644
--- a/net/bluetooth/Makefile
+++ b/net/bluetooth/Makefile
@@ -26,3 +26,5 @@ bluetooth-$(CONFIG_BT_MSFTEXT) += msft.o
 bluetooth-$(CONFIG_BT_AOSPEXT) += aosp.o
 bluetooth-$(CONFIG_BT_DEBUGFS) += hci_debugfs.o
 bluetooth-$(CONFIG_BT_SELFTEST) += selftest.o
+
+CONTEXT_ANALYSIS_sco.o := y
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 3a0592599086..b8014f8bd844 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1057,6 +1057,8 @@ static struct hci_conn *__hci_conn_add(struct hci_dev *hdev, int type,
 	INIT_DELAYED_WORK(&conn->idle_work, hci_conn_idle);
 	INIT_DELAYED_WORK(&conn->le_conn_timeout, le_conn_timeout);
 
+	spin_lock_init(&conn->proto_lock);
+
 	atomic_set(&conn->refcnt, 0);
 
 	hci_dev_hold(hdev);
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 18826d4b9c0b..259bb45b0d65 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -42,21 +42,6 @@ static struct bt_sock_list sco_sk_list = {
 };
 
 /* ---- SCO connections ---- */
-struct sco_conn {
-	struct hci_conn	*hcon;
-
-	spinlock_t	lock;
-	struct sock	*sk;
-
-	struct delayed_work	timeout_work;
-
-	unsigned int    mtu;
-	struct kref	ref;
-};
-
-#define sco_conn_lock(c)	spin_lock(&c->lock)
-#define sco_conn_unlock(c)	spin_unlock(&c->lock)
-
 static void sco_sock_close(struct sock *sk);
 static void sco_sock_kill(struct sock *sk);
 
@@ -69,97 +54,21 @@ struct sco_pinfo {
 	bdaddr_t	dst;
 	__u32		flags;
 	__u16		setting;
+	unsigned int    mtu;
 	struct bt_codec codec;
-	struct sco_conn	*conn;
+	struct delayed_work timeout_work;
+	struct hci_conn *hcon;
 };
 
 /* ---- SCO timers ---- */
 #define SCO_CONN_TIMEOUT	(HZ * 40)
 #define SCO_DISCONN_TIMEOUT	(HZ * 2)
 
-static void sco_conn_free(struct kref *ref)
-{
-	struct sco_conn *conn = container_of(ref, struct sco_conn, ref);
-
-	BT_DBG("conn %p", conn);
-
-	if (conn->sk)
-		sco_pi(conn->sk)->conn = NULL;
-
-	if (conn->hcon) {
-		conn->hcon->sco_data = NULL;
-		hci_conn_drop(conn->hcon);
-	}
-
-	/* Ensure no more work items will run since hci_conn has been dropped */
-	disable_delayed_work_sync(&conn->timeout_work);
-
-	kfree(conn);
-}
-
-static void sco_conn_put(struct sco_conn *conn)
-{
-	if (!conn)
-		return;
-
-	BT_DBG("conn %p refcnt %d", conn, kref_read(&conn->ref));
-
-	kref_put(&conn->ref, sco_conn_free);
-}
-
-static struct sco_conn *sco_conn_hold(struct sco_conn *conn)
-{
-	BT_DBG("conn %p refcnt %u", conn, kref_read(&conn->ref));
-
-	kref_get(&conn->ref);
-	return conn;
-}
-
-static struct sco_conn *sco_conn_hold_unless_zero(struct sco_conn *conn)
-{
-	if (!conn)
-		return NULL;
-
-	BT_DBG("conn %p refcnt %u", conn, kref_read(&conn->ref));
-
-	if (!kref_get_unless_zero(&conn->ref))
-		return NULL;
-
-	return conn;
-}
-
-static struct sock *sco_sock_hold(struct sco_conn *conn)
-{
-	if (!conn || !bt_sock_linked(&sco_sk_list, conn->sk))
-		return NULL;
-
-	sock_hold(conn->sk);
-
-	return conn->sk;
-}
-
 static void sco_sock_timeout(struct work_struct *work)
 {
-	struct sco_conn *conn = container_of(work, struct sco_conn,
-					     timeout_work.work);
-	struct sock *sk;
-
-	conn = sco_conn_hold_unless_zero(conn);
-	if (!conn)
-		return;
-
-	sco_conn_lock(conn);
-	if (!conn->hcon) {
-		sco_conn_unlock(conn);
-		sco_conn_put(conn);
-		return;
-	}
-	sk = sco_sock_hold(conn);
-	sco_conn_unlock(conn);
-	sco_conn_put(conn);
-
-	if (!sk)
-		return;
+	struct sco_pinfo *pi = container_of(work, struct sco_pinfo,
+					    timeout_work.work);
+	struct sock *sk = (struct sock *)pi;
 
 	BT_DBG("sock %p state %d", sk, sk->sk_state);
 
@@ -167,82 +76,94 @@ static void sco_sock_timeout(struct work_struct *work)
 	sk->sk_err = ETIMEDOUT;
 	sk->sk_state_change(sk);
 	release_sock(sk);
-	sock_put(sk);
 }
 
 static void sco_sock_set_timer(struct sock *sk, long timeout)
 {
-	if (!sco_pi(sk)->conn)
-		return;
-
 	BT_DBG("sock %p state %d timeout %ld", sk, sk->sk_state, timeout);
-	cancel_delayed_work(&sco_pi(sk)->conn->timeout_work);
-	schedule_delayed_work(&sco_pi(sk)->conn->timeout_work, timeout);
+	cancel_delayed_work(&sco_pi(sk)->timeout_work);
+	schedule_delayed_work(&sco_pi(sk)->timeout_work, timeout);
 }
 
 static void sco_sock_clear_timer(struct sock *sk)
 {
-	if (!sco_pi(sk)->conn)
-		return;
-
 	BT_DBG("sock %p state %d", sk, sk->sk_state);
-	cancel_delayed_work(&sco_pi(sk)->conn->timeout_work);
+	cancel_delayed_work(&sco_pi(sk)->timeout_work);
 }
 
 /* ---- SCO connections ---- */
-static struct sco_conn *sco_conn_add(struct hci_conn *hcon)
+static struct sock *__sco_peek_sk(struct hci_conn *hcon)
+	__must_hold(&hcon->proto_lock)
 {
-	struct sco_conn *conn = hcon->sco_data;
-
-	conn = sco_conn_hold_unless_zero(conn);
-	if (conn) {
-		if (!conn->hcon) {
-			sco_conn_lock(conn);
-			conn->hcon = hcon;
-			sco_conn_unlock(conn);
-		}
-		return conn;
-	}
-
-	conn = kzalloc_obj(struct sco_conn);
-	if (!conn)
-		return NULL;
-
-	kref_init(&conn->ref);
-	spin_lock_init(&conn->lock);
-	INIT_DELAYED_WORK(&conn->timeout_work, sco_sock_timeout);
-
-	hcon->sco_data = conn;
-	conn->hcon = hcon;
-	conn->mtu = hcon->mtu;
-
-	if (hcon->mtu > 0)
-		conn->mtu = hcon->mtu;
-	else
-		conn->mtu = 60;
-
-	BT_DBG("hcon %p conn %p", hcon, conn);
-
-	return conn;
+	return rcu_dereference_protected(hcon->sco_data,
+					 lockdep_is_held(&hcon->proto_lock));
+}
+
+static struct sock *__sco_get_sk(struct hci_conn *hcon)
+{
+	struct sock *sk;
+
+	sk = rcu_dereference(hcon->sco_data);
+
+	if (sk && !refcount_inc_not_zero(&sk->sk_refcnt))
+		sk = NULL;
+
+	return sk;
+}
+
+static struct sock *sco_get_sk(struct hci_conn *hcon)
+{
+	struct sock *sk;
+
+	rcu_read_lock();
+	sk = __sco_get_sk(hcon);
+	rcu_read_unlock();
+	if (!sk)
+		return NULL;
+
+	lock_sock(sk);
+
+	/* Deal with sk detached in the meantime */
+	if (sco_pi(sk)->hcon != hcon) {
+		release_sock(sk);
+		sock_put(sk);
+		return NULL;
+	}
+
+	return sk;
+}
+
+static struct hci_conn *sco_sk_hcon(struct sock *sk)
+{
+	lockdep_assert(lockdep_sock_is_held(sk));
+	return sco_pi(sk)->hcon;
+}
+
+static void sco_sk_detach(struct sock *sk)
+{
+	struct hci_conn *hcon = sco_sk_hcon(sk);
+
+	if (hcon) {
+		/* RCU update (see sco_chan_add) */
+		spin_lock(&hcon->proto_lock);
+
+		lockdep_assert(__sco_peek_sk(hcon) == sk);
+		rcu_assign_pointer(hcon->sco_data, NULL);
+		sco_pi(sk)->hcon = NULL;
+
+		spin_unlock(&hcon->proto_lock);
+
+		hci_conn_drop(hcon);
+	}
 }
 
-/* Delete channel.
- * Must be called on the locked socket. */
 static void sco_chan_del(struct sock *sk, int err)
 {
-	struct sco_conn *conn;
+	BT_DBG("sk %p, hcon %p, err %d", sk, sco_sk_hcon(sk), err);
 
-	conn = sco_pi(sk)->conn;
-	sco_pi(sk)->conn = NULL;
+	lockdep_assert(lockdep_sock_is_held(sk));
 
-	BT_DBG("sk %p, conn %p, err %d", sk, conn, err);
-
-	if (conn) {
-		sco_conn_lock(conn);
-		conn->sk = NULL;
-		sco_conn_unlock(conn);
-		sco_conn_put(conn);
-	}
+	sco_sk_detach(sk);
 
 	sk->sk_state = BT_CLOSED;
 	sk->sk_err   = err;
@@ -252,64 +173,67 @@ static void sco_chan_del(struct sock *sk, int err)
 }
 
 static void sco_conn_del(struct hci_conn *hcon, int err)
+	__must_hold(&hcon->hdev->lock)
 {
-	struct sco_conn *conn = hcon->sco_data;
-	struct sock *sk;
+	struct sock *sk = sco_get_sk(hcon);
 
-	conn = sco_conn_hold_unless_zero(conn);
-	if (!conn)
+	if (!sk)
 		return;
 
-	BT_DBG("hcon %p conn %p, err %d", hcon, conn, err);
-
-	sco_conn_lock(conn);
-	sk = sco_sock_hold(conn);
-	sco_conn_unlock(conn);
-	sco_conn_put(conn);
-
-	if (!sk) {
-		sco_conn_put(conn);
-		return;
-	}
-
 	/* Kill socket */
-	lock_sock(sk);
 	sco_sock_clear_timer(sk);
 	sco_chan_del(sk, err);
 	release_sock(sk);
 	sock_put(sk);
 }
 
-static void __sco_chan_add(struct sco_conn *conn, struct sock *sk,
+static void __sco_chan_add(struct hci_conn *hcon, struct sock *sk,
 			   struct sock *parent)
+	__must_hold(&hcon->hdev->lock)
+	__must_hold(&hcon->proto_lock)
 {
-	BT_DBG("conn %p", conn);
+	BT_DBG("hcon %p sk %p mtu %d", hcon, sk, (int)hcon->mtu);
 
-	sco_pi(sk)->conn = conn;
-	conn->sk = sk;
+	/* If parent, sk is not yet visible to user tasks, so no sk lock needed.
+	 */
+	lockdep_assert(parent || lockdep_sock_is_held(sk));
+	lockdep_assert_held(&hcon->hdev->lock);
+	lockdep_assert_held(&hcon->proto_lock);
+
+	if (hcon->mtu > 0)
+		sco_pi(sk)->mtu = hcon->mtu;
+	else
+		sco_pi(sk)->mtu = 60;
+
+	sock_set_flag(sk, SOCK_RCU_FREE);
+
+	sco_pi(sk)->hcon = hci_conn_hold(hcon);
+	rcu_assign_pointer(hcon->sco_data, sk);
 
 	if (parent)
 		bt_accept_enqueue(parent, sk, true);
 }
 
-static int sco_chan_add(struct sco_conn *conn, struct sock *sk,
+static int sco_chan_add(struct hci_conn *hcon, struct sock *sk,
 			struct sock *parent)
+	__must_hold(&hcon->hdev->lock)
 {
 	int err = 0;
 
-	sco_conn_lock(conn);
-	if (conn->sk || sco_pi(sk)->conn)
+	spin_lock(&hcon->proto_lock);
+
+	if (__sco_peek_sk(hcon) || sco_pi(sk)->hcon)
 		err = -EBUSY;
 	else
-		__sco_chan_add(conn, sk, parent);
+		__sco_chan_add(hcon, sk, parent);
+
+	spin_unlock(&hcon->proto_lock);
 
-	sco_conn_unlock(conn);
 	return err;
 }
 
 static int sco_connect(struct sock *sk)
 {
-	struct sco_conn *conn;
 	struct hci_conn *hcon;
 	struct hci_dev  *hdev;
 	int err, type;
@@ -344,13 +268,6 @@ static int sco_connect(struct sock *sk)
 		goto unlock;
 	}
 
-	conn = sco_conn_add(hcon);
-	if (!conn) {
-		hci_conn_drop(hcon);
-		err = -ENOMEM;
-		goto unlock;
-	}
-
 	lock_sock(sk);
 
 	/* Recheck state after reacquiring the socket lock, as another
@@ -363,10 +280,12 @@ static int sco_connect(struct sock *sk)
 		goto unlock;
 	}
 
-	err = sco_chan_add(conn, sk, NULL);
+	lockdep_assert_held(&hcon->hdev->lock);
+
+	err = sco_chan_add(hcon, sk, NULL);
+	hci_conn_drop(hcon);
 	if (err) {
 		release_sock(sk);
-		hci_conn_drop(hcon);
 		goto unlock;
 	}
 
@@ -392,44 +311,35 @@ static int sco_connect(struct sock *sk)
 static int sco_send_frame(struct sock *sk, struct sk_buff *skb,
 			  const struct sockcm_cookie *sockc)
 {
-	struct sco_conn *conn = sco_pi(sk)->conn;
+	struct hci_conn *hcon = sco_sk_hcon(sk);
 	int len = skb->len;
 
 	/* Check outgoing MTU */
-	if (len > conn->mtu)
+	if (len > sco_pi(sk)->mtu)
 		return -EINVAL;
+	if (!hcon)
+		return -ENOTCONN;
 
 	BT_DBG("sk %p len %d", sk, len);
 
 	hci_setup_tx_timestamp(skb, 1, sockc);
-	hci_send_sco(conn->hcon, skb);
+	hci_send_sco(hcon, skb);
 
 	return len;
 }
 
-static void sco_recv_frame(struct sco_conn *conn, struct sk_buff *skb)
+static void sco_recv_frame(struct sock *sk, struct sk_buff *skb)
 {
-	struct sock *sk;
-
-	sco_conn_lock(conn);
-	sk = sco_sock_hold(conn);
-	sco_conn_unlock(conn);
-
-	if (!sk)
-		goto drop;
-
 	BT_DBG("sk %p len %u", sk, skb->len);
 
-	if (sk->sk_state != BT_CONNECTED)
-		goto drop_put;
+	/* NOTE: sk not locked */
 
-	if (!sock_queue_rcv_skb(sk, skb)) {
-		sock_put(sk);
+	if (READ_ONCE(sk->sk_state) != BT_CONNECTED)
+		goto drop;
+
+	if (!sock_queue_rcv_skb(sk, skb))
 		return;
-	}
 
-drop_put:
-	sock_put(sk);
 drop:
 	kfree_skb(skb);
 }
@@ -472,16 +382,20 @@ static struct sock *sco_get_sock_listen(bdaddr_t *src)
 			sk1 = sk;
 	}
 
+	sk = sk ? sk : sk1;
+	if (sk)
+		sock_hold(sk);
+
 	read_unlock(&sco_sk_list.lock);
 
-	return sk ? sk : sk1;
+	return sk;
 }
 
 static void sco_sock_destruct(struct sock *sk)
 {
 	BT_DBG("sk %p", sk);
 
-	sco_conn_put(sco_pi(sk)->conn);
+	WARN_ON(sco_pi(sk)->hcon);
 
 	skb_queue_purge(&sk->sk_receive_queue);
 	skb_queue_purge(&sk->sk_write_queue);
@@ -514,12 +428,11 @@ static void sco_sock_kill(struct sock *sk)
 
 	BT_DBG("sk %p state %d", sk, sk->sk_state);
 
-	/* Sock is dead, so set conn->sk to NULL to avoid possible UAF */
-	if (sco_pi(sk)->conn) {
-		sco_conn_lock(sco_pi(sk)->conn);
-		sco_pi(sk)->conn->sk = NULL;
-		sco_conn_unlock(sco_pi(sk)->conn);
-	}
+	disable_delayed_work_sync(&sco_pi(sk)->timeout_work);
+
+	lock_sock(sk);
+	sco_sk_detach(sk);
+	release_sock(sk);
 
 	/* Kill poor orphan */
 	bt_sock_unlink(&sco_sk_list, sk);
@@ -595,6 +508,8 @@ static struct sock *sco_sock_alloc(struct net *net, struct socket *sock,
 	sco_pi(sk)->codec.vid = 0xffff;
 	sco_pi(sk)->codec.data_path = 0x00;
 
+	INIT_DELAYED_WORK(&sco_pi(sk)->timeout_work, sco_sock_timeout);
+
 	bt_sock_link(&sco_sk_list, sk);
 	return sk;
 }
@@ -905,7 +820,6 @@ static int sco_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 			    size_t len, int flags)
 {
 	struct sock *sk = sock->sk;
-	struct sco_pinfo *pi = sco_pi(sk);
 
 	if (unlikely(flags & MSG_ERRQUEUE))
 		return sock_recv_errqueue(sk, msg, len, SOL_BLUETOOTH,
@@ -914,8 +828,9 @@ static int sco_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 	lock_sock(sk);
 
 	if (sk->sk_state == BT_CONNECT2 &&
-	    test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags)) {
-		sco_conn_defer_accept(pi->conn->hcon, pi->setting);
+	    test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags) &&
+	    sco_sk_hcon(sk)) {
+		sco_conn_defer_accept(sco_sk_hcon(sk), sco_pi(sk)->setting);
 		sk->sk_state = BT_CONFIG;
 
 		release_sock(sk);
@@ -1090,7 +1005,7 @@ static int sco_sock_getsockopt_old(struct socket *sock, int optname,
 			break;
 		}
 
-		opts.mtu = sco_pi(sk)->conn->mtu;
+		opts.mtu = sco_pi(sk)->mtu;
 
 		BT_DBG("mtu %u", opts.mtu);
 
@@ -1108,9 +1023,14 @@ static int sco_sock_getsockopt_old(struct socket *sock, int optname,
 			break;
 		}
 
+		if (!sco_sk_hcon(sk)) {
+			err = -ENOTCONN;
+			break;
+		}
+
 		memset(&cinfo, 0, sizeof(cinfo));
-		cinfo.hci_handle = sco_pi(sk)->conn->hcon->handle;
-		memcpy(cinfo.dev_class, sco_pi(sk)->conn->hcon->dev_class, 3);
+		cinfo.hci_handle = sco_sk_hcon(sk)->handle;
+		memcpy(cinfo.dev_class, sco_sk_hcon(sk)->dev_class, 3);
 
 		len = min(len, sizeof(cinfo));
 		if (copy_to_user(optval, (char *)&cinfo, len))
@@ -1175,12 +1095,12 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case BT_PHY:
-		if (sk->sk_state != BT_CONNECTED) {
+		if (sk->sk_state != BT_CONNECTED || !sco_sk_hcon(sk)) {
 			err = -ENOTCONN;
 			break;
 		}
 
-		phys = hci_conn_get_phy(sco_pi(sk)->conn->hcon);
+		phys = hci_conn_get_phy(sco_sk_hcon(sk));
 
 		if (put_user(phys, (u32 __user *) optval))
 			err = -EFAULT;
@@ -1199,7 +1119,7 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		if (put_user(sco_pi(sk)->conn->mtu, (u32 __user *)optval))
+		if (put_user(sco_pi(sk)->mtu, (u32 __user *)optval))
 			err = -EFAULT;
 		break;
 
@@ -1363,51 +1283,46 @@ static int sco_sock_release(struct socket *sock)
 	return err;
 }
 
-static void sco_conn_ready(struct sco_conn *conn)
+static void sco_conn_ready(struct hci_conn *hcon)
 {
 	struct sock *parent;
-	struct sock *sk = conn->sk;
+	struct sock *sk;
 
-	BT_DBG("conn %p", conn);
+	lockdep_assert_held(&hcon->hdev->lock);
+
+	sk = sco_get_sk(hcon);
+
+	BT_DBG("hcon %p sk %p", hcon, sk);
 
 	if (sk) {
-		lock_sock(sk);
 		sco_sock_clear_timer(sk);
 		sk->sk_state = BT_CONNECTED;
 		sk->sk_state_change(sk);
 		release_sock(sk);
+		sock_put(sk);
 	} else {
-		sco_conn_lock(conn);
-
-		if (!conn->hcon) {
-			sco_conn_unlock(conn);
+		parent = sco_get_sock_listen(&hcon->src);
+		if (!parent)
 			return;
-		}
-
-		parent = sco_get_sock_listen(&conn->hcon->src);
-		if (!parent) {
-			sco_conn_unlock(conn);
-			return;
-		}
 
 		lock_sock(parent);
 
+		spin_lock(&hcon->proto_lock);
+
+		if (parent->sk_state != BT_LISTEN || __sco_peek_sk(hcon))
+			goto release;
+
 		sk = sco_sock_alloc(sock_net(parent), NULL,
 				    BTPROTO_SCO, GFP_ATOMIC, 0);
-		if (!sk) {
-			release_sock(parent);
-			sco_conn_unlock(conn);
-			return;
-		}
+		if (!sk)
+			goto release;
 
 		sco_sock_init(sk, parent);
 
-		bacpy(&sco_pi(sk)->src, &conn->hcon->src);
-		bacpy(&sco_pi(sk)->dst, &conn->hcon->dst);
+		bacpy(&sco_pi(sk)->src, &hcon->src);
+		bacpy(&sco_pi(sk)->dst, &hcon->dst);
 
-		sco_conn_hold(conn);
-		hci_conn_hold(conn->hcon);
-		__sco_chan_add(conn, sk, parent);
+		__sco_chan_add(hcon, sk, parent);
 
 		if (test_bit(BT_SK_DEFER_SETUP, &bt_sk(parent)->flags))
 			sk->sk_state = BT_CONNECT2;
@@ -1417,9 +1332,10 @@ static void sco_conn_ready(struct sco_conn *conn)
 		/* Wake up parent */
 		parent->sk_data_ready(parent);
 
+release:
+		spin_unlock(&hcon->proto_lock);
 		release_sock(parent);
-
-		sco_conn_unlock(conn);
+		sock_put(parent);
 	}
 }
 
@@ -1452,26 +1368,26 @@ int sco_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 }
 
 static void sco_connect_cfm(struct hci_conn *hcon, __u8 status)
+	__must_hold(&hcon->hdev->lock)
 {
+	lockdep_assert_held(&hcon->hdev->lock);
+
 	if (hcon->type != SCO_LINK && hcon->type != ESCO_LINK)
 		return;
 
 	BT_DBG("hcon %p bdaddr %pMR status %u", hcon, &hcon->dst, status);
 
-	if (!status) {
-		struct sco_conn *conn;
-
-		conn = sco_conn_add(hcon);
-		if (conn) {
-			sco_conn_ready(conn);
-			sco_conn_put(conn);
-		}
-	} else
+	if (!status)
+		sco_conn_ready(hcon);
+	else
 		sco_conn_del(hcon, bt_to_errno(status));
 }
 
 static void sco_disconn_cfm(struct hci_conn *hcon, __u8 reason)
+	__must_hold(&hcon->hdev->lock)
 {
+	lockdep_assert_held(&hcon->hdev->lock);
+
 	if (hcon->type != SCO_LINK && hcon->type != ESCO_LINK)
 		return;
 
@@ -1483,35 +1399,35 @@ static void sco_disconn_cfm(struct hci_conn *hcon, __u8 reason)
 int sco_recv_scodata(struct hci_dev *hdev, u16 handle, struct sk_buff *skb)
 {
 	struct hci_conn *hcon;
-	struct sco_conn *conn;
+	struct sock *sk;
 
-	hci_dev_lock(hdev);
+	rcu_read_lock();
 
 	hcon = hci_conn_hash_lookup_handle(hdev, handle);
 	if (!hcon) {
-		hci_dev_unlock(hdev);
+		rcu_read_unlock();
 		kfree_skb(skb);
 		return -ENOENT;
 	}
 
-	conn = sco_conn_hold_unless_zero(hcon->sco_data);
+	sk = __sco_get_sk(hcon);
 	hcon = NULL;
 
-	hci_dev_unlock(hdev);
+	rcu_read_unlock();
 
-	if (!conn) {
+	if (!sk) {
 		kfree_skb(skb);
 		return -EINVAL;
 	}
 
-	BT_DBG("conn %p len %u", conn, skb->len);
+	BT_DBG("sk %p len %u", sk, skb->len);
 
 	if (skb->len)
-		sco_recv_frame(conn, skb);
+		sco_recv_frame(sk, skb);
 	else
 		kfree_skb(skb);
 
-	sco_conn_put(conn);
+	sock_put(sk);
 	return 0;
 }
 
-- 
2.53.0

