Return-Path: <SRS0=u1pM=5S=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28CFC2D0F3
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Apr 2020 15:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C0A520675
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Apr 2020 15:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcVvStrp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389297AbgDBP0D (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Apr 2020 11:26:03 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42874 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbgDBP0D (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Apr 2020 11:26:03 -0400
Received: by mail-pg1-f195.google.com with SMTP id g6so41567pgs.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Apr 2020 08:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bkEX8C6yzfPHrwSdvl/IzTqPBYGIbYyrmM9omTFJHkg=;
        b=NcVvStrpVuJ1XKXJxDons8JXMZCALfQxgr4fK1PoNqqTOWmZh+3OXObnB/QU6IxXYX
         9Q87VtF2y0gD/hlZJ1Js719QPO05AIX2GRaRVb1CQUZTw5QVdcsKAAoVr/giLlS/b6iG
         plDV5wEJZ0hDN/hy6VBY6fCk7wyqc2YHiidxTO1M8VWvmaEd8d15woBs31DnNsGpS3H8
         FdrFmeNn7ENjDn3RxCpVYc5l9Br4ABrvmfEEvOKGfOZ7Kc2FYkrIiRQNIoizahJBSVLH
         Cd/tddq4A2TM5T4X6u8NyBZjKl1Nsp8/sBf9WD+aLLykhK9XrymG5R3oaC/2Nkq9iPKM
         FVdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bkEX8C6yzfPHrwSdvl/IzTqPBYGIbYyrmM9omTFJHkg=;
        b=ud96WbYJV9Iy5cNDfY8oPMlOxzWzgK29LwXBGr3mAlrnuNQGW1FuXO5RrxmZ1/Ssjw
         rem8V4xRbbUVQvFWUUfi6BHM/LUvOGoErh6fg6CxWMklYC4bxDGhfNuZbz8PwKjjgbSd
         ES8xGZpDYLRT1838wqPKP1Ut80CKP4deb4W6P37ywPlyQv7dDcLqVQppRYVWjoP4ntkv
         hBPu4NunUkzebjIimYpi4f/ufXLx/k0pKjiOEAhL5cycH6guxg8kRxpGVTfqFjlKgqcK
         shwwCEJV9QbLY7Lcb/DPhLS+FejQziRQ1hJ48EsZMFHNBYjkaexDQD4YkylgI1SyvFSH
         Yxaw==
X-Gm-Message-State: AGi0PuYx8h3/tJLop4TZlznGnaAt5c0GmCkMYpS62TvNowgHcsYdAGeR
        QUpzapPDx2e6o6DAy2QX/X4hHQ9nx9z88g==
X-Google-Smtp-Source: APiQypLYlt/NuxUWeoa5lHsEGvW3FVTpxQ2fEBMEV25DJbadILHqoF5FNB+WbCLVg9nPxvxm0+AsEA==
X-Received: by 2002:a63:3002:: with SMTP id w2mr3810961pgw.290.1585841160030;
        Thu, 02 Apr 2020 08:26:00 -0700 (PDT)
Received: from nsathish-Latitude-7480.iind.intel.com ([192.55.55.45])
        by smtp.gmail.com with ESMTPSA id h95sm3911816pjb.46.2020.04.02.08.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 08:25:58 -0700 (PDT)
From:   Sathish Narsimman <nsathish41@gmail.com>
X-Google-Original-From: Sathish Narsimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sathish Narasimman <sathish.narasimman@intel.com>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Hsin-Yu Chao <hychao@chromium.org>,
        Amit K Bag <amit.k.bag@intel.com>
Subject: [PATCH v7 2/2] bluetooth:btusb: handle msbc audio over USB Endpoints
Date:   Thu,  2 Apr 2020 20:57:58 +0530
Message-Id: <20200402152758.10363-2-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200402152758.10363-1-sathish.narasimman@intel.com>
References: <20200402152758.10363-1-sathish.narasimman@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Sathish Narasimman <sathish.narasimman@intel.com>

For msbc encoded audio stream over usb transport, btusb driver
to be set to alternate settings 6 as per BT core spec 5.0. The
type of air mode is used to differenting which alt setting to be
used.
The changes are made considering some discussion over the similar
patch submitted earlier from Kuba Pawlak(link below)
https://www.spinics.net/lists/linux-bluetooth/msg64577.html

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Sathish Narasimman <sathish.narasimman@intel.com>
Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Signed-off-by: Hsin-Yu Chao <hychao@chromium.org>
Signed-off-by: Amit K Bag <amit.k.bag@intel.com>
---
 drivers/bluetooth/btusb.c | 155 +++++++++++++++++++++++++++++---------
 1 file changed, 118 insertions(+), 37 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 3bdec42c9612..be207fd49e6f 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -492,6 +492,8 @@ struct btusb_data {
 	__u8 cmdreq;
 
 	unsigned int sco_num;
+	unsigned int air_mode;
+	bool usb_alt6_packet_flow;
 	int isoc_altsetting;
 	int suspend_count;
 
@@ -983,6 +985,42 @@ static void btusb_isoc_complete(struct urb *urb)
 	}
 }
 
+static inline void __fill_isoc_descriptor_msbc(struct urb *urb, int len,
+					       int mtu, struct btusb_data *data)
+{
+	int i, offset = 0;
+	unsigned int interval;
+
+	BT_DBG("len %d mtu %d", len, mtu);
+
+	/* For msbc ALT 6 setting the host will send the packet at continuous
+	 * flow. As per core spec 5, vol 4, part B, table 2.1. For ALT setting
+	 * 6 the HCI PACKET INTERVAL should be 7.5ms for every usb packets.
+	 * To maintain the rate we send 63bytes of usb packets alternatively for
+	 * 7ms and 8ms to maintain the rate as 7.5ms.
+	 */
+	if (data->usb_alt6_packet_flow) {
+		interval = 7;
+		data->usb_alt6_packet_flow = false;
+	} else {
+		interval = 6;
+		data->usb_alt6_packet_flow = true;
+	}
+
+	for (i = 0; i < interval; i++) {
+		urb->iso_frame_desc[i].offset = offset;
+		urb->iso_frame_desc[i].length = offset;
+	}
+
+	if (len && i < BTUSB_MAX_ISOC_FRAMES) {
+		urb->iso_frame_desc[i].offset = offset;
+		urb->iso_frame_desc[i].length = len;
+		i++;
+	}
+
+	urb->number_of_packets = i;
+}
+
 static inline void __fill_isoc_descriptor(struct urb *urb, int len, int mtu)
 {
 	int i, offset = 0;
@@ -1386,9 +1424,13 @@ static struct urb *alloc_isoc_urb(struct hci_dev *hdev, struct sk_buff *skb)
 
 	urb->transfer_flags  = URB_ISO_ASAP;
 
-	__fill_isoc_descriptor(urb, skb->len,
-			       le16_to_cpu(data->isoc_tx_ep->wMaxPacketSize));
-
+	if (data->isoc_altsetting == 6)
+		__fill_isoc_descriptor_msbc(urb, skb->len,
+					    le16_to_cpu(data->isoc_tx_ep->wMaxPacketSize),
+					    data);
+	else
+		__fill_isoc_descriptor(urb, skb->len,
+				       le16_to_cpu(data->isoc_tx_ep->wMaxPacketSize));
 	skb->dev = (void *)hdev;
 
 	return urb;
@@ -1484,6 +1526,7 @@ static void btusb_notify(struct hci_dev *hdev, unsigned int evt)
 
 	if (hci_conn_num(hdev, SCO_LINK) != data->sco_num) {
 		data->sco_num = hci_conn_num(hdev, SCO_LINK);
+		data->air_mode = evt;
 		schedule_work(&data->work);
 	}
 }
@@ -1531,11 +1574,65 @@ static inline int __set_isoc_interface(struct hci_dev *hdev, int altsetting)
 	return 0;
 }
 
