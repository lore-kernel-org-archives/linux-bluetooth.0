Return-Path: <SRS0=/IWC=O4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89162C43387
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Dec 2018 16:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51C16218AE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Dec 2018 16:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uZxfC4zB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbeLSQvx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Dec 2018 11:51:53 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43551 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbeLSQvw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Dec 2018 11:51:52 -0500
Received: by mail-wr1-f66.google.com with SMTP id r10so20207019wrs.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Dec 2018 08:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=Wyl4nKNSoA632AhIdxkLdVuxjYPJ9OmtiYFGvPWStT0=;
        b=uZxfC4zBymtyBPqBqhNodCPZhFH9p+w439vGy6ZRJfsGQgxPZQ/brpH80v5Db4ey/6
         WAl54//GIaPRsbOlSa8RfEpTp8tu9oBEmfS1BHHySJ5fOWVjo3lFpDgogKb4PxLGZ1FW
         khT6Qjk6a9MsEJQfdER/awXPB6dE0mOYWlT6VI6Dfq8bK5q9j2Q5ufCwmEz3o2deFQWU
         xhWS1PmTgwSnugs+m4aORQUm3Y+PeCocvoqjP9/QTvUeBSgykkUlNBa76bsPGpHCM7XN
         903PWUt6Kvy/BWMM56xQHlCaFgA87g+yl1djOiFcedx0bX9aKIczxvEc8Cpf++Uy9B1o
         GW0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=Wyl4nKNSoA632AhIdxkLdVuxjYPJ9OmtiYFGvPWStT0=;
        b=dKDujaWn1ATuQpdOHNFNf11bCRkIAHME89GLTJ+GgnN52ERdtwvtxkvmMpsWpYlsix
         ggNMQLiNHxoWy3N5tIiD/jJmw0hxuYInsfCKtXXMqnJcI40sHMqNsPXhhIc6XuY4cKSX
         p+iZxe9lpNq7rg7vA1l+iXWxOTHFTjB5X8Hq9EypejsdXlpxgFZqow96SS+Lv+oh+1e8
         SXPUMP+9LOzpq5qgfusZFBZ3HGb/7EVm1nEZrAHCIRKfEl3cz73Qqdf9H5/d0gurhp8a
         RHN/ScOiGLktI7vJ/paAIN7Jz4Ioc90lggEA0yKH/5vvXkB0+hF3qa3+hB9YbIb+p7lC
         sNig==
X-Gm-Message-State: AA+aEWZwI5ilunYJK8U7VQemoQAPGNoQy6FjKajZ3lm6KV3/Vvv4WIYM
        yvxugh05pi4cAEU5MWG1zcFrrycm6Eo=
X-Google-Smtp-Source: AFSGD/UPLPZWmMIgL7rjGmn3WDdOtH8TZV2pOhiWKa1jbTb2O0rQfafwzRAOo60wO1PB8GJCGga1hA==
X-Received: by 2002:adf:d0c9:: with SMTP id z9mr18583339wrh.317.1545238310897;
        Wed, 19 Dec 2018 08:51:50 -0800 (PST)
Received: from localhost.localdomain ([2a02:130:501:7::102])
        by smtp.gmail.com with ESMTPSA id w125sm5613853wmb.45.2018.12.19.08.51.50
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 08:51:50 -0800 (PST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 04/10] a2dp-codecs: Fix codec id for ATRAC
Date:   Wed, 19 Dec 2018 17:51:03 +0100
Message-Id: <20181219165109.29088-5-pali.rohar@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181219165109.29088-1-pali.rohar@gmail.com>
References: <20181219165109.29088-1-pali.rohar@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

According to Bluetooth Assigned Numbers for Audio/Video, ATRAC has codec id 0x04.
See: https://www.bluetooth.com/specifications/assigned-numbers/audio-video
---
 profiles/audio/a2dp-codecs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/a2dp-codecs.h b/profiles/audio/a2dp-codecs.h
index 205491939..25959902c 100644
--- a/profiles/audio/a2dp-codecs.h
+++ b/profiles/audio/a2dp-codecs.h
@@ -25,7 +25,7 @@
 #define A2DP_CODEC_SBC			0x00
 #define A2DP_CODEC_MPEG12		0x01
 #define A2DP_CODEC_MPEG24		0x02
-#define A2DP_CODEC_ATRAC		0x03
+#define A2DP_CODEC_ATRAC		0x04
 #define A2DP_CODEC_VENDOR		0xFF
 
 #define SBC_SAMPLING_FREQ_16000		(1 << 3)
-- 
2.11.0

