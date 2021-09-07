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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39580C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Sep 2021 22:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2119761101
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Sep 2021 22:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346427AbhIGWbR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Sep 2021 18:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344382AbhIGWbR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Sep 2021 18:31:17 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C14AC061575
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Sep 2021 15:30:10 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id m21-20020a17090a859500b00197688449c4so100336pjn.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Sep 2021 15:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i3F0z84ohA3gaRU7vi+1lhrskpPB6p/jomHClZ+pLRo=;
        b=P5hPvn0Ix5xYNy8gy17/CwJtd1ToB8LW+W/yFaFU42fhFyaf1bsc/Mrp7Fz7blkIqz
         gU/mNtfYZa2y4NYjQogPr7StfbNt8IqI++1iEdX/iSxcuKtBNNXoR9nIEVlSRJ21RZcS
         iZcQOTuzDUEtZ+MZPsQSZwaLaSkhZcOL8NWsFCwmRwhJkhT4D3FtiOO4iDkR7HP2Pbeu
         zSodc/CA+1KzD77MJihsZJzqodluS00Eor8IxIrfFfeFHQzurnhAj1G+ouV3I9MR+qZK
         AWbcp9Ihjg5SfGEPFl2PeA/CpRpHaqlzpGY4mCTMug+gkcwKWKXWcZbm9AoEYUpWlyB9
         cW4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i3F0z84ohA3gaRU7vi+1lhrskpPB6p/jomHClZ+pLRo=;
        b=nZa3oppRfc0d5M0BwvsbCg7bOtEnENqUsCaM97llQSVKSlKb6IvHqEed0rSCc7Ggrb
         lbShYzVQacC4bftL4e9ukpCuDM81V73Xr4709Y9U+omC319o3dt3leAnskFJyRCRhLoK
         HndZCl9CJGHWIbBPu+iNmm9tJ6PKugr0oYstILW93EHt8JdeJxbxLlrJg3WEH9UlIqKp
         qz1B/OEbrSW1PH4kLHNPwSOkWoe2pOfYbft3jbKC7zXm0GeWAEtX7OYXllEzOWRGWIRx
         B3JLYh+MGoShWgRodIgyg+edBRUw7WViBuXf4ND6pKJVfaYA/1IyK0R6qa7WpS6E837C
         cvlg==
X-Gm-Message-State: AOAM531KMXa90rMIMOGNerlEftJkpR82KhL4LycU97Djm9qDbOs9fEFN
        49eCoZD5Y2mEYIXnEPs6XTST5Sq/V3E=
X-Google-Smtp-Source: ABdhPJxYo/WalW8B9K42cPcOtO6yz2Jo3OUOCZkre5vtaXqPw6WK68Fyw2i/XwHEdPoNdn/P/FzQPQ==
X-Received: by 2002:a17:90a:2:: with SMTP id 2mr666115pja.77.1631053809593;
        Tue, 07 Sep 2021 15:30:09 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id x19sm153811pgk.37.2021.09.07.15.30.09
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 15:30:09 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/5] adapter-api: Add Experimental property
Date:   Tue,  7 Sep 2021 15:30:04 -0700
Message-Id: <20210907223008.2322035-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds Experimental property which indicates what experimental
features are currently enabled.
---
 doc/adapter-api.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
index 464434a81..490608e8d 100644
--- a/doc/adapter-api.txt
+++ b/doc/adapter-api.txt
@@ -335,3 +335,8 @@ Properties	string Address [readonly]
 				"peripheral": Supports the peripheral role.
 				"central-peripheral": Supports both roles
 						      concurrently.
+
+		array{string} ExperimentalFeatures [readonly, optional]
+
+			List of 128-bit UUIDs that represents the experimental
+			features currently enabled.
-- 
2.31.1

