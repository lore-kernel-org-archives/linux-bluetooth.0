Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209F7348C63
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Sep 2026 17:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788973556; cv=none; b=g70z39yBbMT739+VJrldYcqccjoZXEJyRPMFQQCVv1eiFVUt3I9X9QVIcG29/mpGbcLUZD9UbOh4lmM1Fpr+Wf5oQNyprRZqgkmbJYTZkjzb0qsKC4I/J03uDsLK6aQV4Q51NZ4JoKFj50kA++O/65QV9AqrkUa7WzA/9PAi0uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788973556; c=relaxed/simple;
	bh=2vJcrfmtONiiZ6qszfDi4QNl+g1tcAIj9jSLqmWRXdI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=u5bkCjLjWYJ15OyGLpt3SXSicX82MH9ddpcHsszJD7XojPHz406jkDxxsGIOljEaFXYVLuogcKLzHPZTc0Sf5KUzTNP4WwUcFh1o3bLW5UEZzwh7Lu85xOyF9ndtuK2D+Y6tU1wrTK3i9GKoc/4bFa0iuhh365buzHtua4V/pv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HH9SGjV8; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HH9SGjV8"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5c7d1512dbfso4887285e0c.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Sep 2026 10:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788973553; x=1789578353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MtFmR3vRVuttZHqItlxYn1u428pMEb9u5utjpJKK+hY=;
        b=HH9SGjV8eX89EVfKfIJD27xxHfN+BRR9O1SQfR1YrkSPYpAlzqZxrrL+nTz+oPb9wU
         3xMJJZ8HDtnhEvHSOYZCaq7waWLWtYLJOpvC1xkxE0UQNxmG1RrEWrUvbDPP2YeGqW58
         7rVDqpge/6ZpsPMi6s+o/BMUgavgDbhUThUHDdIvSyPsmkALfnn142tHF2M5XgOzXW/Y
         RS8k2hld6L4LlJBVvqHinQCJop1enOEO8YB1z0xut9sFKwF598ob7dv4A1MVjb0/kf5H
         b2+ViMfigaszBSUW+vmzAqoPiJNX/xkcICTZbi8fvZIzK4nAPYu2LWWc9D/EjqtVMHYQ
         NG8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788973553; x=1789578353;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MtFmR3vRVuttZHqItlxYn1u428pMEb9u5utjpJKK+hY=;
        b=j1dvlUr/M4lZAsBaM2Pwk0NnPlmA/oMMVXawZ/rKDqdI3bmi9YiqHDWX8LqVx6t5eC
         KAjXATsvVZAZqvqYLJiizvhs6yQ2KzXnhLIW0TwJHnhMVXYs+GGpbCJXG8LrWu5QQb7y
         FEtytKcSqnPaRiguqyQxvdXynMvg0UmmfJZqjeUUynCikxhHf5iTiHQNkx1z8EG33eHD
         B0ltYMelz3AgSnIDCc/2E6RvdifGsPjRjGEOeTvynSRcaT7n1/mn4TkGWrE8IASaBfYC
         Jk9uaGhTdqO2yfrT5dL9CjvOoI+ygN7JvFsYtpQiIUQiLRQ+vQ7v07ayj7tiOPaJCcLO
         mV1A==
X-Gm-Message-State: AFuF++lldSgzcnkdrET4RqvpPMLhO/vKK5vmngobZLYxeoDgpbMpQyhx
	kOLizdYVJR3stC5MuDFyN6BqZG8SCrPLRiYscwz0/4euTYPMmYTIhV8HCWWhbpvo
X-Gm-Gg: AYBFou3mjtRW0/w4ig4q7OCcsOBQW52z6P3N/BGTG4ziUjdrT9KxJ9fgalJzrdX5v6E
	osNbslg8lhd+eKcK71lhUiVG+l1Y68+zqLvEcKrF4Aqj1MJSfgIuoKDzFegA3MYKwFCY3BSFDBH
	qF/EApcdkIpXQBMBPB43MmVAceGZsGZDuMHOgeT68wrBy9LSgla+FEZhtaNJAesIANQFDUL2nVO
	vM1lR7CY963myKif08aTmWRILWDCuCbDePU2DnDQTYVmv9dang/73yfrMrxTS/Ro+BmFSZ3MLhP
	w0LCVjfBWgCPdAEfoYLQ4yw8wMVbdf3NMHtiUuCVK6l1UbONjClXnSdTrALqfU/GIYkN/qcqxGn
	gmLeWuapY6gddGQPc7oBpmgoBCSx6J4b0ADzWvCR94tkzWNwYVMg7gtO68YGwpgOCzp9ijY9dXi
	I/fRyvso0fIgeAiEu3L5PtFF2OujTpkg+ZwVeP+SoGBS8Ek5oKyzg63CuGgYjYXaWfkAI9UXnZf
	9nLyXPC5CJQlCKibF3BiMoOHnUQKDyMiXd3AlUs8RqGdSUymUIOw/SpHIRf9cZRFQ==
