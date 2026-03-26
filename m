Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9281A262A
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Mar 2026 12:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774529346; cv=none; b=cUYxCMRv/H1WhYsRLGoQzBdF/nqjRbOxwFH4OtBO0FLbbq22Mt64yPoQfPpGNvCsJQCUrgIivDWMnzkdgXCg3UZGOwSr5RCnq5+Xur0/OcHyLow9rjQeVVXcdDjWMvgwZv0HbwRnJUMJs7+Y/M2G62D6GvP8xEEkqfqjEYTbz0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774529346; c=relaxed/simple;
	bh=8has8JRxmDNwqbe5Rn9NFL/jk3QRhGwc9DpE42EKgJQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZL0E+kVEZMznsRolbk1qHoGMc0+jNrCpO10rrFnynWWoFOnv1SD/dF2KtDVBUyp8lNW8uGeESUyXXAwDQgNLwCSy4GVlCzd1P2ldBIlnb9wODgrG/ifmgjqnBkf81EuTk8EPTnFpZIFcc0n+a0xAGmrySlUSLikOsSvlO+L9GW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EcSBeYIW; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EcSBeYIW"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c7412b07f22so935994a12.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Mar 2026 05:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774529345; x=1775134145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LL5u+eySuwC4h9vk77ymZ7rOJb68kKa6ErC+eNN2nqE=;
        b=EcSBeYIWDjA1Wfk+xjsml0TI98YqjkxRuM7w45EFVH3H52/6QNbmNoxvzKxfH6o3t2
         KHl3CbtrhKgGuKFjZT/4RXPL6rBhVLrjyQT8aiOZ2Ykd7Uf0GCmG/+efhyeFor8ypFJr
         eUydJETDDzFwOjY7YYU3Pn4fcReiX2vXA3ypwiqlugoZ8nDhwf74uJ9Ozo2J8h82ALAX
         S2czBBy5E6qT6eFdn+DvjtPfuVMrL+qgcVtahDLmDr0bZSfCSnbSoCbg5acIRlWUnYU5
         qKy8qt2yULgsUq3W54wQ0jHLDLowpMzmHH5fwfTkd0jl7Z49sna179mEVg5Qq7cYYCfO
         49qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774529345; x=1775134145;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LL5u+eySuwC4h9vk77ymZ7rOJb68kKa6ErC+eNN2nqE=;
        b=jrXiFNw96BGGHFD5BMGvvdiRo7YpeO3l4LQS7P4sV5zQFUl7MrZcPer0QLE/lmm2xr
         SQ+kdiBD8fBB4XBoeE46INbFwHdeOW69V/xubuzCEtoS2vAf+Y8VbxotS3AHZMnHZEz6
         XwlpulbSfoO3OzHAl6tFpaYSHcppAINz5uPG9RxTwxYUfrgcwYnsz/ZwKA00vCk111nz
         SahF+A7Qd6jx133W9JzYNFugy4CVLSa45YvpSYgdn9ceJw8pXmuNsz01oxRu4qND0wa8
         9McLBz1vxmKZ8fMP1j0/VKGrHsT7MX3F079o+MmyeR2d0FjEVdI/G6SDujg8h5JSygTw
         gR2w==
X-Gm-Message-State: AOJu0YzFmEd7FXcNY/B+zy+6rJ4mLlN6eAdwdT3iciYsTu3pWGkP1LkS
	apO9LEAVIwle5viSYr+FdQhFpl4ynx9bifensxoBaIeHAMvWvrrUXN/j
X-Gm-Gg: ATEYQzykQoPRdELgaZT6if9UqEAAD9xiyh/MnaDN4qTDVFs3sa3vrOUaCyfSCWmgr1Z
	P7dG4/eJOmVv1IGpRVCqvHOwGQ3Tpjev9Iz+Qo5cX0OgD7/enHM3ilucSG+Es664EI+43wD6sHA
	ssqfX3h2D37t1J/FjRL+wQS+l/SftMS6flmptGvnGP52J8n4OM2wHxppXBzQ3/B+8HcnMz22BdY
	LyoBZTxVhGO8gelsBvEt5OKAntwHYzyVpcbhQ5dMNKHEhqpBfycirVadmF5h/VfTbGt3HceF9bJ
	YJVbr4Gbboo1Sz/0iJjow8pLNmxpoilRp2E/USzqBrasStscaK8460qGxRze+j+K5JpPc8kRKTZ
	nr7m6O/zB63MBbPx0TJ6leVtw9Az+d00j32oJaSqbx7TYmY3RgUrB2Ig3n59mPPf2VrG0UopIA6
	3F9ffGBIOGsUsphH66Bu4IkU0bGxUn
