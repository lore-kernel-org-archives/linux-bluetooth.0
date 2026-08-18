Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB575367B9C;
	Tue, 18 Aug 2026 03:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787022050; cv=none; b=uhy2MSDr8yjOXPJaZyRSSZ6uzU0lFt+8q9qeQ2lFUwHuDvPG8+uhw8ntoGwoI+3Ayjq/3ZrrBPF5c2mzbjLZBHMslWiEK7Bb4XqSUvOldqx7JTw9i5SIdGlEcYzev+R2rcIwVBDwQ3gBn+16wPtMWUfkbPfY5qbmclPkp2YXLKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787022050; c=relaxed/simple;
	bh=g9XLW7UcPt4/hTN4AzgZ6uktrVB634M81KfTlI/jUrQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rtlVDEsBX3vIJqhAXAvPbHmUHiU8/Ka2sD+c3UmjFPntQntiX08oylX4mIEbfQq3RA5s8+Wzl9i529wPiW8eNQ72V+GepU9792MPhWrtf5mZV7A8Zgjrjc23Mi+dInSxoo8wPTewso/QNOTLkY5Hh7BjOZ59zbPitZPc0mE5ryY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GT3BHGwJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GT3BHGwJ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AE45CC2BCF7;
	Tue, 18 Aug 2026 03:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787022049;
	bh=g9XLW7UcPt4/hTN4AzgZ6uktrVB634M81KfTlI/jUrQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=GT3BHGwJcRE+rSKnyl9h38PSZ9/V/9N1HTB7vSsnRb3fFkE7cZne/UpF9SmLOOmSD
	 okKywtALR5KS3KJPR9X9+D7eVLf8O2KWZGS/Cns/MAE5IJpz0yfBDtq+sqsVR1FiRu
	 adqMqLe3VevTagLZHbXMS/jCwKhm3hJRKQZmlGEj96tN+GzSO81zK6VyQYs3ftgniP
	 SYpd1BSPjHD8IJ5MplqAnlWbazISOC+p78oee5ZNELGggCYZ+4jqDNXFfdeudqiNjO
	 A5DutE7hSnVbtoq+2uruQVkWmL/ShfpYmYAxttTLcw+V68J4UyWHumJaOy6tsRMGAh
	 V+peLn0oDg0FA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 999F6C5B572;
	Tue, 18 Aug 2026 03:00:49 +0000 (UTC)
From: George Maraveyas via B4 Relay <devnull+george.0xfff.gmail.com@kernel.org>
Date: Tue, 18 Aug 2026 04:55:20 +0200
Subject: [PATCH RFC 1/2] USB: core: add helper to queue device
 re-enumeration
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-mt7925-rfc-v1-1-284d856ac572@gmail.com>
References: <20260818-mt7925-rfc-v1-0-284d856ac572@gmail.com>
In-Reply-To: <20260818-mt7925-rfc-v1-0-284d856ac572@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-bluetooth@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 George Maraveyas <george.0xfff@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787022047; l=4731;
 i=george.0xfff@gmail.com; s=20260818; h=from:subject:message-id;
 bh=LhOMiuJkFZB8vjWmzvqH/IlXANYNGRaUBImp9cDEvUE=;
 b=QuWR3tLnrOCzrGaSnaIZkR2uHdWvmptm5sTiiiAiW3Eep00puYXgmpwDeEBL9c9CKl1b75KBC
 ehFm4F+ABGyBF/fFA7duWiUvyBMr/772ri2HcsUGsMGoXN3epiLdcpR
X-Developer-Key: i=george.0xfff@gmail.com; a=ed25519;
 pk=Jz8kMnumjUlo1GJvJ5kdfkF3ZP8DjPbYaYQR5J8IHMI=
X-Endpoint-Received: by B4 Relay for george.0xfff@gmail.com/20260818 with
 auth_id=960
X-Original-From: George Maraveyas <george.0xfff@gmail.com>
Reply-To: george.0xfff@gmail.com

From: George Maraveyas <george.0xfff@gmail.com>

USB drivers can use usb_queue_reset_device() when they need USB core to
reset an already enumerated device asynchronously.

There is currently no driver-facing helper corresponding to
usb_queue_reset_device() which allows an interface driver to ask USB core
to remove the current usb_device and enumerate the physical device on the
port again.

