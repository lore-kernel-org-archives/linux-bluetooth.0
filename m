Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795345059;
	b=qJe7kB5fpQDcWVk3Z6TOpQXFGu3xae2Na+YyhJ81C4ZT7LgL5PjfCF/KZWEiyYa4hQRV
	 XKVSvCAgUFUmRiExfiRc1IQJRcW558Nq2Ll4keRKri4Z4m2W0uFVw+JLK/+Kb8N1ynYQo
	 pleggeho7s5LX7UN2JK3qq/IriTBftT6HyNw9PN5sRiXMwUL3W1u69ztRxLGH6tBubSpq
	 GoCXBjA8ydBb6sc8NZNauuM8XvYWBcUXk/ymvN10bLCJROE/f0G7zCGSuSFGThJ4Fh2ej
	 I02JDerIOhG8XRQNMh5CD/n8yCUg/bZ97t6dH6iMHwvRN++ao5tlmU/vnCb2axQ4jhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795345059;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BnadnBrf9KhjiDVaAi+tm44lxXvlPk5YiBx9cQB8Cz8=;
	b=pMuFAx9OxdTTxd4l+JJJUyZ+zyPtRl3BPIcukEhK3Hi6Sa1yVUeV3p4GMPBOyREZv4lo
	 Tzday2ju/OXArjIO/ll+ZQ7zWTE65+iTbOgwnwBTlVRF1EgprAeMo+Bhgn5nkP9SgrRC5
	 I5VHCXDVY7+NynTqRrnuROuPpYVQv465qyxDdOutEMRegEEq7REkefFUx6zP3c47JPyft
	 /YVfQAEB99wnlRvmCtI6Da8Dg6DVp2tCV2KRHu8aTNULxvgoFCgzL9yLiJ83jxSiMiPwz
	 iAwdN8Xe2vYuUU7eRy4zBBQGd9UyzkaAq+EWHwOWlz9V1njZMxVV9Y2CbPP4B6DD53w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=dYYAibfW;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE14F606A33B
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 10:57:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE14F606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=dYYAibfW
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4a7b8abe209so1756090f8f.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 02:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795345057; x=1795949857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BnadnBrf9KhjiDVaAi+tm44lxXvlPk5YiBx9cQB8Cz8=;
        b=dYYAibfWjX8toxOWM5GfLYFimpL6hrW41NKyEra1Nn4c23pAzzLieX0OHjGAph7Qhl
         6SqF0OcFhMWewTMruynXsSZV4ScE0il4Ubzs1zLpmejmfRMKy6pI3Pgx4iZieW7jppNP
         uqf60uKLwN4YfZ4Roc9tpBhtDZ2kt8pW9pWBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795345057; x=1795949857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BnadnBrf9KhjiDVaAi+tm44lxXvlPk5YiBx9cQB8Cz8=;
        b=Mh6YYX6FfPOmLu3vBMXTVKuO74X59Vt+sf+nI6J+sGNWX2McdZUbC8NgUP2JoVkq93
         R9vhURgCSXH2k6HpAuwVcOXZUg22pK9vTgifnELruu/i5qbgXRX/09vJwfcFG9I2n9fS
         puxL2AfDT9xdcRVRO2/3LIz1zPT5Wu4YGruWD6lkHsen0oibVrWokwqxUz7twQqy5XsB
         X540bImN4+0Fz2p0DPQmoe7S1eIbR/ZOrJy34087BdWF7oXmjWD4Sgg+rAILdp8UHH72
         5kmhMusRQsT7dYZ/S2LrAq2KIj8lwrvzc0ptg5f0isszMKcysePrnOJpZHWMbdjAGZBA
         8RtQ==
X-Gm-Message-State: APuU4Z9R6ws3uV/zWbVpQbANyJsKDsvQabf8qHmbm5UbFGbjhtQA7byQ
	v3e/qbHXmzCGcjgh/Cwpcbl8mHrIzv8kQ/wPfznNIksZlZlyrozm6gsErMJcpGi6D4tdICezC7b
	L7RWd