X-Received: by 2002:a05:6122:8b11:b0:5c7:a844:493 with SMTP id 71dfb90a1353d-5c7ed2f89e5mr23477960e0c.0.1788973551255;
        Wed, 09 Sep 2026 10:05:51 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9808ee8039csm12766307241.11.2026.09.09.10.05.50
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 10:05:50 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: ISO: set BT_LISTEN before requesting a BIG sync
Date: Wed,  9 Sep 2026 13:05:41 -0400
Message-ID: <20260909170541.1245942-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

A BIS connection is matched to its parent socket by looking for a
socket in BT_LISTEN state with the same BIG handle:

  iso_conn_ready()
    if (test_bit(HCI_CONN_BIG_SYNC, &hcon->flags))
            parent = iso_get_sock(hdev, &hcon->src, &hcon->dst,
                                  BT_LISTEN, iso_match_big_hcon, hcon);

The socket was only moved to BT_LISTEN after iso_conn_big_sync()
returned, while the LE BIG Create Sync command has already been queued
by then. If the BIG sync is established before the state is updated,
which is easy to hit with an emulated controller as the command may
complete in a few hundred microseconds, no parent is found and the BIS
connections are never notified to the listening socket.

The user space is then left waiting for connections that never arrive,
e.g. bluetoothd never completes a MediaTransport1.Acquire of a
Broadcast Sink transport.

Move the socket to BT_LISTEN before requesting the BIG sync, so the
state is visible by the time the command is queued, and restore the
previous state if the request could not be started.

Fixes: fbdc4bc47268 ("Bluetooth: ISO: Use defer setup to separate PA sync and BIG sync")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/iso.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 75bfd5938b2e..dd4e1b9a7fdb 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1737,6 +1737,13 @@ static int iso_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 		switch (sk->sk_state) {
 		case BT_CONNECT2:
 			if (test_bit(BT_SK_PA_SYNC, &pi->flags)) {
+				/* Move to BT_LISTEN before requesting the BIG
+				 * sync: the BIS connections are matched to a
+				 * parent socket in BT_LISTEN state, and they
+				 * may be notified before the request returns.
+				 */
+				sk->sk_state = BT_LISTEN;
+
 				release_sock(sk);
 				err = iso_conn_big_sync(sk);
 				lock_sock(sk);
@@ -1745,12 +1752,12 @@ static int iso_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 				 * connection may have been torn down
 				 * meanwhile and iso_chan_del() may have
 				 * already moved the socket to BT_CLOSED.
-				 * Only move on to BT_LISTEN if the BIG sync
-				 * was actually started and nothing else has
-				 * changed the state.
+				 * Only move back if the BIG sync could not be
+				 * started and nothing else has changed the
+				 * state.
 				 */
-				if (!err && sk->sk_state == BT_CONNECT2)
-					sk->sk_state = BT_LISTEN;
+				if (err && sk->sk_state == BT_LISTEN)
+					sk->sk_state = BT_CONNECT2;
 			} else {
 				iso_conn_defer_accept(pi->conn->hcon);
 				sk->sk_state = BT_CONFIG;
@@ -1760,12 +1767,17 @@ static int iso_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 			break;
 		case BT_CONNECTED:
 			if (test_bit(BT_SK_PA_SYNC, &iso_pi(sk)->flags)) {
+				/* As above, the BIS connections may be
+				 * notified before the request returns.
+				 */
+				sk->sk_state = BT_LISTEN;
+
 				release_sock(sk);
 				err = iso_conn_big_sync(sk);
 				lock_sock(sk);
 
-				if (!err && sk->sk_state == BT_CONNECTED)
-					sk->sk_state = BT_LISTEN;
+				if (err && sk->sk_state == BT_LISTEN)
+					sk->sk_state = BT_CONNECTED;
 				early_ret = true;
 			}
 
-- 
2.55.0