The difference between the two is that a device reset continues using the
existing usb_device and its current enumeration state while
re-enumeration removes the existing usb_device and returns the port to
the hub code, which then discovers the device again through the normal
USB enumeration path.

Add usb_queue_reenumerate_device() to provide this facility.

The helper queues a logical disconnect on the parent hub port.
hub_port_logical_disconnect() disables the port, records a logical
connect-change event and queues the hub work.  The hub work later
disconnects the existing usb_device and, if the physical device remains
connected, attempts to enumerate it again through the normal hub path.

Any retries or port recovery required during the subsequent enumeration
remain the responsibility of the existing hub code.

usb_remove_device() cannot provide the same behaviour because it also
marks the port in removed_bits.  The hub connection path does not
enumerate a device on a port while that bit remains set.

The helper takes the device lock required by usb_hub_to_struct_hub() and
holds a runtime-PM reference on the parent hub interface while the
logical disconnect is queued.

The helper does not decide when re-enumeration is needed.  That decision
remains with the calling driver.

The following MT7925 Bluetooth patch is the first user of the helper.  It
requests re-enumeration after the controller has already enumerated
successfully but later fails during Bluetooth setup and cannot be
recovered by its existing reset path.

Signed-off-by: George Maraveyas <george.0xfff@gmail.com>
---
 drivers/usb/core/hub.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/usb.h    |  1 +
 2 files changed, 55 insertions(+)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index fcac92bd7..22279d438 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -6503,6 +6503,60 @@ void usb_queue_reset_device(struct usb_interface *iface)
 }
 EXPORT_SYMBOL_GPL(usb_queue_reset_device);
 
+/**
+ * usb_queue_reenumerate_device - queue logical disconnect and re-enumeration
+ * @iface: USB interface belonging to the device to re-enumerate
+ *
+ * Request that USB core logically disconnect the device and subsequently
+ * re-enumerate its parent hub port.  The actual device teardown and
+ * re-enumeration are handled asynchronously by the hub workqueue.
+ *
+ * This is intended for failures where resetting the existing usb_device is
+ * insufficient and the driver needs USB core to perform a full logical
+ * disconnect/re-enumeration cycle.
+ *
+ * Return: 0 if re-enumeration was queued successfully, or a negative error
+ * code otherwise.
+ */
+int usb_queue_reenumerate_device(struct usb_interface *iface)
+{
+	struct usb_device *udev = interface_to_usbdev(iface);
+	struct usb_interface *hub_intf;
+	struct usb_hub *hub;
+	int ret;
+
+	usb_lock_device(udev);
+
+	if (!udev->parent || udev->state == USB_STATE_NOTATTACHED) {
+		ret = -ENODEV;
+		goto out_unlock;
+	}
+
+	/*
+	 * usb_hub_to_struct_hub() requires either the hub or one of its
+	 * children to be locked.  @udev is locked above.
+	 */
+	hub = usb_hub_to_struct_hub(udev->parent);
+	if (!hub) {
+		ret = -ENODEV;
+		goto out_unlock;
+	}
+
+	hub_intf = to_usb_interface(hub->intfdev);
+	ret = usb_autopm_get_interface(hub_intf);
+	if (ret < 0)
+		goto out_unlock;
+
+	hub_port_logical_disconnect(hub, udev->portnum);
+	usb_autopm_put_interface(hub_intf);
+	ret = 0;
+
+out_unlock:
+	usb_unlock_device(udev);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(usb_queue_reenumerate_device);
+
 /**
  * usb_hub_find_child - Get the pointer of child device
  * attached to the port which is specified by @port1.
diff --git a/include/linux/usb.h b/include/linux/usb.h
index 49ab8dbb8..9841029a2 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -789,6 +789,7 @@ extern int usb_lock_device_for_reset(struct usb_device *udev,
 /* USB port reset for device reinitialization */
 extern int usb_reset_device(struct usb_device *dev);
 extern void usb_queue_reset_device(struct usb_interface *dev);
+int usb_queue_reenumerate_device(struct usb_interface *iface);
 
 extern struct device *usb_intf_get_dma_device(struct usb_interface *intf);
 

-- 
2.53.0


