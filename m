Return-Path: <SRS0=NoyY=YH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A4DC47404
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Oct 2019 05:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29BA620873
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Oct 2019 05:39:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbfJNFjB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Oct 2019 01:39:01 -0400
Received: from mga03.intel.com ([134.134.136.65]:31237 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbfJNFjB (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Oct 2019 01:39:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Oct 2019 22:39:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,294,1566889200"; 
   d="scan'208";a="278765263"
Received: from kmsmsx156.gar.corp.intel.com ([172.21.138.133])
  by orsmga001.jf.intel.com with ESMTP; 13 Oct 2019 22:38:59 -0700
Received: from pgsmsx105.gar.corp.intel.com ([169.254.4.226]) by
 KMSMSX156.gar.corp.intel.com ([169.254.1.23]) with mapi id 14.03.0439.000;
 Mon, 14 Oct 2019 13:38:56 +0800
From:   "Bag, Amit K" <amit.k.bag@intel.com>
To:     "'linux-bluetooth@vger.kernel.org'" <linux-bluetooth@vger.kernel.org>
CC:     "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>,
        "Narasimman, Sathish" <sathish.narasimman@intel.com>,
        "Hegde, Raghuram" <raghuram.hegde@intel.com>,
        Hsin-Yu Chao <hychao@chromium.org>
Subject: RE: [PATCH v2] Bluetooth: btusb: hci_event: handle msbc audio over
 USB Endpoints
Thread-Topic: [PATCH v2] Bluetooth: btusb: hci_event: handle msbc audio over
 USB Endpoints
Thread-Index: AQHVdOpxD8XXwh17WEayMj8sM05jOKdZuI5g
Date:   Mon, 14 Oct 2019 05:38:55 +0000
Message-ID: <EFE6F46E14A5F445949D76A8CAC2240058458279@PGSMSX105.gar.corp.intel.com>
References: <1569557518-16750-1-git-send-email-amit.k.bag@intel.com>
In-Reply-To: <1569557518-16750-1-git-send-email-amit.k.bag@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZWVlM2JjMDMtNWYyMy00MzdhLWJiOWItNDVhODFlNTY3NGY2IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiZSs4bWhRZGpOdG1VYnptZ2lETXZDMndkRlJEZ1AyZ051UXEzZHRNMW4xK1wvMGU3SnIrQ2Fha0ZTNnR4emNBV3UifQ==
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [172.30.20.205]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

>For msbc encoded audio stream over usb transport, btusb driver to be set to alternate settings 6 as per BT core spec 5.0. This done from  hci_sync_conn_complete_evt.  The type of air mode is known during this event.  For this reason the btusb is to be notifed about the TRANSPARENT air mode and the ALT setting 6 is selected.
>The changes are made considering some discussion over the similar patch submitted earlier from Kuba Pawlak(link below) https://www.spinics.net/lists/linux-bluetooth/msg64577.html
>
>(am from https://www.spinics.net/lists/linux-bluetooth/msg76982.html)
>
>Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
>Signed-off-by: Sathish Narasimman <sathish.narasimman@intel.com>
>Signed-off-by: Raghuram Hegde <raghuram.hegde@intel.com>
>Signed-off-by: Hsin-Yu Chao <hychao@chromium.org>
>Signed-off-by: Amit K Bag <amit.k.bag@intel.com>
>
>Signed-off-by: Amit K Bag <amit.k.bag@intel.com>
>---
> drivers/bluetooth/btusb.c   | 138 +++++++++++++++++++++++++++++---------------
> include/net/bluetooth/hci.h |   1 +
> net/bluetooth/hci_event.c   |   5 ++
> 3 files changed, 99 insertions(+), 45 deletions(-)
>
>diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c index a9c35ebb30f8..f52acced68f8 100644
>--- a/drivers/bluetooth/btusb.c
>+++ b/drivers/bluetooth/btusb.c
>@@ -57,6 +57,9 @@ static struct usb_driver btusb_driver;
> #define BTUSB_IFNUM_2		0x80000
> #define BTUSB_CW6622		0x100000
> #define BTUSB_MEDIATEK		0x200000
>+#define BTUSB_ALT6_FLOW_CNTRL	6
>+
>+static int set_hci_packet_interval_flow = BTUSB_ALT6_FLOW_CNTRL;
> 
> static const struct usb_device_id btusb_table[] = {
> 	/* Generic Bluetooth USB device */
>@@ -974,6 +977,38 @@ static void btusb_isoc_complete(struct urb *urb)
> 	}
> }
> 
>+static inline void __fill_isoc_descriptor_msbc(struct urb *urb, int len,
>+					       int mtu)
>+{
>+	int i, offset = 0;
>+
>+	/* For msbc ALT 6 setting the host will send the packet at continuous
>+	 * flow. As per core spec 5, vol 4, part B, table 2.1. For ALT setting
>+	 * 6 the HCI PACKET INTERVAL should be 7.5ms for every usb packets.
>+	 * To maintain the rate we send 63bytes of usb packets alternatively for
>+	 * 7ms and 8ms to maintain the rate as 7.5ms.
>+	 */
>+	if (set_hci_packet_interval_flow == 6)
>+		set_hci_packet_interval_flow = 7;
>+	else if (set_hci_packet_interval_flow == 7)
>+		set_hci_packet_interval_flow = 6;
>+
>+	BT_DBG("len %d mtu %d", len, mtu);
>+
>+	for (i = 0; i < set_hci_packet_interval_flow; i++) {
>+		urb->iso_frame_desc[i].offset = offset;
>+		urb->iso_frame_desc[i].length = offset;
>+	}
>+
>+	if (len && i < BTUSB_MAX_ISOC_FRAMES) {
>+		urb->iso_frame_desc[i].offset = offset;
>+		urb->iso_frame_desc[i].length = len;
>+		i++;
>+	}
>+
>+	urb->number_of_packets = i;
>+}
>+
> static inline void __fill_isoc_descriptor(struct urb *urb, int len, int mtu)  {
> 	int i, offset = 0;
>@@ -1376,9 +1411,12 @@ static struct urb *alloc_isoc_urb(struct hci_dev *hdev, struct sk_buff *skb)
> 
> 	urb->transfer_flags  = URB_ISO_ASAP;
> 
>-	__fill_isoc_descriptor(urb, skb->len,
>+	if (data->isoc_altsetting == 6)
>+		__fill_isoc_descriptor_msbc(urb, skb->len,
>+			       le16_to_cpu(data->isoc_tx_ep->wMaxPacketSize));
>+	else
>+		__fill_isoc_descriptor(urb, skb->len,
> 			       le16_to_cpu(data->isoc_tx_ep->wMaxPacketSize));
>-
> 	skb->dev = (void *)hdev;
> 
> 	return urb;
>@@ -1466,18 +1504,6 @@ static int btusb_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
> 	return -EILSEQ;
> }
> 
>-static void btusb_notify(struct hci_dev *hdev, unsigned int evt) -{
>-	struct btusb_data *data = hci_get_drvdata(hdev);
>-
>-	BT_DBG("%s evt %d", hdev->name, evt);
>-
>-	if (hci_conn_num(hdev, SCO_LINK) != data->sco_num) {
>-		data->sco_num = hci_conn_num(hdev, SCO_LINK);
>-		schedule_work(&data->work);
>-	}
>-}
>-
> static inline int __set_isoc_interface(struct hci_dev *hdev, int altsetting)  {
> 	struct btusb_data *data = hci_get_drvdata(hdev); @@ -1521,6 +1547,58 @@ static inline int __set_isoc_interface(struct hci_dev *hdev, int altsetting)
> 	return 0;
> }
> 
>+static int bt_switch_alt_setting(struct hci_dev *hdev, int new_alts) {
>+	struct btusb_data *data = hci_get_drvdata(hdev);
>+	int err;
>+
>+	if (data->isoc_altsetting != new_alts) {
>+		unsigned long flags;
>+
>+		clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
>+		usb_kill_anchored_urbs(&data->isoc_anchor);
>+
>+		/* When isochronous alternate setting needs to be
>+		 * changed, because SCO connection has been added
>+		 * or removed, a packet fragment may be left in the
>+		 * reassembling state. This could lead to wrongly
>+		 * assembled fragments.
>+		 *
>+		 * Clear outstanding fragment when selecting a new
>+		 * alternate setting.
>+		 */
>+		spin_lock_irqsave(&data->rxlock, flags);
>+		kfree_skb(data->sco_skb);
>+		data->sco_skb = NULL;
>+		spin_unlock_irqrestore(&data->rxlock, flags);
>+
>+		err = __set_isoc_interface(hdev, new_alts);
>+		if (err < 0)
>+			return err;
>+	}
>+	if (!test_and_set_bit(BTUSB_ISOC_RUNNING, &data->flags)) {
>+		if (btusb_submit_isoc_urb(hdev, GFP_KERNEL) < 0)
>+			clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
>+		else
>+			btusb_submit_isoc_urb(hdev, GFP_KERNEL);
>+	}
>+
>+	return 0;
>+}
>+
>+static void btusb_notify(struct hci_dev *hdev, unsigned int evt) {
>+	struct btusb_data *data = hci_get_drvdata(hdev);
>+
>+	BT_DBG("%s evt %d", hdev->name, evt);
>+
>+	if (hci_conn_num(hdev, SCO_LINK) != data->sco_num) {
>+		data->sco_num = hci_conn_num(hdev, SCO_LINK);
>+		schedule_work(&data->work);
>+	}
>+
>+}
>+
> static void btusb_work(struct work_struct *work)  {
> 	struct btusb_data *data = container_of(work, struct btusb_data, work); @@ -1547,37 +1625,7 @@ static void btusb_work(struct work_struct *work)
> 		} else {
> 			new_alts = data->sco_num;
> 		}
>-
>-		if (data->isoc_altsetting != new_alts) {
>-			unsigned long flags;
>-
>-			clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
>-			usb_kill_anchored_urbs(&data->isoc_anchor);
>-
>-			/* When isochronous alternate setting needs to be
>-			 * changed, because SCO connection has been added
>-			 * or removed, a packet fragment may be left in the
>-			 * reassembling state. This could lead to wrongly
>-			 * assembled fragments.
>-			 *
>-			 * Clear outstanding fragment when selecting a new
>-			 * alternate setting.
>-			 */
>-			spin_lock_irqsave(&data->rxlock, flags);
>-			kfree_skb(data->sco_skb);
>-			data->sco_skb = NULL;
>-			spin_unlock_irqrestore(&data->rxlock, flags);
>-
>-			if (__set_isoc_interface(hdev, new_alts) < 0)
>-				return;
>-		}
>-
>-		if (!test_and_set_bit(BTUSB_ISOC_RUNNING, &data->flags)) {
>-			if (btusb_submit_isoc_urb(hdev, GFP_KERNEL) < 0)
>-				clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
>-			else
>-				btusb_submit_isoc_urb(hdev, GFP_KERNEL);
>-		}
>+		bt_switch_alt_setting(hdev, new_alts);
> 	} else {
> 		clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
> 		usb_kill_anchored_urbs(&data->isoc_anchor);
>diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h index 5bc1e30dedde..89ac29f1dffa 100644
>--- a/include/net/bluetooth/hci.h
>+++ b/include/net/bluetooth/hci.h
>@@ -52,6 +52,7 @@
> #define HCI_NOTIFY_CONN_ADD		1
> #define HCI_NOTIFY_CONN_DEL		2
> #define HCI_NOTIFY_VOICE_SETTING	3
>+#define HCI_NOTIFY_AIR_MODE_TRANSP	4
> 
> /* HCI bus types */
> #define HCI_VIRTUAL	0
>diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c index c1d3a303d97f..1c268932422c 100644
>--- a/net/bluetooth/hci_event.c
>+++ b/net/bluetooth/hci_event.c
>@@ -4231,6 +4231,11 @@ static void hci_sync_conn_complete_evt(struct hci_dev *hdev,
> 		break;
> 	}
> 
>+	if (ev->air_mode == SCO_AIRMODE_TRANSP) {
>+		if (hdev->notify)
>+			hdev->notify(hdev, HCI_NOTIFY_AIR_MODE_TRANSP);
>+	}
>+
> 	hci_connect_cfm(conn, ev->status);
> 	if (ev->status)
> 		hci_conn_del(conn);
>

Anything pending in this patch to be merged. 
