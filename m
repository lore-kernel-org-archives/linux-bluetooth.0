Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5B3361DDC
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 16:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788194491; cv=none; b=CZgS+jUzT60JgmLC0R4FAbcNQPcgqsr72IUj3AjCNJBeRPG5ZZ+W2QgS/S8laQIt2PpxGM5zMjRfQvXFiUSkUuQ2wRZRduzfWhXnUKsWlxBDV/svQlucx5aGiPBNacD1n73i9Bo6qRATMpIn3OKFLJUS9j6w0Jas3i7lOZk0gPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788194491; c=relaxed/simple;
	bh=l0g5idS5FlFFkEJXVeQ5lRjFxn72tRowtGX8tXArpFg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=afHK+L2hxVCc+OcDgjzqtrrlmshQ4f5Xhopvslm91PyzfeKWX1vosS1dnDfVZ0tx4ZlmvsqrCjjf1jFEqO4nh+2rCeciG8jNeMqqJf7Ds+ct1XoGNZsn+rLqJYVx5Nf9ipimioh8cZR7ki8OJK+tUm7Ih+DRTBpqg4g//4VBkJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R9jtV2kQ; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9jtV2kQ"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5c652293bcdso3461081e0c.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 09:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788194488; x=1788799288; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fds1q+wRuABjXfyGHiOKc962FFFKwCWM7UEpYlx8h1Y=;
        b=R9jtV2kQAzPM/Ys05YIM0oYWkOis77/CYtnchcMI0ugOaiLG5M9wHS/2HpBup2ay5Z
         Qjy29CAhIC9K3GuMLGiqLrvYeT5OIFN3twsdYAhq6tEx5KFWg6vwbhh9/nkiyFDAVoIa
         cLXw7iRevV/LVZqYN8ckM6gUkv1TQFDjmfLfezNQfmhplJUMRsLzAv1uXqZcBx2ajzTb
         xORc2P3q467ZnAk8Z7AN3LSVyNmjufQpuqaLpwy0Z9maqMjuD+gNzuC3nQNc6wFNqWRs
         AWaqrlXIeen5NHBeJ5yaOm/cRv62P/g3mzzJmuMOQ0zo89PdweIctWyK+779yl1TwHCN
         IiWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788194488; x=1788799288;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fds1q+wRuABjXfyGHiOKc962FFFKwCWM7UEpYlx8h1Y=;
        b=FyGQ8GC8HGblnrlWfgqMZgLRUzsBG6uw8eJrTKmfGexLeqO30hcBMIlHzj7gTzfJWS
         cSldNuPUqKbNPLe+TAr+Hevq9jqdtLePF5CkA/58bNLJpt4wg7VpRCfIG4c7zam8Bwp3
         8XkFWS0zL876BH5wEQkchtCxpTWyNXHITZGDhUYNiQrcqmSxUpPTveLP3gBdzTbLOP67
         Yz0aEPkajQjPwCpDkfEbBbTg6dSI/Nn8w0GQLIneuRg28JSR+BduWZL/5wUeETDI9/F2
         5aVlFFGHIfcl9T/Rmymz5IahhteZjRIVjQ7G1OVKjCkfjrZS1ftnNE8uv9zfBEoOVmat
         qa6A==
X-Gm-Message-State: AFuF++m/nD3pjsa62crVLQ5MHQb4BQxtcd7zA+XGIPwknKZ6pLY90Ibf
	t8wv1Mcd7ZI+fVlu6sjECzy+Y9ySwXCwxgmxOLofstTmTDBy58KN/KGgDfRlisuWFK63HQ==
X-Gm-Gg: AR+sD128WBqUJ1D5QQ0PlvBtt1qlNW6WROs0/DckWhQneoAeaLD1MofDRj0M/2VsIa2
	nr/T8m+jmO/1MwxU8Z/kX2dPF3MW+lEtlCVIUEfp8ZTNuFto3HoZu3sYaC40HG/KiJbW14zfJFY
	N+MehBSfduYmaonykqeQEW+0iFDoJcYV24Fci60qEIuFkQa5BqhvCtCXk6ogEgCI53E5KFij4h1
	biXsSiGB7nX2T4rvjtAmLFlTGIhHdvDLiBwgX25fYufJ8DVeR6kbXIic3D7HlH8VDZHOabxqM74
	50j428O3YIeRzDHUQlAt/WrOJyJyRcJr6KXKCUKYkvjEXrdC3zw9XFydI4gmRIIRiQJ/9+W7lbs
	/qFuDVidR0k/dRjXhWPkjqgE29y3a9s9EYp/gzsL4+4sfEcTVjEpU8ZSf/7Uh5shuJSJalvcerB
	b1TcoebQ8vg8if1vKQdZN4oZRPsPDf79S+U34Hfm4FYAc39QPhbRPCtM9CKwEAxygQP12kloBe4
	F/G9oR0JvdBXwzxcwJgFLhYzw+yDwtUXKm8TVP/FzOyIAI4uCapHXs=
