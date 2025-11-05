Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A51301038
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Nov 2025 17:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762362308; cv=none; b=aFsT//ttas9NW08yZrwe1NYidLydYucOlMxaG3oeRSlUjHIeiBcSrJKVsmhgv86vs8fXNmTzvLBr3s1arF07bVbcqbV1xXR/U+6DrzsVp7fhKSOh8iGaTxNsThWviZPrgz8kX0MEwFdOJcdLO4rAglsVcNWqH1iQEDmxw5U9vng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762362308; c=relaxed/simple;
	bh=FTppKrDu+YI3UiPAHx5ZdIQHZAVzSOqclFrftSevEmM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F0tmTDbgZlQCiR/lMSe7s9WSpFXqVmek5pLxSLYNVGHM9Rl2bM/U7ml0tgWHqyf3arJzxZZD8SEHVT6RCnDP47a8MF6kBAo1lAlR3sIU+x8zJAKxILeSRowaVdv1/w7hr/9icY80dlxJHIZNYeQDGpJGmYjvFUJkTemmSBS/eyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OajfvuC8; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OajfvuC8"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-5dbd150efe8so44986137.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Nov 2025 09:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762362303; x=1762967103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OK/v0cAHbaQXhfeiqh5D2wAzLxI9qoUQWYAF8SmAoj8=;
        b=OajfvuC8XC+vXQIUpk5nyA1t9gBlRjSqiZKajcqPcPGKSOBzOlU5G2gYAPgE9lI51/
         TZmoMGQ474ep4lGa0VWg25nmTjVrbfc9OincuxpG5vS0n5XQKaCGL2/2FBPq1V8+zrJt
         iKBUFSQra26c1JkBY9Jt2GmQwAKpZkHrLpeatT1eRRbUHXPorkmr3bv4vLu51g4yGI/L
         0ufv2mNSOwHAgO+wv+eoIxthUrUy5MeFBQL3oL9C75pnLkQsEkrBl6p3dIJlhW6SYu8W
         Nf6Ij27N5EqjIb23H2KLvFgev48AwnwM/6lhPVYGrZ172TcF0GyeyNZcHd3jQAlspff/
         rAaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762362303; x=1762967103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OK/v0cAHbaQXhfeiqh5D2wAzLxI9qoUQWYAF8SmAoj8=;
        b=n4GJbS0M6hgX5WXsOX521mvukny6i02K9ZUm6jpZQMu3wtVaVfoBReBB4f6ccS9rHv
         wEge52LR4gVdixnwgA1G/gj0+CGphceZXNo/9vkrskrM+qx0tYRvngNb1z3UcPZikQUP
         dTuUbAVW8ekAvlIKFJjp3cc29dEq62HKi+FbBoth3xhy27fPT4oIDXa9spwZpCZJwL33
         Pn62PLCvQvGC1unKNnY+9iDi4+l6Jvtfw1yU3ji1ggALh0ftce2QgGj7+ccbVLaYNIS1
         pGNrJUFKaX+lBd97xnlSkcT6wiUij1l4AkCVwkw4frorHo7iOFrFdvIX9IlHx0VoiF5w
         KSjQ==
X-Gm-Message-State: AOJu0Yy3F1e8kfHbbc6jc0rTfn7uOzofn79Y1Q3CpmwxTA0bBTedNkzN
	7xmDmEHfap5Qji4riQhK+Ti+grqti3AVaTODbIQ4fNyKMQerdctUH05FzqiM/aN00ms=
X-Gm-Gg: ASbGnct/ZKzoHlZA2YMKiCme88kx3ILBHFpBZEqei7kZedHePb0b5kIkIJ2Yep3lYDj
	frvFiZgBVxqsv8UfuHrMiCfQ9lSAjGc67iREx8+ZEKTd//tL2jqznVKDihBfSV5GVnonfqhBHQc
	YQ5ZlAVxDENuMlYeQuMrElPjuKNZBTpNsl1AxpMy7pUE0LQpTXabx7mpVRkQRQnM8g25dn9M1cR
	cwayWZsslCipksWhaxvDUFVgihDx7ahOmii/rEJMKojT3f423QgvOh0+WGxo/7X4pYvKbXNGzo4
	Ypj3zi5eNT4CmxF/aePQY2Cydpf0rmH8hKdGB7pIlBWmFCKLKd5v9PmIe4o25EBexOZKQg4QjpT
	mCIJcpphftC0f3L1StxyhVaVczTI9MzlZKsIxC9kzDTp2t+0ecS+P6IfKKRTCYgcqySCrTUVy2c
	XaXrA=
