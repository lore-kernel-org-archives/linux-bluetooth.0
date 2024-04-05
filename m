Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC5A1C6A8
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Apr 2024 20:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712350117; cv=none; b=ZeLhemnY6n787u7eRVgGjuOS+ldSSrZxB9vEp0YNuvdM9eF0ZQxPXAtS08RHHleZ0T54IqZBFJi8EhQpPljrH52FULrYsnPM9DP/KyG5Fwkzs6FCLuAi7WJLNKGYmFh9vBARXsETKv00/twY8AL0zzmHHgmAF/JVaQ20iL/l27M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712350117; c=relaxed/simple;
	bh=iXNizauSXh66GDHlq1xzX42c+ElqefZx2lOfRicB8yQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tgT6dOtZiNcmNIkEDW+w+N4+dQ0auj7SZItCctDWvTMaGr5EvIl4eKDQOXhQVLvbcYUAjiKuwg0ulEEPu/2tDfcUQ54IOqGCQxBeu5KbrraYPgDXvTa2jjIbNoshSDTPxtdAcqA7E7kN0uXOBbOgzm7yYpAme062ipR0g3letSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cydTrfsY; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cydTrfsY"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4d88360fd7bso1857443e0c.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Apr 2024 13:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712350113; x=1712954913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nUCzNWsmkKyWSoZrbs7OPkZEkFyQh9bUXtmeEbSQTqg=;
        b=cydTrfsYNPoio0S0FIT7Uw5ajZ+8GoZj6wR0fmLbhiXhWuNrqvCW0Fr7O0VmKgi7Mk
         mYDTiNsy4eutyROFU5QPFyjhqa1W2rswALkeYGQSHwD+6AOVQPyIrbz9hPMq3NDlny3J
         C6zhOAIIFUQOfpbVyXS3veBM1URSqIj+qd7MvBdOuy9RVtPdgJB7JWdfqXNcgB7eNajt
         Ny9QPiKRioqzMafphsgd15dyLTtVJvooN2No9lmDoBPZlaNwfnpJG+xO2uTBMekNhSgq
         6k3CwKNGsWlvHi4NeZYlnSl0MkK3mczUC5HvzuVvE7h6mTJGg/NvxP5/WPNoSxfDfaIe
         h13g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712350113; x=1712954913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nUCzNWsmkKyWSoZrbs7OPkZEkFyQh9bUXtmeEbSQTqg=;
        b=pBbUzvkGNsJZp84Ek1w6q6aBs12DwTFod/Hrx1RvgKSYq/QaYepoO9HhZHaQp7Dq9t
         V+/KOxPnPnDb2U1DwrmIvQ7LsBHvpFM03mhGFviVQifJmuYm42mQUhhrYlakPolGKmze
         fCY24+hGCtg9qUeg6i31+mhidGgqk5yO2bSxS5BXq4DpcehFcN4+j2F3wN4Z/SP1ASWm
         zeRUIxv3/XIZfP7GzhIOyVkvxI2ZQKlbSeEl683tYMyqX9dlavZnZiu1LIKZG7I2bvSD
         hiH3MDyfMMRnw+BRgnXnlOzC3HugeCt2qzDC4cgyGcC7M1OgL8YxasFFKjJpzyV+ipcp
         NV5w==
X-Gm-Message-State: AOJu0YwGLh31ASWj1QAQgxWSCyILvAwRAA376ukmzYA6H0f/yR2Mie2m
	QnOXOFYfav4ulp84Kk0wSmX0G+fNM8cP1SZVYY6vTaW5pfICHIVC8KZ7IE0V
X-Google-Smtp-Source: AGHT+IF/gf3ZQ6p/M5LgEHlvrRtrsl+7L3fxKTIATP3Hq4PQSWEm7P0uhcvBBhvwDPdYrUuPHX+yeQ==
X-Received: by 2002:a05:6122:c8c:b0:4ce:96b7:c2f6 with SMTP id ba12-20020a0561220c8c00b004ce96b7c2f6mr3553465vkb.5.1712350113541;
        Fri, 05 Apr 2024 13:48:33 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id y72-20020a1f7d4b000000b004d8a496db23sm336004vkc.1.2024.04.05.13.48.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 13:48:32 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 3/5] Bluetooth: L2CAP: Fix not validating setsockopt user input
Date: Fri,  5 Apr 2024 16:48:25 -0400
Message-ID: <20240405204827.3458726-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240405204827.3458726-1-luiz.dentz@gmail.com>
References: <20240405204827.3458726-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Check user input length before copying data.

