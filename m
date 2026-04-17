Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDFF3A4507
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 13:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776431491; cv=none; b=QIh5+ZXmaGkbe2TImtXy7uzU8thggjtP4+Cx5gaJQg5vVO8yJjcO0fzGcf2tg87sqxjAsr+V1dtOS8eK8h+wGXasPE+kG0ZpJvbGwC+D6reCFUKoGZiLsYYsm1dnIEg6UEtVLf75DDwjWGEX+PXnwbM0wIEbDYDmQDAXPkCXupU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776431491; c=relaxed/simple;
	bh=2l6+VruZCe2G92lMFTOG+EfNer+jq/4dC3nqnXbD9Bs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bgbB4lXl0NDvI3pJMiNngD9hfmQAaROD9Xia/zAKLxsQd2heTe3vfQKWUAUkEbcCO7PxUVUNDC531OEgzmLtElatPr+x+/6Zxb9aX0M/nkagvobz776uPFHzzlt5FTGpkynMiBg3aEZgL7IOmzIPgYrxfWFTfpaeV0OkLRLt+pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=q2TmRER5; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="q2TmRER5"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488af96f6b2so9109085e9.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 06:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776431489; x=1777036289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KiTXMXyGgbry+1smTdjpHYLgWhcXFX/mZbw63wGDKJA=;
        b=q2TmRER5keY5WW2wPfyZIUAAn9rMC5RCl3jgFM5/FFZzQTUpboDKSaokoh9xwLCZ1c
         Yw3ER8xaLSf2aUr7rVjNZMXHFNaA6Mb2P1LHSIGWmUkaJWmOH5I/8V7gnmqm+sljyv0u
         Q7U/Hs0ydITGwUq49QEi+fXnXTgZFgachTSrPyRc21rSAmWYu8i7X/O168XnJW+fDIn6
         cVhsENzBNny27jVYf/l+uydYKOnIShDPI3ZEsOoIgZmrxVZqPUeuCZLs0FrVgPY9UoyG
         b9RvXS9bieCYyZJaVDMh1BmW8wk1yIdVUgqkQmVZJw80McuhI6dHaLN/M9dtPl2njWVM
         ZKVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776431489; x=1777036289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KiTXMXyGgbry+1smTdjpHYLgWhcXFX/mZbw63wGDKJA=;
        b=DIugwdHwb/xtWONun9rUbql9/R5FIWOCkL0DdLsZQ1lApq/tpcT+q9YH2SQfhHcNOY
         bMyOYj2E0sitpxhrSKzNjVxAJSh/6dlUFCU6aRz8hFiGjnEonZCSoS2l5CRAXiP3/3m8
         P6piqueomIhkjjWR7tsbYiNF7yMj/GovnHe4lLA7ZvPXzrhddKDnReh5aBN+7R8djhfc
         ZdkOgimzHcmxyOjXOonpZNFqvyEaqfBbRE07uqYnXmb/xp8uSpJfW33s1C9GZbtDF/Qi
         uhuCA/NrDgQ+QBE1oNHU3RQqn3aFE/BZShPJRbZ7Poxk6KPB5fFzcHL6rx+7YIvgdFY+
         1lFw==
X-Forwarded-Encrypted: i=1; AFNElJ8O/r5D7eUjo+Sk5DjJJ4WBzQv1OR3pD3ILetFm4LFOdCfaNDBPgk8XHWLL7jeRsBOJVMr3tkgumxhsM3E286k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww/tbZSM1iDXO49ThTtajH7I+pktqEEZHxwpd+u8DV4+MVN2ze
	j/ljy2M22nGX60meZiT/oMP+28waUNRoR42v0hk5e3heI5lyVzCAXfxeozPj2X0iiy8=
X-Gm-Gg: AeBDieuZilgfy6y5p06DvnM4IUSvC0r8nNVU+s1QRrN2Uidzqwz0OssAInmcrHdqY5y
	G0pt0cc68brgy/2+ozgXlzUOAJ5TeMLF4n23Cn30+7TmPeL5Sexk+g0Ls06rEQm/xfTYuH+JKek
	enSIEd9M5kPcKwdrYKRyYNL/o1OPLaxyR+pISTrqygFLL/Ne2wBwtmMwFtRoLeh9y/vM7OcOyux
	y3xUwL0k4p4LynziBhsjvdHybhQ15y2crCZCPL3n6ircLLmu7BDEZuxjNKvYmfvO052qrehQWMi
	r8NDHBLV8PTclgLRC/DnI/aYpK3+rir9kbDp3jikN+iwhZOqu23gGEQ63nb5ckpGDBwLpoE26Z3
	f8mhQcDaIhtOLnzv6Lyvn6OiDGRkJsn+OZ2z7oxD8vH3P9RWJ28gJi77U2gcDoq5cSpYxZCp7Yz
	oijc5GWXnZnJrv/GWgpYFkCmqpr8mqkG3KMr4z3GyN4OW/DbIaabFJMC5CBae52XVQxRR8oq4nT
	dRddMCqM1UA8nHc3AHLLvT3pPTebaRb/tg=
