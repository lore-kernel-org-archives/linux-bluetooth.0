Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C91FC001DE
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Aug 2023 19:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbjHDT0L (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Aug 2023 15:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjHDT0I (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Aug 2023 15:26:08 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E304E46
        for <linux-bluetooth@vger.kernel.org>; Fri,  4 Aug 2023 12:26:07 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fe1c285690so4013735e87.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Aug 2023 12:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691177165; x=1691781965;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yFpKa9A9kVr8AJW7PsBI7wCt2VlMHS+Q7NMUYnoadWo=;
        b=ec7p5peQUSYMgZEAoEpTtOuOT+uGi+6XbG320h+6OG3BWOMnhDVDMVZ8y3GL/zIZR/
         qaJFrzIF19yDnn7jpizoYxJRp8zwKoIq8ECVsLoZGRT0jFpuXR+Nt1uEPqZhX+S0INWd
         CD9FyS9lgcXUeOc9W4spLW+fw8ZfKOb+xhDInaUr7pNe89e4xwW3xx9Qac+1Ipl0+9kc
         h0fqrMRlCwtg6bjt77MTFT5Ean7L4KeVyIOxcM89gVjCA7GZQjDAekmP2F3Jn4YQ3x/1
         QouZ//1QCkHtBc8+5GSl/cE/VQvYYf58tYCkdeOZS8VMS3BrZLw+rLy8LpDhjy/mNUUu
         oSiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691177165; x=1691781965;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yFpKa9A9kVr8AJW7PsBI7wCt2VlMHS+Q7NMUYnoadWo=;
        b=dvmauLbaQPcC6PcncdHtHOHKpFECTsDuXIyxX8jSqkz9TJBgbC/FE2vZmr+IZZNy9+
         tTUQdDm4GSCZFJ0pn950bANVeWnq9jJwOaZ39u3F2BXhOw6OLA0s9SKDVVP0vB2Paveh
         3OwtjNXhvw0uNLfQnw5iupzJ3C2yap8Ug/efBmcCldZ4s0/hIAVAcNoI9Eu3/ko2aQnM
         P6GJVBgE2MWZ4sfrNssqg0H02tuMZA31Stheu4xUcPSqYWqbItEkmk6nKJKUKY9qLbkT
         vYI9dBe4uIJugwquQDJA57042iAZsbpkDUIvarTnP3KTi4gzsLWk2CF5K4DsMYfSkFPW
         KhLQ==
X-Gm-Message-State: AOJu0YxhXBFE1x+xMMCDDswwUTxwB5vQi5Js8JGBDzagdbm8B2vtaNck
        zmRaG8IFd/He94yWU9ShA40UTURMMfY=
X-Google-Smtp-Source: AGHT+IGbGhypy4zqAD8YMM8HIVhdsvR4hf13cU4O8ZDr/y38IM36Vuy5B+ih79WcZvtnCoAT8rxUuw==
X-Received: by 2002:a05:6512:280c:b0:4fb:744e:17db with SMTP id cf12-20020a056512280c00b004fb744e17dbmr2561843lfb.1.1691177164560;
        Fri, 04 Aug 2023 12:26:04 -0700 (PDT)
Received: from localhost.localdomain ([188.146.125.123])
        by smtp.gmail.com with ESMTPSA id b17-20020ac25631000000b004fdc6f03c6dsm476222lff.37.2023.08.04.12.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 12:26:04 -0700 (PDT)
From:   Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Subject: [PATCH SBC 1/1] sbc: Fix mSBC reinitialization
Date:   Fri,  4 Aug 2023 21:25:25 +0200
Message-Id: <20230804192525.67067-1-arkadiusz.bokowy@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

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
index d059906..c35b564 100644
--- a/sbc/sbc.c
+++ b/sbc/sbc.c
@@ -1010,17 +1010,13 @@ static void sbc_set_defaults(sbc_t *sbc, unsigned long flags)
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
@@ -1033,6 +1029,30 @@ static void sbc_set_defaults(sbc_t *sbc, unsigned long flags)
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
@@ -1056,33 +1076,13 @@ SBC_EXPORT int sbc_init(sbc_t *sbc, unsigned long flags)
 
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
@@ -1095,12 +1095,7 @@ SBC_EXPORT int sbc_reinit_msbc(sbc_t *sbc, unsigned long flags)
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
2.39.2

