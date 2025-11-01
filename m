Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517C634D38D;
	Sat,  1 Nov 2025 10:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761992929; cv=none; b=lD4zOobG1Lj9yPB/CsFiQSyaqA/f0e5JVWqAQy0vxNZgCQlH6ZkeegzOO1arYhW4LZpe40FCspABfGJ6g+HKb3i1+awEI8Dvj+QXBVlJWqyMwmAWoL+fXZjRTPuudnd15EUpsjuwZcuTxjZXsNU6iiJwsf6xz27hc1S1J/imHdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761992929; c=relaxed/simple;
	bh=SHYtH5bETGar8dS4QBtS1eUfRcYLLVYSMMofFjNxIQg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X79IA3KtzAeiiTeXNd8z3PjmDua6+EaI+LCv8ZQdKF4uJfCHWOCAQRS7vGaZ0uI0A5v+HdfVc8wviJj3B4YDOSWNyZTt8RjVU6wimkuY0mjvZSjBu1/GBPkeP1RLVyg/XEbBi9mq+dvZNM7Jo20tkN5K98xKzHrZRit/YO2+Plg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WPSn0KWX; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WPSn0KWX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=rq
	6HLerKSGV89rZ0utez+xAew3A/QhvKdFmaZJVOYj0=; b=WPSn0KWXkjeReDUzqo
	rjbrugTtKQFS11eod2dGBptl8heWIqxBwnHcEJdYZ99010ETIJ0sTcw/ZTTqIB+6
	WWnRxcR6KBHpTB5un3b5RR7dYHRYmV2HTbmUI+kX6QLOs9oqaabwr/m6r3gy9lPf
	lJAyIh+rq3hX42WK9ziHBqHQM=
Received: from localhost (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgBHw3XN4AVpl9dNCQ--.35324S2;
	Sat, 01 Nov 2025 18:28:30 +0800 (CST)
From: Cen Zhang <zzzccc427@163.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	johan.hedberg@gmail.com,
	marcel@holtmann.org
Cc: linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	baijiaju1990@gmail.com,
	r33s3n6@gmail.com,
	gality369@gmail.com,
	zhenghaoran154@gmail.com,
	Cen Zhang <zzzccc427@163.com>
Subject: [PATCH] bluetooth: sco: Serialize state check in sco_sock_connect to fix UAF
Date: Sat,  1 Nov 2025 10:28:25 +0000
Message-ID: <20251101102825.173610-1-zzzccc427@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgBHw3XN4AVpl9dNCQ--.35324S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCF17KrWrtF4ktF1xKw45KFg_yoW5CryDpF
	WDKanak34DJrn3ursayay8Wr4kArn5uFW2kr10gwn5Aas5KFW0yF48trWUtrs8CrWvyF45
	Z3WqgFW3CF4DurDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piL0ePUUUUU=
X-CM-SenderInfo: 5222uujfuslqqrwthudrp/1tbiXQH4hGkF275GMwAAsc

Concurrent sco_sock_connect() calls could race on the same socket since the
state checks (BT_OPEN/BT_BOUND) were done without holding the socket lock.
This allowed two parallel connects to proceed and end up binding two
separate sco_conn objects to the same sk. Later, when sk->conn had been
updated to point to the second conn, closing the socket could free the
second conn and the socket, while the first conn's connect confirm path
still referenced the stale sk/conn, triggering a KASAN use-after-free.

Fix by taking lock_sock(sk) before checking sk->sk_state and sk->sk_type,
performing the destination address assignment under the lock, and releasing
it before invoking sco_connect() (which will acquire the lock as needed).
This serializes concurrent connect attempts for the same sk and prevents the
interleaving that caused the double-attachment and subsequent UAF.

Thread 1:                          Thread 2:						Thread3:
check sk_state                     check sk_state
sco_sock_connect(sk)               sco_sock_connect(sk)			sco_connect_cfm(sk->conn)
conn1->sk = sk				       
								   conn2->sk = sk
sk->conn = conn1			       
								   sk->conn = conn2
								   sco_sock_release
								   free conn2 and sk
																sco_connect_cfm
																sco_conn_del
																sco_conn_free
																UAF on sk 

The representative KASAN report excerpt:

  BUG: KASAN: slab-use-after-free in sco_conn_free net/bluetooth/sco.c:94
  ...
  Write of size 8 at addr ffff88810d2be350 by task kworker/u25:1/88
  ...
  Call Trace:
  sco_conn_free net/bluetooth/sco.c:94 [inline]
  kref_put include/linux/kref.h:65 [inline]
  sco_conn_put+0x49d/0xfc0 net/bluetooth/sco.c:115
  sco_conn_del+0x46d/0x8d0 net/bluetooth/sco.c:280
  sco_connect_cfm+0x83d/0x1ee0 net/bluetooth/sco.c:1468
  hci_connect_cfm include/net/bluetooth/hci_core.h:2082 [inline]
  ...
  Allocated by task 294:
  ...
  sco_sock_create+0x22d/0xc00 net/bluetooth/sco.c:616
  ...
  Freed by task 295:
  __sk_destruct+0x4b0/0x630 net/core/sock.c:2373
  sock_put include/net/sock.h:1962 [inline]
  sco_sock_kill+0x64d/0x9b0 net/bluetooth/sco.c:526
  sco_sock_release+0x770/0xa50 net/bluetooth/sco.c:1359
  ...

Reported-by: Cen Zhang <zzzccc427@163.com>
Signed-off-by: Cen Zhang <zzzccc427@163.com>

---
 net/bluetooth/sco.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index ab0cf442d..0af266880 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -651,13 +651,18 @@ static int sco_sock_connect(struct socket *sock, struct sockaddr *addr, int alen
 	    addr->sa_family != AF_BLUETOOTH)
 		return -EINVAL;
 
-	if (sk->sk_state != BT_OPEN && sk->sk_state != BT_BOUND)
+	lock_sock(sk);
+
+	if (sk->sk_state != BT_OPEN && sk->sk_state != BT_BOUND){
+		release_sock(sk);
 		return -EBADFD;
+	}
 
-	if (sk->sk_type != SOCK_SEQPACKET)
-		err = -EINVAL;
+	if (sk->sk_type != SOCK_SEQPACKET){
+		release_sock(sk);
+		return -EINVAL;
+	}
 
-	lock_sock(sk);
 	/* Set destination address and psm */
 	bacpy(&sco_pi(sk)->dst, &sa->sco_bdaddr);
 	release_sock(sk);
-- 
2.34.1

