Return-Path: <SRS0=YOMr=7K=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E2DC433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 May 2020 06:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA914207BC
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 May 2020 06:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kHoIW/1X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725780AbgE1Gqa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 May 2020 02:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgE1Gqa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 May 2020 02:46:30 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E499EC05BD1E
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 May 2020 23:46:29 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id y189so27615064ybc.14
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 May 2020 23:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=j8kTDZDT/aaAtikIRo80XDHzGcHZZBKkvIsiEahlfCw=;
        b=kHoIW/1XY8oo9qMq111KwDWTN8znyvGWsCNZc2BRuhQE0YCTQJ8Jt3nWSz11T/Dd1P
         F+dsv+OsX9z7xUFdGL4IgHFSpf6gBycp7dFOhC2AJCOghSFG7lGk02a51t8ffMR5pdKY
         8wdNGk2sIflre/OXlrnIBAzl6t6EHQkvE74cVL3lYxEp+otIAPhh8kBz03ubatMeQugQ
         0Zrtq7qoxryozwqxUjmKaq5A+TeBtWACzRBYRR8Kik356BTxt/hEeCDy40ze78JpeTCb
         fwhUR9v2k+WZBUHZqocjn7sorpYJWSINXRhVa4LGZ3gXEtyMwPyteyArEUjuSBPbE5gz
         doYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=j8kTDZDT/aaAtikIRo80XDHzGcHZZBKkvIsiEahlfCw=;
        b=TLPw3qz2Her4URgHM5bo55/QArki5Fa69H/s7kU+5AlCvVj/i9sjO8SVWjZWqYDJMB
         mrhovCReNeQQ3K4AmVSfXCfwsPacBozaxQxxLnBPzVbY4WJxxCRu53Ism4tvhGWHAH84
         ICcm9rmU+qdFx/gNAD3Nd3lgXj+dHJiVzxvnjZ8ZrwwwoYUfNyUtc6I9kbmm9VCve8Vt
         2h53zG5XDrSo6maJGd0i90TRfcopIIyt+J7tqWFkUMp/mxrTmYXHEcLZedYC2Bp/wuA+
         m8A26Q1fz0vvZ3upnR/FujclfDgGVzg5K4PLVL/ZVOOW6vWkPCwWQA8BvWrtYCIKk98K
         Dicw==
X-Gm-Message-State: AOAM530nAS36ySsucAYKHBMA2iHGAQdDlhHTKXLdE3so0pVzZaTsdlBp
        v/oPia/Fw5Hau77NqsjZfpfTufmFIZu1mz5ORJHydxXhXReP/H/lHfOUtoEXRvFR7FNMCCbLCs3
        LEO04iDwpiI2IwkOEaHQpEhz79ZJCEk2cUNaeWwT5KAYgPWR5RCeY8Kro9u9gRB9ftyGPkmNv5n
        J9
X-Google-Smtp-Source: ABdhPJz60jsC3gSjne/HCkQOTEIPqhnIYr4dLlxBbjjsepl16apgmLmlvRCDBDbiKRV87SeXetglUJOj4Qg7
X-Received: by 2002:a25:e785:: with SMTP id e127mr2169422ybh.37.1590648388943;
 Wed, 27 May 2020 23:46:28 -0700 (PDT)
Date:   Thu, 28 May 2020 14:46:21 +0800
Message-Id: <20200528144605.Bluez.v2.1.Idd38f20f6ff4fc0b295a0a4a8655079373216933@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.rc2.251.g90737beb825-goog
Subject: [Bluez PATCH v2] audio/avrcp: Fix media player passthrough bitmask
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Michael Sun <michaelfsun@google.com>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

Adjust the values of the passthrough bitmask with the declared
keys in avctp.c:key_map, according to section 6.10.2.1 of the
AVRCP specification.
---

Changes in v2:
- Fix the mix-up between the first 4 and the last 4 bits of each
octet

 profiles/audio/avrcp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 773ccdb60..6c529bf0c 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -298,8 +298,8 @@ static unsigned int avctp_id = 0;
 
 /* Default feature bit mask for media player as per avctp.c:key_map */
 static const uint8_t features[16] = {
-				0xF8, 0xBF, 0xFF, 0xBF, 0x1F,
-				0xFB, 0x3F, 0x60, 0x00, 0x00,
+				0x1F, 0xFA, 0xFF, 0xBB, 0xF3,
+				0xBF, 0xF9, 0x06, 0x00, 0x00,
 				0x00, 0x00, 0x00, 0x00, 0x00,
 				0x00 };
 
-- 
2.27.0.rc2.251.g90737beb825-goog

