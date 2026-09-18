Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA12C4CCDC7
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 10:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789728496; cv=none; b=tX9hjR+03MiD5VTXyucaW5v9vjWmVJLoMMA9om2wTGaMsuY7Cq5Q3ZgQdNAYMgpmwD3toeo7v1+O/WxQmlL0vt8pZUsU2y9qDG+yfN2sWH2YzfTD0RVoA56bwPx92QUX1gnVsIEreAcWzleylDu+mJmngwG8hJMBg56sGSu5xL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789728496; c=relaxed/simple;
	bh=GUoNXGoRu/YXogOq9X/rgu4d8MQqhVuvIq9UPe1IZDw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nSpcLnIzbWOnivs/Bw2yZdLmBiqBVOD7D0ox2hviMmss2NzLPpbTGwoejai5V8qKTe/sQqoPtyhTb3jq+E+fpNNSjS09L30Y7Ohwilne0N/DkiEaWr16PQ7429I6HTlfRb+uwA2ONZfG3XXmU7drfra9xnLPrXFmGHCCTbIwhoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ue0vSpnM; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ue0vSpnM"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39b350c6920so505129a91.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 03:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789728494; x=1790333294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JwK7hDaTxVvRj/kN5UmwJrv3y8N+AsYHVz6dYPsaA6Y=;
        b=Ue0vSpnM/eNgywHjWRcnJb8fS+J5eC9h1EOhCvMjPxddPdbeWVGmXAqNad7ILHi0OY
         vrJEbN1IhwYsZD4NoCxj0eNmbQZyAeZliuXFlRIVyeww+gCJRe8/5azssph+J7yW3HE+
         8dyGVdmtWw/zXm97VcOEk8aXwVlULlhngeEmOjJu7lOBb/JjJD7pksM5h5NwkQsH64o1
         gIRAyPDNbeoj5rz3scRaMkEd+jGqX8IYUF38D6LrYqrsvaE5sEBrCSY10TKs+u5ACsAc
         BQLnY/OEi/P6FV/I5ZMSEhPQP248kLK6sZatbwdwFDkbx88robT/12X0N8exJ1l4pslE
         Swwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789728494; x=1790333294;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JwK7hDaTxVvRj/kN5UmwJrv3y8N+AsYHVz6dYPsaA6Y=;
        b=WCfBdVUzsqf6XBSZKEl6KYmHma0GpXyJvxH4wsABpYytQqDlgbKFYM5PM0noFDHXE0
         4MQyN2+8lTN2kQKboH0It6mktnwK9E1iRm3K6meMRD3SeM89TAVTubLdQtV5m3CPjq2x
         lNoGoZp+Zk87fqmuaEPf93iwg6mXrU22p6LshPPXaa8DE07Wo5oZ9J2SiSfPBZrhWlxb
         R3P+8pRC2p05U/55Lo/PWdcIpRkp+utfqlD3VeVjb7NzNdt4PjMHZKSQW3KJN6CjEBZp
         qhPNbAyuEHtSSV+aopUEAZUb1BrHiMg44siDiQWuPJzpFd8U7wVISsUis/UaUzMbKf6K
         dQrw==
X-Gm-Message-State: AFuF++mhxsa7d9QlZpzO+82uUWyw2gXLQF8zUCEcH1lqHCxke8d9fTHP
	niBM52MhVDXxDav3iOz0nHQRcqpTBv0qM82MOzfwp8RIoaNwZMpIFnsyP7UFVA==
X-Gm-Gg: AYBFou304rYc5o//U4AQT5tlqfVTm3VbHKD34lP7x6fXY0iar9qg5gETrxoA1s+em+O
	OVFCmrLjzX2gmIVQPQu7NnXGFiZwxGxLaALcP3UxbKJlZwfK+3IWs1J0ObbCw9ubARB1zeO+8Xl
	G923JY21d2QOxMkpIgEzycaBdYZEMNL77nkMyY31jAxxkNdSYlSvXPh0iDOwhZuqqO1Z1lgJK6m
	EWn3xdltVAGtuc5NY8V7fzlYrv8pmXkkaFsrMm02Cn6CedJstW4aLhZl0f/0s+S9/Jc7R26srG9
	0p013g9P+RS+6iUUO/Cuo+Byz5W4yVECS7hI5w0O5qM5mPdUmfscFpldhCBNVvh90NhbJ5b4X4e
	bwd3wlV9qcZjeRCqhT0VdNa+uRDBG2pj2sHiAqZ4PSwHU22qFtoETtAU8Ulj0atC6XzKl7TK4MU
	GZtSD6bDICBFAn5nGsTs5R8nTF5Qxd+x1MlignzLpkiHiAt3MXdGEFAspguNqtJ+BO7npaVLG9v
	blZBD9aRWp28SoAavFUy/eK0pZkiF8f
