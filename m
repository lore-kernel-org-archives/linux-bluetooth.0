Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 312EDC433DB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Jan 2021 05:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAB4A206F7
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Jan 2021 05:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731833AbhAZFci (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Jan 2021 00:32:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728842AbhAYSnu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Jan 2021 13:43:50 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91CBC06178C
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Jan 2021 10:42:54 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id h6so14473183oie.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Jan 2021 10:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kLxQDH+LKWSz6Gzm/t6HQBwMQNf2vgFQZ6fmAKmuqLw=;
        b=PeFsyfOc8wO1scFwkT4XpWiiDYj+XgjBppRSQ4RU3+hTJ4kZgjBNK8OmJNe6clOWm4
         T007UmzdNX+EUP8jAFI1XaGMYfRuDEQcFV8DBBk/LhEUeR6yyH7wxaqpNsYdm7JT0pJi
         jcTATLY/Cu+pnjB5lpnY55ZWO+JNnNA2LClIwVHUKhQqq1jUT03Z3+CmCMJTrA1se0FL
         hX7T5OrB35M6F7QHl+CQAhLww4Y+xDqwFsTr5aoC9mfAU+CaZoo3DB0qtaGAwuH1eGOf
         ZDHZOYByvOya1bIED2KGmkaF97zeOikaShMriwqvQ3c3jAkxvDMmIsFwc8O87ujijoxd
         Qz6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kLxQDH+LKWSz6Gzm/t6HQBwMQNf2vgFQZ6fmAKmuqLw=;
        b=Qk2uSNwDtb8tjnBZjILHFFKsMhD7zjWylMSeCYzwlA3Afa0NWwu+eLPfkQ1K7S24nv
         /T4hV5gDp7SBahwh063OKhH3osnnwKTXLOyAD37Ou3RU1b2Wpd3JEGpbo9xYu82yVSIf
         bEsvsT3mtL6oZdau5fvUxe8IpD83POx+P+HxrtjF9IVkp3k77UYIgtsJ5OVfFc8LsetT
         Cw28sqgGDlTEdvG0HOS+IamxV5T9/fKQT35dbOjXMNZzBxW1v/Z4H5gtxCnPnOwxKtDe
         6YJAgXbcY5I+fLlORqum2V0K8SAemcjeegCVomVsoqwt296wB49e6Sd3HeZ+5ow2SzsI
         6TIw==
X-Gm-Message-State: AOAM531Fgy1RgTa4cDMDqqULks1uJ6RaARpP2aaf5j3utA0oJcPKfrsk
        0BdEiSsk1BoFhxgaRm0YS7WfP0viVMd1iZRbo2urL0AJbVs=
X-Google-Smtp-Source: ABdhPJwlpHf23ARZpYOkhzCvXEI4uFIAR7yPMqUb2XgQdXZk/4QyfCTSY10q4TYKiHTWC5Q5S0t6szBMQdh1kE+h5Jw=
X-Received: by 2002:aca:c693:: with SMTP id w141mr968498oif.58.1611600173942;
 Mon, 25 Jan 2021 10:42:53 -0800 (PST)
MIME-Version: 1.0
References: <20210113232858.1181251-1-luiz.dentz@gmail.com> <52613EEA-D992-4BDB-BA8A-E91DC4125F70@holtmann.org>
In-Reply-To: <52613EEA-D992-4BDB-BA8A-E91DC4125F70@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 25 Jan 2021 10:42:42 -0800
Message-ID: <CABBYNZLu7nqgp8x6AWYfQOCXG4_Z6Da8PF=v=XAK9mj7Vg5FjQ@mail.gmail.com>
Subject: Re: [RESEND 1/2] Bluetooth: btusb: Add support for queuing during
 polling interval
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Mon, Jan 25, 2021 at 10:20 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Luiz,
>
> > This makes btusb to queue ACL and events during a polling interval
> > by using of a delayed work, with the interval working as a time window
> > where frames received from different endpoints are considered to be
> > arrived at same time and then attempt to resolve potential conflics by
> > processing the events ahead of ACL packets.
> >
> > It worth noting though that priorizing events over ACL data may result
> > in inverting the order compared to how they appeared over the air, for
> > instance there may be packets received before a disconnect event that
> > will be discarded and unencrypted packets received before encryption
> > change which would considered encrypted, because of these potential
> > changes on the order the support for queuing during the polling
> > interval is not enabled by default so platforms have the following
> > means to enable it:
> >
> > At build-time:
> >
> >    CONFIG_BT_HCIBTUSB_INTERVAL=y
> >
> > At runtime with use of module option:
> >
> >    enable_interval
> >
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> > drivers/bluetooth/Kconfig |  7 ++++
> > drivers/bluetooth/btusb.c | 88 ++++++++++++++++++++++++++++++++++-----
> > 2 files changed, 84 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> > index 4e73a531b377..2f20a853d946 100644
> > --- a/drivers/bluetooth/Kconfig
> > +++ b/drivers/bluetooth/Kconfig
> > @@ -41,6 +41,13 @@ config BT_HCIBTUSB_AUTOSUSPEND
> >         This can be overridden by passing btusb.enable_autosuspend=[y|n]
> >         on the kernel commandline.
> >
> > +config BT_HCIBTUSB_INTERVAL
> > +     bool "Enable notification of USB polling interval"
> > +     depends on BT_HCIBTUSB
> > +     help
> > +       Say Y here to enable notification of USB polling interval for
> > +       Bluetooth USB devices by default.
> > +
> > config BT_HCIBTUSB_BCM
> >       bool "Broadcom protocol support"
> >       depends on BT_HCIBTUSB
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index b14102fba601..38cb5448fc69 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -30,7 +30,7 @@
> > static bool disable_scofix;
> > static bool force_scofix;
> > static bool enable_autosuspend = IS_ENABLED(CONFIG_BT_HCIBTUSB_AUTOSUSPEND);
> > -
> > +static bool enable_interval = IS_ENABLED(CONFIG_BT_HCIBTUSB_INTERVAL);
> > static bool reset = true;
> >
> > static struct usb_driver btusb_driver;
> > @@ -519,8 +519,12 @@ struct btusb_data {
> >
> >       unsigned long flags;
> >
> > -     struct work_struct work;
> > -     struct work_struct waker;
> > +     struct work_struct  work;
> > +     struct work_struct  waker;
> > +     struct delayed_work rx_work;
> > +
> > +     struct sk_buff_head acl_q;
> > +     struct sk_buff_head evt_q;
>
> so does it make sense to keep them separate if we delay processing anyway.


We need them to reorder in case they are received at the same time
(within the same polling interval), we could reorder in place but then
will need to iterate into the queue to find where to insert events,
using 2 queues is a lot simpler to understand and probably perform
better.

>
> >
> >       struct usb_anchor deferred;
> >       struct usb_anchor tx_anchor;
> > @@ -557,7 +561,7 @@ struct btusb_data {
> >       int isoc_altsetting;
> >       int suspend_count;
> >
> > -     int (*recv_event)(struct hci_dev *hdev, struct sk_buff *skb);
> > +     int (*recv_event)(struct btusb_data *data, struct sk_buff *skb);
> >       int (*recv_bulk)(struct btusb_data *data, void *buffer, int count);
> >
> >       int (*setup_on_usb)(struct hci_dev *hdev);
> > @@ -707,7 +711,7 @@ static int btusb_recv_intr(struct btusb_data *data, void *buffer, int count)
> >
> >               if (!hci_skb_expect(skb)) {
> >                       /* Complete frame */
> > -                     data->recv_event(data->hdev, skb);
> > +                     data->recv_event(data, skb);
> >                       skb = NULL;
> >               }
> >       }
> > @@ -718,6 +722,25 @@ static int btusb_recv_intr(struct btusb_data *data, void *buffer, int count)
> >       return err;
> > }
> >
> > +static int btusb_rx_queue(struct btusb_data *data, struct sk_buff *skb,
> > +                       struct sk_buff_head *queue, unsigned int interval)
> > +{
> > +     skb_queue_tail(queue, skb);
> > +
> > +     schedule_delayed_work(&data->rx_work, interval);
> > +
> > +     return 0;
> > +}
> > +
> > +static int btusb_recv_acl(struct btusb_data *data, struct sk_buff *skb)
> > +{
> > +     if (!enable_interval)
> > +             return hci_recv_frame(data->hdev, skb);
> > +
> > +     /* TODO: Calculate polling interval based on endpoint bInterval? */
> > +     return btusb_rx_queue(data, skb, &data->acl_q, msecs_to_jiffies(1));
> > +}
>
> Lets get this also fixed before we consider applying the patch.

Will update the use of the bInterval then, it just needs to be
converted to msec though.

> > +
> > static int btusb_recv_bulk(struct btusb_data *data, void *buffer, int count)
> > {
> >       struct sk_buff *skb;
> > @@ -765,7 +788,7 @@ static int btusb_recv_bulk(struct btusb_data *data, void *buffer, int count)
> >
> >               if (!hci_skb_expect(skb)) {
> >                       /* Complete frame */
> > -                     hci_recv_frame(data->hdev, skb);
> > +                     btusb_recv_acl(data, skb);
> >                       skb = NULL;
> >               }
> >       }
> > @@ -1383,9 +1406,13 @@ static int btusb_close(struct hci_dev *hdev)
> >
> >       BT_DBG("%s", hdev->name);
> >
> > +     cancel_delayed_work(&data->rx_work);
> >       cancel_work_sync(&data->work);
> >       cancel_work_sync(&data->waker);
> >
> > +     skb_queue_purge(&data->acl_q);
> > +     skb_queue_purge(&data->evt_q);
> > +
> >       clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
> >       clear_bit(BTUSB_BULK_RUNNING, &data->flags);
> >       clear_bit(BTUSB_INTR_RUNNING, &data->flags);
> > @@ -1417,6 +1444,11 @@ static int btusb_flush(struct hci_dev *hdev)
> >
> >       BT_DBG("%s", hdev->name);
> >
> > +     cancel_delayed_work(&data->rx_work);
> > +
> > +     skb_queue_purge(&data->acl_q);
> > +     skb_queue_purge(&data->evt_q);
> > +
> >       usb_kill_anchored_urbs(&data->tx_anchor);
> >       btusb_free_frags(data);
> >
> > @@ -1769,6 +1801,25 @@ static void btusb_waker(struct work_struct *work)
> >       usb_autopm_put_interface(data->intf);
> > }
> >
> > +static void btusb_rx_dequeue(struct btusb_data *data,
> > +                          struct sk_buff_head *queue)
> > +{
> > +     struct sk_buff *skb;
> > +
> > +     while ((skb = skb_dequeue(queue)))
> > +             hci_recv_frame(data->hdev, skb);
> > +}
> > +
> > +static void btusb_rx_work(struct work_struct *work)
> > +{
> > +     struct btusb_data *data = container_of(work, struct btusb_data,
> > +                                            rx_work.work);
> > +
> > +     /* Process HCI event packets so states changes are synchronized first */
> > +     btusb_rx_dequeue(data, &data->evt_q);
> > +     btusb_rx_dequeue(data, &data->acl_q);
> > +}
> > +
> > static int btusb_setup_bcm92035(struct hci_dev *hdev)
> > {
> >       struct sk_buff *skb;
> > @@ -2304,10 +2355,8 @@ static void btusb_intel_secure_send_result(struct btusb_data *data,
> >               wake_up_bit(&data->flags, BTUSB_DOWNLOADING);
> > }
> >
> > -static int btusb_recv_event_intel(struct hci_dev *hdev, struct sk_buff *skb)
> > +static int btusb_recv_event_intel(struct btusb_data *data, struct sk_buff *skb)
> > {
> > -     struct btusb_data *data = hci_get_drvdata(hdev);
> > -
> >       if (test_bit(BTUSB_BOOTLOADER, &data->flags)) {
> >               struct hci_event_hdr *hdr = (void *)skb->data;
> >
> > @@ -2336,7 +2385,7 @@ static int btusb_recv_event_intel(struct hci_dev *hdev, struct sk_buff *skb)
> >               }
> >       }
> >
> > -     return hci_recv_frame(hdev, skb);
> > +     return hci_recv_frame(data->hdev, skb);
> > }
> >
> > static int btusb_send_frame_intel(struct hci_dev *hdev, struct sk_buff *skb)
> > @@ -4279,6 +4328,15 @@ static int btusb_shutdown_qca(struct hci_dev *hdev)
> >       return 0;
> > }
> >
> > +static int btusb_recv_evt(struct btusb_data *data, struct sk_buff *skb)
> > +{
> > +     if (!enable_interval)
> > +             return hci_recv_frame(data->hdev, skb);
> > +
> > +     /* Don't delay event processing */
> > +     return btusb_rx_queue(data, skb, &data->evt_q, 0);
> > +}
> > +
> > static int btusb_probe(struct usb_interface *intf,
> >                      const struct usb_device_id *id)
> > {
> > @@ -4362,6 +4420,11 @@ static int btusb_probe(struct usb_interface *intf,
> >
> >       INIT_WORK(&data->work, btusb_work);
> >       INIT_WORK(&data->waker, btusb_waker);
> > +     INIT_DELAYED_WORK(&data->rx_work, btusb_rx_work);
> > +
> > +     skb_queue_head_init(&data->acl_q);
> > +     skb_queue_head_init(&data->evt_q);
> > +
> >       init_usb_anchor(&data->deferred);
> >       init_usb_anchor(&data->tx_anchor);
> >       spin_lock_init(&data->txlock);
> > @@ -4378,7 +4441,7 @@ static int btusb_probe(struct usb_interface *intf,
> >               data->recv_bulk = btusb_recv_bulk_intel;
> >               set_bit(BTUSB_BOOTLOADER, &data->flags);
> >       } else {
> > -             data->recv_event = hci_recv_frame;
> > +             data->recv_event = btusb_recv_evt;
> >               data->recv_bulk = btusb_recv_bulk;
> >       }
> >
> > @@ -4867,6 +4930,9 @@ MODULE_PARM_DESC(force_scofix, "Force fixup of wrong SCO buffers size");
> > module_param(enable_autosuspend, bool, 0644);
> > MODULE_PARM_DESC(enable_autosuspend, "Enable USB autosuspend by default");
> >
> > +module_param(enable_interval, bool, 0644);
> > +MODULE_PARM_DESC(enable_interval, "Enable USB polling interval by default");
> > +
> > module_param(reset, bool, 0644);
> > MODULE_PARM_DESC(reset, "Send HCI reset command on initialization");
>
> Regards
>
> Marcel
>


-- 
Luiz Augusto von Dentz
