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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52444C432BE
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Aug 2021 22:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 341FE60FC2
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Aug 2021 22:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236062AbhHIWuG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Aug 2021 18:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbhHIWuF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Aug 2021 18:50:05 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09227C0613D3
        for <linux-bluetooth@vger.kernel.org>; Mon,  9 Aug 2021 15:49:45 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id bo18so8256888pjb.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Aug 2021 15:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=P3IDmVuKO7O3HkuAlMjxQDVH5awewBmJogAj+DT7iIw=;
        b=E3p4vgad15xlbMN8K80JFQfYcoWsulrcvv8gkwic2pEq1wlzPESdvdkR77y9iFDaMr
         9yzLRQjtsHGyKrwr8vvrrg9BYthuv3bccOUGX7aFVj5hn8Bscjjg4LIlwIcg4wLn0CLV
         4PPybBmaasnP+6sseH4UD6pDJCMyYAitIuisCPkSon7q+lM/TMaLrVmMTYjP92Cz9KvJ
         JYA2leDVKYgfge3HfLn5xDHZJNAzThk238jaRnPIhJpJVljGGSe4tJYJLlnlecpfhsXJ
         saSVLCkHEqrKFCojZV49aY5Bk32i+h3IgFkBaPD4/qKFo35hL+tyTbqavjwbOPqvQGmQ
         2Dlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P3IDmVuKO7O3HkuAlMjxQDVH5awewBmJogAj+DT7iIw=;
        b=ujeNHCwefSjU/K5g22r5gHlewcg8mhfvXh8IYJ9dz+uUPuYNacrmihKmdXLyIQti0V
         z/nYPUR/sahZhyQew/r4YSbhLGCyFITtXSQBy7YF3vYB+n5GKRtjJvTbxHO0edc1G2gb
         ALugGbLr86SrAw2NCLKzCOzrQKMfL8jATNvJF7K27/hK3YeOID2wQo+G0iC83p+NAKAB
         1HKCDCO9ycgg6ruq+h2LOyRLk4gT+loZ7Y8Hpv2d5ftAWO/8ULWONKhTWNHF8KOC80hO
         n0LQMHHbUyc2P8Y521zVXBz0t0Qp3jX2oXuyz9VRWunv31ShcViXWICga5acVdyuwCJJ
         gpHA==
X-Gm-Message-State: AOAM533QKmzea900kb4Avi19KR/0UmgR733J23Jgt9YXTVflofP/UIK4
        i505gSY4Lie9x/S6V/NOd3bDmJ8GAtU=
X-Google-Smtp-Source: ABdhPJxz6Y/eBT9UNTifUUy6i2TrmlK/2AnaK39kIhO0nQTlV6rsudqrJFE8U+fCgVnSGkXPS0nyFg==
X-Received: by 2002:a17:90a:ff94:: with SMTP id hf20mr12266491pjb.64.1628549384370;
        Mon, 09 Aug 2021 15:49:44 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id n35sm20826891pfv.152.2021.08.09.15.49.43
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 15:49:44 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v2 2/5] monitor: Fix minimun packet latency
Date:   Mon,  9 Aug 2021 15:49:39 -0700
Message-Id: <20210809224942.225915-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210809224942.225915-1-luiz.dentz@gmail.com>
References: <20210809224942.225915-1-luiz.dentz@gmail.com>
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

