Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0C2C433DB
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Mar 2021 13:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F4AB64FDF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Mar 2021 13:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbhCENY2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Mar 2021 08:24:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbhCENXz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Mar 2021 08:23:55 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A56AC061574
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Mar 2021 05:23:55 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id u4so2712521ljh.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Mar 2021 05:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3vCJ3Xj+RPjkG+Npaaa9CXbJBl9rcKiVLGtrcCJP0y8=;
        b=u1fnfNZ6noTJgFwnSHh18/uYtGYQAT7bm3WhDp4Eqdm1IiUNuKHrFk/j9Fn8NFT3QF
         +u5FRhwAyfE9pzsgHAUo4zjG44b/5XQ70TTJKTObAVnSAnB/Y0Iu2S/C6YbHhiSqUKM8
         E6S4MYCgeKIfhbmirpRh+YH6ZHDSrrgaspxdV9D6Bo5p6sZUhvpqNEjWj/SbMKmMxqgz
         0AuF3FfPZ5YKo8swO8VjicH4WW+RApRhXCc8m/v9fg/ZLKbQmr5R/rIDi+uA7TOoII4C
         tCfryje/0RhiXu3ObQFan2aiOsDUuq4tys693t+g8ZTiEttHcFIkT5LwDwF9B+q/ERGN
         AB5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3vCJ3Xj+RPjkG+Npaaa9CXbJBl9rcKiVLGtrcCJP0y8=;
        b=MKYUTtKNyieajZRY9PMjhNb/AaF1vOonAAuhIIZCXtLpqBl+p6v5rgheyJxdPnEriX
         n/EgFV+g1vn6k3xnsgU3P7cYhFkwR46eYXt40eY70ZYN5LWAOBs7akJwMhrxOHb4tErd
         YpAlt6JrXVOOQN1SvjdhkFJQe7frVxQ2e4uGcbZuKVlHEdVyBtl5YFtf6pTTpSVs8nVN
         MzYr9Of6mLxiRJlWBElDZglsIqeUFdZeQmpaf6TfDMPpmrdGPGCyqUr5d4yTtaV87REH
         jgbCrwdHxzRO/mMzgE4IQxmwYnQ/hMUpEwA0AF+sNT0bwRIiu+u8z4D4oxjWOI3jToxH
         YBow==
X-Gm-Message-State: AOAM53346eqP/aMTg1Cw87UPLHW2ZN0d39u8Jop8Hc9/CdxgG1tGwOjl
        eXM9Z3YkTcFSx+IUt2/h3G5seg==
X-Google-Smtp-Source: ABdhPJxfd/m1mRgrZUMbE++FCLc0W4a1oEddRr5wTCImBFJOsjGSDTLoNIS0/HvzIRarSsbk8kuf5A==
X-Received: by 2002:a2e:9195:: with SMTP id f21mr5136619ljg.340.1614950633916;
        Fri, 05 Mar 2021 05:23:53 -0800 (PST)
Received: from localhost.localdomain (c-d7cb225c.014-348-6c756e10.bbcust.telenor.se. [92.34.203.215])
        by smtp.gmail.com with ESMTPSA id v28sm298420ljv.66.2021.03.05.05.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 05:23:53 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/2 v2] Bluetooth: btbcm: Obtain and handle reset GPIO
Date:   Fri,  5 Mar 2021 14:23:43 +0100
Message-Id: <20210305132343.2070583-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210305132343.2070583-1-linus.walleij@linaro.org>
References: <20210305132343.2070583-1-linus.walleij@linaro.org>
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
ChangeLog v1->v2:
- Rebase on v5.12-rc1
---
 drivers/bluetooth/hci_bcm.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 3764ceb6fa0d..93a4c03a8787 100644
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
@@ -985,6 +988,15 @@ static int bcm_gpio_set_device_wakeup(struct bcm_device *dev, bool awake)
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
 
@@ -1050,6 +1062,11 @@ static int bcm_get_resources(struct bcm_device *dev)
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
2.29.2

