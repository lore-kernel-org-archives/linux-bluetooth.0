Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794579978;
	b=HaQc5jOz799YczzQjrLUFZY9ZNAyWtGV8cZvyfSepFVXYij7l1m9ly6gosJ8DLhPciEv
	 xHzdubwBmiAyNBxnONagr5M3AFoQnO0xfNFOzGDmAV7k2564M+RFlXc/ZAz0N0DdBc/dV
	 P6YCJZM18jtyasHK+LET8/KnQBxOvfGoVITzZszR4O7vq9Euk53hinaCMf/hPQmq8L/mC
	 g+0vCIfVDSYipshEpF/yym1DbH2OzFsKP3UhY/rES4UCtWzpahsVtpMwZeNhiE5hR/Tcz
	 ++4tbM2bPsQpU0yRZ4Ktn4LPPIbFYd6CH4IbWavwvFlsGQrEBdLKqZJwvTTBMiHIf9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794579978;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=/nLM1fyb4CYFtb+qcD/HqclcdUuwKJWI/0V/2uveRrs=;
	b=PpgxyjNjUzYhq7cAJcPPOEDtBqyhaWOWGhiezQ2YVj3Eph/mreFsfkDB+3cRMSqU2by1
	 +KWiCpKkX/aDtTE0xNoMz62ephGMZ/MvowCWuNKISeqf7cvPu6cspPzajc3srcljtQQ1g
	 fjd0juaLlDY34NI4wpuM/OUnEryF5Re74OmjWCTSeLbgIAF8HqW+YBlT4khyEDshgNZmB
	 dUesWiAIM1gU09gwagSvmdYSJ7PfN7vYgCukApMeraSMBaB9Z56RHv642DcSDOBm+zo13
	 hPOcgoIPoOjxW+93q6OzDLsKVHvsAwprfJCdLF0y5BfH14MoNptgCx1GaoMxacHbN3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Gy7XBSKK;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E75606A32E
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 14:26:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99E75606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Gy7XBSKK
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 741C04E415A5
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 14:26:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4AB2160015;
	Fri, 13 Nov 2026 14:26:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B836711BC040F;
	Fri, 13 Nov 2026 15:26:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794579975; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=/nLM1fyb4CYFtb+qcD/HqclcdUuwKJWI/0V/2uveRrs=;
	b=Gy7XBSKKfWqxxd7xixK/0PFMoyUbEgTqGprmUvQTCLWbMtQ6FGbthTeuqSb3Sy9pHt4FbB
	HpixdHuw3qRscYQ2VjmcDpT3gtxPM8loPEDl6njNN+9cUTdNikCaPHkBeWpTBvD/foGEZK
	RwHqCrrBzUaCYTN9QLx3Z7pgXP44sZU51YmOcig6dsZ/Fq5QuuJEv96xvJJx0jWjVjTHgm
	dQypJaRa7RWfJEhYR1zmxv/mciNbW+rQOra330YojJ1INxZKvJuswGQ0Peovt50YuRFf+w
	siKDfPKZqE8DPpM9mvWBX6SZp8Zh+shp2N1UnFLA2UAvrB1ebTZmVPzobQwNBA==
From: Paul Cercueil <paul.cercueil@bootlin.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Paul Cercueil <paul.cercueil@bootlin.com>
Subject: [PATCH 2/2] Bluetooth: btusb: Prevent conditional compilation
Date: Fri, 13 Nov 2026 15:26:00 +0100
Message-ID: <20261113142600.74004-2-paul.cercueil@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261113142600.74004-1-paul.cercueil@bootlin.com>
References: <20261113142600.74004-1-paul.cercueil@bootlin.com>
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

Use IS_ENABLED() when possible instead of #ifdef macro guards.
It makes the code cleaner, and the compiler will still discard the code
blocks if the corresponding configuration option is disabled.

Note the small change where we now check for
"IS_ENABLED(CONFIG_PM) && data->oob_wake_irq". These code paths were
dead when CONFIG_PM was not set, and I'm not sure the compiler was
seeing that.

Signed-off-by: Paul Cercueil <paul.cercueil@bootlin.com>
---
 drivers/bluetooth/btusb_main.c | 35 ++++++++++------------------------
 1 file changed, 10 insertions(+), 25 deletions(-)

