Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 835D9C432BE
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Aug 2021 22:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6547560FC2
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Aug 2021 22:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236855AbhHIWuI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Aug 2021 18:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236329AbhHIWuH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Aug 2021 18:50:07 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30DDC0613D3
        for <linux-bluetooth@vger.kernel.org>; Mon,  9 Aug 2021 15:49:46 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id z3so18299811plg.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Aug 2021 15:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=h5O23deTS/YJXaWeLzUnVmuu6XP6/UdUDz9XhtpcMXY=;
        b=sYXgHv/rqmWQx8m6P4xEGD9Phu13XhT8NgOf/2BzrZsaJOtRKozGSYDW6jNF0WdAce
         wj4+lKGSzYRXtVSvaWmEfG7NJo8HLb8TNdwPFES/iFophhZrghvfoWFuI0fSMh+MgyrG
         reOeRXhXHqH20s4UsEeYOY69rmJ2E1HlBslGsAsMqhlDqWEslc/Z3NVdDIjmNPDpPTvL
         eX+nPU1L0LnAmNbXmGFJXgLk8DFUIfaoYF8aennAmUF43H9DRohRK9AUHMTN1sfifmuG
         u3m5WbKwGhNT6gE809PHB5gxTDhraRgNw2xDCovNPuW8bRmjtCCpr8KSse0Pvlmsx6ZM
         ln9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h5O23deTS/YJXaWeLzUnVmuu6XP6/UdUDz9XhtpcMXY=;
        b=pN/lNdsWkBp9iywqoY2nbozuu0fYk+m47sKz5uXfPOw0TzdHE8a/3qOzyxfnRVj0nN
         mWEuodFayopKxOuX/HxhYjT6NgCxZVHgkphrqvEacjsrmbAaiuNqEsKk6wa3hPJI3raY
         nxkdnqQcfNUzxCm6ECJl5E3kTb5+Z9eqthil80PNlqRA2quAdTGXeAHUUILT73QgPkMK
         D57SlA9LxykXbvUEb6mZ96A4RIzrt9ydxAZ3e0hBpFQ5bR7QgBqdocsI8j0rAjzdV0oP
         aqHk5eD9P3h8SDYi9zmzOoHfMkBnktR1AeFDX6N+iM8PQWpDkdW++3i6tCVc2rRamir5
         R5Kw==
X-Gm-Message-State: AOAM530YmYspFt/DZ98VQPM891vM7wux4mDzpNjoVSy/48b0tHNUSG+G
        9RIKYL/pNGyMtdHAn5k4lz0JaCEDmc4=
X-Google-Smtp-Source: ABdhPJymKrXYfsWXl9SqPFUVAecIiTDLKOz3BN//k3yf/H3nWbwY8kk99GysBbzAaCJxEFZ1VlELfA==
X-Received: by 2002:a17:902:848c:b029:12c:daf3:94f1 with SMTP id c12-20020a170902848cb029012cdaf394f1mr3403168plo.50.1628549386143;
        Mon, 09 Aug 2021 15:49:46 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id n35sm20826891pfv.152.2021.08.09.15.49.45
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 15:49:45 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v2 4/5] monitor: Make --analyze output latencies in msec
Date:   Mon,  9 Aug 2021 15:49:41 -0700
Message-Id: <20210809224942.225915-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210809224942.225915-1-luiz.dentz@gmail.com>
References: <20210809224942.225915-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Milisecconds is probably the best unit to have since it is unlikely that
the controller can respond in under 1 msec as well as most time
sensitive connection e.g. A2DP, HFP, etc, also don't expect the
latencies to be over 1 sec.
---
 monitor/analyze.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/monitor/analyze.c b/monitor/analyze.c
index aae153f94..bee05f467 100644
--- a/monitor/analyze.c
+++ b/monitor/analyze.c
@@ -110,12 +110,15 @@ static void conn_destroy(void *data)
 	printf("    %lu RX packets\n", conn->rx_num);
 	printf("    %lu TX packets\n", conn->tx_num);
 	printf("    %lu TX completed packets\n", conn->tx_num_comp);
-	printf("    %ld.%06ld seconds min latency\n",
-			conn->tx_lat_min.tv_sec, conn->tx_lat_min.tv_usec);
-	printf("    %ld.%06ld seconds max latency\n",
-			conn->tx_lat_max.tv_sec, conn->tx_lat_max.tv_usec);
-	printf("    %ld.%06ld seconds median latency\n",
-			conn->tx_lat_med.tv_sec, conn->tx_lat_med.tv_usec);
+	printf("    %ld msec min latency\n",
+			conn->tx_lat_min.tv_sec * 1000 +
+			conn->tx_lat_min.tv_usec / 1000);
+	printf("    %ld msec max latency\n",
+			conn->tx_lat_max.tv_sec * 1000 +
+			conn->tx_lat_max.tv_usec / 1000);
+	printf("    %ld msec median latency\n",
+			conn->tx_lat_med.tv_sec * 1000 +
+			conn->tx_lat_med.tv_usec / 1000);
 	printf("    %u octets TX min packet size\n", conn->tx_pkt_min);
 	printf("    %u octets TX max packet size\n", conn->tx_pkt_max);
 	printf("    %u octets TX median packet size\n", conn->tx_pkt_med);
-- 
2.31.1

