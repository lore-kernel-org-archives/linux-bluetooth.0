Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C101DC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 31 Dec 2021 11:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbhLaLvJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 31 Dec 2021 06:51:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35368 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229489AbhLaLvJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 31 Dec 2021 06:51:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640951468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=zhWN2Rh45gKF0Nk3ByNy06oJF/53KKV9V2UfhQl0Yjk=;
        b=IQnOPRs3Vkjt2/iF/6K3zN9aKdhSzw7sfj/rO5q8II/f3oTrwGf65NaESek4zfZpb33Vsl
        iTy/yTTbDi8hDlM458/wpGRCnJOIeR/QhT9Pgg+tNDwpX1d6NBRAPXbg4JkawjRI+NplYD
        A2gEJPXTbHhDX3IeSOJxqidwHoGxsZw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-66-Q5P4hJ_YOiWPvjrBzZpshA-1; Fri, 31 Dec 2021 06:51:03 -0500
X-MC-Unique: Q5P4hJ_YOiWPvjrBzZpshA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04EDB1853026;
        Fri, 31 Dec 2021 11:51:02 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E315070F60;
        Fri, 31 Dec 2021 11:51:00 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_bcm: Add the Asus TF103C to the bcm_broken_irq_dmi_table
Date:   Fri, 31 Dec 2021 12:50:55 +0100
Message-Id: <20211231115055.115988-1-hdegoede@redhat.com>
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
index ef54afa29357..c6ac4aa994af 100644
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
2.33.1

