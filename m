Received: from mail.wantyapps.xyz (mail.wantyapps.xyz [66.135.5.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE4CC148;
	Fri, 23 Aug 2024 00:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.135.5.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724373519; cv=none; b=aYW6FD7OhBTgTgg5za0jyFQSTy3tdTJJvYdjy0fcAmLhWfKdAheCWDBXO1fBLuupeFRkSxzLjoR/XCzL4GoXN5QvO0lOiLTaJjg1ruHTjkLLlUtMVmxVs1hmA09Ge+D1Hrqpv9WJ4egLDtHMVdXztFE30OxyZZlun+sUEuVr+uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724373519; c=relaxed/simple;
	bh=I+8tRpfyUrBe2V7U7HVsggUxN5K+Mw0VQASzGgsBNc8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uTjj+0uwLU8lX8ZrqXPMM+bPxABD/DsTEhD4oM8heJRX0mq86RjvgcLRyWvvTx5rhJgmOt0vkPBoyAUikqHE3qQpUh3Ey8uBNYexDjU9aSZJrdhZ8UgNQkPjk6qL2l4BYCDEn3hMvWMLxPMDdqA/2qtdJdqjsVftRQaHx5qpGyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=wantyapps.xyz; spf=pass smtp.mailfrom=wantyapps.xyz; dkim=pass (2048-bit key) header.d=wantyapps.xyz header.i=@wantyapps.xyz header.b=sjKEkmQm; arc=none smtp.client-ip=66.135.5.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=wantyapps.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wantyapps.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wantyapps.xyz header.i=@wantyapps.xyz header.b="sjKEkmQm"
Received: from multivac.localdomain (unknown [147.235.206.10])
	by mail.wantyapps.xyz (Postfix) with ESMTPSA id A9A6A7D13A;
	Fri, 23 Aug 2024 00:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wantyapps.xyz;
	s=mail; t=1724373516;
	bh=I+8tRpfyUrBe2V7U7HVsggUxN5K+Mw0VQASzGgsBNc8=;
	h=From:To:Cc:Subject:Date:From;
	b=sjKEkmQmfQXsPGQc/dwvpbh5ZtrcZatbW+xRAzRHsJs/relFRXxCh0XLgM/9T8/Qn
	 l7VVhplcWU8JBnZ5V8Id08ZF5GkSR6gQNBIIu7OvGEeXPqrso1qEnhBcnG/lMsGJ7b
	 f8e0jLvvFqWWSR8FpdTn6max92hRmCY/3JP0Le7mJPDg2ojBbmfoQ+qTGAncpz0Eyl
	 5RqJ6AuQEHgMeooPgfhIzD3pK8oe3cRT6/ajB2gwh5QYNvkWDljKp8koGti57CtT1R
	 SdN/vdB56CVFNDcGu4MVMmIEZuZAKcCZVfxXJ9n800merYo8XfMbxoH9sXm0x1axYC
	 YJ00jrQkOu2Lw==
From: me@wantyapps.xyz
To: 
Cc: me@wantyapps.xyz,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: bfusb: Fix multiple issues reported by checkpatch.pl
Date: Fri, 23 Aug 2024 03:38:23 +0300
Message-ID: <20240823003831.3568918-1-me@wantyapps.xyz>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Uri Arev <me@wantyapps.xyz>

This fixes the following CHECKs and WARNINGs reported in bfusb.c.

Reported by checkpatch.pl:
-------
bfusb.c
-------
CHECK: No space is necessary after a cast
+               urb = ((struct bfusb_data_scb *) skb->cb)->urb;

CHECK: No space is necessary after a cast
+               urb = ((struct bfusb_data_scb *) skb->cb)->urb;

CHECK: No space is necessary after a cast
+       struct bfusb_data_scb *scb = (void *) skb->cb;

CHECK: Alignment should match open parenthesis
+       usb_fill_bulk_urb(urb, data->udev, pipe, skb->data, skb->len,
+                       bfusb_tx_complete, skb);

CHECK: braces {} should be used on all arms of this statement
+       if (err) {
[...]
+       } else
[...]

CHECK: Unbalanced braces around else statement
+       } else

CHECK: Alignment should match open parenthesis
+               while ((atomic_read(&data->pending_tx) < BFUSB_MAX_BULK_TX) &&
+                               (skb = skb_dequeue(&data->transmit_q))) {

CHECK: No space is necessary after a cast
+       struct sk_buff *skb = (struct sk_buff *) urb->context;

CHECK: No space is necessary after a cast
+       struct bfusb_data *data = (struct bfusb_data *) skb->dev;

CHECK: Please don't use multiple blank lines
+
+

CHECK: No space is necessary after a cast
+       skb->dev = (void *) data;

CHECK: No space is necessary after a cast
+       scb = (struct bfusb_data_scb *) skb->cb;

CHECK: Alignment should match open parenthesis
+       usb_fill_bulk_urb(urb, data->udev, pipe, skb->data, size,
+                       bfusb_rx_complete, skb);

CHECK: No space is necessary after a cast
+                               struct hci_event_hdr *hdr = (struct hci_event_hdr *) buf;

WARNING: Missing a blank line after declarations
+                               struct hci_event_hdr *hdr = (struct hci_event_hdr *) buf;
+                               pkt_len = HCI_EVENT_HDR_SIZE + hdr->plen;

CHECK: No space is necessary after a cast
+                               struct hci_acl_hdr *hdr = (struct hci_acl_hdr *) buf;

WARNING: Missing a blank line after declarations
+                               struct hci_acl_hdr *hdr = (struct hci_acl_hdr *) buf;
+                               pkt_len = HCI_ACL_HDR_SIZE + __le16_to_cpu(hdr->dlen);

CHECK: No space is necessary after a cast
+                               struct hci_sco_hdr *hdr = (struct hci_sco_hdr *) buf;

WARNING: Missing a blank line after declarations
+                               struct hci_sco_hdr *hdr = (struct hci_sco_hdr *) buf;
+                               pkt_len = HCI_SCO_HDR_SIZE + hdr->dlen;

CHECK: No space is necessary after a cast
+       struct sk_buff *skb = (struct sk_buff *) urb->context;

CHECK: No space is necessary after a cast
+       struct bfusb_data *data = (struct bfusb_data *) skb->dev;

WARNING: braces {} are not necessary for single statement blocks
+               if (count < len) {
+                       bt_dev_err(data->hdev, "block extends over URB buffer ranges");
+               }

CHECK: No space is necessary after a cast
+       nskb->dev = (void *) data;

CHECK: Alignment should match open parenthesis
+       if (usb_control_msg(data->udev, pipe, USB_REQ_SET_CONFIGURATION,
+                               0, 1, 0, NULL, 0, USB_CTRL_SET_TIMEOUT) < 0) {

CHECK: multiple assignments should be avoided
+       data->udev->toggle[0] = data->udev->toggle[1] = 0;

CHECK: Alignment should match open parenthesis
+               err = usb_bulk_msg(data->udev, pipe, buf, size,
+                                       &len, BFUSB_BLOCK_TIMEOUT);

CHECK: Unnecessary parentheses around 'len != size'
+               if (err || (len != size)) {

CHECK: Alignment should match open parenthesis
+       err = usb_bulk_msg(data->udev, pipe, NULL, 0,
+                                       &len, BFUSB_BLOCK_TIMEOUT);

CHECK: Alignment should match open parenthesis
+       err = usb_control_msg(data->udev, pipe, USB_REQ_SET_CONFIGURATION,
+                               0, 2, 0, NULL, 0, USB_CTRL_SET_TIMEOUT);

CHECK: multiple assignments should be avoided
+       data->udev->toggle[0] = data->udev->toggle[1] = 0;

CHECK: Alignment should match open parenthesis
+       usb_control_msg(data->udev, pipe, USB_REQ_SET_CONFIGURATION,
+                               0, 0, 0, NULL, 0, USB_CTRL_SET_TIMEOUT);

Signed-off-by: Uri Arev <me@wantyapps.xyz>
---
 drivers/bluetooth/bfusb.c | 57 ++++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 28 deletions(-)

diff --git a/drivers/bluetooth/bfusb.c b/drivers/bluetooth/bfusb.c
index cab93935cc7f..a41b746b63a8 100644
--- a/drivers/bluetooth/bfusb.c
+++ b/drivers/bluetooth/bfusb.c
@@ -84,7 +84,7 @@ static struct urb *bfusb_get_completed(struct bfusb_data *data)
 
 	skb = skb_dequeue(&data->completed_q);
 	if (skb) {
-		urb = ((struct bfusb_data_scb *) skb->cb)->urb;
+		urb = ((struct bfusb_data_scb *)skb->cb)->urb;
 		kfree_skb(skb);
 	}
 
@@ -99,7 +99,7 @@ static void bfusb_unlink_urbs(struct bfusb_data *data)
 	BT_DBG("bfusb %p", data);
 
 	while ((skb = skb_dequeue(&data->pending_q))) {
-		urb = ((struct bfusb_data_scb *) skb->cb)->urb;
+		urb = ((struct bfusb_data_scb *)skb->cb)->urb;
 		usb_kill_urb(urb);
 		skb_queue_tail(&data->completed_q, skb);
 	}
@@ -110,7 +110,7 @@ static void bfusb_unlink_urbs(struct bfusb_data *data)
 
 static int bfusb_send_bulk(struct bfusb_data *data, struct sk_buff *skb)
 {
-	struct bfusb_data_scb *scb = (void *) skb->cb;
+	struct bfusb_data_scb *scb = (void *)skb->cb;
 	struct urb *urb = bfusb_get_completed(data);
 	int err, pipe;
 
@@ -125,7 +125,7 @@ static int bfusb_send_bulk(struct bfusb_data *data, struct sk_buff *skb)
 	pipe = usb_sndbulkpipe(data->udev, data->bulk_out_ep);
 
 	usb_fill_bulk_urb(urb, data->udev, pipe, skb->data, skb->len,
-			bfusb_tx_complete, skb);
+			  bfusb_tx_complete, skb);
 
 	scb->urb = urb;
 
@@ -137,8 +137,9 @@ static int bfusb_send_bulk(struct bfusb_data *data, struct sk_buff *skb)
 			   urb, err);
 		skb_unlink(skb, &data->pending_q);
 		usb_free_urb(urb);
-	} else
+	} else {
 		atomic_inc(&data->pending_tx);
+	}
 
 	return err;
 }
