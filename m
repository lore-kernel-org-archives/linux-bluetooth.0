Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A521C84DC;
	Thu,  4 Jun 2026 06:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780555147; cv=none; b=pfgd9udmgYRVoiL8v/yMURWLzUUSh+pkQl4p88wVrPO6Rd5IWtpuaa11KXiHH2RojmnjKVIQFOvBuML6b7sB+HTR0eJ/ACoCo8D/yMY6lHGoaxX0DK0krNzig6625kGqfFh2bEbC5C3jTLL/El476r2qhQdRRlY/VGwk0aTOomw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780555147; c=relaxed/simple;
	bh=vtDmusNrMao4Z6mwciC/lR4yLnLetYiSKLwA6yespiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XMY6swkjJA7Uxlk6+wRju/Lqwwj7PLIW/9modKSSNeB8gE65vc0fXVf4onyhtcs304OC5HL3kv155vrb1ufIC9TyKBE/cH0p+v5GpNH0U8531D70FTbi6+o5oRF95MO2in0bLexv7LuMI368PvhJyOQxYMpXL5VFbp+boYSEAQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JbiPzgIp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JbiPzgIp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC80A1F0089B;
	Thu,  4 Jun 2026 06:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780555146;
	bh=ejOOzNwpl1mrjW2fyUd7AnjG9O0q5KxuZVO+r1xM+sM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JbiPzgIpi2kk8l6/35uIfMNHPeZp+4o0yUPzYfTM61jOv5abVNYjdEz8ESBLjax3k
	 1CTh6sf2j7jhe6n0xT1YaJclCdOKzxQ4X4sEbu7+FI8FfXOLQzh06hftG3vVYVfHIL
	 wDL+N9t3Z0k2osJ4qPbr7kQgMmsGXNuVZuJAnf2NJnBGRrSYIWa8UcLXzel790PnOS
	 3qoIz7p5BM2s+5OJ8TcAARGQOGRBHfEDg/WZRqgHUwOPlttTInCuL2ZXG7kLffHGTt
	 mCk1yL19RkxShjtmCCRv1O3r+NUJmQ5O6pbjBFfi7e7qFqrfPj6qbfW5Yvp92YyrfD
	 f/eo+Tpo1eLCw==
Received: from johan by xi.lan with local (Exim 4.99.3)
	(envelope-from <johan@kernel.org>)
	id 1wV1jL-0000000AtAx-33Zy;
	Thu, 04 Jun 2026 08:39:03 +0200
From: Johan Hovold <johan@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	Rajat Jain <rajatja@google.com>
Subject: [PATCH v4 4/5] Bluetooth: btusb: fix wakeup irq devres lifetime
Date: Thu,  4 Jun 2026 08:37:39 +0200
Message-ID: <20260604063740.2595260-5-johan@kernel.org>
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
index 3e8c90486e4c..9d2e5a8dcf85 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3824,8 +3824,7 @@ static int btusb_config_oob_wake(struct hci_dev *hdev)
 	}
 
 	irq_set_status_flags(irq, IRQ_NOAUTOEN);
-	ret = devm_request_irq(&hdev->dev, irq, btusb_oob_wake_handler,
-			       0, "OOB Wake-on-BT", data);
+	ret = request_irq(irq, btusb_oob_wake_handler, 0, "OOB Wake-on-BT", data);
 	if (ret) {
 		bt_dev_err(hdev, "%s: IRQ request failed", __func__);
 		return ret;
@@ -3834,12 +3833,18 @@ static int btusb_config_oob_wake(struct hci_dev *hdev)
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
 #else
 static inline int btusb_config_oob_wake(struct hci_dev *hdev)
@@ -4437,8 +4442,10 @@ static int btusb_probe(struct usb_interface *intf,
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
@@ -4471,8 +4478,11 @@ static void btusb_disconnect(struct usb_interface *intf)
 
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

