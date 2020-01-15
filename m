Return-Path: <SRS0=uqsz=3E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEAB8C33CB1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 10:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD2B82467C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 10:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="hyEuRy4N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729632AbgAOKMw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Jan 2020 05:12:52 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36811 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729539AbgAOKMt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Jan 2020 05:12:49 -0500
Received: by mail-wm1-f67.google.com with SMTP id p17so17161356wma.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jan 2020 02:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tXpo5MYGeWvRjvLGBcgNx4X2h+6aZ6zfLICyaTGuIUI=;
        b=hyEuRy4NBBXv9i1cTbMO4RPHvgNr++QeW3094lGhowrdyRoliaxSjDbZWQctWMoL1G
         intGa8iv3u+cL72afwfD5VjnxaJZ4nxD8PgZsziSitVrI4arOlLO1wUNkUgvI5FugwZp
         U/bGsGWeQWKacGmC2TChw7bSuhecxcEzZMeF7ZCcaBGEdwAFHYz5GXRHoaAQ1SFB6fCW
         sBwzubZ+j4UWbeZEspJVuBLTqTupJerWahoGswge7QsgOUNjyFKKC2w7Nj11gNNOQmmX
         pItcaVx9bvEA2B6Sr2mD98cFulwS/lO+lvXUR3SC2xtiIhY6PnJalBZ/GSpAezrOHixF
         Gr4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tXpo5MYGeWvRjvLGBcgNx4X2h+6aZ6zfLICyaTGuIUI=;
        b=Lke4FzYPsK0/5JfrKgF+5uGHor24vubFih4x1WwWn4q+ZF95beBG4sPUTlfOuV/Pe+
         q5xUA2ssuFI2ovbRKjO/TSjHbZhSAaK/9n4XVhOVSkv/dEyh276qoHHJIDwjVfCgmt9t
         V0Dy0+d85BFgTgxJkX1wx1V/vFOEOM3tTtOPxzifziEKPd7A6iUmFtuFeDIbSdhVKxfM
         +/37l5Q34kAQnCv73z3RE81VH1zePJlW0xMyD2i5fBfh2qw0g488icb3uinaMMbAjO5S
         M/TsbrZ1j/hZhhMoPiRUhYuvrDspfne7xdKyBj6xFLoMVIjQiUAarq0c4JaBTJW2OMfr
         dlgA==
X-Gm-Message-State: APjAAAUNPu/EpA7oOlwpmc9L1pLwWYJdwdAQwT54RzC/UvOPYrDJ4C5N
        nLhfhUDEbhIegy8dExEq8dAwJg==
X-Google-Smtp-Source: APXvYqyeGSZDmYaqLCKbki2jn7P4jJyKO+UR19mLn+8i1Bj1Dxqrts7BUcZe4EUGD9P9TykOOeh0mQ==
X-Received: by 2002:a7b:cc98:: with SMTP id p24mr31873993wma.139.1579083167531;
        Wed, 15 Jan 2020 02:12:47 -0800 (PST)
Received: from glaroque-ThinkPad-T480.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id g7sm23828223wrq.21.2020.01.15.02.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 02:12:47 -0800 (PST)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org
Cc:     johan@kernel.org, nsaenzjulienne@suse.de,
        linux-kernel@vger.kernel.org, khilman@baylibre.com
Subject: [PATCH v7 2/2] bluetooth: hci_bcm: enable IRQ capability from devicetree
Date:   Wed, 15 Jan 2020 11:12:43 +0100
Message-Id: <20200115101243.17094-3-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200115101243.17094-1-glaroque@baylibre.com>
References: <20200115101243.17094-1-glaroque@baylibre.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add support for getting IRQ directly from DT instead of relying on
converting a GPIO to IRQ. This is needed for platforms with GPIO
controllers that that do not support gpiod_to_irq().

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 drivers/bluetooth/hci_bcm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 769bb4404bd1..b236cb11c0dc 100644
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
@@ -1151,6 +1152,8 @@ static int bcm_of_probe(struct bcm_device *bdev)
 	device_property_read_u32(bdev->dev, "max-speed", &bdev->oper_speed);
 	device_property_read_u8_array(bdev->dev, "brcm,bt-pcm-int-params",
 				      bdev->pcm_int_params, 5);
+	bdev->irq = of_irq_get_byname(bdev->dev->of_node, "host-wakeup");
+
 	return 0;
 }
 
-- 
2.17.1

