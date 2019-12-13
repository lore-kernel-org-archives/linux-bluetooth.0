Return-Path: <SRS0=edj+=2D=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722AFC43603
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Dec 2019 10:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4459C2073D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Dec 2019 10:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="esFnpRQ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfLMKzZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Dec 2019 05:55:25 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45282 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfLMKzZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Dec 2019 05:55:25 -0500
Received: by mail-wr1-f65.google.com with SMTP id j42so6110355wrj.12
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Dec 2019 02:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=p415J89+YNScswOm0Ig+Gz4iio3dTiRz0IYzmtQJ8Wg=;
        b=esFnpRQ81UxTGd7lVa9vrscL5Wo31bYIRK/esBzJwjTw0hN6Z2GUhicpEUuGmed16f
         vziddOcnCkRW/Zmii476mpzLbVqUyUh1qc2Gne+M2STHXuec0yJ//xxfyclNHGmhvA5X
         OKnVUG8jTyZsuDcUQU31HboP7r7T5822VdErFuZEYy9zurHBzU3YoW/hOnsBLmHGdmPc
         4jIszGaWBAElk1jA7fLhBesqzZhUGnxTBfl3bcHXZyjTOwWjvjiO+vL1UckskaAIPbhM
         1YJKAnKreCL7FgEhuFXi/RpAhhYtYY8sRiKonILuepHAdYoPhJttbSk30Ujhm4C4nxmU
         l9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=p415J89+YNScswOm0Ig+Gz4iio3dTiRz0IYzmtQJ8Wg=;
        b=cGKFDyzTw1SbnZYNSX4JmwR3nFQYeXu18wwM8/GXnwStYRw9iEG3xd73rb34/NGxm4
         7CvNRnhT0Pe9pyoux+Hu2B/4AcVYGGXa1SYJowoThn8OjZuaYGqudmnMuWxGm6ScJZ4D
         WLfprWmfxUMUPFb4E38ZbF2WOVKtz1pe43KmV0wyets/RaWUUeiL2NlS8HqaEgzrU5ht
         tcCst8aI3J1GTIs28oov8g2XpAeJ6ZFxzk5J1Iuh0JVTX57016C6HVGCF/ppEZeWgB9Z
         90HJGp+8ybOEfiO4nyzgEyarmULnfBKkTvnKRSSWcy0B/4LAszZNXaDVZX5PU+RyRkgp
         7CVQ==
X-Gm-Message-State: APjAAAXFjFHH+mUNo18msm1BSOUEg3TEOXH7+PvD1iPuVaeIoBcovk2f
        EV9S/kU/m9AhMSUvhGJx1qjjKFJ4ccE=
X-Google-Smtp-Source: APXvYqzOfpJA5Vuw50woqY71RTwVq2767+KlZHxm+PmsLzgH6mBL4XJMA/L4DXoADGKJ+fDyAQpIKg==
X-Received: by 2002:a5d:4d8d:: with SMTP id b13mr12675842wru.6.1576234523179;
        Fri, 13 Dec 2019 02:55:23 -0800 (PST)
Received: from localhost.localdomain ([2a01:cb1d:6e7:d500:82a9:347a:43f3:d2ca])
        by smtp.gmail.com with ESMTPSA id s82sm10401368wms.28.2019.12.13.02.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 02:55:22 -0800 (PST)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org
Cc:     nsaenzjulienne@suse.de, linux-kernel@vger.kernel.org,
        khilman@baylibre.com
Subject: [PATCH v4] bluetooth: hci_bcm: enable IRQ capability from node
Date:   Fri, 13 Dec 2019 11:55:21 +0100
Message-Id: <20191213105521.4290-1-glaroque@baylibre.com>
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
 drivers/bluetooth/hci_bcm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index f8f5c593a05c..aa194f8d703e 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/acpi.h>
 #include <linux/of.h>
+#include <linux/of_irq.h>
 #include <linux/property.h>
 #include <linux/platform_data/x86/apple.h>
 #include <linux/platform_device.h>
@@ -1421,6 +1422,7 @@ static int bcm_serdev_probe(struct serdev_device *serdev)
 #endif
 	bcmdev->serdev_hu.serdev = serdev;
 	serdev_device_set_drvdata(serdev, bcmdev);
+	bcmdev->irq = of_irq_get(bcmdev->dev->of_node, 0);
 
 	/* Initialize routing field to an unused value */
 	bcmdev->pcm_int_params[0] = 0xff;
-- 
2.17.1

