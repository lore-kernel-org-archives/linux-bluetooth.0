Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795156748;
	b=hCxN8CfbrjEwiskZEX5x3bSdoGb24baGazUVCS/XNnjWnAoP1iS6oKCL7yvKE7w5iocZ
	 wqb5Cixc5qIFm+HbWDM9uiHLYK5+tiAEQKdQu8YT7lIIk1dFpdC4qZPlno1ZXqplj5RJj
	 9FkpQVzoFe9CnaGedRSgN5bBvwLdjGDmlSkzkP0bb9sKY9dFyh8Plk7Xu3qFIpxYEeAh+
	 vkpX9PGmfC6W/3ITaJlMWx26Mip7M+qPFs5wfaLo0ijbm65KBpy+94gnSeUCbubE8SA4r
	 O7NnRnDLTJehw/syK0mS33wNteBgy4DvGujW/cMsDOO7U+RDyIidNG9FKGaj0+wTAOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795156748;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9b3wkdM1zubf9Rrjy22aWqnNj0ZkbZpbRoUAJQIplMs=;
	b=jVYEwZ2Cj5holZody5cDtLB6+yClJ26/eX3hNfvd+4/ao3T7FuwADfzWkDUP+LWHLmKA
	 O4J0yjS0mtQ0RR7KesIa/Vr/KhxZtfg2VCSv5GsSlzDeBtfHr2HuaN7nCwPkYbcOxE0PI
	 WVqVfwBa6hr0gie5sspS7bXOBzkM6Dm34iHj7Ts78WdUkvWLOjxyM25vsuf570mOgY2ZX
	 JflhFif2pe2+pFEDfEQGyDVHAizLpHmhltq/12uaUhmuWlubyfZQMpaIMt9wPtBaDE+r4
	 xqGZczfZh6pXXoH3ocKTWwDVHdRsucNlp5KTq0+BflPLj0YcyKtDSqCxRS5JWsCDNlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IIMMg8t4;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6CD606A325
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 06:39:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA6CD606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IIMMg8t4
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4bb5d38264aso475275e9.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 22:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795156746; x=1795761546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9b3wkdM1zubf9Rrjy22aWqnNj0ZkbZpbRoUAJQIplMs=;
        b=IIMMg8t415jocOag4iuaIpJR1gTI9B0vFeVmIVpu2s8c5ocf3TGgVqV3BrmKLXINhk
         eEXoC3X8lthzy5I7Vq1Uy7JAwDHgZLCFSTZqqFmniLcS9o2DR5U+q9tIP9LLEJUcTh3Y
         haT12KZuB/sq3mXLNV4+FRZ5J/b9l3zgN/Pxv6lcNDOGMSsdWuPJkqKmrCUgM/6Zbseu
         UFfAck4aEDCU4Lev6Hfa6MGu45EwHswTmaViybT9XluW5vYjwurwQke5X9xex7lEIteP
         sTnUB1LSfiAlSgKkvy4IsSDxNJycit6xsQEaLDznq0dSQnwGQQxXMINjmXIXnL/4TMoS
         Fd1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795156746; x=1795761546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9b3wkdM1zubf9Rrjy22aWqnNj0ZkbZpbRoUAJQIplMs=;
        b=WLzhcxy08BXOr1ffJXTkyBF97OfDcoiqaEIf1yWNDL6gdYpsy3XxVXXz0q1cKBMDqO
         y0/dYigzxrv+IMKZTSE0+BZ+9rh4zlO2ej+E0tjOFMdGsuy3ZXmmL8LkDaFzLRwZibk3
         KlheYzM7dX8pwed/kTx+Z3qlhQa64YDS/KmMZRlskozmf3+/CPVwOGQwiYizhsgVgX3u
         JTBa5iZsCIwtkSPbBUM9+HWHtKA+XXU0IJJ+sDXDQbTqJRsuZGVcD82ZLSRcJaAGGvew
         5TiFuYTo6lK18QQ2zXNCJh73PM41Zf7okw6TMXGV/u9oR1/GF05ErtLctaCpkb2DmmJv
         2k9w==
X-Gm-Message-State: APuU4Z8wGSgswDfawRYhdMjy5uS7tWxvZb7CzsPPai51s1/tFuUL0fj9
	G/ZD65a8cyJyek8Vhp10wePtE6FXZ3FZoQw2sK12DLITutsuX0n4OngWo4FN/dqR
