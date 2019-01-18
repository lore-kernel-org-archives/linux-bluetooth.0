Return-Path: <SRS0=s7/i=P2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A12C43612
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jan 2019 17:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6752F2086D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jan 2019 17:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8VQohhR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbfARRCx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Jan 2019 12:02:53 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44918 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728305AbfARRCt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Jan 2019 12:02:49 -0500
Received: by mail-pg1-f193.google.com with SMTP id t13so6318151pgr.11;
        Fri, 18 Jan 2019 09:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=4xR1KYQugEMkmMq57G98vJgznMGv5+b9o//ihdpDFFk=;
        b=W8VQohhRHylK8qIeIMPsCgeUBkdi246JIFWArzeRK06r73GzduMz7oIZ78WICDUblz
         e45HrHe+vYK3sW75OWoVPmedz3/n6+Vpn8v4nZqU/sFVuI9JL55JT8KKHjzFcrV7blzz
         YmbjdI80sMz7GdsWqSWFtE+FtZvRuFkoXVJQuWqsdq21KX7zRMEi0Jlkdfi5KSbiAdZ5
         nhSrAzga7K/HUkudnngpKnnNIBDANg9hpGGlO/r1GVzvFyG22T0RcaEjjwgr3xLrU9U0
         J8YwgwoqIc8UnCSrfo86OKT6jg1XujU6BZrDQxu3AbIVQ4yw2KHUcRqOokW3vlXJfwnJ
         LJxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4xR1KYQugEMkmMq57G98vJgznMGv5+b9o//ihdpDFFk=;
        b=CsUef19+jotDCYBSYZLH5SAOYw1ICYTwy5Hnq+IYyfjxSeDxCmDXOoCQ2D3ahLx+ze
         5updL6g2XtArW6WSI+GC7TgGGnQw+PB8gtH7R076vM+7qVFQnkDWik+cAEb6U71xZvPZ
         qgVGGrR+R2J0yLcHJwBAq9/YNoU4mQ2z9DE1FqdBPCDztx+tbC9E4uurtaX06+ZD3z+Q
         febM4X6SDvZNomlPKk0fxS+0yugmtHNzY/904RvwahAWBbYVjoeXCDI9f1B2K7j5v/xP
         EAsQyu+/3pbTL/fXUpVknj586xyJiZCiUm9NanRL3hTe5RSRE3klGe8PfV9srYyfJYE4
         dQlg==
X-Gm-Message-State: AJcUukfx8S2UIZAKdKoIhMeboQRhuwoxYmve9QoLzlE0kUNr4zA9TN+x
        5BtfrLNvZga0NmFcUyvxoDs=
X-Google-Smtp-Source: ALg8bN7eKG9Zfd/C08iT/TSsDGBMH2LRelSemvSqKMOphpjky6CTf4WpERgIJdacBkOyODA2ZJbrBQ==
X-Received: by 2002:a62:3888:: with SMTP id f130mr19784070pfa.132.1547830968387;
        Fri, 18 Jan 2019 09:02:48 -0800 (PST)
Received: from anarsoul-thinkpad.lan (216-71-193-140.dyn.novuscom.net. [216.71.193.140])
        by smtp.gmail.com with ESMTPSA id b4sm5672222pgq.65.2019.01.18.09.02.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 09:02:47 -0800 (PST)
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
Subject: [PATCH 4/8] Bluetooth: hci_h5: Add support for binding RTL8723BS with device tree
Date:   Fri, 18 Jan 2019 09:02:28 -0800
Message-Id: <20190118170232.16142-5-anarsoul@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190118170232.16142-1-anarsoul@gmail.com>
References: <20190118170232.16142-1-anarsoul@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

RTL8723BS is often used in ARM boards, so add ability to bind it
using device tree.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 drivers/bluetooth/hci_h5.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index 7ead8c3d8657..44f848c02c63 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -26,6 +26,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/kernel.h>
 #include <linux/mod_devicetable.h>
+#include <linux/of_device.h>
 #include <linux/serdev.h>
 #include <linux/skbuff.h>
 
@@ -823,6 +824,11 @@ static int h5_serdev_probe(struct serdev_device *serdev)
 		if (h5->vnd->acpi_gpio_map)
 			devm_acpi_dev_add_driver_gpios(dev,
 						       h5->vnd->acpi_gpio_map);
+	} else {
+		h5->vnd = (const struct h5_vnd *)
+				of_device_get_match_data(&serdev->dev);
+		of_property_read_string(serdev->dev.of_node,
+					"firmware-postfix", &h5->id);
 	}
 
 	h5->enable_gpio = devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_LOW);
@@ -1024,12 +1030,26 @@ static const struct dev_pm_ops h5_serdev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(h5_serdev_suspend, h5_serdev_resume)
 };
 
+static struct h5_vnd rtl8723_of_vnd = {
+	.setup		= h5_btrtl_setup,
+	.open		= h5_btrtl_open,
+	.close		= h5_btrtl_close,
+};
+
+static const struct of_device_id h5_of_match[] = {
+	{ .compatible = "realtek,rtl8723bs-bt", .data = &rtl8723_of_vnd },
+	{ .compatible = "realtek,rtl8723cs-bt", .data = &rtl8723_of_vnd },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, h5_of_match);
+
 static struct serdev_device_driver h5_serdev_driver = {
 	.probe = h5_serdev_probe,
 	.remove = h5_serdev_remove,
 	.driver = {
 		.name = "hci_uart_h5",
 		.acpi_match_table = ACPI_PTR(h5_acpi_match),
+		.of_match_table = of_match_ptr(h5_of_match),
 		.pm = &h5_serdev_pm_ops,
 	},
 };
-- 
2.20.1

