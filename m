Return-Path: <SRS0=pK2I=ZD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DABC43331
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Nov 2019 11:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBFCB214DB
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Nov 2019 11:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CeE7jxJl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfKKLRn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Nov 2019 06:17:43 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43695 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbfKKLRn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Nov 2019 06:17:43 -0500
Received: by mail-pf1-f195.google.com with SMTP id 3so10478688pfb.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Nov 2019 03:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=B9pJ1aJH3lZWSBIkvoZvCRxbPN/F01go6ayo1hZDNr8=;
        b=CeE7jxJl+Dn3F8S3a0fN6G+7wOCvf4E4Oj2p1Pyt7P/6VHYw1VvuH2kKIWtWQtXNIX
         oaCHlunHm6f5j5sgDF50VXmICRUJjQWqf3BVS81t6wHYEOBMI1hTgIk+FfoGTMxBPzoh
         5HcUxhoTpCRLsuRxJKyTs8qQSt2j72YyctvCJEcgTF3De490hxm6ej9GdDgM1c74bKQ9
         VoHMMPA3TnmsNJrhnYbveGBXY/Vem+vaVT/DL7MKle2l3vnxRapz8bFmhRmsTf1DHOcG
         hCNJCiMl8RARCfQ94u7AXBgEHjKJ/v0shdANg+U+ib6FbvZD4TNc3YbXsFv/i+dci74l
         kLiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=B9pJ1aJH3lZWSBIkvoZvCRxbPN/F01go6ayo1hZDNr8=;
        b=lavukPjKELSDuvKCHcCvmPFNctiqu4SmwNnkAlbXtCUWtZCcaKCGxr7MiXAxBhnj5h
         OsPujskevkAWXjWCNLgZS+k7cMhfHEirheV/fbcghiJkTYVPCRVUYWLEcNPjof5a+51A
         ozy8Q+vKz/S7rABmlu1vcCgco5fWU76VnJSz2g19IH1pqU+DrbBB/nNZR9UKOTTrZQVq
         RTff5whardbl82chjyeb5eEPT9R9tQJgJ61ydgzJ6YrT/kd7MFG+cHmIlA4A7Yt9JZxr
         PZTZa5Tu1t9oUSSp17Ldg/6GqdilnqXKiAtCkwfc2nG7gweaWb4Btl1DXKcUFtfXLJmG
         oniA==
X-Gm-Message-State: APjAAAXoSFDUlddrQv+opW3Kw65RWszhKDyqoOnFokqWkrPHe70E02aJ
        KikRl6ZMLmwzMD9vbe4K0kbayo1t1giFXBk1
X-Google-Smtp-Source: APXvYqwSOMqPcUhQtOzvXXesX3C4i6uWjd9PyGlONlW/MW3Kd6oOcCQYbsXvEZKWcSeKcxVbFKPrLw==
X-Received: by 2002:aa7:93a7:: with SMTP id x7mr6673930pff.36.1573471060187;
        Mon, 11 Nov 2019 03:17:40 -0800 (PST)
Received: from nsathish-Latitude-7480.iind.intel.com ([192.55.54.44])
        by smtp.gmail.com with ESMTPSA id 186sm3042234pfe.141.2019.11.11.03.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 03:17:39 -0800 (PST)
From:   Sathish Narsimman <nsathish41@gmail.com>
X-Google-Original-From: Sathish Narsimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sathish Narasimman <sathish.narasimman@intel.com>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Hsin-Yu Chao <hychao@chromium.org>,
        Amit K Bag <amit.k.bag@intel.com>
Subject: [PATCH v2] Bluetooth: btusb: hci_event: handle msbc audio over USB Endpoints
Date:   Mon, 11 Nov 2019 16:47:35 +0530
Message-Id: <20191111111735.7467-1-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Sathish Narasimman <sathish.narasimman@intel.com>

For msbc encoded audio stream over usb transport, btusb driver
to be set to alternate settings 6 as per BT core spec 5.0. This
done from  hci_sync_conn_complete_evt.  The type of air mode is known
during this event.  For this reason the btusb is to be notifed
about the TRANSPARENT air mode and the ALT setting 6 is selected.
The changes are made considering some discussion over the similar
patch submitted earlier from Kuba Pawlak(link below)
https://www.spinics.net/lists/linux-bluetooth/msg64577.html

(am from https://www.spinics.net/lists/linux-bluetooth/msg76982.html)

Signed-off-by: Sathish Narasimman <sathish.narasimman@intel.com>
Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Signed-off-by: Hsin-Yu Chao <hychao@chromium.org>
Signed-off-by: Amit K Bag <amit.k.bag@intel.com>
---
 drivers/bluetooth/btusb.c        | 155 ++++++++++++++++++++++++-------
 include/net/bluetooth/hci.h      |   7 +-
 include/net/bluetooth/hci_core.h |   3 +
 net/bluetooth/hci_conn.c         |   2 -
 net/bluetooth/hci_event.c        |   9 ++
 5 files changed, 136 insertions(+), 40 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 04a139e7793f..1615d9dc0f16 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -483,6 +483,8 @@ struct btusb_data {
 	__u8 cmdreq;
 
 	unsigned int sco_num;
+	unsigned int air_mode;
+	bool usb_alt6_packet_flow;
 	int isoc_altsetting;
 	int suspend_count;
 
@@ -974,6 +976,42 @@ static void btusb_isoc_complete(struct urb *urb)
 	}
 }
 
