Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF203939C8;
	Thu,  2 Apr 2026 09:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775122053; cv=none; b=p26oYr//bjX5fU0rGh98VdV/40yazKkqp++d54qRW2Ov0agrAga9xRxnGVTWtPI/AOErUqitlGpLnaxIkLsBFNj85r7AVkj2eoxbx6xkmU4QnkZ4/BHpFpg/w8wUsfU63rm1tIeQ8kpLARgvkn52YbFabjb1Vmd/taNcilMiCUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775122053; c=relaxed/simple;
	bh=IXIEWBIWCqof18A43cfnb86WqaIOtazyVtqjLxeWcAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bzuhrcLhzSrTEUimSNeo43ZvDHycdU8mTwgRPeLpb0uC3wHDBTAvPlWWXQ62ZSKZZ7RNuutWNMwWNExLlZHF2yT9LkKOd4gtXrITWUmz7lzZeKUyaDMAuAMptjYj47p2HKdy7Lf/optlgEYGwtH9OasH+5C5cf5GeNfnY9AAOIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8I0O2Uq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8I0O2Uq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D4D7C19423;
	Thu,  2 Apr 2026 09:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775122052;
	bh=IXIEWBIWCqof18A43cfnb86WqaIOtazyVtqjLxeWcAI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z8I0O2UqeRk2dxXGeIYM9cwNg4XDVKMi/flbHSI/ehv+wuGs/G380ccKCefHnS5h2
	 bBLBPsnh/qRTJ8wkVc+IA/t+UrqoaPzSzCm+Fj58j0/2Ykeq+2U4/PDlSACZ/9CvjB
	 GJ4ltM82anqQOW0D43hQN1I6dzaux7QWAarqGvwvRBZ8Y4O/LL2Pv5y9sHX5QHtW8n
	 H96xG/vGzjQhwv+pa7BBPMWJjx+crzsv1dann4Ae0fa3vhgxEpxdbgZjaVQofmeNji
	 SVU1LrZZJ63Yf73ml6TQ5yqxc/r9jJXisy8FCSFZlcbvrw5+P50Bp2Hx76QXAID4lY
	 BmBg5+ANhGZZw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w8EKo-00000009qUr-0KFs;
	Thu, 02 Apr 2026 11:27:30 +0200
From: Johan Hovold <johan@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 3/3] Bluetooth: btusb: clean up probe error handling
Date: Thu,  2 Apr 2026 11:27:04 +0200
Message-ID: <20260402092704.2346710-4-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260402092704.2346710-1-johan@kernel.org>
References: <20260402092704.2346710-1-johan@kernel.org>
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
index 0001477463a3..28e2a536a309 100644
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
@@ -4391,11 +4389,14 @@ static int btusb_probe(struct usb_interface *intf,
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

