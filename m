Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460C44AFE14
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Sep 2026 21:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788385599; cv=none; b=hvVbFT3TFJXaKVGU3DcpOCV5eI2Ht8qRti79iJxEYO6FnTx6qu3FmN++X+VsGO6A0/tb5qJ1nZxaI3T3iqp8dyp8OxTIezksBNYP2eMWj9tPlgEoL3Hxd86z6KIU0plfSVoec0d0QR0NBme0k4mx3wzwtAtFg0KLCPaEXwKE1p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788385599; c=relaxed/simple;
	bh=byEeD1+2hmCnTE1EhEya7njyFjcqFSsdLyc2lWRBLnc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UU3IC5Gpclv6hHuxsShrWFIalH26kZdHZRY77Z+7oz9qB0fDL5baDRM1lI8NL0IA9EcBmiHTKlMXRUhrO8e3YfejNc8h3UTlODocB+5Zev1h9tMVszoIedVkSbCnRi2YzwEDRSlvJd1H5kduTR5eZfnZoF4HeKgupii6nVhzBfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cPKkeGHN; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cPKkeGHN"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5c5ac25089bso878056e0c.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Sep 2026 14:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788385589; x=1788990389; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+EKthhl+uKy1aW+japEMmzkZ8hhLzVZgJgvIju0ltPM=;
        b=cPKkeGHNNwnrLktHPBexJwkl2oYC1oYYVUHAPdCzzkXZjMWWxyRKq6ec6avU4V7a2M
         k19HKDovA0txlH8FUoAt0Nd69W+X7xPD3J+1SpO5P+xElPQZCmTTVjOdusYfyRB9gy+W
         qS9sDX1knw30Ua2QAX42LyzLkWjq5e8O3pEUD5tFx3QKe/8nyyobDRf1glXJogwvdl/d
         Why4erOlANkqStSgCqUgbHC6dx1eoSPGNFUMcW2mMiQrHZsq+JlM0hww6q1nKVJQHVnz
         7UlhiwYxOIJXznStUkymFIYdu+SiaGvShygZBW6uaEgq9higBIfOdqZXIhr4tUMZaTTA
         e0qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788385589; x=1788990389;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+EKthhl+uKy1aW+japEMmzkZ8hhLzVZgJgvIju0ltPM=;
        b=W3Gcvx9jXpGDVsgHSDaptLI6cIoWXeTP0TkgRXgmPnEjFyreLKRdNgj7gRbC3fKIaz
         l9BY4fTovjTCIU5vl6tnT/6glgqrCYKmlmWNyG9vtJi/9KngwAZMPbOUeU24xGMvYhQk
         7uTXUK4J7KLdJTyO94Sw4YLyYa4VNDlSnzx+tG1OPSR9m7pyI5RTRfp1Ej0g8YZWguzw
         eWSUQxBvWjBDlXGUyiuE6CKy5CfEB5yLZ9QetUaj4us9T89MfdZQce9naj+kEiByNm01
         4u2qlPiEZ/F4Mt6tDH8A97LzY3LFrqEN7053aWGIZ5OHpLj7we9nwl0Cu9kzr3uoCLGr
         t33Q==
X-Gm-Message-State: AFuF++nXZOvdj/SSODkrbIbOF+b+a3O5IS3dZGzgwXLHZHTFR0Aj1n/B
	QMKQWa14HlBzBWroPLgxKu3JObiouMSQWKfgdPWOaDZpWn0yS02VaBNKMENcvAfPVgc=
X-Gm-Gg: AYBFou0ymCV9F4lkY7wcaklpvtwKfwhjN6IzJBGHLn6Gmupcw/UjkRK6Rgp0nGPLxTG
	nEsq0zn2bxFvcXNeOC7/kjz+MQs8EjO1747OADpr6Mv6FL6iLX/69xl9o4PjT2/BjtyzZ26bQpI
	qNKmNqnlTwtc1jzW7IgG1qUjxjOQBL7EJquRQSdaeZFnBSfCL+2OY2v+ZHo1rahH35QrWEvWtCM
	SKcuO1W16518XF1KsFcePYcwyYC2QMOZBSI2sYcbMF3AZzomrVQdSxPgH90kmEEWB3tW9LadBPE
	7SFHy8PaNM+M2XRFjr9hRqO4MzM+GPundYXgLEEJTYWyaTrNUneUJ9uzcKNuTB4LW4jfNwlRWrW
	4kYACJlXlnw76obTtNXPrLg+ruI1O6A2loQtyu5xyopyFXI8bQxvA7YX75VRxf9Oj/xZr50bHwD
	H5o3Se6FZ/RQKrR86idU9rIJSaQg03ZnAnP/aA+hHQ27MeENGsEWeMD/G5nOGG1UYlNd07rIZoI
	Trvjf8908LAq+EveNWvTtnG9X5dNY2dNlCOgtwwLQ0r2JZ/S8cd1Gc=
