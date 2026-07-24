Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5104F34A79D;
	Fri, 24 Jul 2026 20:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784924462; cv=pass; b=T9ZN2GjY0OtIw1Ahs4eBriJmwq+U43X2sZlDNgiFexsYku3xpFIrEbo0pH+D7DT5S3JySjzwKpE5EcqaEz3sFi31r0fIEPD7fybEUqHV1JtrmyljY1UcTARzbI7/nNzmG06NdKoNo0ZheEDGCMfEjT45PdQ5zj4cVI1k7pYBOWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784924462; c=relaxed/simple;
	bh=KGw37HWimL8GUMlYoC9NuI8Ufw9+0fiDugoW2aTDOoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XkXTSNQGcLh6hB5YqIWuJD3zT3YDfVyFuT9JmTBXhnh6Ue3ybwWsN4baoPMUywc5AgWXYo+JRoNBObfFFTxeXe0KaPgIVuB0sqgkQ4kh/tGkyjJOXqi9MeLMxJ1bxZXKeWW6itatgBDrzwot2UhfoLxXffkihsnlDeFquBy6dUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=l+cxu3Ry; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="l+cxu3Ry"
Received: from monolith.lan (unknown [89.37.63.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4h6KBG1mPJzyVm;
	Fri, 24 Jul 2026 23:20:54 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1784924455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IlKQ1ZC+1xVz0L955RIT5f4Q8s4F3vKgafHXx6cqrzQ=;
	b=l+cxu3Ry5o3mWEmGnKSIq3eMfE4J3KdCUOnBJj9h1lHgNrQTHr48ulYxx4a/KHgpL3XO3n
	GpEQNFQMY3rSYjQZMt5LWoFYIU6lZMtUTVfSxhg6p4Sqn/0oxblwNp1hekzT0UEl8rDdl5
	iORm6J4kuBNEUiHvpL7ti0JIG8S4lAM=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1784924455;
	b=XLV+2zMkR1ZCWAunLM7euQlgTcpHNjYjpwm85Yi4HPo+EqTFFn0qjtB9IMWxkGoZNxUVzx
	aDrw8sceupTrM404/yfgYX6jn82EL9XyzS+IW7VnDBG1isr5lqYA2jQoPqTworDvPu9Xf6
	5PShS9ULu+JJQH6LaSMfmYe3q+xaN6k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1784924455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IlKQ1ZC+1xVz0L955RIT5f4Q8s4F3vKgafHXx6cqrzQ=;
	b=Hgjwsq6mACrRfmppmSG2ejTGWEPXqhcXUQOkjA6huQa15hprzrWIeSd+0qwFzKmF9XmljP
	rCcdlkisReYG7onCXN6urmlBB4/HAUA1pvUULV5U0pCZBI1I/zlL2Z1e94YBHTkb5BNI0C
	ricqKMELAJ6OxQINQ8IEIpAq+CVtvAw=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/11] Bluetooth: ISO: avoid deadlocks in iso_sock_timeout
Date: Fri, 24 Jul 2026 23:20:31 +0300
Message-ID: <47bac9e8d5b1bd7335a93ae5b834ac7065820b7c.1784923689.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1784923689.git.pav@iki.fi>
References: <cover.1784923689.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iso_sock_timeout() takes lock_sock, so sync disabling the timer while
holding that lock may deadlock.

iso_sock_timeout() may also run concurrently with iso_conn_del(), which
leads to UAF

        [Task 1]                      [Task hdev->workqueue]
        iso_sock_timeout              iso_conn_del
          iso_conn_hold_unless_zero     iso_chan_del
                           `------------> iso_conn_put
                                      caller frees hcon
          iso_conn_put
            iso_conn_free
              conn->hcon->iso_data = NULL; /* UAF */

Fix the deadlock by removing the disable from the lock_sock sections.
Move the timer from iso_conn to iso_pinfo to decouple it from iso_conn
which may need to be freed in lock_sock section. Convert some of the
clear_timer to disable_timer.

Fixes: dc26097bdb86 ("Bluetooth: ISO: Use kref to track lifetime of iso_conn")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/iso.c | 60 ++++++++++++++++++++++-----------------------
 1 file changed, 29 insertions(+), 31 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 5f0f45a573a7..0cc08416fde5 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -37,8 +37,6 @@ struct iso_conn {
 	spinlock_t	lock;
 	struct sock	*sk;
 
-	struct delayed_work	timeout_work;
-
 	struct sk_buff	*rx_skb;
 	__u32		rx_len;
 	__u16		tx_sn;
@@ -81,6 +79,7 @@ struct iso_pinfo {
 	__u8			base_len;
 	__u8			base[BASE_MAX_LENGTH];
 	struct iso_conn		*conn;
+	struct delayed_work	timeout_work;
 };
 
 static struct bt_iso_qos default_qos;
@@ -118,9 +117,6 @@ static void iso_conn_free(struct kref *ref)
 			hci_conn_drop(conn->hcon);
 	}
 
-	/* Ensure no more work items will run since hci_conn has been dropped */
-	disable_delayed_work_sync(&conn->timeout_work);
-
 	kfree_skb(conn->rx_skb);
 
 	kfree(conn);
@@ -161,48 +157,45 @@ static struct sock *iso_sock_hold(struct iso_conn *conn)
 
 static void iso_sock_timeout(struct work_struct *work)
 {
-	struct iso_conn *conn = container_of(work, struct iso_conn,
-					     timeout_work.work);
-	struct sock *sk;
-
-	conn = iso_conn_hold_unless_zero(conn);
-	if (!conn)
-		return;
-
-	iso_conn_lock(conn);
-	sk = iso_sock_hold(conn);
-	iso_conn_unlock(conn);
-	iso_conn_put(conn);
-
-	if (!sk)
-		return;
+	struct iso_pinfo *pi = container_of(work, struct iso_pinfo,
+					    timeout_work.work);
+	struct sock *sk = &pi->bt.sk;
 
 	BT_DBG("sock %p state %d", sk, sk->sk_state);
 
 	lock_sock(sk);
-	sk->sk_err = ETIMEDOUT;
-	sk->sk_state_change(sk);
+	if (!sock_flag(sk, SOCK_ZAPPED)) {
+		sk->sk_err = ETIMEDOUT;
+		sk->sk_state_change(sk);
+	}
 	release_sock(sk);
-	sock_put(sk);
 }
 
 static void iso_sock_set_timer(struct sock *sk, long timeout)
 {
+	lockdep_assert(lockdep_sock_is_held(sk));
+
+	cancel_delayed_work(&iso_pi(sk)->timeout_work);
+
 	if (!iso_pi(sk)->conn)
 		return;
 
 	BT_DBG("sock %p state %d timeout %ld", sk, sk->sk_state, timeout);
-	cancel_delayed_work(&iso_pi(sk)->conn->timeout_work);
-	schedule_delayed_work(&iso_pi(sk)->conn->timeout_work, timeout);
+	schedule_delayed_work(&iso_pi(sk)->timeout_work, timeout);
 }
 
 static void iso_sock_clear_timer(struct sock *sk)
 {
-	if (!iso_pi(sk)->conn)
-		return;
+	BT_DBG("sock %p state %d", sk, sk->sk_state);
+	cancel_delayed_work(&iso_pi(sk)->timeout_work);
+}
+
+static void iso_sock_disable_timer(struct sock *sk)
+{
+	lockdep_assert(!lockdep_sock_is_held(sk));
 
 	BT_DBG("sock %p state %d", sk, sk->sk_state);
-	cancel_delayed_work(&iso_pi(sk)->conn->timeout_work);
+	disable_delayed_work_sync(&iso_pi(sk)->timeout_work);
 }
 
 /* ---- ISO connections ---- */
@@ -227,7 +220,6 @@ static struct iso_conn *iso_conn_add(struct hci_conn *hcon)
 
 	kref_init(&conn->ref);
 	spin_lock_init(&conn->lock);
-	INIT_DELAYED_WORK(&conn->timeout_work, iso_sock_timeout);
 
 	hcon->iso_data = conn;
 	conn->hcon = hcon;
@@ -292,8 +284,9 @@ static void iso_conn_del(struct hci_conn *hcon, int err)
 		return;
 	}
 
+	iso_sock_disable_timer(sk);
+
 	lock_sock(sk);
-	iso_sock_clear_timer(sk);
 	iso_chan_del(sk, err);
 	release_sock(sk);
 	iso_sock_kill(sk);
@@ -800,6 +793,8 @@ static void iso_sock_cleanup_listen(struct sock *parent)
  */
 static void iso_sock_kill(struct sock *sk)
 {
+	iso_sock_disable_timer(sk);
+
 	lock_sock(sk);
 
 	if (!sock_flag(sk, SOCK_ZAPPED) || sk->sk_socket ||
@@ -895,8 +890,9 @@ static void __iso_sock_close(struct sock *sk)
 /* Must be called on unlocked socket. */
 static void iso_sock_close(struct sock *sk)
 {
+	iso_sock_disable_timer(sk);
+
 	lock_sock(sk);
-	iso_sock_clear_timer(sk);
 	__iso_sock_close(sk);
 	release_sock(sk);
 }
@@ -965,6 +961,8 @@ static struct sock *iso_sock_alloc(struct net *net, struct socket *sock,
 	iso_pi(sk)->qos = default_qos;
 	iso_pi(sk)->sync_handle = -1;
 
+	INIT_DELAYED_WORK(&iso_pi(sk)->timeout_work, iso_sock_timeout);
+
 	bt_sock_link(&iso_sk_list, sk);
 	return sk;
 }
-- 
2.55.0

