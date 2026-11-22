Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795345058;
	b=DbFaxncp0WnYGgx7+xTyd/14exchBUOttqhnm4ismN34sOS+ti1EQz7c3Y2LXaG6+OUq
	 hUAUyPgaVRCif+A8/Qu2GYbznNvavA4dPDgqQTlGjGHwedjTypZ+CPOZbujPM3R9TqaQL
	 dJ2OOZCneARDlt9r0Pg9aadL5PbaIJn9iNSOd8nfUKbpI/2Zcs7Ls8/AhNyUtWcpNgeT8
	 5rKSkXnpvj/xRYFwg4rznE4VkVc6VcoMiZTEUJ73B0KxKx2Wmc0YV+GN79Bh2kVagXTNp
	 C7Y64CQT2Ly/8NmgPEzANXNBCVui7LlcrEzOUUa4WKdvm7xjAG9F8poR13993EVLfYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795345058;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Ng0JWsIQGAdG89dHvGYT0Auv5cwYct9D/A6o/8HaVwA=;
	b=RZlxaX3WFwUidU5E/jmEB1R8WI7igKmCJMnrjxrcYRLfa7rhzK9npMu57RcXiLQlTWJG
	 j8XdMzbpPNj/NXtquKaU65dvm+B0W8NpH0W8/ghlUz4nNc3IJI0MKG0afu/LJr4JPLem5
	 gcsPlLnVyG/o1IJy8QoGb7jVeArPj5HUhHjBHk1ZXSA2rltQZDiwo+c/2S3kzE0mk0wVO
	 lkGYM0uy0EcUgaWLzOpy2BML/YHJZiKSxUjyFfsfFLsY0cEATEr4CHYsIkgOwRlF/h5Vi
	 9EuXNTMcl4X3Uyced830ec+/4AytQ1rhXSyA/xJWCApFNOhIazVutE+P2OzV6fSsRYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b="xzZkGD/H";
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C78A606A331
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 10:57:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C78A606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=xzZkGD/H
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-492690dd5daso1732520f8f.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 02:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795345057; x=1795949857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ng0JWsIQGAdG89dHvGYT0Auv5cwYct9D/A6o/8HaVwA=;
        b=xzZkGD/H0j1lYM42BaXb3cqaWK4rB8JHVf5cj1t8CrGG6joUDCQiMZ7jkDv/aZWhTM
         s6DiKemiLvp71c/XkCsjwkwduQNjX44OCRRBJBhaJL1gT6WtqrGcQAVj1hAT05uuyq/r
         HTNGME8gjBs4dgmpdNHKYyCl38StMvNEBGfzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795345057; x=1795949857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ng0JWsIQGAdG89dHvGYT0Auv5cwYct9D/A6o/8HaVwA=;
        b=xWC5GdGtrHuF3ApgVWomeyAzRD6LeZA+JiQmE97KWj0Knz/4+bP1Kb+OyYegj/zfAx
         5wvPG2rEzMYxrTV1DY3N4SkfFr2I0rd7dEE7qtW00z7feEG5dZcDVwvlhNpTfEC3OU+F
         OO90s0YGafqdzlB750rEhiKLaDXBujpZkcDn82Oilt4RN1OD/hadCmEjff/3/Rsgn8ZU
         XLuLHp8wbamrFsnfHp+kGaChJDAC67WdU/Dn1HyMQHyMM6J/lpbJXwJ0GzKynvsI9c4g
         mWLCxY2QBDveyg2P91UiLWzasM7hZ19suGEY3AcEruXyVbTIF3bwUfxMgjWX+0u0head
         4kKA==
X-Gm-Message-State: APuU4Z/pi/qMg7X11wb+SEaK9KljAx6aP3X60H+4HjPyJJZLcTd3hkYK
	oEy9wdgZIPKiGiaddL0trbnFmIJ5ikoWlHyOKZEwCEMX8nrviLtNbM8Y+Ga8Xl98N0CDazwei7b
	wxJy1
