Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27EF5C76196
	for <linux-bluetooth@archiver.kernel.org>; Fri, 31 Mar 2023 21:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbjCaVM2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 31 Mar 2023 17:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjCaVM1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 31 Mar 2023 17:12:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BACD20312
        for <linux-bluetooth@vger.kernel.org>; Fri, 31 Mar 2023 14:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680297100;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yemG7U4n0SREemlPoqtXQXCCdOnV3oRU7zN02g4tpYY=;
        b=SvSOVkEfD9eTpibwc+OpAl4b4XP0Otu66k8Ex6JGG9n488k0BN2GVXnpC2eJEe3/rh+lHl
        hx0dy7QkAYJewNftd6UvMI6QkQw7Nug9/odeRffNbZg/zH97IsbnN+gvUAUuV4XnfuRwzy
        ZIRNNFaH9Y3XeSvlTOhq08m+S9+DRj8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-6-3yd2duNxMLuhbyYM0fqq7Q-1; Fri, 31 Mar 2023 17:11:37 -0400
X-MC-Unique: 3yd2duNxMLuhbyYM0fqq7Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B11E185A588;
        Fri, 31 Mar 2023 21:11:36 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EDE5B492B00;
        Fri, 31 Mar 2023 21:11:35 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/4] Bluetooth: hci_bcm: Add Lenovo Yoga Tablet 2 830 / 1050 to the bcm_broken_irq_dmi_table
Date:   Fri, 31 Mar 2023 23:11:23 +0200
Message-Id: <20230331211124.463003-4-hdegoede@redhat.com>
In-Reply-To: <20230331211124.463003-1-hdegoede@redhat.com>
References: <20230331211124.463003-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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
index 4a3ef844df5d..eb9e1c858e91 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -890,7 +890,7 @@ static int bcm_resume(struct device *dev)
 #endif
 
 /* Some firmware reports an IRQ which does not work (wrong pin in fw table?) */
-static struct gpiod_lookup_table asus_tf103c_irq_gpios = {
+static struct gpiod_lookup_table irq_on_int33fc02_pin17_gpios = {
 	.dev_id = "serial0-0",
 	.table = {
 		GPIO_LOOKUP("INT33FC:02", 17, "host-wakeup-alt", GPIO_ACTIVE_HIGH),
@@ -905,7 +905,18 @@ static const struct dmi_system_id bcm_broken_irq_dmi_table[] = {
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

