Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455C8172BCE
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Apr 2024 20:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712349666; cv=none; b=rg87RJCrlLjD6twE9NUEIohzq0YaiE+QGMGy3G+I/DJRZz79m7az8H3s3b8iVSYAJDNyJCw7fwXYwNZzkWwAPHOQfKjUB7jNoa4JqRLtELHuxgKuxER9nSO5Kp3KP73yBwTyrv5J14BqqcZCZeBJ4qi3ufxi6Vv3+orLdW4o0pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712349666; c=relaxed/simple;
	bh=scB375BcgWKyVs7APGKmlH3BNN9sCzGwZGn3kP93Dw4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qEv12PhpTn1IRiJ/++HJgebuww9LzaHQ6T5HPYN2KO37YStCOD7VtUTtiySAFdSf+Bn+Sl7i1ZYxkrxW0YcUml4ibHU38aP7CxujHLYbBAhaX7XnG3baFqOBRZztsdmKeWivJA51R/0GSM78ldV5Pe8SlZN15Vqwppzpa//tJxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hRi5NIuB; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRi5NIuB"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4dac19aa9b5so264868e0c.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Apr 2024 13:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712349663; x=1712954463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EJ8oPaEsLNRDFCeZl16WX8XecPaorqdlk6SPAFE/suI=;
        b=hRi5NIuBH2OAamaONFKMZX8iHhKWXAS5EO9uu96MGGGuJtLcfSgD8dz5Aw2w7o3ITK
         PdYHHJnGgxXxUHIYv/syxjips9UCQ1nax4/lv9nflkO9mgm9yUCGPBA0dGLq4a5nXVIT
         ZKIzBjsW3KS1FQUw/NUZv/ZrXYoKLJHUBWl2n75AfIZU5iEewbGAMtAKG8uyU+n1ZrXz
         VA4tYz9QTkWtvA5t9luiRbxU7EdIJ9noZV5qxNVH55wchCPZi4b3vu/2c9PKfNU+jNDf
         hBbC1zxcj22oNYxNHIVspDmvwdGK5OxM4YOHXCq+giY6pM/v5loyHI5irhabS+MsLQiw
         ZLpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712349663; x=1712954463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EJ8oPaEsLNRDFCeZl16WX8XecPaorqdlk6SPAFE/suI=;
        b=gex1d4NeqR66R0+q4+0CUJFch3D31cvLhpomCPAtABSXuFA7BoeO4K2Nfbklvzo8+F
         RlgjOrDMa0IosgFPat7P9Ci4rHl6qBehimaElxqxhifqZEadv3WlmE7DYDImFg+uOHu8
         gEbS2ysjeqm5sXZnyZDc9ljiVlgijEeTXL9McrrQ6PpTPFBXfyfCHVlw8aOnCju/mv4W
         fmbRYm1ZgpRs/LxEZ3yPs+8bIhWL2/avC2GRGRFNJguwJk9sHKvXj4wPEHHBXxKCz0sM
         zOlmkzLCFIA0ei3vca/4PTLpoRy/f4+e/3qy40RYqmnRc9f3Gtmbly0XX1UOQU+cfY3B
         Zxiw==
X-Gm-Message-State: AOJu0YwZ1hil8Q6OfF+iXTXiKulq+W6dzC7xNLhq/pt5fl8mUF5smQcy
	j7MgVSfeJ4By4ckZxOwc8LyHM4EAY2jhesVPOdDjn3883+5by9Y1ZYXLz0tM
X-Google-Smtp-Source: AGHT+IESyv451olDS/UHqDXehGRyW8zWMpH2hapEU4yg46QWkwxPjEVw4uQXZPTwowzZ1mchjJeDYA==
X-Received: by 2002:a05:6122:1c7:b0:4da:ab0f:4a86 with SMTP id h7-20020a05612201c700b004daab0f4a86mr2226343vko.9.1712349661095;
        Fri, 05 Apr 2024 13:41:01 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id l76-20020a1ffe4f000000b004d89b77e45asm326510vki.51.2024.04.05.13.41.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 13:41:00 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 2/4] Bluetooth: RFCOMM: Fix not validating setsockopt user input
Date: Fri,  5 Apr 2024 16:40:54 -0400
Message-ID: <20240405204056.3451243-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240405204056.3451243-1-luiz.dentz@gmail.com>
References: <20240405204056.3451243-1-luiz.dentz@gmail.com>
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

