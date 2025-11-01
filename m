Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FE819E968;
	Sat,  1 Nov 2025 10:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761993247; cv=none; b=jMrJtz3rYtmMadYjztkStYgDWsapC+WK6KupkRcVCMW3aGeLLnQZqRGUJz324CUuhSBenOFqaFD7C1RXHBA43QlXsaM9B88yAOs+fLs+YKuX8bSNwsm0/ZYcqxMazc9TNysrWmMYsKOEuayiv9M9Q6p2m4zm6n/ITyoK7zjWLoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761993247; c=relaxed/simple;
	bh=hVgOtHh2UP3HTW/xtGWITgsaue9OFL956Tam2z1jdKw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nl/KOHypyDQVu6gLS21JACZe9dVweaXOAlIWTjMtCFUSvyj52tOUrtXm2yGL4R5MCko8t5nJcktVWQkr0drHun991C6p93IaD3Ose1tS76YRJNOJbl8VAZU/WXltsUutxrYFKbZLpud6AV7MjiZQIunGfByTNVNIYdy5Oe+urjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=MphnwwPZ; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="MphnwwPZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=rq
	6HLerKSGV89rZ0utez+xAew3A/QhvKdFmaZJVOYj0=; b=MphnwwPZMgYAoTOCQY
	cIeW1LdB7PIcMmqqoCKBFOQ/aX45zP3xDLWOX2StasvyWCZrgzfPh1eOB0WjQY9I
	Tw6EfXHjiVqNMA9aho51lSworvPSK1PAE2hGwS74n8TTss9Z0KDzJ19Ttho0eMcx
	vB5b4hBZGIaFp+GcmKHTtFfPY=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wCXP0wI4gVp9f6lAw--.43067S2;
	Sat, 01 Nov 2025 18:33:44 +0800 (CST)
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
Subject: [PATCH V2] bluetooth: sco: Serialize state check in sco_sock_connect to fix UAF
Date: Sat,  1 Nov 2025 10:33:33 +0000
Message-ID: <20251101103333.173774-1-zzzccc427@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCXP0wI4gVp9f6lAw--.43067S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCF17KrWrtF4ktF1xKw45KFg_yoW5CryDpF
	WDKanak34DJrn3ursayay8Wr4kArn5uFW2kr10gwn5Aas5KFW0yF48trWUtrs8CrWvyF45
	Z3WqgFW3CF4DurDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piG2NtUUUUU=
X-CM-SenderInfo: 5222uujfuslqqrwthudrp/1tbiXBP4hGkF3CFQBwAAs1

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

Thread 1:               Thread 2:				Thread3:
check sk_state          check sk_state
sco_sock_connect(sk)    sco_sock_connect(sk)	sco_connect_cfm(sk->conn)
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

