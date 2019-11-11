Return-Path: <SRS0=pK2I=ZD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA14C43331
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Nov 2019 11:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16EA021655
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Nov 2019 11:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iP0HFLNR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfKKLEZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Nov 2019 06:04:25 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:40213 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbfKKLEZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Nov 2019 06:04:25 -0500
Received: by mail-il1-f193.google.com with SMTP id d83so11706060ilk.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Nov 2019 03:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bjc2C+j46aN0i2/ydPsGSc5V6ZkrJvYybPvoFON4Pmo=;
        b=iP0HFLNRObf7RR89wJ2csaAX1zYtCYdtlMN0Wr8c+rBv4PbBCFDPxEoFzISw5WRXbT
         JnPJZONxYQ4ectooXejLbkcCAxK2GamYHaQZ1mDKca2RV4HofO+4tUBnqUiNa0GZf2aH
         naB/zbTg6XsQK5YEcG4eztGPCKlGCH9XAgNnWRQgNVjeADCsQN75arVDJ2FpzJPjhJ5Z
         Xcp474J5ifzPRuMOh4BT5AAMSD05R1lzW1895yVfaQRKqMqhZvIDUiLWgdV7j0alD8RO
         m+N29zWwtuxu1BBAJf01jPV0Hf2z33M7wp5kM+ZN4w+uBx4bU7lCAAsLC4pwM1Syklen
         NK/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bjc2C+j46aN0i2/ydPsGSc5V6ZkrJvYybPvoFON4Pmo=;
        b=Hk4hHzHOXJm+IaloPu8bMbabRErHtuQ76JlwzVdgwyJ/NvojqxVVXv5Kxn9LCQY1mJ
         DH5bSVUvbSjGLbadBRtF+lgAfPj2dV5in8AbfmQDWnx5uacUjsYJ9G1jHeVUGnNW5g/o
         ge+HrpgJoTOJ5YyXMgiLWsW+ZHpyZi01oFYrYU1vh7vzkQi2Xxy7ZCa8UdjFqVw0INbZ
         /V8yrz4aT4KaVnDJr6cX2P7qGjuRfynR42FhAdfsaukjlVSd4oqJhSgCf04Q3hnzNDgg
         8pONWWTeMbRWauesjPkXlpLiSeEAdeuPXlGHjxA1kfe6vU2/TNJXlu/3VuoIQcEviDCU
         sn0g==
X-Gm-Message-State: APjAAAU1ErcIIjpK9r86HLtnQU6b25D6ihXQUcT/+OZ2hFHGeuJFULhs
        GQgVKDAwtEZK8LvkcnH56DQztWu39LdtsycyU+pJtM2iJC4=
X-Google-Smtp-Source: APXvYqxF0o9pbRriBipPQdY9MPljbpo7l003q5gB+DRBgbBuNi1udOJp8sCuhrQdkQioS5xEJE3rTzwsVr0jIx/1Bkk=
X-Received: by 2002:a05:6e02:1014:: with SMTP id n20mr19832012ilj.221.1573470263855;
 Mon, 11 Nov 2019 03:04:23 -0800 (PST)
MIME-Version: 1.0
References: <1569476123-9951-1-git-send-email-amit.k.bag@intel.com> <1DA34553-082C-4C58-ABCC-6CFAA9E3DF3A@holtmann.org>
In-Reply-To: <1DA34553-082C-4C58-ABCC-6CFAA9E3DF3A@holtmann.org>
From:   Sathish Narasimman <nsathish41@gmail.com>
Date:   Mon, 11 Nov 2019 16:34:12 +0530
Message-ID: <CAOVXEJ+zF4WKA3hjdSJxywMFumY2AT-D8ORMAUy_tX7tRF7PMQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: hci_event: handle msbc audio over USB Endpoints
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Amit K Bag <amit.k.bag@intel.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        Sathish Narasimman <sathish.narasimman@intel.com>,
        Raghuram Hegde <raghuram.hegde@intel.com>,
        Hsin-Yu Chao <hychao@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

I will submit the next version of the patch and tried to fix all your comme=
nts.
Please check the same.