X-Gm-Gg: AZFdTZfAaCG9qFC5Sk/rolpU67oDJBkwkx2UFfVfty8Ry1J7pjo8k8WD9DrNIrI8Wzg
	C8/Mj+k11+TztC71RQwNUdAj3U0QRolxgMSdGtpVhuZrr+oQek8D/p+/9/pUNl0LOtg7EaBo0V0
	xXLPOgPAcglDYNFXUCiRTit6+NVm4cjKldvysAXLSQTjLUv4Qe8en7LPqtBbrMWqjhDAgtePesg
	FIGycIjoedQSwXk3roYztpAB+wyA5OO3x1bD+bsxRzXtb83cvGmPcD7YIK7LL7wbP5MX13UX88+
	d6zIDgjpab/zQd0cwBRKAJhZe5FhFnFyjj98pA42nAS1O4LAhDTDvJFWdKvJ5SbACJgtWghw57L
	iv9UmhXDThTDOF13lRgMcP5fYelK3m+ynUWS1GMcJY7jol1XU4zaR0+Tle78MlBsCYW/RATT5d1
	amnBqnGIl6HpDRUvFypO2ynZDtom7h/YBc85fWrrf2I0mINw6lSN62p/H/qgKMYm+ezn++P6XqH
	keWSGTWQcvdKshZ52Byv2lE5e2FoBahUhyGVVmaSeFHA4/Y9NWkWYsd5ZgsEwHMJUagCR/sgJoS
	o7kNvZrsY7/3DKnBfxRP8xm3T1Q8TzO2mfQ=
X-Received: by 2002:a05:6000:4812:b0:4a6:bc53:2472 with SMTP id ffacd0b85a97d-4abb3b41cf6mr3185458f8f.5.1795156746134;
        Thu, 19 Nov 2026 22:39:06 -0800 (PST)
Received: from schinder.corp.hoffmann-group.com ([2003:8:2:4::5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab69bf630esm3685607f8f.16.2026.11.19.22.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 22:39:05 -0800 (PST)
From: Roland Schober <rolandschober1968@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Roland Schober <rolandschober1968@gmail.com>
Subject: [PATCH BlueZ v4 07/10] monitor: Fix byte order of LE PA Sync Handle and Properties
Date: Fri, 20 Nov 2026 07:38:53 +0100
Message-ID: <20261120063856.16585-8-rolandschober1968@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261120063856.16585-1-rolandschober1968@gmail.com>
References: <20261120063856.16585-1-rolandschober1968@gmail.com>
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

The decoders of the LE Periodic Advertising Sync Established and
LE Periodic Advertising Report events print the Sync_Handle, and the
decoder of LE Set Periodic Advertising Parameters prints the
Periodic_Advertising_Properties, as they are stored in the packet.
On a big-endian host Sync_Handle 2 is therefore shown as 512, and the
Include TxPower property (0x0040) as unknown property 0x4000.

Convert them from little-endian like the other fields.

Fixes: 9285a4e33882 ("monitor: Decode LE Periodic Advertising Sync Established Event")
Fixes: 5441a5b91a08 ("monitor: Decode LE Periodic Advertising Report Event")
Fixes: 61563bd7b477 ("monitor: Add LE Set Periodic Advertising commands decoding")
Assisted-by: Claude:claude-fable-5-2
---
 monitor/packet.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index ce05928c1..4b7a82ac0 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -8707,7 +8707,7 @@ static void le_set_pa_params_cmd(uint16_t index, const void *data, uint8_t size)
 	print_field("Handle: 0x%2.2x", cmd->handle);
 	print_slot_125("Min interval", cmd->min_interval);
 	print_slot_125("Max interval", cmd->max_interval);
-	print_pa_properties(cmd->properties);
+	print_pa_properties(le16_to_cpu(cmd->properties));
 }
 
 static void le_set_pa_data_cmd(uint16_t index, const void *data, uint8_t size)
@@ -13904,7 +13904,7 @@ static void le_pa_sync_evt(struct timeval *tv, uint16_t index,
 	const struct bt_hci_evt_le_per_sync_established *evt = data;
 
 	print_status(evt->status);
-	print_field("Sync handle: %d", evt->handle);
+	print_field("Sync handle: %d", le16_to_cpu(evt->handle));
 	if (evt->sid > 0x0f)
 		print_field("Advertising SID: Reserved (0x%2.2x)", evt->sid);
 	else
@@ -13924,7 +13924,7 @@ static void le_pa_report_evt(struct timeval *tv, uint16_t index,
 	const char *color_on;
 	const char *str;
 
-	print_field("Sync handle: %d", evt->handle);
+	print_field("Sync handle: %d", le16_to_cpu(evt->handle));
 	if (evt->tx_power == 127)
 		print_field("TX power: not available (0x7f)");
 	else
-- 
2.47.3