X-Received: by 2002:a05:6123:2e5:b0:5c6:7f44:b001 with SMTP id 71dfb90a1353d-5c7bdd9da3cmr1121312e0c.0.1788194488062;
        Mon, 31 Aug 2026 09:41:28 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c724263c41sm8759775e0c.16.2026.08.31.09.41.24
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 09:41:25 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 2/2] Bluetooth: btusb: Add support for Bulk Serialization Mode
Date: Mon, 31 Aug 2026 12:41:11 -0400
Message-ID: <20260831164112.778064-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260831164112.778064-1-luiz.dentz@gmail.com>
References: <20260831164112.778064-1-luiz.dentz@gmail.com>
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
 drivers/bluetooth/btusb.c | 187 ++++++++++++++++++++++++++++++--------
 1 file changed, 147 insertions(+), 40 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index ce870ec5ab43..ffa2d6053b32 100644
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
@@ -2147,6 +2189,42 @@ static int btusb_flush(struct hci_dev *hdev)
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
+	if (data->proto == BTUSB_PROTO_H4) {
+		/* The frame type is prepended in place, so the buffer must not
+		 * be shared with anyone else.
+		 */
+		if (skb_cow_head(skb, 1))
+			return ERR_PTR(-ENOMEM);
+	}
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
@@ -2154,6 +2232,9 @@ static struct urb *alloc_ctrl_urb(struct hci_dev *hdev, struct sk_buff *skb)
 	struct urb *urb;
 	unsigned int pipe;
 
+	if (data->proto == BTUSB_PROTO_H4)
+		return alloc_bulk_urb(hdev, skb);
+
 	urb = usb_alloc_urb(0, GFP_KERNEL);
 	if (!urb)
 		return ERR_PTR(-ENOMEM);
@@ -2180,35 +2261,15 @@ static struct urb *alloc_ctrl_urb(struct hci_dev *hdev, struct sk_buff *skb)
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
 
@@ -2422,10 +2483,9 @@ static int btusb_switch_alt_setting(struct hci_dev *hdev, int new_alts)
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
@@ -2448,6 +2508,13 @@ static void btusb_work(struct work_struct *work)
 	int new_alts = 0;
 	int err;
 
+	/* In H:4 mode SCO/ISO data is carried over the bulk endpoints, so
+	 * there is no isochronous interface to resume or to switch alternate
+	 * settings on.
+	 */
+	if (data->proto == BTUSB_PROTO_H4)
+		return;
+
 	if (data->sco_num > 0) {
 		if (!test_bit(BTUSB_DID_ISO_RESUME, &data->flags)) {
 			err = usb_autopm_get_interface(data->isoc ? data->isoc : data->intf);
@@ -2481,9 +2548,9 @@ static void btusb_work(struct work_struct *work)
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
@@ -3957,8 +4024,11 @@ static ssize_t force_poll_sync_write(struct file *file,
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
@@ -4057,7 +4127,7 @@ static int btusb_hci_drv_supported_altsettings(struct hci_dev *hdev, void *data,
 		goto done;
 
 	for (i = 0; i <= 6; i++) {
-		if (btusb_find_altsetting(drvdata, i))
+		if (btusb_find_altsetting(drvdata->isoc, i))
 			rp->altsettings[rp->num++] = i;
 	}
 
@@ -4111,6 +4181,8 @@ static int btusb_probe(struct usb_interface *intf,
 		       const struct usb_device_id *id)
 {
 	struct gpio_desc *reset_gpio;
+	struct usb_host_interface *alt;
+	struct usb_endpoint_descriptor *bulk_rx_ep, *bulk_tx_ep, *intr_ep;
 	struct btusb_data *data;
 	struct hci_dev *hdev;
 	unsigned ifnum_base;
@@ -4152,10 +4224,38 @@ static int btusb_probe(struct usb_interface *intf,
 		return -ENOMEM;
 
 	data->match_id = id;
+
+	/* Alternate setting 1 with a single pair of bulk endpoints and no
+	 * interrupt endpoint means the controller supports Bulk Serialization
+	 * Mode, in which every packet is prefixed with an H:4 header and
+	 * carried over the bulk endpoints.
+	 */
+	alt = btusb_find_altsetting(intf, 1);
+	if (alt && usb_find_int_in_endpoint(alt, &intr_ep) &&
+	    !usb_find_common_endpoints(alt, &bulk_rx_ep, &bulk_tx_ep, NULL,
+				       NULL)) {
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
@@ -4367,6 +4467,12 @@ static int btusb_probe(struct usb_interface *intf,
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
@@ -4476,7 +4582,8 @@ static int btusb_probe(struct usb_interface *intf,
 	if (enable_autosuspend)
 		usb_enable_autosuspend(data->udev);
 
-	data->poll_sync = enable_poll_sync;
+	if (data->proto == BTUSB_PROTO_LEGACY)
+		data->poll_sync = enable_poll_sync;
 
 	err = hci_register_dev(hdev);
 	if (err < 0)
-- 
2.54.0

