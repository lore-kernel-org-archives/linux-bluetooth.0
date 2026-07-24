Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BAFDF59;
	Fri, 24 Jul 2026 20:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784924462; cv=pass; b=pvsBgzZQjhYys/DWR24cqawXIfVJORjfwvCYl4/o8LSV6tIXmKDljUsNxiD0QYYcma1DxRtQQgZFBz1zITqX/084uSbpYoIoOh502g+7SbrhKq6B8jdre3ilVSOAX0DasxB7n0NB6s2+suFNlyOgBg5t9WsxCR9E/1AuEr55pRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784924462; c=relaxed/simple;
	bh=r1mrQYEbSXOMLLJrXhEjlo+6dNsR+rQfl8Fo8+tRcbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qfki2q4wlAC/AgfcA5d9PwBtF92c+6rzwYv7MGmgElq/G7Nsl7pZB1a37rkmf+lzRalOK8pHnYezCS1YJqHUhjm6c7BMZGAkPtUKRePV3kMH8OCFqBIOeU82pMPs4iYRyB3N6HenBqBVxV5t4UIX255aNs3e+EywPBOI9Fmy3Hk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=EkmrIE4Z; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="EkmrIE4Z"
Received: from monolith.lan (unknown [89.37.63.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4h6KBD4PqgzyQq;
	Fri, 24 Jul 2026 23:20:52 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1784924453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=blpzDVZeHkyB9hZ00OWamntBW35ZDd0tWBbUkewuOfA=;
	b=EkmrIE4Z73O9UrxDIcWnP/AEBlm7VCXPcixhYJCSjEwTtCjp0BilxyqJQ/NQ1MKwQDOJtR
	kXM0h2hbYZlHnnkzkq0wnLwmVqGaNUynyF5utTh/gvQAN0z0lqiMCDQnENB55oKrgwMgFW
	J9cX+oNaQdhQXl/UFPW3WrdGBuNCfMQ=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1784924453;
	b=bwNu9+sIPmRHLluJwDecwkmdT7m4cddXen05MyUv47lghpHWgTKSkx0PmmdHyEufiUut+V
	IaDq0PMas9Aqsk0+pNi0ceQ+5A3puj4Fyn0ZHTQcHW5C9W/vQsGE6cF2vaSC75H5GYU/A9
	Ni3SrzEvwrFwUAxY7di8hF96T/gfiEk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1784924453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=blpzDVZeHkyB9hZ00OWamntBW35ZDd0tWBbUkewuOfA=;
	b=a5QFZAkrw9mrd4tSEBAmBUhVtFZElela4xx1VAmgaRCv3Qcy75SPN+/CgjHY4u/Q/4LtKZ
	/iIWFUt40fA+EVb1E/0ooDoq+kT/yd/rzroPwOp4J2sWJQr92D/y/sfTHWfzGJl+M7ozb2
	7JWJ3o4AGqTHW8oW4vUqLT3cwepgoI0=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 07/11] Bluetooth: ISO: fix leaking sk after socket release
Date: Fri, 24 Jul 2026 23:20:30 +0300
Message-ID: <f5cb2f1c158f50f91f613e9c7646673673da60ba.1784923689.git.pav@iki.fi>
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

iso_sock_kill() tests !sock_flag(sk, SOCK_ZAPPED) || sk->sk_socket ||
sock_flag(sk, SOCK_DEAD) for early return, but this is always true since
sock_orphan(sk) sets SOCK_DEAD, so the sk reference released by socket
always leaks, iso_sock_destruct is never called.

The socket reference also leaks when __iso_sock_close() does not set
SOCK_ZAPPED, since iso_conn_del() does not call iso_sock_kill() after
zapping.

Fix by replacing SOCK_DEAD by BT_SK_KILLED flag that is not used for
something else, and lock_sock to ensure iso_sock_kill() puts sk only
after socket release only once. Release and iso_conn_del may run
concurrently. Call iso_sock_kill() from iso_conn_del() to clean sk up
after zapping.

Remove call to iso_sock_kill() from iso_sock_close(), as it's generally
no-op there.

Fixes: ccf74f2390d6 ("Bluetooth: Add BTPROTO_ISO socket type")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/iso.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 80a58275891d..5f0f45a573a7 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -62,6 +62,7 @@ static void iso_sock_kill(struct sock *sk);
 enum {
 	BT_SK_BIG_SYNC,
 	BT_SK_PA_SYNC,
+	BT_SK_KILLED,
 };
 
 struct iso_pinfo {
@@ -295,6 +296,7 @@ static void iso_conn_del(struct hci_conn *hcon, int err)
 	iso_sock_clear_timer(sk);
 	iso_chan_del(sk, err);
 	release_sock(sk);
+	iso_sock_kill(sk);
 	sock_put(sk);
 }
 
@@ -798,24 +800,29 @@ static void iso_sock_cleanup_listen(struct sock *parent)
  */
 static void iso_sock_kill(struct sock *sk)
 {
+	lock_sock(sk);
+
 	if (!sock_flag(sk, SOCK_ZAPPED) || sk->sk_socket ||
-	    sock_flag(sk, SOCK_DEAD))
+	    test_bit(BT_SK_KILLED, &iso_pi(sk)->flags)) {
+		release_sock(sk);
 		return;
+	}
 
 	BT_DBG("sk %p state %d", sk, sk->sk_state);
 
 	/* Sock is dead, so set conn->sk to NULL to avoid possible UAF */
-	lock_sock(sk);
 	if (iso_pi(sk)->conn) {
 		iso_conn_lock(iso_pi(sk)->conn);
 		iso_pi(sk)->conn->sk = NULL;
 		iso_conn_unlock(iso_pi(sk)->conn);
 	}
-	release_sock(sk);
 
 	/* Kill poor orphan */
 	bt_sock_unlink(&iso_sk_list, sk);
 	sock_set_flag(sk, SOCK_DEAD);
+	set_bit(BT_SK_KILLED, &iso_pi(sk)->flags);
+
+	release_sock(sk);
 	sock_put(sk);
 }
 
@@ -892,7 +899,6 @@ static void iso_sock_close(struct sock *sk)
 	iso_sock_clear_timer(sk);
 	__iso_sock_close(sk);
 	release_sock(sk);
-	iso_sock_kill(sk);
 }
 
 static void iso_sock_init(struct sock *sk, struct sock *parent)
@@ -2040,8 +2046,16 @@ static int iso_sock_release(struct socket *sock)
 		release_sock(sk);
 	}
 
+	/* Make sure sk is valid even if iso_conn_del() is concurrent */
+	sock_hold(sk);
+
+	lock_sock(sk);
 	sock_orphan(sk);
+	release_sock(sk);
+
 	iso_sock_kill(sk);
+
+	sock_put(sk);
 	return err;
 }
 
-- 
2.55.0

