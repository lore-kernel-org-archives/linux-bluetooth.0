Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC14C433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Feb 2021 13:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3D5C64F45
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Feb 2021 13:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236250AbhBDNH2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Feb 2021 08:07:28 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:43279 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236233AbhBDNH1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Feb 2021 08:07:27 -0500
Received: from marcel-macbook.holtmann.net (p4fefcdd8.dip0.t-ipconnect.de [79.239.205.216])
        by mail.holtmann.org (Postfix) with ESMTPSA id 5F8E6CED16;
        Thu,  4 Feb 2021 14:14:12 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.40.0.2.32\))
Subject: Re: [PATCH v3] Bluetooth: btusb: Add support for queuing during
 polling interval
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210126185042.114037-1-luiz.dentz@gmail.com>
Date:   Thu, 4 Feb 2021 14:06:44 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <F74EFDC2-E5BB-4733-98CC-393BF47B75C8@holtmann.org>
References: <20210126185042.114037-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3654.40.0.2.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This makes btusb to queue ACL and events during a polling interval
> by using of a delayed work, with the interval working as a time window
> where frames received from different endpoints are considered to be
> arrived at same time and then attempt to resolve potential conflics by
> processing the events ahead of ACL packets.
> 
> It worth noting though that priorizing events over ACL data may result
> in inverting the order compared to how they appeared over the air, for
> instance there may be packets received before a disconnect event that
> will be discarded and unencrypted packets received before encryption
> change which would considered encrypted, because of these potential
> changes on the order the support for queuing during the polling
> interval is not enabled by default so platforms have the following
> means to enable it:
> 
> At build-time:
> 
>    CONFIG_BT_HCIBTUSB_INTERVAL=y
> 
> At runtime with use of module option:
> 
>    enable_interval
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> 
> v2: Calculate the delayed_work interval based on the intr urb->interval which
> is derived from endpoint bInterval.
> v3: Drop use of a queue for events.

we should get this tested and if this actually helps reducing the issue.

If this does work in general, we can adopt a version of this upstream.

> drivers/bluetooth/Kconfig |  7 +++
> drivers/bluetooth/btusb.c | 98 ++++++++++++++++++++++++++++++++++-----
> 2 files changed, 94 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> index 4e73a531b377..2f20a853d946 100644
> --- a/drivers/bluetooth/Kconfig
> +++ b/drivers/bluetooth/Kconfig
> @@ -41,6 +41,13 @@ config BT_HCIBTUSB_AUTOSUSPEND
> 	  This can be overridden by passing btusb.enable_autosuspend=[y|n]
> 	  on the kernel commandline.
> 
> +config BT_HCIBTUSB_INTERVAL
> +	bool "Enable notification of USB polling interval"
> +	depends on BT_HCIBTUSB
> +	help
> +	  Say Y here to enable notification of USB polling interval for
> +	  Bluetooth USB devices by default.
> +

So, I am not really convinced it is a good idea to have this as a Kconfig option. I think this always needs to be some runtime thing you enable with a config file. Module option are really just a lame way of hacking things and we should most likely start to get rid of them.

Anyhow, my main concern here is that no matter how good your comment is here, people will false enable it and wonder why things might not work as expected anymore when they try to qualify things and packets get wrongly labeled as encrypted but in reality they are not.

So I wonder if we can do mgmt experimental features on a per driver basis. If so, we might better provide this feature via an obscure UUID that is documented. And I wanted to expose more details about the attached hardware anyway. That way the platform or bluetoothd can then decide on when to enable this or not. There might be hardware that does a way better job anyhow than other and doesn’t need this.

