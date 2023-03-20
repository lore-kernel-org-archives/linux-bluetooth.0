Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBA3C6FD1D
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Mar 2023 05:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjCTFGu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Mar 2023 01:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjCTFGq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Mar 2023 01:06:46 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5192C1EBEA
        for <linux-bluetooth@vger.kernel.org>; Sun, 19 Mar 2023 22:06:40 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id l9-20020a17090a3f0900b0023d32684e7fso12612831pjc.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 19 Mar 2023 22:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679288799;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6VeZhm2jSVX0JL1QW8rR57XybZMflMmDt3p5q8YmGB4=;
        b=KKCZU9gFY1sa4/WEwClbiuA4yYMegso64+LaqwYTdwUaKQ7tEQpyT+F+FgIhZaJzPc
         qHCaOpMYFuC8MDaDjxFG+1+6U66uPVQxNXGS2wtD1yZ6EfT3nKRPGnZm+X7Tp4YN6dCk
         stEYJn7oMEXfe6khDlK+IpNBJ8t1IKYNWBy9J9kqsRuXqeZICB5UUfAH+e36HPXERwxL
         6F4FMYgSx8Ba2xgSqxUzJBAEbHlguHQ1tl1e1PL+b8ysOC2tG3qJlIkdIuVqG42ODU3W
         c/PYJzf2AGnZ5mxqh5+iW9CGNcllrBkYdr7oBrBjvPaX7/phhcpeLidsyrKOwCLzUC6E
         Qczg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679288799;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6VeZhm2jSVX0JL1QW8rR57XybZMflMmDt3p5q8YmGB4=;
        b=mFDrnaAG/FF1kDgsBwggDXmOoZ5yIONDQEL8JtSCtz/zlYEOib2ZyQG86UFKTO0wqV
         15kU66bfTISH9UTxINGu4XMBTz5as3nm35IOwW6RHtWGGUtdXQ0AC1/yC9Gj2aq3aRdX
         Wup5Jqfn/7ovOwJ//96mz3L5pbRydA3Inlpb5A8iwaHArJRnX992oJqCO3wTctqpFZ9+
         9gR+CHSB4rvr5+Wy4YloMYfHjyVUXbNXslfrYob9qTkRuV8v3YbzOFpqN86k6yy00soY
         Qe3hesUGtTtkRKYacnBsjmydTKCaAsW0Dlh7Z7iRZ1cjPthrWVZoNfgd4wzbtwpeaANg
         rOTw==
X-Gm-Message-State: AO0yUKUrxvwCflvYtum+M2oXVXgrQMxvDxXXrckM3Qs919L50lAiK6Nr
        fKH284lCcVr4FUQxrknVvDOvvydjp5+uJQ==
X-Google-Smtp-Source: AK7set9eXWtFIJUZ1BwlIp6U9colFQimvmQYlVre2VKhKmvxNd0faHfZ1FiapgRvn/KUjM0bIQewJQ==
X-Received: by 2002:a05:6a20:659a:b0:d9:7424:3430 with SMTP id p26-20020a056a20659a00b000d974243430mr2809655pzh.15.1679288798999;
        Sun, 19 Mar 2023 22:06:38 -0700 (PDT)
Received: from fedora.. (c-67-170-58-107.hsd1.wa.comcast.net. [67.170.58.107])
        by smtp.googlemail.com with ESMTPSA id g13-20020a63e60d000000b004fba32949c3sm5222456pgh.16.2023.03.19.22.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 22:06:38 -0700 (PDT)
From:   Inga Stotland <inga.stotland@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@gmail.com, brian.gix@intel.com,
        Inga Stotland <inga.stotland@gmail.com>
Subject: [PATCH BlueZ] mesh: On exit free timer for filtering duplicates
Date:   Sun, 19 Mar 2023 22:06:18 -0700
Message-Id: <20230320050618.314590-1-inga.stotland@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This frees resources associated with duplicate filter timer
when destroying management IO.
---
 mesh/mesh-io-mgmt.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mesh/mesh-io-mgmt.c b/mesh/mesh-io-mgmt.c
index f1385edcc..5f51f3a1f 100644
--- a/mesh/mesh-io-mgmt.c
+++ b/mesh/mesh-io-mgmt.c
@@ -35,6 +35,7 @@ struct mesh_io_private {
 	struct mesh_io *io;
 	void *user_data;
 	struct l_timeout *tx_timeout;
+	struct l_timeout *dup_timeout;
 	struct l_queue *dup_filters;
 	struct l_queue *rx_regs;
 	struct l_queue *tx_pkts;
@@ -146,6 +147,7 @@ static void filter_timeout(struct l_timeout *timeout, void *user_data)
 
 done:
 	l_timeout_remove(timeout);
+	pvt->dup_timeout = NULL;
 }
 
 /* Ignore consequtive duplicate advertisements within timeout period */
@@ -179,7 +181,8 @@ static bool filter_dups(const uint8_t *addr, const uint8_t *adv,
 
 	/* Start filter expiration timer */
 	if (!l_queue_length(pvt->dup_filters))
-		l_timeout_create(1, filter_timeout, NULL, NULL);
+		pvt->dup_timeout = l_timeout_create(1, filter_timeout, NULL,
+									NULL);
 
 	l_queue_push_head(pvt->dup_filters, filter);
 	instant_delta = instant - filter->instant;
@@ -474,6 +477,7 @@ static bool dev_destroy(struct mesh_io *io)
 	mesh_mgmt_unregister(pvt->rx_id);
 	mesh_mgmt_unregister(pvt->tx_id);
 	l_timeout_remove(pvt->tx_timeout);
+	l_timeout_remove(pvt->dup_timeout);
 	l_queue_destroy(pvt->dup_filters, l_free);
 	l_queue_destroy(pvt->rx_regs, free_rx_reg);
 	l_queue_destroy(pvt->tx_pkts, l_free);
-- 
2.39.2

