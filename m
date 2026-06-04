Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F633C9438;
	Thu,  4 Jun 2026 06:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780555147; cv=none; b=fpF0iNiBQyy785L9/JD+4FJXtQXWN1XVw91oldAXcZMP3iNV/MwrwxuVRM0Is9ezqrFXwP97Yp54E7tgl29vgvOiZNdcW+jlfC3SypXGUzNve159d/KH567MpxElnckJflAeLYOMZRPiGweFNchukdGTSAIe9m8hZ9SCCHclVQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780555147; c=relaxed/simple;
	bh=Q3kfYZcW46bIW2qT9/sECH6OUd2HM8vIk9lN8nGlVyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qTYNabGzsbffrFuDdv1oStMzxyoEembPLSgEM4eY0iUu4Y7YacPKQWU2+QcAI98Q0eVEjbZkKEumE+o4G1mWS1k6hQK5CrXWmACVWdxuoTnQDp20LV6b3LLTfH051l/UQFCInxVV+HSdyouGPmo8PEibiKnQDYvqX33TZZiK49E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MuTArgOa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MuTArgOa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E59A51F00898;
	Thu,  4 Jun 2026 06:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780555145;
	bh=WLdC8e8Fm2aLuCMzw+PgROgwxwX557EDKd0kldTccfY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MuTArgOaGxQO9WrRyEGEODVqsMU90ByCDy5piGLiX9dCztcLlse5az1k3PWXiaCzh
	 tLTJJ8MDuy/PFqfVtHdz7K1gwLwSb7IuT8lJw55B7N2O3ChmLUyL2SJ0DXKMEh+w6R
	 QcJ4DQFBIo6d7fktvz4v7ec8EZubDL7rKnOTY/aPpTpuKmZozqKFgFTfOiF2Wo+asF
	 rCnhPc5RxgDk3ft/50su5NHZq6L1fd4KIvotgo4BYSfLMLVrtJeXOe4soemlUgmZko
	 Rd/rh53xCSjfrEtYxZTS3FXULPNWOoWzQYluVMOEqdnak+0x21Ii4ca47KfTTNi4fG
	 8xfZanVgtzDJQ==
Received: from johan by xi.lan with local (Exim 4.99.3)
	(envelope-from <johan@kernel.org>)
	id 1wV1jL-0000000AtB0-35vG;
	Thu, 04 Jun 2026 08:39:03 +0200
From: Johan Hovold <johan@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH v4 5/5] Bluetooth: btusb: clean up probe error handling
Date: Thu,  4 Jun 2026 08:37:40 +0200
Message-ID: <20260604063740.2595260-6-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260604063740.2595260-1-johan@kernel.org>
References: <20260604063740.2595260-1-johan@kernel.org>
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
index 9d2e5a8dcf85..b91966ec914f 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4100,10 +4100,8 @@ static int btusb_probe(struct usb_interface *intf,
 
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
@@ -4159,8 +4157,8 @@ static int btusb_probe(struct usb_interface *intf,
 
 	hdev = hci_alloc_dev_priv(priv_size);
 	if (!hdev) {
-		kfree(data);
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto err_free_data;
 	}
 
 	hdev->bus = HCI_USB;
@@ -4174,7 +4172,7 @@ static int btusb_probe(struct usb_interface *intf,
 					GPIOD_OUT_LOW);
 	if (IS_ERR(reset_gpio)) {
 		err = PTR_ERR(reset_gpio);
-		goto out_free_dev;
+		goto err_free_hdev;
 	} else if (reset_gpio) {
 		data->reset_gpio = reset_gpio;
 	}
@@ -4189,7 +4187,7 @@ static int btusb_probe(struct usb_interface *intf,
 
 	err = btusb_config_oob_wake(hdev);
 	if (err)
-		goto out_free_dev;
+		goto err_put_reset;
 
 	/* Marvell devices may need a specific chip configuration */
 	if (id->driver_info & BTUSB_MARVELL && data->oob_wake_irq) {
@@ -4446,11 +4444,14 @@ static int btusb_probe(struct usb_interface *intf,
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

