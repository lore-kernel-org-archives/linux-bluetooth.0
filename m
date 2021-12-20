Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18814C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Dec 2021 22:20:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbhLTWUF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Dec 2021 17:20:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbhLTWUE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Dec 2021 17:20:04 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B9CC061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Dec 2021 14:20:04 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id k21so15273476ioh.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Dec 2021 14:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:from:to:cc:subject:date:mime-version
         :content-transfer-encoding;
        bh=9VcGAJmRnLZXfRim4m+DGyv6ghd8MitFvMHpsLDMV+o=;
        b=fElqYKZAVVAW7nTi+z/+sMB5WLW5Qni39d1yYkZr13/d5zo+Fejz7bTHs1OLQ4q84G
         1ioG+YPOXBhachquTkkDyMgv3A6qHk6h78BRrgDcFOVf74hUYixpr7rlH72Hw0KgJLoO
         jNy2zoS1RyQRRhTPuBu9ab7fjw2hXS3SHA/3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:to:cc:subject:date:mime-version
         :content-transfer-encoding;
        bh=9VcGAJmRnLZXfRim4m+DGyv6ghd8MitFvMHpsLDMV+o=;
        b=4Oy4kmifpriztUt75fVKfbWRX4K0hjEUO8zllgtE0PJot6JH0wdm8FLPpwp9H39fDh
         OJVYIZsHFYL6/NP2p7O+xI/s7avaaG4EqkogtYwSK4X84u3ju1FdUFC0y6Vo0NTwk46h
         kfJflIMCkaonVUz5AWd2/jktmR/OrHqZHH1CRgI9CdxitSoBfg9p1yBII9mwfzByHmSV
         XajDhroTDhO36KnnTXqSjLUng2O4JdH4RBeNr++rmW+F5L7wX8VQlssCyKFfYVKyOZCQ
         YQV57+sKHjMo8Ph/wMe9BvYA6eY4rg/DP5VprTQQTIwliZBZ15nSy3hsJR00gKaqq7Dp
         9+Cg==
X-Gm-Message-State: AOAM5305/JXVPCNj18+WN8hJ0SziWqcLrLFfPGtd9FC97rEgBabEosEs
        sInsoKuXf3CjXbHuXGe0u7/Kvn7ox01z6A==
X-Google-Smtp-Source: ABdhPJzoEh3BwvPCzF0m8Ka0YglQwC533YFJ3Q/U7cC/XAOKXGYhV8NWwfL74KA5lt8TBDPM8vpgbg==
X-Received: by 2002:a05:6638:328e:: with SMTP id f14mr193992jav.158.1640038803363;
        Mon, 20 Dec 2021 14:20:03 -0800 (PST)
Received: from melhuishj.c.googlers.com.com (161.74.123.34.bc.googleusercontent.com. [34.123.74.161])
        by smtp.gmail.com with ESMTPSA id c22sm9352706ioz.15.2021.12.20.14.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 14:20:02 -0800 (PST)
Message-ID: <61c10192.1c69fb81.96a67.06a8@mx.google.com>
X-Google-Original-Message-ID: <20211220221818.RFC BlueZ.1.Iabb6889d4aa2fe9d3e61e0a311722531564f0933@changeid>
From:   Jesse Melhuish <melhuishj@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Jesse Melhuish <melhuishj@chromium.org>
Subject: [RFC BlueZ PATCH] Bluetooth: Use driver status and experiment value for central-peripheral support.
Date:   Mon, 20 Dec 2021 22:19:25 +0000
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
The observed behavior without any change is that support for the
central-peripheral role can be enabled through an experiment flag in
BlueZ regardless of whether the controller can actually support it.
Additionally, if the controller has enabled this feature but the
experiment flag has not been set the central-peripheral role is not
listed as supported. I'm not certain what the expected behavior should
be, but enabling if either source says to enable (this patch) or only
when both enable the feature both seem like reasonable options to start
with.

 src/adapter.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index 9fc6853c9..60325015b 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -10434,7 +10434,8 @@ static void read_exp_features_complete(uint8_t status, uint16_t length,
 			}
 
 			if (feat->func)
-				feat->func(adapter, action);
+				feat->func(adapter, action ||
+					(rp->features[i].flags & BIT(0)));
 		}
 	}
 }
-- 
2.31.0

