Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF13B323417
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Dec 2025 10:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765188037; cv=none; b=oJHf0Y/WMNAfo+QQ++IlQye/vFb4fvgZ8bC5nLbHSSbUSuRWMzxDvLla8UQXyw6GKqBFjtlBuqqYMVZa6swkqpUpOSoEVNDvTb/xgAjhj2NUMs5NLJMuBlDkJPxCIEUQmK3Xob+mLXLNBnYjTCjG8Q3usSdfem3ufMgqFjMqj1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765188037; c=relaxed/simple;
	bh=1XVDh3dp5tZIeFg98Vk6MbXMHXsKItcUhOubCWeyDfk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hAOXZfYg/H9P3v+XiY2Y6WxsmL2BRcWJ4pgRhqaM2so9bAez7R5eLX2X2LnHjlT7iXTW/4uMwdsAAsKpIX5dgmEhWoyJiSbwwvlY14P28E7/H/MeVLIs7M6p55k5tx7KkzRoxomCGuGTrtyR8tmDDC3OfDI+OTAaGpvNG6tedpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MIIdbvGg; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIIdbvGg"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7b86e0d9615so7421409b3a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Dec 2025 02:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765188033; x=1765792833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IkU8zs9uXFlGL15DzG+faC+I8uxG16rJuRvxzfu0Cb0=;
        b=MIIdbvGg9ol7WKWKmVc9k3WS2e+3ruMLSUXOgQBSgHoaybgqMq+oI4KUWRqQEsVRwV
         3CXylf5NyRPV84no9x4YbkWYu6VSF+T+axG95htSq0K5l5Ro/DA+Iq86we72Fy25kyl2
         pfPy2XW55esdGUj8iE6v06Tp8TEVRo4EsuC2rgonVFywPIt1nVCvl0xdrzPCYYlAttuE
         ZDRKyd1xEqyZKIaJUV6d8AiOv+mjMOPe94UN2jplILribWB+mWM+1Mq5eG+ZU+Ge72TK
         BcTtUXGiKxs6iDJe/GWRji3fVP9GYVnSUF1jMikR+sg4bCmMrQ6FUwp/1oGJ6W3BF86l
         RRmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765188033; x=1765792833;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IkU8zs9uXFlGL15DzG+faC+I8uxG16rJuRvxzfu0Cb0=;
        b=FcuYVCIPXWQbiA+AYZqe3qTbFRNu3hSdItBTbGuzZuoMeva1112HmknjkTLSo1bcmQ
         ePs+zT5HOFguk2xgznyiNccU+M9uK1RwDbzhlZGXG4mMqyWnKoAres9+VcsXC0SxBQqy
         xISnbqKkhFH+QcXzVtwqO0CKpiardwce7XFzWmfk3JE3MGFqUxjdmqc5Ax7YfOqhIdR9
         4S/vuWAnE0aMNWHTVRD/w8f3o9qlYwwd9g51sTaAkwQL7ca5lO55lKGB40rNLt1Y1gcw
         Wz/nZK/1/7xYt2WLbrFcukNCJ7KEFQ1QIcO0NKdyY/+CwWjQbS4iyEdKimj0F+aCIRDW
         h0BA==
X-Forwarded-Encrypted: i=1; AJvYcCUQWuaX7h4H/GHBfrYlVGMASfRO5CFeDCZ+FovyrrPrNOXE7y3JRAyk4BKxizQHvaUblyefyTeusMRkdC3fZM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbXkUycYx73aogkMYlq2yiSj0dwuYwBVkCMBxyq6R6+0P/sMaR
	XpvaELufYeueh5UxkFEwxXft7edtOrmYEgCQkkueZIOlgbOPSo5FxK2p
X-Gm-Gg: ASbGncsWWEU/kk4fw68YEHaIwzc1Ab45ya5JWwGNlnqLUDy7zbo1yYDykO/UThEl9bH
	ZB9YVWkYjb96OhOgLs57hAgc3iNZDa7UWz52YFCXCmEa1pd+i2uMFxDNxhe+9i0L8HuaotbHTRJ
	MDp4ulQkAcSPuuUC4pO7NRsc6TuC+HhUJSS6jgoIwhGh09/LD9IBlCe8UZp5anZNrOVYRIoEkpU
	j2XLL3OtqHdivBV45Ub1bycDHMXBxfE430fewT/A+OYxThgx4JN/rCR+EPSHPsQwHiUMU2CDxEZ
	N90g/ZCX07+zgXOcCRPpoz5jN6PI/p4+e3iGDHnWNa0pLpB7jxGKxKCFd3XHwE6bEDoVaKCr/hq
	oDwBzTQUA7XaDckkCqARzMZLIVymFSl0JvbiVRh9MCabm2FHBn7fOkDVlRP2SGJuLcltweWIlfg
	U+JVl0aC5eJb0yLsr3
X-Google-Smtp-Source: AGHT+IE8skWgTr1ANpp+hZqjpx4gPIQvsLmr6pB+ss0Mb3mXn02MVwlGOeCLyU/+/66OCSSiuKNn6g==
X-Received: by 2002:a05:6a00:1802:b0:7a9:f465:f25 with SMTP id d2e1a72fcca58-7e8c1e20f75mr5175128b3a.27.1765188033353;
        Mon, 08 Dec 2025 02:00:33 -0800 (PST)
Received: from lavm-prs74opxn5.. ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7e2af843307sm12648562b3a.61.2025.12.08.02.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 02:00:33 -0800 (PST)
From: Cen Zhang <zzzccc427@gmail.com>
To: luiz.dentz@gmail.com,
	johan.hedberg@gmail.com,
	marcel@holtmann.org
Cc: linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	baijiaju1990@gmail.com,
	r33s3n6@gmail.com,
	gality369@gmail.com,
	zhenghaoran154@gmail.com,
	Cen Zhang <zzzccc427@gmail.com>
Subject: [PATCH RESEND] Bluetooth: sco: Serialize state check in sco_sock_connect to fix UAF
Date: Mon,  8 Dec 2025 17:55:08 +0800
Message-Id: <20251208095508.3481977-1-zzzccc427@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
 net/bluetooth/sco.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 87ba90336..e065390a8 100644
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
 
@@ -651,13 +652,17 @@ static int sco_sock_connect(struct socket *sock, struct sockaddr_unsized *addr,
 	    addr->sa_family != AF_BLUETOOTH)
 		return -EINVAL;
 
-	if (sk->sk_state != BT_OPEN && sk->sk_state != BT_BOUND)
-		return -EBADFD;
+	lock_sock(sk);
 
-	if (sk->sk_type != SOCK_SEQPACKET)
+	if (sk->sk_state != BT_OPEN && sk->sk_state != BT_BOUND){
+		release_sock(sk);
+		return -EBADFD;
+	}
+	if (sk->sk_type != SOCK_SEQPACKET){
+		release_sock(sk);
 		err = -EINVAL;
-
-	lock_sock(sk);
+	}
+		
 	/* Set destination address and psm */
 	bacpy(&sco_pi(sk)->dst, &sa->sco_bdaddr);
 	release_sock(sk);
-- 
2.34.1

