Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D253B2FC2;
	Fri, 24 Jul 2026 20:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784924460; cv=pass; b=YtKG97UQhd8nmIz6e8pbHeHvse/kVdVQf5UOqcGakSFaiVq4I7TJIm09GrSzTfJRZtl0/czf2pexqNcATMQP/c5PMNTAzmNGjTvuP0rWkD7caGs046TgUGzVDwC4uAB5olveWuIMW6cPQW6ezyZVo1MRBNFB/hPNgLB6sA6/uGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784924460; c=relaxed/simple;
	bh=IUfhJibQ8PWq8wEjiUFCy9u1EK09x/sH8c2uAMr8SDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RoVJtcmm6PqE5Za4IZEAbhnVX5o27W1y+ebYVfpGwvohqws3q3iT9rpQxqWKux4vvmfOOO44AeS+kqj2KPXmZLRBwtX22G/eKFTdnd6zEeHglGObaOhwMh3aHNhpx+0Ku5san+apS/uRr92ny2vJiUib6oOjA8NpLsgXgbe9vyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=AjgA1zzh; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="AjgA1zzh"
Received: from monolith.lan (unknown [89.37.63.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4h6KBB5V61zyc2;
	Fri, 24 Jul 2026 23:20:50 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1784924452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yg6adg4D1+AWwokr1LUf/baS+b9XSlEzwrPbVKcgDns=;
	b=AjgA1zzhPuA4M03XL76MoFJQ044LJzL+KKwE4kXUzFERh31ox9mmSUP9szJaP4VVcD0iez
	tPHeIYrk+EHJIyRie4DuExZAyiKANXo/lIIt4iYaqqdbPwMzjPdDmoPKHI/icR9VWdgVee
	tb7sqikeLjtiRq6ePTSw7iq50cnPrnQ=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1784924452;
	b=queE09pQMIRIR6ubPwx/0SBh/jqWq3yfxIXoJ6xqvI+KWGgnkZ32TsvDsLTBgYBoggBpbq
	AT4AJfkX61ZC3KQeNaLTJOUo17hVs28aFVSpMbatNEiYkbok5x+ab339011IGj3GwfYIYE
	xI6K1tN9fFi6CcnJxqCGBkrTihWbQB0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1784924452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yg6adg4D1+AWwokr1LUf/baS+b9XSlEzwrPbVKcgDns=;
	b=SnPf+lxIpraiJZhBrHdG7QYgAssONmH08EbOvcZJuAAzgPpMiRNz/yUn3aXUWWz4vlUFPY
	YAnOZnj3aq1Hy71YK1laExAw8tizFPyCgERtfmtQRf7XS+F3sxnwK5SrJbAFi18EAah5QJ
	bpck5pAoBcIA86Hm9HbRzyw5/Dl05P8=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 06/11] Bluetooth: ISO: hold sk properly in iso_conn_ready
Date: Fri, 24 Jul 2026 23:20:29 +0300
Message-ID: <6ce88b5e06ebc89e5e848ea3deb150e03805f2fd.1784923689.git.pav@iki.fi>
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

sk deref in iso_conn_ready must be done either under conn->lock, or
holding a refcount, to avoid concurrent close. conn->sk is currently
accessed without either:

    [Task 1]            [Task 2]
                        iso_sock_release
    iso_conn_ready
      sk = conn->sk
                          lock_sock(sk)
                            conn->sk = NULL
      lock_sock(sk)
                          release_sock(sk)
                          iso_sock_kill(sk)
       UAF on sk deref

Fix possible UAF by holding sk refcount in iso_conn_ready().  Also
recheck after lock_sock that the socket is still valid.  Adjust locking
so conn->sk is cleared only under lock_sock.

Fixes: 27c24fda62b60 ("Bluetooth: switch to lock_sock in SCO")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/iso.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 5de4a2f886eb..80a58275891d 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -805,11 +805,13 @@ static void iso_sock_kill(struct sock *sk)
 	BT_DBG("sk %p state %d", sk, sk->sk_state);
 
 	/* Sock is dead, so set conn->sk to NULL to avoid possible UAF */
+	lock_sock(sk);
 	if (iso_pi(sk)->conn) {
 		iso_conn_lock(iso_pi(sk)->conn);
 		iso_pi(sk)->conn->sk = NULL;
 		iso_conn_unlock(iso_pi(sk)->conn);
 	}
+	release_sock(sk);
 
 	/* Kill poor orphan */
 	bt_sock_unlink(&iso_sk_list, sk);
@@ -2047,23 +2049,17 @@ static void iso_sock_ready(struct sock *sk)
 {
 	BT_DBG("sk %p", sk);
 
-	if (!sk)
-		return;
-
-	lock_sock(sk);
+	lockdep_assert(lockdep_sock_is_held(sk));
 
 	switch (sk->sk_state) {
 	case BT_DISCONN:
 	case BT_CLOSED:
-		release_sock(sk);
 		return;
 	}
 
 	iso_sock_clear_timer(sk);
 	sk->sk_state = BT_CONNECTED;
 	sk->sk_state_change(sk);
-
-	release_sock(sk);
 }
 
 static bool iso_match_big(struct sock *sk, void *data)
@@ -2093,7 +2089,7 @@ static bool iso_match_dst(struct sock *sk, void *data)
 static void iso_conn_ready(struct iso_conn *conn)
 {
 	struct sock *parent = NULL;
-	struct sock *sk = conn->sk;
+	struct sock *sk;
 	struct hci_ev_le_big_sync_established *ev = NULL;
 	struct hci_ev_le_pa_sync_established *ev2 = NULL;
 	struct hci_ev_le_per_adv_report *ev3 = NULL;
@@ -2102,7 +2098,22 @@ static void iso_conn_ready(struct iso_conn *conn)
 
 	BT_DBG("conn %p", conn);
 
+	iso_conn_lock(conn);
+	sk = iso_sock_hold(conn);
+	iso_conn_unlock(conn);
+
 	if (sk) {
+		lock_sock(sk);
+
+		/* conn->sk may have become NULL if racing with sk close, but
+		 * due to held hdev->lock, it can't become different sk.
+		 */
+		if (!conn->sk) {
+			release_sock(sk);
+			sock_put(sk);
+			return;
+		}
+
 		/* Attempt to update source address in case of BIS Sender if
 		 * the advertisement is using a random address.
 		 */
@@ -2115,14 +2126,15 @@ static void iso_conn_ready(struct iso_conn *conn)
 			adv = hci_find_adv_instance(bis->hdev,
 						    bis->iso_qos.bcast.bis);
 			if (adv && bacmp(&adv->random_addr, BDADDR_ANY)) {
-				lock_sock(sk);
 				iso_pi(sk)->src_type = BDADDR_LE_RANDOM;
 				bacpy(&iso_pi(sk)->src, &adv->random_addr);
-				release_sock(sk);
 			}
 		}
 
-		iso_sock_ready(conn->sk);
+		iso_sock_ready(sk);
+
+		release_sock(sk);
+		sock_put(sk);
 	} else {
 		hcon = conn->hcon;
 		if (!hcon)
-- 
2.55.0

