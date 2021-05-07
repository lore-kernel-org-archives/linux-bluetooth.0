Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F61C433B4
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 May 2021 04:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8438613E3
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 May 2021 04:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbhEGEeD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 May 2021 00:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbhEGEeC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 May 2021 00:34:02 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3D9C061574
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 May 2021 21:33:02 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id a7-20020a5b00070000b02904ed415d9d84so8670005ybp.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 May 2021 21:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=5UQ/wwx1Ydws36/YktDrQoi4ihTeH8GoY5vacP6mNkI=;
        b=HelFeH0jV5JUuvJMmcGxSCcG8lfgba3TIZgdS8pZDYLAYHDITknYoBQkJfQskfwyd9
         w3WZKTwxkD/TCg0VAXQ/xB/c1ztPWu7h+Oz9JUsFPApWYZWEvu13dori3XQqiAO6o5O/
         3A+IvJzrYR/Aw84AcQOuLkTIZBvmm43b1eEzjCxQ7aLJmNfRAV4wPtlDmf9tLjid6qId
         FnsprpUyPRbD7x3fP0TxgG+TXKDNNcB30+bAN280jPzeD/i5PohRvzyaBrke8U4enHki
         479i4+T2UGNPdzExRyZU1h3JXCs1o/GEz9Q5a/HrjWVB/PPEJZWfsD5gnHQDXyguNy5m
         nAQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=5UQ/wwx1Ydws36/YktDrQoi4ihTeH8GoY5vacP6mNkI=;
        b=IbBIwjmVAgPIk8/qfWTbwTJXBhV/FrRfOsFOpMCqKhb9qTxtjYaacZas5qLIANbA+a
         NRY9/at5sUV3OTkfoAefUMsAg/RUPtHjysq4MwrDWzVe8xygPmUAiMJMZJoW1+VkWC8C
         cUdlD3SKGN/jCYb4Nmi8eKrvEMatgX9rxhEUHGlRAAHCYe4n+0MyiRfKWRZRqFQ6MvQa
         Xn3/7j4aOBiJ6WfPmQBMih6lkqmimB37nz0jXtvUCVGM5olhmiemWkpJ7wGVHSopWraD
         FXZu3m6R7MOjAXuRLaC6Nf5tTijxIxOa8CSVPOiUds98TQ/oN9kbcZqL49zx1Vraoz4U
         REzQ==
X-Gm-Message-State: AOAM530m+sB0er5OOD2vwHdIgUbY6Q9a6SbXrrulrpUjC7kPNWlMkZ8q
        d5/i04YqT0YPdciOAMnNHaOgWl9DioCAGR0ydElwyYeBJkUqTH1qg3BQF42XZ/2D50+Y4hueeh7
        gEAdYgSy/DtdZJ421W+j4jCLciPqwCQxZmHMUKhN9+COI1+Y+2tD5NsHA1W/QvkAcFlM3WxX9Jg
        i+4vQ2NAR5MhE=
X-Google-Smtp-Source: ABdhPJyZyUXADJNT/GuDbROZPTZVGWD1T9FRUWdSXwXbGbweSJ1SihlAJti94xoOTcokrrw8hGmLUHdLkU00+78w7Q==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:40b1:d831:771:711c])
 (user=howardchung job=sendgmr) by 2002:a25:e682:: with SMTP id
 d124mr11678871ybh.148.1620361981896; Thu, 06 May 2021 21:33:01 -0700 (PDT)
Date:   Fri,  7 May 2021 12:32:57 +0800
Message-Id: <20210507123246.Bluez.v1.1.I15d73dd47b94af906daa3f5a25d4fc5db8cc5b29@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
Subject: [Bluez PATCH v1] core: Fix loading AVDTP options
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Yun-Hao Chung <howardchung@chromium.org>,
        mmandlik@chromium.org, apusaka@chromium.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Yun-Hao Chung <howardchung@chromium.org>

Fix misassigned AVDTP StreamMode option, which causes StreamMode not
being set.
Fix AVDTP SessionMode option not freed.

Reviewed-by: mmandlik@chromium.org
Reviewed-by: apusaka@chromium.org
---

 src/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/main.c b/src/main.c
index c32bda7d407d..7612d6984890 100644
--- a/src/main.c
+++ b/src/main.c
@@ -774,9 +774,10 @@ static void parse_config(GKeyFile *config)
 			DBG("Invalid mode option: %s", str);
 			btd_opts.avdtp.session_mode = BT_IO_MODE_BASIC;
 		}
+		g_free(str);
 	}
 
-	val = g_key_file_get_integer(config, "AVDTP", "StreamMode", &err);
+	str = g_key_file_get_string(config, "AVDTP", "StreamMode", &err);
 	if (err) {
 		DBG("%s", err->message);
 		g_clear_error(&err);
@@ -791,6 +792,7 @@ static void parse_config(GKeyFile *config)
 			DBG("Invalid mode option: %s", str);
 			btd_opts.avdtp.stream_mode = BT_IO_MODE_BASIC;
 		}
+		g_free(str);
 	}
 
 	parse_br_config(config);
-- 
2.31.1.607.g51e8a6a459-goog