> config BT_HCIBTUSB_BCM
> 	bool "Broadcom protocol support"
> 	depends on BT_HCIBTUSB
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index b14102fba601..4266c057746e 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -30,7 +30,7 @@
> static bool disable_scofix;
> static bool force_scofix;
> static bool enable_autosuspend = IS_ENABLED(CONFIG_BT_HCIBTUSB_AUTOSUSPEND);
> -
> +static bool enable_interval = IS_ENABLED(CONFIG_BT_HCIBTUSB_INTERVAL);
> static bool reset = true;
> 
> static struct usb_driver btusb_driver;
> @@ -519,8 +519,12 @@ struct btusb_data {
> 
> 	unsigned long flags;
> 
> -	struct work_struct work;
> -	struct work_struct waker;
> +	int intr_interval;
> +	struct work_struct  work;
> +	struct work_struct  waker;
> +	struct delayed_work rx_work;
> +
> +	struct sk_buff_head acl_q;
> 
> 	struct usb_anchor deferred;
> 	struct usb_anchor tx_anchor;
> @@ -557,7 +561,7 @@ struct btusb_data {
> 	int isoc_altsetting;
> 	int suspend_count;
> 
> -	int (*recv_event)(struct hci_dev *hdev, struct sk_buff *skb);
> +	int (*recv_event)(struct btusb_data *data, struct sk_buff *skb);
> 	int (*recv_bulk)(struct btusb_data *data, void *buffer, int count);
> 
> 	int (*setup_on_usb)(struct hci_dev *hdev);
> @@ -707,7 +711,7 @@ static int btusb_recv_intr(struct btusb_data *data, void *buffer, int count)
> 
> 		if (!hci_skb_expect(skb)) {
> 			/* Complete frame */
> -			data->recv_event(data->hdev, skb);
> +			data->recv_event(data, skb);
> 			skb = NULL;
> 		}
> 	}
> @@ -718,6 +722,24 @@ static int btusb_recv_intr(struct btusb_data *data, void *buffer, int count)
> 	return err;
> }
> 
> +static int btusb_rx_queue(struct btusb_data *data, struct sk_buff *skb,
> +			  struct sk_buff_head *queue, unsigned int interval)
> +{
> +	skb_queue_tail(queue, skb);
> +
> +	schedule_delayed_work(&data->rx_work, interval);
> +
> +	return 0;
> +}
> +
> +static int btusb_recv_acl(struct btusb_data *data, struct sk_buff *skb)
> +{
> +	if (!enable_interval)
> +		return hci_recv_frame(data->hdev, skb);
> +
> +	return btusb_rx_queue(data, skb, &data->acl_q, data->intr_interval);
> +}
> +

Combine these two into one function.

> static int btusb_recv_bulk(struct btusb_data *data, void *buffer, int count)
> {
> 	struct sk_buff *skb;
> @@ -765,7 +787,7 @@ static int btusb_recv_bulk(struct btusb_data *data, void *buffer, int count)
> 
> 		if (!hci_skb_expect(skb)) {
> 			/* Complete frame */
> -			hci_recv_frame(data->hdev, skb);
> +			btusb_recv_acl(data, skb);
> 			skb = NULL;
> 		}
> 	}
> @@ -917,6 +939,19 @@ static int btusb_submit_intr_urb(struct hci_dev *hdev, gfp_t mem_flags)
> 		usb_unanchor_urb(urb);
> 	}
> 
> +	/* The units are frames (milliseconds) for full and low speed devices,
> +	 * and microframes (1/8 millisecond) for highspeed and SuperSpeed
> +	 * devices.
> +	 */
> +	switch (urb->dev->speed) {
> +	case USB_SPEED_SUPER_PLUS:
> +	case USB_SPEED_SUPER:	/* units are 125us */
> +		data->intr_interval = usecs_to_jiffies(urb->interval * 125);
> +		break;
> +	default:
> +		data->intr_interval = msecs_to_jiffies(urb->interval);
> +	}
> +

Do we have to do this on every interrupt URB submission? Or can we just get this once at probe()?

> 	usb_free_urb(urb);
> 
> 	return err;
> @@ -1383,9 +1418,12 @@ static int btusb_close(struct hci_dev *hdev)
> 
> 	BT_DBG("%s", hdev->name);
> 
> +	cancel_delayed_work(&data->rx_work);
> 	cancel_work_sync(&data->work);
> 	cancel_work_sync(&data->waker);
> 
> +	skb_queue_purge(&data->acl_q);
> +
> 	clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
> 	clear_bit(BTUSB_BULK_RUNNING, &data->flags);
> 	clear_bit(BTUSB_INTR_RUNNING, &data->flags);
> @@ -1417,6 +1455,10 @@ static int btusb_flush(struct hci_dev *hdev)
> 
> 	BT_DBG("%s", hdev->name);
> 
> +	cancel_delayed_work(&data->rx_work);
> +
> +	skb_queue_purge(&data->acl_q);
> +
> 	usb_kill_anchored_urbs(&data->tx_anchor);
> 	btusb_free_frags(data);
> 
> @@ -1769,6 +1811,24 @@ static void btusb_waker(struct work_struct *work)
> 	usb_autopm_put_interface(data->intf);
> }
> 
> +static void btusb_rx_dequeue(struct btusb_data *data,
> +			     struct sk_buff_head *queue)
> +{
> +	struct sk_buff *skb;
> +
> +	while ((skb = skb_dequeue(queue)))
> +		hci_recv_frame(data->hdev, skb);
> +}
> +
> +static void btusb_rx_work(struct work_struct *work)
> +{
> +	struct btusb_data *data = container_of(work, struct btusb_data,
> +					       rx_work.work);
> +
> +	/* Dequeue ACL data received during the interval */
> +	btusb_rx_dequeue(data, &data->acl_q);
> +}
> +

