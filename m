Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1B8406261;
	Tue,  1 Sep 2026 21:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788296707; cv=pass; b=gF0peF1ajAOO/Bi7gbuBXq5uZaFVUFUIwMVU8dn3pMsNAO8eM6YqJMQYPdpHGd56iMYzCojJciWCg46WXlIJ/r86/ZJlRFAZ+kEptZUO6aqDRkpKMFOFIBGP7jMs0rS51B2ouEKrRQLLMRE0M9sZhZoyp3hmXa3DXkoACTs70gg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788296707; c=relaxed/simple;
	bh=nUb+Kw11eg4gqQYRw1zJn6IfcxOia+Zh7pODmMOOg4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F45c1wBKE0cblz01eUHmMmw1W3h7VzsbvvvRWss3m04Vj/f/qGTxu71LmWNWLluTL6FY3/oAvjDdfBsyzj/OTXLt19QRH/XlTnK39KOaFUnD4emsUrXgkSTLhbkUmvjVOORuXVLSSHCJ3C1onYSwhvmDAbLrwVwKE5QHMM4Z3Ec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=k5Xv1eZK; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="k5Xv1eZK"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:4:f011::dd01])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hZJK710FczyQn;
	Wed, 02 Sep 2026 00:04:59 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1788296699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pItbY5onH1Vlt47pfP8WyBfdNBB9um1JXokdD+/CiFY=;
	b=k5Xv1eZKyjb6hTAeZjQ33rL0E2g+rkzB7lSs5MYy47XdLfRcuF2msU5DnZtKgpsrrpsId6
	2zDO+V/67ASA4YivwaLgV7FJGG9HcGjvpm7kW79iioIy5znXNF4c00whHZi6VNJ1Vx8Wda
	xjSoTzCFJUNYSD23jsnHHAZ/cbBrhFc=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1788296699;
	b=o/u7SoNQ0j/Jrn7OwepVGQO4fN0cAs88S40qE/kz3Kh9pLtSGvOWp3D4hgFA5BPBhEKqjn
	UFAb0/U+UuZEg1c08wbWGSOkJT4d8jgbmbYU3z3czZc8foTWLHPIbAx/dUmJVtKIJHxL1e
	8SBtdn8Fv/vaEu2ewmRHzxXc0ku7DRw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1788296699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pItbY5onH1Vlt47pfP8WyBfdNBB9um1JXokdD+/CiFY=;
	b=SKznPzmiogRJS3eC06LjMY6e0b9efvqsSuoNViEdhJKcw8mXbu4q3zxPHsQRtOhdFp4y48
	7NyZkMDMH8DZOgpTOG0R2ZLCSCDQQ+j93sDy2k3TLTrlEWHs57WjAHbstyVh5l9aXcJysZ
	ry7opfCSEOCCb27ioHXwFrZPpTOLE3E=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	elver@google.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] Bluetooth: L2CAP: refuse __l2cap_chan_add if chan already has conn
Date: Wed,  2 Sep 2026 00:04:36 +0300
Message-ID: <1e0a04c3e50261e7fa59686ab861819951e90809.1788296635.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1788296635.git.pav@iki.fi>
References: <cover.1788296635.git.pav@iki.fi>
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
index b7d5fa6f6a83..a22edd2baf5e 100644
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
@@ -7623,7 +7627,8 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 		}
 	}
 
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

