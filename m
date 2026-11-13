Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794579978;
	b=leDtNUfkSoDEwU34MtS5XzwklcLz62wB2tdGOjdzSWbRjf7aevzKh3AitbLJruH1b7Px
	 WvPFaaxtJ70lLO9A9pkLpWCS6r9Fdmg6+nNDn4gtwEOGHx/2OgXrI4XjG2AUz3hSsGMIU
	 K6kW7W+luT0PVXSvlsrx1ey+wH0MhwXzFEdSO09tg0q2PLsurSMho+pl99GqrzZLHS6/q
	 8/fa6YFYmS2TWaCzXn9ytCbLDCwC9v6teuATI6CAI8SFoYsbcl6sZ6qe1+I0dPMOCoQhr
	 9vFIZJfkt7orEPxk+bdRRjPBJheeGeYfFR7D81PMUrIVfz40lYFCdhVhH+JnNAy8dEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794579978;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=G1whiDQ+WYgxy6We26fHqJIz5PJd9aZjXqYivDN7dQE=;
	b=Fn5q84Fd4+bLoRWGi80dR9HbNfjXTbgJd5lJGXUxs2HFrw73V6SqPRAsCodWbWsPbmeQ
	 FYmWGCt3+2M6KE4AaxmEERnpudhIJ9V8NzeCKRtbEC48R4wV6ff05TbQF15snFWWEV3a2
	 yBwrRb2BvdcWmNa+2X0J0mjM6NLNLIL5olJfIdN5eUun3A69yfwWs+LN95XaU2NeQNI82
	 g1qXNl3A/kTjpY0+UVJ6sKK9xKsr0kF6Rb46Bvb5duJtx8WmDbYXxJAlBkUIkGv7szCjA
	 GMRh+GpzeyiSUznKMQ6d3G+/AikBdP32c6OCl5QCjdgiEaNhVPOJoWAY+t5TGKPMcdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=n6vBTilQ;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D62606A323
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 14:26:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89D62606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=n6vBTilQ
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 0CC831A1658;
	Fri, 13 Nov 2026 14:26:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D679560015;
	Fri, 13 Nov 2026 14:26:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E0AAD11BC0333;
	Fri, 13 Nov 2026 15:26:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794579974; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=G1whiDQ+WYgxy6We26fHqJIz5PJd9aZjXqYivDN7dQE=;
	b=n6vBTilQ4ZVgf+YzcU4YRbeyaFjryThnAhLFC6REe42a0/4qeHwq/2ml731LHChhjD4Uuv
	PPIzUtXdD2s/4b/YRAPjUH5lX8XVMhNTBjqX3k+N29BpEWHp+0NfARWdJbw6FsB/XrsJlz
	UmvwQSEgY065QifKnim8rFUqDG6ubOl8xfN9ar8WiqDP83pbORWcFU5CryUwZtiLwOMJaZ
	okonC2xMLgmFT9gC3etci89CSnrCC+M8Nrrff9VfwfiwlW8MAHY3pgpIieWbC9d6JoZnkM
	1mms63HDdCivbqC438PzuULoOIYwpgPs2l+WE/ddugqigOmc2RcO1F3c6sbWyw==
From: Paul Cercueil <paul.cercueil@bootlin.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Paul Cercueil <paul.cercueil@bootlin.com>
Subject: [PATCH 1/2] Bluetooth: hci_bcm: Drop CONFIG_PM guards
Date: Fri, 13 Nov 2026 15:25:59 +0100
Message-ID: <20261113142600.74004-1-paul.cercueil@bootlin.com>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Use the modem PM macros for the suspend and resume functions. These
ensure that the PM functions will be automatically dropped by the
compiler when CONFIG_PM is disabled.

