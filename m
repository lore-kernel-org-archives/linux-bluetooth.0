Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D902E388E76;
	Thu,  2 Apr 2026 09:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775122053; cv=none; b=M3YG8n373OJN/+DculiaKVl2/mWepYpMqNRE4I0TyEGQdWnnf2314xd0q5oKTIv2I4pYv3nVWPokeIFuiz+Ouw/obonnpqcpodh9S4VabhroVI1W8GJjPQTjQeW4wWhTZPVzOTFdGxtxGPZOlfOljs+t79ZWfFZeipc5pxV4Kwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775122053; c=relaxed/simple;
	bh=zq0jQHD/gI2al+Mu/lC9PtgXBd21pPA9ncMSg1zf5HQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gX2Xp70oXzo+fv+Izoi7A160kmI5A7Ypa+3sAHJQGiet7ZOtQMD9/DSK/3ZUUUFGKvbfIT3lA1iCID1m3RFuVnYWPv0ZOxyzCV3ACEwHvMcbZ2yV8Np1cnrcalQQYJd8+r7VSBE7DDpbPqwP07yngZbO3+lxrC91VMGk/zI6oqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HCCsQ/2G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HCCsQ/2G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63A67C116C6;
	Thu,  2 Apr 2026 09:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775122052;
	bh=zq0jQHD/gI2al+Mu/lC9PtgXBd21pPA9ncMSg1zf5HQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HCCsQ/2GAK3RmWjytZGlgLVgNZnFQAL6Q2cXg3zo0tYho3lJZme8Ubv6lXrHvUvL5
	 J6guPkjhO0BZfF3Eo6ZiXYhHAxpsNE6L9b+MxZnUdCBinsmyyiDQYUaaK7DEB+Nkmv
	 YUQbvvl9rvvVCOPSgyO3/HEpxdJpT8IlL6Hy7SXeuxLccZ5RK7eClZ+HzSKT0iKYFn
	 xQaWz86QR6xYKVnhYopVCB2NaSVQ42hvLnzI1zivXiGXyxWwO0gvTTFDJ05ss2a4/7
	 FkMWc49zHxsTdL3XkLH3vVOUdeF4wsuVWAe4cwfG5EJn6R82mGMQHWRKydnQ2sg5uM
	 bhpkQ/8T6IIFQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w8EKo-00000009qUp-0Hnq;
	Thu, 02 Apr 2026 11:27:30 +0200
From: Johan Hovold <johan@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	Rajat Jain <rajatja@google.com>
Subject: [PATCH v2 2/3] Bluetooth: btusb: fix wakeup irq devres lifetime
Date: Thu,  2 Apr 2026 11:27:03 +0200
Message-ID: <20260402092704.2346710-3-johan@kernel.org>
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

The OOB wakeup irq is device managed but its lifetime is incorrectly
tied to the child HCI device rather than the USB interface to which the
driver is bound.

This should not cause any trouble currently as the interrupt will be
disabled when the HCI device is deregistered on disconnect (but this was
not always the case, see [1]), and there should be no further references
if probe fails before registering it. But it is still technically wrong
as the reference counted HCI device could in theory remain after a probe
failure.

Explicitly free the interrupt on disconnect so that it is guaranteed to
be disabled before freeing the (non-managed) driver data (including if
disconnected while suspended).

[1] 699fb50d9903 ("drivers: base: Free devm resources when unregistering
                   a device")

Fixes: fd913ef7ce61 ("Bluetooth: btusb: Add out-of-band wakeup support")
Cc: Rajat Jain <rajatja@google.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/bluetooth/btusb.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 9e4390ba82ba..0001477463a3 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3784,8 +3784,7 @@ static int btusb_config_oob_wake(struct hci_dev *hdev)
 	}
 
 	irq_set_status_flags(irq, IRQ_NOAUTOEN);
-	ret = devm_request_irq(&hdev->dev, irq, btusb_oob_wake_handler,
-			       0, "OOB Wake-on-BT", data);
+	ret = request_irq(irq, btusb_oob_wake_handler, 0, "OOB Wake-on-BT", data);
 	if (ret) {
 		bt_dev_err(hdev, "%s: IRQ request failed", __func__);
 		return ret;
@@ -3794,12 +3793,18 @@ static int btusb_config_oob_wake(struct hci_dev *hdev)
 	ret = device_init_wakeup(dev, true);
 	if (ret) {
 		bt_dev_err(hdev, "%s: failed to init_wakeup", __func__);
-		return ret;
+		goto err_free_irq;
 	}
 
 	data->oob_wake_irq = irq;
 	bt_dev_info(hdev, "OOB Wake-on-BT configured at IRQ %u", irq);
+
 	return 0;
+
+err_free_irq:
+	free_irq(irq, data);
+
+	return ret;
 }
 #endif
 
@@ -4382,8 +4387,10 @@ static int btusb_probe(struct usb_interface *intf,
 	return 0;
 
 err_disable_wakeup:
-	if (data->oob_wake_irq)
+	if (data->oob_wake_irq) {
 		device_init_wakeup(&data->udev->dev, false);
+		free_irq(data->oob_wake_irq, data);
+	}
 out_free_dev:
 	if (data->reset_gpio)
 		gpiod_put(data->reset_gpio);
@@ -4416,8 +4423,11 @@ static void btusb_disconnect(struct usb_interface *intf)
 
 	hci_unregister_dev(hdev);
 
-	if (data->oob_wake_irq)
+	if (data->oob_wake_irq) {
 		device_init_wakeup(&data->udev->dev, false);
+		free_irq(data->oob_wake_irq, data);
+	}
+
 	if (data->reset_gpio)
 		gpiod_put(data->reset_gpio);
 
-- 
2.52.0