X-Received: by 2002:a05:6122:788:b0:5c5:731b:11d2 with SMTP id 71dfb90a1353d-5c7d28a4f65mr3025811e0c.8.1788385588982;
        Wed, 02 Sep 2026 14:46:28 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c7cd8fda9asm3219583e0c.14.2026.09.02.14.46.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 14:46:28 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 3/3] Bluetooth: btusb: Add support for Bulk Serialization Mode
Date: Wed,  2 Sep 2026 17:46:20 -0400
Message-ID: <20260902214620.44041-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260902214620.44041-1-luiz.dentz@gmail.com>
References: <20260902214620.44041-1-luiz.dentz@gmail.com>
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
 drivers/bluetooth/btusb.c | 214 ++++++++++++++++++++++++++++++--------
 1 file changed, 171 insertions(+), 43 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index b42963417213..b802c8d7c04d 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -28,8 +28,9 @@
 #include "btbcm.h"
 #include "btrtl.h"
 #include "btmtk.h"
+#include "hci_uart.h"
 
-#define VERSION "0.8"
+#define VERSION "1.0"
 
 static bool disable_scofix;
 static bool force_scofix;
@@ -985,6 +986,9 @@ struct btqca_data {
 #define BTUSB_HW_SSR_ACTIVE	17
 #define BTUSB_WAKEUP_BROKEN	18
 
+#define BTUSB_PROTO_LEGACY	0x00
+#define BTUSB_PROTO_H4		0x01
+
 struct btusb_data {
 	struct hci_dev       *hdev;
 	struct usb_device    *udev;
@@ -1018,6 +1022,7 @@ struct btusb_data {
 	struct sk_buff *evt_skb;
 	struct sk_buff *acl_skb;
 	struct sk_buff *sco_skb;
+	struct sk_buff *rx_skb;
 
 	struct usb_endpoint_descriptor *intr_ep;
 	struct usb_endpoint_descriptor *bulk_tx_ep;
@@ -1031,6 +1036,7 @@ struct btusb_data {
 
 	__u8 cmdreq_type;
 	__u8 cmdreq;
+	__u8 proto;
 
 	unsigned int sco_num;
 	unsigned int air_mode;
@@ -1258,6 +1264,11 @@ static inline void btusb_free_frags(struct btusb_data *data)
 	dev_kfree_skb_irq(data->sco_skb);
 	data->sco_skb = NULL;
 
+	/* rx_skb may hold an ERR_PTR from a previous h4_recv_skb() call */
+	if (!IS_ERR(data->rx_skb))
+		dev_kfree_skb_irq(data->rx_skb);
+	data->rx_skb = NULL;
+
 	spin_unlock_irqrestore(&data->rxlock, flags);
 }
 
@@ -1357,12 +1368,41 @@ static int btusb_recv_acl(struct hci_dev *hdev, struct sk_buff *skb)
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
 
@@ -2040,12 +2080,14 @@ static int btusb_open(struct hci_dev *hdev)
 
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
@@ -2149,6 +2191,42 @@ static int btusb_flush(struct hci_dev *hdev)
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
@@ -2156,6 +2234,9 @@ static struct urb *alloc_ctrl_urb(struct hci_dev *hdev, struct sk_buff *skb)
 	struct urb *urb;
 	unsigned int pipe;
 
+	if (data->proto == BTUSB_PROTO_H4)
+		return alloc_bulk_urb(hdev, skb);
+
 	urb = usb_alloc_urb(0, GFP_KERNEL);
 	if (!urb)
 		return ERR_PTR(-ENOMEM);
@@ -2182,35 +2263,15 @@ static struct urb *alloc_ctrl_urb(struct hci_dev *hdev, struct sk_buff *skb)
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
 
@@ -2282,6 +2343,22 @@ static int submit_or_queue_tx_urb(struct hci_dev *hdev, struct urb *urb)
 	return 0;
 }
 
+static int submit_sco_urb(struct hci_dev *hdev, struct urb *urb)
+{
+	struct btusb_data *data = hci_get_drvdata(hdev);
+
+	/* In H:4 mode SCO frames are carried over the bulk endpoint and
+	 * complete via btusb_tx_complete(), which decrements tx_in_flight, so
+	 * they have to be accounted for like any other bulk transfer.
+	 * Isochronous transfers use btusb_isoc_tx_complete() instead, which
+	 * does not, so they must not be counted.
+	 */
+	if (data->proto == BTUSB_PROTO_H4)
+		return submit_or_queue_tx_urb(hdev, urb);
+
+	return submit_tx_urb(hdev, urb);
+}
+
 static int btusb_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct urb *urb;
@@ -2315,7 +2392,7 @@ static int btusb_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 			return PTR_ERR(urb);
 
 		hdev->stat.sco_tx++;
-		return submit_tx_urb(hdev, urb);
+		return submit_sco_urb(hdev, urb);
 
 	case HCI_ISODATA_PKT:
 		urb = alloc_bulk_urb(hdev, skb);
@@ -2424,10 +2501,9 @@ static int btusb_switch_alt_setting(struct hci_dev *hdev, int new_alts)
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
@@ -2450,6 +2526,13 @@ static void btusb_work(struct work_struct *work)
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
@@ -2483,9 +2566,9 @@ static void btusb_work(struct work_struct *work)
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
@@ -2734,8 +2817,13 @@ static int btusb_recv_bulk_intel(struct btusb_data *data, void *buffer,
 	/* When the device is in bootloader mode, then it can send
 	 * events via the bulk endpoint. These events are treated the
 	 * same way as the ones received from the interrupt endpoint.
+	 *
+	 * In H:4 mode there is no interrupt endpoint and every frame on the
+	 * bulk endpoint carries an H:4 header, including the ones sent by the
+	 * bootloader, so the regular decoding applies.
 	 */
-	if (btintel_test_flag(hdev, INTEL_BOOTLOADER))
+	if (data->proto == BTUSB_PROTO_LEGACY &&
+	    btintel_test_flag(hdev, INTEL_BOOTLOADER))
 		return btusb_recv_intr(data, buffer, count);
 
 	return btusb_recv_bulk(data, buffer, count);
@@ -2796,7 +2884,7 @@ static int btusb_send_frame_intel(struct hci_dev *hdev, struct sk_buff *skb)
 			return PTR_ERR(urb);
 
 		hdev->stat.sco_tx++;
-		return submit_tx_urb(hdev, urb);
+		return submit_sco_urb(hdev, urb);
 
 	case HCI_ISODATA_PKT:
 		urb = alloc_bulk_urb(hdev, skb);
@@ -4007,8 +4095,11 @@ static ssize_t force_poll_sync_write(struct file *file,
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
@@ -4107,7 +4198,7 @@ static int btusb_hci_drv_supported_altsettings(struct hci_dev *hdev, void *data,
 		goto done;
 
 	for (i = 0; i <= 6; i++) {
-		if (btusb_find_altsetting(drvdata, i))
+		if (btusb_find_altsetting(drvdata->isoc, i))
 			rp->altsettings[rp->num++] = i;
 	}
 
@@ -4161,6 +4252,8 @@ static int btusb_probe(struct usb_interface *intf,
 		       const struct usb_device_id *id)
 {
 	struct gpio_desc *reset_gpio;
+	struct usb_host_interface *alt;
+	struct usb_endpoint_descriptor *bulk_rx_ep, *bulk_tx_ep, *intr_ep;
 	struct btusb_data *data;
 	struct hci_dev *hdev;
 	unsigned ifnum_base;
@@ -4202,10 +4295,38 @@ static int btusb_probe(struct usb_interface *intf,
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
@@ -4417,6 +4538,12 @@ static int btusb_probe(struct usb_interface *intf,
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
@@ -4526,7 +4653,8 @@ static int btusb_probe(struct usb_interface *intf,
 	if (enable_autosuspend)
 		usb_enable_autosuspend(data->udev);
 
-	data->poll_sync = enable_poll_sync;
+	if (data->proto == BTUSB_PROTO_LEGACY)
+		data->poll_sync = enable_poll_sync;
 
 	err = hci_register_dev(hdev);
 	if (err < 0)
-- 
2.54.0

