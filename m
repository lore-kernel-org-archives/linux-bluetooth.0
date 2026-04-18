Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE45142E83
	for <linux-bluetooth@vger.kernel.org>; Sat, 18 Apr 2026 15:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776526899; cv=pass; b=W3WCF6T/ptRzpgbIbH1idzbb9mUD4irbmuqEMAhQzvb0zR8K7xliegDJJvRIXknbn+S0l5Bzg/x9pd2bBjeVKbJnLBWjwhb6sTCt49+rxeN85QbC5SldcJivZiUCv+BzDtf4TsJC6Ooa9AZbfSLQZLBwyzRWeApE/RK8C/FOrjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776526899; c=relaxed/simple;
	bh=wANRfH2hQUc0xMaQOlZy4mfqIug0+YDHz/BQOVzyxxs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HKDeYD6PF7ToQ0fgtYMoG+oVeFuA8rkevtJvZwBExpKBS+uLAYSSWJcSIoqh6IpRF2pwxAnwaetModUx+/44Ga9Z5kR+d8twF/W3kJPCF/UJsamFczOS9JPNrrLdOuvvjoBu9Eiy7ylG4WzFZBVAhchsPK7/0vBujeeM2lbT2tU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=U4c44Ox8; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="U4c44Ox8"
Received: from monolith (unknown [185.65.133.164])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4fybZg4zTgz49PyQ;
	Sat, 18 Apr 2026 18:41:31 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1776526891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qn93VwOBVZZIgQWp9Cdd9d0NMTBm1nYJsF/UM5nSxkA=;
	b=U4c44Ox8GjNje3Z73heYs/u0vOYSJ5DLdFHZJXszRQDxyCpW8jPd3ZqOTKNikaGNQVSROD
	ZCOgdF//c4BZ3L9M6bWrNS/V9/KUAHA09GdrRvAOgnZPAwWOAxsh1Ee1zIsdOuHkqMSR7/
	xhywf1fjXkVj9RjpuOMpTizvXymPpXfpuDS4A4s5udUuMGHxHBKXcd8liNeCRnFzEGlIDd
	Y6UZA/V6zZyfw8rbWEduuwWODkp2AOcn4po0hEfy0vEv4QfkE5yla2uZ2E4oKo+lGtQMEv
	ADOXCm+rpByrQl8iRopUVB2xk8Pqq7EQeck6WXxzxXPjJ2krLcrjtPt6l3Sgmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1776526891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qn93VwOBVZZIgQWp9Cdd9d0NMTBm1nYJsF/UM5nSxkA=;
	b=WtXPUrT7Hqumw8D7JLiC6N40RpRTem95GfXzwepGIpsvJrdYJ6NOFUQWwkWbuHG0l0EbGC
	hVnwOgpaQvnICtgAtATzZvxLFOzkepXf8C1zTAr3sXQ2gU/yXYN21YfntEveDSZVtGr6QX
	UCA/Z2maB8DQbM+safU8pHXm4SviAwPPZypByeB3XUhd3rRiN1ibczWauDDoI7ggf9BdIl
	h1No0ddr8NlVZhjtjzQ7wOzgSD0aeychoSmDtVRAsEBZuVbv2YrpgEGI/yjaGOr300JmYz
	CdIz3OdQ2rz3vwiyo7QEYIka2a9SnIqPLAdjlVchvNnGB2xtCANEX10rvQi0mQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1776526891;
	b=WUge0FKpNvnRk3P2Pk44AU5RYJGtuufOczmrv55IeZjxaB6W0upAQLgtLz54MFPd7ERsfc
	ggUaQpv3NFkmtVfYNLs2+BEFF2zBMlPq9UeOxZbohocpzS2gD/PWd2FRgiCUAQqeaoJVe9
	vnP8OFDOoRj74EHuswd0xzMMEJm9+qJ4UBykYB3W0cCMxevVjWtiAM/m07xBtLYFQePjgr
	om78v9fbh7AP+4WIubc8AxzwqIzHvY+oD95x4IdF9ksRjFvYfGP4qxfOurNTZMqmPVwPHf
	soxM8aB4DD1Q0OQv3cLCHKZbtlDC7yQFRZ+ciVnCZP+3ZKnJ4l7hDMNvp1o02Q==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH] Bluetooth: SCO: hold sk properly in sco_conn_ready
