Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6451D934C
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Dec 2024 15:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733932764; cv=none; b=s9XEgDeBeMU9rfZTaYt144ki0n0Yg96z1TcTqBF7v/Pe1pQoQI7WhxkZJCGBYTCbmGM1X8kKsHo59Ni+feOLoSG+ArBR+xLSjYHJvuF4+5ehx/WIuchP3P5X0NbrDJ0KjoRXB7STTj03CP9pYg7Ezx9Dr0cUlIpzE3NMMZ2q4Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733932764; c=relaxed/simple;
	bh=JI1N7QNZBnc6SEn9qxCID7M38WYTyRqRZ4WYv/LD7Eo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HTbR3YVqQtsIigrJNDFHEs4uk6nsBC0/aYA2TUEnCm32yhs3t61HsDxswKjUC46wdkInxomFDJH4d1N9KkxDL8abEj46vrYr2GDjbv5WnGEnREcwh+KEpXI564EvifMRyDBReC4crxJ9KNBviTsBqn9+4ADU2Zlx8U++hiW3QW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d4y3LzZ5; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4y3LzZ5"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aa5f1909d6fso1312415966b.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Dec 2024 07:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733932760; x=1734537560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SOYiRQdE9pxZytNBMm9pR6wOMK4iB6jvsSOkMjprXHk=;
        b=d4y3LzZ5mJMiebAKMUZV5sekHGbCFZWQE0l3k0QFI6qHzPTLeqY5Oh0lWVdCZ+8Ab4
         bOyY231KHMvabGV99hPeUfaGUHEA+sgc+EF4e5fmwN0QwJCMDqJwGAYv2upQg7zUk5E5
         odxri6lk2trcHDb7KfN0IytgMPdeVkisB/YojzLVbbv/pRDUHA+PWADlfrAZFWAIXn6x
         G48soeCGshDQabzVaX8hdbJ4i3/XAuuQx82g0WOYF/tpL22HvVBp28cdPRmkegJ6ex6b
         05AQohiuHkTABFFmvGU77KTRkHNV7NwXw2mRosFEAFSEYuPCKylKRRCrr2uWb0+I8Kvs
         Wv1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733932760; x=1734537560;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SOYiRQdE9pxZytNBMm9pR6wOMK4iB6jvsSOkMjprXHk=;
        b=AV6Q5d6X/1rbtUSMJs8XmQB/9peR9UEM0MqW+6nmLZ70Xyx6ynWpeg5F0jJMUxWrAj
         4RQ9eXb3libkF00TNwamLKlJC/yzVlDRqabW6RWFPeV3QKbDw9dYux+0Yq27OWvcfnOR
         GEcV9CHdjNZ7ibr6V1w0xfEvhES1xd3Or0eUxZV1+/NtkjCU6//qCZprGtvMtmVW/zx/
         a1fqRLvGSgfW3s01894x02ScU6pKde7Rk6n9ziGLe+rsk95ReTLuaFc/YU1PumGTw1Ny
         9obucLvZq4cGbpwqm34vI4l7OpBz2glHUBdfYYFR6qIFOXj441IK4nE4t+rb3zMWPRIo
         fk+A==
X-Gm-Message-State: AOJu0YwbCn9Qfq6Fe0oEKNbHmonKz/fGXdITAtwXItx46JjSSsYoprW5
	w1IGxp+XGphkx2rIJszeeBqUctqAIa2jcMkx7QuRSukCa1/03fZ+m1sf4w==
X-Gm-Gg: ASbGncvQMg+obmdyK9StXRuCTM4GTea8Ru6lO8A1fscq6bRz9q2yc5PWWl7UO2fIffK
	wztsbdKq7c/4cFyu9ByrUj6yUMpjfX7Hp/kVCLNmMKBOTj4xTaq4mfzH6/Qdb5a9jJUE26/C/Jf
	xnrwGYTUMVlqAjU8niVUc9gMbwy+NoMsf/HTPUGyrLADXUnac2NRYndJtMoaDavEkaodFpm3zJI
	e4WzOFf5yd0lTC2NpHKtiodNIg3rO1KEAby96CVkJmVee1jMlr/GK33aFcykKn43/H4RUW+W/LW
	/FpeLdOxqLG8Lore9p9fKEp7/ohNendQ2ymNEDXV
X-Google-Smtp-Source: AGHT+IErvc2rnPHFx+63oBorIV9FpvFWfVTiEaYV6UU77C1vgRsHhXsBfUdYQJHWPsgoagtUTJoG/g==
X-Received: by 2002:a17:906:cc9:b0:aa6:650f:cf34 with SMTP id a640c23a62f3a-aa6b119111fmr262351766b.13.1733932760202;
        Wed, 11 Dec 2024 07:59:20 -0800 (PST)
