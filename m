Return-Path: <SRS0=/IWC=O4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92185C43444
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Dec 2018 16:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DC8B218AE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Dec 2018 16:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wcf2dAGB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbeLSQv6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Dec 2018 11:51:58 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51785 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbeLSQv6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Dec 2018 11:51:58 -0500
Received: by mail-wm1-f67.google.com with SMTP id b11so6704255wmj.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Dec 2018 08:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=ScLzGwc+SYpeSiZ6fn98ZB21gwV8D7YlsCBKvHsa/5I=;
        b=Wcf2dAGBypCJTcABRkTbAXWFeCfqgJGQoi3AjTCaMsuJ8/DhlAkieIttr4qKZ2fvBY
         WUgQpYCbeGELVNzO468UmgMGK6mQg6UNSzfJeKe9adyMzkoo7EM4VW//YoW1RKTqG9aL
         jD64zgridz45QEgzzYPSVAk9YkBhs5YrMb3BBdAAVQs9E6oyWJeF+pfQIH8q8Kvb+wy0
         pWdq8SP5ggifJ99voxq2DVki1zeimByFLN7+V1afLblZPlR9NebvPZ5t0jUgQh+UREvx
         V9Texex6xcUa0wVtR/XBPO/ZnFqOuD4pGxX5Pv4y35nRrzlkIyJaB8sjO/ujXUSJxcRO
         zVFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=ScLzGwc+SYpeSiZ6fn98ZB21gwV8D7YlsCBKvHsa/5I=;
        b=UTjg5fN6USZdYLvxt/Zlfg6ewIZKGeIhhQkwg5ZEXx5636+RGWQxIa3pY16lM2qGwY
         ++RJxeq4QCbuHCBqsu/9aLLZ8pyqdbk4Jm0nnKa7Mo3WyunlmXGB8Y2fUNKtDKygJGfy
         i+g594h3+R266lQv2HElJO6NWmuONj20hLGP5yxkTJ2y2BBuPmMMum5aiR61SX/+h2Sb
         KLMMWzwGk9oHupiO/8i6xghgCfqnJHBOjWhloX/BMEAT/r5NwP3WyIBkOk5jeQT7miBm
         +RZQoLKeNWbRPLUt1W7rcZmjpClK/IK6/UNQzFe7rbQg+pJ5h/Sd28GVoiZ3sD5OGio8
         h5OQ==
X-Gm-Message-State: AA+aEWbLYNJrvWcD/huzaXQF69HDOpeGTAiYBz7mnEFCdNIJhfjM7BEq
        /ozGCC5hyBAYfyXjQkcZDFm076mWAhQ=
X-Google-Smtp-Source: AFSGD/WhSLHc5ZJY2NVMSBrmgkWZXYvg7FTj2fDj9uIdNMl2mQbZPYTO/ajeff/thAQpPTbULIeLWg==
X-Received: by 2002:a1c:cec1:: with SMTP id e184mr8151223wmg.75.1545238316609;
        Wed, 19 Dec 2018 08:51:56 -0800 (PST)
Received: from localhost.localdomain ([2a02:130:501:7::102])
        by smtp.gmail.com with ESMTPSA id w125sm5613853wmb.45.2018.12.19.08.51.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 08:51:55 -0800 (PST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 07/10] a2dp-codecs: Add needed includes and properly check for endian macros
Date:   Wed, 19 Dec 2018 17:51:06 +0100
Message-Id: <20181219165109.29088-8-pali.rohar@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181219165109.29088-1-pali.rohar@gmail.com>
References: <20181219165109.29088-1-pali.rohar@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Without stdint.h type uint8_t cannot be used.

And without endian.h macros __BYTE_ORDER, __LITTLE_ENDIAN and __BIG_ENDIAN
are not defined.

When both __BYTE_ORDER and __LITTLE_ENDIAN macros are not defined, then
condition #if __BYTE_ORDER == __LITTLE_ENDIAN is true.
---
 profiles/audio/a2dp-codecs.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/a2dp-codecs.h b/profiles/audio/a2dp-codecs.h
index 43a5eef97..327901eac 100644
--- a/profiles/audio/a2dp-codecs.h
+++ b/profiles/audio/a2dp-codecs.h
@@ -22,6 +22,9 @@
  *
  */
 
+#include <endian.h>
+#include <stdint.h>
+
 #define A2DP_CODEC_SBC			0x00
 #define A2DP_CODEC_MPEG12		0x01
 #define A2DP_CODEC_MPEG24		0x02
@@ -213,7 +216,7 @@ typedef struct {
 		.codec_id1 = (((c) >> 8) & 0xff), \
 	})
 
-#if __BYTE_ORDER == __LITTLE_ENDIAN
+#if defined(__BYTE_ORDER) && defined(__LITTLE_ENDIAN) && __BYTE_ORDER == __LITTLE_ENDIAN
 
 typedef struct {
 	uint8_t channel_mode:4;
@@ -260,7 +263,7 @@ typedef struct {
 	uint8_t unknown[2];
 } __attribute__ ((packed)) a2dp_ldac_t;
 
-#elif __BYTE_ORDER == __BIG_ENDIAN
+#elif defined(__BYTE_ORDER) && defined(__BIG_ENDIAN) && __BYTE_ORDER == __BIG_ENDIAN
 
 typedef struct {
 	uint8_t frequency:4;
-- 
2.11.0

