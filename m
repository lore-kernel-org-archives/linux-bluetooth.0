Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E40DAC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Feb 2022 11:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234352AbiB1Ljf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Feb 2022 06:39:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233563AbiB1Ljc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Feb 2022 06:39:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5A2D51AD9A
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Feb 2022 03:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646048333;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7H8CeIdDiRylBzBEy/YCcLXb7VJ80rA5l7+uhfxGm2k=;
        b=asbFmeFA7Qis6/VGOHtusT6OCcshiwn5Jfu06YrOnTsPNDWpPx6KVg81ss6/7TTTAh1ENN
        b1QkNzl8Saseq7FKsgDLpcYqMdl9CNSSDmmoDiNVlRvxJGUtpjM/baBZ+AOU6EYHPkjTz/
        vBWte0lwBnF6Z02I34tqUGBW8ZXFXFc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-91-ZA_4lcbgNFyUZDZ6mpsqbQ-1; Mon, 28 Feb 2022 06:38:50 -0500
X-MC-Unique: ZA_4lcbgNFyUZDZ6mpsqbQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 123DE824FA8;
        Mon, 28 Feb 2022 11:38:49 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.193.120])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7FB9D8306D;
        Mon, 28 Feb 2022 11:38:47 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH resend 1/1] Bluetooth: hci_bcm: Add the Asus TF103C to the bcm_broken_irq_dmi_table
Date:   Mon, 28 Feb 2022 12:38:41 +0100
Message-Id: <20220228113841.476174-2-hdegoede@redhat.com>
In-Reply-To: <20220228113841.476174-1-hdegoede@redhat.com>
References: <20220228113841.476174-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The DSDT for the Asus TF103C specifies a IOAPIC IRQ for the HCI -> host IRQ
but this is not correct. Unlike the previous entries in the table, this
time the correct GPIO to use instead is known; and the TF103C is battery
powered making runtime-pm support more important.

Extend the bcm_broken_irq_dmi_table mechanism to allow specifying the right
GPIO instead of just always disabling runtime-pm and add an entry to it for
the Asus TF103C.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/bluetooth/hci_bcm.c | 44 ++++++++++++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 8 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index d634a27bc850..d3747e049cb7 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -20,6 +20,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/clk.h>
 #include <linux/gpio/consumer.h>
+#include <linux/gpio/machine.h>
 #include <linux/tty.h>
 #include <linux/interrupt.h>
 #include <linux/dmi.h>
@@ -870,7 +871,23 @@ static int bcm_resume(struct device *dev)
 #endif
 
 /* Some firmware reports an IRQ which does not work (wrong pin in fw table?) */
+static struct gpiod_lookup_table asus_tf103c_irq_gpios = {
+	.dev_id = "serial0-0",
+	.table = {
+		GPIO_LOOKUP("INT33FC:02", 17, "host-wakeup-alt", GPIO_ACTIVE_HIGH),
+		{ }
+	},
+};
+
 static const struct dmi_system_id bcm_broken_irq_dmi_table[] = {
+	{
+		.ident = "Asus TF103C",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "TF103C"),
+		},
+		.driver_data = &asus_tf103c_irq_gpios,
+	},
 	{
 		.ident = "Meegopad T08",
 		.matches = {
@@ -1027,7 +1044,8 @@ static struct clk *bcm_get_txco(struct device *dev)
 
 static int bcm_get_resources(struct bcm_device *dev)
 {
-	const struct dmi_system_id *dmi_id;
+	const struct dmi_system_id *broken_irq_dmi_id;
+	const char *irq_con_id = "host-wakeup";
 	int err;
 
 	dev->name = dev_name(dev->dev);
@@ -1083,23 +1101,33 @@ static int bcm_get_resources(struct bcm_device *dev)
 	if (err)
 		return err;
 
+	broken_irq_dmi_id = dmi_first_match(bcm_broken_irq_dmi_table);
+	if (broken_irq_dmi_id && broken_irq_dmi_id->driver_data) {
+		gpiod_add_lookup_table(broken_irq_dmi_id->driver_data);
+		irq_con_id = "host-wakeup-alt";
+		dev->irq_active_low = false;
+		dev->irq = 0;
+	}
+
 	/* IRQ can be declared in ACPI table as Interrupt or GpioInt */
 	if (dev->irq <= 0) {
 		struct gpio_desc *gpio;
 
-		gpio = devm_gpiod_get_optional(dev->dev, "host-wakeup",
-					       GPIOD_IN);
+		gpio = devm_gpiod_get_optional(dev->dev, irq_con_id, GPIOD_IN);
 		if (IS_ERR(gpio))
 			return PTR_ERR(gpio);
 
 		dev->irq = gpiod_to_irq(gpio);
 	}
 
-	dmi_id = dmi_first_match(bcm_broken_irq_dmi_table);
-	if (dmi_id) {
-		dev_info(dev->dev, "%s: Has a broken IRQ config, disabling IRQ support / runtime-pm\n",
-			 dmi_id->ident);
-		dev->irq = 0;
+	if (broken_irq_dmi_id) {
+		if (broken_irq_dmi_id->driver_data) {
+			gpiod_remove_lookup_table(broken_irq_dmi_id->driver_data);
+		} else {
+			dev_info(dev->dev, "%s: Has a broken IRQ config, disabling IRQ support / runtime-pm\n",
+				 broken_irq_dmi_id->ident);
+			dev->irq = 0;
+		}
 	}
 
 	dev_dbg(dev->dev, "BCM irq: %d\n", dev->irq);
-- 
2.35.1

