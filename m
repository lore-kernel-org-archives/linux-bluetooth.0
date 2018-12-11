Return-Path: <SRS0=Lkqy=OU=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68686C5CFFE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Dec 2018 17:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19B0D2086D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Dec 2018 17:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXxAtyUb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19B0D2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbeLKRNB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 Dec 2018 12:13:01 -0500
Received: from mail-wm1-f41.google.com ([209.85.128.41]:37896 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbeLKRNA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 Dec 2018 12:13:00 -0500
Received: by mail-wm1-f41.google.com with SMTP id m22so3117386wml.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Dec 2018 09:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oYeAeFrW91/zH0NlkSKng6LrB2S7/Qu7XYiXKFu6hOI=;
        b=mXxAtyUb8hU9xDlCX6h18cquFAJwg4vnQaV0H75VDmOz3QBG9ny9xupUtrAZunVFzf
         67i8fXsUNcUwHfPJiDoMBtPhHpJ611dzrZB7K1TPbGk1rYX4LCDRgI6Gh/BijdWqmKWL
         M9qYG8+VC0tkAgZGP+qPPF/zJ9TwwSjEwGQAWsZUbPusrjvvZ5TnR8416gVuPtmJrk4U
         u0tYjeaSfGsJ37qxO5d2ONeujHTXMadp1TRutLowbXbNj3i1M3us2DRm622Wjnp54dNF
         xlKCOF1o8MLQy2SrT5wLYhurh96MQS9rmMKOv629HW78Zo4zlqdI3Lmi7tZWp4G0sCrc
         on4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oYeAeFrW91/zH0NlkSKng6LrB2S7/Qu7XYiXKFu6hOI=;
        b=DVFklpPJWIHiyE3n+d3iRTWGFVF/QmQsbsoMAw3hXTWglGRKGP79Ew8rZK1yKdhl+K
         vHqTXZXxwIFRgpDni03BscU+t/c9fNpEkZ3GWKx3BM0dOlY5wg1c68+i5bW/IvvllUa6
         Ybe1kmzgqEQcpT7OkN7z/XTCapj3PnHPG4KhooLIpEv2SNto3w4By5TZpavuX5SxG8Oq
         BH1qyeINgSGNR+C1SIrXQrJ2CSBzSb5k7vyWjhEkciM+vkA4Ju0Fe6lzCq/3H/TekjJe
         Zg0UgI5WpFEZXb0iH/HUeqGj5NXtAXBjKTQ1P39Fsd9D4wafhPgNste++j6FoV8hL2EO
         OCUw==
X-Gm-Message-State: AA+aEWbZGSAt4TOsljAvwCZR2NWBCjK/9cOkokL98s8dgrpW7j1RaTR9
        uETDi/TSVpIAM5cvkHBPgQWCmoBa5Kc=
X-Google-Smtp-Source: AFSGD/U/Gu3cKx+m9AYW3OCSz59ZyBs+q39d0wM1ia6PCCmh6uQvSirHofqx9WsRb5uRcnZwEYe6dA==
X-Received: by 2002:a1c:a58a:: with SMTP id o132mr3375946wme.6.1544548377787;
        Tue, 11 Dec 2018 09:12:57 -0800 (PST)
Received: from xps.lan (static-css-csd-151233.business.bouyguestelecom.com. [176.162.151.233])
        by smtp.gmail.com with ESMTPSA id 126sm737754wmd.1.2018.12.11.09.12.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 09:12:57 -0800 (PST)
Date:   Tue, 11 Dec 2018 18:12:50 +0100
From:   fabien dvlt <fabiendvlt@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: Re: Security block and Bluez - connection issue with Android
Message-ID: <20181211171249.GA411@xps.lan>
References: <CAOiLkfOuenvh5ZLQD_k-yi7mL1Epr+gGJZ65zr2Fcp2SzE9F7w@mail.gmail.com>
 <20180926112801.GA8013@x1c.lan>
 <20181003141959.GA5359@xps.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181003141959.GA5359@xps.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

I am aware some are using previous patch, here is an update that
improves connections made while other devices are already connected.

It tracks bdaddr and handles from connection event to disconnection
event.

See comments in patch for more details. If you have any trouble or
remarks please let me know.

Fabien

---

--- linux-4.9.137/drivers/bluetooth/btusb.c	2018-12-11 16:42:10.897859304 +0100
+++ linux/drivers/bluetooth/btusb.c	2018-12-11 17:32:02.938800781 +0100
@@ -383,6 +383,21 @@
 #define BTUSB_DIAG_RUNNING	10
 #define BTUSB_OOB_WAKE_ENABLED	11
 
+struct hci_peer {
+	struct list_head list;
+
+	bdaddr_t		bdaddr;
+	__le16			handle;
+	int			acl_deferred;
+	struct sk_buff_head	acl_deferred_q;
+};
+
+struct hci_peer_hash {
+	struct list_head list;
+
+	unsigned int peer_num;
+};
+
 struct btusb_data {
 	struct hci_dev       *hdev;
 	struct usb_device    *udev;
@@ -410,6 +425,9 @@
 	struct sk_buff *acl_skb;
 	struct sk_buff *sco_skb;
 
+	struct hci_peer_hash peer_hash;
+	int acl_deferred_peer;
+
 	struct usb_endpoint_descriptor *intr_ep;
 	struct usb_endpoint_descriptor *bulk_tx_ep;
 	struct usb_endpoint_descriptor *bulk_rx_ep;
@@ -431,6 +449,93 @@
 	int (*setup_on_usb)(struct hci_dev *hdev);
 };
 
+static inline void hci_peer_hash_add(struct btusb_data *data,
+				     struct hci_peer *p)
+{
+	struct hci_peer_hash *h = &data->peer_hash;
+
+	list_add(&p->list, &h->list);
+
+	h->peer_num++;
+}
+
+static inline void hci_peer_hash_del(struct btusb_data *data,
+				     struct hci_peer *p)
+{
+	struct hci_peer_hash *h = &data->peer_hash;
+
+	h->peer_num--;
+
+	list_del(&p->list);
+}
+
+static inline struct hci_peer *hci_peer_hash_lookup_ba(struct btusb_data *data,
+						       bdaddr_t *bdaddr)
+{
+	struct hci_peer *p;
+	struct hci_peer_hash *h = &data->peer_hash;
+
+	list_for_each_entry(p, &h->list, list)
+		if (!bacmp(&p->bdaddr, bdaddr))
+			return p;
+
+	return NULL;
+}
+
+static inline struct hci_peer *
+hci_peer_hash_lookup_handle(struct btusb_data *data, __le16 handle)
+{
+	struct hci_peer_hash *h = &data->peer_hash;
+	struct hci_peer *p;
+
+	list_for_each_entry(p, &h->list, list)
+		if (p->handle == handle)
+			return p;
+
+	return NULL;
+}
+
+struct hci_peer *hci_peer_add(struct btusb_data *data, bdaddr_t *bdaddr,
+			      __le16 handle)
+{
+	struct hci_peer *peer;
+
+	peer = kzalloc(sizeof(*peer), GFP_KERNEL);
+	if (!peer)
+		return NULL;
+
+	bacpy(&peer->bdaddr, bdaddr);
+	peer->handle = handle;
+
+	skb_queue_head_init(&peer->acl_deferred_q);
+
+	hci_peer_hash_add(data, peer);
+
+	return peer;
+};
+
+void hci_peer_remove(struct btusb_data *data, struct hci_peer *peer)
+{
+	hci_peer_hash_del(data, peer);
+
+	if (peer->acl_deferred)
+		data->acl_deferred_peer--;
+
+	skb_queue_purge(&peer->acl_deferred_q);
+
+	kfree(peer);
+	peer = NULL;
+}
+
+static inline void hci_peer_purge(struct btusb_data *data)
+{
+	struct hci_peer_hash *h = &data->peer_hash;
+	struct hci_peer *p, *next;
+
+	list_for_each_entry_safe(p, next, &h->list, list)
+		hci_peer_remove(data, p);
+}
+
 static inline void btusb_free_frags(struct btusb_data *data)
 {
 	unsigned long flags;
@@ -449,6 +554,119 @@
 	spin_unlock_irqrestore(&data->rxlock, flags);
 }
 
+/*
+ * Workaround for a race condition observed with Android phones which makes fail
+ * some connections (30% with my device).
+ *
+ * After link key reply it is expected that HCI_EV_ENCRYPT_CHANGE is received
+ * before any ACL connection request or it will be dropped by bluez L2CAP layer.
+ *
+ * The events are received from usb interrupt transfer and ACL packet from usb
+ * bulk transfer. I guess the bluetooth controller does not handle correctly
+ * write ordering between those two transfer types.
+ *
+ * The connection/disconnection are tracked so the workaround can apply with a
+ * per device logic. It will start queueing ACL packets when link key are
+ * exchanged until the HCI_EV_ENCRYPT_CHANGE event or a disconnection.
+ *
+ * POSSIBLE LIMITATIONS:
+ *
+ * - Connection requests made between LINK_KEY_REQ and ENCRYPT_CHANGE events
+ * will be forwarded to the L2CAP layer and will be seen as legitimate. However,
+ * bluetooth specification says that ACL transfer is paused until encryption is
+ * fully setup. I guess this is the responsability of the controller to filter
+ * any rogue connection request until ENCRYPT_CHANGE event.
+ *
+ * - This workaround is not enough to fix a similar issue with pairing.
+ */
+static void btusb_update_deferred(struct btusb_data *data, struct sk_buff *skb)
+{
+	struct hci_peer *peer = NULL;
+	const int evt = ((struct hci_event_hdr *)skb->data)->evt;
+
+	BT_DBG("%s, event 0x%x, peers %d, deferred peers %d",
+	       data->hdev->name,
+	       evt,
+	       data->peer_hash.peer_num,
+	       data->acl_deferred_peer);
+
+	skb_pull(skb, HCI_EVENT_HDR_SIZE);
+
+	switch (evt) {
+	case HCI_EV_CONN_COMPLETE: {
+		struct hci_ev_conn_complete *event;
+		__le16 handle;
+
+		event =	(struct hci_ev_conn_complete *)skb->data;
+		handle = hci_handle(__le16_to_cpu(event->handle));
+		peer = hci_peer_hash_lookup_ba(data, &event->bdaddr);
+		if (peer) {
+			hci_peer_remove(data, peer);
+			peer = NULL;
+		}
+
+		/* Track only peers on successful connections */
+		if (event->status == 0)
+			hci_peer_add(data, &event->bdaddr, handle);
+
+		break;
+	}
+
+	case HCI_EV_DISCONN_COMPLETE: {
+		struct hci_ev_disconn_complete *event;
+		__le16 handle;
+
+		event  = (struct hci_ev_disconn_complete *)skb->data;
+		handle = hci_handle(__le16_to_cpu(event->handle));
+
+		peer = hci_peer_hash_lookup_handle(data, handle);
+		if (peer) {
+			hci_peer_remove(data, peer);
+			peer = NULL;
+		}
+		break;
+	}
+
+	case HCI_EV_LINK_KEY_REQ: {
+		struct hci_ev_link_key_req *event;
+
+		event =	(struct hci_ev_link_key_req *)skb->data;
+
+		peer = hci_peer_hash_lookup_ba(data, &event->bdaddr);
+		if (peer && !peer->acl_deferred) {
+			peer->acl_deferred = 1;
+			data->acl_deferred_peer++;
+		}
+		break;
+	}
+
+	case HCI_EV_ENCRYPT_CHANGE: {
+		struct hci_ev_encrypt_change *event;
+		__le16 handle;
+
+		event =	(struct hci_ev_encrypt_change *)skb->data;
+		handle = hci_handle(__le16_to_cpu(event->handle));
+
+		peer = hci_peer_hash_lookup_handle(data, handle);
+		if (peer && peer->acl_deferred) {
+			struct sk_buff *frame;
+
+			while ((frame = skb_dequeue(&peer->acl_deferred_q)))
+				hci_recv_frame(data->hdev, frame);
+			frame = NULL;
+
+			peer->acl_deferred = 0;
+			data->acl_deferred_peer--;
+		}
+		break;
+	}
+
+	default:
+		BT_ERR("Unexpected event");
+		break;
+	}
+}
+
 static int btusb_recv_intr(struct btusb_data *data, void *buffer, int count)
 {
 	struct sk_buff *skb;
@@ -492,9 +710,29 @@
 		}
 
 		if (!hci_skb_expect(skb)) {
+			struct sk_buff *evt_skb = NULL;
+			struct hci_event_hdr *hdr = (struct hci_event_hdr *)
+				skb->data;
+
+			if (hdr->evt == HCI_EV_CONN_COMPLETE ||
+			    hdr->evt == HCI_EV_DISCONN_COMPLETE ||
+			    hdr->evt == HCI_EV_LINK_KEY_REQ ||
+			    hdr->evt == HCI_EV_ENCRYPT_CHANGE) {
+				evt_skb = skb_clone(skb, GFP_KERNEL);
+				if (!evt_skb)
+					BT_ERR("Out of memory");
+			}
+
 			/* Complete frame */
 			data->recv_event(data->hdev, skb);
 			skb = NULL;
+
+			if (evt_skb) {
+				btusb_update_deferred(data, evt_skb);
+
+				kfree_skb(evt_skb);
+				evt_skb = NULL;
+			}
 		}
 	}
 
