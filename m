Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF32C4338F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Aug 2021 10:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AC5560F94
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Aug 2021 10:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237526AbhHDKzJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Aug 2021 06:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237285AbhHDKzI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Aug 2021 06:55:08 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B97C0613D5
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 Aug 2021 03:54:55 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id h9so2042119ljq.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Aug 2021 03:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dzQjMcvL3hu6zMgcp73uYdk03r6UJalwpd/O7n8Rr6w=;
        b=U/wRDT+pxoCGmAE2s/EQTtE+O0oRC4n8Uq9BYtIoCxnZrK6bSY78HgPKVGPRQ8r5Ia
         ZZN47ntvaAgL7KKmKXHZ7r9n621XZx3p9vDyWF0AKx6KRs7K9kR/ZwbujHLzAfb54hIA
         rHV/yegnhUeOw+Jgj6jWAeUpDZwwBrF91GE9WS6VRJNd8ljV5RLURfntxoVEQIkuZ9zc
         RvLJII/s4GQuElnT1EwcG0sgkJDUZOdDf7J8IRhre0LMCOWGk/qIw9fMhTrH4zlQ76IG
         0K/gIRfkzOSj/X8ekqHTY26nJ3UxaEpOcDGO67smv0bVIvR7OER2+WuL45IqyCF4H+Ts
         3Q4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dzQjMcvL3hu6zMgcp73uYdk03r6UJalwpd/O7n8Rr6w=;
        b=roSv4TcyQSNiWxaKgiDoFBzveRLVJTkaLx0IQLdCWEyn3hlZBTAFwtcq82luBjRPRQ
         Oza7da/wncaOdXU+2LuZn7Uv6JHTsnax8noyPtxoEONBvvA2qyLJUJUX7yK+KBu8mvU3
         CnIuBjSL9xyi+TFr17BG0lAgrhjgU63Cl7Sr4SdX+1DhuTdCR9Vk6heHgkZhrT/FmmTj
         HOT+hRUOldiL5P3RhTgycAlyoYmIqT/E2kLHZY42mJFHXXligaRdLw/vkg5SC0C3xW7g
         s1l+ACms8eCS9WKugJiGxDn1aDPZWY6CdOIeLoxe7Wv5BAPnC0uGN1r49RjU4zS3M10y
         NHoA==
X-Gm-Message-State: AOAM5300GiD2sfAv0QAOPWnKV0ier7HFg6Gu5vuWcM2FpcFV0UMXbMvK
        A+98pA7aunAzPE2ndco//mFrpLYSO4qHHw==
X-Google-Smtp-Source: ABdhPJy390jLy/FRFV7FznJiQVO9ZHcER3TOJGv6xKLm/y6YEdk9mvKxqWr/sCT1uZPma0kr5kOhMg==
X-Received: by 2002:a2e:7404:: with SMTP id p4mr17070510ljc.163.1628074493790;
        Wed, 04 Aug 2021 03:54:53 -0700 (PDT)
Received: from localhost.localdomain ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id 4sm133244ljf.127.2021.08.04.03.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 03:54:53 -0700 (PDT)
From:   Mariusz Skamra <mariusz.skamra@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Cc:     Mariusz Skamra <mariusz.skamra@codecoup.pl>
Subject: [PATCH v2] monitor: Fix truncated server socket path parameter
Date:   Wed,  4 Aug 2021 12:54:46 +0200
Message-Id: <20210804105446.556937-1-mariusz.skamra@codecoup.pl>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210804085937.541076-1-mariusz.skamra@codecoup.pl>
References: <20210804085937.541076-1-mariusz.skamra@codecoup.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This fixes the issue of --server <socket> parameter
last character was dropped. There is no need to use
strncpy, as the length is already checked, and it is
known that the destination buffer is big enough
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