X-Received: by 2002:a17:90b:2d8a:b0:39e:2e79:7ce7 with SMTP id 98e67ed59e1d1-39e54d38b59mr5317868a91.6.1789728493789;
        Fri, 18 Sep 2026 03:48:13 -0700 (PDT)
Received: from thangnn-Dell.vingroup.local ([202.60.105.126])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e5a50d332sm2659573a91.9.2026.09.18.03.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 03:48:13 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	syzbot+534002670dd34a114fdc@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Subject: [PATCH v3] Bluetooth: af_bluetooth: Fix double list_del and UAF in accept_q
Date: Fri, 18 Sep 2026 17:47:36 +0700
Message-ID: <20260918104736.958613-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bt_sk(sk)->parent is a raw pointer with no refcount backing it, so a
child sitting in the listening socket's accept_q can outlive it. When
the child's channel is torn down independently (e.g. hci_error_reset()
-> l2cap_conn_del() -> l2cap_sock_teardown_cb()), bt_accept_unlink()
dereferences the freed parent, corrupting its accept_q_lock and list.

Additionally, if multiple threads concurrently tear down the child
socket, bt_accept_unlink() can be called multiple times. Without
checking if the socket is still in the list, the second thread will
perform a double list_del_init(), causing list_del corruption (kernel BUG).

Fix this by:
1. Taking a reference on parent in bt_accept_enqueue() and dropping it
   only when actually unlinked in bt_accept_unlink().
2. Checking !list_empty(&bt_sk(sk)->accept_q) inside the accept_q_lock
   to prevent double unlinking.
3. Moving sock_put() outside of the spinlock to avoid sleeping in an
   atomic context.

Reported-by: syzbot+534002670dd34a114fdc@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=534002670dd34a114fdc
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
---
 net/bluetooth/af_bluetooth.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 411d66f24393..7797b1052808 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -224,6 +224,10 @@ void bt_accept_enqueue(struct sock *parent, struct sock *sk, bool bh)
 	else
 		lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
 
+	/* Hold a reference on parent so it cannot be freed while sk keeps
+	 * a raw pointer to it via bt_sk(sk)->parent.
+	 */
+	sock_hold(parent);
 	bt_sk(sk)->parent = parent;
 
 	spin_lock_bh(&par->accept_q_lock);
@@ -257,15 +261,24 @@ EXPORT_SYMBOL(bt_accept_enqueue);
 void bt_accept_unlink(struct sock *sk)
 {
 	struct sock *parent = bt_sk(sk)->parent;
+	bool unlinked = false;
 
-	BT_DBG("sk %p state %d", sk, sk->sk_state);
+	if (!parent)
+		return;
 
 	spin_lock_bh(&bt_sk(parent)->accept_q_lock);
-	list_del_init(&bt_sk(sk)->accept_q);
-	sk_acceptq_removed(parent);
+	if (!list_empty(&bt_sk(sk)->accept_q)) {
+		list_del_init(&bt_sk(sk)->accept_q);
+		sk_acceptq_removed(parent);
+		unlinked = true;
+	}
 	spin_unlock_bh(&bt_sk(parent)->accept_q_lock);
-	bt_sk(sk)->parent = NULL;
-	sock_put(sk);
+
+	if (unlinked) {
+		bt_sk(sk)->parent = NULL;
+		sock_put(parent);
+		sock_put(sk);
+	}
 }
 EXPORT_SYMBOL(bt_accept_unlink);
 
-- 
2.43.0

