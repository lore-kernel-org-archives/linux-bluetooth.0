Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48C2C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Dec 2021 21:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383283AbhLCVuD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Dec 2021 16:50:03 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:40277 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383291AbhLCVuC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Dec 2021 16:50:02 -0500
Received: from smtpclient.apple (p5b3d2e91.dip0.t-ipconnect.de [91.61.46.145])
        by mail.holtmann.org (Postfix) with ESMTPSA id 89E9ACED20;
        Fri,  3 Dec 2021 22:46:37 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [PATCH v3] Bluetooth: btusb: Add support for queuing during
 polling interval
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211202210932.1884203-1-luiz.dentz@gmail.com>
Date:   Fri, 3 Dec 2021 22:46:37 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <BF7D6EF6-DF25-4E4E-8D4B-91039B07F7DF@holtmann.org>
References: <20211202210932.1884203-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
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
> interval is not enabled by default so it requires setting
> force_poll_sync debugfs while the adapter is down.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> v2: Check for intr_interval instead of enable_poll_sync when dispatching
> since the former can only be changed on open/resume.
> v3: Change the way the feature is enabled from module parameter to debugfs
> entry and rename it from enable_poll_sync to force_poll_sync.
> 
> drivers/bluetooth/btusb.c | 125 ++++++++++++++++++++++++++++++++++++--
> 1 file changed, 120 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index ab169fc673ea..9b3cadb33fcb 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -16,6 +16,7 @@
> #include <linux/of_irq.h>
> #include <linux/suspend.h>
> #include <linux/gpio/consumer.h>
> +#include <linux/debugfs.h>
> #include <asm/unaligned.h>
> 
> #include <net/bluetooth/bluetooth.h>
> @@ -31,7 +32,6 @@
> static bool disable_scofix;
> static bool force_scofix;
> static bool enable_autosuspend = IS_ENABLED(CONFIG_BT_HCIBTUSB_AUTOSUSPEND);
> -
> static bool reset = true;
> 
> static struct usb_driver btusb_driver;
> @@ -558,8 +558,13 @@ struct btusb_data {
> 
> 	unsigned long flags;
> 
> -	struct work_struct work;
> -	struct work_struct waker;
> +	bool poll_sync;
> +	int intr_interval;
> +	struct work_struct  work;
> +	struct work_struct  waker;
> +	struct delayed_work rx_work;
> +
> +	struct sk_buff_head acl_q;
> 
> 	struct usb_anchor deferred;
> 	struct usb_anchor tx_anchor;
> @@ -724,6 +729,15 @@ static inline void btusb_free_frags(struct btusb_data *data)
> 	spin_unlock_irqrestore(&data->rxlock, flags);
> }
> 
> +static int btusb_recv_event(struct btusb_data *data, struct sk_buff *skb)
> +{
> +	if (data->intr_interval)

enclose in {

> +		/* Trigger dequeue immediatelly if an event is received */
> +		schedule_delayed_work(&data->rx_work, 0);

} this please.

> +
> +	return data->recv_event(data->hdev, skb);
> +}
> +
> static int btusb_recv_intr(struct btusb_data *data, void *buffer, int count)
> {
> 	struct sk_buff *skb;
> @@ -769,7 +783,7 @@ static int btusb_recv_intr(struct btusb_data *data, void *buffer, int count)
> 
> 		if (!hci_skb_expect(skb)) {
> 			/* Complete frame */
> -			data->recv_event(data->hdev, skb);
> +			btusb_recv_event(data, skb);
> 			skb = NULL;
> 		}
> 	}
> @@ -780,6 +794,18 @@ static int btusb_recv_intr(struct btusb_data *data, void *buffer, int count)
> 	return err;
> }
> 
> +static int btusb_recv_acl(struct btusb_data *data, struct sk_buff *skb)
> +{

Add a comment above here.

> +	if (!data->intr_interval)
> +		return data->recv_acl(data->hdev, skb);
> +
> +	skb_queue_tail(&data->acl_q, skb);
> +

Skip this empty line.

> +	schedule_delayed_work(&data->rx_work, data->intr_interval);
> +
> +	return 0;
> +}
> +
> static int btusb_recv_bulk(struct btusb_data *data, void *buffer, int count)
> {
> 	struct sk_buff *skb;
> @@ -827,7 +853,7 @@ static int btusb_recv_bulk(struct btusb_data *data, void *buffer, int count)
> 
> 		if (!hci_skb_expect(skb)) {
> 			/* Complete frame */
> -			data->recv_acl(data->hdev, skb);
> +			btusb_recv_acl(data, skb);
> 			skb = NULL;
> 		}
> 	}
> @@ -979,6 +1005,27 @@ static int btusb_submit_intr_urb(struct hci_dev *hdev, gfp_t mem_flags)
> 		usb_unanchor_urb(urb);
> 	}
> 
> +	/* Only initialize intr_interval if URB poll sync is enabled */
> +	if (!data->poll_sync)
> +		goto done;
> +
> +	/* The units are frames (milliseconds) for full and low speed devices,
> +	 * and microframes (1/8 millisecond) for highspeed and SuperSpeed
> +	 * devices.
> +	 *
> +	 * This is done once on open/resume so it shouldn't change even if
> +	 * enable_poll_sync changes.
> +	 */
> +	switch (urb->dev->speed) {
> +	case USB_SPEED_SUPER_PLUS:
> +	case USB_SPEED_SUPER:	/* units are 125us */
> +		data->intr_interval = usecs_to_jiffies(urb->interval * 125);
> +		break;
> +	default:
> +		data->intr_interval = msecs_to_jiffies(urb->interval);

Add break here.

> +	}
> +
> +done:
> 	usb_free_urb(urb);
> 
> 	return err;
> @@ -1438,9 +1485,12 @@ static int btusb_close(struct hci_dev *hdev)
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
> @@ -1472,6 +1522,10 @@ static int btusb_flush(struct hci_dev *hdev)
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
> @@ -1835,6 +1889,17 @@ static void btusb_waker(struct work_struct *work)
> 	usb_autopm_put_interface(data->intf);
> }
> 
> +static void btusb_rx_work(struct work_struct *work)
> +{
> +	struct btusb_data *data = container_of(work, struct btusb_data,
> +					       rx_work.work);
> +	struct sk_buff *skb;
> +
> +	/* Dequeue ACL data received during the interval */
> +	while ((skb = skb_dequeue(&data->acl_q)))
> +		data->recv_acl(data->hdev, skb);
> +}
> +
> static int btusb_setup_bcm92035(struct hci_dev *hdev)
> {
> 	struct sk_buff *skb;
> @@ -3392,6 +3457,49 @@ static int btusb_shutdown_qca(struct hci_dev *hdev)
> 	return 0;
> }
> 
> +static ssize_t force_poll_sync_read(struct file *file, char __user *user_buf,
> +				    size_t count, loff_t *ppos)
> +{
> +	struct btusb_data *data = file->private_data;
> +	char buf[3];
> +
> +	buf[0] = data->poll_sync ? 'Y' : 'N';
> +	buf[1] = '\n';
> +	buf[2] = '\0';
> +	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
> +}
> +
> +static ssize_t force_poll_sync_write(struct file *file,
> +				     const char __user *user_buf,
> +				     size_t count, loff_t *ppos)
> +{
> +	struct btusb_data *data = file->private_data;
> +	bool enable;
> +	int err;
> +
> +	err = kstrtobool_from_user(user_buf, count, &enable);
> +	if (err)
> +		return err;
> +
> +	/* Only allow changes while the adapter is down */
> +	if (test_bit(HCI_UP, &data->hdev->flags))
> +		return -EPERM;
> +
> +	if (data->poll_sync == enable)
> +		return -EALREADY;
> +
> +	data->poll_sync = enable;
> +
> +	return count;
> +}
> +
> +static const struct file_operations force_poll_sync_fops = {
> +	.open		= simple_open,
> +	.read		= force_poll_sync_read,
> +	.write		= force_poll_sync_write,
> +	.llseek		= default_llseek,
> +};
> +
> static int btusb_probe(struct usb_interface *intf,
> 		       const struct usb_device_id *id)
> {
> @@ -3475,6 +3583,10 @@ static int btusb_probe(struct usb_interface *intf,
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
> @@ -3740,6 +3852,9 @@ static int btusb_probe(struct usb_interface *intf,
> 
> 	usb_set_intfdata(intf, data);
> 
> +	debugfs_create_file("force_poll_sync", 0644, hdev->debugfs, data,
> +			    &force_poll_sync_fops);
> +
> 	return 0;

So besides cosmetic changes, looks good.

Regards

Marcel

