Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459E03AAF42;
	Sat,  8 Aug 2026 09:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786180185; cv=pass; b=lSgcPFIT0wbsp8SaM9xbGf4ttzYgwBjZyVadv/+chIGdXmjDCkZsnFgGgfhc0WTnVCUO1bmgQ3NwD4AWvnZFybND+5wLM5Tisdwg5OW27e610ZCyLg1E6TA8GxllOPi99RvaUn5diiQijJj2QOaYZRDIX6NYk5X/uRoGf2MpwDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786180185; c=relaxed/simple;
	bh=OzSEQyeMOo2YfL2fJOEX/yD2FnUsim+aOkK/ye7uKjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=daLQUK93qGYDsWrK9oRUJ0EBdz1e3WER3oUQT0etupu7RzLQblIl9eZBtYwKl51IS2mkuwpmzMmDTf3e49aWjNeCdaAvhogRlOt3jpG613WOm/CjVNIqCe5oHyMant3IENDNoy87mlnhxOenHeP8lboKuHqQ7R1jTk9m13mcdKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=zSzof+Dn; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="zSzof+Dn"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:1::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hHFZm1BPFzyQZ;
	Sat, 08 Aug 2026 12:09:36 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1786180177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5g+xaXaE/Q+I+hL8BZ4zitytO4Dm1vzjqstMvA3mnmw=;
	b=zSzof+DnTGx5kvJb///BBPWB6MnjjmTp2I+6Xohtx2STEKTwc8O6h/oLFWNuF0/Mt4KZiK
	uV5it/lAjcbUE9DpiDEaz719oJ2qS3hFQF3QrgPzxiGPUVJ5JOlml2W2v+KZUW+PldMlru
	tQFjLvIOsIr3bDhhXd2WyCo+3PeZxus=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1786180177;
	b=mchdSg1N4jEVrR5xzDB2rIkku8uvCsVr/WR/J8de45ygrNkB7pzsI4XV+n9gknvNYry2KR
	YrREECcq3ceQLuaWF1RWEq3VFtlj2fZCM5UBgnWXA1+8KyyCeKnKt5JiLU7ucjF530DrfR
	3LjR9B/zxzxFki1z5a2jgjhUd+9FxEA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1786180177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5g+xaXaE/Q+I+hL8BZ4zitytO4Dm1vzjqstMvA3mnmw=;
	b=Q5tCiqLqFlbsKbf/CKwavcalYc0j9A5XKz9p1YoLpmALHraM75LG2joN7OJTTmW7MKuYd+
	8CD+r1zV1j6li8uJyl9StlonzpGgqNMDBAg+rw6LJMRhE2RF5D/9mDje7AbKX7m+WaM/uM
	YvJXCkql9jrBi6AgvnlXbVotc1y2xRM=
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
	hdanton@sina.com,
	syzbot+e6382a2f53f5fc7453ac@syzkaller.appspotmail.com
Subject: [PATCH v2] Bluetooth: L2CAP: fix race l2cap_sock_cleanup_listen() vs. put_chan
Date: Sat,  8 Aug 2026 12:08:45 +0300
Message-ID: <95cf567c0e78b0ded9a555da052b4ea9b91aacce.1786179819.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For L2CAP sockets without owning sk->sk_socket, reading
l2cap_pi(sk)->chan may race against concurrent l2cap_sock_kill() ->
l2cap_sock_put_chan().  This excludes simultaneous proto_ops callbacks,
but access in l2cap_sock_cleanup_listen() has unsafe lockless read.

 [Task 1]                         [Task 2 (hdev->workqueue)]
 l2cap_sock_release(parent)       l2cap_disconn_cfm
   l2cap_sock_cleanup_listen        l2cap_conn_del
     bt_accept_dequeue                l2cap_chan_del
       lock_sock(sk)                    l2cap_sock_teardown_cb
       bt_accept_unlink
         bt_sk(sk)->parent = NULL
       release_sock(sk) ----------------> lock_sock(sk)
                                          parent = /* NULL */
     lock_sock(sk) <--------------------- release_sock(sk)
                                          sock_set_flag(sk, SOCK_ZAPPED)
                                      l2cap_sock_close_cb
                                        l2cap_sock_kill(sk)
                                          l2cap_sock_put_chan
     chan = READ l2cap_pi(sk)->chan         l2cap_pi(sk)->chan = NULL
     l2cap_chan_hold_unless_zero            l2cap_put_chan(chan)
       kref_get_unless_zero(&chan->ref)

