Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B8FC64EC7
	for <linux-bluetooth@archiver.kernel.org>; Sat, 25 Feb 2023 14:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjBYOkA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 25 Feb 2023 09:40:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBYOj7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 25 Feb 2023 09:39:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901AD12BE4
        for <linux-bluetooth@vger.kernel.org>; Sat, 25 Feb 2023 06:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677335951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=EgVx5zjCl/pDiYGE9sx9GvME48f6cIrJ7yIXuQ2Paus=;
        b=SR268dj0D3NBfO+g6hqvJuVaefob3Wf4K/pPddPBzh1cZN0dJvBIEgQvulnthEDQdhrKOG
        GlAC0vYL9hSB62KyoP+vekfQdv4C2ONqkf0ASgTX5ZEVoNb0w+DaL9epj49qrcbV+/8lmL
        WHKwo+Nh3Ox9qujowjKivnhWWONhadk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-402-NB3lm_5CMaaQYty-NFIDTg-1; Sat, 25 Feb 2023 09:39:07 -0500
X-MC-Unique: NB3lm_5CMaaQYty-NFIDTg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CC6F3811E6E;
        Sat, 25 Feb 2023 14:39:06 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 124CB440DC;
        Sat, 25 Feb 2023 14:39:05 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_bcm: Add Lenovo Yoga Tablet 2 830 / 1050 to the bcm_broken_irq_dmi_table
Date:   Sat, 25 Feb 2023 15:39:00 +0100
Message-Id: <20230225143900.47158-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The DSDT for the Lenovo Yoga Tablet 2 830 / 1050 models (which share
the same mainboard) specifies a IOAPIC IRQ for the HCI -> host IRQ but
this is not correct.

Like the Asus TF103C these tablets use pin 17 of the INT33FC:02 GPIO
controller for the IRQ and this pin is _not_ configured in direct IRQ
mode by the firmware.

Add a DMI match for this, re-using the Asus TF103C gpiod_lookup_table,
to fix bluetooth not working on these tablets.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/bluetooth/hci_bcm.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 2b6c0e1922cb..227c4da3ba4d 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -888,7 +888,7 @@ static int bcm_resume(struct device *dev)
 #endif
 
 /* Some firmware reports an IRQ which does not work (wrong pin in fw table?) */
-static struct gpiod_lookup_table asus_tf103c_irq_gpios = {
+static struct gpiod_lookup_table irq_on_int33fc02_pin17_gpios = {
 	.dev_id = "serial0-0",
 	.table = {
 		GPIO_LOOKUP("INT33FC:02", 17, "host-wakeup-alt", GPIO_ACTIVE_HIGH),
@@ -903,7 +903,18 @@ static const struct dmi_system_id bcm_broken_irq_dmi_table[] = {
 			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
 			DMI_MATCH(DMI_PRODUCT_NAME, "TF103C"),
 		},
-		.driver_data = &asus_tf103c_irq_gpios,
+		.driver_data = &irq_on_int33fc02_pin17_gpios,
+	},
+	{
+		.ident = "Lenovo Yoga Tablet 2 830F/L / 1050F/L",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Intel Corp."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "VALLEYVIEW C0 PLATFORM"),
+			DMI_MATCH(DMI_BOARD_NAME, "BYT-T FFD8"),
+			/* Partial match on beginning of BIOS version */
+			DMI_MATCH(DMI_BIOS_VERSION, "BLADE_21"),
+		},
+		.driver_data = &irq_on_int33fc02_pin17_gpios,
 	},
 	{
 		.ident = "Meegopad T08",
-- 
2.39.1

