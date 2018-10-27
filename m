Return-Path: <SRS0=uhHz=NH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8D9C46475
	for <linux-bluetooth@archiver.kernel.org>; Sat, 27 Oct 2018 11:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D98D20856
	for <linux-bluetooth@archiver.kernel.org>; Sat, 27 Oct 2018 11:33:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D98D20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbeJ0UOM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 27 Oct 2018 16:14:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45792 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728320AbeJ0UOM (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 27 Oct 2018 16:14:12 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B0DBAB0AB3;
        Sat, 27 Oct 2018 11:33:32 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-22.ams2.redhat.com [10.36.116.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3CF8B662FA;
        Sat, 27 Oct 2018 11:33:31 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Jeremy Cline <jeremy@jcline.org>,
        linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: hci_h5: Turn off RTL8723BS on suspend, reprobe on resume
Date:   Sat, 27 Oct 2018 13:33:27 +0200
Message-Id: <20181027113327.8182-2-hdegoede@redhat.com>
In-Reply-To: <20181027113327.8182-1-hdegoede@redhat.com>
References: <20181027113327.8182-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Sat, 27 Oct 2018 11:33:32 +0000 (UTC)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On many devices the RTL8723BS device gets reset during suspend/resume,
causing it to loose its firmware and all state.

Testing has shown it drops back to communicating at 115200 bps and sends
sync-request packages, indicating it has been fully reset.

This commit fixes this by queueing a reprobe on resume.

This mirrors how USB RTL BT devices, which have the same problem, are
handled in the btusb driver, there we set the USB_QUIRK_RESET_RESUME for
all RTL devices, which also causes a reprobe on resume. The only difference
is that here we need to do the reprobe ourselves.

Since we are doing a full reprobe on resume now, we can also turn of the
device on suspend to save power while suspended.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/bluetooth/hci_h5.c | 52 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index beddb89a00f2..654987b47051 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -931,6 +931,56 @@ static void h5_btrtl_close(struct h5 *h5)
 	gpiod_set_value_cansleep(h5->enable_gpio, 0);
 }
 
+/* Suspend/resume support. On many devices the RTL BT device looses power during
+ * suspend/resume, causing it to loose its firmware and all state. So we simply
+ * turn it off on suspend and reprobe on resume.  This mirrors how RTL devices
+ * are handled in the USB driver, where the USB_QUIRK_RESET_RESUME is used which
+ * also causes a reprobe on resume.
+ */
+static int h5_btrtl_suspend(struct h5 *h5)
+{
+	serdev_device_set_flow_control(h5->hu->serdev, false);
+	gpiod_set_value_cansleep(h5->device_wake_gpio, 0);
+	gpiod_set_value_cansleep(h5->enable_gpio, 0);
+	return 0;
+}
+
+struct h5_btrtl_reprobe {
+	struct device *dev;
+	struct work_struct work;
+};
+
+static void h5_btrtl_reprobe_worker(struct work_struct *work)
+{
+	struct h5_btrtl_reprobe *reprobe =
+		container_of(work, struct h5_btrtl_reprobe, work);
+	int ret;
+
+	ret = device_reprobe(reprobe->dev);
+	if (ret && ret != -EPROBE_DEFER)
+		dev_err(reprobe->dev, "Reprobe error %d\n", ret);
+
+	put_device(reprobe->dev);
+	kfree(reprobe);
+	module_put(THIS_MODULE);
+}
+
+static int h5_btrtl_resume(struct h5 *h5)
+{
+	struct h5_btrtl_reprobe *reprobe;
+
+	reprobe = kzalloc(sizeof(*reprobe), GFP_KERNEL);
+	if (!reprobe)
+		return -ENOMEM;
+
+	__module_get(THIS_MODULE);
+
+	INIT_WORK(&reprobe->work, h5_btrtl_reprobe_worker);
+	reprobe->dev = get_device(&h5->hu->serdev->dev);
+	queue_work(system_long_wq, &reprobe->work);
+	return 0;
+}
+
 static const struct acpi_gpio_params btrtl_device_wake_gpios = { 0, 0, false };
 static const struct acpi_gpio_params btrtl_enable_gpios = { 1, 0, false };
 static const struct acpi_gpio_params btrtl_host_wake_gpios = { 2, 0, false };
@@ -945,6 +995,8 @@ static struct h5_vnd rtl_vnd = {
 	.setup		= h5_btrtl_setup,
 	.open		= h5_btrtl_open,
 	.close		= h5_btrtl_close,
+	.suspend	= h5_btrtl_suspend,
+	.resume		= h5_btrtl_resume,
 	.acpi_gpio_map	= acpi_btrtl_gpios,
 };
 #endif
-- 
2.19.0

