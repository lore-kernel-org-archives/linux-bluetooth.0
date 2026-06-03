Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A343A961E;
	Wed,  3 Jun 2026 14:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780497450; cv=none; b=QsR9pKz5nZO0XpNXmuJceO5SZl4eysQzOnf9ahgF7KjIOco1ZuQxXoZhcQIofjiLEzjamHAc1E7QQiZXOGoXwex9QX7gu0DkeXsXvc1Vu42ba55WcXWPCfwF08LYmLYfERCgkatbuAgoqNA1DjhF7BeC9NZ9yapT9CcXcnGi3ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780497450; c=relaxed/simple;
	bh=eGIUkkDeHIoabRpC/swsReB/e1STf58GKDlMA+oD6tw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y5aYSNJI49eBejqtkKM0is3xUrQG03igM+ycB41vu78/TvgrDZIVtOLekb3Sp2dUshk9HSp46iebBMc0sRvr7k/tOdIYP9c+8GTaFrVbSDZvKdRfKTLb3IK4VWQ+tgiaatUWpOQGv6D5HA1qLz4snh9h2W7DxZg/WdZdwFdUEGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQT62A2H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQT62A2H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D0A41F0089A;
	Wed,  3 Jun 2026 14:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780497449;
	bh=MxCEcu+ZTRXj48YJ5EIbCe8X2ETMhTGE/bvVh2HH67M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KQT62A2Ho7r2ZO50eJ8T/uo7hGaxYcgxoYlu40P6eSDsNCuiofJ2/b/xWhCzXi0Fc
	 rTmRsXNco+yHDEgHPT2tAaeO0F7cLGjN6iVH6QIQdocyD1oIrQlBB/t4YA8+T1XrPR
	 1v310JwZD+b6ascyThMHhEOP9dcpBuVFpq3XTmSXutVShULNdLEbcJMoW3O9d8PfuG
	 f1OsZlz77XYpBwGbaxeo0LI8P+12WkCTCMaJmN6DzKvG54TpH5o9wxj7xqQmH7rzQT
	 JgbnE7nVVqNnEIUiIdMeL34nSD8WIKHtN/2VFw35hC/KAPqcamfk7rChzjikOdnAf3
	 bSOM8W/oWzmPw==
Received: from johan by xi.lan with local (Exim 4.99.3)
	(envelope-from <johan@kernel.org>)
	id 1wUmik-0000000AYBA-3EP8;
	Wed, 03 Jun 2026 16:37:26 +0200
From: Johan Hovold <johan@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH v3 RESEND 5/5] Bluetooth: btusb: clean up probe error handling
Date: Wed,  3 Jun 2026 16:36:43 +0200
Message-ID: <20260603143643.2514595-6-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260603143643.2514595-1-johan@kernel.org>
References: <20260603143643.2514595-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clean up probe error handling by using dedicated error labels with an
"err" prefix.

Note that the endpoint lookup helper returns -ENXIO when endpoints are
missing which is functionally equivalent to returning -ENODEV.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/bluetooth/btusb.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 450c8746bea6..83fbb5d2bf4a 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4090,10 +4090,8 @@ static int btusb_probe(struct usb_interface *intf,
 
 	err = usb_find_common_endpoints(intf->cur_altsetting, &data->bulk_rx_ep,
 					&data->bulk_tx_ep, &data->intr_ep, NULL);
-	if (err) {
-		kfree(data);
-		return -ENODEV;
-	}
+	if (err)
+		goto err_free_data;
 
 	if (id->driver_info & BTUSB_AMP) {
 		data->cmdreq_type = USB_TYPE_CLASS | 0x01;
@@ -4149,8 +4147,8 @@ static int btusb_probe(struct usb_interface *intf,
 
 	hdev = hci_alloc_dev_priv(priv_size);
 	if (!hdev) {
-		kfree(data);
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto err_free_data;
 	}
 
 	hdev->bus = HCI_USB;
@@ -4164,7 +4162,7 @@ static int btusb_probe(struct usb_interface *intf,
 					GPIOD_OUT_LOW);
 	if (IS_ERR(reset_gpio)) {
 		err = PTR_ERR(reset_gpio);
-		goto out_free_dev;
+		goto err_free_hdev;
 	} else if (reset_gpio) {
 		data->reset_gpio = reset_gpio;
 	}
@@ -4180,7 +4178,7 @@ static int btusb_probe(struct usb_interface *intf,
 #ifdef CONFIG_PM
 	err = btusb_config_oob_wake(hdev);
 	if (err)
-		goto out_free_dev;
+		goto err_put_reset;
 
 	/* Marvell devices may need a specific chip configuration */
 	if (id->driver_info & BTUSB_MARVELL && data->oob_wake_irq) {
@@ -4437,11 +4435,14 @@ static int btusb_probe(struct usb_interface *intf,
 		device_init_wakeup(&data->udev->dev, false);
 		free_irq(data->oob_wake_irq, data);
 	}
-out_free_dev:
+err_put_reset:
 	if (data->reset_gpio)
 		gpiod_put(data->reset_gpio);
+err_free_hdev:
 	hci_free_dev(hdev);
+err_free_data:
 	kfree(data);
+
 	return err;
 }
 
-- 
2.53.0

