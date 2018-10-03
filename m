Return-Path: <SRS0=yBkr=MP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F285C00449
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Oct 2018 14:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4567213A2
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Oct 2018 14:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ucij32ix"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4567213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbeJCVIl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Oct 2018 17:08:41 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:51484 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbeJCVIl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Oct 2018 17:08:41 -0400
Received: by mail-wm1-f43.google.com with SMTP id 143-v6so5888348wmf.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Oct 2018 07:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U7UCl0UQ9bveRuZvE5ZrxpTwu9GcNMGiaoCETVrQDMQ=;
        b=ucij32ixO/vKtPczVn17aHhqf30R1qdFhMiyAQsLLsiebGy1U/sbOge4eytTdyhQaR
         lBdNvl8/FJ74mJy/ILiJB6XJldkKu+flAF5lP7hxFuilt9KnrZju6ocXacTOSDdc92+Y
         rz04vdD5HziMAddigVOW/Tr3kzlgQVDNP6NadoVvktpo5Urrn/hvaQkRObx/2RWZmXtS
         2D/xXQm/1lZInJ8tqil20R4qbXzzzxOP7gXsloWuydEN3OzANwJEAEfC1oXHiQNYh92F
         wZazFJoM1w8GwmAZZfUdiisnfIJIPBVNWvp74RtrtCSLHivmCp6/byYcBUJHQt1w2CD0
         g6qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U7UCl0UQ9bveRuZvE5ZrxpTwu9GcNMGiaoCETVrQDMQ=;
        b=BjQfxpO2/PrqsBZHLBssb/ve4BOGTjKRZr4pXYGjEnXYfoZZQQr1MbAXGxVLnzFFE4
         YHkozp7Lyq1/1LfpFc5cK0Hgpi9O0KssBoNQ8TrbkXvm88f1bSheqwGUeAg18aLEaSmL
         l/KEnaWa8sllSakEjFsxonTnIaVKOtBWc/HSJVpottlkflKxUFDqDDDSPLX0Cza430iq
         Lw3kHzxTBa8k7UitEAdzyd3IRbKsuCJ8A7rbdEXkqnsqvjk56XEYLYXa+UHjzsj4pxt8
         xr5s5eRWAJo7qUPdp2ZZwURoOb7H6ESGOK0PTpGMgQTFTsKTvfVCDcpZBzP/mg8OcP5e
         8cJQ==
X-Gm-Message-State: ABuFfoiYwVyKN7aNNEYk8SEt637FPhkrAM5bQy9UliEPuo+8oQdBMrAP
        BHtbp2epN5djuBR+fqTIpnE=
X-Google-Smtp-Source: ACcGV62ikZX7M39Yb9Q52NJ73EUKsnqnaCitGF+0eyT3WWac4s00akZ+xzBiF/6kMMzLJYbBj6+baw==
X-Received: by 2002:a1c:9616:: with SMTP id y22-v6mr1612098wmd.72.1538576403009;
        Wed, 03 Oct 2018 07:20:03 -0700 (PDT)
Received: from xps.lan (static-css-csd-151233.business.bouyguestelecom.com. [176.162.151.233])
        by smtp.gmail.com with ESMTPSA id a6-v6sm1948533wmf.22.2018.10.03.07.20.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Oct 2018 07:20:02 -0700 (PDT)
Date:   Wed, 3 Oct 2018 16:20:00 +0200
From:   fabien dvlt <fabiendvlt@gmail.com>
To:     Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: Re: Security block and Bluez - connection issue with Android
Message-ID: <20181003141959.GA5359@xps.lan>
References: <CAOiLkfOuenvh5ZLQD_k-yi7mL1Epr+gGJZ65zr2Fcp2SzE9F7w@mail.gmail.com>
 <20180926112801.GA8013@x1c.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926112801.GA8013@x1c.lan>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Thank you both for your reply. Since you and Luiz answered, I have
