Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794346532;
	b=VSevxH0gW82PgLqJ4aL+O1cuj03EBMFQdVspoWsJp0tyhMHPQE9H8pjvhbT7xuVLnduE
	 +xtjOKxmPeeKWgSg2UAIqzUAKIVanMaOmyCFt7h2zcpxr6HIDyCx5fXA6y9sAMTxV+4So
	 QIAMbpLKRfmzum9QkJueHb1SpsNuyriUEdojf6rl8KBFykGpmmUM+Gdsyhh39X8CK1oSm
	 SSmCvMeuwDSVlRkUIHyX/izvJeBT8Siiq2x7nbNP91awfRuokCTnCUWHNQcPfuuyvTKMJ
	 7v4YDACUAvPdw7ZbQAVWWL/HNaRC4ga2+XjZCcQAzLdOlYR06W2b2xEG2H421oJw0ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794346532;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=H9Brfz8k7TKgPnr3sZqZNB69i8pBO+z/vJ0OnzZLXfo=;
	b=KRNSUDNfy3qpHd/GYj3U+5fGaNKsDve29NJngnxGIfiAk1M0RqQehCAQtj0YX8LAMAg1
	 5a8Hcb7umu8E3Oahd23J+duJnkcGgyKB0UvRxpnrvPotaHDbR1YmPVtmRvA4LUv47nwO0
	 9M4H4SiH9nVIvRsgjz4uoR3KYw7wkYOCPS0q0y+Gkfhosx0Cz6kkoIEIt9JsyYvAoxnaV
	 SZ6U4fDZ4PZLQ/gw6SHOF0X0BxXKN3HfrRNugxb9KzWIzEMn3jU3O/PdvMPWY3xoQCHkq
	 47NvYK+K7W9j4zhNmtevNd7fkg9YuX+UD4AYl62qXSHcR8cuQL0xcuJsbKX3/2i5ceg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZRzHnyML;
	arc=none smtp.remote-ip=209.85.221.180
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F250606A327
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 21:35:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F250606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZRzHnyML
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5edf97136aaso1309572e0c.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 13:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794346531; x=1794951331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=H9Brfz8k7TKgPnr3sZqZNB69i8pBO+z/vJ0OnzZLXfo=;
        b=ZRzHnyMLfbvZyw3591+rMybvMC74jIIPEC5JBZU9fJjBsxmVAC95+oL3ThxjJs6nym
         4VPj7r7Wgj/bx1wsWwKXWEs2ENbpX6x/biE9SbYG4kz/2mDyArVXIvn9bTGKYiMw55tj
         luWyqeIWIL2SEcaiyg2eHvslx65r1WuCHN2wmiD0n6/Ifk0l3XgjH7OZ1CUxlr1K4ZgT
         M6bagBJbYA3QsXrliqBRGu5gQ+BiZTDuU9noS+C8/Rh5zNiEnNpjneKSpBO2V3ixkuwR
         ydtMw7bqA1DAU1hoKeSpwKyWxuHUwtf3MxpThj+JNM5e1fe2NLtOCvEO9AsueNdhH+o3
         841A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794346531; x=1794951331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=H9Brfz8k7TKgPnr3sZqZNB69i8pBO+z/vJ0OnzZLXfo=;
        b=NBWzr/AHRfA6EfHYRRg84MA+fuy7OE43sJQRjpi3tpk8dfAcxyXbUn3wDcKD60cqrh
         gZXXJwXFygLITOm0WWNUALNOpL0J8mvbduBO4HtOmesyNKFv2sSr65Bm7U2o6NPbvX58
         izxqMpH0rSd1IHqRVOWXL87SUwmX/9FU1GrnPxqMADngPpd3xc1+96jH1wlVH0AqbYxP
         1jhKBHZ8l5Ps/hA+yXX/qa8+ufJ0SFjsJhLTJfNHDDZQ9O6NbI7/+XAro/IS3A/27qPq
         qz4Bfkxg6JvUjv8F9X/dzNqwkAH0BPBr7wnIOvsi4p3DazVjTG96+dZM/utZI+rbuByR
         YCSg==
X-Gm-Message-State: APuU4Z9mQbR25KZwP+Tu9Poer5b4njUtlc1UjW1u7zFEKSc+irwwN+V+
	z8nK4ycTJqtetEfMptFF0mcHnYOQqDGAc/Njlat3+MZljHNJBijJoVnwP1Kw+Q==
X-Gm-Gg: AYBFou0tCMnLOkO20AB38QCAI0WM4qvU/WcBQ+S90XDPMupZ+LPIxUCKyc1FXw2BJHN
	cp+RKhAiT8+kvqNQvLYMR9Lb7tg2IHYd5Y7pPDt9q//JzjOtzMpjqXghQZj4tkd5nhfTooxuSzv
	X2ZX0tBV6Fwy3mhIpADzEdq40tYkmiSG3+3Rd944mmyZVUpCJMvNPOEVAORzByzoGKRPLdd1fWd
	K0OaZw1c+Mfq5v6pKR/ZhDGpM1srCGSN3yvHs58m/I7HxqpQRUmKm4QXjmOy6RTPyCftlalROQZ
	CEBFtJED9QGOlf9XJgqeIt3CRai4mQqSwwMh8PO2A2ss2cgpPY2U6c6BO3dgIqFI8J0U9pqSXm1
	kghJUCNF6ObGEtkX14arxT5gN/o4MjaWsdw5Tda9F8zA8LLogtZk+DQKYsV1etZDS/wjk7U+lhs
	cqFmCq2pi10l1gx/gfZLQfpy0IHlIA2M8h4EBWULhNJfzKGX1S6UQrxN94WC/RJvgx0FSvW4IRL
	534vs5+inmaBwIKUbUYno6qNd5JVP9+3TofckEAEVfp8zJImmfb2cK7GZWGaOTIz8DoA4y0k+J4
	rLS72pf6mmSpw0fFzsGGSOi1ZzEeTXId4lGHPtvEtnzpwi3kdA9/khTH/7Oinbl5ob+4nZAADog
	72q6KitvpOcGwp0+ZjlVpr09+aw7p2m3f4Xp1CGrPhPENi2PK9erfrchhpWih6OLw0wMKCRZi0Z
	HEmlU=
