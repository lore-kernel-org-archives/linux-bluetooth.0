Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793656508;
	b=kOAiveugvOVaIigtTaymoTVmWrf28uYJXxs6znr+nqNDlI3YJ+/sI/3Y6gD/KRusxv2W
	 RP/+gh8/JQaQBp0NtrI2cxxKo1BL2aKCKAIQnMbmgRCG0s0QRLAwDVYAg9atkD+/paS4+
	 5ElN9cwfu8JWb8l7PGZLuiTVMLyKvlP0yKsZ5uxkSU6sch+6z7J8SZT4z3g6/biRIx1RV
	 hX2AIURpVzaIbMndWBMtcr1oVDbfB1gER1AevwO921DFMVxJl3iOjlJR100Xi9hypNFVM
	 iB/ZQeJRtKRtV/cSDc8uAWS0p7cxlLTcT7CVmLrVmMYl3UA1uHu6L7GA6HNIv20nU4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793656508;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=E0IcfN1ut/RcVzoOjOl/M5N3ZCrmzDsSFPzaDDBuuKU=;
	b=V4TF/GTVA1YfVOPRtGztEMJtD8UsBt5wXJC8Fa/iudHt3rplNzDOKPDKu4mcEwSujMU7
	 gSkrezFhIZ5WiwQrDjou8GXYQL4mmohRGbXJhN60D4kTh6jyOCDwcaDCwkcRLwmBSUqJb
	 WxqK1G3aD2m2+lQQsGuxdSAm9LupFurJx+aF56T4sRzvhx4JBVyDAj/aCyiFyf6oJIWZw
	 h8W8gJ2g9B2nn4wdGXVpFVQyVKrxvbbF21+mVlXX7eVe/fzec5AflDN1uHDOox+199YaU
	 83knWCtsZQd4h1c94b5TRx02Pf8VcvclopnjxpehfbgrjZxHSfvaFl1WcdnM5f8dz9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Dp3xqxt2;
	arc=none smtp.remote-ip=209.85.221.180
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE454606A32E
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2026 21:55:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE454606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Dp3xqxt2
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5ec690faf85so991949e0c.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2026 13:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793656506; x=1794261306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=E0IcfN1ut/RcVzoOjOl/M5N3ZCrmzDsSFPzaDDBuuKU=;
        b=Dp3xqxt2q97IT2oOMu0rPUhGVNBr0OBOCOmd4LT23Cw1Eg2iIO81E5k7/oFvFboQh+
         IiMk1WGG8CbCzZhreLameHIoik3dWUgfpfmqxYulX88b2J4eQp/Z3JALAf7TXm7VDoOS
         K4TnbHq51DTKa9Y/jEbMdfnEk/b5OB8K3n9Gq3PsUW87rEVbAsiuRYyE6sUN4KiAsZIW
         I60GAD2IfA4BUIhDmCcrjZ2vBeduYr4HZSMY/KqgBV6Hj6x9WouRhQzVGmndeaxSd+Se
         o/so6/24PpMKof/J8YdVFpTJXPH1LUTFMHC9UFUTNRbty5zy5zbCn0T86AOz3ARsrBOh
         MiYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793656506; x=1794261306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=E0IcfN1ut/RcVzoOjOl/M5N3ZCrmzDsSFPzaDDBuuKU=;
        b=TeqOmKUqGrN//Y9opcejTeFn8AMVARugDcOv2A8wUSFcdaKcREhpJ2GK//6nNA3FTm
         644hvRQvp4t7ZQjEG7q5iou4y6JLU3cekIcNVXz++7WjOkLCZGtoEJB6Jc9xBhzq/hxi
         q0IychktbraUaNTZv25clmMvDbRUu4ULZjPX6dNdkjjK8/4VLF0nd9fpEvYrOvkSI7Y9
         P7VTrzO2jl7S1jFBlIky5RpGAW31r4SXmr1kRHCdtRfDspCt3sFOKTyZWFc08Icw3SAs
         XoNWfcr/mTw1Pbd5uCw/VavM9gMZ+wUWjGWbJlWOqLAUKIcyqkomyx1VcKgVwGRBw2am
         w0kg==