been trying to do a better workaround at USB/HCI level instead of
L2CAP.

I understand this issue is more related to the firmware implementation
but for those who really need it, I think the patch below is a better
approach than the first I have submitted.

It will start queueing ACL packets when link key exchange begins until
the next HCI event. It still have some limitations I wish to fix soon
(see patch below).

I have a question about what I have read in bluetooth specifications:
 
 Version 5.0, Vol 2, Part C, - 4.2.5.1 Encryption Mode

   "ACL-U logical link traffic shall only be resumed after the attempt
   to encrypt or decrypt the logical transport is completed"

I was wondering if this would guarantee that no unencrypted connection
request could be forwarded to other layer once the link key exchange
has started.

Thank you

---

From bd17d5e519c2ad76ef1761b2d066d98ec4c723d1 Mon Sep 17 00:00:00 2001
From: fabien filhol <fabien.filhol@devialet.com>
Date: Wed, 3 Oct 2018 12:06:30 +0200
Subject: [PATCH] Bluetooth: btusb: Fix race condition between BT events and
 ACL

Workaround for a race condition observed with Android phones which makes
fail some connections (30% with a Oneplus 6).

After link key reply it is expected that HCI_EV_ENCRYPT_CHANGE is received
before any ACL connection request or it will be dropped by bluez L2CAP
layer.

The events are received from usb interrupt transfer and ACL packet from usb
bulk transfer. I guess the bluetooth controller does not handle correctly
write ordering between those two transfer types.

The workaround will start queueing ACL packets when link key are exchanged until
the next real event (other than HCI_EV_CMD_COMPLETE) is received, it should
be HCI_EV_ENCRYPT_CHANGE.

LIMITATIONS:

An unencrypted connection request forwarded by the controller at
"ACL queueing time" could pass. Bluetooth specification says that ACL
transfer is paused until encryption is setup so I hope it is safe to queue
ACL between HCI_EV_LINK_KEY_REQ and HCI_EV_CMD_COMPLETE.

With concurrent connections from multiple bluetooth devices the workaround
could not work as any event from any device would flush the queue.
---
 drivers/bluetooth/btusb.c | 50 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index bff67c5a5fe7..c55096fa8c4e 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -406,6 +406,9 @@ struct btusb_data {
 	struct sk_buff *acl_skb;
 	struct sk_buff *sco_skb;
 
+	struct sk_buff_head acl_deferred_q;
+	int acl_deferred;
+
 	struct usb_endpoint_descriptor *intr_ep;
 	struct usb_endpoint_descriptor *bulk_tx_ep;
 	struct usb_endpoint_descriptor *bulk_rx_ep;
@@ -449,6 +452,7 @@ static int btusb_recv_intr(struct btusb_data *data, void *buffer, int count)
 {
 	struct sk_buff *skb;
 	int err = 0;
+	int event = HCI_OP_NOP;
 
 	spin_lock(&data->rxlock);
 	skb = data->evt_skb;
@@ -488,6 +492,9 @@ static int btusb_recv_intr(struct btusb_data *data, void *buffer, int count)
 		}
 
 		if (!hci_skb_expect(skb)) {
+			struct hci_event_hdr *hdr = (struct hci_event_hdr *)skb->data;
+			event = hdr->evt;
+
 			/* Complete frame */
 			data->recv_event(data->hdev, skb);
 			skb = NULL;
@@ -495,6 +502,39 @@ static int btusb_recv_intr(struct btusb_data *data, void *buffer, int count)
 	}
 
 	data->evt_skb = skb;
+
+	/*
+	 * Workaround for a race condition observed with Android phones. After link
+	 * key reply it is expected that HCI_EV_ENCRYPT_CHANGE is received before
+	 * any ACL connection request or it will be dropped by bluez L2CAP layer.
+	 *
+	 * The events are received from usb interrupt transfer and ACL packet from
+	 * usb bulk transfer. I guess the bluetooth controller does not handle
+	 * correctly write ordering between those two transfer types.
+	 *
+	 * The workaround will start queueing ACL packets when link key are exchanged
+	 * until the next real event (not an HCI_EV_CMD_COMPLETE) is received, it
+	 * should be HCI_EV_ENCRYPT_CHANGE.
+	 *
+	 * LIMITATIONS:
+	 *
+	 * An unencrypted connection request forwarded by the controller at
+	 * "ACL queueing time" would pass. Bluetooth specification says that ACL
+	 * transfer is paused until encryption is setup so I hope it is safe to queue
+	 * ACL between HCI_EV_LINK_KEY_REQ and HCI_EV_CMD_COMPLETE.
+	 *
+	 * With concurrent connections from multiple bluetooth devices the workaround
+	 * could not work as any event from any device would flush the queue.
+	 */
+	if (event == HCI_EV_LINK_KEY_REQ) {
+		data->acl_deferred = 1;
+	} else if (data->acl_deferred && event != HCI_EV_CMD_COMPLETE) {
+		while ((skb = skb_dequeue(&data->acl_deferred_q)))
+			hci_recv_frame(data->hdev, skb);
+		skb = NULL;
+		data->acl_deferred = 0;
+	}
+
 	spin_unlock(&data->rxlock);
 
 	return err;
@@ -546,7 +586,10 @@ static int btusb_recv_bulk(struct btusb_data *data, void *buffer, int count)
 
 		if (!hci_skb_expect(skb)) {
 			/* Complete frame */
-			hci_recv_frame(data->hdev, skb);
+			if (data->acl_deferred)
+				skb_queue_tail(&data->acl_deferred_q, skb);
+			else
+				hci_recv_frame(data->hdev, skb);
 			skb = NULL;
 		}
 	}
