Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C9B29898D
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Jul 2025 16:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753806310; cv=none; b=AX0Vh5xek9DRbF4YcWza/oaEz3gHRZuuSFQep3e2ihEpo7Gv4K0oLkpEUWXx8PqLmYZ9y7WOEMmw0raHbGcV3ss7ppwcCYcOQAgO9Lj46XaF6L73FWuriUgQFbeApktfw0b+NKEAyqFEZEG/xNpvp6bUvE81vKT+vVKjh3LZiPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753806310; c=relaxed/simple;
	bh=NEd2Tf7H49pgHdO7rdrsVzn2xK7WxrmVg/NGQzOuJu8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aR5N+3sdWEyuBB+Wq/tSpZNPJdtkX8Pk7r0tMjRI/UuTEEnAWbWdT9n/fF3f67+4TEnvT/5CTjvKJxompuYbDMFPjirzsn+4tjzndvMXfEFf6S83qskUXX/VTx92+vqxAszJbyQ5aBnvRo1/XhDVQiJv6XsSTCFcBGMBkJMZq8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JvChwfnE; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JvChwfnE"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5314b486207so1914572e0c.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Jul 2025 09:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753806307; x=1754411107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=66s/I0IDDRgdBaXz+fBQqyoKsm1eef0GEc1hdRHWyzY=;
        b=JvChwfnEKtN1TStAvzt7GZDKRXwOKqhDg4mc0IR+wpqlDMYC2nAKUXdChd06JsO0Zy
         dDZEG3/jLOTGq0rhGLxSJRTy3fvYiZ+J3T1Fe9ggT1tpQpsWLj53R0sD7oVwCB+LvaLx
         ojnlRS1AAHKMDA5zlgAg6ua/iwXQQXjjqOBvt7RMxUX9KdqXoNQ3C/7bxzgA5zd2FN5D
         s5GB7zF4BckBRwK5gtuWXa9MQxJ/9GV461rJV4ajO4GsrYskVhJkqlF+2PnOGivsJien
         1B0av7rfEclZMXzkBc/JWe8LOqBUTg7rTI2smM3sPErW4McDQOAMT1v+OOrYk92InDaP
         qTYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753806307; x=1754411107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=66s/I0IDDRgdBaXz+fBQqyoKsm1eef0GEc1hdRHWyzY=;
        b=aCtBppUbPum+D2cS3P1ff1cS7JzBIMRhKBrnVT4434yLcObWD8U7F/ra2cUgz7qgGf
         gLrS5VrQmrMPjhCgbUDrSpErJC+qLCJ5Ly9+goBf+HWEPJGkxif7WBe0QJ8sCOH0X4RS
         xM29FeT79sxhr2HCz+5/Vq3UCyBlZcCkIRime2vpdWgAfVxFWXinO/kLO140lLsRrC+k
         +TADMdm8QPNlf4YNNDaOLpis9z+X5rdBYMR5pw4LJi41tOBlX1SCvBLJUH1slu8gSpym
         srgm95yzBd/88sFKYUGCsUrelUYFW1ZA8vRQZ7Hp+BMukcBdo05nZOcUe7x/bxw1w7/h
         mIkA==
X-Gm-Message-State: AOJu0YwbioseW6lx2dob+QoLPgT9fqfc6uXSRoqOChphGI/HWlC/rTiR
	+zs4JM/rhIjgUQRTN+CrAc1m4NxcjG6CzjZkBNmi7jKFORFPGq2GAqckX1pBZWJr
X-Gm-Gg: ASbGnctwAZLtuPpHbNeGXsHdBF2IGg1QwXcVfCR6uVqwDyuoijAuFOUiklIGDr3fTBL
	moG5XAblAnTnoelGRWrMu/h+QjwMNfJIsB1TqJvicXs3wR3hoALO3Euo5ldP86t4n25EwRBN5qb
	0I3OOgB2Y4o6H9h+Cavd2wpn0xJfRjZFIemqyLIRDE01OY+kr09DeyLFysVaPkqtlLP6Pxowaav
	Rmz7pgaeUXZgkdxEINdMShe77EpRTOhuv/eZPFFoUz0VNIy0JnfDY8r+afV1ZZZFhfWij6cwpE7
	0eQTnxnX2gTkwyO06eS4L2Z8K5zUem9OieqaRLb3MeMqJHb2TwUhSCjYwJ7411rrLvxajxknxFw
	7Ngu58fUQDzjiML/ZDqlPN5LX3oMBWr1uSwAeT5mRNyaKT4s/lNhBgkKxasPk4SOf
X-Google-Smtp-Source: AGHT+IE/eRSmw88ybQyMw2vURxEwUPd8tOOQFNYFe6Lhi4kR+kU0lkJIa9MTImOkz3rhbUIYgtmFkg==
X-Received: by 2002:a05:6122:88c:b0:531:188b:c19e with SMTP id 71dfb90a1353d-5391ce9e8ddmr427303e0c.2.1753806306812;
        Tue, 29 Jul 2025 09:25:06 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-538e288700bsm2139773e0c.27.2025.07.29.09.25.05
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 09:25:05 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/4] Bluetooth: ISO: Fix getname not returning broadcast fields
Date: Tue, 29 Jul 2025 12:24:51 -0400
Message-ID: <20250729162453.221656-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250729162453.221656-1-luiz.dentz@gmail.com>
References: <20250729162453.221656-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

getname shall return iso_bc fields for both BIS_LINK and PA_LINK since
the likes of bluetoothd do use the getpeername to retrieve the SID both
when enumerating the broadcasters and when synchronizing.

Fixes: a7bcffc673de ("Bluetooth: Add PA_LINK to distinguish BIG sync and PA sync connections")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/iso.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 7bd3aa0a6db9..eaffd25570e3 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1347,7 +1347,7 @@ static int iso_sock_getname(struct socket *sock, struct sockaddr *addr,
 		bacpy(&sa->iso_bdaddr, &iso_pi(sk)->dst);
 		sa->iso_bdaddr_type = iso_pi(sk)->dst_type;
 
-		if (hcon && hcon->type == BIS_LINK) {
+		if (hcon && (hcon->type == BIS_LINK || hcon->type == PA_LINK)) {
 			sa->iso_bc->bc_sid = iso_pi(sk)->bc_sid;
 			sa->iso_bc->bc_num_bis = iso_pi(sk)->bc_num_bis;
 			memcpy(sa->iso_bc->bc_bis, iso_pi(sk)->bc_bis,
-- 
2.50.1

