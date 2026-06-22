Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0558E3B1022
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 13:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782136236; cv=none; b=YglkIQ0sBa+DzLANRDN0kodbIt2PzYmbl7awRQNG61y8WJl348xRtP3G4vVVpzIZRIxZMtre/Nvg+B/F9RAaHf1wngJerUvYNiv/O/rL4VdJUWqjumjmkXKPe++5lYzO2W6/KuW92S4StIXkE4pBXUBp4R8sxmZTsi+SxbxuMyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782136236; c=relaxed/simple;
	bh=aGtBPESRm3txCjwTJwhTRrFHDAsV0jdLdFp2Hxp1geo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=oKp/B4vhBn8KSP+QEe6ni0y+AChrM9sTBFW17rglo8Z2V4L9fVuGVsW2CuZVCbshs4lOi03wk+uURZ0e3yz3zu31OWp+7Mfxcf6Ua8i1DlIcdCPP1c4peXz9UxM5D12S9+yNfHTNpvytBW2gzFwvVSaNDqrDCfEc9ygrOxiyxm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e1iVRYuX; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1iVRYuX"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-963ebce7076so908227241.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 06:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782136234; x=1782741034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=dlj+C+D+p7geg/QOPr8ArXEBGtjMTBv7C5CJwWs7+Gc=;
        b=e1iVRYuXoNMjSVfLtb6ak25mxf2gukACBe56MIpeM8iY9pCyRyKM+TGBkFqLBBpkQT
         WrYT+edGki35pUIOWieGdAJlzR8p5QOxQftbH4a3+c2A/UJDASqzbE94KxCXek3A8IVA
         wJbW5vUKR6lTZoTqiBQ4fGg4xwT3AZ3+Ln42uJsAML34w+qnbw38OoNPorMDRk19NUjA
         xQjZzvwh8lKU5gUDy8eWIYkod2u9BsghkPhYczGNYkTxTUFCi1fqEaf9L1vRLQaZquOQ
         y6MbrcW6XlyB4+YhNfjPSwaEwsSx9rZWiai28yqtAx5ezWJoEKU1nk2ZX1qUMVgN17z7
         RG8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782136234; x=1782741034;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dlj+C+D+p7geg/QOPr8ArXEBGtjMTBv7C5CJwWs7+Gc=;
        b=E0ojdjczLrMnmTFdMTbt/DoVXcN53Sbpy2SRYs2cZqpfHMitkYft0Dr9cntJZ+ASIm
         EqJMBg9AMEEEntShnwAS7KVzVzd661gWbMyWYmnhgGtiuT5MnMQNaPYh+FaTZzsje+oq
         Y9L5hElXGsgMjkl/KpfMgDphU5PItvfosKOEjVPunLmOtTY0UkiU25FVsicUO2L88aWb
         OHdD0S3q5EG5OKsJznGXrD4EgNG4nXPObTzp9R+dVhuoo3StBxA5S5kzndQEiZA+jyv+
         Alzj1vbSH97wgw0w6v+aU4yq2Ck4zwh9s2EgQJJ4HqMtbLLdS8UiVBaZsUl5KParpUA6
         qGYQ==
X-Gm-Message-State: AOJu0YwN5km9M3IlE8neO+Wj7MrFgUwN9dd+TjPqmMkjTqlGs0/1kt+f
	kRlegCWbgYerdd8PNPamj/9dwGnzQIzjAdMkxCIP7oxIyXMxYwl4qdndzsDRHvQNGJ0=
X-Gm-Gg: AfdE7cmtXiB0/ra7GrnkWO19mY9fGj9g2CWfz3gfbJq9fHIOONgTfpuwjTEgdzO3RR2
	u5Ywvy2qwl/r4ATWsQQOoGuUbjxgqjycpKsunSoEZpVT2BiZNP8C4DvHx6S80hsjt1Qll3cT6Ei
	KnIbw/EcU1i/hlxxfB73eGrfFF8Xh5G8MJzw8pLbKij/TYNMfnv1azcGYE8oYLspwaZc6UclB08
	joW64ipBqDtFyPMGaYsfnckFlG6uGZVo9/XJurHm3jPMCS1Fq02zd2K1CIh9bsoyMrHkC35u7mH
	wkiQeqotaEY1HWr1D0sDeUjq+co4HMFHTDDIt0w8Lpcg/gIxgh/+R/OpnSU/zCcCchQKca1JPps
	OZ2wDmjT7/0qGuuZF3meFA7u7CSZsqz82K7lrVL5TrwTIQ49uCzIUxA1SHLnD4HY7TrqY43OpDK
	w9oINjL0StF7HEM29t+8BozPgFgI0KfvaueMDfY4WD2eQcHFkkwWTon24bEYXy5aPxsllXtPSHt
	qEDZ+s=
X-Received: by 2002:a05:6102:2c1a:b0:60a:8515:9097 with SMTP id ada2fe7eead31-72b649454b0mr5214160137.3.1782136233955;
        Mon, 22 Jun 2026 06:50:33 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-72ba2299803sm6146206137.1.2026.06.22.06.50.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 06:50:33 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] a2dp: Fix handling of codec capability storage
Date: Mon, 22 Jun 2026 09:50:27 -0400
Message-ID: <20260622135027.646361-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Codec capability is one byte long (max 255) the storage format is
02hhx which means each byte ends up as 2 characters so the buffer
needs to be doubled in order to handle capabilities of that size.

Reported-by:  p0her (_@p0her_) in TeamH4C working with TrendAI Zero Day Initiative
Reported-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 profiles/audio/a2dp.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index a5e002784c02..bf163de0ff03 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -971,7 +971,7 @@ static void store_remote_sep(void *data, void *user_data)
 {
 	struct a2dp_remote_sep *sep = data;
 	GKeyFile *key_file = user_data;
-	char seid[4], value[256];
+	char seid[4], value[9 + 512];
 	struct avdtp_service_capability *service = avdtp_get_codec(sep->sep);
 	struct avdtp_media_codec_capability *codec;
 	unsigned int i;
@@ -2373,7 +2373,7 @@ static void load_remote_sep(struct a2dp_channel *chan, GKeyFile *key_file,
 		uint8_t codec;
 		uint8_t delay_reporting;
 		GSList *l = NULL;
-		char caps[256];
+		char caps[513];
 		uint8_t data[128];
 		int i, size;
 
@@ -2386,10 +2386,10 @@ static void load_remote_sep(struct a2dp_channel *chan, GKeyFile *key_file,
 			continue;
 
 		/* Try loading with delay_reporting first */
-		if (sscanf(value, "%02hhx:%02hhx:%02hhx:%s", &type, &codec,
+		if (sscanf(value, "%02hhx:%02hhx:%02hhx:%512s", &type, &codec,
 					&delay_reporting, caps) != 4) {
 			/* Try old format */
-			if (sscanf(value, "%02hhx:%02hhx:%s", &type, &codec,
+			if (sscanf(value, "%02hhx:%02hhx:%512s", &type, &codec,
 								caps) != 3) {
 				warn("Unable to load Endpoint: seid %u", rseid);
 				g_free(value);
@@ -2398,7 +2398,7 @@ static void load_remote_sep(struct a2dp_channel *chan, GKeyFile *key_file,
 			delay_reporting = false;
 		}
 
-		for (i = 0, size = strlen(caps); i < size; i += 2) {
+		for (i = 0, size = strlen(caps); i < size || i >= 2; i += 2) {
 			uint8_t *tmp = data + i / 2;
 
 			if (sscanf(caps + i, "%02hhx", tmp) != 1) {
-- 
2.54.0