@@ -2815,6 +2858,9 @@ static int btusb_probe(struct usb_interface *intf,
 	data->udev = interface_to_usbdev(intf);
 	data->intf = intf;
 
+	data->acl_deferred = 0;
+	skb_queue_head_init(&data->acl_deferred_q);
+
 	INIT_WORK(&data->work, btusb_work);
 	INIT_WORK(&data->waker, btusb_waker);
 	init_usb_anchor(&data->deferred);
@@ -3051,6 +3097,8 @@ static void btusb_disconnect(struct usb_interface *intf)
 	if (!data)
 		return;
 
+	skb_queue_purge(&data->acl_deferred_q);
+
 	hdev = data->hdev;
 	usb_set_intfdata(data->intf, NULL);
 
-- 
2.17.1


On Wed, Sep 26, 2018 at 02:28:01PM +0300, Johan Hedberg wrote:
> Hi Fabien,
> 
> On Tue, Sep 25, 2018, fabien dvlt wrote:
> > > ACL Data RX: Handle 13 flags 0x02 dlen 12           #198 [hci0] 21.813116
> >       L2CAP: Connection Request (0x02) ident 7 len 4
> >         PSM: 25 (0x0019)
> >         Source CID: 75
> > > HCI Event: Encryption Change (0x08) plen 4          #199 [hci0] 21.813155
> >         Status: Success (0x00)
> >         Handle: 13
> >         Encryption: Enabled with AES-CCM (0x02)
> > < ACL Data TX: Handle 13 flags 0x00 dlen 16           #200 [hci0]
> >       L2CAP: Connection Response (0x03) ident 7 len 8
> >         Destination CID: 0
> >         Source CID: 75
> >         Result: Connection refused - security block (0x0003)
> >         Status: No further information available (0x0000)
> 
> This looks like the well-known race condition for ACL data and HCI
> events on USB where the two come through different endpoints. From the
> host perspective there's not much we can do since we can't make
> assumptions that the connection request was sent over an encrypted
> connection if we haven't seen the encryption change request at that
> point.
> 
> Johan
