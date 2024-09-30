Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24811514C9
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Sep 2024 19:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727724650; cv=none; b=Waswfp+e8wiK8GrDodb2KPrPR3XfQdGpGXMRjec2JWlOHGpjItB1G9LegvigcW5a1HM6YNPwqCBEvQ70ib0Pc52Djz89Xsf1CgfDN8iSEWlpLSeTgtmplGQ+r5hgrZ8ZvkXRhkJXmiVMJ2HocZfiNp+K7PmZsOKMzXXBbwnoTfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727724650; c=relaxed/simple;
	bh=/b+gsPVuyPaVSP71MAlIW80vA5n0QNd1zI8QCC9Ynt8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=L5mApZcVzbsD/gqQpTczJktH2VVHW2l1KY8Q+TrO6Rs2wObUoABSiQ6tNWOrmOSCG9zMtCQpI8ilIEolflskvTM4Lsqmjn4LTCHjJy9+FILKEYfkw6jL4EyPTz6dwiSfYBXGthDlYftgGtaEUe/nCG/TAlf53WsruaXBYRNeupc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bR7c8JI3; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bR7c8JI3"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e262c652f99so167242276.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Sep 2024 12:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727724647; x=1728329447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=OkDsgt1f4U8H7Pj7Y2ppusMAZHpfUVV2u+6EYx34DBc=;
        b=bR7c8JI3LxLxaBDgNSgrtR0vpmSGhtDnoaDyjofH2H7UCjTCceAf/Iq7YMzVCgASpw
         1BVFeKbYvUMT6TKbi38AlgQYPltxJSXBvzOi8z6n8KSTgfY09O/cwwNW7C5dAuMLVLqH
         59Ol+wzDcUx+B2DZU4osl0WWxPR2nQIhRZJZixqZYiYtfH6lh2eiuetKjGRoDtsae7n1
         CLiOirYwluFAV3ASgYM6hpDh+txi8jM1dDDjHv00HngcFmLkXRLUXEh5QlT1Rzol2Wd1
         zP6JNwqL727XOEyeqikNqs5u00e6xWDNuxlhOz2qYyZFBgN2s2RZ3HGuevzlztaRJc2m
         gb+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727724647; x=1728329447;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OkDsgt1f4U8H7Pj7Y2ppusMAZHpfUVV2u+6EYx34DBc=;
        b=azu7ofLykLXc/Se/8AXoA0MkOgK726Ep9b/D8hvrulpa4qVNUUcPA6ZXOa4JHBWiHf
         hqpvSd0MV3RYrUyA497HrVdKS0J72Fc/hnumfFKlZn5xms4nA5yFFIkONCLI2yNKhgFv
         lCu3NTObb0MidI2k5tqxJNqSGXZi9tLmIfwKEL27AxcBGgPtoUy5gLNsR4AMXRwU7hH2
         pLOwlEhGAvyADINzDrK6LZD1jO67yYVDUDhUuoIztARJ0uZa4aOFWH+GXWMnBOn7ahnc
         e1B9KbnTjYhsEXxvnVxCkTnC8GM7SEm0rUpHBd6P/+wFw4eg0U8Fawg75OrEjR8840kb
         iJmw==
X-Gm-Message-State: AOJu0YzH7yDlJAK6ngIpNOadCW4Q1GNlUKkLs0Km6EloLLiTxY5Gn4/v
	UwqrRkZndh+lWE5eyW3i0GHltGxj1ZfEG3DdQbS8tKEpU7wlsRMfyUkfRg==
X-Google-Smtp-Source: AGHT+IFHqkXzFmRzbL6CiWbqnmfUgpKY+7JfZbe9qEn8Fc7b3Bj4XYYuRquEIHHm0g0Sd+1/9IKU9A==
X-Received: by 2002:a05:6902:c11:b0:e22:59c6:5d2f with SMTP id 3f1490d57ef6-e2604caa689mr11181057276.51.1727724647024;
        Mon, 30 Sep 2024 12:30:47 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e25e400f721sm2465810276.14.2024.09.30.12.30.45
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 12:30:45 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: RFCOMM: FIX possible deadlock in rfcomm_sk_state_change
Date: Mon, 30 Sep 2024 15:30:44 -0400
Message-ID: <20240930193044.2907716-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

rfcomm_sk_state_change attempts to use sock_lock so it must never be
called with it locked but rfcomm_sock_ioctl always attempt to lock it
causing the following trace:

======================================================
WARNING: possible circular locking dependency detected
6.8.0-syzkaller-08951-gfe46a7dd189e #0 Not tainted
------------------------------------------------------
syz-executor386/5093 is trying to acquire lock:
ffff88807c396258 (sk_lock-AF_BLUETOOTH-BTPROTO_RFCOMM){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1671 [inline]
ffff88807c396258 (sk_lock-AF_BLUETOOTH-BTPROTO_RFCOMM){+.+.}-{0:0}, at: rfcomm_sk_state_change+0x5b/0x310 net/bluetooth/rfcomm/sock.c:73

but task is already holding lock:
ffff88807badfd28 (&d->lock){+.+.}-{3:3}, at: __rfcomm_dlc_close+0x226/0x6a0 net/bluetooth/rfcomm/core.c:491

Reported-by: syzbot+d7ce59b06b3eb14fd218@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d7ce59b06b3eb14fd218
Fixes: 3241ad820dbb ("[Bluetooth] Add timestamp support to L2CAP, RFCOMM and SCO")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/rfcomm/sock.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 37d63d768afb..f48250e3f2e1 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -865,9 +865,7 @@ static int rfcomm_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned lon
 
 	if (err == -ENOIOCTLCMD) {
 #ifdef CONFIG_BT_RFCOMM_TTY
-		lock_sock(sk);
 		err = rfcomm_dev_ioctl(sk, cmd, (void __user *) arg);
-		release_sock(sk);
 #else
 		err = -EOPNOTSUPP;
 #endif
-- 
2.46.1

