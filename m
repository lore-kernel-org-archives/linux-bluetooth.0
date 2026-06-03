Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A879D47DF8F;
	Wed,  3 Jun 2026 14:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780497452; cv=none; b=re0SgESFh+eSUgQwX5hHXgp6M9LCbOxZNnMB2Y6cWeyt9fy77cW9fM9NhHUyL7nf+eauX2USNuJBm0KfPK55HCFIz3hwN19mZh9xv3BldvfHJeVuHnXe156bpg1LhKTMg+ce6ohvx3xvT3xCBHmATQEKOcBtkrpRv+IKu4cOR+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780497452; c=relaxed/simple;
	bh=ZTMs/JG5ZExpxDrRxlzy7vlto7pTpYFGaCCLhKvpUMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Insvqn/mlaPxU1+QbH+/SAl1pDIf+TYNriQKWhhRD6R9P8uqWE6EOFIQCyNTNC0i3JB1F+jjbbQT95w43BlHW0Nuw5n7EOn9OiEbkaqoosrWpDY3So44BxuBxzQjvqUlI9CKeVMwkhuAoTkLwHKcKGqw1RA60JAcqFX7tplHSXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nxyj8Ijb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nxyj8Ijb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D01F1F0089C;
	Wed,  3 Jun 2026 14:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780497449;
	bh=Y/IN4P09rZ58FdY/EKLm5RE3U4EEjJCNUePEuJlPask=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Nxyj8IjbfIQevlUFCR4+hQfJJvCdI7XzYXWvg3qY+uwd00bMgKbtsqqhvaDGsjZ1a
	 r5fIFNEcqGuHpLBts3iHoV0wFCsm80OUWeh9ZmTi/QP1NU+1VQpRP+GMpjonDaw3ee
	 XjLYuAoDARtbEP1f2A/rWxan0VFL/bAsf2CyCpctlJQBpT7fPAUPXmcR+zWFxMhRFT
	 HGbv6ze0UqaO6Tx+aHpJ1xRycvVSA5WuS0F49sC+d4I4urKjUWv2Ni2GJVlViGr1gL
	 t/fcGKipOEP8OH9jPyKKN01FLKi3yTlfyIRcPJY1IJbJ+IXgcMAWjJdJ203xhu4dqa
	 tnkMfaBY7DsUQ==
Received: from johan by xi.lan with local (Exim 4.99.3)
	(envelope-from <johan@kernel.org>)
	id 1wUmik-0000000AYB7-3BqD;
	Wed, 03 Jun 2026 16:37:26 +0200
From: Johan Hovold <johan@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	Rajat Jain <rajatja@google.com>
Subject: [PATCH v3 RESEND 4/5] Bluetooth: btusb: fix wakeup irq devres lifetime
Date: Wed,  3 Jun 2026 16:36:42 +0200
Message-ID: <20260603143643.2514595-5-johan@kernel.org>
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

The OOB wakeup interrupt is device managed but its lifetime is
incorrectly tied to the child HCI device rather than the USB interface
to which the driver is bound.

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
index 622df2fff497..450c8746bea6 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3819,8 +3819,7 @@ static int btusb_config_oob_wake(struct hci_dev *hdev)
 	}
 
 	irq_set_status_flags(irq, IRQ_NOAUTOEN);
-	ret = devm_request_irq(&hdev->dev, irq, btusb_oob_wake_handler,
-			       0, "OOB Wake-on-BT", data);
+	ret = request_irq(irq, btusb_oob_wake_handler, 0, "OOB Wake-on-BT", data);
 	if (ret) {
 		bt_dev_err(hdev, "%s: IRQ request failed", __func__);
 		return ret;
@@ -3829,12 +3828,18 @@ static int btusb_config_oob_wake(struct hci_dev *hdev)
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
 
@@ -4428,8 +4433,10 @@ static int btusb_probe(struct usb_interface *intf,
 err_kill_tx_urbs:
 	usb_kill_anchored_urbs(&data->tx_anchor);
 err_disable_wakeup:
-	if (data->oob_wake_irq)
+	if (data->oob_wake_irq) {
 		device_init_wakeup(&data->udev->dev, false);
+		free_irq(data->oob_wake_irq, data);
+	}
 out_free_dev:
 	if (data->reset_gpio)
 		gpiod_put(data->reset_gpio);
@@ -4462,8 +4469,11 @@ static void btusb_disconnect(struct usb_interface *intf)
 
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
2.53.0

