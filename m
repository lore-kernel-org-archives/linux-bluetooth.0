Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795625952;
	b=wtNaGIm3CnEh86wg4dcFdQCMOj1h0IUqlTXnR+43/sC5DQf9qHon6CNdDV7YF0BraSAL
	 j9dbVa4xUx+4Yk+PqyEOeT2fibC6nHw6Pjd0iY3u518nOyaLYzxsIz+IoquteQxOlhipK
	 jXpGPW010q3+a799ZLzeOKA/FwW2A1K+xgxssPmh5A5XoVsNUN5C8tSCPiEmA6JcfaBRE
	 hQv1ij8Hi4lRoiZnjn9Q57RAX+UUyro8e2LnWkXSpqqSo+G2ZyUwbfinUNZs+nldTVesc
	 hFflZcU9chLipf7pLVhhEeEq6TJMdaN/xJy4hOYZdVB+5gYOS1OaXsvX9aCX0jqLSlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795625952;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0mAJQG8ulHT90AuRb4hTHoYK+0v5iUp9TI0hCYb+ozQ=;
	b=mEg+JygQjhzilbIEl8NJF3WsR6G4R2OZhX9tJ8dd/uvUGFk0pv4iY/lRKxHXX1hDeV6b
	 +Xq8Mk5DMo4ey35chL9h2HbpX/eEDg4gPS9Mc7Vj111FMNCk5zE2Cl3RpQdBknTO/q0fc
	 k+EWAMV/9xmxQ3ZL7SWKWNRDgKWDGxrN3CcOGnmsgsZ8poQ7FSEtcod+QcXIocC86Y56U
	 sU6IDy48OXykP4ps34jeKV7BfrVUbTrwu7ISo90r6nOpoVVZD0yJdgKscr30AEDVYK3Ky
	 zQTSn1tXum2qi7R0UagpWYNdEnE91cv1ipgt1OwyReH3rs9uykQg27NZTVtiTBSkncw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=qELd9MYs;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E64B606A339
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 16:59:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E64B606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=qELd9MYs
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a9a8d6cea8so77879375e9.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 08:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795625951; x=1796230751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0mAJQG8ulHT90AuRb4hTHoYK+0v5iUp9TI0hCYb+ozQ=;
        b=qELd9MYsIZv54xA97rv9ynEolsus/5dowfP5HSW6poMrmssSdQ9b3x9ALPmUz9NefB
         CrZohrPPyM0/SydO3PUmz9+MLAEb95cAsOB/tmWQnFUAC4DrMm1UjSIpZ7pRVSz9ZHIv
         O5V/x/1PmzvUFc7fVsHNo6ln1xIae7Bp4iPNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795625951; x=1796230751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0mAJQG8ulHT90AuRb4hTHoYK+0v5iUp9TI0hCYb+ozQ=;
        b=TsH4Dchw2kS7G56GudCgCbW7RwkTgTLZPCawX0WZW5FatoNh5uDxWaY1SUKzVaBwPf
         oCLP6cbPg1H4XEbQZIybTSQ/fGbuTD/Eip8Wcqjgg7e0kf0BB3jqTnbEby3aDy3T8gwe
         4GTp4+MMkOBUMmGBcqmYgGc+I9OFNcceKnvFkA0awwJkC8pgeukJozbWYNGQdbhoaDkZ
         EVwY0PlnWyCh7ZbP8RTZ2+B3ZBTwdCht/zkN8o4mZ2KMyeCmzGoTFar6YZ9gJ1ONidM4
         CDm9drzLKppWBM2+gTmDllvqL2VKr9HQZbjsclAWorvpgAZtHtfcFE2vmSY6iR/igCUX
         889w==
X-Gm-Message-State: APuU4Z80AAOAXWU9ZCZyfANiTvmBomkgFiSGbc5WJTALI0gl3pYIEF/H
	e1PqPclTwOFxzDlIswwHBezRVAdY1U2qFtIHHhEzYvHjjsQpoTLWtCNduG0eHUmd36BAKiEMj91
	58WcG
X-Gm-Gg: AZFdTZfGLlkI/sbqsyCaVQkOZdJ7kG7gTMX25vHJoHw5XthiNohIpo2f84ioSASO4r4
	myTzCGYy+xoMG4YWXbso2K1MxTp9THaXtOfab5YriJuZ4wGpAIyQy8lW+8mVw2/J7Cnr11m+oTC
	fM8jWFwiG0LaS9sikP8qS7X+FJI8XHdAfuHed+BDKjz3suXWteTWM3kCJ8Vent6pa2qZ7oCujqL
	A/zDANCwCnIpH+zQTybekf4YLgS7qI36dCltTIS5WpGSWA4SAfUlGHJz4aqmpeBHbm+kkOlBN9L
	0DErCobiMGqZ2FS+kivWvh82BfT+B8wRw3C0v5NHxjdi7YKjAiR/xMXkwuE88KOOHDtthE5IxR8
	AasFQx2TqGqdbKkaRopfFAqgVol1vcjuGCqFUo4+I9Gt+ifGyQVaL+PhFy8oRp2zQRqEeujzuh+
	7YSMmWeyRwLfzHaZeWgPIQKe12WcvVo0tvK4c+xItZPWwdlmaiG1rRio4vENQ/yaYosgwfvd+fg
	B3r+rXeGwHpwf07UG24Nu/0AqZaLQTyEkwpd4MqaROclHlDAk1fkmKjtiMvUtfoy2L+MA3FINAQ
	VYhQEXAyHUBobAq6naaorS5NPa/XeUVZ9Mb4HxQ/SYO4Qqa5iw==
X-Received: by 2002:a05:600c:4504:b0:4b4:a551:681a with SMTP id 5b1f17b1804b1-4bb887fc396mr381198135e9.3.1795625950965;
        Wed, 25 Nov 2026 08:59:10 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:641b:80e1:c5fc:b7eb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853b2437sm754943945e9.13.2026.11.25.08.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 08:59:10 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v2 5/8] gatt-client: Don't connect EATT on an ATT bearer over BR/EDR
Date: Wed, 25 Nov 2026 17:59:03 +0100
Message-ID: <20261125165906.1645581-6-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125165906.1645581-1-simon.mikuda@streamunlimited.com>
References: <20261125165906.1645581-1-simon.mikuda@streamunlimited.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With Channels set above 1, btd_gatt_client_eatt_connect() connects the
EATT channels to the device's LE address also when ATT runs over BR/EDR:

  EATT bt_io_connect(<addr>): connect to <addr>: Invalid argument (22)

Only connect EATT channels next to an ATT bearer over LE.

Fixes: 45219190617b ("gatt: Enable EATT bearer support")
Assisted-by: Claude:claude-opus-5-5
---
 src/gatt-client.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/gatt-client.c b/src/gatt-client.c
index 2d58ee2e5..449f85fc4 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -2361,6 +2361,10 @@ void btd_gatt_client_eatt_connect(struct btd_gatt_client *client)
 	if (bt_att_get_channels(att) == btd_opts.gatt_channels)
 		return;
 
+	/* EATT channels are connected over LE only */
+	if (bt_att_get_link_type(att) == BT_ATT_BREDR)
+		return;
+
 	ba2str(device_get_address(dev), addr);
 
 	for (i = bt_att_get_channels(att); i < btd_opts.gatt_channels; i++) {
-- 
2.43.0