X-Google-Smtp-Source: AGHT+IHYC4xZKimcnr/YvKCDx0vlk3XlXphgrBfT5rX9YWpF9jqLiUYHXx6/y5A5cc8r9xkJBRTIAw==
X-Received: by 2002:a05:6102:c53:b0:5d5:f6ae:38d8 with SMTP id ada2fe7eead31-5dd892cc398mr1270313137.45.1762362299367;
        Wed, 05 Nov 2025 09:04:59 -0800 (PST)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5dd9f665523sm100099137.6.2025.11.05.09.04.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 09:04:58 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 2/2] Bluetooth: btusb: Add support for Bulk Serialization Mode
Date: Wed,  5 Nov 2025 12:04:45 -0500
Message-ID: <20251105170445.518320-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251105170445.518320-1-luiz.dentz@gmail.com>
References: <20251105170445.518320-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for Bulk Serialization Mode introduced in 6.2:

https://www.bluetooth.com/bluetooth-core-6-2-feature-overview/#5-bluetooth-hci-usb-le-isochronous-support
https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTML/Core-62/out/en/host-controller-interface/usb-transport-layer.html#UUID-c1a65395-29e9-87d3-2981-8bed625d0459

It works by detecting if alternate setting 1 is supported for the
interface and then switches to use it as it serializes all the frames
in a single Bulk endpoint using H4 headers and it considerable more
robust then legacy one while allowing the transport of ISO packets:

 'In addition to enabling Bluetooth® LE Audio, the new mode resolves a
 persistent race condition in the legacy USB transport layer. In Legacy
 Mode, different endpoint types are serviced in a specific order within
 a USB frame, which can result in out-of-order delivery of data and
 events. For example, a Host might receive a data packet before the
 event signaling its arrival. This behavior can disrupt critical
 processes such as connection setup, disconnection, and data encryption,
 adversely affecting the user experience.'

Signed-off-by: Johann Fischer <johann.fischer@nordicsemi.no>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/btusb.c | 142 +++++++++++++++++++++++++++-----------
 1 file changed, 102 insertions(+), 40 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index dcbff764122f..e565f598b923 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -27,8 +27,9 @@
 #include "btbcm.h"
 #include "btrtl.h"
 #include "btmtk.h"
+#include "hci_uart.h"
 
-#define VERSION "0.8"
+#define VERSION "1.0"
 
 static bool disable_scofix;
 static bool force_scofix;
