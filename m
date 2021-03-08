Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D563C433E6
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Mar 2021 22:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5EE46529E
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Mar 2021 22:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbhCHWnC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Mar 2021 17:43:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbhCHWma (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Mar 2021 17:42:30 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCB7C06174A
        for <linux-bluetooth@vger.kernel.org>; Mon,  8 Mar 2021 14:42:30 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id m6so8202577pfk.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Mar 2021 14:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZE6Pml5paV8vMbhak/UxbFx6LzmyL4qlgh6H3g+QwnU=;
        b=OBoVGKkr+L8E3jPfPlY7lUNSrEK5lDVroJpTMit/xH79JJvxC79WfLx7Qo90IX19Tm
         WD39jjM6qWKcmyX6+FDyb1lzcatwWt89b60nIgE0/ktcCm4XKdoABgBh5eogwKZjT0fp
         LXlu7MOpFSF2dJXJRpE3cueYA1GAoeVTb91YQxUqDRIZvhcOskONcJzzMBmu06nRwgy7
         Wd/L+Qz1KQMl640o4eZ41hHLjiWcE8KR2g5fnZDoGh22ruf0rRQXbft3OKwhWy61YQ0n
         2EB6PUzXv8w0psA27Qth4EpOyW53lfchiFGJOD2YEtD0DGoBdyofvjYLPp1g7dxY42Gd
         V3RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZE6Pml5paV8vMbhak/UxbFx6LzmyL4qlgh6H3g+QwnU=;
        b=cMiqr60s4fgLX4qfm75Kt98+dtwJlEkKClQTeoDRncex8Cs9HlnUaTEsFfwglbXNZE
         odEKDQrBuplBNOpnKeFagQ31IjarS7P3rtCuRFmFVT1uPO9i/5Mg0nJSq15w1lLa6uJu
         fuvtf70AYf66ZScVnZOH7rcMNPf/a0p4a51l5KW8ifQ/nXDIlxH8EMogcFrMZDlYV+16
         lDuDqrs4cNEhl29iP9+yrOzrWLER4p0HcfLVvkBiawa7PNJIoaBwa/bCHlG0H7A5vvlv
         FFh1FiFBHLfu3Fh32ZBs2dIOgTj39Udh/apHsAVYuAC74IHFs698M+qZIQ4SDsTE2XK5
         7s3A==
X-Gm-Message-State: AOAM533lhF+jRXWMESf/SiiqjTOG8QesUmlwqXfmh6ETctiSovfVjE58
        IMM/bgw70pXiLafNnmkmweAzF1IOJ84e0g==
X-Google-Smtp-Source: ABdhPJyhU6vvlktpu11WGLb4qL3QgAOuPPCSqa7YyopJ88JU3BNAgYI/pInJUPDPQbsdinAlSj9tsA==
X-Received: by 2002:a63:c47:: with SMTP id 7mr14626488pgm.300.1615243349710;
        Mon, 08 Mar 2021 14:42:29 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id j2sm10879563pgh.39.2021.03.08.14.42.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 14:42:29 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] monitor: Fix invalid access
Date:   Mon,  8 Mar 2021 14:42:28 -0800
Message-Id: <20210308224228.344888-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

ident can be NULL when printing user logs which may lead ot invalid
access.

Fixes: https://github.com/bluez/bluez/issues/92
---
 monitor/packet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index a72b424fe..8b87d3d8b 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -11306,7 +11306,7 @@ void packet_user_logging(struct timeval *tv, struct ucred *cred,
 			label = "Message";
 	}
 
-	if (ident[0] == '<' || ident[0] == '>') {
+	if (ident && (ident[0] == '<' || ident[0] == '>')) {
 		packet_decode(tv, cred, ident[0], index, color,
 				label == ident ? &ident[2] : label,
 				data, size);
-- 
2.29.2

