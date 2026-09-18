Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51DF35E1A9
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 07:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789718172; cv=none; b=DhXdgyTo5YwDq8JCfO23bb0elRGMfTnXKujdIBvn6ib7qYoAskBeMlYdan5LkSyR8Sa+/HjDYbDV3KE92cammNjVv9OVM8mHBDY6kJFnsL7dGS4azynDpQ8ARZFbQk9ogCJJorqJIhR7OpM52rBXn/j9jGH8o1jUEnzspM9nbV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789718172; c=relaxed/simple;
	bh=E5lJFa48JLe3JtulsGSEAqeCO2Wce69bO6my0/dJXaA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QESvzwD4rb9or1fWjdwyMmkQBMaEvFS5TBSmke5XDNvGNmYzWS5LLQ4dpeOd8M8Iu8AZXeCUQlQzWVXu22JSxsrWqy/dRI4W2Og8cI0qJ22b1YMwuzPs4djx2AhMPJcG47TCvFP99Ku7syjxQ7NnHilkpJVwStNm1tiJFtzAQk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HeIwTZlW; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HeIwTZlW"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-398b3b189e0so398048a91.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 00:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789718170; x=1790322970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yn5DIqQw4q6rC7tHkuAinbNEk6nv+wVGhTyoKH5xIz4=;
        b=HeIwTZlWILDeufklzoptdsOj1F9yRTeRz7F/1qtWhAIo2WreN7eNzC6Ep2OMafAsne
         MHDK6QoMmov7zBdZekQ627nhezJxTlakqfNbF9r0CYr1REiq+oXeq8y0CtiF8I5sU6KB
         e+3TK8cV5bhS98ACLWjHBAcJ+m1jioS3LbZN/FeU+QvfG+zCnbLQuFp8Aa6a7MWiUrDN
         qSKBv2qMu8QEIjiVPqmUW7lH8i6vSTOESfXwm4mqGf7A68XT0LlhWsDTBeSLIP4+ldP1
         IVSHtjXTCwei38sCi+BSgirpTorM4S4ubc1vBntDiU4exZdvMpLF5MLK5pOKxq2D6dMl
         Qv0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789718170; x=1790322970;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yn5DIqQw4q6rC7tHkuAinbNEk6nv+wVGhTyoKH5xIz4=;
        b=IsGmYmX/e6t3FIYZLkiXgJJ0t8hJrBGl7+OkkT2N/9aL1UNunanTY+Z8EiPGiqruep
         i6djZPY0w2cYPRPdMpLIqCiaxZPWkWmfPPFrWmIqu4vASpPNvoaiSJArOIGEjVf4j9Va
         UczOQR6mxKmxO/Aehr9eX16v5mXPqTJkmChW+9tSOoiyAt+8EoskC5V2P8u/xAWMHTcj
         5pIS/48C1v8bj6PHWaVR4N7YV/d/UA2ACsM5KywdOQiZNQ2lha5vX0XO3lbITXMkoup+
         4BSJ3V90shMA6XUTfc7TZKKwBWBiUH0XuGA9L5lSO9pJ6slmNSxmyRx8po0ktvB3yAdn
         WgBA==
X-Gm-Message-State: AFuF++lT7lhRe6wvRqerb8RbbOIHdo9R0///DeY2RrBFvUnbiw/qUO6P
	6hToR7BgYv7xHMbFXkD4D/8oiwEuT3CvcB06K46KFmCzyqBWZDxXYPmgonL3mg==
X-Gm-Gg: AYBFou1vXzvk0TlhGJubTfOXHQcioqodFTNE5yayXA1TpiEM0Z9WYEb3DwmyZNUSp9i
	Y+18L0elI3jIUt37zteYB7/KS1dpRGmoVhibFLeH8TFF3gkV3sgXnNWRr40NWQoIkv3OJ3Tvzpn
	Pu/LRQBeZb4MzNeUmtrMdmXT4XZM1o+QwkU/wRCDjoFzDHeHHPOI3TZyLnrELa50jFpJxtPYe95
	es/rz0sj/cLvNECYDZGrgZRftG++SrAS+HGDo6VVqIdSgeFngSpLgwxwypUYGMz2SbV7hYAsefY
	ite4cbeumX21g1+9R/IsUZaGsHEulTgILisa1YfHS7TMkDW9ieOcxo8otMLGuk9PRyhzsjg3mAd
	xcy6DFrEqixLpLbw2w9veLr2d2tFb1MBN+8UF+ukC/taaSxhbDi4eGodmF2iQTDoDTbGvwTrDPO
	NGdwnsyZrL81MRakgP4w+060lGjAlEu5nWWyqO0EkDgvreenRBP2eXfIHyq1uzUqQJHdCRvykSz
	04AZI/2f3Vm6Ef1lkYLpmWvCUmxv7oM
X-Received: by 2002:a17:90b:4e8c:b0:39b:2c55:365 with SMTP id 98e67ed59e1d1-39e54b457a8mr4076007a91.12.1789718169851;
        Fri, 18 Sep 2026 00:56:09 -0700 (PDT)
Received: from thangnn-Dell.vingroup.local ([202.60.105.126])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e36116884sm9214715a91.6.2026.09.18.00.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 00:56:09 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	syzbot+534002670dd34a114fdc@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Subject: [PATCH v2] Bluetooth: af_bluetooth: Fix double list_del and UAF in accept_q
Date: Fri, 18 Sep 2026 14:55:35 +0700
Message-ID: <20260918075535.886816-1-ngocthang2710.1999@gmail.com>
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
v2:
 - Add !list_empty() check inside accept_q_lock to prevent double list_del.
 - Move sock_put() outside of the spinlock to avoid sleeping in atomic context (suggested by Paavo Helde).

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