X-Gm-Gg: AZFdTZcSRSXPM2gBVlv3xvdTnwofjewLsYyuOCzSDrCwhQeTvB3zw+JskoVgqG+/7up
	HOSctWMMqzlLeY5dmLXcmDzzEzr7OiZ18bg+Zz2l1zdE06ujUPV8VX35K/EKxERgZwCUIjhOWFY
	DABl4qPiROTVJCpvLnh+UnTLSJtOrFY1xJPSXBY6eQ2XnSpYmKuTczrrFxPp7/l1ecAFDaVp4Ii
	8pp1SslH/LOKBDhGse1WjwY/vnl1CjnetZeNLGLXTHkx8AVGdwHPuD11DXfaKabWJrBfMi3soOT
	dbhVo1mntwKKQjKiHbwy9vpf1xq/SKLeVwAsn/TyV8nilhH/3qO0YR4QPKVa4bOgKunklqzusFA
	ajNvtrygcDtQSa9C5lOcZFMliKRuuK87rSoMXHAW2bkgpvbfqTMcZYRui7EsdI6M51cDxhY4eui
	4JGd1KcYZRze+RO1TiIQX5QQUQm3HLU9Y3btgwlviTffY9lfJzU/TEZRXiS/ckDVBk7sARaVdnt
	rPMR77r1w7yxBhP2ucTqkvd5vWq/6xVW2PfbWWjSTOXOCnyodHN9TyQUjRTDbanvDnqNmbyy9UG
	HgOFiV95gJyBfQxzZP+HYpdasVpQL2yRZPUjwXFZwNOqYmm2UA==
X-Received: by 2002:a05:600c:1c08:b0:4bb:7757:fe6d with SMTP id 5b1f17b1804b1-4bb88804c5fmr214685285e9.11.1795345056764;
        Sun, 22 Nov 2026 02:57:36 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:f8cf:a1d9:90ed:c978])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb85399e2esm300138965e9.7.2026.11.22.02.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 02:57:36 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 2/8] avrcp: Fix listing media players up to item 0xffffffff
Date: Sun, 22 Nov 2026 11:57:25 +0100
Message-ID: <20261122105731.799090-3-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261122105731.799090-1-simon.mikuda@streamunlimited.com>
References: <20261122105731.799090-1-simon.mikuda@streamunlimited.com>
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

GetFolderItems for the media player list stops once it has
end_item - start_item + 1 items, which overflows to 0 for a request
from 0 to 0xffffffff, so the list stops before the first player and is
answered with Range Out of Bounds. That is the request the BlueZ
controller sends, so it never learns the target's players.

To reproduce, register a media player on the target and connect AVRCP
from a BlueZ controller, whose player never gets a Name:

  btmon: AVRCP: GetFolderItems: len 0x000a
  btmon: Scope: 0x00 (Media Player List)
  btmon: StartItem: 0x00000000 (0)
  btmon: EndItem: 0xffffffff (4294967295)
  avrcp_handle_get_folder_items() scope 0x00 start_item 0x00000000
      end_item 0xffffffff
  btmon: AVRCP: GetFolderItems: len 0x0001
  btmon: Status: 0x0b (Range Out of Bounds)

Fixes: d6bb0111b569 ("audio/avrcp: Add GetFolderItems support")
Assisted-by: Claude:claude-opus-5-5
---
 profiles/audio/avrcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 95b1d8c47..3ab7b6d7c 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -1997,7 +1997,7 @@ static void avrcp_handle_media_player_list(struct avrcp *session,
 		struct player_item *item;
 		uint16_t namelen;
 
-		if (rsp->num_items == (end_item - start_item) + 1)
+		if (rsp->num_items > end_item - start_item)
 			break;
 
 		folder = (void *)&pdu->params[pdu->param_len];
-- 
2.43.0

