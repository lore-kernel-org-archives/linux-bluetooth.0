Return-Path: <SRS0=oxy1=EJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0879C55178
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Nov 2020 12:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81A6A22264
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Nov 2020 12:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="syFMOrEJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728948AbgKCMJv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Nov 2020 07:09:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728644AbgKCMJu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Nov 2020 07:09:50 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE68C0613D1
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2020 04:09:49 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id o13so10461339ljj.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Nov 2020 04:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pXw+4mvpHTL0090esXvbC0/ocXQHd2mKNDoOfKKak1Y=;
        b=syFMOrEJOfYJj9/XmAs2cGnnCf6XnD3oP5+Jo8vfxhcbw58xPE7GAm/8BMNf1xVQ2h
         GWS8EnzFAT2H9F/BLkhfbmAtDZy+eovdrKCNTDxt18I4LPvq/kgELa5SxAmlK02Y6pR5
         9H/CeGWslniyaWpUIlx61DW0IXXmOJtNFzOJLogl//KWMzHxBnAbCuyIrrEKhHaZr0bd
         AKfU2afnpJlYBrhH5gVTIHXysqwTjs5wH6uZF6ksJf1icyQ/6r4zbwSHtUR6bEd26r+m
         N1Z5AvrmqO0RA60F3wQS0vnynguDKXhYhHJt8EQl0goPK9Y9AoK5CQjrsPy52thXnlYq
         yemQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pXw+4mvpHTL0090esXvbC0/ocXQHd2mKNDoOfKKak1Y=;
        b=Sl4OErtOgkJupOLIIAL2mY8KAFJL6yhAguZEXOwBGkZx5pmAYpgu4oY0B1COhP2R5G
         3grdMFP0KNtAHPgChlcCEUtpfE24uHHzWQweR14x4ieS6wmyPTgual0IOd6Is/x1EBzQ
         dBR/+DNJvnnIwFonnHytrMvhGoClbf2qhhV8G1nwgv9xDKwRC6dVWgRGodx4CCLZldiP
         GaO4uoUohxVjzpMt9gCKwB1R0y2d83y15qGjbYia0ypqnP+6jiARgkuh+j8I4josh7+I
         7sCECz8evsOKIGA8AzUb+HsAhQzaNgi07JvOFb4JrRGGTTCtH4DshgJUJ23SvwHxwZdf
         PmRQ==
X-Gm-Message-State: AOAM533CHg1yq7SABbNJ/5fpCqpCHynCJDMO8lwT5xjKsR5L7q1MvUvK
        iKB+kf1vydwQ1CEI6orZgUmm+A==
X-Google-Smtp-Source: ABdhPJxspSp336WE5nuo7NoBOx6vaawWCnIvGBTr6HlM0sAQVq8Kv89lK5bY+l5LAYZQP0MyT101gA==
X-Received: by 2002:a05:651c:1a6:: with SMTP id c6mr6768863ljn.244.1604405388189;
        Tue, 03 Nov 2020 04:09:48 -0800 (PST)
Received: from localhost.bredbandsbolaget (c-92d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.146])
        by smtp.gmail.com with ESMTPSA id p18sm4155723ljn.127.2020.11.03.04.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 04:09:47 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/2] Bluetooth: btbcm: Obtain and handle reset GPIO
Date:   Tue,  3 Nov 2020 13:09:43 +0100
Message-Id: <20201103120943.1289277-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201103120943.1289277-1-linus.walleij@linaro.org>
References: <20201103120943.1289277-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Obtain and drive the optional reset GPIO line if this is
not hardwired in the platform. This is needed on the
Samsung GT-I9070 mobile phone.

The invers of power is used, this should be OK to apply
simultaneously as the power signal according to
figures 47-51 on pages 159-161 in the BCM4330 datasheet.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/bluetooth/hci_bcm.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 8ea5ca8d71d6..15a28b90c2d0 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -68,6 +68,8 @@ struct bcm_device_data {
  *	deassert = Bluetooth device may sleep when sleep criteria are met
  * @shutdown: BT_REG_ON pin,
  *	power up or power down Bluetooth device internal regulators
+ * @reset: BT_RST_N pin,
+ *	active low resets the Bluetooth logic core
  * @set_device_wakeup: callback to toggle BT_WAKE pin
  *	either by accessing @device_wakeup or by calling @btlp
  * @set_shutdown: callback to toggle BT_REG_ON pin
@@ -101,6 +103,7 @@ struct bcm_device {
 	const char		*name;
 	struct gpio_desc	*device_wakeup;
 	struct gpio_desc	*shutdown;
+	struct gpio_desc	*reset;
 	int			(*set_device_wakeup)(struct bcm_device *, bool);
 	int			(*set_shutdown)(struct bcm_device *, bool);
 #ifdef CONFIG_ACPI
@@ -984,6 +987,15 @@ static int bcm_gpio_set_device_wakeup(struct bcm_device *dev, bool awake)
 static int bcm_gpio_set_shutdown(struct bcm_device *dev, bool powered)
 {
 	gpiod_set_value_cansleep(dev->shutdown, powered);
+	if (dev->reset)
+		/*
+		 * The reset line is asserted on powerdown and deasserted
+		 * on poweron so the inverse of powered is used. Notice
+		 * that the GPIO line BT_RST_N needs to be specified as
+		 * active low in the device tree or similar system
+		 * description.
+		 */
+		gpiod_set_value_cansleep(dev->reset, !powered);
 	return 0;
 }
 
@@ -1049,6 +1061,11 @@ static int bcm_get_resources(struct bcm_device *dev)
 	if (IS_ERR(dev->shutdown))
 		return PTR_ERR(dev->shutdown);
 
+	dev->reset = devm_gpiod_get_optional(dev->dev, "reset",
+					     GPIOD_OUT_LOW);
+	if (IS_ERR(dev->reset))
+		return PTR_ERR(dev->reset);
+
 	dev->set_device_wakeup = bcm_gpio_set_device_wakeup;
 	dev->set_shutdown = bcm_gpio_set_shutdown;
 
-- 
2.26.2

