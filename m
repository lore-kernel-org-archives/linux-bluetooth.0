Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5E81DFE26;
	Sat,  1 Nov 2025 17:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762016488; cv=none; b=BoAVWqhmM4x++pdAHlnJ24zQ2Fg9GMSQdu/fXM1PjoPSmXO0Kv5ODBaxW3H7JJePD4UuSKajLn7yUkMclNj4X7oNnAQwaRQahKDBui7oDjnfoVS8i+ZiXmHUyNFsD9asiKQC1h7h6o0enq/MOHb9nDppIWedLbgIljzYYCtXmVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762016488; c=relaxed/simple;
	bh=6cgCz2XhKQjeiHjZ9yJcICIYarnhGGJs7JtPlEcxyPE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PKRhTogapy1RoH2Yvik1egaVO8WxLAGYx0RW7PSQvQ3JbnjVQOYkd3To6mdvyAhjAgEDGv1zZhw8KbKTJ03yIO6uTbRwE/QOV+PQNdzADp2OasGRrZXvMv//X4sTMrMyFcx3ZZirT5G8UCZ2auP6ybbHaHCq/aibIWdCqG0s/OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=M+ZGUhmV; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="M+ZGUhmV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=bt
	PNQ78ofuz9BQtjwT/RO+d80HvZGd3wPR//jV3fT5U=; b=M+ZGUhmVALYPfSK3Ez
	zjS2Eo2eLx4bjjXoPHRIYNL1x/2olUx/CyZbFz9O2BmqzQG/NYZ7cH4NhMt4abU1
	m3aKbFVi10Dxj4KcXQM7zPZCHsjtNPRz9QiWdR/ijmYtm1a1bfsDdct0jk+K/gOF
	U3MpOZCuf/Uq+DIgqTNAbioGU=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wAXIUrZPAZpK7S+Aw--.48439S2;
	Sun, 02 Nov 2025 01:01:14 +0800 (CST)
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
	zzzccc427@163.com
Subject: [PATCH v4] Bluetooth: sco: Serialize state check in sco_sock_connect to fix UAF
Date: Sat,  1 Nov 2025 17:01:10 +0000
Message-ID: <20251101170110.179111-1-zzzccc427@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAXIUrZPAZpK7S+Aw--.48439S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCF17KrWrtF4ktF1xKw45KFg_yoWrJw1DpF
	ZrKa9xK34UJrn3uFsayFW8Wrs5ArnYvFy2kr10gwn5Aas5KFWFyr48tryUtrZ8CrWvyF45
	Za1UKF43KF4DWrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pimhF7UUUUU=
X-CM-SenderInfo: 5222uujfuslqqrwthudrp/1tbiXQP4hGkGO84QCQAAsh

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

Thread 1:               Thread 2:               Thread3:
check sk_state          check sk_state
sco_sock_connect(sk)    sco_sock_connect(sk)    sco_connect_cfm(sk->conn)
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
v2 and v3:
 - Fix the patch format
---

---
v4:
 - fix the subject prefix to "Bluetooth: SCO: ..."
 - in sco_chan_add(), also check sco_pi(sk)->conn and return -EBUSY if the
   socket is already attached
 - in sco_connect(), if sco_chan_add() fails, drop the hci_conn ref
---

---
 net/bluetooth/sco.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index ab0cf442d..b73ee71c6 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -298,7 +298,7 @@ static int sco_chan_add(struct sco_conn *conn, struct sock *sk,
 	int err = 0;
 
 	sco_conn_lock(conn);
-	if (conn->sk)
+	if (conn->sk || sco_pi(sk)->conn)
 		err = -EBUSY;
 	else
 		__sco_chan_add(conn, sk, parent);
@@ -356,6 +356,7 @@ static int sco_connect(struct sock *sk)
 	err = sco_chan_add(conn, sk, NULL);
 	if (err) {
 		release_sock(sk);
+		hci_conn_drop(hcon);
 		goto unlock;
 	}
 
@@ -651,13 +652,18 @@ static int sco_sock_connect(struct socket *sock, struct sockaddr *addr, int alen
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