X-Received: by 2002:a05:6122:3488:b0:5de:ee96:75b with SMTP id 71dfb90a1353d-5ee1c426b9cmr76019e0c.12.1794346531192;
        Tue, 10 Nov 2026 13:35:31 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee0c614572sm2482189e0c.17.2026.11.10.13.35.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 13:35:30 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 3/5] shared/asha: Use util_iov helpers to parse characteristic values
Date: Tue, 10 Nov 2026 16:35:23 -0500
Message-ID: <20261110213525.2942339-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261110213525.2942339-1-luiz.dentz@gmail.com>
References: <20261110213525.2942339-1-luiz.dentz@gmail.com>
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

Parse the Read Only Properties and PSM values with util_iov_pull_*
instead of indexing the value at fixed offsets.

Assisted-by: OpenCode:claude-sonnet-5.5
---
 src/shared/asha.c | 52 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 36 insertions(+), 16 deletions(-)

diff --git a/src/shared/asha.c b/src/shared/asha.c
index 79bb29bf9a0b..8fe83348da96 100644
--- a/src/shared/asha.c
+++ b/src/shared/asha.c
@@ -365,19 +365,18 @@ static void read_psm(bool success,
 			void *user_data)
 {
 	struct bt_asha *asha = user_data;
+	struct iovec iov = { (void *)value, length };
 
 	if (!success) {
 		DBG("Reading PSM failed with ATT error: %u", att_ecode);
 		return;
 	}
 
-	if (length != 2) {
+	if (length != 2 || !util_iov_pull_le16(&iov, &asha->psm)) {
 		DBG("Reading PSM failed: unexpected length %u", length);
 		return;
 	}
 
-	asha->psm = get_le16(value);
-
 	DBG("Got PSM: %u", asha->psm);
 
 	check_probe_done(asha);
@@ -390,41 +389,62 @@ static void read_rops(bool success,
 			void *user_data)
 {
 	struct bt_asha *asha = user_data;
+	struct iovec iov = { (void *)value, length };
+	uint8_t version, caps, features;
+	uint16_t render_delay, codec_ids;
+	uint8_t *hisyncid;
 
 	if (!success) {
 		DBG("Reading ROPs failed with ATT error: %u", att_ecode);
 		return;
 	}
 
-	if (length != 17) {
-		DBG("Reading ROPs failed: unexpected length %u", length);
-		return;
-	}
+	if (length != 17)
+		goto invalid;
+
+	if (!util_iov_pull_u8(&iov, &version) ||
+			!util_iov_pull_u8(&iov, &caps))
+		goto invalid;
 
-	if (value[0] != 0x01) {
-		DBG("Unexpected ASHA version: %u", value[0]);
+	hisyncid = util_iov_pull_mem(&iov, 8);
+	if (!hisyncid)
+		goto invalid;
+
+	if (!util_iov_pull_u8(&iov, &features) ||
+			!util_iov_pull_le16(&iov, &render_delay) ||
+			!util_iov_pull(&iov, 2) ||
+			!util_iov_pull_le16(&iov, &codec_ids))
+		goto invalid;
+
+	if (version != 0x01) {
+		DBG("Unexpected ASHA version: %u", version);
 		return;
 	}
 
 	/* Device Capabilities */
-	asha->right_side = (value[1] & 0x1) != 0;
-	asha->binaural = (value[1] & 0x2) != 0;
-	asha->csis_supported = (value[1] & 0x4) != 0;
+	asha->right_side = (caps & 0x1) != 0;
+	asha->binaural = (caps & 0x2) != 0;
+	asha->csis_supported = (caps & 0x4) != 0;
 	/* HiSyncId: 2 byte company id, 6 byte ID shared by left and right */
-	memcpy(asha->hisyncid, &value[2], 8);
+	memcpy(asha->hisyncid, hisyncid, 8);
 	/* FeatureMap */
-	asha->coc_streaming_supported = (value[10] & 0x1) != 0;
+	asha->coc_streaming_supported = (features & 0x1) != 0;
 	/* RenderDelay */
-	asha->render_delay = get_le16(&value[11]);
+	asha->render_delay = render_delay;
 	/* byte 13 & 14 are reserved */
 	/* Codec IDs */
-	asha->codec_ids = get_le16(&value[15]);
+	asha->codec_ids = codec_ids;
 
 	DBG("Got ROPS: side %u, binaural %u, csis: %u, delay %u, codecs: %u",
 			asha->right_side, asha->binaural, asha->csis_supported,
 			asha->render_delay, asha->codec_ids);
 
 	check_probe_done(asha);
+
+	return;
+
+invalid:
+	DBG("Reading ROPs failed: unexpected length %u", length);
 }
 
 static void audio_status_register(uint16_t att_ecode, void *user_data)
-- 
2.56.0