@@ -158,7 +159,7 @@ static void bfusb_tx_wakeup(struct bfusb_data *data)
 		clear_bit(BFUSB_TX_WAKEUP, &data->state);
 
 		while ((atomic_read(&data->pending_tx) < BFUSB_MAX_BULK_TX) &&
-				(skb = skb_dequeue(&data->transmit_q))) {
+		       (skb = skb_dequeue(&data->transmit_q))) {
 			if (bfusb_send_bulk(data, skb) < 0) {
 				skb_queue_head(&data->transmit_q, skb);
 				break;
@@ -172,8 +173,8 @@ static void bfusb_tx_wakeup(struct bfusb_data *data)
 
 static void bfusb_tx_complete(struct urb *urb)
 {
-	struct sk_buff *skb = (struct sk_buff *) urb->context;
-	struct bfusb_data *data = (struct bfusb_data *) skb->dev;
+	struct sk_buff *skb = (struct sk_buff *)urb->context;
+	struct bfusb_data *data = (struct bfusb_data *)skb->dev;
 
 	BT_DBG("bfusb %p urb %p skb %p len %d", data, urb, skb, skb->len);
 
@@ -197,7 +198,6 @@ static void bfusb_tx_complete(struct urb *urb)
 	read_unlock(&data->lock);
 }
 
-
 static int bfusb_rx_submit(struct bfusb_data *data, struct urb *urb)
 {
 	struct bfusb_data_scb *scb;
@@ -218,15 +218,15 @@ static int bfusb_rx_submit(struct bfusb_data *data, struct urb *urb)
 		return -ENOMEM;
 	}
 
-	skb->dev = (void *) data;
+	skb->dev = (void *)data;
 
-	scb = (struct bfusb_data_scb *) skb->cb;
+	scb = (struct bfusb_data_scb *)skb->cb;
 	scb->urb = urb;
 
 	pipe = usb_rcvbulkpipe(data->udev, data->bulk_in_ep);
 
 	usb_fill_bulk_urb(urb, data->udev, pipe, skb->data, size,
-			bfusb_rx_complete, skb);
+			  bfusb_rx_complete, skb);
 
 	skb_queue_tail(&data->pending_q, skb);
 
@@ -274,7 +274,7 @@ static inline int bfusb_recv_block(struct bfusb_data *data, int hdr, unsigned ch
 		switch (pkt_type) {
 		case HCI_EVENT_PKT:
 			if (len >= HCI_EVENT_HDR_SIZE) {
-				struct hci_event_hdr *hdr = (struct hci_event_hdr *) buf;
+				struct hci_event_hdr *hdr = (struct hci_event_hdr *)buf;
 				pkt_len = HCI_EVENT_HDR_SIZE + hdr->plen;
 			} else {
 				bt_dev_err(data->hdev, "event block is too short");
@@ -284,7 +284,7 @@ static inline int bfusb_recv_block(struct bfusb_data *data, int hdr, unsigned ch
 
 		case HCI_ACLDATA_PKT:
 			if (len >= HCI_ACL_HDR_SIZE) {
-				struct hci_acl_hdr *hdr = (struct hci_acl_hdr *) buf;
+				struct hci_acl_hdr *hdr = (struct hci_acl_hdr *)buf;
 				pkt_len = HCI_ACL_HDR_SIZE + __le16_to_cpu(hdr->dlen);
 			} else {
 				bt_dev_err(data->hdev, "data block is too short");
@@ -294,7 +294,7 @@ static inline int bfusb_recv_block(struct bfusb_data *data, int hdr, unsigned ch
 
 		case HCI_SCODATA_PKT:
 			if (len >= HCI_SCO_HDR_SIZE) {
-				struct hci_sco_hdr *hdr = (struct hci_sco_hdr *) buf;
+				struct hci_sco_hdr *hdr = (struct hci_sco_hdr *)buf;
 				pkt_len = HCI_SCO_HDR_SIZE + hdr->dlen;
 			} else {
 				bt_dev_err(data->hdev, "audio block is too short");
@@ -332,8 +332,8 @@ static inline int bfusb_recv_block(struct bfusb_data *data, int hdr, unsigned ch
 
 static void bfusb_rx_complete(struct urb *urb)
 {
-	struct sk_buff *skb = (struct sk_buff *) urb->context;
-	struct bfusb_data *data = (struct bfusb_data *) skb->dev;
+	struct sk_buff *skb = (struct sk_buff *)urb->context;
+	struct bfusb_data *data = (struct bfusb_data *)skb->dev;
 	unsigned char *buf = urb->transfer_buffer;
 	int count = urb->actual_length;
 	int err, hdr, len;
@@ -365,9 +365,8 @@ static void bfusb_rx_complete(struct urb *urb)
 			buf   += 3;
 		}
 
-		if (count < len) {
+		if (count < len)
 			bt_dev_err(data->hdev, "block extends over URB buffer ranges");
-		}
 
 		if ((hdr & 0xe1) == 0xc1)
 			bfusb_recv_block(data, hdr, buf, len);
@@ -480,7 +479,7 @@ static int bfusb_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 		return -ENOMEM;
 	}
 
-	nskb->dev = (void *) data;
+	nskb->dev = (void *)data;
 
 	while (count) {
 		size = min_t(uint, count, BFUSB_MAX_BLOCK_SIZE);
@@ -534,13 +533,14 @@ static int bfusb_load_firmware(struct bfusb_data *data,
 	pipe = usb_sndctrlpipe(data->udev, 0);
 
 	if (usb_control_msg(data->udev, pipe, USB_REQ_SET_CONFIGURATION,
-				0, 1, 0, NULL, 0, USB_CTRL_SET_TIMEOUT) < 0) {
+			    0, 1, 0, NULL, 0, USB_CTRL_SET_TIMEOUT) < 0) {
 		BT_ERR("Can't change to loading configuration");
 		kfree(buf);
 		return -EBUSY;
 	}
 
-	data->udev->toggle[0] = data->udev->toggle[1] = 0;
+	data->udev->toggle[0] = 0;
+	data->udev->toggle[1] = 0;
 
 	pipe = usb_sndbulkpipe(data->udev, data->bulk_out_ep);
 
@@ -550,9 +550,9 @@ static int bfusb_load_firmware(struct bfusb_data *data,
 		memcpy(buf, firmware + sent, size);
 
 		err = usb_bulk_msg(data->udev, pipe, buf, size,
-					&len, BFUSB_BLOCK_TIMEOUT);
+				   &len, BFUSB_BLOCK_TIMEOUT);
 
-		if (err || (len != size)) {
+		if (err || len != size) {
 			BT_ERR("Error in firmware loading");
 			goto error;
 		}
@@ -562,7 +562,7 @@ static int bfusb_load_firmware(struct bfusb_data *data,
 	}
 
 	err = usb_bulk_msg(data->udev, pipe, NULL, 0,
-					&len, BFUSB_BLOCK_TIMEOUT);
+			   &len, BFUSB_BLOCK_TIMEOUT);
 	if (err < 0) {
 		BT_ERR("Error in null packet request");
 		goto error;
@@ -571,13 +571,14 @@ static int bfusb_load_firmware(struct bfusb_data *data,
 	pipe = usb_sndctrlpipe(data->udev, 0);
 
 	err = usb_control_msg(data->udev, pipe, USB_REQ_SET_CONFIGURATION,
-				0, 2, 0, NULL, 0, USB_CTRL_SET_TIMEOUT);
+			      0, 2, 0, NULL, 0, USB_CTRL_SET_TIMEOUT);
 	if (err < 0) {
 		BT_ERR("Can't change to running configuration");
 		goto error;
 	}
 
-	data->udev->toggle[0] = data->udev->toggle[1] = 0;
+	data->udev->toggle[0] = 0;
+	data->udev->toggle[1] = 0;
 
 	BT_INFO("BlueFRITZ! USB device ready");
 
@@ -590,7 +591,7 @@ static int bfusb_load_firmware(struct bfusb_data *data,
 	pipe = usb_sndctrlpipe(data->udev, 0);
 
 	usb_control_msg(data->udev, pipe, USB_REQ_SET_CONFIGURATION,
-				0, 0, 0, NULL, 0, USB_CTRL_SET_TIMEOUT);
+			0, 0, 0, NULL, 0, USB_CTRL_SET_TIMEOUT);
 
 	return err;
 }
-- 
2.46.0

