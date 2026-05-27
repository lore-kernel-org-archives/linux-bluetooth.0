Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E11A126C17
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 May 2026 04:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779857986; cv=none; b=SzDku4w4NfAeYbptUjIwhs4knJRrwce6wnwUT0vR0Z/Fcd1UV08gwo8QqkV1U6+94rYSSqBGewFzbBZF/fr94gL79biYO5PLlNTKemfvzzL+w0l/gI71sLIkMrpalGORgA6dBXeLq08Ye3JpYOM//5qEJ6nLnge+SVv1hCairdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779857986; c=relaxed/simple;
	bh=XTXmDAUFvXvTiWqlHzjhD3yNcXPtaREUgWrMw5c6hLU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lCLLvfhKPj3V3O13bV0elD2sRJTDGf1xNr8YYkQ9zMVR/1f5jskcQO+2aR7hDfEsiS/3ky2YlXcEBVN4G7Qzgipylc39Uv/PiMUofpyiXyAYW9jGhr9uEvvH2eqChHm8cidZz+p2I6dM7Fo1KKWwJlXPLOOAYM1OqY030Ew4/1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZqrNXtf8; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqrNXtf8"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-82f8893bff3so5253718b3a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2026 21:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779857984; x=1780462784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uMxFDyzWsRKlVJURYrmPdEmoNvPZv2yVR/RX1zOeUzY=;
        b=ZqrNXtf8EAVlpCJvWtBZ0TLYP7weSQKQWO6pJqZgqudtfFjQCltHDZTQU487JmJYsk
         42jcpJSL/AH3lJ329FreexxZBjWgmgHfStBQXpSKdR1t6yYiFmPTGLQzfrmJXhYRQMBW
         Lg29mrdfgLxcWtmK9lodf+Se9KtV8fsfi5BCrtne37Ap1X9MSzTrxThMlGPUVW3xR+w+
         wIwRTRUsmMNywLcbALMrW17R7PK1dQF7P2//Ud5M/5pMVScbvR1zNJkjsI9/iU7c1/Ta
         TZRyrBzE4fV8X2E2JTVDko2+2TDC+xu54366XWBXsUJVLrCSU3FW4FEuQYES+x7gpsC0
         D/gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779857984; x=1780462784;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uMxFDyzWsRKlVJURYrmPdEmoNvPZv2yVR/RX1zOeUzY=;
        b=NiNkTkMZN2qQ0KGQ3AvD5jrGAPW7EdDCh+h9V8P9zraI+FakIvDBDZU986/PViIcTL
         DZLBb3mpgqJLgoNq5qhRzU5UKNlhQcY66pjj8IOtrvz7IM/UL7vDsUGtewCYUSt3vEeA
         191yazvdtTmCDgBDk2Hc9ukz+T++Rog+nYvu7mlfW2/97V2Qu6gaHRfXX7DGzLe88JVF
         GbNXSJD11utWSJigW2TB1H3pePlsRO55C1AZn3l3I1JkPbaI8QrioGHLH646O7tzfiS0
         dNLXdrSq/Gc+epOiRTg3aeoJOjMM7L2RUgfVfZo7JEKS7/WwnS1aCnRb5BlDjMbZWNcT
         KMEw==
X-Gm-Message-State: AOJu0YwMLscDyqTxhkLPJqO7IRAranekClUbV6TvNj7Qyjc2UQMlgSqK
	Fo5GmEw9Ojh9aWh4qCdtNHXxPLTLgZa6NyNWaeQSJVJkveTRU9lRf5jJSrMlzw==
X-Gm-Gg: Acq92OGuAJVGUJD/yTjFM9U69oApizuAy+lGeK45ip3ybrIPbxCYl83QnRyja7kExs1
	T3ti7+8U2T+E8CoadU3dZo9+w2zMaDEsa69SRH1drd1u3A2khb/hkwn8gVTDBZtHs+MFn1QjIGj
	L5WgXQb9hYiAdVmLLvGxmW3nWPtXI3P43xtbY1KeBB1ebhQrnp7BahGRrC4F6JOc/iarhtZP770
	PBU9yW9vhuExmHCvt9fdn3UqCz9gxFYmd0+3zTuCNa0gHxU7pxdfGBF+UgiEm8BpRpoauNGq0By
	AWroEG8CFf2Ns77fWvyowDIUyal8eaVghoz6yg0enNf65jHB7jFEQYCo7I+X2J+AgHOjjfQzTXK
	rdn+qb2sLu7R5fZXJmH9aUclLxof4AL86AsqKzOrSfXFGCAZq54snQQKbC6srqGJPcy0av07hsg
	zZDZ2NdBUU9Wn9Zu612VjyxSA/UR2Dkrhe/lZGM0ee16BvaqVHgWl+BA+ZiJ7WgPWEXe4BYX81f
	tpDhmRiN0V9f8/LtKyJ1bZawDP70QtqZJ79032aWv9/Lsg49Frbaaqubznenm78/SRzxA2HOBwJ
	gkNa2OOwu9rteyY=
X-Received: by 2002:a05:6a00:3911:b0:82c:dd31:b844 with SMTP id d2e1a72fcca58-8415f5e9a44mr19610973b3a.40.1779857984382;
        Tue, 26 May 2026 21:59:44 -0700 (PDT)
Received: from codespaces-78f0a7.2t4prynt4dlezbzls5ze3dxsqg.rx.internal.cloudapp.net ([4.240.18.229])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841d70bb19asm930900b3a.30.2026.05.26.21.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 21:59:44 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: stable@vger.kernel.org,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH 1/2] Bluetooth: ISO: fix UAF in iso_recv_frame
Date: Wed, 27 May 2026 04:59:17 +0000
Message-ID: <20260527045919.39077-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iso_recv_frame reads conn->sk under iso_conn_lock but releases the lock
before using sk, with no reference held. A concurrent iso_sock_kill()
can free sk in that window, causing use-after-free on sk->sk_state and
sock_queue_rcv_skb().

Fix by replacing the bare pointer read with iso_sock_hold(conn), which
calls sock_hold() while the spinlock is held, atomically elevating the
refcount before the lock drops. Add a drop_put label so sock_put() is
called on all exit paths where the hold succeeded.

Fixes: ccf74f2390d60a2f9a75ef496d2564abb478f46a ("Bluetooth: Add BTPROTO_ISO socket type")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 net/bluetooth/iso.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index d7af617cda45..f03b7fa5dccc 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -564,7 +564,7 @@ static void iso_recv_frame(struct iso_conn *conn, struct sk_buff *skb)
 	struct sock *sk;
 
 	iso_conn_lock(conn);
-	sk = conn->sk;
+	sk = iso_sock_hold(conn);
 	iso_conn_unlock(conn);
 
 	if (!sk)
@@ -573,11 +573,15 @@ static void iso_recv_frame(struct iso_conn *conn, struct sk_buff *skb)
 	BT_DBG("sk %p len %d", sk, skb->len);
 
 	if (sk->sk_state != BT_CONNECTED)
-		goto drop;
+		goto drop_put;
 
-	if (!sock_queue_rcv_skb(sk, skb))
+	if (!sock_queue_rcv_skb(sk, skb)) {
+		sock_put(sk);
 		return;
+	}
 
+drop_put:
+	sock_put(sk);
 drop:
 	kfree_skb(skb);
 }
-- 
2.53.0

