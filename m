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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E651CC433DB
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Feb 2021 21:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9392064E56
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Feb 2021 21:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235581AbhBHVOh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Feb 2021 16:14:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234270AbhBHVN4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Feb 2021 16:13:56 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8DAC061786
        for <linux-bluetooth@vger.kernel.org>; Mon,  8 Feb 2021 13:13:16 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id 18so6030324oiz.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Feb 2021 13:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9P0I4vCZKt0yp7dgXa5ZS5CvmXZRHwAzznNVcKtDy0c=;
        b=hu/Ij2PlI3dnDA1JUNmaNgcIIb+SrOfyprYwTj7cYchco4JZY0KOEtdzqnGfPUN8BV
         qNOchSg9PhE9twG2HC/HuPDpnqdHQ6/J4XEDdtVi0lSQOrYbS3Du0qDXuoNMBKyv+UnO
         WXTFThDFCwjLpCOaHyWD8usUKyLEwoZUBYVc0UmmzfKBeTT8/1OXiTPRvhjCbX9zRJja
         G3c+rgcjTJoFnO4y8fIsal4jI0604hIOSZa7q0SKShsShSycIFiTRfBckEjZIJP3STPF
         tZaPpYFKTmkOxn6KV5Ihgx2rLX8fGgI6QYQK1Z7gpWV/YPpJ2bknn/F4mlZdprhsH5N6
         aWmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9P0I4vCZKt0yp7dgXa5ZS5CvmXZRHwAzznNVcKtDy0c=;
        b=mVrCQy7zB1ClUfTVTxS0+4dJxZ6H1AxcgQB44y2m599ym7lmZwa8NVTgM6IR8yovZ0
         sT+UzVzDvOiXXh8ZgiW1kGRwdLpcdLSqzsN5N3tfHvMmVL4zXYRem3N8J6mwV9LdKGS6
         k4/fMHIVRsh3CpiJjWy8Hpaj/s0EVnS7eprdpOVinPtJiHpAX6WiWbZIhiT2mKqCPWFp
         I6YgyG4RxrxATnlf3CVdPYE8/DSbcicP30MCQ/4U808khGaE5zHdoNpqyVvIoWlh83co
         6pF6LEc8lnqWVrDRIfAOv12umCTCQehvxXuXOUy94VWKgfkrMrgLkCwNq2QLsKd7BFKD
         lovQ==
X-Gm-Message-State: AOAM533YF4ZbFJwup457bCD6NER0aTT/ODYKU0MHVx34IFxdCfaD2fQz
        AYKJd+Wdnz0xEESLmOy/0+2nVMJOovcxHsi8v3yAggLRB0Z8nw==
X-Google-Smtp-Source: ABdhPJw3oQKQUbJxoD7WOJS5tFb+0p/SEhjzANg4DxhMM1g2awEm0Kifx4bsqpJRRFAWxnOTbE4tQ93ImNrOCua2YMY=
X-Received: by 2002:a05:6808:1290:: with SMTP id a16mr425158oiw.161.1612818795669;
 Mon, 08 Feb 2021 13:13:15 -0800 (PST)
MIME-Version: 1.0
References: <20210126185042.114037-1-luiz.dentz@gmail.com> <F74EFDC2-E5BB-4733-98CC-393BF47B75C8@holtmann.org>
In-Reply-To: <F74EFDC2-E5BB-4733-98CC-393BF47B75C8@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 8 Feb 2021 13:13:04 -0800
Message-ID: <CABBYNZJWHzoCTPbxePv2JN_+e=waz=i40+Ypyd13eA+UXJwnWA@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: btusb: Add support for queuing during
 polling interval
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Thu, Feb 4, 2021 at 5:06 AM Marcel Holtmann <marcel@holtmann.org> wrote:
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
> >    CONFIG_BT_HCIBTUSB_INTERVAL=3Dy
> >
> > At runtime with use of module option:
> >
> >    enable_interval
> >
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> >
> > v2: Calculate the delayed_work interval based on the intr urb->interval=
 which
