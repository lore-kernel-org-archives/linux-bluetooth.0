Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52DD9C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Dec 2021 23:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242195AbhLVXmI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Dec 2021 18:42:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242144AbhLVXmI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Dec 2021 18:42:08 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129D1C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Dec 2021 15:42:08 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id s1so1833207pga.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Dec 2021 15:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Y1ismcWgDnFFXISLA/l57y2B3Rq2xdUkaw18gPCSGm0=;
        b=VdxdZY6Blb+D9pW0gK499pQatucPQ4XRfDwrOtVK8UNY5feWJfixrx0YQaIW8ZRHjI
         aMGztpWyi4Wlf5LNwvx6kniHLjaGe/LoKkItLkKqUEFUZjKoIhKnWE+YAh+tqQ3xQWqQ
         UzOTHMB8Z9Jja741gxxaRFpSmzmlGfe62ihekBytb7BgUFYa6pbFCzb6ONIZZ4Hk+XgR
         fU7EvlgKYNPK+UCHQGFADpZ33r6RcgNM+hH/kzv+hbPk3AsPPL8zaXpDfQhVDLksAvR6
         1lEFtkxUCLu4T3zBfnFjHeqER2eJeDuYs1wDNX9ebau8Z3Zs9eAGjw8N1F3H7H03izeQ
         Bfmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y1ismcWgDnFFXISLA/l57y2B3Rq2xdUkaw18gPCSGm0=;
        b=t1gircMHrXokY+5acNvC5i4/TrFSXupJJpengxc7O8yl9qRUKdnSdJZ5Wl/NYdNKPD
         e/EAVk3DlBIvrQUTvn37V6aluL9ldZ0ZYFXM1IZAcskunKWOqVfMGcpi+Pdgh77qzA4b
         403ZkatcwySRe9DYzczfeAQDg5bjSnZh3FJtAuPL2wpVIOUCJNixtu6qbgl2Wb8mKThB
         aI84lBf9YNfqMwjaUAGKZUXnLu7MS6Vj+fzGSz2Z5zQ/TvH0QfJrcAMJSpnVwnxDZuib
         ommuFKCGRcasWAnvxoTL7HsSjqJHK/ys/fEnUhCtSHFVUbXe0ypbMhOxSCpyYUsJGfLD
         Z6dA==
X-Gm-Message-State: AOAM531dCbeE7rcoCQycL9yiL6grA9cu432knjZLBpY+xC+NTDJ8rm1X
        2MdwFQEZkkX95Jz2shh9Psual3Z1geM=
X-Google-Smtp-Source: ABdhPJyqNOkwy5kaljekYpyX2ZbEwlSklR1aZrySR/Ndb9PbV6tGg9h960F83fWMB0ZzHHOvRWI4SA==
X-Received: by 2002:a05:6a00:174a:b0:4ba:7a99:e789 with SMTP id j10-20020a056a00174a00b004ba7a99e789mr5152709pfc.76.1640216527283;
        Wed, 22 Dec 2021 15:42:07 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id r10sm3563666pff.120.2021.12.22.15.42.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 15:42:07 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 3/4] bootstrap-configure: Enable sanitizer options
Date:   Wed, 22 Dec 2021 15:42:03 -0800
Message-Id: <20211222234204.1455901-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211222234204.1455901-1-luiz.dentz@gmail.com>
References: <20211222234204.1455901-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes bootstrap-configure enables all sanitizers.
---
 bootstrap-configure | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/bootstrap-configure b/bootstrap-configure
index a34be8320..8172840d5 100755
--- a/bootstrap-configure
+++ b/bootstrap-configure
@@ -28,6 +28,9 @@ fi
 		--enable-btpclient \
 		--enable-logger \
 		--enable-pie \
+		--enable-asan \
+		--enable-lsan \
+		--enable-ubsan \
 		--enable-cups \
 		--enable-library \
 		--enable-admin \
-- 
2.33.1

