Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205352FE56F
	for <linux-bluetooth@vger.kernel.org>; Sun, 13 Sep 2026 03:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789268989; cv=none; b=ufkEX9mMFohV0Nej0JihNoFl8rXk0aFlGze0FoHkt1/UocMsd+Dnb3PwHV6iARfrTFZPM0ORAsCHh5YnC8atT5DYdVhiuMKDA8ONdh0rDgIgzB8KHM/qsjzSQ1/Z6zPzCESLInwIiFsm4GUqJ85TUr7M8nzVJTCLFtRT8ysQgW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789268989; c=relaxed/simple;
	bh=X2A/5d9QeOB9OKtd9sE5zXeKx9erBPPV4ajbPLRfhnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FTgB8e4o/zw69BDhoEyLCfrmA99RJJNMxDsJvCaWfMMrvqRiJLOPn9JAASn8ykrIfBolmSTn9WmUfF5HFZRwoeebUFzD9DH9wZh9EHO+jkDYioRgYjqctSqmCdPDHzT+sQqG22hbZn2Gj4j9bMxVO9BdtPk0usfcZ4e78sMvreM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DF5Bqf+S; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DF5Bqf+S"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-93a0fd41a7bso56364885a.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Sep 2026 20:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789268987; x=1789873787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ALKVDnESABRZmUOg2I7SKOBTtWppnEDzB82ISkvwYxg=;
        b=DF5Bqf+SR2b5x75uKyeq/kXHqxDQ3C2omaJeBolDDrbvmFS3Ok1epzq+GF6ZDIcJjl
         9aVnYXJXq/+n/Ekt73zVPut0lMU0THGU/mquIVN2Z/OV5KYDNQcHU38LRQcFMY9/K0Ws
         GjbbFTwORLymkqHluC1vho1A1gKvb38ZIafdfACgd38nPUzsPtNAST1ZgjaA9dA7qD1/
         nMyU9BQ5/DUfCCicGn4j2/yaOmZIXXP3wZQd1h4AtQeDqV7TKuI3I9tw1bgF8JL4SEqL
         5q0dA/BMUWxtfJkNg1iukcDfC3NrmrUvzWw75UXK0Zn83xdVKy+86xkaqkzDgjDqdJ+0
         Ctag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789268987; x=1789873787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ALKVDnESABRZmUOg2I7SKOBTtWppnEDzB82ISkvwYxg=;
        b=AkG0rRzqA/es6/S+XJt8VkzLPFVZBiIdrORBgLHKObXWA63v1B/dOB790E4j1hT20h
         Gmeij0n+gvSL6wV61EXcbQFVuoKmYDq/Q31DEp6JtAIdx2CzAZhpOL/HVFcxx/1Cc6IQ
         3PIVdVEWBunK66iKAnNozzMJsohQd2UnqL2vFDuFOopTicbME8Nio1VRzbLbpifgzohj
         5YR7UbDUzMilEQnfYfQuiHgt7K0dTGDWmNcgy+983Wp5oGkawWaF1SoDlfAbcBj3Xfzw
         yMKQVDNa2xm15/Y20oYNz1OyUe6fkCbdDTkv+Mz//1OacTERob5loSa6PgunUPeHYLnf
         FU5g==
X-Gm-Message-State: AFuF++kV/c/I3MoGSFPNpd87bFXdCdKjSdQHif8RvlBVlAPX5E7E7cMR
	24DYL6Enlhh7186h4BPVszxpn4t+gdk5gzxa1qwTDnum7RUZpiItsZgc
X-Gm-Gg: AYBFou0mD34KZHy9UPfyx2160jNEkGC24706gasQjv9d7RyOnYQ1sZ6hFFAvemmMV+C
	nCZpGoqi5eZGAmzl3NjCWYoIeDiUpGw6WdfaMh94LifGH6fwtr5tTTysEkvnUa0VgEEkmCyFCou
	LpM9kjUrBPrb7IIWuK/StAhtDJLpayOvc9FMTrRsDo99Wv+mSeFrOfM2WvTkKDr+dEYgqmTQhVE
	524qXiGow/BOE0+8bWL96ALrzZHudD2S+1szSGEraHbosoqPhUonzYkPre7LGobtcU/RDC24lII
	ZVlyYlhkwbQSNCpuxrzglt8xXzQiGj3DLhuIVsaCBza5/XzWMJWaLYBXhUDNN8u+4r7f3rdFWfm
	yZdGy1FhAd/QNsFV4hrL4xPo0mYpHWr3KbRJE9O0nl9+/TCbqEH1spZU7mXpcttq0IoM4n/FrOa
	o3rpmvWNCEZEeCQwBOG4EthD399yJtr/CsKEJbjs7GcJTBTxGMsGLC0SdrmBGP7Ns1wHPqJsnL3
	B/m6u5xoas3J0QPvlxSgYqLozOxzRflXt7mc195N/o02M3WMjuBFez45xUeA2JCtDMLGuoWtVZH
	XtAVWPz/Ujdn+bwCGEQqUC9qxlId/jwLh5wnXB6dg6DxFnCeLPI1bZsCnKOygqhTNU6m4xibK5n
	yrWx95Q84u67US91Or3kW