> > is derived from endpoint bInterval.
> > v3: Drop use of a queue for events.
>
> we should get this tested and if this actually helps reducing the issue.
>
> If this does work in general, we can adopt a version of this upstream.
>
> > drivers/bluetooth/Kconfig |  7 +++
> > drivers/bluetooth/btusb.c | 98 ++++++++++++++++++++++++++++++++++-----
> > 2 files changed, 94 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> > index 4e73a531b377..2f20a853d946 100644
> > --- a/drivers/bluetooth/Kconfig
> > +++ b/drivers/bluetooth/Kconfig
> > @@ -41,6 +41,13 @@ config BT_HCIBTUSB_AUTOSUSPEND
> >         This can be overridden by passing btusb.enable_autosuspend=3D[y=
|n]
> >         on the kernel commandline.
> >
> > +config BT_HCIBTUSB_INTERVAL
> > +     bool "Enable notification of USB polling interval"
> > +     depends on BT_HCIBTUSB
> > +     help
> > +       Say Y here to enable notification of USB polling interval for
> > +       Bluetooth USB devices by default.
> > +
>
> So, I am not really convinced it is a good idea to have this as a Kconfig=
 option. I think this always needs to be some runtime thing you enable with=
 a config file. Module option are really just a lame way of hacking things =
and we should most likely start to get rid of them.
>
> Anyhow, my main concern here is that no matter how good your comment is h=
ere, people will false enable it and wonder why things might not work as ex=
pected anymore when they try to qualify things and packets get wrongly labe=
led as encrypted but in reality they are not.
>
> So I wonder if we can do mgmt experimental features on a per driver basis=
. If so, we might better provide this feature via an obscure UUID that is d=
ocumented. And I wanted to expose more details about the attached hardware =
anyway. That way the platform or bluetoothd can then decide on when to enab=
le this or not. There might be hardware that does a way better job anyhow t=
han other and doesn=E2=80=99t need this.

Ok, how about we first introduce as a module parameter and then once
we have the hardware information shared over the MGMT interface we can
use the experimental features to enable/disable it.

> > config BT_HCIBTUSB_BCM
> >       bool "Broadcom protocol support"
> >       depends on BT_HCIBTUSB
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index b14102fba601..4266c057746e 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -30,7 +30,7 @@
> > static bool disable_scofix;
> > static bool force_scofix;
> > static bool enable_autosuspend =3D IS_ENABLED(CONFIG_BT_HCIBTUSB_AUTOSU=
SPEND);
> > -
> > +static bool enable_interval =3D IS_ENABLED(CONFIG_BT_HCIBTUSB_INTERVAL=
);
> > static bool reset =3D true;
> >
> > static struct usb_driver btusb_driver;
> > @@ -519,8 +519,12 @@ struct btusb_data {
> >
> >       unsigned long flags;
> >
> > -     struct work_struct work;
> > -     struct work_struct waker;
> > +     int intr_interval;
> > +     struct work_struct  work;
> > +     struct work_struct  waker;
> > +     struct delayed_work rx_work;
> > +
> > +     struct sk_buff_head acl_q;
> >
> >       struct usb_anchor deferred;
> >       struct usb_anchor tx_anchor;
> > @@ -557,7 +561,7 @@ struct btusb_data {
> >       int isoc_altsetting;
> >       int suspend_count;
> >
> > -     int (*recv_event)(struct hci_dev *hdev, struct sk_buff *skb);
> > +     int (*recv_event)(struct btusb_data *data, struct sk_buff *skb);
> >       int (*recv_bulk)(struct btusb_data *data, void *buffer, int count=
);
> >
> >       int (*setup_on_usb)(struct hci_dev *hdev);
> > @@ -707,7 +711,7 @@ static int btusb_recv_intr(struct btusb_data *data,=
 void *buffer, int count)
> >
> >               if (!hci_skb_expect(skb)) {
> >                       /* Complete frame */
> > -                     data->recv_event(data->hdev, skb);
> > +                     data->recv_event(data, skb);
> >                       skb =3D NULL;
> >               }
> >       }
> > @@ -718,6 +722,24 @@ static int btusb_recv_intr(struct btusb_data *data=
, void *buffer, int count)
> >       return err;
> > }
> >
> > +static int btusb_rx_queue(struct btusb_data *data, struct sk_buff *skb=
,
> > +                       struct sk_buff_head *queue, unsigned int interv=
al)
> > +{
> > +     skb_queue_tail(queue, skb);
> > +
> > +     schedule_delayed_work(&data->rx_work, interval);
> > +
> > +     return 0;
> > +}
> > +
> > +static int btusb_recv_acl(struct btusb_data *data, struct sk_buff *skb=
)
> > +{
> > +     if (!enable_interval)
> > +             return hci_recv_frame(data->hdev, skb);
> > +
> > +     return btusb_rx_queue(data, skb, &data->acl_q, data->intr_interva=
l);
> > +}
> > +
>
> Combine these two into one function.
>
> > static int btusb_recv_bulk(struct btusb_data *data, void *buffer, int c=
ount)
> > {
> >       struct sk_buff *skb;
> > @@ -765,7 +787,7 @@ static int btusb_recv_bulk(struct btusb_data *data,=
 void *buffer, int count)
> >
> >               if (!hci_skb_expect(skb)) {
> >                       /* Complete frame */
> > -                     hci_recv_frame(data->hdev, skb);
> > +                     btusb_recv_acl(data, skb);
> >                       skb =3D NULL;
> >               }
> >       }
> > @@ -917,6 +939,19 @@ static int btusb_submit_intr_urb(struct hci_dev *h=
dev, gfp_t mem_flags)
> >               usb_unanchor_urb(urb);
> >       }
> >
> > +     /* The units are frames (milliseconds) for full and low speed dev=
ices,
> > +      * and microframes (1/8 millisecond) for highspeed and SuperSpeed
> > +      * devices.
> > +      */
> > +     switch (urb->dev->speed) {
> > +     case USB_SPEED_SUPER_PLUS:
> > +     case USB_SPEED_SUPER:   /* units are 125us */
> > +             data->intr_interval =3D usecs_to_jiffies(urb->interval * =
125);
> > +             break;
> > +     default:
> > +             data->intr_interval =3D msecs_to_jiffies(urb->interval);
> > +     }
> > +
>
> Do we have to do this on every interrupt URB submission? Or can we just g=
et this once at probe()?

