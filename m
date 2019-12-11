Return-Path: <SRS0=dcS5=2B=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94902C43603
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Dec 2019 09:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69C0C214D8
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Dec 2019 09:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="b1M+u6Le"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbfLKJt1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Dec 2019 04:49:27 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51609 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727888AbfLKJt0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Dec 2019 04:49:26 -0500
Received: by mail-wm1-f66.google.com with SMTP id d73so3043305wmd.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Dec 2019 01:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=ew5JWCOcSlKaUdOBW2upCduPJsnWEHhMOGfyRLOM/Ks=;
        b=b1M+u6LeZzfLRE63nJT4EwennKzWm2huuKcVuAQB43o5C88vNT07efqLx2pSavKKRr
         k2dqMp6/rxETI+GhLwSubs7At19B+2hSjOZUi8+qyhNYIenbXDwMKku9FS5AEAmgnLb+
         dU/HgwUlhFytzlUzo5o9Pvkjycl99b2/7U3kYciIwJhaHotCvzleA11B68L4nsei/WNU
         VESkqxpc9JSZoYu7xK4MLuZ79Wj6qfJCKuJJ9JnpaYJeFojm72TChD/o4jhW/Ex5wylK
         DI/KgcMu+o5KiftFsIpb6cdbJObDUi/vfYKnB9S9/ChC9Z0KPtqv5aKgzp7WLfBlNaBo
         wh/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ew5JWCOcSlKaUdOBW2upCduPJsnWEHhMOGfyRLOM/Ks=;
        b=Mri5IWpXX4Q4kLa8l4JGu/yZPzI6Co0FIQvNCc3TiqopHToUojBzFNIlJ9B7TJyoXm
         uxfJqLLKzICvfb4rnlbvZIoHSr8ga8eHGIofjqtpi+fTXQy5nj+VzzKaO8Lc5Rrn3VA1
         2Dnr/uKfUz++5VKdhNrByWYv0Qv1kpRkfuH+QaXVIXUhL9En2Lqh/J+OG0sWzxxD1rWs
         CubA9xYklP1OY3UNXH780tFmAse8rqi+/f4X2i/xCXcpxjmvavq9Rywj6n22fGr6UAK3
         HrvjCXrN5T1Dj+v6ZzkktA6JFO9h/rk3ZOOl2Gq2oU1WpX8+BXCyW46b4b7mMnrp+n3y
         iSFQ==
X-Gm-Message-State: APjAAAX/+pahc3vYOJs2Rx5j38/7OCkBI9+WjQcUshT0WtavDt/ZxtkN
        OByf5/7KkcCk0bOvUgLygydQ8w==
X-Google-Smtp-Source: APXvYqzAGcw3s+OGM61OWIJ1Q4lLcdmgx5c1rL6joB3KJRAYdsCxoVV2iKVaQxGfLokfqpD8OaOuCQ==
X-Received: by 2002:a7b:cb4a:: with SMTP id v10mr2547385wmj.106.1576057765329;
        Wed, 11 Dec 2019 01:49:25 -0800 (PST)
Received: from glaroque-ThinkPad-T480.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id g17sm1531836wmc.37.2019.12.11.01.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 01:49:24 -0800 (PST)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, khilman@baylibre.com
Subject: [PATCH v3] bluetooth: hci_bcm: enable IRQ capability from node
Date:   Wed, 11 Dec 2019 10:49:23 +0100
Message-Id: <20191211094923.20220-1-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Actually IRQ can be found from GPIO but all platforms don't support
gpiod_to_irq, it's the case on amlogic chip.
so to have possibility to use interrupt mode we need to add interrupts
field in node and support it in driver.

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 drivers/bluetooth/hci_bcm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index f8f5c593a05c..9f52d57c56de 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -1409,6 +1409,7 @@ static int bcm_serdev_probe(struct serdev_device *serdev)
 {
 	struct bcm_device *bcmdev;
 	const struct bcm_device_data *data;
+	struct platform_device *pdev;
 	int err;
 
 	bcmdev = devm_kzalloc(&serdev->dev, sizeof(*bcmdev), GFP_KERNEL);
@@ -1421,6 +1422,8 @@ static int bcm_serdev_probe(struct serdev_device *serdev)
 #endif
 	bcmdev->serdev_hu.serdev = serdev;
 	serdev_device_set_drvdata(serdev, bcmdev);
+	pdev = to_platform_device(bcmdev->dev);
+	bcmdev->irq = platform_get_irq(pdev, 0);
 
 	/* Initialize routing field to an unused value */
 	bcmdev->pcm_int_params[0] = 0xff;
-- 
2.17.1