Received: from raspberrypi.home (46.205.203.47.nat.ftth.dynamic.t-mobile.pl. [46.205.203.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa699487854sm372647466b.13.2024.12.11.07.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 07:59:19 -0800 (PST)
From: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Subject: [PATCH] sbc: Fix mSBC reinitialization
Date: Wed, 11 Dec 2024 16:59:05 +0100
Message-Id: <20241211155905.1312473-1-arkadiusz.bokowy@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 10310fb has introduced a function for mSBC reinitialization.
However, it did not set msbc private flag, which is checked e.g. by
sbc_set_defaults() and sbc_get_frame_length() functions.

This commit fixes this, so now after reinitialization this library
properly packs/unpacks mSBC frames and the sbc_get_frame_length()
function returns correct frame length.
---
 sbc/sbc.c | 71 ++++++++++++++++++++++++++-----------------------------
 1 file changed, 33 insertions(+), 38 deletions(-)

diff --git a/sbc/sbc.c b/sbc/sbc.c
index 2fab366..886806d 100644
--- a/sbc/sbc.c
+++ b/sbc/sbc.c
@@ -994,17 +994,13 @@ static void sbc_set_defaults(sbc_t *sbc, unsigned long flags)
 {
 	struct sbc_priv *priv = sbc->priv;
 
-	if (priv->msbc) {
-		priv->pack_frame = msbc_pack_frame;
-		priv->unpack_frame = msbc_unpack_frame;
-	} else {
-		priv->pack_frame = sbc_pack_frame;
-		priv->unpack_frame = sbc_unpack_frame;
-	}
+	priv->pack_frame = sbc_pack_frame;
+	priv->unpack_frame = sbc_unpack_frame;
 
 	sbc->flags = flags;
 	sbc->frequency = SBC_FREQ_44100;
 	sbc->mode = SBC_MODE_STEREO;
+	sbc->allocation = SBC_AM_LOUDNESS;
 	sbc->subbands = SBC_SB_8;
 	sbc->blocks = SBC_BLK_16;
 	sbc->bitpool = 32;
@@ -1017,6 +1013,30 @@ static void sbc_set_defaults(sbc_t *sbc, unsigned long flags)
 #endif
 }
 
+static void sbc_set_defaults_msbc(sbc_t *sbc, unsigned long flags)
+{
+	struct sbc_priv *priv = sbc->priv;
+
+	priv->msbc = true;
+	priv->pack_frame = msbc_pack_frame;
+	priv->unpack_frame = msbc_unpack_frame;
+
+	sbc->flags = flags;
+	sbc->frequency = SBC_FREQ_16000;
+	sbc->mode = SBC_MODE_MONO;
+	sbc->allocation = SBC_AM_LOUDNESS;
+	sbc->subbands = SBC_SB_8;
+	sbc->blocks = MSBC_BLOCKS;
+	sbc->bitpool = 26;
+#if __BYTE_ORDER == __LITTLE_ENDIAN
+	sbc->endian = SBC_LE;
+#elif __BYTE_ORDER == __BIG_ENDIAN
+	sbc->endian = SBC_BE;
+#else
+#error "Unknown byte order"
+#endif
+}
+
 SBC_EXPORT int sbc_init(sbc_t *sbc, unsigned long flags)
 {
 	if (!sbc)
@@ -1040,33 +1060,13 @@ SBC_EXPORT int sbc_init(sbc_t *sbc, unsigned long flags)
 
 SBC_EXPORT int sbc_init_msbc(sbc_t *sbc, unsigned long flags)
 {
-	struct sbc_priv *priv;
-
-	if (!sbc)
-		return -EIO;
-
-	memset(sbc, 0, sizeof(sbc_t));
-
-	sbc->priv_alloc_base = malloc(sizeof(struct sbc_priv) + SBC_ALIGN_MASK);
-	if (!sbc->priv_alloc_base)
-		return -ENOMEM;
-
-	sbc->priv = (void *) (((uintptr_t) sbc->priv_alloc_base +
-			SBC_ALIGN_MASK) & ~((uintptr_t) SBC_ALIGN_MASK));
-
-	memset(sbc->priv, 0, sizeof(struct sbc_priv));
-
-	priv = sbc->priv;
-	priv->msbc = true;
+	int err;
 
-	sbc_set_defaults(sbc, flags);
+	err = sbc_init(sbc, flags);
+	if (err < 0)
+		return err;
 
-	sbc->frequency = SBC_FREQ_16000;
-	sbc->blocks = MSBC_BLOCKS;
-	sbc->subbands = SBC_SB_8;
-	sbc->mode = SBC_MODE_MONO;
-	sbc->allocation = SBC_AM_LOUDNESS;
-	sbc->bitpool = 26;
+	sbc_set_defaults_msbc(sbc, flags);
 
 	return 0;
 }
@@ -1079,12 +1079,7 @@ SBC_EXPORT int sbc_reinit_msbc(sbc_t *sbc, unsigned long flags)
 	if (err < 0)
 		return err;
 
-	sbc->frequency = SBC_FREQ_16000;
-	sbc->blocks = MSBC_BLOCKS;
-	sbc->subbands = SBC_SB_8;
-	sbc->mode = SBC_MODE_MONO;
-	sbc->allocation = SBC_AM_LOUDNESS;
-	sbc->bitpool = 26;
+	sbc_set_defaults_msbc(sbc, flags);
 
 	return 0;
 }
-- 
2.39.5

