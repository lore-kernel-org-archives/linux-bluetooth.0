Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8539C433B4
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 May 2021 03:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94F3D611CB
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 May 2021 03:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbhEFDoH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 May 2021 23:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbhEFDoG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 May 2021 23:44:06 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77291C061574
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 May 2021 20:43:08 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id u5-20020a17090a3fc5b029014e545d9a6eso2140230pjm.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 May 2021 20:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=v4sIB7CW7eNqeHRknNb8xK7/J/zKawxOJQD/udkqmgA=;
        b=A6Slnis0Gy0YdgrM8+X6MAT/k2xhU/dKAIjiBzdgNRTVATHjEpOuSbB5Nd7hUAe/Qt
         Lj49Jo2bNPf8oAsV14vpFNa1eg0Z6zZSvubUJE79qx/KKqiP96fEWtFNRVC93vYy1oJ0
         vvnjhgTUV/mdBe4q/fPfukdRd9M0k5shwp5fwgh5Uhwz5p4HMYdKkA28n4qEXv3m4taX
         j90gBUddIpGsxB8wwOGAxJvQlKYqfj5IDyONRvqZmz9EvTatBf2y9K5aZ0l7u07B6vK8
         +k+LoVPaSNlaFWyV9WAqnmDLANxkonfPSUh5LcUdbl+sXaPLxDPNEVTVTQnDIxlnA9YP
         slog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=v4sIB7CW7eNqeHRknNb8xK7/J/zKawxOJQD/udkqmgA=;
        b=ZNRFzTT0G2bkIhjoamq9b7u2VTujqjizG8D3HIDgrUqR2tj4PYkAu9G/jiC/SpqHFt
         wO4o2Sk+b0R/HKvOK6XiI+eAuT5AFK1/BtWMDrWhTImSyyPOXtFRUEicnl4sB7Mo3pc3
         isa7AKIi/JzBSlAXxV8WqzEyCzuW8gliLeJPEn1Kfz9Tf5yHnegzmgkljUm2PZ2A5cp1
         U+LlZh/+gPQEOlHqwxXX9wVbRpPRfnFbIqFdsqeRLhILCU0VGaeAlVeOnQLjOvoY7ES6
         sbbui3VA88mUumGcYEkZIs553tv5Uv/W+pCwoB3j4XLA2bxOug6FQgoYoejI6GL8EfgL
         hzlQ==
X-Gm-Message-State: AOAM5332ok34C1spUu8I76U5fp90CZo+ELn5cAGT/ACOCCARxjjOc7tq
        K6q8NC5LtnsOI/r+F5gotiV3HIxbbP6Dh4JLGGsmMBxL/wSegV07kBkt4u9CCepDKHsvs6tLAFs
        O1RA+iAN+k9S/CKKt4WICZgW2bWl0jR12Hyo0YGdrxDOL5yZlWaqvtD8Eat2Qwhh+AyZYzJt/dY
        m5
X-Google-Smtp-Source: ABdhPJzms5A+NrrhW5dZbyllBQn0Vaj1TAgSaiJuDYdo1oNQSHjH5B/TufxZZA+QjivTULLFb8gq6vAgJ6TC
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:f548:7c9e:65f1:7d8])
 (user=apusaka job=sendgmr) by 2002:a17:90a:174c:: with SMTP id
 12mr1300474pjm.1.1620272586129; Wed, 05 May 2021 20:43:06 -0700 (PDT)
Date:   Thu,  6 May 2021 11:42:55 +0800
In-Reply-To: <20210506114234.Bluez.v3.1.I462ae10efbf980757258cabcce883b212259a793@changeid>
Message-Id: <20210506114234.Bluez.v3.2.Ifd899edb45d3800750c6d04d6bde30a0115c007f@changeid>
Mime-Version: 1.0
References: <20210506114234.Bluez.v3.1.I462ae10efbf980757258cabcce883b212259a793@changeid>
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
Subject: [Bluez PATCH v3 2/2] PRE-UPSTREAM: Makefile.am: Hide test-gobex*
 behind OBEX flag
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

If obex is disabled in the config, running gobex test is unnecessary.
This patch skips gobex tests if obex is disabled.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---

(no changes since v1)

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

