Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77519327210
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 20:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768510462; cv=none; b=r+f4j0i8HEW6hiD4/SISm3taaldtzMuwQMPd/jhEK+6brXa+qtwLcXQWfr8xLsVWGT4kXsYXFW1PVfQvxK1UGzmbMY/DmAwSZU+uJkXGDreOmv0SNBh+5CPmyiaOh5kORiPZ5bYaZzPzE80YPkXRNbt7S+vwGFtM3INJ3+jzGfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768510462; c=relaxed/simple;
	bh=JiyQTzShsanCdMhCFOuQu+3W2LB1zeTWbqEgrAt798E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pWgy+Ex/v6LtRlTkACH2QN3VsTAgCIQcditdawPBtBkKiWWyA0eHh39f8WT5UqJQicocBhvyywybL/pgozOwvhy0cprh0dsvWk+twrVTdad8vSE7IF4CNTnVTqJ6q5/37RsDBJQFKFdI6uaMbB9LWgfOBfBry5S3rnW1Usl9Wt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IS94C6gS; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IS94C6gS"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-560227999d2so513314e0c.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 12:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768510460; x=1769115260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vkF2VJJSDXUFFwr4555CnnMv7t7G2rRcFAEe6VI96ys=;
        b=IS94C6gScnyVNI4YJeRiVkeDrqNBRw+2Bsgo1X8/uGfj1mKDRlPray3J3HRQSWC+kY
         BD/ibVPSoF4QkShbmUOjbyDeSyLsCcFKFCPfCWPd8lJnTRdOqQ/elf7Ep9KtBxyWin3n
         UrHixktqKRJuBN8ORoQ/oqxDqc0ilhV3ihRUUb+u8v7cbkj6ZNDiHtVKTbBvJO9NZJjY
         8qHdxBbB0sxWemiDO3Vma4v+eGX+AHOMaFD4cX5cJ9T1GjsZCIZ+w4lQDjMyh+wiBl9A
         XJw+ekO5i0tpK3vdDY4gBKyW2jAKiozLtQLuv4UfLSUD9vpN+cgHOqcCkY3lwTDSo/2u
         J2Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768510460; x=1769115260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vkF2VJJSDXUFFwr4555CnnMv7t7G2rRcFAEe6VI96ys=;
        b=NMoE/izKwf2jwws49nxS7sHN3MgD2dY4TXarnqYSwDtzsF5k87XPFD4jEldT2Y5JX5
         IaW8e0SS2frqNdQO64RgHWpCivOfDptvXlMdcyg8IdxQCUHdLKBMeVzq7cP3wvptHENv
         D8M8bohoxhYeellwVkhxYGfY8Ece1gYrLPGPWrun7BH9dyOZZmErrC3hQL3GT5mh/5eb
         bYZb9YslURfJ95j5yoJGBO3KJQsVdY5N6mfekylpt7lzw9hJb5xt0F/Qs2HOAvn/Hoi5
         YQ7N+b6Qzmw+l406/HztIznjJzDXNvYXsi3ejG2V0NLQXG6Mlm+7JvWiNeMXwywcEHDT
         CJBQ==
X-Gm-Message-State: AOJu0YxnuTAliK0XBjZIG8h+v00Cn6fPou1zdgy2y1PaMP9SUYeFXC4A
	Ck1E1tFj40cyMqFEgk11c1m9rmnz57y4+wOwNXA0vuTFxY+9xN9LXH1NeEWuTdUX
X-Gm-Gg: AY/fxX49GOphpazn0FpqZFTYhLF/eN5HAKQeGzLKXaEvdkW9wi6DRYk8C4+IsGbdv3A
	Tg9YToQwn4NLOJiFzdIZQFEmNqdLniq2/DJwqhypNwGyAi4eqLRE5AjtjcZCEB4gMosbASQG2c+
	sK9N0zLtIFsnzQTiPWZ3nZaz7mkrLmuiSFtarS9ziuCVbkuzXrjkWISm1BpvPvzuSviGpzom+iY
	LC0Id4b5cj6+okC7yT+Embn01m9Qwjko9xoiIF681AvJyvMq9G3supK2IDLIhLs5RLU1eammbRo
	jc+zwbwrN9UnWH5k+1htz5kCkmQgkHiwDCVE12PGqtd53oMQbUw0qmqhOxpga+XquPtQPVWZ95x
	KotFJDVghUcvIIqBIQRq+FPo/spqE3kc3L/hjq5qXmErqoKoggsdQT5PVhJvFgEvqwF85idKOxx
	S/L8uwVMiv3pipurAxbnpNrxkesSfDgDE/b2eOWgwIT61WZhYgyK3h4j4D/woJ4+WY7KGRsKxLo
	VM/HTojCMQlhWUo
X-Received: by 2002:a05:6122:3c91:b0:563:746c:a32b with SMTP id 71dfb90a1353d-563b738c3d4mr115222e0c.15.1768510460114;
        Thu, 15 Jan 2026 12:54:20 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-563b6ffda3csm167159e0c.7.2026.01.15.12.54.18
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 12:54:19 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/6] advertising: Use bt_crypto_rsi to generate RSI
Date: Thu, 15 Jan 2026 15:54:03 -0500
Message-ID: <20260115205408.1554101-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115205408.1554101-1-luiz.dentz@gmail.com>
References: <20260115205408.1554101-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes use of bt_crypto_rsi to generate a valid RSI.
---
 src/advertising.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/src/advertising.c b/src/advertising.c
index ebdefcdb0586..5dc33c004f93 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -526,11 +526,7 @@ static bool set_rsi(struct btd_adv_client *client)
 	if (!crypto)
 		return false;
 
-	ret = bt_crypto_random_bytes(crypto, data + 3, sizeof(data) - 3);
-	if (!ret)
-		goto done;
-
-	ret = bt_crypto_sih(crypto, btd_opts.csis.sirk, data + 3, data);
+	ret = bt_crypto_rsi(crypto, btd_opts.csis.sirk, data);
 	if (!ret)
 		goto done;
 
-- 
2.52.0