@@ -550,7 +788,23 @@
 
 		if (!hci_skb_expect(skb)) {
 			/* Complete frame */
-			hci_recv_frame(data->hdev, skb);
+			if (data->acl_deferred_peer) {
+				struct hci_peer *p;
+				struct hci_acl_hdr *hdr;
+				__le16 handle;
+
+				hdr = (struct hci_acl_hdr *)skb->data;
+				handle = hci_handle(__le16_to_cpu(hdr->handle));
+
+				p = hci_peer_hash_lookup_handle(data, handle);
+				if (p && p->acl_deferred)
+					skb_queue_tail(&p->acl_deferred_q, skb);
+				else
+					hci_recv_frame(data->hdev, skb);
+			} else {
+				hci_recv_frame(data->hdev, skb);
+			}
+
 			skb = NULL;
 		}
 	}
@@ -2819,6 +3073,9 @@
 	data->udev = interface_to_usbdev(intf);
 	data->intf = intf;
 
+	data->acl_deferred_peer = 0;
+	INIT_LIST_HEAD(&data->peer_hash.list);
+
 	INIT_WORK(&data->work, btusb_work);
 	INIT_WORK(&data->waker, btusb_waker);
 	init_usb_anchor(&data->deferred);
@@ -3055,6 +3312,8 @@
 	if (!data)
 		return;
 