X-Gm-Gg: AZFdTZfXNKnuTNEwiN+HabSpkqiU2gUKWM6ST+hbbEroxz0Nb37gDjgmNMqZd+Sj4B7
	hCE8Mo3Z5AwKzh9v6dRsQH9YDBwKKDtSBE9Ma+EmfyTj5tfecMdRGIkcQ1tds3JVE3uxUV1hG9t
	TQdHHkFRfpF/8/KwhslgEpaFZeZikhHqxapawDmrDk0cGkWAxPxGz37LFu4bVDqXXXljDST9M78
	dS8FYOZWBs6KtmRm9y0apWKwan7Kn0VlPEHb/cieqwTkj/cmQ+mzS5/tqkf4M+d47lPzACA3Bqf
	trwTC9xdFL+OumKS+LrmdBnpUQEwjXEvSm+UV7jl1Yjkf41UraXgQ6qMRr6AhE7MWR+EsscIwOR
	FgV8igyMFKW0u5AJDnY77dxZJ8rGSJqceyX080JCz7K/nL+vGm75hGLHMzjQxag1WzFBnicEIcr
	dnjbShbKI/+22NFgVhHxMWqb5F2nS8Y5qBKd1zxML6XkmKIp+7W5wJV2Rrm0w5c0YsIdC2nJIbU
	3EWmszeQH1vH+KlI98VSMQ/dmsQceYFLh4hoazyr0q5SpsHSY1wT/vYbL0UhNfvtshoRSLDQ6qR
	1XU2MegH02nQ4DefnUSqaan+zzzcIeaCLtXmF8fp2QZ2B8huMA==
X-Received: by 2002:a05:600c:8b11:b0:4a1:dda8:eb73 with SMTP id 5b1f17b1804b1-4bb8881c630mr190035325e9.27.1795345057548;
        Sun, 22 Nov 2026 02:57:37 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:f8cf:a1d9:90ed:c978])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb85399e2esm300138965e9.7.2026.11.22.02.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 02:57:37 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 4/8] avrcp: Fix byte order of TRACK_CHANGED identifier
Date: Sun, 22 Nov 2026 11:57:27 +0100
Message-ID: <20261122105731.799090-5-simon.mikuda@streamunlimited.com>
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

The Identifier of TRACK_CHANGED, in the interim and the changed
response, was copied in host byte order. The identifiers sent so far, 0
and UINT64_MAX, read the same in either byte order, but any other one,
such as the UID of an item of a browsable player, is swapped on a
little endian host, and the controller then asks for an item that does
not exist.

To reproduce, with a target that reports the UID of the current track,
as "avrcp: Add browsing support in the target role" later in this
series does, change the track to the item of UID 2:

  btmon: EventID: 0x02 (EVENT_TRACK_CHANGED)
  btmon: Identifier: 0x 200000000000000 (144115188075855872)
  btmon: AVRCP: GetItemAttributes: len 0x000c
  btmon: UID: 0x0200000000000000 (144115188075855872)
  btmon: AVRCP: GetItemAttributes: len 0x0001
  btmon: Status: 0x09 (Does Not Exist)

Fixes: 9ab125a8ec20 ("AVRCP: Use track's UID in event notification")
Assisted-by: Claude:claude-opus-5-5
---
 profiles/audio/avrcp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index aff1c381a..fbd212511 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -791,7 +791,7 @@ void avrcp_player_event(struct avrcp_player *player, uint8_t id,
 		break;
 	case AVRCP_EVENT_TRACK_CHANGED:
 		size = 9;
-		memcpy(&pdu->params[1], data, sizeof(uint64_t));
+		put_be64(*(const uint64_t *) data, &pdu->params[1]);
 
 		break;
 	case AVRCP_EVENT_TRACK_REACHED_END:
@@ -1629,7 +1629,7 @@ static uint8_t avrcp_handle_register_notification(struct avrcp *session,
 	case AVRCP_EVENT_TRACK_CHANGED:
 		len = 9;
 		uid = player_get_uid(player);
-		memcpy(&pdu->params[1], &uid, sizeof(uint64_t));
+		put_be64(uid, &pdu->params[1]);
 
 		break;
 	case AVRCP_EVENT_TRACK_REACHED_END:
-- 
2.43.0