X-Received: by 2002:a17:902:ce05:b0:2ae:4d6b:b2c7 with SMTP id d9443c01a7336-2b0c4857d4cmr14315585ad.9.1774529344624;
        Thu, 26 Mar 2026 05:49:04 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc8be006sm29673155ad.60.2026.03.26.05.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 05:49:04 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	Cen Zhang <zzzccc427@gmail.com>
Subject: [PATCH] Bluetooth: SCO: fix race conditions in sco_sock_connect()
Date: Thu, 26 Mar 2026 20:28:42 +0800
Message-Id: <20260326122842.13664-1-zzzccc427@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sco_sock_connect() checks sk_state and sk_type without holding the
socket lock, creating a TOCTOU race where two threads can both pass the
state check and proceed to sco_connect() concurrently.

This causes multiple issues:
1. Both threads create separate HCI and SCO connections
2. The second thread's sco_chan_add() overwrites sco_pi(sk)->conn,
   orphaning the first connection (memory/resource leak)
3. If the socket is closed between the state check and sco_connect()'s
   inner lock_sock(), the connect proceeds on a dead socket (UAF)

Fix this by:
- Moving lock_sock() before the sk_state/sk_type checks in
  sco_sock_connect() to serialize concurrent connect attempts
- Fixing the sk_type != SOCK_SEQPACKET check to actually return the
  error instead of just assigning it
- Adding a state re-check in sco_connect() after lock_sock() to detect
  state changes during the lock gap
- Adding sco_pi(sk)->conn check in sco_chan_add() to prevent
  double-attach of the socket to multiple connections
- Adding hci_conn_drop() on sco_chan_add failure to prevent HCI
  connection leaks

Fixes: 9a8ec9e8ebb5 ("Bluetooth: SCO: Fix possible circular locking dependency on sco_connect_cfm")
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
 net/bluetooth/sco.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index e7db50165879..689788ad26a4 100644
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
@@ -353,9 +353,20 @@ static int sco_connect(struct sock *sk)
 
 	lock_sock(sk);
 
+	/* Recheck state after reacquiring the socket lock, as another
+	 * thread may have changed it (e.g., closed the socket).
+	 */
+	if (sk->sk_state != BT_OPEN && sk->sk_state != BT_BOUND) {
+		release_sock(sk);
+		hci_conn_drop(hcon);
+		err = -EBADFD;
+		goto unlock;
+	}
+
 	err = sco_chan_add(conn, sk, NULL);
 	if (err) {
 		release_sock(sk);
+		hci_conn_drop(hcon);
 		goto unlock;
 	}
 
@@ -652,13 +663,18 @@ static int sco_sock_connect(struct socket *sock, struct sockaddr_unsized *addr,
 	    addr->sa_family != AF_BLUETOOTH)
 		return -EINVAL;
 
-	if (sk->sk_state != BT_OPEN && sk->sk_state != BT_BOUND)
+	lock_sock(sk);
+
+	if (sk->sk_state != BT_OPEN && sk->sk_state != BT_BOUND) {
+		release_sock(sk);
 		return -EBADFD;
+	}
 
-	if (sk->sk_type != SOCK_SEQPACKET)
-		err = -EINVAL;
+	if (sk->sk_type != SOCK_SEQPACKET) {
+		release_sock(sk);
+		return -EINVAL;
+	}
 
-	lock_sock(sk);
 	/* Set destination address and psm */
 	bacpy(&sco_pi(sk)->dst, &sa->sco_bdaddr);
 	release_sock(sk);
-- 
2.34.1

