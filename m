Return-Path: <SRS0=2LFz=ID=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22698C433E9
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Mar 2021 18:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6609650A7
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Mar 2021 18:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbhCESju (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Mar 2021 13:39:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbhCESho (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Mar 2021 13:37:44 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DE0C061756
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Mar 2021 10:37:44 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id m22so5259332lfg.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Mar 2021 10:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+2ElZv11zdoL2qiA64ASUABXEbwM8MABPwhCs71wdjc=;
        b=azUAvx7CMf2XeiZiwrZ/U18kSPh9kV6DLCMfb20nYpgYOHPHR1N3QB2s8CPHIghUUd
         HTVTWhvXPoHFrhFXr9WiFCCikRBVQP2K0L3y/58qrMSkRHmc80Wf1YAt+w3EGGMuDm/Z
         qUnm0OOCi7X8QZ0qsYAz5LyIp4qv/AQulb31o7huSDjDD7o1A82+si21Xo6jCa1vsErT
         CT11dQn5sBCrZGSDWJvAEukcRhfCZsmS2GnvZcykGKQ3cEVQ7r4qhbKumQHZE2k6Pgza
         FTtuQtw05X9tAk7tk37FIXWAJgFevnWWvbmncQ4X0bpu+SOrUPVnBLIPn3jsWqWPn4Jn
         hNMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+2ElZv11zdoL2qiA64ASUABXEbwM8MABPwhCs71wdjc=;
        b=quFotabhn8fV10F9/lFyda7USt79h5MI5GZJPUi2IYmoNHbqSQkYMrT/CNGitvXLCf
         sd04zF8z4UoVN0loYhemWuLhVV2DNop2MpJdMLR4/ZmYNzF4aYVkZ8mUCIAz38ddP/S7
         m95mKw29VOtgz6q7uRalyUo+tvH2wDfqrKDjK+hw5/pR9CEV4+BjiMeI1gFnm4LCuYd6
         Xpdek1d4ghkKYxLg9hD0bSpfiPDJloFE0MqzqwaGgISqbCBxPhcN3npbJ2vNTqnRMLS2
         remTSIPuOVFG+80NpHy0Zyl9d1VB53e73a8u4U+aSnpaKalaQ/Szll3LFPwwObU7TXn9
         eivA==
X-Gm-Message-State: AOAM532EIHO8c/IAH8ILlhuROxSKQUynUgiFGR1mcnc9OTwQctt18wxE
        me33qRyXxoOMY7HNNY8jZ2yp5g==
X-Google-Smtp-Source: ABdhPJwkJR+Tw3+OcDFN7aXBO/+jTdz5kiRzWyP/2Z3BlqAPk1pPgbeDG/Wky1/4zFJF9Mnjp6ccSw==
X-Received: by 2002:a05:6512:1086:: with SMTP id j6mr6301673lfg.96.1614969463027;
        Fri, 05 Mar 2021 10:37:43 -0800 (PST)
Received: from localhost.localdomain (c-d7cb225c.014-348-6c756e10.bbcust.telenor.se. [92.34.203.215])
        by smtp.gmail.com with ESMTPSA id o16sm400374lfo.166.2021.03.05.10.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 10:37:42 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/2 v3] Bluetooth: btbcm: Obtain and handle reset GPIO
Date:   Fri,  5 Mar 2021 19:37:36 +0100
Message-Id: <20210305183736.2123083-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210305183736.2123083-1-linus.walleij@linaro.org>
References: <20210305183736.2123083-1-linus.walleij@linaro.org>
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
ChangeLog v2->v3:
- Resend with the other patch.
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