Task 1 may observe NULL which causes null-ptr-deref.

Fix the race by taking lock_sock() in l2cap_sock_kill() to
synchronize with l2cap_sock_cleanup_listen().  hold_unless_zero() is not
needed here, l2cap_pi(sk)->chan owns reference if it is non-NULL.

Clarify code comments vs. locking.

Fixes: 0e2c0392b9dc ("Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_new_connection_cb()")
Reported-by: syzbot+e6382a2f53f5fc7453ac@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e6382a2f53f5fc7453ac
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    v2:
    - improve commit message
    - no code changes

 include/net/bluetooth/l2cap.h |  5 +++++
 net/bluetooth/l2cap_sock.c    | 23 +++++++++++++----------
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index ef6ce1c20a4f..3d9a32094347 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -699,7 +699,12 @@ struct l2cap_rx_busy {
 
 struct l2cap_pinfo {
 	struct bt_sock		bt;
+
+	/* With owning sk_socket chan may be read without lock, other access
+	 * should hold lock_sock.
+	 */
 	struct l2cap_chan	*chan;
+
 	struct list_head	rx_busy;
 };
 
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 735167f73f31..9540617a0e6c 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1312,7 +1312,12 @@ static void l2cap_sock_kill(struct sock *sk)
 
 	BT_DBG("sk %p state %s", sk, state_to_string(sk->sk_state));
 
+	/* Take lock to synchronize against access without owning sk->sk_socket,
+	 * eg. in l2cap_sock_cleanup_listen(). proto_ops etc. don't need lock.
+	 */
+	lock_sock(sk);
 	l2cap_sock_put_chan(sk);
+	release_sock(sk);
 
 	/* Kill poor orphan */
 	sock_set_flag(sk, SOCK_DEAD);
@@ -1516,14 +1521,10 @@ static void l2cap_sock_cleanup_listen(struct sock *parent)
 	 * establish sk_lock -> conn->lock and invert the established
 	 * conn->lock -> chan->lock -> sk_lock order (lockdep deadlock).
 	 *
-	 * Instead, briefly take the child sk lock to fetch and pin its chan.
-	 * l2cap_conn_del() reaches the chan free only via
-	 * l2cap_chan_del() -> l2cap_sock_teardown_cb(), which itself takes
-	 * the child sk lock; holding it across l2cap_chan_hold_unless_zero()
-	 * therefore guarantees the chan cannot be freed while we read and
-	 * pin it (hold_unless_zero() additionally skips a chan already past
-	 * its last reference).  We then drop the sk lock before taking
-	 * chan->lock, so sk and chan locks are never held together.
+	 * Instead, briefly take the child sk lock to synchronize vs.
+	 * l2cap_sock_kill that puts l2cap_pi(sk)->chan. We then drop the sk
+	 * lock before taking chan->lock, so sk and chan locks are never held
+	 * together.
 	 *
 	 * Since we cannot call l2cap_chan_close() without conn->lock,
 	 * schedule l2cap_chan_timeout to close the channel; it already
@@ -1533,10 +1534,12 @@ static void l2cap_sock_cleanup_listen(struct sock *parent)
 		struct l2cap_chan *chan;
 
 		lock_sock_nested(sk, L2CAP_NESTING_NORMAL);
-		chan = l2cap_chan_hold_unless_zero(l2cap_pi(sk)->chan);
+		chan = l2cap_pi(sk)->chan;
+		if (chan)
+			l2cap_chan_hold(chan);
 		release_sock(sk);
 		if (!chan) {
-			/* l2cap_conn_del() already tearing this child down */
+			/* Already torn down */
 			sock_put(sk);
 			continue;
 		}
-- 
2.55.0