Afaik btusb_submit_intr_urb is only called in btusb_open and
btusb_resume, note there are some changes to urb->dev->speed when
usb_submit_urb is called urb->interval maybe adjusted thus why I had
captured the interval after submission.

> >       usb_free_urb(urb);
> >
> >       return err;
> > @@ -1383,9 +1418,12 @@ static int btusb_close(struct hci_dev *hdev)
> >
> >       BT_DBG("%s", hdev->name);
> >
> > +     cancel_delayed_work(&data->rx_work);
> >       cancel_work_sync(&data->work);
> >       cancel_work_sync(&data->waker);
> >
> > +     skb_queue_purge(&data->acl_q);
> > +
> >       clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
> >       clear_bit(BTUSB_BULK_RUNNING, &data->flags);
> >       clear_bit(BTUSB_INTR_RUNNING, &data->flags);
> > @@ -1417,6 +1455,10 @@ static int btusb_flush(struct hci_dev *hdev)
> >
> >       BT_DBG("%s", hdev->name);
> >
> > +     cancel_delayed_work(&data->rx_work);
> > +
> > +     skb_queue_purge(&data->acl_q);
> > +
> >       usb_kill_anchored_urbs(&data->tx_anchor);
> >       btusb_free_frags(data);
> >
> > @@ -1769,6 +1811,24 @@ static void btusb_waker(struct work_struct *work=
)
> >       usb_autopm_put_interface(data->intf);
> > }
> >
> > +static void btusb_rx_dequeue(struct btusb_data *data,
> > +                          struct sk_buff_head *queue)
> > +{
> > +     struct sk_buff *skb;
> > +
> > +     while ((skb =3D skb_dequeue(queue)))
> > +             hci_recv_frame(data->hdev, skb);
> > +}
> > +
> > +static void btusb_rx_work(struct work_struct *work)
> > +{
> > +     struct btusb_data *data =3D container_of(work, struct btusb_data,
> > +                                            rx_work.work);
> > +
> > +     /* Dequeue ACL data received during the interval */
> > +     btusb_rx_dequeue(data, &data->acl_q);
> > +}
> > +
>
> Combine these two into one function.
>
> > static int btusb_setup_bcm92035(struct hci_dev *hdev)
> > {
> >       struct sk_buff *skb;
> > @@ -2304,10 +2364,8 @@ static void btusb_intel_secure_send_result(struc=
t btusb_data *data,
> >               wake_up_bit(&data->flags, BTUSB_DOWNLOADING);
> > }
> >
> > -static int btusb_recv_event_intel(struct hci_dev *hdev, struct sk_buff=
 *skb)
> > +static int btusb_recv_event_intel(struct btusb_data *data, struct sk_b=
uff *skb)
> > {
> > -     struct btusb_data *data =3D hci_get_drvdata(hdev);
> > -
> >       if (test_bit(BTUSB_BOOTLOADER, &data->flags)) {
> >               struct hci_event_hdr *hdr =3D (void *)skb->data;
> >
> > @@ -2336,7 +2394,7 @@ static int btusb_recv_event_intel(struct hci_dev =
*hdev, struct sk_buff *skb)
> >               }
> >       }
> >
> > -     return hci_recv_frame(hdev, skb);
> > +     return hci_recv_frame(data->hdev, skb);
> > }
> >
> > static int btusb_send_frame_intel(struct hci_dev *hdev, struct sk_buff =
*skb)
> > @@ -4279,6 +4337,17 @@ static int btusb_shutdown_qca(struct hci_dev *hd=
ev)
> >       return 0;
> > }
> >
> > +static int btusb_recv_evt(struct btusb_data *data, struct sk_buff *skb=
)
> > +{
> > +     if (!enable_interval)
> > +             return hci_recv_frame(data->hdev, skb);
> > +
> > +     /* Trigger dequeue immediatelly if an event is received */
> > +     schedule_delayed_work(&data->rx_work, 0);
> > +
> > +     return hci_recv_frame(data->hdev, skb);
> > +}
> > +
> > static int btusb_probe(struct usb_interface *intf,
> >                      const struct usb_device_id *id)
> > {
> > @@ -4362,6 +4431,10 @@ static int btusb_probe(struct usb_interface *int=
f,
> >
> >       INIT_WORK(&data->work, btusb_work);
> >       INIT_WORK(&data->waker, btusb_waker);
> > +     INIT_DELAYED_WORK(&data->rx_work, btusb_rx_work);
> > +
> > +     skb_queue_head_init(&data->acl_q);
> > +
> >       init_usb_anchor(&data->deferred);
> >       init_usb_anchor(&data->tx_anchor);
> >       spin_lock_init(&data->txlock);
> > @@ -4378,7 +4451,7 @@ static int btusb_probe(struct usb_interface *intf=
,
> >               data->recv_bulk =3D btusb_recv_bulk_intel;
> >               set_bit(BTUSB_BOOTLOADER, &data->flags);
> >       } else {
> > -             data->recv_event =3D hci_recv_frame;
> > +             data->recv_event =3D btusb_recv_evt;
> >               data->recv_bulk =3D btusb_recv_bulk;
> >       }
> >
> > @@ -4867,6 +4940,9 @@ MODULE_PARM_DESC(force_scofix, "Force fixup of wr=
ong SCO buffers size");
> > module_param(enable_autosuspend, bool, 0644);
> > MODULE_PARM_DESC(enable_autosuspend, "Enable USB autosuspend by default=
");
> >
> > +module_param(enable_interval, bool, 0644);
> > +MODULE_PARM_DESC(enable_interval, "Enable USB polling interval by defa=
ult");
> > +
>
> For a testing patch, leave this option in (just scrap the Kconfig part) a=
nd name =E2=80=9CEnable URB polling interval synchronization=E2=80=9D. I wo=
uld also name the option =E2=80=9Cenable_poll_sync=E2=80=9D.

Will update according to your comments.

> > module_param(reset, bool, 0644);
> > MODULE_PARM_DESC(reset, "Send HCI reset command on initialization");
>
> Regards
>
> Marcel
>


--=20
Luiz Augusto von Dentz