+static int bt_switch_alt_setting(struct hci_dev *hdev, int new_alts)
+{
+	struct btusb_data *data = hci_get_drvdata(hdev);
+	int err;
+
+	if (data->isoc_altsetting != new_alts) {
+		unsigned long flags;
+
+		clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
+		usb_kill_anchored_urbs(&data->isoc_anchor);
+
+		/* When isochronous alternate setting needs to be
+		 * changed, because SCO connection has been added
+		 * or removed, a packet fragment may be left in the
+		 * reassembling state. This could lead to wrongly
+		 * assembled fragments.
+		 *
+		 * Clear outstanding fragment when selecting a new
+		 * alternate setting.
+		 */
+		spin_lock_irqsave(&data->rxlock, flags);
+		kfree_skb(data->sco_skb);
+		data->sco_skb = NULL;
+		spin_unlock_irqrestore(&data->rxlock, flags);
+
+		err = __set_isoc_interface(hdev, new_alts);
+		if (err < 0)
+			return err;
+	}
+	if (!test_and_set_bit(BTUSB_ISOC_RUNNING, &data->flags)) {
+		if (btusb_submit_isoc_urb(hdev, GFP_KERNEL) < 0)
+			clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
+		else
+			btusb_submit_isoc_urb(hdev, GFP_KERNEL);
+	}
+
+	return 0;
+}
+
+static struct usb_host_interface *btusb_find_altsetting(struct btusb_data *data, int alt)
+{
+	struct usb_interface *intf = data->isoc;
+	int i;
+
+	BT_DBG("Looking for Alt no :%d", alt);
+
+	for (i = 0; i < intf->num_altsetting; i++) {
+		if (intf->altsetting[i].desc.bAlternateSetting == alt)
+			return &intf->altsetting[i];
+	}
+
+	return NULL;
+}
+
 static void btusb_work(struct work_struct *work)
 {
 	struct btusb_data *data = container_of(work, struct btusb_data, work);
 	struct hci_dev *hdev = data->hdev;
-	int new_alts;
+	int new_alts = 0;
 	int err;
 
 	if (data->sco_num > 0) {
@@ -1550,44 +1647,28 @@ static void btusb_work(struct work_struct *work)
 			set_bit(BTUSB_DID_ISO_RESUME, &data->flags);
 		}
 
-		if (hdev->voice_setting & 0x0020) {
-			static const int alts[3] = { 2, 4, 5 };
-
-			new_alts = alts[data->sco_num - 1];
-		} else {
-			new_alts = data->sco_num;
-		}
-
-		if (data->isoc_altsetting != new_alts) {
-			unsigned long flags;
+		if (data->air_mode == HCI_NOTIFY_ENABLE_SCO_CVSD) {
+			if (hdev->voice_setting & 0x0020) {
+				static const int alts[3] = { 2, 4, 5 };
 
-			clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
-			usb_kill_anchored_urbs(&data->isoc_anchor);
-
-			/* When isochronous alternate setting needs to be
-			 * changed, because SCO connection has been added
-			 * or removed, a packet fragment may be left in the
-			 * reassembling state. This could lead to wrongly
-			 * assembled fragments.
-			 *
-			 * Clear outstanding fragment when selecting a new
-			 * alternate setting.
-			 */
-			spin_lock_irqsave(&data->rxlock, flags);
-			kfree_skb(data->sco_skb);
-			data->sco_skb = NULL;
-			spin_unlock_irqrestore(&data->rxlock, flags);
+				new_alts = alts[data->sco_num - 1];
+			} else {
+				new_alts = data->sco_num;
+			}
+		} else if (data->air_mode == HCI_NOTIFY_ENABLE_SCO_TRANSP) {
 
-			if (__set_isoc_interface(hdev, new_alts) < 0)
-				return;
-		}
+			data->usb_alt6_packet_flow = true;
 
-		if (!test_and_set_bit(BTUSB_ISOC_RUNNING, &data->flags)) {
-			if (btusb_submit_isoc_urb(hdev, GFP_KERNEL) < 0)
-				clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
+			/* Check if Alt 6 is supported for Transparent audio*/
+			if (btusb_find_altsetting(data, 6))
+				new_alts = 6;
 			else
-				btusb_submit_isoc_urb(hdev, GFP_KERNEL);
+				bt_dev_err(hdev, "(%s) Device does not support ALT setting 6",
+					   hdev->name);
 		}
+
+		if (bt_switch_alt_setting(hdev, new_alts) < 0)
+			bt_dev_err(hdev, "(%s) set USB alt:(%d) failed!", hdev->name, new_alts);
 	} else {
 		clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
 		usb_kill_anchored_urbs(&data->isoc_anchor);
-- 
2.17.1

