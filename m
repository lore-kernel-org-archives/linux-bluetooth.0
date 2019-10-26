Return-Path: <SRS0=Kz1L=YT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA0CCA9EBE
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Oct 2019 20:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42AC1214DA
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Oct 2019 20:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bonstra.fr.eu.org header.i=@bonstra.fr.eu.org header.b="a69nCh1v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfJZUsk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 26 Oct 2019 16:48:40 -0400
Received: from vault.bonstra.fr.eu.org ([51.158.68.104]:39544 "EHLO
        vault.bonstra.fr.eu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbfJZUsk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 26 Oct 2019 16:48:40 -0400
X-Greylist: delayed 410 seconds by postgrey-1.27 at vger.kernel.org; Sat, 26 Oct 2019 16:48:38 EDT
Received: from val.bonstra.fr.eu.org (unknown [192.168.128.2])
        by vault.bonstra.fr.eu.org (Postfix) with ESMTP id 05E74BFD2D;
        Sat, 26 Oct 2019 20:41:48 +0000 (UTC)
Received: from bonstra.fr.eu.org (vlad.gr1 [IPv6:fd7b:45cc:aa3d::3])
        by val.bonstra.fr.eu.org (Postfix) with ESMTPSA id B839060872;
        Sat, 26 Oct 2019 22:41:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bonstra.fr.eu.org;
        s=dkim1; t=1572122506; x=1573332106;
        bh=FyQmJggoRLmgdI/q2dRsgf7Gx/W0s5so0ktocvI2jZg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=a69nCh1vudgKtmmY0lGVIH6/NKWuMS9Sizht2iFRbUvG0xc7nV5Ed+cyYd0En8gDA
         bJIahxWflCenEMQ67NaswXcR/JZxwaXE5aukNkMIhr2xoWAWWSo+fechRN4uwBZuaQ
         1GhMVcohCvnLJQ92/aK3cWPIpxdrJlD9jJcJijoSsXiJpVKI4eLfj1iWrR+zFQQpVz
         bmocZm0T5vJwQ0+28Cc35lAm3yee2xuKviI8yl45HeHznkN+JYZ+9hSuQe2N7QGpsf
         AFzzOwvao7797RhRyttKeMF1ORLPtUOlayUhxESceILv/xkJnuyeV9RImindMZnq8X
         aludlEdbdwAzA==
From:   Hugo Grostabussiat <bonstra@bonstra.fr.eu.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     Hugo Grostabussiat <bonstra@bonstra.fr.eu.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: hci_h5: Add DT support for rtl8723bs
Date:   Sat, 26 Oct 2019 22:41:15 +0200
Message-Id: <20191026204116.95119-3-bonstra@bonstra.fr.eu.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191026204116.95119-1-bonstra@bonstra.fr.eu.org>
References: <20191026204116.95119-1-bonstra@bonstra.fr.eu.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The hci_h5 already supports rtl8723bs devices discovered via ACPI. This
commit adds support for discovering via device tree for ACPI-less
platforms.

Signed-off-by: Hugo Grostabussiat <bonstra@bonstra.fr.eu.org>
---
 drivers/bluetooth/hci_h5.c | 40 +++++++++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index dacf297baf59..49ac03b1a7e3 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -11,6 +11,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/kernel.h>
 #include <linux/mod_devicetable.h>
+#include <linux/of_device.h>
 #include <linux/serdev.h>
 #include <linux/skbuff.h>
 
@@ -782,7 +783,9 @@ static const struct hci_uart_proto h5p = {
 
 static int h5_serdev_probe(struct serdev_device *serdev)
 {
-	const struct acpi_device_id *match;
+	const struct acpi_device_id *acpi_match;
+	const struct of_device_id *of_match;
+	const char *cfgname = NULL;
 	struct device *dev = &serdev->dev;
 	struct h5 *h5;
 
@@ -797,16 +800,27 @@ static int h5_serdev_probe(struct serdev_device *serdev)
 	serdev_device_set_drvdata(serdev, h5);
 
 	if (has_acpi_companion(dev)) {
-		match = acpi_match_device(dev->driver->acpi_match_table, dev);
-		if (!match)
+		acpi_match = acpi_match_device(
+				dev->driver->acpi_match_table, dev);
+		if (!acpi_match)
 			return -ENODEV;
 
-		h5->vnd = (const struct h5_vnd *)match->driver_data;
-		h5->id  = (char *)match->id;
+		h5->vnd = (const struct h5_vnd *)acpi_match->driver_data;
+		h5->id  = (char *)acpi_match->id;
 
 		if (h5->vnd->acpi_gpio_map)
 			devm_acpi_dev_add_driver_gpios(dev,
 						       h5->vnd->acpi_gpio_map);
+	} else if (dev->of_node) {
+		of_match = of_match_device(dev->driver->of_match_table, dev);
+		if (!of_match)
+			return -ENODEV;
+
+		of_property_read_string(dev->of_node,
+					"realtek,config-name", &cfgname);
+
+		h5->vnd = (const struct h5_vnd *)of_match->data;
+		h5->id = cfgname;
 	}
 
 	h5->enable_gpio = devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_LOW);
@@ -996,6 +1010,19 @@ static const struct acpi_device_id h5_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, h5_acpi_match);
 #endif
 
+#ifdef CONFIG_OF
+static const struct of_device_id h5_of_match[] = {
+#ifdef CONFIG_BT_HCIUART_RTL
+	{
+		.compatible = "realtek,rtl8723bs-bt",
+		.data = &rtl_vnd
+	},
+#endif
+	{ },
+};
+MODULE_DEVICE_TABLE(of, h5_of_match);
+#endif
+
 static const struct dev_pm_ops h5_serdev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(h5_serdev_suspend, h5_serdev_resume)
 };
@@ -1006,6 +1033,9 @@ static struct serdev_device_driver h5_serdev_driver = {
 	.driver = {
 		.name = "hci_uart_h5",
 		.acpi_match_table = ACPI_PTR(h5_acpi_match),
+#ifdef CONFIG_OF
+		.of_match_table = h5_of_match,
+#endif
 		.pm = &h5_serdev_pm_ops,
 	},
 };
-- 
2.23.0

