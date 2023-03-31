Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B77C761A6
	for <linux-bluetooth@archiver.kernel.org>; Fri, 31 Mar 2023 21:12:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbjCaVMa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 31 Mar 2023 17:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjCaVM3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 31 Mar 2023 17:12:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0EF1D936
        for <linux-bluetooth@vger.kernel.org>; Fri, 31 Mar 2023 14:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680297099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LrsrRTwi0WYJL389M6cXTGbwr4lYcS7GvH8qZhx/QnA=;
        b=gn7g2ebazfyJxDF///b7Ok+qt0UzkYbaWV/O6abz5OkkdpsAbCaFsIGcd5e3dQjj9gPB/F
        Q/45zPrScyLjXbxgcZqr1rBRAIUjrd/AMdzlVceNb1EG3eIZr3UrFCJJyQxFsbA0o/U+GE
        FYBxlb0LzDGnVSy8fwWJYn5eq8XP/Zw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-199-dPmQYiV5NciPXU6RvBzvug-1; Fri, 31 Mar 2023 17:11:36 -0400
X-MC-Unique: dPmQYiV5NciPXU6RvBzvug-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BCDAF3C0ED41;
        Fri, 31 Mar 2023 21:11:35 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0648F492B00;
        Fri, 31 Mar 2023 21:11:34 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/4] Bluetooth: hci_bcm: Limit bcm43430a0 / bcm43430a1 baudrate to 2000000
Date:   Fri, 31 Mar 2023 23:11:22 +0200
Message-Id: <20230331211124.463003-3-hdegoede@redhat.com>
In-Reply-To: <20230331211124.463003-1-hdegoede@redhat.com>
References: <20230331211124.463003-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The bcm43430a0 and bcm43430a1 BT does not support the 0xfc45 command
to set the UART clock to 48 MHz and it also does not work at 4000000
baud without this command as some newer models do.

These chips are found on ACPI/x86 devices where the operating baudrate
does not come from the firmware but is hardcoded at 4000000, which does
not work.

Add a max_baudrate value to struct bcm_device_data and set this
to 2000000 on all known ACPI hardware-ids for the bcm43430a0
and the bcm43430a1.

Note this also adds the BCM2E9F ACPI HID which was missing until now.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/bluetooth/hci_bcm.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 2b6c0e1922cb..4a3ef844df5d 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -55,12 +55,14 @@
  * @drive_rts_on_open: drive RTS signal on ->open() when platform requires it
  * @no_uart_clock_set: UART clock set command for >3Mbps mode is unavailable
  * @max_autobaud_speed: max baudrate supported by device in autobaud mode
+ * @max_speed: max baudrate supported
  */
 struct bcm_device_data {
 	bool	no_early_set_baudrate;
 	bool	drive_rts_on_open;
 	bool	no_uart_clock_set;
 	u32	max_autobaud_speed;
+	u32	max_speed;
 };
 
 /**
@@ -1300,6 +1302,12 @@ static const struct hci_uart_proto bcm_proto = {
 };
 
 #ifdef CONFIG_ACPI
+
+/* bcm43430a0/a1 BT does not support 48MHz UART clock, limit to 2000000 baud */
+static struct bcm_device_data bcm43430_device_data = {
+	.max_speed = 2000000,
+};
+
 static const struct acpi_device_id bcm_acpi_match[] = {
 	{ "BCM2E00" },
 	{ "BCM2E01" },
@@ -1414,19 +1422,19 @@ static const struct acpi_device_id bcm_acpi_match[] = {
 	{ "BCM2E71" },
 	{ "BCM2E72" },
 	{ "BCM2E73" },
-	{ "BCM2E74" },
-	{ "BCM2E75" },
+	{ "BCM2E74", (long)&bcm43430_device_data },
+	{ "BCM2E75", (long)&bcm43430_device_data },
 	{ "BCM2E76" },
 	{ "BCM2E77" },
 	{ "BCM2E78" },
 	{ "BCM2E79" },
 	{ "BCM2E7A" },
-	{ "BCM2E7B" },
+	{ "BCM2E7B", (long)&bcm43430_device_data },
 	{ "BCM2E7C" },
 	{ "BCM2E7D" },
 	{ "BCM2E7E" },
 	{ "BCM2E7F" },
-	{ "BCM2E80" },
+	{ "BCM2E80", (long)&bcm43430_device_data },
 	{ "BCM2E81" },
 	{ "BCM2E82" },
 	{ "BCM2E83" },
@@ -1435,7 +1443,7 @@ static const struct acpi_device_id bcm_acpi_match[] = {
 	{ "BCM2E86" },
 	{ "BCM2E87" },
 	{ "BCM2E88" },
-	{ "BCM2E89" },
+	{ "BCM2E89", (long)&bcm43430_device_data },
 	{ "BCM2E8A" },
 	{ "BCM2E8B" },
 	{ "BCM2E8C" },
@@ -1444,29 +1452,30 @@ static const struct acpi_device_id bcm_acpi_match[] = {
 	{ "BCM2E90" },
 	{ "BCM2E92" },
 	{ "BCM2E93" },
-	{ "BCM2E94" },
+	{ "BCM2E94", (long)&bcm43430_device_data },
 	{ "BCM2E95" },
 	{ "BCM2E96" },
 	{ "BCM2E97" },
 	{ "BCM2E98" },
-	{ "BCM2E99" },
+	{ "BCM2E99", (long)&bcm43430_device_data },
 	{ "BCM2E9A" },
-	{ "BCM2E9B" },
+	{ "BCM2E9B", (long)&bcm43430_device_data },
 	{ "BCM2E9C" },
 	{ "BCM2E9D" },
+	{ "BCM2E9F", (long)&bcm43430_device_data },
 	{ "BCM2EA0" },
 	{ "BCM2EA1" },
-	{ "BCM2EA2" },
-	{ "BCM2EA3" },
+	{ "BCM2EA2", (long)&bcm43430_device_data },
+	{ "BCM2EA3", (long)&bcm43430_device_data },
 	{ "BCM2EA4" },
 	{ "BCM2EA5" },
 	{ "BCM2EA6" },
 	{ "BCM2EA7" },
 	{ "BCM2EA8" },
 	{ "BCM2EA9" },
-	{ "BCM2EAA" },
-	{ "BCM2EAB" },
-	{ "BCM2EAC" },
+	{ "BCM2EAA", (long)&bcm43430_device_data },
+	{ "BCM2EAB", (long)&bcm43430_device_data },
+	{ "BCM2EAC", (long)&bcm43430_device_data },
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, bcm_acpi_match);
@@ -1535,6 +1544,8 @@ static int bcm_serdev_probe(struct serdev_device *serdev)
 		bcmdev->no_early_set_baudrate = data->no_early_set_baudrate;
 		bcmdev->drive_rts_on_open = data->drive_rts_on_open;
 		bcmdev->no_uart_clock_set = data->no_uart_clock_set;
+		if (data->max_speed && bcmdev->oper_speed > data->max_speed)
+			bcmdev->oper_speed = data->max_speed;
 	}
 
 	return hci_uart_register_device(&bcmdev->serdev_hu, &bcm_proto);
-- 
2.39.1

