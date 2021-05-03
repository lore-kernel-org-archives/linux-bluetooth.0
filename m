Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDDB7C433B4
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 May 2021 10:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C79F8610C8
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 May 2021 10:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233216AbhECKFR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 3 May 2021 06:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233218AbhECKFG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 3 May 2021 06:05:06 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59ECDC06174A
        for <linux-bluetooth@vger.kernel.org>; Mon,  3 May 2021 03:04:12 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id g29-20020a25b11d0000b02904f44adeb480so7044189ybj.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 May 2021 03:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LnUjlGz38MHKl4kK47ZhHWnpX3jjIoovM9n6tgvDXXM=;
        b=u09yMpWAPasl2MgwPxQ50J+YyrC+dasqn3OF7CheHr76D6OO8dCVVBQzklTa5ZCeJE
         R8dZr0WIw7R+aM6BxNgWgNUkXc9rae75XkFqT34/nRhDXk+GnX86tCTTVtmKOJ9xXnJA
         pnwZsvT3ZKGsRiTIu7rVRNG0hbec3U8h9qhsI0ekjHDrHpq1KCdnrLEpMvNSdBcYWhUc
         hFiXFGsFuuFR1jA+IgG4guj8/FeeyT+qatNBEEEKn+yMv4yLGOmatINfe+dEAK0KXBQF
         KKAfBsZe3wfPt/dfh2NmfrpdgipGQp6KXiIVZddNuulqn2CmPz/gImBsueDU+ywo5KrO
         /dMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LnUjlGz38MHKl4kK47ZhHWnpX3jjIoovM9n6tgvDXXM=;
        b=mGbP8Msrx5NrNnDA76USzils6PmafGP/lKSVWbAmnHfbSnr6QfPraf8mJAKI+ibECZ
         LaeqVAJvyuXScPF7pS6M2ocDqLs9g5yp0v/HtzN+crGkr3zZrx6moVWteTAlrC0yopRX
         gYH14SttHgvKlLRLYKcgxYq5+d1f4LV8xW9CrT2WI9yo2Bh7wp0z6PckofeWVpJuAVo6
         SiTam+BmT6SjSu668CfclxAZMA7p/J8DheQ4FBRca34NB6775b3wMDvU8r5JISPLiFvD
         Ex6U04RV71gJ95pKWvrEH4DNq/FLkQxeBLL6FzY2cEK6cFsmIuWi1tTrSRB18nVKSlXj
         +v8A==
X-Gm-Message-State: AOAM532S1v78eOZRPQghFy+UfeXjdaiD+QcSiw4An64Y6n6Bh/TLeV2m
        5gla6T/mmbwHWwpxA8L+KNcq1boiQmrYfid0FkRUmOrLirTrlFu7SChJphjR1SMFfD7naoRaVT6
        12m2AT6mWx6QcMo/gFxgCkBOxaVU+1VoDBXxtWOm6SNDVCcp6FztvxlDCLQjiT8t+KA1a2uDzNC
        /R
X-Google-Smtp-Source: ABdhPJwAcrnIn8uGPWUlYen5r4p8PyJHXs902p/nySerwaen496U5SemdT5BL78F+Uqe/JGQ2CX4DdqbN6Kh
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:5010:35e5:ebd5:76d7])
 (user=apusaka job=sendgmr) by 2002:a25:2bc1:: with SMTP id
 r184mr26498538ybr.51.1620036251434; Mon, 03 May 2021 03:04:11 -0700 (PDT)
Date:   Mon,  3 May 2021 18:03:45 +0800
In-Reply-To: <20210503180321.Bluez.1.I462ae10efbf980757258cabcce883b212259a793@changeid>
Message-Id: <20210503180321.Bluez.2.Ifd899edb45d3800750c6d04d6bde30a0115c007f@changeid>
Mime-Version: 1.0
References: <20210503180321.Bluez.1.I462ae10efbf980757258cabcce883b212259a793@changeid>
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
Subject: [Bluez PATCH 2/2] Makefile.am: Hide test-gobex* behind OBEX flag
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        Yun-Hao Chung <howardchung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

If obex is disabled in the config, running gobex test is unnecessary.
This patch skips gobex tests if obex is disabled.

Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
Reviewed-by: Yun-Hao Chung <howardchung@chromium.org>
---

 Makefile.am | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Makefile.am b/Makefile.am
index 2a222167f7..add80dde9e 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -492,6 +492,7 @@ unit_test_gdbus_client_SOURCES = unit/test-gdbus-client.c
 unit_test_gdbus_client_LDADD = gdbus/libgdbus-internal.la \
 				src/libshared-glib.la $(GLIB_LIBS) $(DBUS_LIBS)
 
+if OBEX
 unit_tests += unit/test-gobex-header unit/test-gobex-packet unit/test-gobex \
 			unit/test-gobex-transfer unit/test-gobex-apparam
 
@@ -514,6 +515,7 @@ unit_test_gobex_transfer_LDADD = $(GLIB_LIBS)
 unit_test_gobex_apparam_SOURCES = $(gobex_sources) unit/util.c unit/util.h \
 						unit/test-gobex-apparam.c
 unit_test_gobex_apparam_LDADD = $(GLIB_LIBS)
+endif
 
 unit_tests += unit/test-lib
 
-- 
2.31.1.527.g47e6f16901-goog

