Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648F21BD9F0;
	Sat,  1 Nov 2025 14:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762008043; cv=none; b=N4NDSIJCwM+0N93OSaXMAS9SJF/M/7jzgZa2c3MyU9wGC1k4Gw0ghJOJhdPrJoFixi23ZB0XnEf0jLw+eoutqt4F54Puv0Nyo/4QwTcDdh8qUKvLzOmR9ITwT0Vq/pR+Fy7ZlnxqG8dOI3sqOQobojJtlEQIe09Iu4JSMh6ThJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762008043; c=relaxed/simple;
	bh=wx2j3MswhoxUK4tUM4MFH9dlK4bbicOdsQcKqMmWSdI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=daudHkvS7BJQTI1N10KeweD0aIk+5UxJDoKySiZhQCN1wxR3F09suxzhYh/wVVce5PWReqAdeKX1rp4ad2JQVT/6CMmyBzrb2e3pJovebSgfn7b5MHj65Vywb4RdI2HvlY+SImW1XMt9dX2tvsSJB9425AjqnPc0JktMa/AHDeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JvPlEtkV; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JvPlEtkV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=GJ
	2zCIHiKG62pgfqtGy6VnLIxl5DOG0adzVxO21inlU=; b=JvPlEtkVp05tNt53dv
	o9w/1fMK017qUS0ecjnUAWmsMekftOCP9F4wJQUIRsVkYM3T0IHxoTUyvtRygfAn
	8UZUoymNA/XYRcHyA45uCYZwqnbMgcBRxnXxoaOSxwlHbYxw9WblKorKp6gkcNI1
	8PlQofu6KgyLgiLz6GRXv/bYE=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3n77WGwZpZ0jBAw--.46548S2;
	Sat, 01 Nov 2025 22:40:23 +0800 (CST)
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
Subject: [BUG] Bluetooth: SCO: UAF due to concurrent sco_sock_connect() on same socket
Date: Sat,  1 Nov 2025 14:40:22 +0000
Message-ID: <20251101144022.177197-1-zzzccc427@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3n77WGwZpZ0jBAw--.46548S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGF4rtr4fWw1xCFyfAF18Krg_yoW5Gw4UpF
	Wqga1Ska4DArn5ZFsayF18Wr4kZrs09FW2kr10grn5A3s8KFW0yF40yr4UtwsrCr1ktF47
	ZanFgrW3CF4DWaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piG2NtUUUUU=
X-CM-SenderInfo: 5222uujfuslqqrwthudrp/1tbiXQz4hGkGGawciwABsh

Hi maintainers,

I would like to report a KASAN use-after-free in the SCO path caused by two concurrent sco_sock_connect() calls on the same socket.
This race allows both call paths to proceed into sco_connect() and eventually bind two different struct sco_conn objects to the same sk. 
Later, when sk->conn has been updated to the second conn, close() can free that conn and the socket, 
while the HCI connect-confirm path still references the first (stale) conn/sk, triggering a UAF.

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

Representative KASAN excerpt

  BUG: KASAN: slab-use-after-free in sco_conn_free net/bluetooth/sco.c:94
  Write of size 8 at addr ffff88810d2be350 by task kworker/u25:1/88
  Call Trace:
    sco_conn_free net/bluetooth/sco.c:94 [inline]
    kref_put include/linux/kref.h:65 [inline]
    sco_conn_put+0x49d/0xfc0 net/bluetooth/sco.c:115
    sco_conn_del+0x46d/0x8d0 net/bluetooth/sco.c:280
    sco_connect_cfm+0x83d/0x1ee0 net/bluetooth/sco.c:1468
    hci_connect_cfm include/net/bluetooth/hci_core.h:2082 [inline]
  Allocated by task 294:
    sco_sock_create+0x22d/0xc00 net/bluetooth/sco.c:616
  Freed by task 295:
    __sk_destruct+0x4b0/0x630 net/core/sock.c:2373
    sock_put include/net/sock.h:1962 [inline]
    sco_sock_kill+0x64d/0x9b0 net/bluetooth/sco.c:526
    sco_sock_release+0x770/0xa50 net/bluetooth/sco.c:1359

Reproducer and race amplification

- A easy PoC which triggers concurrent sco_sock_connect() on the same socket and a fast close is available here:
  https://github.com/zzzcccyyyggg/Syzkaller-log/blob/main/UAF-in-sco_conn_free-due-to-concurrent-sco_sock_connect/poc.c

- To enlarge the probability that two connect operations overlap (i.e., widen the race window), inserting a fixed delay right after the state/type checks reliably reproduces the issue in my tests. Concretely, after:

  if (sk->sk_state != BT_OPEN && sk->sk_state != BT_BOUND) {
      release_sock(sk);
      return -EBADFD;
  }

  if (sk->sk_type != SOCK_SEQPACKET) {
      release_sock(sk);
      return -EINVAL;
  }

  add:

  /* increase race window for testing */
  msleep(2000);


We tried using the following patch to fix this bug, but it seems to have failed.
https://lore.kernel.org/linux-bluetooth/20251101104522.174388-1-zzzccc427@163.com/T/#t

Thank you for your attention to this matter.

Best regards,
Cen Zhang

