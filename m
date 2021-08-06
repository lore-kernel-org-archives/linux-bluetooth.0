Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC60C4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Aug 2021 21:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8517061186
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Aug 2021 21:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245262AbhHFVgS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 6 Aug 2021 17:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245255AbhHFVgR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 6 Aug 2021 17:36:17 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F568C0613CF
        for <linux-bluetooth@vger.kernel.org>; Fri,  6 Aug 2021 14:36:01 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id t3so8805372plg.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Aug 2021 14:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=P3IDmVuKO7O3HkuAlMjxQDVH5awewBmJogAj+DT7iIw=;
        b=n4DVEB5DM+jTjoLxjxzatuaGuEw/LBB7DNQSbGX0hJVhKo6+Fw/0zMG3RbXq1BYY/g
         OQYGBH/I5nrqtYU2Jfw4X7F0dhwXUb4vnO+1yl0bT0xAg7/00drMAVrunX1KB3wOgMzP
         Vi91RWspgbygSyekn6beYtBYL3bsfn/iIerD3RaBEyzIv/0/XqhLJD69C39/b+Cd1DYX
         BmkmA3fpPaRI4MAWjfRfIQxUVNz3Y+WiiMIohI5uUTgaY5pZaqYqKeziKjnxpb7RVifM
         HqjbvzudV22tNAEiPrtHkDr/wjxxO2OAxXmNRDa6qNAntl6v8o9Xz/V7TwKNZJs1XVUA
         +iJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P3IDmVuKO7O3HkuAlMjxQDVH5awewBmJogAj+DT7iIw=;
        b=mpj8NOQUWujpQbtdyGegrujsQl4tedDhsTe3Wpy1WTQp75cz+4LfLc330PzED6XS7B
         iSeJUlbBrwI8nS41D9q0+l3jbKUBeDWE2fH0Q4pqrFuvEgWpsu3WSCqkiqJo/W5LQPhB
         RmJyow8NBATsS5FuqIvehdAUDxYnD53ukoHOTgMdDOoPwNNCG4lqhG4YxEsOs0Att1fC
         +ZLYhIqZAzT0VvxJGoFZshMsnHre0tqZFdOH+p9zUzNf5a3qU0asuwzeNkd+IJj0tSnD
         jN/nrXsmGhnIUewXkr4tPGwC2v32KwAShxgjO6vyKuDRznkrR5dzPi9bqFEuTtt46iTT
         wqaA==
X-Gm-Message-State: AOAM532EkmCaKOuqbhUEwGETcGg8h5PBx4GWOEi0PNZ3a9o4qwM6f/Ya
        1pMmedTVON89o9JKXRlZdRCxlCuPNRw=
X-Google-Smtp-Source: ABdhPJxyJnYnY/u4MzpzvgMWIjq4IQFjEsd82NgqqmtgEuIbrIXE5tL8eaBpvQkJWJC/ekdIYwo40w==
X-Received: by 2002:a05:6a00:150d:b029:3c8:e86e:79ec with SMTP id q13-20020a056a00150db02903c8e86e79ecmr2161359pfu.62.1628285760688;
        Fri, 06 Aug 2021 14:36:00 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id h20sm11765201pfn.173.2021.08.06.14.36.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 14:36:00 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/4] monitor: Fix minimun packet latency
Date:   Fri,  6 Aug 2021 14:35:56 -0700
Message-Id: <20210806213558.16442-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210806213558.16442-1-luiz.dentz@gmail.com>
References: <20210806213558.16442-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

It seems timer_sub can produce negative values leading to median packet
latency to be negative e.g conn->last_tx_compl is ahead of
conn->last_tx, in which case it should be discarded.
---
 monitor/analyze.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/monitor/analyze.c b/monitor/analyze.c
index 5e0957ad1..d504c8d84 100644
--- a/monitor/analyze.c
+++ b/monitor/analyze.c
@@ -386,8 +386,9 @@ static void evt_num_completed_packets(struct hci_dev *dev, struct timeval *tv,
 		if (timerisset(&conn->last_tx)) {
 			timersub(&conn->last_tx_comp, &conn->last_tx, &res);
 
-			if (!timerisset(&conn->tx_lat_min) ||
-					timercmp(&res, &conn->tx_lat_min, <))
+			if ((!timerisset(&conn->tx_lat_min) ||
+					timercmp(&res, &conn->tx_lat_min, <)) &&
+					res.tv_sec >= 0 && res.tv_usec >= 0)
 				conn->tx_lat_min = res;
 
 			if (!timerisset(&conn->tx_lat_max) ||
@@ -408,6 +409,8 @@ static void evt_num_completed_packets(struct hci_dev *dev, struct timeval *tv,
 						tmp.tv_usec -= 1000000;
 					}
 				}
+
+				conn->tx_lat_med = tmp;
 			} else
 				conn->tx_lat_med = res;
 
-- 
2.31.1

