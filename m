Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844741C6A8
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Apr 2024 20:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712350115; cv=none; b=Tjk+340IVtrdpIgzTYEEjNFAltUCvZTPEqprD/eP9T8Fz0B8I3nOxiPXZ3fPWQXEgiYwVoeTC0EPNIVV9+KfHwaeOsM/UCwVz0t3o2QlDvRiim7arQffUdQFJGtJLxADOWao8f6cMvQzLSJjqekoopULrkXZ5aWlzK/VcZ3uxY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712350115; c=relaxed/simple;
	bh=scB375BcgWKyVs7APGKmlH3BNN9sCzGwZGn3kP93Dw4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jy7JxW7Oq5gUNMbqkd99DXLao2BMa1OiF4FA5+tCMLcd/KLCrXG5cW8a/cBnIQs8KI4vpqTmWM0q0VW0/dD/dpOnJWNB3VAOVjmUtx8syPWZtAB0hLXgnAfw9QpVhvFiNnLHwLN5NDYpiVP9qH+A10FhVskNHZ9jW7rxcHVfECI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E4pIbMy3; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4pIbMy3"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4dac112e192so213848e0c.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Apr 2024 13:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712350112; x=1712954912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EJ8oPaEsLNRDFCeZl16WX8XecPaorqdlk6SPAFE/suI=;
        b=E4pIbMy3wtfZR8w39WoE98Ip84EcWsRtChVILMU2pN6XRExia8BmwzcfkKvgWWd9ey
         yMZgI080RoAuoa8ZNaRNZS7u53ptrmC8YOdmAAoKHtMpMdJEvlpw846beg5rthugKfLc
         nQ/MzwIAViv42JMDVfKcKNK4UsTLsCaioWVPvPpNuCV+qCKFjhuCds4yHMOokmY9o3cf
         hQT1qa+5GHMPw/cegyb+QHn+1j0BbB1i3hZkKgVyKwUK8Eujq/8sAt0FPw53fc1hThd8
         +/EJ3J+eBCa/xfeSa/ksAJFuY+lxIoNRySWKXozSktrVuqsD7XsPvBMcQLykglNu4qkI
         8VSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712350112; x=1712954912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EJ8oPaEsLNRDFCeZl16WX8XecPaorqdlk6SPAFE/suI=;
        b=hEQnQSjtWpz2De0czETYs9FAuEswN0sg04hAVUNjaOYGCRItvykDJCGYA9vnZ+OLHP
         pTLzpAzgUdkZdH8YVYsMhWVRXCvcoEemnlnQ4WGlyb9NXeJYggozlZ5F+uYHoCbjUSaB
         A/Scmzd2sWujLYtiUDcY38l1taqOBFNDkY9KBO2nAwfCQWLL+wk4O7+3jsbfB+FGidQV
         BWJfTl7TQ3g5pVahJKC4NzbBX+4Rytxpgx+xjcapYgACVTkW2ldidNL4i9fopvnG8mDo
         5HdiW48FrK+DMqNfBugy/1yTDGtyFxVuEPr+PxqapggLLpQe9CDOwSyyRoxF0cq2n81M
         UNoA==
X-Gm-Message-State: AOJu0YzxjVYwAY9L8FNrZ0Jo2+cBQ+0D/vUAYT6ALfSn5b1GfDEJ7VvR
	vuflEnkhcWqP/PvF3PcJ9UAWOlIT4vheEtbKMnglhCzdwzBKsY6pzPxRrdUk
X-Google-Smtp-Source: AGHT+IGddPNusUbMtHnK6LR6MMJDd+ZWvCO1/xgJWvvOk6aAid2a5/pDb8cYwu7GlgBvSFaEj3+Osw==
X-Received: by 2002:a05:6122:3903:b0:4d1:4e40:bd6f with SMTP id ep3-20020a056122390300b004d14e40bd6fmr2934655vkb.10.1712350111784;
        Fri, 05 Apr 2024 13:48:31 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id y72-20020a1f7d4b000000b004d8a496db23sm336004vkc.1.2024.04.05.13.48.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 13:48:30 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/5] Bluetooth: RFCOMM: Fix not validating setsockopt user input
Date: Fri,  5 Apr 2024 16:48:24 -0400
Message-ID: <20240405204827.3458726-2-luiz.dentz@gmail.com>
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

syzbot reported rfcomm_sock_setsockopt_old() is copying data without
checking user input length.

BUG: KASAN: slab-out-of-bounds in copy_from_sockptr_offset
include/linux/sockptr.h:49 [inline]
BUG: KASAN: slab-out-of-bounds in copy_from_sockptr
include/linux/sockptr.h:55 [inline]
BUG: KASAN: slab-out-of-bounds in rfcomm_sock_setsockopt_old
net/bluetooth/rfcomm/sock.c:632 [inline]
BUG: KASAN: slab-out-of-bounds in rfcomm_sock_setsockopt+0x893/0xa70
net/bluetooth/rfcomm/sock.c:673
Read of size 4 at addr ffff8880209a8bc3 by task syz-executor632/5064

Fixes: 9f2c8a03fbb3 ("Bluetooth: Replace RFCOMM link mode with security level")
Fixes: bb23c0ab8246 ("Bluetooth: Add support for deferring RFCOMM connection setup")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/rfcomm/sock.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index b54e8a530f55..29aa07e9db9d 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -629,7 +629,7 @@ static int rfcomm_sock_setsockopt_old(struct socket *sock, int optname,
 
 	switch (optname) {
 	case RFCOMM_LM:
-		if (copy_from_sockptr(&opt, optval, sizeof(u32))) {
+		if (bt_copy_from_sockptr(&opt, sizeof(opt), optval, optlen)) {
 			err = -EFAULT;
 			break;
 		}
@@ -664,7 +664,6 @@ static int rfcomm_sock_setsockopt(struct socket *sock, int level, int optname,
 	struct sock *sk = sock->sk;
 	struct bt_security sec;
 	int err = 0;
-	size_t len;
 	u32 opt;
 
 	BT_DBG("sk %p", sk);
@@ -686,11 +685,9 @@ static int rfcomm_sock_setsockopt(struct socket *sock, int level, int optname,
 
 		sec.level = BT_SECURITY_LOW;
 
-		len = min_t(unsigned int, sizeof(sec), optlen);
-		if (copy_from_sockptr(&sec, optval, len)) {
-			err = -EFAULT;
+		err = bt_copy_from_sockptr(&sec, sizeof(sec), optval, optlen);
+		if (err)
 			break;
-		}
 
 		if (sec.level > BT_SECURITY_HIGH) {
 			err = -EINVAL;
@@ -706,10 +703,9 @@ static int rfcomm_sock_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		if (copy_from_sockptr(&opt, optval, sizeof(u32))) {
-			err = -EFAULT;
+		err = bt_copy_from_sockptr(&opt, sizeof(opt), optval, optlen);
+		if (err)
 			break;
-		}
 
 		if (opt)
 			set_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags);
-- 
2.44.0

