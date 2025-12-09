Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343CC1FF5E3
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Dec 2025 03:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765249470; cv=none; b=NYgBXtbHdQmVFkl7KWKmpn8MPEz5zjY5wzZZHqT7fSG1gH1k9iQzDXBBpxMKVUUAz4HbObTdflg21uAzp3A5Br90XqxF7XulLI4IdNy++dk1JNSOnV1EXGpptCGVBaKnuHKnVsfh1onhwQfJH9QmWn1GSlm1qfoJpPSIgVbL+KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765249470; c=relaxed/simple;
	bh=zuBrqI+k3375lYwxSM0TM6yyCytWdN8NMXde9m2lkOI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l+qFTA6hTL7WpsezJbTLA1tqGDVvXSjsW23l+G/RjOhja77wozW/vn5wWGfnsUS4uvIPye1JenWl+HjrMjaIY0azd555Q90Em+Sw2cjAPmjYSMieIH8qp6S1QF1HdyGZXOKYJaVjpO8THREdwOHig0BpHnpuMXeydp9CreKgaos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U/2V/7tH; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/2V/7tH"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7b8e49d8b35so6344480b3a.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Dec 2025 19:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765249468; x=1765854268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jwe69yxioHlY4ZbFKre52tYc0WMZ/6kY9gk8OVirfXo=;
        b=U/2V/7tHhAquhiWwteoAIrV6wHfwIOlHi6AlQn08aiBWjiSZt7CkElH6aPczW/Kc66
         SapJ7BL9AemEPk8InXos5Dx+QiQ2lg+Zw8+wuhlLDo80Q7bLPQOWZnRtbnLrOeHqFKjk
         BhyNByZ6ZjmHvVYuRw0gRthiCwm0Y63Hm/y3kRsJUDN+DKrSOOSBpx+HFuTG2CVnrDy/
         dXM4tP6lCxRawh3Lq7UpgHCEvOBvFTwLddD71alugN9ypgLoxNB5bKmTGx6U5Qf2FByU
         o6wVOHj8GGBkIvcYDM7JzAT5HHgAyABRUrIeegUkyuCb9zom8jhSOPzNigqd+gurkL0D
         ZleA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765249468; x=1765854268;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jwe69yxioHlY4ZbFKre52tYc0WMZ/6kY9gk8OVirfXo=;
        b=EXAPU4gSAwMV//wwTT9bBJ5W3x1TXp8b5ynDkj0QqQSdMrtIQBgFsaR8wCPmFJUG2N
         Y4gLjWhv1IeyBym9hI5vzONPMvRbiyAVsZ3PS3//y/P7SN42VddXMZQsNZLLhuFPaPf5
         ZZty9+68WqYuPgeDQJkdpnXOZmuZQyGy6Tse97cUo2uTCbBLbtBI85hHj4rUsojWXQkS
         LxE2uXZRwrK9r5pNYXgxFLO859gltaDK1ZKlfziDI5aQ36Jl/u/5gJYoK9mRQcH1NFbX
         aBc4mB0TBVfiyh93qjKXrjrlXwYZgcovqntivnJ0gZKue2p/2OXhgkFXNE/DkHEZaS6M
         ZV6A==
X-Forwarded-Encrypted: i=1; AJvYcCW/AjwalRyS9geXNUKGC7G4kmTwb5hIXwXXegU+Kzga4Km3ZsXNCdkV/BnLtxBg71P+tQH7TiUlTT8ho4me8Nk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOK/Fc0msBoDKjwXSt8V1SMCBIYU6+Df4fiUFJXPL35aYHaXnx
	d+VoM3yeXnaIJTWtOnYU3Wue3XCRx5TSBpr/EfgesZoqGigUkV53laRB
X-Gm-Gg: ASbGnctvvJvZLCkQrbwZXy0zIsrhl6nkUhJx1Rswc/uavWU6k//thi1Tg/79wg4YCxA
	vSxiH32s2hswgeOrtYd2IFZtlDLnETuf1OgU5IJTnnraSK6OSARgTzZPG/xIixDYa7ycwSeNfMc
	P0/nEHV3QLxyIlAcnw8hdtaAPzMMZvGq3gsD7CfT6qshaROHmNAM8XUBd484ejCNZZt2jmcPcHx
	7lcaXp/A60IPSWh3Byb1oWimBbjbaMt2DKdRUoEhuPI+szh12SX09YqFzQOnhGUgdPv0JNnaWio
	Vzuct2JF6jkA5TIjdmfhoFpXwqYXdaJapouxRTbRNEvvV3Cil/adYy/77IwH0on3OTPnj+c5Idd
	1VFFa7ynMGI1e2zYpB9SejMqpxim/f76D7tAs8Zl2Wnkb0tA2kqaxwBsUzmOI411JYBHXvPnMz2
	Ieq17sMDzYqgG8Rnjt
X-Google-Smtp-Source: AGHT+IF0AYr51+oXX9VH+qtdgIAirX3IdK6su9cVXslzsV/sUvHzb9PNFfFOPDZ9KSIm3lZkEYNiEw==
X-Received: by 2002:a05:6a00:228e:b0:7ab:21ca:a3be with SMTP id d2e1a72fcca58-7e8c04fd601mr9300446b3a.12.1765249468360;
        Mon, 08 Dec 2025 19:04:28 -0800 (PST)
Received: from lavm-prs74opxn5.. ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7e2af843307sm14415879b3a.61.2025.12.08.19.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 19:04:28 -0800 (PST)
From: Cen Zhang <zzzccc427@gmail.com>
To: luiz.dentz@gmail.com,
	johan.hedberg@gmail.com,
	marcel@holtmann.org
Cc: linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	pav@iki.fi,
	baijiaju1990@gmail.com,
	r33s3n6@gmail.com,
	gality369@gmail.com,
	zhenghaoran154@gmail.com,
	Cen Zhang <zzzccc427@gmail.com>
Subject: [RFC PATCH v2] Bluetooth: sco: Serialize state check in sco_sock_connect to fix UAF
Date: Tue,  9 Dec 2025 10:59:45 +0800
Message-Id: <20251209025945.3555605-1-zzzccc427@gmail.com>
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

---
v2: Try to resolve the issue of incorrect lock usage.
---

Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
 net/bluetooth/sco.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 87ba90336..cf590219e 100644
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
 
@@ -651,8 +652,12 @@ static int sco_sock_connect(struct socket *sock, struct sockaddr_unsized *addr,
 	    addr->sa_family != AF_BLUETOOTH)
 		return -EINVAL;
 
-	if (sk->sk_state != BT_OPEN && sk->sk_state != BT_BOUND)
+	lock_sock(sk);
+	if (sk->sk_state != BT_OPEN && sk->sk_state != BT_BOUND) {
+		release_sock(sk);
 		return -EBADFD;
+	}
+	release_sock(sk);
 
 	if (sk->sk_type != SOCK_SEQPACKET)
 		err = -EINVAL;
-- 
2.34.1