Fixes: 33575df7be67 ("Bluetooth: move l2cap_sock_setsockopt() to l2cap_sock.c")
Fixes: 3ee7b7cd8390 ("Bluetooth: Add BT_MODE socket option")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/l2cap_sock.c | 52 +++++++++++++++-----------------------
 1 file changed, 20 insertions(+), 32 deletions(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 7846a068bf60..b8913fbd77ce 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -728,7 +728,7 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname,
 	struct sock *sk = sock->sk;
 	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
 	struct l2cap_options opts;
-	int len, err = 0;
+	int err = 0;
 	u32 opt;
 
 	BT_DBG("sk %p", sk);
@@ -755,11 +755,9 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname,
 		opts.max_tx   = chan->max_tx;
 		opts.txwin_size = chan->tx_win;
 
-		len = min_t(unsigned int, sizeof(opts), optlen);
-		if (copy_from_sockptr(&opts, optval, len)) {
-			err = -EFAULT;
+		err = bt_copy_from_sockptr(&opts, sizeof(opts), optval, optlen);
+		if (err)
 			break;
-		}
 
 		if (opts.txwin_size > L2CAP_DEFAULT_EXT_WINDOW) {
 			err = -EINVAL;
@@ -802,10 +800,9 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname,
 		break;
 
 	case L2CAP_LM:
-		if (copy_from_sockptr(&opt, optval, sizeof(u32))) {
-			err = -EFAULT;
+		err = bt_copy_from_sockptr(&opt, sizeof(opt), optval, optlen);
+		if (err)
 			break;
-		}
 
 		if (opt & L2CAP_LM_FIPS) {
 			err = -EINVAL;
@@ -886,7 +883,7 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 	struct bt_security sec;
 	struct bt_power pwr;
 	struct l2cap_conn *conn;
-	int len, err = 0;
+	int err = 0;
 	u32 opt;
 	u16 mtu;
 	u8 mode;
@@ -912,11 +909,9 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 
 		sec.level = BT_SECURITY_LOW;
 
-		len = min_t(unsigned int, sizeof(sec), optlen);
-		if (copy_from_sockptr(&sec, optval, len)) {
-			err = -EFAULT;
+		err = bt_copy_from_sockptr(&sec, sizeof(sec), optval, optlen);
+		if (err)
 			break;
-		}
 
 		if (sec.level < BT_SECURITY_LOW ||
 		    sec.level > BT_SECURITY_FIPS) {
@@ -961,10 +956,9 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		if (copy_from_sockptr(&opt, optval, sizeof(u32))) {
-			err = -EFAULT;
+		err = bt_copy_from_sockptr(&opt, sizeof(opt), optval, optlen);
+		if (err)
 			break;
-		}
 
 		if (opt) {
 			set_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags);
@@ -976,10 +970,9 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case BT_FLUSHABLE:
-		if (copy_from_sockptr(&opt, optval, sizeof(u32))) {
-			err = -EFAULT;
+		err = bt_copy_from_sockptr(&opt, sizeof(opt), optval, optlen);
+		if (err)
 			break;
-		}
 
 		if (opt > BT_FLUSHABLE_ON) {
 			err = -EINVAL;
@@ -1011,11 +1004,9 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 
 		pwr.force_active = BT_POWER_FORCE_ACTIVE_ON;
 
-		len = min_t(unsigned int, sizeof(pwr), optlen);
-		if (copy_from_sockptr(&pwr, optval, len)) {
-			err = -EFAULT;
+		err = bt_copy_from_sockptr(&pwr, sizeof(pwr), optval, optlen);
+		if (err)
 			break;
-		}
 
 		if (pwr.force_active)
 			set_bit(FLAG_FORCE_ACTIVE, &chan->flags);
@@ -1024,10 +1015,9 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case BT_CHANNEL_POLICY:
-		if (copy_from_sockptr(&opt, optval, sizeof(u32))) {
-			err = -EFAULT;
+		err = bt_copy_from_sockptr(&opt, sizeof(opt), optval, optlen);
+		if (err)
 			break;
-		}
 
 		err = -EOPNOTSUPP;
 		break;
@@ -1056,10 +1046,9 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		if (copy_from_sockptr(&mtu, optval, sizeof(u16))) {
-			err = -EFAULT;
+		err = bt_copy_from_sockptr(&mtu, sizeof(mtu), optval, optlen);
+		if (err)
 			break;
-		}
 
 		if (chan->mode == L2CAP_MODE_EXT_FLOWCTL &&
 		    sk->sk_state == BT_CONNECTED)
@@ -1087,10 +1076,9 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		if (copy_from_sockptr(&mode, optval, sizeof(u8))) {
-			err = -EFAULT;
+		err = bt_copy_from_sockptr(&mode, sizeof(mode), optval, optlen);
+		if (err)
 			break;
-		}
 
 		BT_DBG("mode %u", mode);
 
-- 
2.44.0