X-Received: by 2002:a05:620a:4089:b0:936:cda7:554d with SMTP id af79cd13be357-93a0363a407mr724272985a.14.1789268986948;
        Sat, 12 Sep 2026 20:09:46 -0700 (PDT)
Received: from MacBook-Pro ([2605:8300:17:166:1ca:862b:e953:e8d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939fc4a9455sm427688985a.31.2026.09.12.20.09.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 12 Sep 2026 20:09:46 -0700 (PDT)
From: Juan Perdomo <jcperdomo100@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+0cece8fa7d83523f47a3@syzkaller.appspotmail.com,
	Juan Perdomo <jcperdomo100@gmail.com>
Subject: [PATCH v2] Bluetooth: RFCOMM: avoid socket lock inversion in listener cleanup
Date: Sat, 12 Sep 2026 23:09:45 -0400
Message-ID: <20260913030945.4011-1-jcperdomo100@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <6aa2d63e.6e6c5f9e.28f11f.0036.GAE@google.com>
References: <6aa2d63e.6e6c5f9e.28f11f.0036.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rfcomm_sock_cleanup_listen() closes unaccepted child sockets through
rfcomm_sock_close(), which takes the child socket lock before
rfcomm_dlc_close() acquires rfcomm_mutex. The RFCOMM worker takes these
locks in reverse order while handling connections and DLC state changes,
so lockdep reports a possible deadlock.

Close dequeued children without taking their socket lock. The accept queue
owns a reference to each child, and bt_accept_dequeue() locks the child
while unlinking it and clearing its parent pointer.

Dropping the child lock makes it important to prevent a concurrent
rfcomm_connect_ind() from enqueueing a new child after cleanup observes an
empty queue. Set a listening socket to BT_CLOSED while its lock is still
held, before dropping the lock and draining the queue. The state check in
rfcomm_connect_ind() then rejects new children once cleanup starts.

Reported-by: syzbot+0cece8fa7d83523f47a3@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=0cece8fa7d83523f47a3
Fixes: b7ce436a5d79 ("Bluetooth: switch to lock_sock in RFCOMM")
Signed-off-by: Juan Perdomo <jcperdomo100@gmail.com>
---
Changes in v2:
- Mark the listener BT_CLOSED under its socket lock before accept-queue
  cleanup, preventing new children from racing with teardown.
- Retest with syzbot after its v1 run exposed the accept-queue race. The
  revised patch completed without triggering an issue:
  https://syzkaller.appspot.com/x/bisect.txt?x=156ca925580000

 net/bluetooth/rfcomm/sock.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 958081adb..e2486bc11 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -242,9 +242,7 @@ static void __rfcomm_sock_close(struct sock *sk)
  */
 static void rfcomm_sock_close(struct sock *sk)
 {
-	lock_sock(sk);
 	__rfcomm_sock_close(sk);
-	release_sock(sk);
 }
 
 static void rfcomm_sock_init(struct sock *sk, struct sock *parent)
@@ -905,6 +903,7 @@ static int rfcomm_sock_compat_ioctl(struct socket *sock, unsigned int cmd, unsig
 static int rfcomm_sock_shutdown(struct socket *sock, int how)
 {
 	struct sock *sk = sock->sk;
+	bool cleanup_listen = false;
 	int err = 0;
 
 	BT_DBG("sock %p, sk %p", sock, sk);
@@ -915,9 +914,17 @@ static int rfcomm_sock_shutdown(struct socket *sock, int how)
 	lock_sock(sk);
 	if (!sk->sk_shutdown) {
 		sk->sk_shutdown = SHUTDOWN_MASK;
+		if (sk->sk_state == BT_LISTEN) {
+			/* Block new children before cleaning up without sk lock. */
+			sk->sk_state = BT_CLOSED;
+			cleanup_listen = true;
+		}
 
 		release_sock(sk);
-		__rfcomm_sock_close(sk);
+		if (cleanup_listen)
+			rfcomm_sock_cleanup_listen(sk);
+		else
+			__rfcomm_sock_close(sk);
 		lock_sock(sk);
 
 		if (sock_flag(sk, SOCK_LINGER) && sk->sk_lingertime &&
-- 
2.50.1 (Apple Git-155)
