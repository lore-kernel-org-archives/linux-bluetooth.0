Return-Path: <SRS0=zRH5=6U=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7150C47247
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 May 2020 00:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0D0B20735
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 May 2020 00:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XFsUhlj0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbgEFAzw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 May 2020 20:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727989AbgEFAzv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 May 2020 20:55:51 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1AEC061A0F
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 May 2020 17:55:51 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id 145so132275pfw.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 May 2020 17:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=d9DEX0VgBZeXX3aOggd3B/J1oL9vOHkxYqrl4OvBCL8=;
        b=XFsUhlj0+F9CXtAf19V3Zw848EfOVgllrie76w3nLaAsRHQa4GeyXZSWJNVZ6GHlVX
         Z3B6/OePiqIVQtb2ggNcq0GGbdyeGF8I9tgVFEsbNp3I91r1M2awp+ELVP5FfoPOvR1R
         mN41g9tKtEybYR+QDGmMqyc8jlraCEew1Tf+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=d9DEX0VgBZeXX3aOggd3B/J1oL9vOHkxYqrl4OvBCL8=;
        b=WzOn3fTfeO/65cjPETH76jiIo2IgHbrRH8/c6UYWWkKiSjRq/1wEnnHbwWfn2Kan+a
         2OPNRe+4mpKLdnwbFOAuBLIjKPxRUAW+XRshhyXN9+8kuhgl3ckJc3uF8+mJ6yS8IvED
         znG93S3SYb6Kph8Aj3xKpsDlz1QeYZ3eW39teJRRmdIGRvHOknZXjUrRfW3edySluuyI
         NZRXN76Qqau6NURMYxOwbGdp9a8cOm57pdNwauSdr1ZZv5m/Lup1nfj9wbfSXeenCZub
         qEJVkXSugbl+Ijy5k1iQXk6kSpBCtkes8EW/5Bhea26YGNhKK6NPGFMLLEDFLEnkWKAy
         Ok5A==
X-Gm-Message-State: AGi0PubYMn1AwzKaEMVhEd2WqgCqY8ypd6HI4nD+A5j8eDmhcQJMySFX
        bLtfurIk/8IPdcXy5PHTE4dLfZ+MZNU=
X-Google-Smtp-Source: APiQypK+RiiSPUZjqc537IJzMDQ1Js/FPLHWJ2zTj2tv9f4aZJVBSk3m72FE0VOnsTSfeb3TTWfNhA==
X-Received: by 2002:aa7:9dc7:: with SMTP id g7mr5797758pfq.291.1588726551115;
        Tue, 05 May 2020 17:55:51 -0700 (PDT)
Received: from localhost.localdomain (c-73-231-41-185.hsd1.ca.comcast.net. [73.231.41.185])
        by smtp.googlemail.com with ESMTPSA id f74sm3574010pje.3.2020.05.05.17.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 17:55:50 -0700 (PDT)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>
Subject: [PATCH] build: Add an option to explicitly disable installing hid2hci
Date:   Tue,  5 May 2020 17:55:28 -0700
Message-Id: <20200506005528.2897-1-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 configure.ac | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 1433ace4a..ba9937a16 100644
--- a/configure.ac
+++ b/configure.ac
@@ -218,8 +218,11 @@ if (test "${enable_udev}" != "no" && test -z "${path_udevdir}"); then
 fi
 AC_SUBST(UDEV_DIR, [${path_udevdir}])
 
+AC_ARG_ENABLE(hid2hci, AC_HELP_STRING([--disable-hid2hci],
+		[disable hid2hci tool]), [enable_hid2hci=${enableval}])
 AM_CONDITIONAL(HID2HCI, test "${enable_tools}" != "no" &&
-						test "${enable_udev}" != "no")
+					test "${enable_udev}" != "no" &&
+					test "${enable_hid2hci}" != "no")
 
 AC_ARG_ENABLE(cups, AC_HELP_STRING([--disable-cups],
                 [disable CUPS printer support]), [enable_cups=${enableval}])
-- 
2.17.1