X-Gm-Message-State: APuU4Z9Y1qvhgk0TS1z+unyb6+3c4qD1OWIP0aN4WOanFhplpA6KpnBc
	DXC72+LuO0I1DkvDEfBPDsqPtzSMErALBBuEcGfM6feNFD8lMqjncfqUHN0v8vwR
X-Gm-Gg: AYBFou3U+VHeoULRUZCA6s8XTZAbxB1Mx/VtNi+zKEXlsdtKf28VXfT3eoLE40dAHu5
	P2Z7Q5iT+6lRRxOVOXfN1UGWAfj7otyh5SjjdtrMHRfYWmyxhny7j/EFiiquAz0jMsVwlusVp53
	m8oFQNC9YcASBZQl3kkcTGyBq+u+13Z+TsFD5+yPfW0T7qH1CNokKosc7AMXrTPsZRoOMH7GNow
	BtEt8yG14E8wjCYYZwqF9LQIOhKpRMTzEYR8q65h7N4OTT/Y4KePhfVQ3PQpmZ+oyU5K/BbLnlo
	mbC8d39sfZUfBFQF2jq+R4rvUqfp43FZaDVBbsk6Zp8k2Q8dx8pOIxG8yu8djiN6xNnw3ImT2/E
	V+7WFzCuYRWb5kYrtShcT6OlfvMzaApP9J+kF/FG3i9udq4TGC/pnXOmdhZSGXnAS+mOLyMklPP
	2YFc2m/Zf79U4iDCOVN4w1RWEqUM3yEDAIIGSZIzI4WZpkRQ0BdXDvzMYxiif7HEOxf2nDLRNG0
	uI0Z7xsmVEcheVoiEONQZHk/epjhcls35/KVngkTyTs5bA8xCadxsTP4e3blKQ/hKb04psyNMOK
	KfoN2/hyvfYRM5a5i3aV4bMKhAKt+TBTmz3+BGL/tQFno6eon5kesyVNrA0gf8lEkB43g1CeUM1
	f+cyvqDolvD5BZLhiOG7XjaGoHZ/LS/FD/82wxh2BLs3zThVd3u95xahvtWDG7cRrBEyFL/EsjF
	r7DY0=
X-Received: by 2002:a05:6102:c4d:b0:7cc:b162:ea33 with SMTP id ada2fe7eead31-7d072637946mr4095178137.27.1793656506549;
        Mon, 02 Nov 2026 13:55:06 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d07738ebf2sm11066184137.1.2026.11.02.13.55.05
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 13:55:06 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 4/6] shared/bap: Add bt_bap_stream_is_client
Date: Mon,  2 Nov 2026 16:54:55 -0500
Message-ID: <20261102215457.2553416-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102215457.2553416-1-luiz.dentz@gmail.com>
References: <20261102215457.2553416-1-luiz.dentz@gmail.com>
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

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Tell whether the stream is handled by the local client, which enables
its ASEs, or by the server, whose ASEs are enabled by the remote.

Assisted-by: Claude:claude-opus-5-5
---
 src/shared/bap.c | 8 ++++++++
 src/shared/bap.h | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 10cc81a51c3e..b1180b532b8d 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -4549,6 +4549,14 @@ struct iovec *bt_bap_pac_get_metadata(struct bt_bap_pac *pac)
 	return pac->metadata;
 }
 
+bool bt_bap_stream_is_client(struct bt_bap_stream *stream)
+{
+	if (!stream)
+		return false;
+
+	return stream->client;
+}
+
 uint8_t bt_bap_stream_get_type(struct bt_bap_stream *stream)
 {
 	if (!stream)
diff --git a/src/shared/bap.h b/src/shared/bap.h
index 5bdc5f8dbc34..242bfbb39b30 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -122,6 +122,8 @@ struct iovec *bt_bap_pac_get_metadata(struct bt_bap_pac *pac);
 
 uint8_t bt_bap_stream_get_type(struct bt_bap_stream *stream);
 
+bool bt_bap_stream_is_client(struct bt_bap_stream *stream);
+
 struct bt_bap_stream *bt_bap_pac_get_stream(struct bt_bap_pac *pac);
 
 /* Session related function */
-- 
2.56.0

