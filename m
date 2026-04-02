Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1578A3AD50A;
	Thu,  2 Apr 2026 15:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775144989; cv=none; b=OunnEPH+DeCjmvNDTD3gKYJy1PTVvBYUB2VZfLlovK02wrhXxzYJU4zywxfhjJO+6PWKwLdmuNS0i+KDiGlg3CU2bMmmdzQo/QIwDKXnaVTTR0Ia3WYrERk5KwzbZ59xA+w4dyxmHh72Ob5qIgwqqvONwc4McH4fn8hRJe9fa6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775144989; c=relaxed/simple;
	bh=rpkf5w8yDhKheG+qWK9WQyHwNrTiq9e9Px5AXhtt8cQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cl8j9R8KTyO6nxKwLu/JQpTipfZP8dmtv/+LRYz0JOe24Rzoxsr68X/e4ZfqWI7qwW8qvut3wmUOoDScYmwoZRsIITukUWuR+/4jfrswRFaS1Pwn2TrFbVk1XZwJxewoNd3v4xYlo1mJG7+ldQ/y7StMXPRKBDe/Mx2M9WqS9j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R2mMe26h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2mMe26h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C18DBC19423;
	Thu,  2 Apr 2026 15:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775144988;
	bh=rpkf5w8yDhKheG+qWK9WQyHwNrTiq9e9Px5AXhtt8cQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R2mMe26hRmy+DCCq8YV6Obefb6KwebMqsaVivZe7eXP93NQI5q2H60Svb/QxCqcla
	 C2UYsnBve7jlobSVMjGgCjcT1jiVqrNnYyIDlQEOXNUs3O/ZeYIN5DVMx99gSLD1To
	 atpyELR1QwSddr8KdznaVJicCX8ypMdmgB/bFybaGssPZbd95xVAzukdftFcHc6Ar1
	 C6Ems4xl452zBjGwOCJUEHlou9fEd15mxOKIEX6tYXEqDFeCGycPPVGnR0DWCVkOHF
	 7jplj3DyrsqlzsiMwH7wIGUxQ+KwnQ2Oz4mKo3YWlqilQRV4PJazFDKgn6ZJIZWU7x
	 w52YHtLiG0EXg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w8KIk-0000000ALvW-2Eff;
	Thu, 02 Apr 2026 17:49:46 +0200
From: Johan Hovold <johan@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH v3 5/5] Bluetooth: btusb: clean up probe error handling
Date: Thu,  2 Apr 2026 17:48:10 +0200
Message-ID: <20260402154810.2467291-6-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260402154810.2467291-1-johan@kernel.org>
References: <20260402154810.2467291-1-johan@kernel.org>
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
index 04fed3d146ef..13f757aa0bf0 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4055,10 +4055,8 @@ static int btusb_probe(struct usb_interface *intf,
 
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
@@ -4114,8 +4112,8 @@ static int btusb_probe(struct usb_interface *intf,
 
 	hdev = hci_alloc_dev_priv(priv_size);
 	if (!hdev) {
-		kfree(data);
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto err_free_data;
 	}
 
 	hdev->bus = HCI_USB;
@@ -4129,7 +4127,7 @@ static int btusb_probe(struct usb_interface *intf,
 					GPIOD_OUT_LOW);
 	if (IS_ERR(reset_gpio)) {
 		err = PTR_ERR(reset_gpio);
-		goto out_free_dev;
+		goto err_free_hdev;
 	} else if (reset_gpio) {
 		data->reset_gpio = reset_gpio;
 	}
@@ -4145,7 +4143,7 @@ static int btusb_probe(struct usb_interface *intf,
 #ifdef CONFIG_PM
 	err = btusb_config_oob_wake(hdev);
 	if (err)
-		goto out_free_dev;
+		goto err_put_reset;
 
 	/* Marvell devices may need a specific chip configuration */
 	if (id->driver_info & BTUSB_MARVELL && data->oob_wake_irq) {
@@ -4402,11 +4400,14 @@ static int btusb_probe(struct usb_interface *intf,
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
2.52.0