On Thu, Sep 26, 2019 at 3:52 PM Marcel Holtmann <marcel@holtmann.org> wrote=
:
>
> Hi Amit,
>
> > For msbc encoded audio stream over usb transport, btusb driver
> > to be set to alternate settings 6 as per BT core spec 5.0. This
> > done from  hci_sync_conn_complete_evt.  The type of air mode is known
> > during this event.  For this reason the btusb is to be notifed
> > about the TRANSPARENT air mode and the ALT setting 6 is selected.
> > The changes are made considering some discussion over the similar
> > patch submitted earlier from Kuba Pawlak(link below)
> > https://www.spinics.net/lists/linux-bluetooth/msg64577.html
> >
> > (am from https://www.spinics.net/lists/linux-bluetooth/msg76982.html)
> >
> > Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> > Signed-off-by: Sathish Narasimman <sathish.narasimman@intel.com>
> > Signed-off-by: Raghuram Hegde <raghuram.hegde@intel.com>
> > Signed-off-by: Hsin-Yu Chao <hychao@chromium.org>
> > Signed-off-by: Amit K Bag <amit.k.bag@intel.com>
> > ---
> > drivers/bluetooth/btusb.c   | 145 ++++++++++++++++++++++++++++++-------=
-------
> > include/net/bluetooth/hci.h |   1 +
> > net/bluetooth/hci_event.c   |   5 ++
> > 3 files changed, 106 insertions(+), 45 deletions(-)
> >
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index a9c35ebb30f8..368cc93cb17e 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -57,6 +57,9 @@ static struct usb_driver btusb_driver;
> > #define BTUSB_IFNUM_2         0x80000
> > #define BTUSB_CW6622          0x100000
> > #define BTUSB_MEDIATEK                0x200000
> > +#define BTUSB_ALT6_FLOW_CNTRL        6
> > +
> > +static int set_hci_packet_interval_flow =3D BTUSB_ALT6_FLOW_CNTRL;
>
> this can never be a global variable. We allow multiple devices be attache=
d to the same host. You need to move this into btusb_data struct.
>
> >
> > static const struct usb_device_id btusb_table[] =3D {
> >       /* Generic Bluetooth USB device */
> > @@ -974,6 +977,38 @@ static void btusb_isoc_complete(struct urb *urb)
> >       }
> > }
> >
> > +static inline void __fill_isoc_descriptor_msbc(struct urb *urb, int le=
n,
> > +                                            int mtu)
> > +{
> > +     int i, offset =3D 0;
> > +
> > +     /* For msbc ALT 6 setting the host will send the packet at contin=
uous
> > +      * flow. As per core spec 5, vol 4, part B, table 2.1. For ALT se=
tting
> > +      * 6 the HCI PACKET INTERVAL should be 7.5ms for every usb packet=
s.
> > +      * To maintain the rate we send 63bytes of usb packets alternativ=
ely for
> > +      * 7ms and 8ms to maintain the rate as 7.5ms.
> > +      */
> > +     if (set_hci_packet_interval_flow =3D=3D 6)
> > +             set_hci_packet_interval_flow =3D 7;
> > +     else if (set_hci_packet_interval_flow =3D=3D 7)
> > +             set_hci_packet_interval_flow =3D 6;
>
> can=E2=80=99t this just be a bool that you just toggle.
Done.
>
> > +
> > +     BT_DBG("len %d mtu %d", len, mtu);
> > +
> > +     for (i =3D 0; i < set_hci_packet_interval_flow; i++) {
> > +             urb->iso_frame_desc[i].offset =3D offset;
> > +             urb->iso_frame_desc[i].length =3D offset;
> > +     }
> > +
> > +     if (len && i < BTUSB_MAX_ISOC_FRAMES) {
> > +             urb->iso_frame_desc[i].offset =3D offset;
> > +             urb->iso_frame_desc[i].length =3D len;
> > +             i++;
> > +     }
> > +
> > +     urb->number_of_packets =3D i;
> > +}
> > +
> > static inline void __fill_isoc_descriptor(struct urb *urb, int len, int=
 mtu)