X-Received: by 2002:a05:600c:6297:b0:486:d76c:fa57 with SMTP id 5b1f17b1804b1-488fb77155dmr40662045e9.17.1776431488705;
        Fri, 17 Apr 2026 06:11:28 -0700 (PDT)
Received: from localhost (p200300f65f20eb08db61cfc60d8aa232.dip0.t-ipconnect.de. [2003:f6:5f20:eb08:db61:cfc6:d8a:a232])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-488fc10019bsm47077255e9.4.2026.04.17.06.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 06:11:28 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: "Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v1 3/6] Bluetooth: btmtksdio: Make use of driver data pointer in sdio_device_id
Date: Fri, 17 Apr 2026 15:10:49 +0200
Message-ID:  <06f26b3e090ea52c7a2620759e91511570404ec4.1776429984.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1776429984.git.u.kleine-koenig@baylibre.com>
References: <cover.1776429984.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1468; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=2l6+VruZCe2G92lMFTOG+EfNer+jq/4dC3nqnXbD9Bs=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBp4jFefmfBzsGZ3kLo9zeNLh94uuX0wHZ82YrGA IzIlV9GZuaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaeIxXgAKCRCPgPtYfRL+ TqVpCACTT3vbVLQ2hxvR192QyFytoivzueoZDb7jatdZDvJrGkXY/SJpKAnv9gc7tTavtwOYXhV L7rr9SxPzSvrm3zD+tvpqyfbLoKqfGvY3AVSSl8244v/FpXMDNxScKr3vYhEkizGEik/1XdcnB3 AW8x/CqjVCy9e75Lwpx8EInxLRJZEbAfqaiX0exiAd+fe+EndihAzVbnujmTdKL8ma/h+gLj0eB mG3HY/e/6niSjndyNC/AvCXSlLgv3xR9Eg2yeDtxVe1/blvgFVPWaTjeUsEueV8dDHxLhU+f7vs T09dLoBa8K/yteXcNJ/kWIajTt4k3fRJTctpa2WxJWDTRszg
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Recently struct sdio_device_id gained a new member to store a pointer to
driver data. Make use of that to get rid of a bunch of casts.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/bluetooth/btmtksdio.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index e986e5af51ae..ee886dcada63 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -64,11 +64,11 @@ static const struct btmtksdio_data mt7921_data = {
 
 static const struct sdio_device_id btmtksdio_table[] = {
 	{SDIO_DEVICE(SDIO_VENDOR_ID_MEDIATEK, SDIO_DEVICE_ID_MEDIATEK_MT7663),
-	 .driver_data = (kernel_ulong_t)&mt7663_data },
+	 .driver_data_ptr = &mt7663_data },
 	{SDIO_DEVICE(SDIO_VENDOR_ID_MEDIATEK, SDIO_DEVICE_ID_MEDIATEK_MT7668),
-	 .driver_data = (kernel_ulong_t)&mt7668_data },
+	 .driver_data_ptr = &mt7668_data },
 	{SDIO_DEVICE(SDIO_VENDOR_ID_MEDIATEK, SDIO_DEVICE_ID_MEDIATEK_MT7961),
-	 .driver_data = (kernel_ulong_t)&mt7921_data },
+	 .driver_data_ptr = &mt7921_data },
 	{ }	/* Terminating entry */
 };
 MODULE_DEVICE_TABLE(sdio, btmtksdio_table);
@@ -1352,7 +1352,7 @@ static int btmtksdio_probe(struct sdio_func *func,
 	if (!bdev)
 		return -ENOMEM;
 
-	bdev->data = (void *)id->driver_data;
+	bdev->data = id->driver_data_ptr;
 	if (!bdev->data)
 		return -ENODEV;
 
-- 
2.47.3