+	hci_peer_purge(data);
+
 	hdev = data->hdev;
 	usb_set_intfdata(data->intf, NULL);
 
--

On Wed, Oct 03, 2018 at 04:19:59PM +0200, fabien dvlt wrote:
> Thank you both for your reply. Since you and Luiz answered, I have
> been trying to do a better workaround at USB/HCI level instead of
> L2CAP.
> 
> I understand this issue is more related to the firmware implementation
> but for those who really need it, I think the patch below is a better
> approach than the first I have submitted.
> 
> It will start queueing ACL packets when link key exchange begins until
> the next HCI event. It still have some limitations I wish to fix soon
> (see patch below).
> 
> I have a question about what I have read in bluetooth specifications:
>  
>  Version 5.0, Vol 2, Part C, - 4.2.5.1 Encryption Mode
> 
>    "ACL-U logical link traffic shall only be resumed after the attempt
>    to encrypt or decrypt the logical transport is completed"
> 
> I was wondering if this would guarantee that no unencrypted connection
> request could be forwarded to other layer once the link key exchange
> has started.
> 
> Thank you
> 
> ---
> 
> From bd17d5e519c2ad76ef1761b2d066d98ec4c723d1 Mon Sep 17 00:00:00 2001
> From: fabien filhol <fabien.filhol@devialet.com>
> Date: Wed, 3 Oct 2018 12:06:30 +0200
> Subject: [PATCH] Bluetooth: btusb: Fix race condition between BT events and
>  ACL
> 
> Workaround for a race condition observed with Android phones which makes
> fail some connections (30% with a Oneplus 6).
> 
> After link key reply it is expected that HCI_EV_ENCRYPT_CHANGE is received
> before any ACL connection request or it will be dropped by bluez L2CAP
> layer.
> 
> The events are received from usb interrupt transfer and ACL packet from usb
> bulk transfer. I guess the bluetooth controller does not handle correctly
> write ordering between those two transfer types.
> 
> The workaround will start queueing ACL packets when link key are exchanged until
> the next real event (other than HCI_EV_CMD_COMPLETE) is received, it should
> be HCI_EV_ENCRYPT_CHANGE.
> 
> LIMITATIONS:
> 
> An unencrypted connection request forwarded by the controller at
> "ACL queueing time" could pass. Bluetooth specification says that ACL
> transfer is paused until encryption is setup so I hope it is safe to queue
> ACL between HCI_EV_LINK_KEY_REQ and HCI_EV_CMD_COMPLETE.
> 
> With concurrent connections from multiple bluetooth devices the workaround
> could not work as any event from any device would flush the queue.
> ---
>  drivers/bluetooth/btusb.c | 50 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 49 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index bff67c5a5fe7..c55096fa8c4e 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -406,6 +406,9 @@ struct btusb_data {
>  	struct sk_buff *acl_skb;
>  	struct sk_buff *sco_skb;
>  
> +	struct sk_buff_head acl_deferred_q;
> +	int acl_deferred;
> +
>  	struct usb_endpoint_descriptor *intr_ep;
>  	struct usb_endpoint_descriptor *bulk_tx_ep;
>  	struct usb_endpoint_descriptor *bulk_rx_ep;
> @@ -449,6 +452,7 @@ static int btusb_recv_intr(struct btusb_data *data, void *buffer, int count)
>  {
>  	struct sk_buff *skb;
>  	int err = 0;
> +	int event = HCI_OP_NOP;
>  
>  	spin_lock(&data->rxlock);
>  	skb = data->evt_skb;
> @@ -488,6 +492,9 @@ static int btusb_recv_intr(struct btusb_data *data, void *buffer, int count)
>  		}
>  
>  		if (!hci_skb_expect(skb)) {
> +			struct hci_event_hdr *hdr = (struct hci_event_hdr *)skb->data;
> +			event = hdr->evt;
> +
>  			/* Complete frame */
>  			data->recv_event(data->hdev, skb);
>  			skb = NULL;
> @@ -495,6 +502,39 @@ static int btusb_recv_intr(struct btusb_data *data, void *buffer, int count)
>  	}
>  
>  	data->evt_skb = skb;
> +
> +	/*
> +	 * Workaround for a race condition observed with Android phones. After link
> +	 * key reply it is expected that HCI_EV_ENCRYPT_CHANGE is received before
> +	 * any ACL connection request or it will be dropped by bluez L2CAP layer.
> +	 *
> +	 * The events are received from usb interrupt transfer and ACL packet from
> +	 * usb bulk transfer. I guess the bluetooth controller does not handle
> +	 * correctly write ordering between those two transfer types.
> +	 *
> +	 * The workaround will start queueing ACL packets when link key are exchanged
> +	 * until the next real event (not an HCI_EV_CMD_COMPLETE) is received, it
> +	 * should be HCI_EV_ENCRYPT_CHANGE.
> +	 *
> +	 * LIMITATIONS:
> +	 *
> +	 * An unencrypted connection request forwarded by the controller at
> +	 * "ACL queueing time" would pass. Bluetooth specification says that ACL
> +	 * transfer is paused until encryption is setup so I hope it is safe to queue
> +	 * ACL between HCI_EV_LINK_KEY_REQ and HCI_EV_CMD_COMPLETE.
> +	 *
> +	 * With concurrent connections from multiple bluetooth devices the workaround
> +	 * could not work as any event from any device would flush the queue.
> +	 */
> +	if (event == HCI_EV_LINK_KEY_REQ) {
> +		data->acl_deferred = 1;
> +	} else if (data->acl_deferred && event != HCI_EV_CMD_COMPLETE) {
> +		while ((skb = skb_dequeue(&data->acl_deferred_q)))
> +			hci_recv_frame(data->hdev, skb);
> +		skb = NULL;
> +		data->acl_deferred = 0;
> +	}
> +
>  	spin_unlock(&data->rxlock);
>  
>  	return err;
> @@ -546,7 +586,10 @@ static int btusb_recv_bulk(struct btusb_data *data, void *buffer, int count)
>  
>  		if (!hci_skb_expect(skb)) {
>  			/* Complete frame */
> -			hci_recv_frame(data->hdev, skb);
> +			if (data->acl_deferred)
> +				skb_queue_tail(&data->acl_deferred_q, skb);
> +			else
> +				hci_recv_frame(data->hdev, skb);
>  			skb = NULL;
>  		}
>  	}
> @@ -2815,6 +2858,9 @@ static int btusb_probe(struct usb_interface *intf,
>  	data->udev = interface_to_usbdev(intf);
>  	data->intf = intf;
>  
> +	data->acl_deferred = 0;
> +	skb_queue_head_init(&data->acl_deferred_q);
> +
>  	INIT_WORK(&data->work, btusb_work);
>  	INIT_WORK(&data->waker, btusb_waker);
>  	init_usb_anchor(&data->deferred);
> @@ -3051,6 +3097,8 @@ static void btusb_disconnect(struct usb_interface *intf)
>  	if (!data)
>  		return;
>  
> +	skb_queue_purge(&data->acl_deferred_q);
> +
>  	hdev = data->hdev;
>  	usb_set_intfdata(data->intf, NULL);
>  
> -- 
> 2.17.1
> 
> 
> On Wed, Sep 26, 2018 at 02:28:01PM +0300, Johan Hedberg wrote:
> > Hi Fabien,
> > 
> > On Tue, Sep 25, 2018, fabien dvlt wrote:
> > > > ACL Data RX: Handle 13 flags 0x02 dlen 12           #198 [hci0] 21.813116
> > >       L2CAP: Connection Request (0x02) ident 7 len 4
> > >         PSM: 25 (0x0019)
> > >         Source CID: 75
> > > > HCI Event: Encryption Change (0x08) plen 4          #199 [hci0] 21.813155
> > >         Status: Success (0x00)
> > >         Handle: 13
> > >         Encryption: Enabled with AES-CCM (0x02)
> > > < ACL Data TX: Handle 13 flags 0x00 dlen 16           #200 [hci0]
> > >       L2CAP: Connection Response (0x03) ident 7 len 8
> > >         Destination CID: 0
> > >         Source CID: 75
> > >         Result: Connection refused - security block (0x0003)
> > >         Status: No further information available (0x0000)
> > 
> > This looks like the well-known race condition for ACL data and HCI
> > events on USB where the two come through different endpoints. From the
> > host perspective there's not much we can do since we can't make
> > assumptions that the connection request was sent over an encrypted
> > connection if we haven't seen the encryption change request at that
> > point.
> > 
> > Johan