Signed-off-by: Paul Cercueil <paul.cercueil@bootlin.com>
---
 drivers/bluetooth/hci_bcm.c | 44 +++++++++++--------------------------
 1 file changed, 13 insertions(+), 31 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 83091e5c5702..ca030ed25540 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -139,10 +139,8 @@ struct bcm_device {
 	bool			irq_active_low;
 	bool			irq_acquired;
 
-#ifdef CONFIG_PM
 	struct hci_uart		*hu;
 	bool			is_suspended;
-#endif
 	bool			no_early_set_baudrate;
 	bool			drive_rts_on_open;
 	bool			no_uart_clock_set;
@@ -230,11 +228,9 @@ static bool bcm_device_exists(struct bcm_device *device)
 {
 	struct list_head *p;
 
-#ifdef CONFIG_PM
 	/* Devices using serdev always exist */
-	if (device && device->hu && device->hu->serdev)
+	if (IS_ENABLED(CONFIG_PM) && device && device->hu && device->hu->serdev)
 		return true;
-#endif
 
 	list_for_each(p, &bcm_device_list) {
 		struct bcm_device *dev = list_entry(p, struct bcm_device, list);
@@ -318,7 +314,6 @@ static int bcm_gpio_set_power(struct bcm_device *dev, bool powered)
 	return err;
 }
 
-#ifdef CONFIG_PM
 static irqreturn_t bcm_host_wake(int irq, void *data)
 {
 	struct bcm_device *bdev = data;
@@ -409,10 +404,6 @@ static int bcm_setup_sleep(struct hci_uart *hu)
 
 	return 0;
 }
-#else
-static inline int bcm_request_irq(struct bcm_data *bcm) { return 0; }
-static inline int bcm_setup_sleep(struct hci_uart *hu) { return 0; }
-#endif
 
 static int bcm_set_diag(struct hci_dev *hdev, bool enable)
 {
@@ -475,9 +466,8 @@ static int bcm_open(struct hci_uart *hu)
 		 */
 		if (hu->tty->dev->parent == dev->dev->parent) {
 			bcm->dev = dev;
-#ifdef CONFIG_PM
-			dev->hu = hu;
-#endif
+			if (IS_ENABLED(CONFIG_PM))
+				dev->hu = hu;
 			break;
 		}
 	}
@@ -513,10 +503,8 @@ static int bcm_open(struct hci_uart *hu)
 	return 0;
 
 err_unset_hu:
-#ifdef CONFIG_PM
-	if (!hu->serdev)
+	if (IS_ENABLED(CONFIG_PM) && !hu->serdev)
 		bcm->dev->hu = NULL;
-#endif
 	mutex_unlock(&bcm_device_lock);
 	hu->priv = NULL;
 	kfree(bcm);
@@ -538,9 +526,8 @@ static int bcm_close(struct hci_uart *hu)
 		bdev = serdev_device_get_drvdata(hu->serdev);
 	} else if (bcm_device_exists(bcm->dev)) {
 		bdev = bcm->dev;
-#ifdef CONFIG_PM
-		bdev->hu = NULL;
-#endif
+		if (IS_ENABLED(CONFIG_PM))
+			bdev->hu = NULL;
 	}
 
 	if (bdev) {
@@ -646,7 +633,7 @@ static int bcm_setup(struct hci_uart *hu)
 	if (hci_test_quirk(hu->hdev, HCI_QUIRK_INVALID_BDADDR))
 		hci_set_quirk(hu->hdev, HCI_QUIRK_USE_BDADDR_PROPERTY);
 
-	if (!bcm_request_irq(bcm))
+	if (IS_ENABLED(CONFIG_PM) && !bcm_request_irq(bcm))
 		err = bcm_setup_sleep(hu);
 
 	return err;
@@ -755,7 +742,6 @@ static struct sk_buff *bcm_dequeue(struct hci_uart *hu)
 	return skb;
 }
 
-#ifdef CONFIG_PM
 static int bcm_suspend_device(struct device *dev)
 {
 	struct bcm_device *bdev = dev_get_drvdata(dev);
@@ -811,9 +797,7 @@ static int bcm_resume_device(struct device *dev)
 
 	return 0;
 }
-#endif
 
-#ifdef CONFIG_PM_SLEEP
 /* suspend callback */
 static int bcm_suspend(struct device *dev)
 {
@@ -885,7 +869,6 @@ static int bcm_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 /* Some firmware reports an IRQ which does not work (wrong pin in fw table?) */
 static struct gpiod_lookup_table irq_on_int33fc02_pin17_gpios = {
@@ -1489,8 +1472,8 @@ MODULE_DEVICE_TABLE(acpi, bcm_acpi_match);
 
 /* suspend and resume callbacks */
 static const struct dev_pm_ops bcm_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(bcm_suspend, bcm_resume)
-	SET_RUNTIME_PM_OPS(bcm_suspend_device, bcm_resume_device, NULL)
+	SYSTEM_SLEEP_PM_OPS(bcm_suspend, bcm_resume)
+	RUNTIME_PM_OPS(bcm_suspend_device, bcm_resume_device, NULL)
 };
 
 static struct platform_driver bcm_driver = {
@@ -1499,7 +1482,7 @@ static struct platform_driver bcm_driver = {
 	.driver = {
 		.name = "hci_bcm",
 		.acpi_match_table = ACPI_PTR(bcm_acpi_match),
-		.pm = &bcm_pm_ops,
+		.pm = pm_ptr(&bcm_pm_ops),
 	},
 };
 
@@ -1514,9 +1497,8 @@ static int bcm_serdev_probe(struct serdev_device *serdev)
 		return -ENOMEM;
 
 	bcmdev->dev = &serdev->dev;
-#ifdef CONFIG_PM
-	bcmdev->hu = &bcmdev->serdev_hu;
-#endif
+	if (IS_ENABLED(CONFIG_PM))
+		bcmdev->hu = &bcmdev->serdev_hu;
 	bcmdev->serdev_hu.serdev = serdev;
 	serdev_device_set_drvdata(serdev, bcmdev);
 
@@ -1608,7 +1590,7 @@ static struct serdev_device_driver bcm_serdev_driver = {
 		.name = "hci_uart_bcm",
 		.of_match_table = of_match_ptr(bcm_bluetooth_of_match),
 		.acpi_match_table = ACPI_PTR(bcm_acpi_match),
-		.pm = &bcm_pm_ops,
+		.pm = pm_ptr(&bcm_pm_ops),
 	},
 };
 
-- 
2.47.3