Date: Sat, 18 Apr 2026 18:41:12 +0300
Message-ID: <023e04a49d2002882eb5ea6bf27d1169261db875.1776525817.git.pav@iki.fi>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sk deref in sco_conn_ready must be done either under conn->lock, or
holding a refcount, to avoid concurrent close. conn->sk and parent sk is
currently accessed without either, and without checking parent->sk_state:

    [Task 1]            [Task 2]
                        sco_sock_release
    sco_conn_ready
      sk = conn->sk
                          lock_sock(sk)
                            conn->sk = NULL
      lock_sock(sk)
                          release_sock(sk)
                          sco_sock_kill(sk)
       UAF on sk deref

and similarly for access to sco_get_sock_listen() return value.

Fix possible UAF by holding sk refcount in sco_conn_ready() and making
sco_get_sock_listen() increase refcount. Also recheck after lock_sock
that the socket is still valid.  Adjust conn->sk locking so it's
protected also by lock_sock() of the associated socket if any.

Fixes: 27c24fda62b60 ("Bluetooth: switch to lock_sock in SCO")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    There's still several known race conditions in sco.c, if you look at the
    sco_conn_put/free and hcon->sco_data access. A redesign could make these
    locking issues simpler:
    
    https://lore.kernel.org/all/5ac8c40b96052cb320c4ee1083d37818ac5d90cc.1776025103.git.pav@iki.fi/

 net/bluetooth/sco.c | 44 ++++++++++++++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 12 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 3a5479538e85..eba44525d41d 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -472,9 +472,13 @@ static struct sock *sco_get_sock_listen(bdaddr_t *src)
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
@@ -515,11 +519,13 @@ static void sco_sock_kill(struct sock *sk)
 	BT_DBG("sk %p state %d", sk, sk->sk_state);
 
 	/* Sock is dead, so set conn->sk to NULL to avoid possible UAF */
+	lock_sock(sk);
 	if (sco_pi(sk)->conn) {
 		sco_conn_lock(sco_pi(sk)->conn);
 		sco_pi(sk)->conn->sk = NULL;
 		sco_conn_unlock(sco_pi(sk)->conn);
 	}
+	release_sock(sk);
 
 	/* Kill poor orphan */
 	bt_sock_unlink(&sco_sk_list, sk);
@@ -1365,17 +1371,28 @@ static int sco_sock_release(struct socket *sock)
 
 static void sco_conn_ready(struct sco_conn *conn)
 {
-	struct sock *parent;
-	struct sock *sk = conn->sk;
+	struct sock *parent, *sk;
+
+	sco_conn_lock(conn);
+	sk = sco_sock_hold(conn);
+	sco_conn_unlock(conn);
 
 	BT_DBG("conn %p", conn);
 
 	if (sk) {
 		lock_sock(sk);
-		sco_sock_clear_timer(sk);
-		sk->sk_state = BT_CONNECTED;
-		sk->sk_state_change(sk);
+
+		/* conn->sk may have become NULL if racing with sk close, but
+		 * due to held hdev->lock, it can't become different sk.
+		 */
+		if (conn->sk) {
+			sco_sock_clear_timer(sk);
+			sk->sk_state = BT_CONNECTED;
+			sk->sk_state_change(sk);
+		}
+
 		release_sock(sk);
+		sock_put(sk);
 	} else {
 		if (!conn->hcon)
 			return;
@@ -1390,13 +1407,15 @@ static void sco_conn_ready(struct sco_conn *conn)
 
 		sco_conn_lock(conn);
 
+		/* hdev->lock guarantees conn->sk == NULL still here */
+
+		if (parent->sk_state != BT_LISTEN)
+			goto release;
+
 		sk = sco_sock_alloc(sock_net(parent), NULL,
 				    BTPROTO_SCO, GFP_ATOMIC, 0);
-		if (!sk) {
-			sco_conn_unlock(conn);
-			release_sock(parent);
-			return;
-		}
+		if (!sk)
+			goto release;
 
 		sco_sock_init(sk, parent);
 
@@ -1415,9 +1434,10 @@ static void sco_conn_ready(struct sco_conn *conn)
 		/* Wake up parent */
 		parent->sk_data_ready(parent);
 
+release:
 		sco_conn_unlock(conn);
-
 		release_sock(parent);
+		sock_put(parent);
 	}
 }
 
-- 
2.53.0

