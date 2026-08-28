Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF303BED75
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Aug 2026 20:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787948002; cv=none; b=S+63O6oVv4pk7uAfYEiUF3MbMflOx7r+95cAYw9p92DRRbGLcXiHQcEekLrz5UsNvs0RQcgkbX66Saltq/cdfC5eFrLdVWgWsU0O1+G4hBVHKSE5uyzWIJfIWcW/1EAqeyFFo9np4AElDMpCM1AZU5RdSlCKjmKnPYJEHi5RT3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787948002; c=relaxed/simple;
	bh=8kdbDSBUxxfZ7SJKR5qoKyN0oVuJqo39mq2j4mUi7kY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ho1/0EkKPMQqoDDtZBmQX2/k6nhbod7gCHMqD6dEIPnVS+ynWvtbvXZFYCbwxQ7p7VcXou9vpnF404YE0bEDpTHdxhPy3w/OYQ5IOVtxqAx7vzdJEq8zmRnTiSgoPXRB7nF3r92c02LeQS6eZ+0Iz25hW3fKtY8GIZveVbXDxJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lWYbj5yt; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lWYbj5yt"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5c79c9f7b54so115028e0c.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Aug 2026 13:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787947999; x=1788552799; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lXdSE08wASj0CZBV7QRRFnxe5UuZJlkoc8I2Ph8nM2c=;
        b=lWYbj5ytJT2i9+aCzH+NYfS2yR5NZwkoK0zeF+7EkiM0gw1Q+uaj+reT/UWj94z8m9
         k+6ju2MNWEGTbMECR1PE8iGFvc7drjkVq9GbOsvTkzTsa8pzNUCUrWInbbstA2udzBhy
         9af+o++dSwowD2rX2W+lC5pt+aLGsqTIjhTNGsnd41CG9VAKQ743QmcOsnAKBBa+cC50
         CIqBVtmsHxDaLpVGM010hZXaJlCK2tBbLwTi9zInkj+XdaXXtb1Ub94asBZiF39ntrmD
         RgXjIKXwAYqFxBYO7FYL/uKngrgumFWreFE12WJaHaOOa1WS++EXr4yTCQk3cP4u58YZ
         EPrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787947999; x=1788552799;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lXdSE08wASj0CZBV7QRRFnxe5UuZJlkoc8I2Ph8nM2c=;
        b=Y64nKlbcGeDugp9qunRxXVlkZ5eXa1+mHtHyBbaML+iaiSs0/kyGP07C4y0N8R3CBe
         /+8hdbgHqKjERUyQkMzhp/C94uSoIFRXQj1h+PfivYZpNSdfKj6J5pwhvrfNyGwelZKP
         qOcXl/Y3/SklBN4dP2AQN0Kxyqqj6i2BygW9QS99YuEPXW7YSISNnTP3xfKSGKPvPI20
         nnh55+H35ND+sKnUccbfuQRVyQFdwcfL91f/wV4VFdW/50IC8M8rVvLWPVGkxe8U3oD7
         pTA7ZAaqandWPvu5qCqOz0fDGQwDfMKpbvS2up4YlBbiNd/sPEzOG+jYfHgzg+lcjumB
         d+jg==
X-Gm-Message-State: AFuF++n3NzhGsQIU3M69rM+8r4qGnY3bPDC5X9bTcvD79W+mAAcnDPzC
	L1va9LkFSWBSg9bcEpdn71e6OHWDXkYNYfm84Gd0No/G4yU0KMLUcEQ8r/7nANVd/r8=
X-Gm-Gg: AR+sD10ltRPLcJlkQfVblm5prcci8+nL5aEABK6aPmT2cZlS9g+bzL/27XSgcf54bme
	+J8m7HXxrIwIOk4ugjKaIfSgqFBuGeKTwEQpupg+SJihZEKETYpT4NwAxeepUkclZlz9WRT5d1N
	Z7mdwhOzUtzKzJMV+gsiBjvuVmoM7x78SHdH084kyWoKZ47Sy8iaoikBsWJqmIl8R99f6pLEFCY
	xi/2QFK+1MBnLDlCDLjHmKBz3YphzpP9v65oJNpeVZcvttBo1nDNHc+CieH8Xr8ovk9cNc6LQ7b
	f5MiplZWY4kzwDNSh/5R9E9aNvyMmYOtPZGlB0pMZ4MmpsJTvhePKZhhCJ8+zBagZJNjd22Stmz
	aiLgl4Epjmx3IjMEovv0qmVd2bOU0i2E9C91+0DxRsSMyhurR8CmEeU7smMYYUVcReLjQu/6ZAW
	lLLPadUv3vkhhehl3hrF2HkcYMd27KJKqM95KuGp41huCFTWyPsHh+HQ8gKdZ4EoSMc8pociQdc
	JlCZLxaLv+EGlc7JXpR/5sqzasTYKZpfPUmsNrv4oQUBWc51+BnIgQ=
