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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2B5C4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Aug 2021 21:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D50F161186
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Aug 2021 21:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245268AbhHFVgU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 6 Aug 2021 17:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245260AbhHFVgT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 6 Aug 2021 17:36:19 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0C6C0613CF
        for <linux-bluetooth@vger.kernel.org>; Fri,  6 Aug 2021 14:36:02 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id l19so18734251pjz.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Aug 2021 14:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=h5O23deTS/YJXaWeLzUnVmuu6XP6/UdUDz9XhtpcMXY=;
        b=vbVwbu3DiogbUhIsTn7kE4HHTObVoO8snQDIEEVKMg6AGJLu2xEQ65dvd8tkGSiU3Q
         7IGZ9Y9hrSEvd4LwHnumHQVo+mBt3Fjakoso4/ydFEFzqaVmMAfRi2fRxl06iu+AhvOG
         yAs96qi279zM5xBrgnhhfztO7zJ/Gc6+MowGKzpVuc5Wm0cu1x33y6OnGtUKod52Oo70
         CyyZAaXYUQCHJVHRODe5I3RoxZDp+7pxGgEopx+qbZrPUlRkLknutE0ZL5M4GsKOEvvo
         Y3LUfno4jgbLzCTKinVBfEGHWieM8G35w+vvBDCQpgGR8ckGX1TizRViqkNiGhFL0dF+
         J9+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h5O23deTS/YJXaWeLzUnVmuu6XP6/UdUDz9XhtpcMXY=;
        b=fkghsY4aEyaamy//fwe7rsT38bKLw10/JOlT9BTRTAtXZe68Zq2+ppdYQmktwOAYuH
         h5AOH7uaYN0TrxRJx2igOUVLJXAGihdWeUd1e2HbAP7DX2277+E4V2QiKj8a1YUBptfy
         fMoDHCmoly2Rw7r73j28AiSLT7Wg4m7mjosE2eQvJwRUXQdUOoNPO6BY9yW7u7rmRDuL
         CrJj0D4CjbC/o9/hZw1VzrFeB31Y9xMMh6azFu2cNdSXl+YmkG9V87pwsL2q5cJvm0ye
         f3FXTCLK/dtDVmGuCVEpMy4CbM8E7zfLarjsioy3BNns4pb2ydwUk567JLxb8OBeGCbB
         YFIg==
X-Gm-Message-State: AOAM530yt8DbzjCprOLWTDJKhJytvpvVTybKbiRuX8rfoZhrYwaC6vcw
        ZUGf296M9C5DIPE0GANdqqvygDUt9OQ=
X-Google-Smtp-Source: ABdhPJzjRkVFtXHG+gGp6rk92GNxIoNHTXl/DlHxCQEfKnv8iQu78bnWuaF6em/SGIucLAejJf5RYQ==
X-Received: by 2002:a17:90b:4a90:: with SMTP id lp16mr12213930pjb.74.1628285762176;
        Fri, 06 Aug 2021 14:36:02 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id h20sm11765201pfn.173.2021.08.06.14.36.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 14:36:01 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/4] monitor: Make --analyze output latencies in msec
Date:   Fri,  6 Aug 2021 14:35:58 -0700
Message-Id: <20210806213558.16442-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210806213558.16442-1-luiz.dentz@gmail.com>
References: <20210806213558.16442-1-luiz.dentz@gmail.com>
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

