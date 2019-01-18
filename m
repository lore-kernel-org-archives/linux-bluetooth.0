Return-Path: <SRS0=s7/i=P2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21959C43612
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jan 2019 17:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1CFD20883
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jan 2019 17:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pywTVcO+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbfARRCs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Jan 2019 12:02:48 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34732 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726601AbfARRCr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Jan 2019 12:02:47 -0500
Received: by mail-pl1-f195.google.com with SMTP id w4so6620166plz.1;
        Fri, 18 Jan 2019 09:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=jFEUu0iFvQYztS9g4BUdYLNIZwJ1NonHLyGxopxGJbE=;
        b=pywTVcO+DpWWCNXOmqzrHFpvyS521dw4vRXXY+31xsUMVGpIEiHHodTkbjeGeAkH0G
         ijzes2TXZ3uLqONaDqtQ5NJDGqfMmRtiOsAPToCvWtjn4XWMMm4gQID00FhBd3zgCAup
         dBXoawZQUh0QXLLLQ4yn2f92WW5WCswHPHT57RE56vkU4vCAaHfVS+8x5c/poaiaNANF
         7CBhFFyUyrgL7uHK6Gb80GCVPLdMAj641DlRCfd7i3t5mZ8rLXlWt3nnd/M8n2dNdpIP
         g60WsdqC10hB4b2Eog/1WMf6/GMRYeJz6yEX5dt+jqIavBDelbv+9wvf7e+Mwky9ShKo
         kUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jFEUu0iFvQYztS9g4BUdYLNIZwJ1NonHLyGxopxGJbE=;
        b=KSCW4CiGiNlvIYMuEN4xVWjgob0MXSwY8RoveVQt1stVP/D6p2EUoAuPGVvnZb4wS/
         RhKqQH3cs0OkAVM0EAMh56BSsKgCAw4loeO1FIHcnwVggMmibri5fudIxsGNTN7IPW08
         QlmJEVQG4KtautW7CBfZsM8fooXVIt2Rw4OoBReZTg/vzhKGkVJTMJP4uNQFRBEqb4jv
         7wCBIP9e8adefrDZpQubPNqQqxA/BjtPaIm4U4tgXnT/fXlU+vPK9lb9DhnDCiq/WSUN
         bfps4OaEjJaKqBopNyOXlX1zDfTLnqBgdtFiFJJ8+znlDw7v9tp7+HvSYQw4HiXrwC5H
         53Sg==
X-Gm-Message-State: AJcUukeU5HBrpdynkAWI8zf9Bv/pv4JVnloxR62pSa71I3oT6idFQ1l9
        yb0U8LnoHelF1TzCxZuQm3f/3a7JUI0=
X-Google-Smtp-Source: ALg8bN4RkK6wHVXxv15RcaeOc3A+ypBDn75Lj3dSW/DHGg4PYPYfnEC+ZoHcA89/Fdvj6Pa8xVbxfA==
X-Received: by 2002:a17:902:145:: with SMTP id 63mr19834028plb.256.1547830966075;
        Fri, 18 Jan 2019 09:02:46 -0800 (PST)
Received: from anarsoul-thinkpad.lan (216-71-193-140.dyn.novuscom.net. [216.71.193.140])
        by smtp.gmail.com with ESMTPSA id b4sm5672222pgq.65.2019.01.18.09.02.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 09:02:45 -0800 (PST)
From:   Vasily Khoruzhick <anarsoul@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/8] Bluetooth: hci_h5: Add support for reset GPIO
Date:   Fri, 18 Jan 2019 09:02:26 -0800
Message-Id: <20190118170232.16142-3-anarsoul@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190118170232.16142-1-anarsoul@gmail.com>
References: <20190118170232.16142-1-anarsoul@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Some boards (e.g. Pine64 and Pinebook) wire a GPIO to reset pin of
RTL8723BS

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 drivers/bluetooth/hci_h5.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index 069d1c8fde73..7ead8c3d8657 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -107,6 +107,7 @@ struct h5 {
 	const struct h5_vnd *vnd;
 	const char *id;
 
+	struct gpio_desc *reset_gpio;
 	struct gpio_desc *enable_gpio;
 	struct gpio_desc *device_wake_gpio;
 };
@@ -833,6 +834,10 @@ static int h5_serdev_probe(struct serdev_device *serdev)
 	if (IS_ERR(h5->device_wake_gpio))
 		return PTR_ERR(h5->device_wake_gpio);
 
+	h5->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(h5->reset_gpio))
+		return PTR_ERR(h5->reset_gpio);
+
 	return hci_uart_register_device(&h5->serdev_hu, &h5p);
 }
 
@@ -921,6 +926,9 @@ static void h5_btrtl_open(struct h5 *h5)
 
 	/* The controller needs up to 500ms to wakeup */
 	gpiod_set_value_cansleep(h5->enable_gpio, 1);
+	/* Take it out of reset */
+	gpiod_set_value_cansleep(h5->reset_gpio, 0);
+	msleep(100);
 	gpiod_set_value_cansleep(h5->device_wake_gpio, 1);
 	msleep(500);
 }
@@ -928,6 +936,7 @@ static void h5_btrtl_open(struct h5 *h5)
 static void h5_btrtl_close(struct h5 *h5)
 {
 	gpiod_set_value_cansleep(h5->device_wake_gpio, 0);
+	gpiod_set_value_cansleep(h5->reset_gpio, 1);
 	gpiod_set_value_cansleep(h5->enable_gpio, 0);
 }
 
-- 
2.20.1