X-Received: by 2002:a05:6102:a4c:b0:784:b9ec:910b with SMTP id ada2fe7eead31-7859997f01cmr2940331137.12.1787947999016;
        Fri, 28 Aug 2026 13:13:19 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-97e84b6d320sm2069350241.9.2026.08.28.13.13.17
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 13:13:18 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/2] Bluetooth: btusb: Add support for Bulk Serialization Mode
Date: Fri, 28 Aug 2026 16:13:06 -0400
Message-ID: <20260828201306.593974-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260828201306.593974-1-luiz.dentz@gmail.com>
References: <20260828201306.593974-1-luiz.dentz@gmail.com>
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
 drivers/bluetooth/btusb.c | 170 +++++++++++++++++++++++++++++---------
 1 file changed, 130 insertions(+), 40 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 84614e60d142..b9c62d6acab5 100644
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
@@ -983,6 +984,9 @@ struct btqca_data {
 #define BTUSB_ALT6_CONTINUOUS_TX	16
 #define BTUSB_HW_SSR_ACTIVE	17
 
+#define BTUSB_PROTO_LEGACY	0x00
+#define BTUSB_PROTO_H4		0x01
+
 struct btusb_data {
 	struct hci_dev       *hdev;
 	struct usb_device    *udev;
@@ -1016,6 +1020,7 @@ struct btusb_data {
 	struct sk_buff *evt_skb;
 	struct sk_buff *acl_skb;
 	struct sk_buff *sco_skb;
+	struct sk_buff *rx_skb;
 
 	struct usb_endpoint_descriptor *intr_ep;
 	struct usb_endpoint_descriptor *bulk_tx_ep;
@@ -1029,6 +1034,7 @@ struct btusb_data {
 
 	__u8 cmdreq_type;
 	__u8 cmdreq;
+	__u8 proto;
 
 	unsigned int sco_num;
 	unsigned int air_mode;
@@ -1256,6 +1262,11 @@ static inline void btusb_free_frags(struct btusb_data *data)
 	dev_kfree_skb_irq(data->sco_skb);
 	data->sco_skb = NULL;
 
+	/* rx_skb may hold an ERR_PTR from a previous h4_recv_skb() call */
+	if (!IS_ERR(data->rx_skb))
+		dev_kfree_skb_irq(data->rx_skb);
+	data->rx_skb = NULL;
+
 	spin_unlock_irqrestore(&data->rxlock, flags);
 }
 
@@ -1355,12 +1366,41 @@ static int btusb_recv_acl(struct hci_dev *hdev, struct sk_buff *skb)
 	return 0;
 }
 
+/* Dispatch through the btusb_recv_* wrappers so that vendor specific
+ * handling (data->recv_event, data->recv_acl) is preserved in H:4 mode.
+ */
+static const struct h4_recv_pkt btusb_recv_pkts[] = {
+	{ H4_RECV_ACL,          .recv = btusb_recv_acl },
+	{ H4_RECV_SCO,          .recv = hci_recv_frame },
+	{ H4_RECV_EVENT,        .recv = btusb_recv_event },
+	{ H4_RECV_ISO,          .recv = hci_recv_frame },
+};
+
+static int btusb_recv_h4(struct btusb_data *data, void *buffer, int count)
+{
+	unsigned long flags;
+	int err = 0;
+
+	spin_lock_irqsave(&data->rxlock, flags);
+	data->rx_skb = h4_recv_skb(data->hdev, NULL, NULL, data->rx_skb, buffer,
+				   count, btusb_recv_pkts,
+				   ARRAY_SIZE(btusb_recv_pkts));
+	if (IS_ERR(data->rx_skb))
+		err = PTR_ERR(data->rx_skb);
+	spin_unlock_irqrestore(&data->rxlock, flags);
+
+	return err;
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
 
@@ -2038,12 +2078,14 @@ static int btusb_open(struct hci_dev *hdev)
 
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
@@ -2141,6 +2183,34 @@ static int btusb_flush(struct hci_dev *hdev)
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
@@ -2148,6 +2218,9 @@ static struct urb *alloc_ctrl_urb(struct hci_dev *hdev, struct sk_buff *skb)
 	struct urb *urb;
 	unsigned int pipe;
 
+	if (data->proto == BTUSB_PROTO_H4)
+		return alloc_bulk_urb(hdev, skb);
+
 	urb = usb_alloc_urb(0, GFP_KERNEL);
 	if (!urb)
 		return ERR_PTR(-ENOMEM);
@@ -2174,35 +2247,15 @@ static struct urb *alloc_ctrl_urb(struct hci_dev *hdev, struct sk_buff *skb)
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
 
@@ -2416,10 +2469,9 @@ static int btusb_switch_alt_setting(struct hci_dev *hdev, int new_alts)
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
@@ -2475,9 +2527,9 @@ static void btusb_work(struct work_struct *work)
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
@@ -3951,8 +4003,11 @@ static ssize_t force_poll_sync_write(struct file *file,
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
@@ -4051,7 +4106,7 @@ static int btusb_hci_drv_supported_altsettings(struct hci_dev *hdev, void *data,
 		goto done;
 
 	for (i = 0; i <= 6; i++) {
-		if (btusb_find_altsetting(drvdata, i))
+		if (btusb_find_altsetting(drvdata->isoc, i))
 			rp->altsettings[rp->num++] = i;
 	}
 
@@ -4105,6 +4160,8 @@ static int btusb_probe(struct usb_interface *intf,
 		       const struct usb_device_id *id)
 {
 	struct gpio_desc *reset_gpio;
+	struct usb_host_interface *alt;
+	struct usb_endpoint_descriptor *ep;
 	struct btusb_data *data;
 	struct hci_dev *hdev;
 	unsigned ifnum_base;
@@ -4146,10 +4203,36 @@ static int btusb_probe(struct usb_interface *intf,
 		return -ENOMEM;
 
 	data->match_id = id;
+
+	/* Alternate setting 1 with a single pair of bulk endpoints means the
+	 * controller supports Bulk Serialization Mode, in which every packet
+	 * is prefixed with an H:4 header and carried over the bulk endpoints.
+	 */
+	alt = btusb_find_altsetting(intf, 1);
+	if (alt && usb_find_int_in_endpoint(alt, &ep) &&
+	    !usb_find_common_endpoints(alt, &ep, &ep, NULL, NULL)) {
+		err = usb_set_interface(interface_to_usbdev(intf), ifnum_base, 1);
+		if (!err)
+			data->proto = BTUSB_PROTO_H4;
+		else
+			dev_warn(&intf->dev,
+				 "failed to select alt setting 1 (%d), using legacy mode",
+				 err);
+	}
+
+	/* Check if all endpoints could be enumerated, legacy mode requires
+	 * interrupt and bulk endpoints while H4 mode only requires bulk
+	 * endpoints.
+	 */
 	err = usb_find_common_endpoints(intf->cur_altsetting, &data->bulk_rx_ep,
-					&data->bulk_tx_ep, &data->intr_ep, NULL);
-	if (err)
+					&data->bulk_tx_ep,
+					data->proto == BTUSB_PROTO_LEGACY ?
+						&data->intr_ep : NULL,
+					NULL);
+	if (err) {
+		dev_err(&intf->dev, "failed to enumerate endpoints\n");
 		goto err_free_data;
+	}
 
 	if (id->driver_info & BTUSB_AMP) {
 		data->cmdreq_type = USB_TYPE_CLASS | 0x01;
@@ -4361,6 +4444,12 @@ static int btusb_probe(struct usb_interface *intf,
 	if (id->driver_info & BTUSB_AMP) {
 		/* AMP controllers do not support SCO packets */
 		data->isoc = NULL;
+	} else if (data->proto == BTUSB_PROTO_H4) {
+		/* In H:4 mode every packet, including SCO/ISO, is carried over
+		 * the bulk endpoints, so the isochronous interface must not be
+		 * claimed nor have its alternate settings switched.
+		 */
+		data->isoc = NULL;
 	} else {
 		/* Interface orders are hardcoded in the specification */
 		data->isoc = usb_ifnum_to_if(data->udev, ifnum_base + 1);
@@ -4470,7 +4559,8 @@ static int btusb_probe(struct usb_interface *intf,
 	if (enable_autosuspend)
 		usb_enable_autosuspend(data->udev);
 
-	data->poll_sync = enable_poll_sync;
+	if (data->proto == BTUSB_PROTO_LEGACY)
+		data->poll_sync = enable_poll_sync;
 
 	err = hci_register_dev(hdev);
 	if (err < 0)
-- 
2.54.0