> > {
> >       int i, offset =3D 0;
> > @@ -1376,9 +1411,12 @@ static struct urb *alloc_isoc_urb(struct hci_dev=
 *hdev, struct sk_buff *skb)
> >
> >       urb->transfer_flags  =3D URB_ISO_ASAP;
> >
> > -     __fill_isoc_descriptor(urb, skb->len,
> > +     if (data->isoc_altsetting =3D=3D 6)
> > +             __fill_isoc_descriptor_msbc(urb, skb->len,
> > +                            le16_to_cpu(data->isoc_tx_ep->wMaxPacketSi=
ze));
> > +     else
> > +             __fill_isoc_descriptor(urb, skb->len,
> >                              le16_to_cpu(data->isoc_tx_ep->wMaxPacketSi=
ze));
> > -
> >       skb->dev =3D (void *)hdev;
> >
> >       return urb;
> > @@ -1466,18 +1504,6 @@ static int btusb_send_frame(struct hci_dev *hdev=
, struct sk_buff *skb)
> >       return -EILSEQ;
> > }
> >
> > -static void btusb_notify(struct hci_dev *hdev, unsigned int evt)
> > -{
> > -     struct btusb_data *data =3D hci_get_drvdata(hdev);
> > -
> > -     BT_DBG("%s evt %d", hdev->name, evt);
> > -
> > -     if (hci_conn_num(hdev, SCO_LINK) !=3D data->sco_num) {
> > -             data->sco_num =3D hci_conn_num(hdev, SCO_LINK);
> > -             schedule_work(&data->work);
> > -     }
> > -}
> > -
> > static inline int __set_isoc_interface(struct hci_dev *hdev, int altset=
ting)
> > {
> >       struct btusb_data *data =3D hci_get_drvdata(hdev);
> > @@ -1521,6 +1547,65 @@ static inline int __set_isoc_interface(struct hc=
i_dev *hdev, int altsetting)
> >       return 0;
> > }
> >
> > +static int bt_switch_alt_setting(struct hci_dev *hdev, int new_alts)
> > +{
> > +     struct btusb_data *data =3D hci_get_drvdata(hdev);
> > +     int err;
> > +
> > +     if (data->isoc_altsetting !=3D new_alts) {
> > +             unsigned long flags;
> > +
> > +             clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
> > +             usb_kill_anchored_urbs(&data->isoc_anchor);
> > +
> > +             /* When isochronous alternate setting needs to be
> > +              * changed, because SCO connection has been added
> > +              * or removed, a packet fragment may be left in the
> > +              * reassembling state. This could lead to wrongly
> > +              * assembled fragments.
> > +              *
> > +              * Clear outstanding fragment when selecting a new
> > +              * alternate setting.
> > +              */
> > +             spin_lock_irqsave(&data->rxlock, flags);
> > +             kfree_skb(data->sco_skb);
> > +             data->sco_skb =3D NULL;
> > +             spin_unlock_irqrestore(&data->rxlock, flags);
> > +
> > +             err =3D __set_isoc_interface(hdev, new_alts);
> > +             if (err < 0)
> > +                     return err;
> > +     }
> > +     if (!test_and_set_bit(BTUSB_ISOC_RUNNING, &data->flags)) {
> > +             if (btusb_submit_isoc_urb(hdev, GFP_KERNEL) < 0)
> > +                     clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
> > +             else
> > +                     btusb_submit_isoc_urb(hdev, GFP_KERNEL);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static void btusb_notify(struct hci_dev *hdev, unsigned int evt)
> > +{
> > +     struct btusb_data *data =3D hci_get_drvdata(hdev);
> > +
> > +     BT_DBG("%s evt %d", hdev->name, evt);
> > +
> > +     if (hci_conn_num(hdev, SCO_LINK) !=3D data->sco_num) {
> > +             data->sco_num =3D hci_conn_num(hdev, SCO_LINK);
> > +             schedule_work(&data->work);
> > +     }
>
> Since the internal processing of packets moved from a tasklet to a workqu=
eue, I think the extra workqueue inside btusb can be actually removed. So I=
 would get rid of this also for the non-mSBC case.
Have left as it is. Expecting you will change this.
>
> > +
> > +     if (evt =3D=3D HCI_NOTIFY_AIR_MODE_TRANSP) {
> > +             /* Alt setting 6 is used for msbc encoded
> > +              * audio channel
> > +              */
> > +             if (bt_switch_alt_setting(hdev, 6) < 0)
> > +                     BT_ERR("%s Set USB Alt6 failed", hdev->name);
> > +     }
> > +}
> > +
>
> I think this is really a one or the other. If the controller supports alt=
ernate setting 6 (which you actually have to check first) and it is air mod=
e transparent then switch to alternate setting 6. Otherwise do what we have=
 done before.
Done.
>
> > static void btusb_work(struct work_struct *work)
> > {
> >       struct btusb_data *data =3D container_of(work, struct btusb_data,=
 work);
> > @@ -1547,37 +1632,7 @@ static void btusb_work(struct work_struct *work)
> >               } else {
> >                       new_alts =3D data->sco_num;
> >               }
> > -
> > -             if (data->isoc_altsetting !=3D new_alts) {
> > -                     unsigned long flags;
> > -
> > -                     clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
> > -                     usb_kill_anchored_urbs(&data->isoc_anchor);
> > -
> > -                     /* When isochronous alternate setting needs to be
> > -                      * changed, because SCO connection has been added
> > -                      * or removed, a packet fragment may be left in t=
he
> > -                      * reassembling state. This could lead to wrongly
> > -                      * assembled fragments.
> > -                      *
> > -                      * Clear outstanding fragment when selecting a ne=
w
> > -                      * alternate setting.
> > -                      */
> > -                     spin_lock_irqsave(&data->rxlock, flags);
> > -                     kfree_skb(data->sco_skb);
> > -                     data->sco_skb =3D NULL;
> > -                     spin_unlock_irqrestore(&data->rxlock, flags);
> > -
> > -                     if (__set_isoc_interface(hdev, new_alts) < 0)
> > -                             return;
> > -             }
> > -
> > -             if (!test_and_set_bit(BTUSB_ISOC_RUNNING, &data->flags)) =
{
> > -                     if (btusb_submit_isoc_urb(hdev, GFP_KERNEL) < 0)
> > -                             clear_bit(BTUSB_ISOC_RUNNING, &data->flag=
s);
> > -                     else
> > -                             btusb_submit_isoc_urb(hdev, GFP_KERNEL);
> > -             }
> > +             bt_switch_alt_setting(hdev, new_alts);
> >       } else {
> >               clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
> >               usb_kill_anchored_urbs(&data->isoc_anchor);
> > diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> > index 5bc1e30dedde..89ac29f1dffa 100644
> > --- a/include/net/bluetooth/hci.h
> > +++ b/include/net/bluetooth/hci.h
> > @@ -52,6 +52,7 @@
> > #define HCI_NOTIFY_CONN_ADD           1
> > #define HCI_NOTIFY_CONN_DEL           2
> > #define HCI_NOTIFY_VOICE_SETTING      3
> > +#define HCI_NOTIFY_AIR_MODE_TRANSP   4
> >
> > /* HCI bus types */
> > #define HCI_VIRTUAL   0
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index c1d3a303d97f..1c268932422c 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -4231,6 +4231,11 @@ static void hci_sync_conn_complete_evt(struct hc=
i_dev *hdev,
> >               break;
> >       }
> >
> > +     if (ev->air_mode =3D=3D SCO_AIRMODE_TRANSP) {
> > +             if (hdev->notify)
> > +                     hdev->notify(hdev, HCI_NOTIFY_AIR_MODE_TRANSP);
> > +     }
> > +
>
> So this might work, but causes the USB subsystem to change the alternate =
setting twice. Once for CONN_ADD and once for SCO_AIRMODE_TRANSP. I prefer =
we just change the alternate setting once.

> Maybe it is better to change CONN_ADD and CONN_DEL to an explicit ENABLE_=
SCO_CVSD and ENABLE_SCO_TRANSP and DISABLE_SCO.

Done.

>
> Regards
>
> Marcel
>

Regards
Sathish N
