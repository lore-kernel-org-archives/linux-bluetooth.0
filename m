Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26F9C4320A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Jul 2021 11:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B998F60EC0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Jul 2021 11:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234394AbhGWKvc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Jul 2021 06:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbhGWKvb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Jul 2021 06:51:31 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512C6C061575
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jul 2021 04:32:04 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id d69-20020a25e6480000b02904f4a117bd74so1415539ybh.17
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jul 2021 04:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=O7I41NCtCSHX22Iy466gv23WxW0Z9akPjEALodX4ppw=;
        b=Hx++rDueQl1UsulcsoEfkYDvqY0p1UAf/Wu/Vh0ZUxEUddIse7HzC9JoGi2Veldo6x
         +uwd+/lcQoFPm9fv/osBM/ZrUpX2hslwqSno2d6TL4sYTi5KOoWxOpeXCN/lYEJU0E1s
         cLKbiUwrabMH47amSxMaKQexl+L+iOjo4QIU6HC6ycLLOmuzqAvIoBg4XufsB+5mHYYB
         t0VDXsA5KvbKfvesg2FeF90yfZl0YyTZuk76rOsmP4fgAOeSkO8DNxn7ZNqXRHu9GqNR
         upW2/s0Ey6kzjzwiDnXhDcdhdc3d06lEuxCksHvOEEHnb4+pGVf2IbdVvjfDTiKBqQM4
         XWgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=O7I41NCtCSHX22Iy466gv23WxW0Z9akPjEALodX4ppw=;
        b=WY4ZLNVmq5NMAcsJY5ubT/Y5U7fnInxB1ex0Vk1a3x9n5q7jr/odBKmccf8hmvQV8k
         D9J6B/VhWEWVpKRzGHKFhG6uTDBV6IAait37I28nfB0B6tayGPGMZz2X+rIsPydLm4e3
         5pKrgZQxxHyTMX0cF6VUrjijUwm9LRZHjCybwKnx5YArpeCIW4WmMMZOLyRlMF5bfylV
         r/Ov1OXupY3mkYotibCUySI8gjv7ymlEouSoWqvvUmJb+o3AhRP9y/6u3S9CLFZB6/h0
         V6VE9qqIl+25jdNJ7qjJ5kcbHrqYgvtd8o1IoC1MSYBNpceFkMPO+PXqvvCRZmTOn/0k
         587g==
X-Gm-Message-State: AOAM530W4BewuNGsON8QrvsMJVihj6VzduFJ217pPwBYVMXZwEmnBdG3
        IdEUOyaUs2ImLJ5brXAB6XAUVzHi+zUjWnhe2FKijtkiw8EVaqzw2Scr9LcOCG0OS4QTdiU0tyQ
        TPay/feME48uP0zIzyHoVO22GYi5/Jlk0Z/xUQ5eDrnoOtQ6IKe4f/kQJinvwGgRiJmvB5tYXK1
        np
X-Google-Smtp-Source: ABdhPJy2GrOZNBtTyOfCUXXeKFEqddsYzKfLrzRIgV7ajqSJmmK2qB3bOLcm4H3si2Rw35RM34tHpdtr5bok
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:ddde:33b:f989:cd76])
 (user=apusaka job=sendgmr) by 2002:a25:5807:: with SMTP id
 m7mr5723073ybb.127.1627039923474; Fri, 23 Jul 2021 04:32:03 -0700 (PDT)
Date:   Fri, 23 Jul 2021 19:31:55 +0800
Message-Id: <20210723193137.v3.1.I68649745bd11a83265f1e816bf34ecc82775e95a@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH v3 1/3] Bluetooth: hci_h5: add WAKEUP_DISABLE flag
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Hilda Wu <hildawu@realtek.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

Some RTL chips resets the FW on suspend, so wakeup is disabled on
those chips. This patch introduces this WAKEUP_DISABLE flag so that
chips that doesn't reset FW on suspend can leave the flag unset and
is allowed to wake the host.

This patch also left RTL8822 WAKEUP_DISABLE flag unset, therefore
allowing it to wake the host, and preventing reprobing on resume.

Signed-off-by: Archie Pusaka <apusaka@chromium.org>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Reviewed-by: Hilda Wu <hildawu@realtek.com>

