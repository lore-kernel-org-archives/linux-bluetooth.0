Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBED214812;
	Sat, 29 Aug 2026 14:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788013287; cv=pass; b=ncLlJffHwjF9moWo5Tpz7XHqxUAqyzzPPv1t8YMeLTtiXoHKf39XGxOVBbQpJwcIE2pGQjyw3XsYh4qomB1sbl5t8xXv8zWO3mv2YnjRBZOXxnBsGpU5mpPI9rVHCOIUcXeN+JDbXnofddIx9YJdbSOGGbmerADOvPIcJzUhyzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788013287; c=relaxed/simple;
	bh=mJyWPnf3mukEpytt9jrKB9d88tqOXExoMm5/++P1FOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kgDxac0pvCOT/MkUwBoEzBin+jOIpcQhTgyAXdZ9bzek3eKhO/NLk2bt0nzF5rkAILDJpysHrHLIXruh+ZdLzbzSCTV6jTgnCF2wQglWD+EyUdnvOCnQxXHbnVEBcfI/uHqPoDKNCZtKIDFlGbBnXDsOCxgBVsRXaeqh+jXxFY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=q7leeduz; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="q7leeduz"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:1:e011::d701])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hXHVl2RgpzyhS;
	Sat, 29 Aug 2026 17:21:19 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1788013280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rHOeFN2Nn/zpxM8hYq1DsEbcNGI3ZrDw7lT0DfGxc80=;
	b=q7leeduz5fClqIsIVbwU81UesvzP62F1r9s+T20MXPeZNJtsJI/5IUb3qN/mchxd3kCn8v
	9E8y/Dqt6mZKgYZKYNai7YjDfk/pKGR+JCG6MgSirJLv5JghLIbLfVvtk9zaWVFBSXivv5
	4a4et+E1HtgRCOcwwrsCtFh3HxDMhzc=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1788013280;
	b=clzlIpIMPz3PmTdzOTUA2yVFfNUoBF0s6ni21XZF7yI/IiMafpaCzuvpXmGRCo4s6kL+Ci
	gO+oY5BZ0jrSSPgr6kaMvVesKH+vgwRNnP4Vqm2vbs+v0uk+bk9b68KkiE/Gd6lrv1RQoG
	Q+KwvMrlnR+5gP0g9HakwyKcw1wmGWg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1788013280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rHOeFN2Nn/zpxM8hYq1DsEbcNGI3ZrDw7lT0DfGxc80=;
	b=LL4dpy0GrIjX58ZzjydGZspsBlWrmQMKsQaXY3rkKgoMRyR8ZfSaIvr5i3TPMkWXTzPCqa
	uuhU4b4fWVMY4mxBlMXmycT3quItXaCcyuXCigkD1qj6hFPiFL37Hdk4aZ8/a6sT5ukfx3
	TaaE6DU2t9ATVlz4Brno7lFvEhlAKP0=
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
Subject: [PATCH 07/16] Bluetooth: L2CAP: hold conn->lock for __l2cap_ecred_conn_rsp_defer
Date: Sat, 29 Aug 2026 17:20:02 +0300
Message-ID: <3213ea451b4db947b3333c002ab19678431781eb.1788013041.git.pav@iki.fi>
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

__l2cap_ecred_conn_rsp_defer() > __l2cap_chan_list_id() accesses
conn->chan_l which is guarded by conn->lock. The lock fails to be held
when calling from l2cap_sock.c.

Fix by using l2cap_chan_conn_lock(), and taking the locks in required
order l2cap_conn::lock > l2cap_chan::lock > sk.  Leave fast path with
sk->sk_state precheck.  Move the L2CAP defer handling to
l2cap_sock_defer().

The code should also take l2cap_chan_lock() for sibling channels, but
that needs separate fix due to lock nesting.

Fixes: ab4eedb790ca ("Bluetooth: L2CAP: Fix corrupted list in hci_chan_del")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/l2cap_sock.c | 74 ++++++++++++++++++++++++++------------
 1 file changed, 51 insertions(+), 23 deletions(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 0265b6508682..dee3025f0ec2 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1243,6 +1243,54 @@ static void l2cap_publish_rx_avail(struct l2cap_chan *chan)
 		l2cap_chan_rx_avail(chan, -1);
 }
 
+static int l2cap_sock_defer(struct sock *sk)
+{
+	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
+	bool have_conn;
+	int err = 0;
+
+	/* Fast path check */
+	lock_sock(sk);
+	if (sk->sk_state != BT_CONNECT2) {
+		release_sock(sk);
+		return 0;
+	}
+	release_sock(sk);
+
+	have_conn = l2cap_chan_lock_conn(chan);
+	lock_sock(sk);
+
+	if (sk->sk_state == BT_CONNECT2 && test_bit(BT_SK_DEFER_SETUP,
+						    &bt_sk(sk)->flags)) {
+		err = 1;
+
+		if (!have_conn) {
+			release_sock(sk);
+			err = -ENOTCONN;
+		} else if (chan->mode == L2CAP_MODE_EXT_FLOWCTL) {
+			sk->sk_state = BT_CONNECTED;
+			chan->state = BT_CONNECTED;
+			release_sock(sk);
+			__l2cap_ecred_conn_rsp_defer(chan);
+		} else if (bdaddr_type_is_le(chan->src_type)) {
+			sk->sk_state = BT_CONNECTED;
+			chan->state = BT_CONNECTED;
+			release_sock(sk);
+			__l2cap_le_connect_rsp_defer(chan);
+		} else {
+			sk->sk_state = BT_CONFIG;
+			chan->state = BT_CONFIG;
+			release_sock(sk);
+			__l2cap_connect_rsp_defer(chan);
+		}
+	} else {
+		release_sock(sk);
+	}
+
+	l2cap_chan_unlock_conn(chan, have_conn);
+	return err;
+}
+
 static int l2cap_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 			      size_t len, int flags)
 {
@@ -1254,29 +1302,9 @@ static int l2cap_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 		return sock_recv_errqueue(sk, msg, len, SOL_BLUETOOTH,
 					  BT_SCM_ERROR);
 
-	lock_sock(sk);
-
-	if (sk->sk_state == BT_CONNECT2 && test_bit(BT_SK_DEFER_SETUP,
-						    &bt_sk(sk)->flags)) {
-		if (pi->chan->mode == L2CAP_MODE_EXT_FLOWCTL) {
-			sk->sk_state = BT_CONNECTED;
-			pi->chan->state = BT_CONNECTED;
-			__l2cap_ecred_conn_rsp_defer(pi->chan);
-		} else if (bdaddr_type_is_le(pi->chan->src_type)) {
-			sk->sk_state = BT_CONNECTED;
-			pi->chan->state = BT_CONNECTED;
-			__l2cap_le_connect_rsp_defer(pi->chan);
-		} else {
-			sk->sk_state = BT_CONFIG;
-			pi->chan->state = BT_CONFIG;
-			__l2cap_connect_rsp_defer(pi->chan);
-		}
-
-		err = 0;
-		goto done;
-	}
-
-	release_sock(sk);
+	err = l2cap_sock_defer(sk);
+	if (err)
+		return err < 0 ? err : 0;
 
 	if (sock->type == SOCK_STREAM)
 		err = bt_sock_stream_recvmsg(sock, msg, len, flags);
-- 
2.55.0

