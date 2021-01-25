Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF59C433E6
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Jan 2021 18:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C7BB22D50
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Jan 2021 18:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbhAYSV4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Jan 2021 13:21:56 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:48419 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbhAYSVg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Jan 2021 13:21:36 -0500
Received: from marcel-macbook.holtmann.net (p4ff9f11c.dip0.t-ipconnect.de [79.249.241.28])
        by mail.holtmann.org (Postfix) with ESMTPSA id E63B6CECCA;
        Mon, 25 Jan 2021 19:28:05 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.40.0.2.32\))
Subject: Re: [RESEND 1/2] Bluetooth: btusb: Add support for queuing during
 polling interval
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210113232858.1181251-1-luiz.dentz@gmail.com>
Date:   Mon, 25 Jan 2021 19:20:40 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <52613EEA-D992-4BDB-BA8A-E91DC4125F70@holtmann.org>
References: <20210113232858.1181251-1-luiz.dentz@gmail.com>
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
> drivers/bluetooth/Kconfig |  7 ++++
> drivers/bluetooth/btusb.c | 88 ++++++++++++++++++++++++++++++++++-----
> 2 files changed, 84 insertions(+), 11 deletions(-)
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
> config BT_HCIBTUSB_BCM
> 	bool "Broadcom protocol support"
> 	depends on BT_HCIBTUSB
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index b14102fba601..38cb5448fc69 100644
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
> +	struct work_struct  work;
> +	struct work_struct  waker;
> +	struct delayed_work rx_work;
> +
> +	struct sk_buff_head acl_q;
> +	struct sk_buff_head evt_q;

so does it make sense to keep them separate if we delay processing anyway.

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
> @@ -718,6 +722,25 @@ static int btusb_recv_intr(struct btusb_data *data, void *buffer, int count)
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
> +	/* TODO: Calculate polling interval based on endpoint bInterval? */
> +	return btusb_rx_queue(data, skb, &data->acl_q, msecs_to_jiffies(1));
> +}

Lets get this also fixed before we consider applying the patch.

> +
> static int btusb_recv_bulk(struct btusb_data *data, void *buffer, int count)
> {
> 	struct sk_buff *skb;
> @@ -765,7 +788,7 @@ static int btusb_recv_bulk(struct btusb_data *data, void *buffer, int count)
> 
> 		if (!hci_skb_expect(skb)) {
> 			/* Complete frame */
> -			hci_recv_frame(data->hdev, skb);
> +			btusb_recv_acl(data, skb);
> 			skb = NULL;
> 		}
> 	}
> @@ -1383,9 +1406,13 @@ static int btusb_close(struct hci_dev *hdev)
> 
> 	BT_DBG("%s", hdev->name);
> 
> +	cancel_delayed_work(&data->rx_work);
> 	cancel_work_sync(&data->work);
> 	cancel_work_sync(&data->waker);
> 
> +	skb_queue_purge(&data->acl_q);
> +	skb_queue_purge(&data->evt_q);
> +
> 	clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
> 	clear_bit(BTUSB_BULK_RUNNING, &data->flags);
> 	clear_bit(BTUSB_INTR_RUNNING, &data->flags);
> @@ -1417,6 +1444,11 @@ static int btusb_flush(struct hci_dev *hdev)
> 
> 	BT_DBG("%s", hdev->name);
> 
> +	cancel_delayed_work(&data->rx_work);
> +
> +	skb_queue_purge(&data->acl_q);
> +	skb_queue_purge(&data->evt_q);
> +
> 	usb_kill_anchored_urbs(&data->tx_anchor);
> 	btusb_free_frags(data);
> 
> @@ -1769,6 +1801,25 @@ static void btusb_waker(struct work_struct *work)
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
> +	/* Process HCI event packets so states changes are synchronized first */
> +	btusb_rx_dequeue(data, &data->evt_q);
> +	btusb_rx_dequeue(data, &data->acl_q);
> +}
> +
> static int btusb_setup_bcm92035(struct hci_dev *hdev)
> {
> 	struct sk_buff *skb;
> @@ -2304,10 +2355,8 @@ static void btusb_intel_secure_send_result(struct btusb_data *data,
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
> @@ -2336,7 +2385,7 @@ static int btusb_recv_event_intel(struct hci_dev *hdev, struct sk_buff *skb)
> 		}
> 	}
> 
> -	return hci_recv_frame(hdev, skb);
> +	return hci_recv_frame(data->hdev, skb);
> }
> 
> static int btusb_send_frame_intel(struct hci_dev *hdev, struct sk_buff *skb)
> @@ -4279,6 +4328,15 @@ static int btusb_shutdown_qca(struct hci_dev *hdev)
> 	return 0;
> }
> 
> +static int btusb_recv_evt(struct btusb_data *data, struct sk_buff *skb)
> +{
> +	if (!enable_interval)
> +		return hci_recv_frame(data->hdev, skb);
> +
> +	/* Don't delay event processing */
> +	return btusb_rx_queue(data, skb, &data->evt_q, 0);
> +}
> +
> static int btusb_probe(struct usb_interface *intf,
> 		       const struct usb_device_id *id)
> {
> @@ -4362,6 +4420,11 @@ static int btusb_probe(struct usb_interface *intf,
> 
> 	INIT_WORK(&data->work, btusb_work);
> 	INIT_WORK(&data->waker, btusb_waker);
> +	INIT_DELAYED_WORK(&data->rx_work, btusb_rx_work);
> +
> +	skb_queue_head_init(&data->acl_q);
> +	skb_queue_head_init(&data->evt_q);
> +
> 	init_usb_anchor(&data->deferred);
> 	init_usb_anchor(&data->tx_anchor);
> 	spin_lock_init(&data->txlock);
> @@ -4378,7 +4441,7 @@ static int btusb_probe(struct usb_interface *intf,
> 		data->recv_bulk = btusb_recv_bulk_intel;
> 		set_bit(BTUSB_BOOTLOADER, &data->flags);
> 	} else {
> -		data->recv_event = hci_recv_frame;
> +		data->recv_event = btusb_recv_evt;
> 		data->recv_bulk = btusb_recv_bulk;
> 	}
> 
> @@ -4867,6 +4930,9 @@ MODULE_PARM_DESC(force_scofix, "Force fixup of wrong SCO buffers size");
> module_param(enable_autosuspend, bool, 0644);
> MODULE_PARM_DESC(enable_autosuspend, "Enable USB autosuspend by default");
> 
> +module_param(enable_interval, bool, 0644);
> +MODULE_PARM_DESC(enable_interval, "Enable USB polling interval by default");
> +
> module_param(reset, bool, 0644);
> MODULE_PARM_DESC(reset, "Send HCI reset command on initialization");

Regards

Marcel

