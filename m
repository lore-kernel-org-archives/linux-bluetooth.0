Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A947934B66F;
	Sat,  8 Aug 2026 22:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786226776; cv=pass; b=OoJyHAx0bmABgVS2G7O2tAuBgbjtu7+zGpdid2gm8yhvtsn5baAhtjXaAlgXQtvYjO3m4Fh2zk1HiPESzGLxbm71eBTJnXUCqhIhL/oeng2/YLuP672vh/c4eZXHFH6uPnMEg5OcsexwZl7dQnotW9xmlvMQVlftj7TZVwrSo7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786226776; c=relaxed/simple;
	bh=ZGpkRMcTUF9vsE0imEtYTMLOm61POpLyy/6dpgztaLA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DRMqBGsE9q6PWm2q1ZBd8knqVt7bwD/Yjs8wjjYkwaQt4xlJL19tqGkAOflyKwg784XvtYJDT9LBkglLf/WbOBfz9vKLDRhWn5UIRMGa0+gI5lPT6ijiB05G/O29/OPx61mjTdp7eIV9qoAh6SzV23et0w4bKK4ebJORw+OLUNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=vIou7WP0; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="vIou7WP0"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:1::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hHZpl6GJ2zyRl;
	Sun, 09 Aug 2026 01:06:07 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1786226768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZPPrB4lxQ645se+i5ucOW890+wON2Pj0mR4ABoEgBHM=;
	b=vIou7WP00UjRbjf7cxDfcA+sriBlGXcqVerFcNLfob6GQXCnmoRMYeS6uOziEhtz2FfW5M
	PNwRYl3cWhuOxdMD/VDFKxGsfCc0cnsa3necBc3H1LGQUG0luzZBjuEdUKeiVfjUhgRcAG
	8rM/Kxn3ZJIwh4vk7/trOH2IPuZgeVs=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1786226768;
	b=OwIymYy6b4vtuCnuF9NDo/W+xqR3XJiVZ5Jnx8H4cBb26khSM4Pi1aymInbjoCBE0+gt3o
	EJkfgqbXFPzoZecPgfkRhhpQyBEgH0gVhqr/1CcCAr8+Dpj5oV4IBc1MBBI5TKmvpOKCbE
	X4i7r46gEDhYVjirSkdsepxnEY5ZqlQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1786226768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZPPrB4lxQ645se+i5ucOW890+wON2Pj0mR4ABoEgBHM=;
	b=kJDzVoZOXXdZWvh77aLOtX0bbwCxbm7Q7U/lmfqEa4o6HvJoOOFS0Mo+BcdQTeQ9tbmhB5
	7lkvX9sX3LG7dvbJtIr2GZX/yPusFriXlY4nIgIB0gqa4+PVocxhU89heVjjSNKSqH2OE6
	QWep6pkUkMs8OoDLVYaUdN/Onx8gLxw=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	oss@fourdim.xyz,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	syzbot+9265e754091c2d27ea29@syzkaller.appspotmail.com
Subject: [PATCH] Bluetooth: L2CAP: reject accept queue add unless BT_LISTEN
Date: Sun,  9 Aug 2026 01:06:05 +0300
Message-ID: <204b3dea7b0e001f64920ed1114d38c16afdb397.1786225848.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New sk should not be added to parent socket accept queue after last
l2cap_sock_cleanup_listen() has run in l2cap_sock_teardown_cb() and
state set to BT_CLOSED, as that can result to UAF on dereferencing the
dangling parent reference.

l2cap_sock_new_connection_cb() may race with parent l2cap_chan teardown,
due to chan->state accessed without consistent locking:

  [Task 1]                           [Task 2]
  l2cap_sock_release(parent)         l2cap_connect
    l2cap_sock_shutdown                pchan = l2cap_global_chan_by_psm
      l2cap_chan_lock(pchan)
      l2cap_chan_close
        l2cap_sock_teardown_cb
          pchan->state = BT_CLOSED
      l2cap_chan_unlock(pchan) ------> l2cap_chan_lock(pchan)
                                       l2cap_new_connection
                                         l2cap_sock_new_connection_cb
      l2cap_chan_lock(pchan) <-------- l2cap_chan_unlock(pchan)
      l2cap_sock_kill(parent)          /* bt_sk(sk)->parent dangling */

Fix by adding check for sk_state == BT_LISTEN after acquiring sk lock in
l2cap_sock_new_connection_cb().  Add lock_sock() around sk_state writes
where missing, to avoid data races.

Although the data races on pchan->state should be fixed too, this
defensive sk_state check probably makes sense in any case.

Fixes: 2ff1a41a912d ("Bluetooth: L2CAP: Fix null-ptr-deref in l2cap_sock_state_change_cb()")
Reported-by: syzbot+9265e754091c2d27ea29@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9265e754091c2d27ea29
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    Fixing up chan->state locking is a bigger changeset, and should be done
    separately.
    
#syz test

 net/bluetooth/l2cap_sock.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 735167f73f31..8c2ac8b911e0 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1568,6 +1568,11 @@ static int l2cap_sock_new_connection_cb(struct l2cap_chan *chan,
 
 	lock_sock(parent);
 
+	if (parent->sk_state != BT_LISTEN) {
+		release_sock(parent);
+		return -EINVAL;
+	}
+
 	/* Check for backlog size */
 	if (sk_acceptq_is_full(parent)) {
 		BT_DBG("backlog full %d", parent->sk_ack_backlog);
@@ -1731,10 +1736,14 @@ static void l2cap_sock_state_change_cb(struct l2cap_chan *chan, int state,
 	if (!sk)
 		return;
 
+	lock_sock(sk);
+
 	sk->sk_state = state;
 
 	if (err)
 		sk->sk_err = err;
+
+	release_sock(sk);
 }
 
 static struct sk_buff *l2cap_sock_alloc_skb_cb(struct l2cap_chan *chan,
@@ -1810,6 +1819,8 @@ static void l2cap_sock_resume_cb(struct l2cap_chan *chan)
 	if (!sk)
 		return;
 
+	lock_sock(sk);
+
 	if (test_and_clear_bit(FLAG_PENDING_SECURITY, &chan->flags)) {
 		sk->sk_state = BT_CONNECTED;
 		chan->state = BT_CONNECTED;
@@ -1817,6 +1828,8 @@ static void l2cap_sock_resume_cb(struct l2cap_chan *chan)
 
 	clear_bit(BT_SK_SUSPEND, &bt_sk(sk)->flags);
 	sk->sk_state_change(sk);
+
+	release_sock(sk);
 }
 
 static void l2cap_sock_set_shutdown_cb(struct l2cap_chan *chan)
-- 
2.55.0

