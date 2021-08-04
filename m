Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61030C432BE
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Aug 2021 08:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3733B60EE9
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Aug 2021 08:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236888AbhHDJAE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Aug 2021 05:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236876AbhHDJAD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Aug 2021 05:00:03 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9C3C0613D5
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 Aug 2021 01:59:51 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id p38so3353230lfa.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Aug 2021 01:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J/jpn9E/qH0S6IgnbXP74qTOPR1UpoIfV7YCLmx1gaw=;
        b=lWBqs9f5cglW3bH+fboI2bAPcsnnTYTDX5R0QI60YzNQjB5Z5z74uE773u6OXbnOPg
         dxiM6p2xrQt3H8dXQBIuYyd1GDrgz6DkWlqn7f0enCkH5aCtQpXvtPLpCzh4zU2sXWJ0
         zBTa6t4WGMWfH9E1v+D99M2KQa2Hdsfq0S32pKbpg3QCZ0QtwvBeS39eFXZPqi3CzJaf
         hf3s9O0+r56F8FW47Yyyur32YNE9UdAksxmIDjrkKgYDWrnUZecarR2AEz6TlYN4qQix
         htNv7ztoXA/JLr//k5UK1bvkNE4bQzL6h6EHYAG4MwM1mS7ElUJHiGtSDuaa5rN5pYCA
         9p+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J/jpn9E/qH0S6IgnbXP74qTOPR1UpoIfV7YCLmx1gaw=;
        b=Xn/TkUfcbwE/8LAmH+8M0Touv71t7Bbt5uQxAP4J0Odwl8wEa4J+h7t8kG9lbSW6ro
         947tK+jreS2h+o7NPHnRIFmLsA1BhrspMo4Roqq/koSNc5volUPBGBDlKNMb5e+/qEyR
         H9WhGDFtRNbPqz8G6yxXmXJlXgZq5kJzAAfIZK9v7B8t6l9Mh47h9Irgi8vbB7QFO9X5
         Xu+U5ibmMnQRM6ScVGT0592zWhvddDMPWktsI4E1ify1JX0H5z6nEjLanP/sX0rlcHfx
         axXFlPNIU4S8ftb43SoCbptfQI56EvH/WtJ65ZfgaXwjK7qxo6R2DThjX/68ldxR9xKd
         jMtg==
X-Gm-Message-State: AOAM531TKWGi6cRE4AqYfFNxMpFCSsu8JwB1wg2VSyRF1KafjaGgPrdU
        8zl3BPSoJzI518pVdkWnWl7DEZIOX2r4OQ==
X-Google-Smtp-Source: ABdhPJz3TVZ/ipTO5qsw6MTW22ZYf742TS2p3z25GJcMqjh6IjK0m/hRpAeDJxSGD4plxYkbR9ypoA==
X-Received: by 2002:ac2:4c37:: with SMTP id u23mr11753315lfq.340.1628067589268;
        Wed, 04 Aug 2021 01:59:49 -0700 (PDT)
Received: from localhost.localdomain ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id i8sm138346lfu.55.2021.08.04.01.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 01:59:48 -0700 (PDT)
From:   Mariusz Skamra <mariusz.skamra@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Cc:     Mariusz Skamra <mariusz.skamra@codecoup.pl>
Subject: [PATCH] monitor: Fix truncated server socket path parameter
Date:   Wed,  4 Aug 2021 10:59:37 +0200
Message-Id: <20210804085937.541076-1-mariusz.skamra@codecoup.pl>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This fixes the issue of --server <socket> parameter
last character was dropped. There is no need to use
strncpy, as the length is already checked, and it is
known that the destination buffer is big enough

Change-Id: I646f86709d59d33b8f1d27b725eb42a9f44f6f2d
---
 monitor/control.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/monitor/control.c b/monitor/control.c
index d1ba97d37..266602a34 100644
--- a/monitor/control.c
+++ b/monitor/control.c
@@ -1165,14 +1165,12 @@ static int server_fd = -1;
 void control_server(const char *path)
 {
 	struct sockaddr_un addr;
-	size_t len;
 	int fd;
 
 	if (server_fd >= 0)
 		return;
 
-	len = strlen(path);
-	if (len > sizeof(addr.sun_path) - 1) {
+	if (strlen(path) > sizeof(addr.sun_path) - 1) {
 		fprintf(stderr, "Socket name too long\n");
 		return;
 	}
@@ -1187,7 +1185,7 @@ void control_server(const char *path)
 
 	memset(&addr, 0, sizeof(addr));
 	addr.sun_family = AF_UNIX;
-	strncpy(addr.sun_path, path, len - 1);
+	strcpy(addr.sun_path, path);
 
 	if (bind(fd, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
 		perror("Failed to bind server socket");
-- 
2.31.1

