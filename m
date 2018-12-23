Return-Path: <SRS0=7VLe=PA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CFAC43387
	for <linux-bluetooth@archiver.kernel.org>; Sun, 23 Dec 2018 10:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5510221783
	for <linux-bluetooth@archiver.kernel.org>; Sun, 23 Dec 2018 10:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UcbSpKDQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbeLWKkz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 23 Dec 2018 05:40:55 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33008 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727856AbeLWKky (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 23 Dec 2018 05:40:54 -0500
Received: by mail-wm1-f67.google.com with SMTP id r24so17355054wmh.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 23 Dec 2018 02:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=rTvB3KRLzSHUP6Wky17wTDyOYKwnuIu7byYXTsUdgyU=;
        b=UcbSpKDQXJWzfoPPoyngbZ0jcMgjI+s0qGw+m9zy5cgyHKx/TbBmx3gF08yP41vrbL
         wZETXxDZq65VDuKfOmoaZUqnPJzmA1q7lIt6O/I+516gFWQauS61kDb5fyCs7i+QLxVi
         Tsnfd2NRmbAUDVffW5xjUsPg9bS/AjieNfu8AKtkqaCPimoHwmDkCoTwpykaH28v6iko
         KtZPGNvW6DBm5/RPLs3HTh5kZNc8RfjBwv8hZUdvwtmKVLjN6xMUCH6RGS/o8mMTAC3b
         BWoPQ5fQgtc1b6p3YYiy2AwDnuxb9c8xPk71QaKipSr1wUZtmYhjpQca4bCQVrW4dgqH
         ZhTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=rTvB3KRLzSHUP6Wky17wTDyOYKwnuIu7byYXTsUdgyU=;
        b=jWVc/ytAVuAB8pXWCnK1RAJ1JsSeMJIKEjmcwI933D76xgLhYBu+b8mPrdCdwiVKaB
         D8kmgUTf6GFfFXh+4ddzuUWmuKtbJbZ05mrgub/g5VIxc4FKlEwe+p1BJu6aq24OSKMp
         0YcIjeIZ4SWh63foykfsnm/YeNx6YU44jvrFIc0F/IChYqK9FL8OOwgW5JGRs341e4f6
         GSzEOU+WQyo2Q+QsouKyfINf54IClf7m6GnxF/H67s1WxuYe8tJet4q0QUSxZzBkVVoA
         EOsAaTxJZVIDRIot+c4J5qY/KryX2QVKQ1dI1En/5t3lWaU5O2n3eQd9kPuagERyoIOc
         mu8Q==
X-Gm-Message-State: AJcUukf7kxzklh+gHYVBvSsrP0X/0sjqwHpq/S1JLn3z1fMlfaAMceC8
        iKblkHOzKZ84Y9q5mPINe7XtPizJQMg=
X-Google-Smtp-Source: AFSGD/VvKd+7I0vXBU/jjhC9E6erZiwOF/gxLG4TWtichitNShRYScJcjuqb1PCNy7Ajy9DLCDvHfA==
X-Received: by 2002:a1c:ce0e:: with SMTP id e14mr6846010wmg.53.1545561652826;
        Sun, 23 Dec 2018 02:40:52 -0800 (PST)
Received: from localhost.localdomain ([2a02:130:501:7::102])
        by smtp.gmail.com with ESMTPSA id d4sm12168616wmb.25.2018.12.23.02.40.51
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Dec 2018 02:40:52 -0800 (PST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 07/10] a2dp-codecs: Add needed includes and properly check for endian macros
Date:   Sun, 23 Dec 2018 11:40:18 +0100
Message-Id: <20181223104021.18620-8-pali.rohar@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181223104021.18620-1-pali.rohar@gmail.com>
References: <20181219165109.29088-1-pali.rohar@gmail.com>
 <20181223104021.18620-1-pali.rohar@gmail.com>
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
 profiles/audio/a2dp-codecs.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/a2dp-codecs.h b/profiles/audio/a2dp-codecs.h
index a310efe49..649e2411b 100644
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
@@ -222,7 +225,8 @@ typedef struct {
 		.codec_id1 = (((c) >> 8) & 0xff), \
 	})
 
-#if __BYTE_ORDER == __LITTLE_ENDIAN
+#if defined(__BYTE_ORDER) && defined(__LITTLE_ENDIAN) && \
+	__BYTE_ORDER == __LITTLE_ENDIAN
 
 typedef struct {
 	uint8_t channel_mode:4;
@@ -269,7 +273,8 @@ typedef struct {
 	uint8_t unknown[2];
 } __attribute__ ((packed)) a2dp_ldac_t;
 
-#elif __BYTE_ORDER == __BIG_ENDIAN
+#elif defined(__BYTE_ORDER) && defined(__BIG_ENDIAN) && \
+	__BYTE_ORDER == __BIG_ENDIAN
 
 typedef struct {
 	uint8_t frequency:4;
-- 
2.11.0