diff --git a/drivers/bluetooth/btusb_main.c b/drivers/bluetooth/btusb_main.c
index 92a78a7e6039..295c743f42f7 100644
--- a/drivers/bluetooth/btusb_main.c
+++ b/drivers/bluetooth/btusb_main.c
@@ -3220,7 +3220,6 @@ static int btusb_mtk_shutdown(struct hci_dev *hdev)
 	return ret;
 }
 
-#ifdef CONFIG_PM
 /* Configure an out-of-band gpio as wake-up pin, if specified in device tree */
 static int marvell_config_oob_wake(struct hci_dev *hdev)
 {
@@ -3262,12 +3261,6 @@ static int marvell_config_oob_wake(struct hci_dev *hdev)
 
 	return 0;
 }
-#else
-static inline int marvell_config_oob_wake(struct hci_dev *hdev)
-{
-	return 0;
-}
-#endif
 
 static int btusb_set_bdaddr_marvell(struct hci_dev *hdev,
 				    const bdaddr_t *bdaddr)
@@ -4044,7 +4037,6 @@ static int btusb_bcm_set_diag(struct hci_dev *hdev, bool enable)
 	return submit_or_queue_tx_urb(hdev, urb);
 }
 
-#ifdef CONFIG_PM
 static irqreturn_t btusb_oob_wake_handler(int irq, void *priv)
 {
 	struct btusb_data *data = priv;
@@ -4110,12 +4102,6 @@ static int btusb_config_oob_wake(struct hci_dev *hdev)
 
 	return ret;
 }
-#else
-static inline int btusb_config_oob_wake(struct hci_dev *hdev)
-{
-	return 0;
-}
-#endif
 
 static void btusb_check_needs_reset_resume(struct usb_interface *intf)
 {
@@ -4547,12 +4533,15 @@ static int btusb_probe(struct usb_interface *intf,
 	hdev->wakeup  = btusb_wakeup;
 	hdev->hci_drv = &btusb_hci_drv;
 
-	err = btusb_config_oob_wake(hdev);
-	if (err)
-		goto err_put_reset;
+	if (IS_ENABLED(CONFIG_PM)) {
+		err = btusb_config_oob_wake(hdev);
+		if (err)
+			goto err_put_reset;
+	}
 
 	/* Marvell devices may need a specific chip configuration */
-	if (id->driver_info & BTUSB_MARVELL && data->oob_wake_irq) {
+	if (IS_ENABLED(CONFIG_PM)
+	    && id->driver_info & BTUSB_MARVELL && data->oob_wake_irq) {
 		err = marvell_config_oob_wake(hdev);
 		if (err)
 			goto err_disable_wakeup;
@@ -4837,7 +4826,7 @@ static int btusb_probe(struct usb_interface *intf,
 err_kill_tx_urbs:
 	usb_kill_anchored_urbs(&data->tx_anchor);
 err_disable_wakeup:
-	if (data->oob_wake_irq) {
+	if (IS_ENABLED(CONFIG_PM) && data->oob_wake_irq) {
 		device_init_wakeup(&data->udev->dev, false);
 		free_irq(data->oob_wake_irq, data);
 	}
@@ -4876,7 +4865,7 @@ static void btusb_disconnect(struct usb_interface *intf)
 
 	hci_unregister_dev(hdev);
 
-	if (data->oob_wake_irq) {
+	if (IS_ENABLED(CONFIG_PM) && data->oob_wake_irq) {
 		device_init_wakeup(&data->udev->dev, false);
 		free_irq(data->oob_wake_irq, data);
 	}
@@ -5076,7 +5065,6 @@ static int btusb_resume(struct usb_interface *intf)
 	return err;
 }
 
-#ifdef CONFIG_DEV_COREDUMP
 static void btusb_coredump(struct device *dev)
 {
 	struct btusb_data *data = dev_get_drvdata(dev);
@@ -5085,7 +5073,6 @@ static void btusb_coredump(struct device *dev)
 	if (hdev->dump.coredump)
 		hdev->dump.coredump(hdev);
 }
-#endif
 
 static struct usb_driver btusb_driver = {
 	.name		= "btusb",
@@ -5097,11 +5084,9 @@ static struct usb_driver btusb_driver = {
 	.supports_autosuspend = 1,
 	.disable_hub_initiated_lpm = 1,
 
-#ifdef CONFIG_DEV_COREDUMP
 	.driver = {
-		.coredump = btusb_coredump,
+		.coredump = PTR_IF(IS_ENABLED(CONFIG_DEV_COREDUMP), btusb_coredump),
 	},
-#endif
 };
 
 module_usb_driver(btusb_driver);
-- 
2.47.3

