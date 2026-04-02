Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDAE3E1CE0;
	Thu,  2 Apr 2026 15:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775144989; cv=none; b=FmuumLC2Qb7GxseA0TrfENo+NWeSeWld0wQJGRKRpcoavqY90zvvzoSxVYDaD8CPcT9PBjFPA+nllK605cCZfUbVe6kqmq2P3teL04v2Gw+i0Dhd7lBn5DM4j0M9S8XTBInPOs0Ce+D6gZTtWagCupCRE+1kS7xpd6+b07KgRWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775144989; c=relaxed/simple;
	bh=9dJNGOci2T1uYQXSXxoyli4dP9j6zsXiSaDLyLrKXXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NyOe4wTdmjQokg0R5e88qb3305oH9eD4sYThwLxlfffFO2bTTPF38COSkdv4HGudk6R+pK4eVzhBVDwHx1PrpqwHo7S7oLtLWcy2CkAeI1cBrOh/C1NnmSNLWlLS9+FOD9iXLp7oeQtHWNfy16xmkQQ9koDoVi62FCcQhGgrIY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ehE6p5O7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ehE6p5O7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9B14C2BC9E;
	Thu,  2 Apr 2026 15:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775144988;
	bh=9dJNGOci2T1uYQXSXxoyli4dP9j6zsXiSaDLyLrKXXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ehE6p5O78i2PNAhuC7ukdpSMMbHQPm4RW+Z2wAL3Odi+6TNv+j1FL7yyadybTbsMo
	 8pNnSazlO/XiG7aeNdonOsDx3ix/e0VVaVIHExfrPiqU6A5gZefOKwdFOfA1lcBDaN
	 9WNAuinWjt2j56D2WEgeLqgAFc3/FxcZ20y8VHLfBMWpMdonCfAXmVgbbRE61aXerj
	 WmoRUhcPW2h6Gj0h+w88lFjf/6mPpgfjs+1+CSzvpaj9uel0m7bui4ECS5V//NlWZM
	 L267eEKIzX31sorfj+KWC6WadtXrhJ6TfjvLMcD9jL8ElndCE/zuRzYN0uWpKjbSK+
	 ZejbLV05vkYTA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w8KIk-0000000ALvU-2CIh;
	Thu, 02 Apr 2026 17:49:46 +0200
From: Johan Hovold <johan@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	Rajat Jain <rajatja@google.com>
Subject: [PATCH v3 4/5] Bluetooth: btusb: fix wakeup irq devres lifetime
Date: Thu,  2 Apr 2026 17:48:09 +0200
Message-ID: <20260402154810.2467291-5-johan@kernel.org>
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
index cb0d40a7af8f..04fed3d146ef 100644
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
 
@@ -4393,8 +4398,10 @@ static int btusb_probe(struct usb_interface *intf,
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
@@ -4427,8 +4434,11 @@ static void btusb_disconnect(struct usb_interface *intf)
 
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

