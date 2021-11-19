Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF46C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Nov 2021 16:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64D5361B1E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Nov 2021 16:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236068AbhKSQtK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Nov 2021 11:49:10 -0500
Received: from mga14.intel.com ([192.55.52.115]:34807 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234826AbhKSQtJ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Nov 2021 11:49:09 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10172"; a="234681418"
X-IronPort-AV: E=Sophos;i="5.87,248,1631602800"; 
   d="scan'208";a="234681418"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 08:46:07 -0800
X-IronPort-AV: E=Sophos;i="5.87,248,1631602800"; 
   d="scan'208";a="587795182"
Received: from dkrebs-mobl1.amr.corp.intel.com (HELO [10.209.113.34]) ([10.209.113.34])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 08:46:06 -0800
Message-ID: <b82487ae459fc588ab2e716184931d044948a9a9.camel@linux.intel.com>
Subject: Re: [PATCH v2] Bluetooth: btusb: Add support for queuing during
 polling interval
From:   Tedd Ho-Jeong An <tedd.an@linux.intel.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Date:   Fri, 19 Nov 2021 08:46:04 -0800
In-Reply-To: <20211118214956.946365-1-luiz.dentz@gmail.com>
References: <20211118214956.946365-1-luiz.dentz@gmail.com>
Organization: Intel Corporation
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Thu, 2021-11-18 at 13:49 -0800, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
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
> With use of module option:
> 
>     enable_poll_sync
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

I tested this patch with several Intel devices(AX210, CcP, ThP, WsP, and SfP)
and fw loading worked with/without setting the "enable_poll_sync"

Tested-by: Tedd Ho-Jeong An <tedd.an@intel.com>

> ---
> v2: Check for intr_interval instead of enable_poll_sync when dispatching
> since the former can only be changed on open/resume.
> 
>  drivers/bluetooth/btusb.c | 81 ++++++++++++++++++++++++++++++++++++---
>  1 file changed, 76 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 30a057e1d4e3..272faa40b11c 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -31,7 +31,7 @@
>  static bool disable_scofix;
>  static bool force_scofix;
>  static bool enable_autosuspend = IS_ENABLED(CONFIG_BT_HCIBTUSB_AUTOSUSPEND);
> -
> +static bool enable_poll_sync;
>  static bool reset = true;
>  
>  static struct usb_driver btusb_driver;
> @@ -550,8 +550,12 @@ struct btusb_data {
>  
>         unsigned long flags;
>  
> -       struct work_struct work;
> -       struct work_struct waker;
> +       int intr_interval;
> +       struct work_struct  work;
> +       struct work_struct  waker;
> +       struct delayed_work rx_work;
> +
> +       struct sk_buff_head acl_q;
>  
>         struct usb_anchor deferred;
>         struct usb_anchor tx_anchor;
> @@ -716,6 +720,15 @@ static inline void btusb_free_frags(struct btusb_data *data)
>         spin_unlock_irqrestore(&data->rxlock, flags);
>  }
>  
> +static int btusb_recv_event(struct btusb_data *data, struct sk_buff *skb)
> +{
> +       if (data->intr_interval)
> +               /* Trigger dequeue immediatelly if an event is received */
> +               schedule_delayed_work(&data->rx_work, 0);
> +
> +       return data->recv_event(data->hdev, skb);
> +}
> +
>  static int btusb_recv_intr(struct btusb_data *data, void *buffer, int count)
>  {
>         struct sk_buff *skb;
> @@ -761,7 +774,7 @@ static int btusb_recv_intr(struct btusb_data *data, void *buffer, int count)
>  
>                 if (!hci_skb_expect(skb)) {
>                         /* Complete frame */
> -                       data->recv_event(data->hdev, skb);
> +                       btusb_recv_event(data, skb);
>                         skb = NULL;
>                 }
>         }
> @@ -772,6 +785,18 @@ static int btusb_recv_intr(struct btusb_data *data, void *buffer, int count)
>         return err;
>  }
>  
> +static int btusb_recv_acl(struct btusb_data *data, struct sk_buff *skb)
> +{
> +       if (!data->intr_interval)
> +               return data->recv_acl(data->hdev, skb);
> +
> +       skb_queue_tail(&data->acl_q, skb);
> +
> +       schedule_delayed_work(&data->rx_work, data->intr_interval);
> +
> +       return 0;
> +}
> +
>  static int btusb_recv_bulk(struct btusb_data *data, void *buffer, int count)
>  {
>         struct sk_buff *skb;
> @@ -819,7 +844,7 @@ static int btusb_recv_bulk(struct btusb_data *data, void *buffer, int count)
>  
>                 if (!hci_skb_expect(skb)) {
>                         /* Complete frame */
> -                       data->recv_acl(data->hdev, skb);
> +                       btusb_recv_acl(data, skb);
>                         skb = NULL;
>                 }
>         }
> @@ -971,6 +996,27 @@ static int btusb_submit_intr_urb(struct hci_dev *hdev, gfp_t mem_flags)
>                 usb_unanchor_urb(urb);
>         }
>  
> +       /* Only initialize intr_interval if URB poll sync is enabled */
> +       if (!enable_poll_sync)
> +               goto done;
> +
> +       /* The units are frames (milliseconds) for full and low speed devices,
> +        * and microframes (1/8 millisecond) for highspeed and SuperSpeed
> +        * devices.
> +        *
> +        * This is done once on open/resume so it shouldn't change even if
> +        * enable_poll_sync changes.
> +        */
> +       switch (urb->dev->speed) {
> +       case USB_SPEED_SUPER_PLUS:
> +       case USB_SPEED_SUPER:   /* units are 125us */
> +               data->intr_interval = usecs_to_jiffies(urb->interval * 125);
> +               break;
> +       default:
> +               data->intr_interval = msecs_to_jiffies(urb->interval);
> +       }
> +
> +done:
>         usb_free_urb(urb);
>  
>         return err;
> @@ -1430,9 +1476,12 @@ static int btusb_close(struct hci_dev *hdev)
>  
>         BT_DBG("%s", hdev->name);
>  
> +       cancel_delayed_work(&data->rx_work);
>         cancel_work_sync(&data->work);
>         cancel_work_sync(&data->waker);
>  
> +       skb_queue_purge(&data->acl_q);
> +
>         clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
>         clear_bit(BTUSB_BULK_RUNNING, &data->flags);
>         clear_bit(BTUSB_INTR_RUNNING, &data->flags);
> @@ -1464,6 +1513,10 @@ static int btusb_flush(struct hci_dev *hdev)
>  
>         BT_DBG("%s", hdev->name);
>  
> +       cancel_delayed_work(&data->rx_work);
> +
> +       skb_queue_purge(&data->acl_q);
> +
>         usb_kill_anchored_urbs(&data->tx_anchor);
>         btusb_free_frags(data);
>  
> @@ -1827,6 +1880,17 @@ static void btusb_waker(struct work_struct *work)
>         usb_autopm_put_interface(data->intf);
>  }
>  
> +static void btusb_rx_work(struct work_struct *work)
> +{
> +       struct btusb_data *data = container_of(work, struct btusb_data,
> +                                              rx_work.work);
> +       struct sk_buff *skb;
> +
> +       /* Dequeue ACL data received during the interval */
> +       while ((skb = skb_dequeue(&data->acl_q)))
> +               data->recv_acl(data->hdev, skb);
> +}
> +
>  static int btusb_setup_bcm92035(struct hci_dev *hdev)
>  {
>         struct sk_buff *skb;
> @@ -3456,6 +3520,10 @@ static int btusb_probe(struct usb_interface *intf,
>  
>         INIT_WORK(&data->work, btusb_work);
>         INIT_WORK(&data->waker, btusb_waker);
> +       INIT_DELAYED_WORK(&data->rx_work, btusb_rx_work);
> +
> +       skb_queue_head_init(&data->acl_q);
> +
>         init_usb_anchor(&data->deferred);
>         init_usb_anchor(&data->tx_anchor);
>         spin_lock_init(&data->txlock);
> @@ -3943,6 +4011,9 @@ MODULE_PARM_DESC(force_scofix, "Force fixup of wrong SCO buffers size");
>  module_param(enable_autosuspend, bool, 0644);
>  MODULE_PARM_DESC(enable_autosuspend, "Enable USB autosuspend by default");
>  
> +module_param(enable_poll_sync, bool, 0644);
> +MODULE_PARM_DESC(enable_poll_sync, "Enable URB polling interval synchronization");
> +
>  module_param(reset, bool, 0644);
>  MODULE_PARM_DESC(reset, "Send HCI reset command on initialization");
>  