@@ -896,6 +897,9 @@ struct qca_dump_info {
 #define BTUSB_ALT6_CONTINUOUS_TX	16
 #define BTUSB_HW_SSR_ACTIVE	17
 
+#define BTUSB_PROTO_LEGACY	0x00
+#define BTUSB_PROTO_H4		0x01
+
 struct btusb_data {
 	struct hci_dev       *hdev;
 	struct usb_device    *udev;
@@ -929,6 +933,7 @@ struct btusb_data {
 	struct sk_buff *evt_skb;
 	struct sk_buff *acl_skb;
 	struct sk_buff *sco_skb;
+	struct sk_buff *rx_skb;
 
 	struct usb_endpoint_descriptor *intr_ep;
 	struct usb_endpoint_descriptor *bulk_tx_ep;
@@ -942,6 +947,7 @@ struct btusb_data {
 
 	__u8 cmdreq_type;
 	__u8 cmdreq;
+	__u8 proto;
 
 	unsigned int sco_num;
 	unsigned int air_mode;
@@ -1265,12 +1271,35 @@ static int btusb_recv_acl(struct btusb_data *data, struct sk_buff *skb)
 	return 0;
 }
 
+static const struct h4_recv_pkt btusb_recv_pkts[] = {
+	{ H4_RECV_ACL,          .recv = hci_recv_frame },
+	{ H4_RECV_SCO,          .recv = hci_recv_frame },
+	{ H4_RECV_EVENT,        .recv = hci_recv_frame },
+	{ H4_RECV_ISO,          .recv = hci_recv_frame },
+};
+
+static int btusb_recv_h4(struct btusb_data *data, void *buffer, int count)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&data->rxlock, flags);
+	data->rx_skb = h4_recv_skb(data->hdev, NULL, NULL, data->rx_skb, buffer,
+				   count, btusb_recv_pkts,
+				   ARRAY_SIZE(btusb_recv_pkts));
+	spin_unlock_irqrestore(&data->rxlock, flags);
+
+	return 0;
+}
+
 static int btusb_recv_bulk(struct btusb_data *data, void *buffer, int count)
 {
 	struct sk_buff *skb;
 	unsigned long flags;
 	int err = 0;
 
+	if (data->proto == BTUSB_PROTO_H4)
+		return btusb_recv_h4(data, buffer, count);
+
 	spin_lock_irqsave(&data->rxlock, flags);
 	skb = data->acl_skb;
 
@@ -1950,12 +1979,14 @@ static int btusb_open(struct hci_dev *hdev)
 
 	data->intf->needs_remote_wakeup = 1;
 
-	if (test_and_set_bit(BTUSB_INTR_RUNNING, &data->flags))
-		goto done;
+	if (data->proto == BTUSB_PROTO_LEGACY) {
+		if (test_and_set_bit(BTUSB_INTR_RUNNING, &data->flags))
+			goto done;
 
-	err = btusb_submit_intr_urb(hdev, GFP_KERNEL);
-	if (err < 0)
-		goto failed;
+		err = btusb_submit_intr_urb(hdev, GFP_KERNEL);
+		if (err < 0)
+			goto failed;
+	}
 
 	err = btusb_submit_bulk_urb(hdev, GFP_KERNEL);
 	if (err < 0) {
@@ -2045,6 +2076,34 @@ static int btusb_flush(struct hci_dev *hdev)
 	return 0;
 }
 
+static struct urb *alloc_bulk_urb(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct btusb_data *data = hci_get_drvdata(hdev);
+	struct urb *urb;
+	unsigned int pipe;
+
+	if (!data->bulk_tx_ep)
+		return ERR_PTR(-ENODEV);
+
+	urb = usb_alloc_urb(0, GFP_KERNEL);
+	if (!urb)
+		return ERR_PTR(-ENOMEM);
+
+	pipe = usb_sndbulkpipe(data->udev, data->bulk_tx_ep->bEndpointAddress);
+
+	if (data->proto == BTUSB_PROTO_H4) {
+		/* Prepend skb with frame type */
+		memcpy(skb_push(skb, 1), &hci_skb_pkt_type(skb), 1);
+	}
+
+	usb_fill_bulk_urb(urb, data->udev, pipe,
+			  skb->data, skb->len, btusb_tx_complete, skb);
+
+	skb->dev = (void *)hdev;
+
+	return urb;
+}
+
 static struct urb *alloc_ctrl_urb(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
@@ -2052,6 +2111,9 @@ static struct urb *alloc_ctrl_urb(struct hci_dev *hdev, struct sk_buff *skb)
 	struct urb *urb;
 	unsigned int pipe;
 
+	if (data->proto == BTUSB_PROTO_H4)
+		return alloc_bulk_urb(hdev, skb);
+
 	urb = usb_alloc_urb(0, GFP_KERNEL);
 	if (!urb)
 		return ERR_PTR(-ENOMEM);
@@ -2078,35 +2140,15 @@ static struct urb *alloc_ctrl_urb(struct hci_dev *hdev, struct sk_buff *skb)
 	return urb;
 }
 
-static struct urb *alloc_bulk_urb(struct hci_dev *hdev, struct sk_buff *skb)
-{
-	struct btusb_data *data = hci_get_drvdata(hdev);
-	struct urb *urb;
-	unsigned int pipe;
-
-	if (!data->bulk_tx_ep)
-		return ERR_PTR(-ENODEV);
-
-	urb = usb_alloc_urb(0, GFP_KERNEL);
-	if (!urb)
-		return ERR_PTR(-ENOMEM);
-
-	pipe = usb_sndbulkpipe(data->udev, data->bulk_tx_ep->bEndpointAddress);
-
-	usb_fill_bulk_urb(urb, data->udev, pipe,
-			  skb->data, skb->len, btusb_tx_complete, skb);
-
-	skb->dev = (void *)hdev;
-
-	return urb;
-}
-
 static struct urb *alloc_isoc_urb(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
 	struct urb *urb;
 	unsigned int pipe;
 
+	if (data->proto == BTUSB_PROTO_H4)
+		return alloc_bulk_urb(hdev, skb);
+
 	if (!data->isoc_tx_ep)
 		return ERR_PTR(-ENODEV);
 
@@ -2320,10 +2362,9 @@ static int btusb_switch_alt_setting(struct hci_dev *hdev, int new_alts)
 	return 0;
 }
 
-static struct usb_host_interface *btusb_find_altsetting(struct btusb_data *data,
-							int alt)
+static struct usb_host_interface *
+btusb_find_altsetting(struct usb_interface *intf, int alt)
 {
-	struct usb_interface *intf = data->isoc;
 	int i;
 
 	BT_DBG("Looking for Alt no :%d", alt);
@@ -2376,9 +2417,9 @@ static void btusb_work(struct work_struct *work)
 			 * MTU >= 3 (packets) * 25 (size) - 3 (headers) = 72
 			 * see also Core spec 5, vol 4, B 2.1.1 & Table 2.1.
 			 */
-			if (btusb_find_altsetting(data, 6))
+			if (btusb_find_altsetting(data->isoc, 6))
 				new_alts = 6;
-			else if (btusb_find_altsetting(data, 3) &&
+			else if (btusb_find_altsetting(data->isoc, 3) &&
 				 hdev->sco_mtu >= 72 &&
 				 test_bit(BTUSB_USE_ALT3_FOR_WBS, &data->flags))
 				new_alts = 3;
@@ -3827,8 +3868,11 @@ static ssize_t force_poll_sync_write(struct file *file,
 	if (err)
 		return err;
 
-	/* Only allow changes while the adapter is down */
-	if (test_bit(HCI_UP, &data->hdev->flags))
+	/* Only allow changes while the adapter is down and it is using legacy
+	 * protocol.
+	 */
+	if (test_bit(HCI_UP, &data->hdev->flags) ||
+	    data->proto != BTUSB_PROTO_LEGACY)
 		return -EPERM;
 
 	if (data->poll_sync == enable)
@@ -3927,7 +3971,7 @@ static int btusb_hci_drv_supported_altsettings(struct hci_dev *hdev, void *data,
 		goto done;
 
 	for (i = 0; i <= 6; i++) {
-		if (btusb_find_altsetting(drvdata, i))
+		if (btusb_find_altsetting(drvdata->isoc, i))
 			rp->altsettings[rp->num++] = i;
 	}
 
@@ -4022,6 +4066,15 @@ static int btusb_probe(struct usb_interface *intf,
 	if (!data)
 		return -ENOMEM;
 
+	/* If alternate setting 1 is found, it means H4 mode is supported */
+	if (btusb_find_altsetting(intf, 1)) {
+		struct usb_device *udev = interface_to_usbdev(intf);
+
+		err = usb_set_interface(udev, ifnum_base, 1);
+		if (!err)
+			data->proto = BTUSB_PROTO_H4;
+	}
+
 	for (i = 0; i < intf->cur_altsetting->desc.bNumEndpoints; i++) {
 		ep_desc = &intf->cur_altsetting->endpoint[i].desc;
 
@@ -4041,8 +4094,16 @@ static int btusb_probe(struct usb_interface *intf,
 		}
 	}
 
-	if (!data->intr_ep || !data->bulk_tx_ep || !data->bulk_rx_ep)
-		return -ENODEV;
+	/* Check if all endpoints could be enumerated, legacy mode requires
+	 * interrupt and bulk endpoint while H4 mode only requires bulk
+	 * endpoints.
+	 */
+	if ((data->proto == BTUSB_PROTO_LEGACY && !data->intr_ep) ||
+	    !data->bulk_tx_ep || !data->bulk_rx_ep) {
+		BT_ERR("failed to enumerate endpoints");
+		err = -ENODEV;
+		goto out_free_dev;
+	}
 
 	if (id->driver_info & BTUSB_AMP) {
 		data->cmdreq_type = USB_TYPE_CLASS | 0x01;
@@ -4355,7 +4416,8 @@ static int btusb_probe(struct usb_interface *intf,
 	if (enable_autosuspend)
 		usb_enable_autosuspend(data->udev);
 
-	data->poll_sync = enable_poll_sync;
+	if (data->proto == BTUSB_PROTO_LEGACY)
+		data->poll_sync = enable_poll_sync;
 
 	err = hci_register_dev(hdev);
 	if (err < 0)
-- 
2.51.0

