Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792823242AC
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Mar 2026 20:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773347184; cv=none; b=jnTQBvsbxbOUvjeS60hB9EhT/k4JnxR1IeN2/CPfNFptgxCGuAqsF2qzeMECHhBBHR8t6HNj275PEvmJPEXG7w+Nz9UWXeg4LlDWglXcg1hfpSsgIWdyV4CZGMhbAI2lyrK9931Yl3rwjcdaBJFIlI1xD3f8ksB94ca3xndCQio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773347184; c=relaxed/simple;
	bh=CpASQIffFxLfAe3+8LjkFW1uEgC8BNWZ/t8yIzocU90=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kJioXDnQQIj3hi/8NMTG6rNLQB2LABeEecjQAGgd3YWqNy4zeOyCbI27IQFl4K0uclgSc5M1jAqfBVuiL7Kr2AcVm6+Jpj8UbUTcpe8lmyDUYfRZ5VwAehkH+3AvfmJkNAxfZ+bwOMV0dNtIcGi36BfOzYoXXAq99emwie4JTtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PvaSeMvU; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PvaSeMvU"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82987437624so860683b3a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Mar 2026 13:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773347183; x=1773951983; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6sCw9AI75fXl0H6+I+rP9uqVCKt3V8tOkKl0hn17oBY=;
        b=PvaSeMvU7DLd6vAb+MtlS4ERfayxhCXGiVHF8CGZD7IdboXAWGcpcb09/zYWyF79s7
         sjQiN/fu0UXgFqBuRECNpFc5zVkloJowphWgHel/M550+hXLnJNEmnc3UmcLvsrOLjkl
         eWhMOJQqLDrhW+0MWGhJiYSWSdre3nPz8cuLELtHZ+KEiEhxxc9HrTmmNlPAZ9NuXTBe
         TEj7y1Ho7gT8VnzZBuN1DHfItwPOoAHhPrNw0VExnW2tAG1Je41G9CrsTK+POeZGvdB8
         hK6IKcXI4A6hHvQhawUyip0C0htFuzuv/0zPah5Q+PWIl8yHNlXcp52h629lxVbO3stc
         c3SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773347183; x=1773951983;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6sCw9AI75fXl0H6+I+rP9uqVCKt3V8tOkKl0hn17oBY=;
        b=GiFTM+xVDB9s4HBqCHacrJbxBJ4eACpLYtTMVgEUr9mGVXw6ASmFU6P1co6B+thczz
         1nV/Qw0sE+fHTn4r2M+8fQF8cbuUX2qvZ1RqJ688df+v5uloVD8Z2tCPQD3wXgR497KM
         DflBrfG0iBNGMLHliaGWy4R9NBvOtgLe40GKPx5h7pNGosmR1G7CkBj68HFF2kiE7wlu
         zCXmS5i8F1r9njoTpER9+lAdD6ex8TM2DJASIKfRXRi0UYz3Flsmce/Ebl/c9RFJGkCw
         GUuRKHyljHm6e1Xt2tP3QS49IAUwlcG+oc8oiomFpCxccr7+FbwtpJBLmdnRC7LL0MBu
         y0HA==
X-Gm-Message-State: AOJu0YzNFkgtiQdeN+ZVOiggyDooimhMvTiR3IpeLAgIlvWTf364xvER
	RxrNBTwfowe+cd6NygqYNxmlKzwmPxnfXMmXsXxyY8+/XGTC2NknKwwqN7UNeA==
X-Gm-Gg: ATEYQzx+WxiKY8+XpodUS2/CvJuGlVwXpjuTbcJz15mZ2k4PcCM6LYxyQorRqlA/e8S
	IPhWSNPiKk6SX+2HbW1kvP5GNw5Vhwhv4gydAXfY/L2YlMRdUGNqLnQjCqRUv3qo9oaNYQa7z08
	UV2fQ15j+6UGp6LeWyw+34jmGC/0BDjqYrcU2WC48vh41zulPUkga8DUoS1v9rKHfwgyEc6eIS1
	Me9FcWvN7sEnH3Vv/vrbqK4ijrCzP5mWFbO5vXp9zZDytNIUBYryL7uwIrgdr2JE+JKvtmGfmTA
	8TSEgOPJZxzekjFKhxAmJS0oHfQ9aemR/rMMmIMYVOy1dPePToYrnQGulPRgXIcbVf/8ps4LtIY
	8i3dcKxQ2XrQ2sHheB3EJ5so63kFNSofGPFIqJ45goK+gW6ikXOsqkt1+tfSvCoz2IA7553+Jr3
	9ErITJuD0UKsYW/QmR9Q5gAzgOwXbiGop2Okz9o2uR4g==
X-Received: by 2002:a05:6a00:a21b:b0:7e8:3fcb:9b03 with SMTP id d2e1a72fcca58-82a072c6dacmr3458246b3a.25.1773347182801;
        Thu, 12 Mar 2026 13:26:22 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a073419a9sm3933043b3a.42.2026.03.12.13.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 13:26:22 -0700 (PDT)
Date: Fri, 13 Mar 2026 05:26:16 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org, imv4bel@gmail.com
Subject: [PATCH] Bluetooth: SCO: Fix use-after-free in sco_recv_frame() due
 to missing sock_hold
Message-ID: <abMhaMILH0Db12LU@v4bel>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

sco_recv_frame() reads conn->sk under sco_conn_lock() but immediately
releases the lock without holding a reference to the socket. A concurrent
close() can free the socket between the lock release and the subsequent
sk->sk_state access, resulting in a use-after-free.

Other functions in the same file (sco_sock_timeout(), sco_conn_del())
correctly use sco_sock_hold() to safely hold a reference under the lock.

Fix by using sco_sock_hold() to take a reference before releasing the
lock, and adding sock_put() on all exit paths.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 net/bluetooth/sco.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index e7db50165879..584e059de20a 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -401,7 +401,7 @@ static void sco_recv_frame(struct sco_conn *conn, struct sk_buff *skb)
 	struct sock *sk;
 
 	sco_conn_lock(conn);
-	sk = conn->sk;
+	sk = sco_sock_hold(conn);
 	sco_conn_unlock(conn);
 
 	if (!sk)
@@ -410,11 +410,15 @@ static void sco_recv_frame(struct sco_conn *conn, struct sk_buff *skb)
 	BT_DBG("sk %p len %u", sk, skb->len);
 
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
2.43.0

