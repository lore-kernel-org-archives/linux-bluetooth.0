Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4355DC761A6
	for <linux-bluetooth@archiver.kernel.org>; Fri, 31 Mar 2023 21:12:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233092AbjCaVMe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 31 Mar 2023 17:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjCaVMd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 31 Mar 2023 17:12:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3966120620
        for <linux-bluetooth@vger.kernel.org>; Fri, 31 Mar 2023 14:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680297103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZNqNsPrrftVaQBJIDKeg15JbF9J1wMHcRvWUqB9JE28=;
        b=IW8roDpc3VG7Xa4EH9K1tRP9eiJWA+eod4uNE9t1lr8rMYwmP3E6xCmbLtaJoP6bVO39pb
        r/464L2R4xInotUpv3DJUy4NYcmDSwnpO8IP8KdUuqTxRT8uQIgGDDatyEl5cZQef12oQW
        AK5Srb8gdRylnNAiUvi+a8EihBIOf6o=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-91-TqfUOhSXPXmGJ_KpIQuEww-1; Fri, 31 Mar 2023 17:11:38 -0400
X-MC-Unique: TqfUOhSXPXmGJ_KpIQuEww-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A3ACA29A9D36;
        Fri, 31 Mar 2023 21:11:37 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E1D5F492B00;
        Fri, 31 Mar 2023 21:11:36 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/4] Bluetooth: hci_bcm: Add Acer Iconia One 7 B1-750 to the bcm_broken_irq_dmi_table
Date:   Fri, 31 Mar 2023 23:11:24 +0200
Message-Id: <20230331211124.463003-5-hdegoede@redhat.com>
In-Reply-To: <20230331211124.463003-1-hdegoede@redhat.com>
References: <20230331211124.463003-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The DSDT for the Acer Iconia One 7 B1-750 models (which share
the same mainboard) specifies a IOAPIC IRQ for the HCI -> host IRQ but
this is not correct.

Like the Asus TF103C these tablets use pin 17 of the INT33FC:02 GPIO
controller for the IRQ and this pin is _not_ configured in direct IRQ
mode by the firmware.

Add a DMI match for this, re-using the Asus TF103C gpiod_lookup_table,
to fix bluetooth not working on these tablets.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/bluetooth/hci_bcm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index eb9e1c858e91..83bf5d4330c4 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -899,6 +899,14 @@ static struct gpiod_lookup_table irq_on_int33fc02_pin17_gpios = {
 };
 
 static const struct dmi_system_id bcm_broken_irq_dmi_table[] = {
+	{
+		.ident = "Acer Iconia One 7 B1-750",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Insyde"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "VESPA2"),
+		},
+		.driver_data = &irq_on_int33fc02_pin17_gpios,
+	},
 	{
 		.ident = "Asus TF103C",
 		.matches = {
-- 
2.39.1

