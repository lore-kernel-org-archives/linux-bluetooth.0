Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D0D1DD397
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Aug 2024 19:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724097070; cv=none; b=WUAHSN8NLv6L1qDPPHdgyM2zkFwb39+MDhEJCG+ZCNS7Otr/NTWydbeCy22kWSv2Ebn3yD4WhnUWPP9CXYzqdw+1oikSz/SS1x3X79WbnM0DknJg6N4SnnocuOY56ZocQ2FSULR/NCHAudAg08LWOGlASjOZkDoQMs0tYkujY/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724097070; c=relaxed/simple;
	bh=I2ZTKyQE5M4FdCo+xXhLz6C8P93bb6u6+3bcuUwgkH4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RJi8B0ZKKKSSHLY9sZ0GCn761z3ErOJsNQ20nLUt+19DNnfWmb22CKaKkqxdUCd6Q3ZXIxu1ijOnRBiDwtZJb8jbKPaxhkdCG4MLSEQeWMbn/B8aITiBdSEspxBIKufSFOxfWu2v66ShCBFhtM2T0ooxtj7tidsYnIuVbKsZ4Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cWmSkSKU; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cWmSkSKU"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-49297fca3c2so1691929137.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Aug 2024 12:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724097067; x=1724701867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NQYoBSzVThb7g5HLHLf+c0ty/SjotPghKRIte8zUGhQ=;
        b=cWmSkSKU2rfVEWQ4yXeD1h3c+YtR+VsrL6yxLYODHVcbjExpyiX0hzPvROicanp/IJ
         tOVsh+1mYcramIG8Rtr565S6U+FmFiK1APeSNTEMCmJyh9bd13UZJaGXPj1D2Y4Ps8U1
         Jjzj/tP+i8NY4JwgDIZ3QSbbRCFaB+Z1R9qsxk56gH0k4oDXoyPe8t5h9S/Jwes4XgYH
         l1/Hw7KhgZzyajdZJwCFUsCaHl0PgkDapwKlAFBs/J1YkrlNXFwIpdtGu8KO8tBe2rtg
         o92ZUzobibevmaViaTC0jUjECz25GFrX9E/rftHFcw3uZKER4vnTS0AQoqrKcckws/Jr
         cvBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724097067; x=1724701867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NQYoBSzVThb7g5HLHLf+c0ty/SjotPghKRIte8zUGhQ=;
        b=rpMvzyzP7u0piwDhUEn9RfzqfOgbmcwZjawwjrJpmVchla92cHTJkgjdvdrMxU0/mF
         KcBE3m2KIhm5qi9Sr6JNe2AhuNMNHduGl5ZY9dJnABfOHrTNckO+BZBIm0aMmAKi0pzS
         AmIY0H4uNk/qcpvYhlwXcZQbC/J3gePOa5FGOPoAURNnL/eo1Rqe4XTjEw/FILgomCSm
         VYP34LK0XL+Z8s4tBdFnQsS/A387rK3k9nr85Ss0zs0btCO2xAt5ijXfg1hSjGLFIP4f
         9W2oFtG1QFifJEV46GX5t5AbTysyPSZe2rf+ngCtflcnWvXjxjYjoNe8FCC55aM1lQfF
         1gVg==
X-Gm-Message-State: AOJu0YxIihYnKJm+hSwpWKl5QND5NK6Zkl943+AZVpXWPnrkDmhy/s7J
	7Qb/LF0XlXVgaohyhSMmxECGcx0XGIcjwhmW1cm8w9MHBHUoybZL6WQpnw==
X-Google-Smtp-Source: AGHT+IHH3D9Y3yuVn+dk3uzRE+Bm6Jdu5vE4uUIQPOVlU7iU3mLnsgeTmdlTr6cG5LSs3sOCVnGqnA==
X-Received: by 2002:a67:f312:0:b0:493:e585:6ce3 with SMTP id ada2fe7eead31-497799b5e22mr9485469137.31.1724097066944;
        Mon, 19 Aug 2024 12:51:06 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-842fb70fdebsm1274530241.4.2024.08.19.12.51.05
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 12:51:06 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 3/4] client/player: Make endpoint.show print local preset
Date: Mon, 19 Aug 2024 15:51:01 -0400
Message-ID: <20240819195102.37393-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240819195102.37393-1-luiz.dentz@gmail.com>
References: <20240819195102.37393-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes command endpoint.show print preset set with endpoint.presets:

>endpoint.show /local/endpoint/ep2
Endpoint /local/endpoint/ep2
	UUID 00002bc9-0000-1000-8000-00805f9b34fb
	Codec 0x06 (6)
	Capabilities.#0: len 0x03 type 0x01
	Capabilities.Sampling Frequencies: 0x00ff
	Capabilities.Sampling Frequency: 8 Khz (0x0001)
	Capabilities.Sampling Frequency: 11.25 Khz (0x0002)
	Capabilities.Sampling Frequency: 16 Khz (0x0004)
	Capabilities.Sampling Frequency: 22.05 Khz (0x0008)
	Capabilities.Sampling Frequency: 24 Khz (0x0010)
	Capabilities.Sampling Frequency: 32 Khz (0x0020)
	Capabilities.Sampling Frequency: 44.1 Khz (0x0040)
	Capabilities.Sampling Frequency: 48 Khz (0x0080)
	Capabilities.#1: len 0x02 type 0x02
	Capabilities.Frame Duration: 0x03
	Capabilities.Frame Duration: 7.5 ms (0x01)
	Capabilities.Frame Duration: 10 ms (0x02)
	Capabilities.#2: len 0x05 type 0x04
	Capabilities.Frame Length: 26 (0x001a) - 240 (0x00f0)
	Capabilities.#3: len 0x02 type 0x03
	Capabilities.Audio Channel Count: 0x01
	Capabilities.Audio Channel Count: 1 channel (0x01)
	Preset 32_1_1
	Configuration.#0: len 0x02 type 0x01
	Configuration.Sampling Frequency: 32 Khz (0x06)
	Configuration.#1: len 0x02 type 0x02
	Configuration.Frame Duration: 7.5 ms (0x00)
	Configuration.#2: len 0x03 type 0x04
	Configuration.Frame Length: 60 (0x003c)
	Locations 0x00000002 (2)
---
 client/player.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/client/player.c b/client/player.c
index cfaf1137c92e..5644b0d616c9 100644
--- a/client/player.c
+++ b/client/player.c
@@ -2797,13 +2797,26 @@ static void print_capabilities(GDBusProxy *proxy)
 	print_codec(uuid, codec, &caps, &meta);
 }
 
+static void print_preset(struct codec_preset *codec, uint8_t codec_id)
+{
+	bt_shell_printf("\tPreset %s\n", codec->name);
+
+	if (codec_id == LC3_ID)
+		print_lc3_cfg(codec->data.iov_base, codec->data.iov_len);
+}
+
 static void print_local_endpoint(struct endpoint *ep)
 {
 	bt_shell_printf("Endpoint %s\n", ep->path);
 	bt_shell_printf("\tUUID %s\n", ep->uuid);
 	bt_shell_printf("\tCodec 0x%02x (%u)\n", ep->codec, ep->codec);
+
 	if (ep->caps)
 		print_codec(ep->uuid, ep->codec, ep->caps, ep->meta);
+
+	if (ep->codec_preset)
+		print_preset(ep->codec_preset, ep->codec);
+
 	if (ep->locations)
 		bt_shell_printf("\tLocations 0x%08x (%u)\n", ep->locations,
 				ep->locations);
-- 
2.46.0

