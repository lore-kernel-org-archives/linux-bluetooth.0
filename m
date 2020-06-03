Return-Path: <SRS0=Vaj6=7Q=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4FCC433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jun 2020 17:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DB842068D
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jun 2020 17:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c3M/xiwo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbgFCR4Q (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Jun 2020 13:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbgFCR4Q (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Jun 2020 13:56:16 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2885C08C5C0
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jun 2020 10:56:15 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 64so2092026pfg.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jun 2020 10:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J99Q6xTXtDj04+Du0fCQJFtCW8HBuU4z5s+dPJzoIYo=;
        b=c3M/xiwojAUGzMnptkETJWPfjN8knQc/M9d2XTX7mk+wQDrzyJG08y2MHozUzDfAj/
         RlVwjsV06sxAo8UJRklDBCxLxOOIy/F5hlw1Op7XuPEDwkRj5efSv736TRgcMBi1h2Cr
         5zqG3LimGpElPEnA+W3mZB4XcOh92GX+vfFYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J99Q6xTXtDj04+Du0fCQJFtCW8HBuU4z5s+dPJzoIYo=;
        b=Wn9TnCbZsg+/HEJCJcTA7ynHLdVGaZQMuJqM50IlPzK24wjdziX2Bz9nQzssyFqkgU
         cqIreVuoKaqcManfioMhNyLTfkwFJ4AAlhIOfWlKm2qIXT7J42ceNL4TuyIkNUJUGpBp
         WqMo5D9XBwE5WlYGsYbidNJL4xeQBQtWUXGoot8Lrs++s6vRYa5kQfeW4YCjWEi5kZsZ
         X87EXmFF7ZOdept3ZnHjhg9/PZip+YCgka6iRdX+LT4PhIq0m3s9Spt7UbpbxZ3v2OQP
         j8i3xPqEXDVUI+g9X6I3tToa6KDr7eYLAJubQtU6ctoWkU+TjFy7ZAj7BoLnD/GLOTzg
         8+eQ==
X-Gm-Message-State: AOAM530LcamyqXI+qa+EpxisRA1J8TcuudIOgunatQN2C4cy5ftfY1ca
        mz9FydO1uI8x24PHbLAFb0HlhkRNMTg=
X-Google-Smtp-Source: ABdhPJyDni+rboUMjsaSF+c3u5l/rCzI2qANSkv+UWTlDNsyejaqR6715vAtvKen+qpn/u6MbyhhfA==
X-Received: by 2002:a63:1a01:: with SMTP id a1mr494583pga.87.1591206975088;
        Wed, 03 Jun 2020 10:56:15 -0700 (PDT)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:b7e2:9910:bd78:608d])
        by smtp.gmail.com with ESMTPSA id t2sm2064518pgh.89.2020.06.03.10.56.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jun 2020 10:56:14 -0700 (PDT)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>
Subject: [PATCH] shared/util: Fix undefined behavior of left shift
Date:   Wed,  3 Jun 2020 10:56:00 -0700
Message-Id: <20200603175600.3006-1-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When left-shifting 1, we should be explicit that it is an unsigned 1.
---
 src/shared/util.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/shared/util.c b/src/shared/util.c
index 330a0722a..3b976fa16 100644
--- a/src/shared/util.c
+++ b/src/shared/util.c
@@ -140,7 +140,7 @@ uint8_t util_get_uid(unsigned int *bitmap, uint8_t max)
 	if (!id || id > max)
 		return 0;
 
-	*bitmap |= 1 << (id - 1);
+	*bitmap |= 1u << (id - 1);
 
 	return id;
 }
@@ -151,7 +151,7 @@ void util_clear_uid(unsigned int *bitmap, uint8_t id)
 	if (!id)
 		return;
 
-	*bitmap &= ~(1 << (id - 1));
+	*bitmap &= ~(1u << (id - 1));
 }
 
 static const struct {
-- 
2.26.2

