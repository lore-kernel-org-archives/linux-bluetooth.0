Return-Path: <SRS0=uhHz=NH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C31C46475
	for <linux-bluetooth@archiver.kernel.org>; Sat, 27 Oct 2018 11:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A12C520856
	for <linux-bluetooth@archiver.kernel.org>; Sat, 27 Oct 2018 11:33:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A12C520856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbeJ0UOK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 27 Oct 2018 16:14:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54996 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728320AbeJ0UOK (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 27 Oct 2018 16:14:10 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EBF5F30012EB;
        Sat, 27 Oct 2018 11:33:30 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-22.ams2.redhat.com [10.36.116.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6E330662FA;
        Sat, 27 Oct 2018 11:33:29 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Jeremy Cline <jeremy@jcline.org>,
        linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: hci_h5: Add suspend / resume ops
Date:   Sat, 27 Oct 2018 13:33:26 +0200
Message-Id: <20181027113327.8182-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Sat, 27 Oct 2018 11:33:31 +0000 (UTC)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add support for vendor specific suspend / resume callbacks.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/bluetooth/hci_h5.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index 8eede1197cd2..beddb89a00f2 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -115,6 +115,8 @@ struct h5_vnd {
 	int (*setup)(struct h5 *h5);
 	void (*open)(struct h5 *h5);
 	void (*close)(struct h5 *h5);
+	int (*suspend)(struct h5 *h5);
+	int (*resume)(struct h5 *h5);
 	const struct acpi_gpio_mapping *acpi_gpio_map;
 };
 
@@ -841,6 +843,28 @@ static void h5_serdev_remove(struct serdev_device *serdev)
 	hci_uart_unregister_device(&h5->serdev_hu);
 }
 
+static int __maybe_unused h5_serdev_suspend(struct device *dev)
+{
+	struct h5 *h5 = dev_get_drvdata(dev);
+	int ret = 0;
+
+	if (h5->vnd && h5->vnd->suspend)
+		ret = h5->vnd->suspend(h5);
+
+	return ret;
+}
+
+static int __maybe_unused h5_serdev_resume(struct device *dev)
+{
+	struct h5 *h5 = dev_get_drvdata(dev);
+	int ret = 0;
+
+	if (h5->vnd && h5->vnd->resume)
+		ret = h5->vnd->resume(h5);
+
+	return ret;
+}
+
 #ifdef CONFIG_BT_HCIUART_RTL
 static int h5_btrtl_setup(struct h5 *h5)
 {
@@ -935,12 +959,17 @@ static const struct acpi_device_id h5_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, h5_acpi_match);
 #endif
 
+static const struct dev_pm_ops h5_serdev_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(h5_serdev_suspend, h5_serdev_resume)
+};
+
 static struct serdev_device_driver h5_serdev_driver = {
 	.probe = h5_serdev_probe,
 	.remove = h5_serdev_remove,
 	.driver = {
 		.name = "hci_uart_h5",
 		.acpi_match_table = ACPI_PTR(h5_acpi_match),
+		.pm = &h5_serdev_pm_ops,
 	},
 };
 
-- 
2.19.0