Combine these two into one function.

> static int btusb_setup_bcm92035(struct hci_dev *hdev)
> {
> 	struct sk_buff *skb;
> @@ -2304,10 +2364,8 @@ static void btusb_intel_secure_send_result(struct btusb_data *data,
> 		wake_up_bit(&data->flags, BTUSB_DOWNLOADING);
> }
> 
> -static int btusb_recv_event_intel(struct hci_dev *hdev, struct sk_buff *skb)
> +static int btusb_recv_event_intel(struct btusb_data *data, struct sk_buff *skb)
> {
> -	struct btusb_data *data = hci_get_drvdata(hdev);
> -
> 	if (test_bit(BTUSB_BOOTLOADER, &data->flags)) {
> 		struct hci_event_hdr *hdr = (void *)skb->data;
> 
> @@ -2336,7 +2394,7 @@ static int btusb_recv_event_intel(struct hci_dev *hdev, struct sk_buff *skb)
> 		}
> 	}
> 
> -	return hci_recv_frame(hdev, skb);
> +	return hci_recv_frame(data->hdev, skb);
> }
> 
> static int btusb_send_frame_intel(struct hci_dev *hdev, struct sk_buff *skb)
> @@ -4279,6 +4337,17 @@ static int btusb_shutdown_qca(struct hci_dev *hdev)
> 	return 0;
> }
> 
> +static int btusb_recv_evt(struct btusb_data *data, struct sk_buff *skb)
> +{
> +	if (!enable_interval)
> +		return hci_recv_frame(data->hdev, skb);
> +
> +	/* Trigger dequeue immediatelly if an event is received */
> +	schedule_delayed_work(&data->rx_work, 0);
> +
> +	return hci_recv_frame(data->hdev, skb);
> +}
> +
> static int btusb_probe(struct usb_interface *intf,
> 		       const struct usb_device_id *id)
> {
> @@ -4362,6 +4431,10 @@ static int btusb_probe(struct usb_interface *intf,
> 
> 	INIT_WORK(&data->work, btusb_work);
> 	INIT_WORK(&data->waker, btusb_waker);
> +	INIT_DELAYED_WORK(&data->rx_work, btusb_rx_work);
> +
> +	skb_queue_head_init(&data->acl_q);
> +
> 	init_usb_anchor(&data->deferred);
> 	init_usb_anchor(&data->tx_anchor);
> 	spin_lock_init(&data->txlock);
> @@ -4378,7 +4451,7 @@ static int btusb_probe(struct usb_interface *intf,
> 		data->recv_bulk = btusb_recv_bulk_intel;
> 		set_bit(BTUSB_BOOTLOADER, &data->flags);
> 	} else {
> -		data->recv_event = hci_recv_frame;
> +		data->recv_event = btusb_recv_evt;
> 		data->recv_bulk = btusb_recv_bulk;
> 	}
> 
> @@ -4867,6 +4940,9 @@ MODULE_PARM_DESC(force_scofix, "Force fixup of wrong SCO buffers size");
> module_param(enable_autosuspend, bool, 0644);
> MODULE_PARM_DESC(enable_autosuspend, "Enable USB autosuspend by default");
> 
> +module_param(enable_interval, bool, 0644);
> +MODULE_PARM_DESC(enable_interval, "Enable USB polling interval by default");
> +

For a testing patch, leave this option in (just scrap the Kconfig part) and name “Enable URB polling interval synchronization”. I would also name the option “enable_poll_sync”.

> module_param(reset, bool, 0644);
> MODULE_PARM_DESC(reset, "Send HCI reset command on initialization");

Regards

Marcel

