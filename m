Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB8A3B2D0A;
	Sat, 29 Aug 2026 14:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788013401; cv=pass; b=JfzLJMpIIRm4EXgpyCAcuoqrtcIZ8sEKfsvkrGGS4x4Mex26/NWBolG6pdS1H73R1IeiG2dK3jR1CHUguBehzGid0Mz+O3aVkFVX6QZJ5OZcYmnvDC+h6vs2ZN4U/R2NJTEGxgR1zT9Z4yxfKJkR3cFCR9KDONKPe6uXDb8TpWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788013401; c=relaxed/simple;
	bh=OlOrHU6Kcyn0daQj6H9bGgE+0JhY5QStHNTKee3VeCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p2+iRgSHqaksdVSYb6866rYw49N2K4hluMEiGggNjr1coi2U9oT6S5KYKNKBpKQGqXSOATI4l7TiTEtDtcjaOtnWH3bp+b0URy4+lbcKhGpfRe9pd6azMHjrEZffLsjQFRef41tvgOorgHhd8Tcnaah6k9+V9UPfNDSwcQOCHTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=Kb+V5Ir/; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="Kb+V5Ir/"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:1:e011::d701])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hXHXx2ZKJzyhS;
	Sat, 29 Aug 2026 17:23:13 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1788013394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hF4A8wUQ9tYT3NtMOI6k9jJyNs1GZ1ugtGxRJQwRLkY=;
	b=Kb+V5Ir/6lSYcc5F4eJXLNqm7mQz/z7XoFSFzT6INqGgN8uan+ee+P/SkgGfPhsXqUZ1Ai
	4Tah4n3NlsOBhG4RHRYcip3kUnmgis6Yt9yKFdNICxVdT6NOLhv5pTAmkkiOwKQPescYvv
	jCgBbqLg3tDSsLpTQnylOp7n84Ms4w8=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1788013394;
	b=TEoG5RGxBnrPdBj1AjSMrtSKKX7lrhsacVTVgWtYMUXIfxHYTQEzgYlMzUWVCzZlF1InWq
	MtDZMADbVmr6xBUh5V+xxfMFZRFvDNRs7raCTNW9CZ4gXlh7WiiCPtXd+fuY7Ugv8H+gv5
	uvBs3Asye3YfuUtvBNhXx8YMndWkEP8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1788013394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hF4A8wUQ9tYT3NtMOI6k9jJyNs1GZ1ugtGxRJQwRLkY=;
	b=Lvx/r0MR9QxTVKJ0F6fnCL7Ji1+49n1pH0ViBRSlxYcgJGI0HBAlxA8YMJSAVavMeHilI5
	Jlvn7tTEKQY1OyUeyycESwJqD4WE1mxhvg+AFkVe3AH2R7bMZmYszBosKu/3i5MC71WBHd
	Qm0a4rBOpVbu8BGt8s30X5c9iFJ2Juw=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	oss@fourdim.xyz,
	error27@gmail.com,
	elver@google.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 16/16] Bluetooth: L2CAP: refuse __l2cap_chan_add if chan already has conn
Date: Sat, 29 Aug 2026 17:20:11 +0300
Message-ID: <12da72b4d0ec8c2bba425d37ebaab0fde0937075.1788013041.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1788013041.git.pav@iki.fi>
References: <cover.1788013041.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

l2cap_chan may be linked to l2cap_conn at most once. This is assumed in
several places, eg l2cap_chan_del cleanup.

There is a TOCTOU race where the invariant is violated:

    [Task 1]                          [Task 2]
    l2cap_chan_connect                l2cap_sock_bind
      l2cap_chan_lock                   lock_sock
      l2cap_state_change                if (sk->sk_state != BT_OPEN)
        chan->state = BT_CONNECT
        l2cap_sock_state_change_cb      chan->state = BT_BOUND
                                        sk->sk_state = BT_BOUND
          lock_sock <------------------ release_sock
          sk->sk_state = BT_CONNECT

l2cap_sock_connect() does not check sk->sk_state, so since chan->state
is now BT_BOUND, subsequent connect() ends up with second
__l2cap_chan_add.

Explicitly document and check the invariant in __l2cap_chan_add with
WARN_ON_ONCE. The only callsite where it could be hit is
l2cap_chan_connect, so add pre-check there to avoid relying on
chan->state. chan->state read/write is not properly guarded currently so
there can be other TOCTOUC problems.

Add l2cap_lock_chan in l2cap_sock_bind() to guard chan->state write.

Fixes: b66774b48dd9 ("Bluetooth: L2CAP: Fix UAF in channel timeout by holding conn ref")
Assisted-by: deepseek-4-flash # finding the race condition
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/l2cap_core.c | 7 ++++++-
 net/bluetooth/l2cap_sock.c | 2 ++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index a4299bc10c2f..a86c154d4a9a 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -623,6 +623,10 @@ void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 	BT_DBG("conn %p, psm 0x%2.2x, dcid 0x%4.4x", conn,
 	       __le16_to_cpu(chan->psm), chan->dcid);
 
+	/* Caller must ensure l2cap_chan is linked to l2cap_conn only once */
+	if (WARN_ON_ONCE(chan->conn || test_bit(FLAG_DEL, &chan->flags)))
+		return;
+
 	conn->disc_reason = HCI_ERROR_REMOTE_USER_TERM;
 
 	chan->conn = l2cap_conn_get(conn);
@@ -7604,7 +7608,8 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 	mutex_lock(&conn->lock);
 	l2cap_chan_lock(chan);
 
-	if (cid && __l2cap_get_chan_by_dcid(conn, cid)) {
+	if ((cid && __l2cap_get_chan_by_dcid(conn, cid)) || chan->conn ||
+	    test_bit(FLAG_DEL, &chan->flags)) {
 		hci_conn_drop(hcon);
 		err = -EBUSY;
 		goto chan_unlock;
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index dee3025f0ec2..278adb05c4c9 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -109,6 +109,7 @@ static int l2cap_sock_bind(struct socket *sock, struct sockaddr_unsized *addr, i
 			return -EINVAL;
 	}
 
+	l2cap_chan_lock(chan);
 	lock_sock(sk);
 
 	if (sk->sk_state != BT_OPEN) {
@@ -174,6 +175,7 @@ static int l2cap_sock_bind(struct socket *sock, struct sockaddr_unsized *addr, i
 
 done:
 	release_sock(sk);
+	l2cap_chan_unlock(chan);
 	return err;
 }
 
-- 
2.55.0

