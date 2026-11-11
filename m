Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794429597;
	b=UckHYZIbo+Ir6cbntB6OAYo048E9sFJtY8+1J2vL1OllO2BwU9l16WcqKWZLO71EpmTq
	 XIET2U5s90JI+nw6i2eUckwmGDi0lIfkKT7Gb2UB99FeAssP+jRrKLugQN633pYWGyERb
	 GNtUpQQ20v5paM8m+8PhyBmxZNaSES5PYQm34N6Hbfz4N323d15metAezMNngd6btNnIt
	 soukMgX5nYUSUBudV0LCCSbtl8PEZu/Pjig8nmr99he9awexknQ6LiVK1zjAqJM45KurG
	 h6OUGffZ4zUMlc06cGevlMy6Lif0cA9F2/m2bg6ad0t/uANEuNvw/8rlivNmt3s3oGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794429597;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=A04W9o4nzjchR0XXucwN2y18f2T7OtmkNLA3xJKRAHU=;
	b=fJWDFGn2Jr7zyN/g9YbymyMiEUo1MC0RnrSYvHX/B5DFY+Mp273Z3Mla+G4U6RLnb3s4
	 eje4GWzxEzrv9PiSAZqlUtlRvGGVWF7PVV3GLjH63jaIq92asZH0ZiHiQo8Ecv6rIUo2K
	 NnP5nugt+tlkH5IApyNnGj+nJAcTGodGy9ihqY4o1GGULgTuWrIzjLOM5lTCa0ONFWQeD
	 DS88JTIzgxG6ZozE8oKgdhKL6X/sDe1ztFAg7J+5YTbJx6qOiua4xdMv8pSivmDp3L0e/
	 U6eTXsqPUedk0bdaPiY/SWTSVZdX5uwXdnP+jSBKrd0sNG2/P0Eh+Dip/j7uIq4E6fA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DRlyrlbU;
	arc=none smtp.remote-ip=209.85.221.177
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF858606A891
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 20:39:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF858606A891
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DRlyrlbU
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5eabf7d5bbeso2226905e0c.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 12:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794429595; x=1795034395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=A04W9o4nzjchR0XXucwN2y18f2T7OtmkNLA3xJKRAHU=;
        b=DRlyrlbUOI+0d1uE+ANv1QL+5w451bZISPvCtL3rsTOGPv3sHCarz2KE/rZ/Fto3Rt
         oNIsDot2cfalwKlfIIsCN8JjcwWQja0s79AyuZ+Tiwikd/uoHfqXzQEPEn/ma+tbvTNW
         4PJ8lRC0+zIPXHzBRnS25TofKII/IQvmN6NzDglGg35Zc7IcPQN4pIgScXIhauV6NH+s
         FjbePG1aDtfUW8hJKyDQLSyziPKCE7ccTudpr7pttbICW2y6PAN7ariFlevcbQtZlt/e
         oIiwlo5RAliOrAPJebgTbQYYfhZBkHnfXz8MtaRCG+MkO86izRqq2TgBs3COnQ/pWoQv
         YzHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794429595; x=1795034395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=A04W9o4nzjchR0XXucwN2y18f2T7OtmkNLA3xJKRAHU=;
        b=qHz1UyNUaahsDkTPZjjGe6p3CXe/hLJlgP0HMzussXkTcahFH4ZGLbIGc4PgakTNnY
         A2axGYWYyXL0qCF8TbYH6YkXh4TGFua4dj8v1WABVw/bVU30brno/+4xGGa/XKk0rYYQ
         5X5ViIbVCbp9i9A+1N9M0WJguTSDCJfdzAvLbzqeafBHtnX0hUGwmxZYvGebFt775bV/
         rLI6Gq1hgTX8fktCQHn+kARh/f5ONqQxfkzZ23BpOYcB8of/Z529em/HI70yAwKnpGaf
         Xd4bQUbOa27gj8+DFs9fhKJvX1nkY+ovWOteDsajZTZgdwleeaHPgrAVK6YGRelNg6fU
         bwWw==
X-Gm-Message-State: APuU4Z8xj8vJmrnJKehYoBOqRfbe4GBUUUCq9b4+Tahb+9VCE4yalDbe
	oM7pCn05o7LvYRZdVz0q2cBlrps9DxO1+70TYm3lgtdS+WT3priLITYl27Z8cA==
X-Gm-Gg: AYBFou2vuwuT/Zpqo8VM9xlKlXXnYl5TSiiiVwVdP9+4g5KJplg1QOklthmEuu8vXJx
	6WABS2emsHOml/iZqDLaw7VPobKj3Rz+laoDgHaTJ3sDXbJNqFjily1PrmYoK4RDxlet8/3XWf3
	YM1hWMWvL09mdrM4DS71x4c83WoiNJUrAu5Iq7+f8QSzZSU46B0OiRhRaDC61ss6WCvycgsama3
	AzahHxMSMyQoAM9u0OE1u3yGrPAShJi6WjbLkHuxZrluwHJoUYAL7/6VhK2sDByULaHwmenySdb
	rahDNrGXKghT3NkPKKTtShFtbO7cE04/XmoF1qREM0TMzuopFvM7TGsGP8AAXi95kzddBEGS227
	16U/vOfrstXonzHljpxMtyQi/IREG70LKQr5zkCM1dnGFCasAdPugt2MiXYXTT35PBEsRf1qp7q
	IXRbB40IydBnvEY/jRkoxl9jQna3A6a2oiwYNPSJKFdJ/JBJ06ivd8B2uzsAbwOsShg8VD7lCGi
	n0sSgN/VwEjr4xXaa1Sjuj2jrWG54dkkBvD/QSN+awJeRWVQvNSxWlb7bF2vR94aQMKfAQq8jGT
	xTF83pGWIJcIQhlKBCfLlPfSjiwTdgUSx6w2ncvrCf5obr7kdPkHlMbUfbMPtAifRSIRvxFnN22
	KCfkB3eXzNTFtiZWCWKj+4Dsj8j4GSsfj6MDAJTWmlR7DT0bCkYGzBorwFOs3lPGpbhsPrBBcR/
	qzMSs=
X-Received: by 2002:a05:6122:1b09:b0:5ec:e237:b17a with SMTP id 71dfb90a1353d-5ee1c462eecmr1578524e0c.15.1794429595610;
        Wed, 11 Nov 2026 12:39:55 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee0c2f3bfasm4301380e0c.0.2026.11.11.12.39.54
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 12:39:55 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 3/5] shared/asha: Use util_iov helpers to parse characteristic values
Date: Wed, 11 Nov 2026 15:39:47 -0500
Message-ID: <20261111203949.3874673-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261111203949.3874673-1-luiz.dentz@gmail.com>
References: <20261111203949.3874673-1-luiz.dentz@gmail.com>
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
index 07327cd4b8f1..2ce61fd13e96 100644
--- a/src/shared/asha.c
+++ b/src/shared/asha.c
@@ -368,19 +368,18 @@ static void read_psm(bool success,
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
@@ -393,41 +392,62 @@ static void read_rops(bool success,
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

