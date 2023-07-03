Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E31EB64DC
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 Jul 2023 14:17:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjGCOR0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 3 Jul 2023 10:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjGCORY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 3 Jul 2023 10:17:24 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC68E72
        for <linux-bluetooth@vger.kernel.org>; Mon,  3 Jul 2023 07:17:22 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fbc244d386so47680455e9.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 Jul 2023 07:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688393841; x=1690985841;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AKyS+fyTgns6uqGiHeNZDD4/FshXCuvqba4EjpsGTtY=;
        b=x14za32iAGSU72hi1D5KXDHjfL8SqI9J+qV8qY9mu6PkcaT9mH4lovneS7Fwmoil8f
         sFHaGAMR2uc7y/Vu8C3b8kPtEyj+YkOVL0VK6zsu/QB/+WdYzjrrLsMh1iu98Z9FvDTX
         0tk7x6sslXBLnOXVVqRwYsLvUGBDUWIdG6Ai3+hct6z0o0+iJJtcVpJmijqqnBr1l7/W
         aL6oUjyhmItLkLQV5js7msI37l5W+QphaFOIKUO9UELCX6nmnBk2+7vi26Q/TySDB1Y1
         z8K6Br0jvHut3iF+7uUiPuXzstgG585vGssQ5g852ME+ko//oki/52iiYKukWcX9m8va
         iHxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688393841; x=1690985841;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AKyS+fyTgns6uqGiHeNZDD4/FshXCuvqba4EjpsGTtY=;
        b=Z3cd58ElrLRDetow5fPrzxWEpRBBIib+9OBrFddF0dLmWGbRL/GG7ihhMzY2a58TaJ
         cUh5nB0bEsCAFOwQ+No6xYKrK3yTSAOUYvXT6fqRc245IubKvfQ4wc6YEETsh5P6cEWP
         gG6EoVAGjlpIAneJK4+oRpuSrruNPEwCUUkWx5jzSkPn3i3UfOjI3JKNMs+GnWeZ98LK
         /unlWfnHVHA9tx3VunTtbDCL2dfvLc/yTRvZQ4hqf6WDIat0bqI1FOqNYKIEONb3DUPa
         Jq5hnys9CuS9Md7R7GAjZNdPdIpaWvfFTdymRqVjcsPsm0AVdsKepN0T1qSuDe5cNAYS
         XbGg==
X-Gm-Message-State: AC+VfDy91FdW5hXG7wBZ9aMUl4egqdWD8ydHLsRtLKEpc47jHwGUZesn
        NBlhIUlUEwy56qQUXerSthesWA==
X-Google-Smtp-Source: ACHHUZ51bcnZSYbL+6aHx0mx/k5JuWDgoFQDl/mLBxn4uIbEWmjNWVmLYFYWS1otY9KHCdcX9M7FVg==
X-Received: by 2002:a1c:7219:0:b0:3fa:d160:fc6d with SMTP id n25-20020a1c7219000000b003fad160fc6dmr8313002wmc.30.1688393841164;
        Mon, 03 Jul 2023 07:17:21 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id f12-20020a7bc8cc000000b003fbbe41fd78sm11807753wml.10.2023.07.03.07.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 07:17:19 -0700 (PDT)
Date:   Mon, 3 Jul 2023 17:17:16 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Hilda Wu <hildawu@realtek.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Alex Lu <alex_lu@realsil.com.cn>,
        Simon Horman <simon.horman@corigine.com>,
        linux-bluetooth@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] Bluetooth: msft: Fix error code in
 msft_cancel_address_filter_sync()
Message-ID: <be155fef-7758-41b2-a6e8-8f7e253ff452@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Return negative -EIO instead of positive EIO.

Fixes: 926df8962f3f ("Bluetooth: msft: Extended monitor tracking by address filter")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 net/bluetooth/msft.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/msft.c b/net/bluetooth/msft.c
index b80a2162a5c3..abbafa6194ca 100644
--- a/net/bluetooth/msft.c
+++ b/net/bluetooth/msft.c
@@ -743,7 +743,7 @@ static int msft_cancel_address_filter_sync(struct hci_dev *hdev, void *data)
 	if (IS_ERR_OR_NULL(skb)) {
 		bt_dev_err(hdev, "MSFT: Failed to cancel address (%pMR) filter",
 			   &address_filter->bdaddr);
-		err = EIO;
+		err = -EIO;
 		goto done;
 	}
 	kfree_skb(skb);
-- 
2.39.2