---

Changes in v3:
* Rebasing

Changes in v2:
* Remove unnecessary variable

 drivers/bluetooth/hci_h5.c | 83 +++++++++++++++++++++++++++-----------
 1 file changed, 59 insertions(+), 24 deletions(-)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index 7b985c7cd26d..fd672111a048 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -51,8 +51,9 @@
 
 /* H5 state flags */
 enum {
-	H5_RX_ESC,	/* SLIP escape mode */
-	H5_TX_ACK_REQ,	/* Pending ack to send */
+	H5_RX_ESC,		/* SLIP escape mode */
+	H5_TX_ACK_REQ,		/* Pending ack to send */
+	H5_WAKEUP_DISABLE,	/* Device cannot wake host */
 };
 
 struct h5 {
@@ -97,6 +98,10 @@ struct h5 {
 	struct gpio_desc *device_wake_gpio;
 };
 
+enum h5_driver_info {
+	H5_INFO_WAKEUP_DISABLE = BIT(0),
+};
+
 struct h5_vnd {
 	int (*setup)(struct h5 *h5);
 	void (*open)(struct h5 *h5);
@@ -106,6 +111,11 @@ struct h5_vnd {
 	const struct acpi_gpio_mapping *acpi_gpio_map;
 };
 
+struct h5_device_data {
+	uint32_t driver_info;
+	struct h5_vnd *vnd;
+};
+
 static void h5_reset_rx(struct h5 *h5);
 
 static void h5_link_control(struct hci_uart *hu, const void *data, size_t len)
@@ -791,6 +801,8 @@ static int h5_serdev_probe(struct serdev_device *serdev)
 {
 	struct device *dev = &serdev->dev;
 	struct h5 *h5;
+	const struct h5_device_data *data;
+	int err;
 
 	h5 = devm_kzalloc(dev, sizeof(*h5), GFP_KERNEL);
 	if (!h5)
@@ -807,20 +819,19 @@ static int h5_serdev_probe(struct serdev_device *serdev)
 		if (!match)
 			return -ENODEV;
 
-		h5->vnd = (const struct h5_vnd *)match->driver_data;
+		data = (const struct h5_device_data *)match->driver_data;
+		h5->vnd = data->vnd;
 		h5->id  = (char *)match->id;
 
 		if (h5->vnd->acpi_gpio_map)
 			devm_acpi_dev_add_driver_gpios(dev,
 						       h5->vnd->acpi_gpio_map);
 	} else {
-		const void *data;
-
 		data = of_device_get_match_data(dev);
 		if (!data)
 			return -ENODEV;
 
-		h5->vnd = (const struct h5_vnd *)data;
+		h5->vnd = data->vnd;
 	}
 
 
@@ -833,7 +844,14 @@ static int h5_serdev_probe(struct serdev_device *serdev)
 	if (IS_ERR(h5->device_wake_gpio))
 		return PTR_ERR(h5->device_wake_gpio);
 
-	return hci_uart_register_device(&h5->serdev_hu, &h5p);
+	err = hci_uart_register_device(&h5->serdev_hu, &h5p);
+	if (err)
+		return err;
+
+	if (data->driver_info & H5_INFO_WAKEUP_DISABLE)
+		set_bit(H5_WAKEUP_DISABLE, &h5->flags);
+
+	return 0;
 }
 
 static void h5_serdev_remove(struct serdev_device *serdev)
@@ -921,7 +939,8 @@ static void h5_btrtl_open(struct h5 *h5)
 	 * done by the hci_suspend_notifier is not necessary; it actually causes
 	 * delays and a bunch of errors to get logged, so disable it.
 	 */
-	set_bit(HCI_UART_NO_SUSPEND_NOTIFIER, &h5->hu->flags);
+	if (test_bit(H5_WAKEUP_DISABLE, &h5->flags))
+		set_bit(HCI_UART_NO_SUSPEND_NOTIFIER, &h5->hu->flags);
 
 	/* Devices always start with these fixed parameters */
 	serdev_device_set_flow_control(h5->hu->serdev, false);
@@ -942,15 +961,18 @@ static void h5_btrtl_close(struct h5 *h5)
 
 /* Suspend/resume support. On many devices the RTL BT device loses power during
  * suspend/resume, causing it to lose its firmware and all state. So we simply
- * turn it off on suspend and reprobe on resume.  This mirrors how RTL devices
- * are handled in the USB driver, where the USB_QUIRK_RESET_RESUME is used which
+ * turn it off on suspend and reprobe on resume. This mirrors how RTL devices
+ * are handled in the USB driver, where the BTUSB_WAKEUP_DISABLE is used which
  * also causes a reprobe on resume.
  */
 static int h5_btrtl_suspend(struct h5 *h5)
 {
 	serdev_device_set_flow_control(h5->hu->serdev, false);
 	gpiod_set_value_cansleep(h5->device_wake_gpio, 0);
-	gpiod_set_value_cansleep(h5->enable_gpio, 0);
+
+	if (test_bit(H5_WAKEUP_DISABLE, &h5->flags))
+		gpiod_set_value_cansleep(h5->enable_gpio, 0);
+
 	return 0;
 }
 
@@ -976,17 +998,21 @@ static void h5_btrtl_reprobe_worker(struct work_struct *work)
 
 static int h5_btrtl_resume(struct h5 *h5)
 {
-	struct h5_btrtl_reprobe *reprobe;
+	if (test_bit(H5_WAKEUP_DISABLE, &h5->flags)) {
+		struct h5_btrtl_reprobe *reprobe;
 
-	reprobe = kzalloc(sizeof(*reprobe), GFP_KERNEL);
-	if (!reprobe)
-		return -ENOMEM;
+		reprobe = kzalloc(sizeof(*reprobe), GFP_KERNEL);
+		if (!reprobe)
+			return -ENOMEM;
 
-	__module_get(THIS_MODULE);
+		__module_get(THIS_MODULE);
 
-	INIT_WORK(&reprobe->work, h5_btrtl_reprobe_worker);
-	reprobe->dev = get_device(&h5->hu->serdev->dev);
-	queue_work(system_long_wq, &reprobe->work);
+		INIT_WORK(&reprobe->work, h5_btrtl_reprobe_worker);
+		reprobe->dev = get_device(&h5->hu->serdev->dev);
+		queue_work(system_long_wq, &reprobe->work);
+	} else {
+		gpiod_set_value_cansleep(h5->device_wake_gpio, 1);
+	}
 	return 0;
 }
 
@@ -1008,13 +1034,22 @@ static struct h5_vnd rtl_vnd = {
 	.resume		= h5_btrtl_resume,
 	.acpi_gpio_map	= acpi_btrtl_gpios,
 };
+
+static const struct h5_device_data h5_data_rtl8822cs = {
+	.vnd = &rtl_vnd,
+};
+
+static const struct h5_device_data h5_data_rtl8723bs = {
+	.driver_info = H5_INFO_WAKEUP_DISABLE,
+	.vnd = &rtl_vnd,
+};
 #endif
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id h5_acpi_match[] = {
 #ifdef CONFIG_BT_HCIUART_RTL
-	{ "OBDA0623", (kernel_ulong_t)&rtl_vnd },
-	{ "OBDA8723", (kernel_ulong_t)&rtl_vnd },
+	{ "OBDA0623", (kernel_ulong_t)&h5_data_rtl8723bs },
+	{ "OBDA8723", (kernel_ulong_t)&h5_data_rtl8723bs },
 #endif
 	{ },
 };
@@ -1028,11 +1063,11 @@ static const struct dev_pm_ops h5_serdev_pm_ops = {
 static const struct of_device_id rtl_bluetooth_of_match[] = {
 #ifdef CONFIG_BT_HCIUART_RTL
 	{ .compatible = "realtek,rtl8822cs-bt",
-	  .data = (const void *)&rtl_vnd },
+	  .data = (const void *)&h5_data_rtl8822cs },
 	{ .compatible = "realtek,rtl8723bs-bt",
-	  .data = (const void *)&rtl_vnd },
+	  .data = (const void *)&h5_data_rtl8723bs },
 	{ .compatible = "realtek,rtl8723ds-bt",
-	  .data = (const void *)&rtl_vnd },
+	  .data = (const void *)&h5_data_rtl8723bs },
 #endif
 	{ },
 };
-- 
2.32.0.432.gabb21c7263-goog

