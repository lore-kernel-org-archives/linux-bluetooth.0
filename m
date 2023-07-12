Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F0E2C0015E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Jul 2023 19:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbjGLTjC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Jul 2023 15:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbjGLTjB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Jul 2023 15:39:01 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5D71FE4
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 12:38:59 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b8ad356f03so48737935ad.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 12:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689190738; x=1691782738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MyDU1INtuPnC1dvOf6tBCH0BkXwEoWCuMhND3vaDQkk=;
        b=Sv2E49ihqys/5aLky6sqIyXyZzAHGJoXORtvUhvoGdsbkT/9mY/bfvbfOcYjT7MQ5w
         CPl7boUI5hZcvJs2eSYjzplWc2G+CpyZWmxw8OoDRFQmvwboIieuDpX9//WU/3QHotMi
         744vGw59UoJNQfw2pMlIBW/hRLWQ2HeahUlFlRDbAY4vRCcDUHCEKl2RwtKF7qKpnRDD
         iJD+f1rQI/Kkd8vgqC5TEpdCokzoGn7oYCwLITmLmGyGI4vpF4cjp9CTZ/tkHWCGymKO
         fiZ3/qiD/YoKiEVZMxgiZf03Zqp8i3XfcLGEOl3sn2G1tgE17XA5FeLgXe0HKKDrsZoL
         t+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689190738; x=1691782738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MyDU1INtuPnC1dvOf6tBCH0BkXwEoWCuMhND3vaDQkk=;
        b=Ffo2AYfr0iuxmwSRW5IlPUucJy4vL/puPw3KkWE7V89TGxz/P92rLrss++lA46gM+k
         DeyRYB5l9tYE1Hv6MiDtyEdsJ8J5CqwZCNUvRTQwXi6c/1ZCdAyDqAX/MUrTpaNW4Qxh
         uPC1MxIvtSxPkg73VbYaRur54DWUmH5EdPbnYF7X4n1L0oEEJh2i9ydyLRV+XXJAB02a
         rzr7ilhTjE4ixPXsxTNgXEPoM1c7DTU83/KFvLPkwUyD/eSsTMVNj801fbOa0mE5PhG4
         j4qHPcaHJXqT5ZdBph7UJVzc4asWIu7y8W5+Jppwclh3+S3AjvBflzGJZLDsLRQ+oO2h
         CF9g==
X-Gm-Message-State: ABy/qLYrv3eKzn0ysO/XfA9ZDphOU5/Kjo6K7qLZ4ngdvUmT3j2QtzH3
        gSwSo3fT3VUC5n6hAHjVsLmns/aN4mE=
X-Google-Smtp-Source: APBJJlFHSMXcKLTui/WhH8zvpDL/uujjTi4b9fPYokfyFl7NpJYinIsU0qaY0U4krvgLAaPXpo3KlQ==
X-Received: by 2002:a17:902:e746:b0:1b9:ce7a:8603 with SMTP id p6-20020a170902e74600b001b9ce7a8603mr14032025plf.66.1689190738530;
        Wed, 12 Jul 2023 12:38:58 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-236-201-58.hsd1.or.comcast.net. [71.236.201.58])
        by smtp.gmail.com with ESMTPSA id ij12-20020a170902ab4c00b001b84cd8814bsm4413264plb.65.2023.07.12.12.38.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 12:38:56 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/5] main: Remove DEFAULT_SIRK
Date:   Wed, 12 Jul 2023 12:38:51 -0700
Message-Id: <20230712193854.1862996-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230712193854.1862996-1-luiz.dentz@gmail.com>
References: <20230712193854.1862996-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

DEFAULT_SIRK is currently not used.
---
 src/main.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/src/main.c b/src/main.c
index 8dfd2543ba1c..150a5af4cca4 100644
--- a/src/main.c
+++ b/src/main.c
@@ -61,9 +61,6 @@
 #define DEFAULT_TEMPORARY_TIMEOUT         30 /* 30 seconds */
 #define DEFAULT_NAME_REQUEST_RETRY_DELAY 300 /* 5 minutes */
 
-/*CSIP Profile - Server */
-#define DEFAULT_SIRK "761FAE703ED681F0C50B34155B6434FB"
-
 #define SHUTDOWN_GRACE_SECONDS 10
 
 struct btd_opts btd_opts;
-- 
2.40.1

