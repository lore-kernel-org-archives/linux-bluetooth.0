Return-Path: <SRS0=PnVy=63=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86244C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 May 2020 21:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6702A2054F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 May 2020 21:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DWPXH1Ly"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbgEMVim (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 May 2020 17:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728954AbgEMVil (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 May 2020 17:38:41 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ABEEC061A0C
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2020 14:38:41 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t40so11546686pjb.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2020 14:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=18CgMxLU+rbIFuY4cOwcYIpcbc6olt5ZDsvE6aAwIww=;
        b=DWPXH1LygqxlwQxdOoKCxU9s3GW7rq5XKE/Khz1yu+TyDuRzFIxSRElBioo+as9al2
         KiHmflIaGgmRrJWRbFwfmXBfF7v6+BOkHhFFtat8855otNRc0RpW2uUK5n/uILxi6+FU
         ukykIPje2TNWTGV1xypfTXwwzjVJi8c5qs0t4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=18CgMxLU+rbIFuY4cOwcYIpcbc6olt5ZDsvE6aAwIww=;
        b=k6SIMs6KnZXh6BkLWfusSMl9H3LuOQP3g8nym9osRAWNoJa1rsjWO0K624ZlmL+ViR
         0c/cmHDw9xbUiZNpk6SeNQe6ALdKE4T9PFKac3T/OO8eEd6wxj7mG/G22os/PrVTyli1
         dQqrCuVhF5qqUx4m3NmNXsmxrKJFapmoc52+KtJZ6x13f1XqM7ItBEpvArbHdLdDUn8K
         5sF3mPH7BvgDdWN2/1gJFtuAGUm0iVCaQszIQM7fS/8qpNh30G9ONBo/FD6Yu2DI1Eyq
         fQzccvOT9Z+CXHfHr3AzNCVVDIX2SNrz1Oi/2iNyEjHpbnumTdfmsRzwID7n9zLPyHDG
         0Otw==
X-Gm-Message-State: AGi0Pub65B+IDjiN2LzwCfoojEg905nXhz/1VUiQC2Rb9ml4rwdPPKEy
        KOwGgKM/S5HKNCIPyJBnm3HWGhXZVqQ=
X-Google-Smtp-Source: APiQypLPAkwb98ugtRW0CQJcDJqzlG3A5IDtOrgtdvTqM4k7YAZlNyCVOnM2i9LaxS4XRWRGqwha9A==
X-Received: by 2002:a17:90a:b293:: with SMTP id c19mr38654672pjr.22.1589405920676;
        Wed, 13 May 2020 14:38:40 -0700 (PDT)
Received: from localhost.localdomain (c-73-231-41-185.hsd1.ca.comcast.net. [73.231.41.185])
        by smtp.googlemail.com with ESMTPSA id ev5sm35294423pjb.1.2020.05.13.14.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 14:38:39 -0700 (PDT)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>
Subject: [PATCH v2] build: Add an option to explicitly enable hid2hci
Date:   Wed, 13 May 2020 14:38:12 -0700
Message-Id: <20200513213812.23165-1-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <77B1AB20-C903-427C-A3BD-E10C79815EF9@holtmann.org>
References: <77B1AB20-C903-427C-A3BD-E10C79815EF9@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

hid2hci is no longer a common use. This patch changes the default to not
build and install hid2hci and provide a configure flag --enable-hid2hci
to explicitly enable it.
---
 configure.ac | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 1433ace4a..e1c8fd9ad 100644
--- a/configure.ac
+++ b/configure.ac
@@ -218,7 +218,9 @@ if (test "${enable_udev}" != "no" && test -z "${path_udevdir}"); then
 fi
 AC_SUBST(UDEV_DIR, [${path_udevdir}])
 
-AM_CONDITIONAL(HID2HCI, test "${enable_tools}" != "no" &&
+AC_ARG_ENABLE(hid2hci, AC_HELP_STRING([--enable-hid2hci],
+		[enable hid2hci tool]), [enable_hid2hci=${enableval}])
+AM_CONDITIONAL(HID2HCI, test "${enable_hid2hci}" = "yes" &&
 						test "${enable_udev}" != "no")
 
 AC_ARG_ENABLE(cups, AC_HELP_STRING([--disable-cups],
-- 
2.17.1