+static inline void __fill_isoc_descriptor_msbc(struct urb *urb, int len,
+					       int mtu, bool packet_flow)
+{
+	int i, offset = 0;
+	unsigned int interval;
+
+	/* For msbc ALT 6 setting the host will send the packet at continuous
+	 * flow. As per core spec 5, vol 4, part B, table 2.1. For ALT setting
+	 * 6 the HCI PACKET INTERVAL should be 7.5ms for every usb packets.
+	 * To maintain the rate we send 63bytes of usb packets alternatively for
+	 * 7ms and 8ms to maintain the rate as 7.5ms.
+	 */
+	if (packet_flow) {
+		interval = 7;
+		packet_flow = false;
+	} else {
+		interval = 6;
+		packet_flow = true;
+	}
+
+	BT_DBG("interval:%d len %d mtu %d", interval, len, mtu);
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
@@ -1376,9 +1414,13 @@ static struct urb *alloc_isoc_urb(struct hci_dev *hdev, struct sk_buff *skb)
 
 	urb->transfer_flags  = URB_ISO_ASAP;
 
-	__fill_isoc_descriptor(urb, skb->len,
+	if (data->isoc_altsetting == 6)
+		__fill_isoc_descriptor_msbc(urb, skb->len,
+			       le16_to_cpu(data->isoc_tx_ep->wMaxPacketSize),
+			       data->usb_alt6_packet_flow);
+	else
+		__fill_isoc_descriptor(urb, skb->len,
 			       le16_to_cpu(data->isoc_tx_ep->wMaxPacketSize));
-
 	skb->dev = (void *)hdev;
 
 	return urb;
@@ -1474,6 +1516,7 @@ static void btusb_notify(struct hci_dev *hdev, unsigned int evt)
 
 	if (hci_conn_num(hdev, SCO_LINK) != data->sco_num) {
 		data->sco_num = hci_conn_num(hdev, SCO_LINK);
+		data->air_mode = evt;
 		schedule_work(&data->work);
 	}
 }
@@ -1521,6 +1564,65 @@ static inline int __set_isoc_interface(struct hci_dev *hdev, int altsetting)
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
+	if (intf == NULL) {
+		BT_ERR("INterface NULL");
+		return NULL;
+	}
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
@@ -1540,44 +1642,27 @@ static void btusb_work(struct work_struct *work)
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
+				BT_ERR("%s Device does not support ALT setting 6", hdev->name);
 		}
+
+		if (bt_switch_alt_setting(hdev, new_alts) < 0)
+			BT_ERR("%s Set USB Alt: %d failed!", hdev->name, new_alts);
 	} else {
 		clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
 		usb_kill_anchored_urbs(&data->isoc_anchor);
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 5bc1e30dedde..8183394c2cc0 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -49,9 +49,10 @@
 #define HCI_DEV_SETUP			9
 
 /* HCI notify events */
-#define HCI_NOTIFY_CONN_ADD		1
-#define HCI_NOTIFY_CONN_DEL		2
-#define HCI_NOTIFY_VOICE_SETTING	3
+#define HCI_NOTIFY_ENABLE_SCO_CVSD	1
+#define HCI_NOTIFY_ENABLE_SCO_TRANSP	2
+#define HCI_NOTIFY_CONN_DEL		3
+#define HCI_NOTIFY_VOICE_SETTING	4
 
 /* HCI bus types */
 #define HCI_VIRTUAL	0
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index b689aceb636b..c4a2c3efb4b7 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1604,4 +1604,7 @@ void hci_copy_identity_address(struct hci_dev *hdev, bdaddr_t *bdaddr,
 #define SCO_AIRMODE_CVSD       0x0000
 #define SCO_AIRMODE_TRANSP     0x0003
 
+#define SCO_CODED_CVSD             0x02
+#define SCO_CODED_TRANSP           0x03
+
 #endif /* __HCI_CORE_H */
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 7ff92dd4c53c..3a9a4b1c2bb2 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -561,8 +561,6 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
 	hci_dev_hold(hdev);
 
 	hci_conn_hash_add(hdev, conn);
-	if (hdev->notify)
-		hdev->notify(hdev, HCI_NOTIFY_CONN_ADD);
 
 	hci_conn_init_sysfs(conn);
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index c1d3a303d97f..7cf0e5135cd8 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4231,6 +4231,15 @@ static void hci_sync_conn_complete_evt(struct hci_dev *hdev,
 		break;
 	}
 
+	BT_DBG("Air Mode: %02x", ev->air_mode);
+	if (ev->air_mode == SCO_CODED_CVSD) {
+		if (hdev->notify)
+			hdev->notify(hdev, HCI_NOTIFY_ENABLE_SCO_CVSD);
+	} else if (ev->air_mode == SCO_CODED_TRANSP) {
+		if (hdev->notify)
+			hdev->notify(hdev, HCI_NOTIFY_ENABLE_SCO_TRANSP);
+	}
+
 	hci_connect_cfm(conn, ev->status);
 	if (ev->status)
 		hci_conn_del(conn);
-- 
2.17.1

