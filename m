Return-Path: <SRS0=u1pM=5S=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA91C43331
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Apr 2020 15:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A436B206CC
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Apr 2020 15:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLkGYhyn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389109AbgDBPNF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Apr 2020 11:13:05 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:37105 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388986AbgDBPNF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Apr 2020 11:13:05 -0400
Received: by mail-il1-f194.google.com with SMTP id a6so3942177ilr.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Apr 2020 08:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0hdnsaH4IN/f8LQNI9xr4zS+X0EtH7uXXgmzKJLZCfg=;
        b=DLkGYhyn3EyHYOMlOvgHWO7FPqbBukntQWqnMH73M53Jxoi8qfoc/RHtF/C4ZQSWDu
         sQpzlpG9ncuipIypO1VAGlk0FoxE2p/WHnRmQtC6021kAbzZh6rosUCwwhIZqgpKgYkf
         zfSI1otNbHfgacSZOKUhSQHqXALCFvM22vBtEJXY7StiLXlmlF6R2WXlFerWxf1PqRPY
         z+r09sjq5K4phpaZJglRm0jiZoAYFZogGeoPNQCUzPTRcUkOTu1ToYjYb4Li4wScJd+5
         igH789BtIyPHyH9JkKNwMqdyuJpilApmgahvrmMEa06lnUeaXYOxjPrz5ESVcgrU6dGY
         T7Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0hdnsaH4IN/f8LQNI9xr4zS+X0EtH7uXXgmzKJLZCfg=;
        b=WRvOE0MRcmctb8fGOBTGZ3453z0l3j2n612Gd0xGEiG/wpSe/MTWFbsa0ZnIUYgD9N
         9JunYofR8oTFn2sNQNtyCCpqZ7HtmsrzGH8WBF7XvWEoUXMAr+785vZrWrni2F04wDoc
         mXDQh2QrEEk8ZfQoxUgMcyhOI2eYDcvVPyQFAAlDquzM/oGSvSYhv4cvG7lIOWROIOVS
         ib3ihHw7WIsc+KSD//GnJyFCbMA4h6bbUt1k2Zmw5JyxNvNP5KTaBFRo72MJI4IA6wpE
         ufr7kmylQov15XS7Z0Y1IrguTSCIbZZIZZnyGqIRbDURJflWntVaSeiP97JkqbLrRA6t
         lPPg==
X-Gm-Message-State: AGi0Pua4Omm+DYoSSoR7FsfyivZyYj4AuETfRyytrE4Uflsy4bHYV5UD
        NQ7dKC+DKdaaMQrrkDrqMGKmDqfT1GPavp5wRNA=
X-Google-Smtp-Source: APiQypLtMsC7/92lIfAr687z4Bai2+NaCCDs249h5PK+TbTtNlIdrCpUWGQyTWYdlclHizGFp88LeS+EFUoltONh0V4=
X-Received: by 2002:a92:c8c8:: with SMTP id c8mr3507661ilq.221.1585840383230;
 Thu, 02 Apr 2020 08:13:03 -0700 (PDT)
MIME-Version: 1.0
References: <20191205083229.29890-1-sathish.narasimman@intel.com> <F0282871-5558-4582-A1EC-F938BA8F77B8@holtmann.org>
In-Reply-To: <F0282871-5558-4582-A1EC-F938BA8F77B8@holtmann.org>
From:   Sathish Narasimman <nsathish41@gmail.com>
Date:   Thu, 2 Apr 2020 20:42:49 +0530
Message-ID: <CAOVXEJJhbFLPb3_4SsG_2b4Sjtzvozq3QrbTO-LbJjo_tUwE9w@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] bluetooth:btusb: handle msbc audio over USB Endpoints
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Sathish Narasimman <sathish.narasimman@intel.com>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Hsin-Yu Chao <hychao@chromium.org>,
        Amit K Bag <amit.k.bag@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Tue, Mar 31, 2020 at 4:08 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Sathish,
>
> > For msbc encoded audio stream over usb transport, btusb driver
> > to be set to alternate settings 6 as per BT core spec 5.0. The
> > type of air mode is used to differenting which alt setting to be
> > used.
> > The changes are made considering some discussion over the similar
> > patch submitted earlier from Kuba Pawlak(link below)
> > https://www.spinics.net/lists/linux-bluetooth/msg64577.html
> >
> > Reported-by: kbuild test robot <lkp@intel.com>
> > Signed-off-by: Sathish Narasimman <sathish.narasimman@intel.com>
> > Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> > Signed-off-by: Hsin-Yu Chao <hychao@chromium.org>
> > Signed-off-by: Amit K Bag <amit.k.bag@intel.com>
> > ---
> > drivers/bluetooth/btusb.c | 157 +++++++++++++++++++++++++++++---------
> > 1 file changed, 121 insertions(+), 36 deletions(-)
> >
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index d9cd0677d41c..5563569f4473 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -483,6 +483,8 @@ struct btusb_data {
> >       __u8 cmdreq;
> >
> >       unsigned int sco_num;
> > +     unsigned int air_mode;
> > +     bool usb_alt6_packet_flow;
> >       int isoc_altsetting;
> >       int suspend_count;
> >
> > @@ -974,6 +976,42 @@ static void btusb_isoc_complete(struct urb *urb)
> >       }
> > }
> >
> > +static inline void __fill_isoc_descriptor_msbc(struct urb *urb, int len,
> > +                                            int mtu, struct btusb_data *data)
> > +{
> > +     int i, offset = 0;
> > +     unsigned int interval;
> > +
> > +     /* For msbc ALT 6 setting the host will send the packet at continuous
> > +      * flow. As per core spec 5, vol 4, part B, table 2.1. For ALT setting
> > +      * 6 the HCI PACKET INTERVAL should be 7.5ms for every usb packets.
> > +      * To maintain the rate we send 63bytes of usb packets alternatively for
> > +      * 7ms and 8ms to maintain the rate as 7.5ms.
> > +      */
> > +     if (data->usb_alt6_packet_flow) {
> > +             interval = 7;
> > +             data->usb_alt6_packet_flow = false;
> > +     } else {
> > +             interval = 6;
> > +             data->usb_alt6_packet_flow = true;
> > +     }
> > +
> > +     BT_DBG("interval:%d len %d mtu %d", interval, len, mtu);
>
> do you really want to keep this BT_DBG here?
>
Will move it to the beginning of fn

> > +
> > +     for (i = 0; i < interval; i++) {
> > +             urb->iso_frame_desc[i].offset = offset;
> > +             urb->iso_frame_desc[i].length = offset;
> > +     }
> > +
> > +     if (len && i < BTUSB_MAX_ISOC_FRAMES) {
> > +             urb->iso_frame_desc[i].offset = offset;
> > +             urb->iso_frame_desc[i].length = len;
> > +             i++;
> > +     }
> > +
> > +     urb->number_of_packets = i;
> > +}
> > +
> > static inline void __fill_isoc_descriptor(struct urb *urb, int len, int mtu)
> > {
> >       int i, offset = 0;
> > @@ -1377,9 +1415,13 @@ static struct urb *alloc_isoc_urb(struct hci_dev *hdev, struct sk_buff *skb)
> >
> >       urb->transfer_flags  = URB_ISO_ASAP;
> >
> > -     __fill_isoc_descriptor(urb, skb->len,
> > +     if (data->isoc_altsetting == 6)
> > +             __fill_isoc_descriptor_msbc(urb, skb->len,
> > +                            le16_to_cpu(data->isoc_tx_ep->wMaxPacketSize),
> > +                            data);
> > +     else
> > +             __fill_isoc_descriptor(urb, skb->len,
> >                              le16_to_cpu(data->isoc_tx_ep->wMaxPacketSize));
> > -
>
> Your changes are now breaking the coding style. Please fix them.
>
Will fix them in next version

> >       skb->dev = (void *)hdev;
> >
> >       return urb;
> > @@ -1475,6 +1517,7 @@ static void btusb_notify(struct hci_dev *hdev, unsigned int evt)
> >
> >       if (hci_conn_num(hdev, SCO_LINK) != data->sco_num) {
> >               data->sco_num = hci_conn_num(hdev, SCO_LINK);
> > +             data->air_mode = evt;
> >               schedule_work(&data->work);
> >       }
> > }
> > @@ -1522,11 +1565,70 @@ static inline int __set_isoc_interface(struct hci_dev *hdev, int altsetting)
> >       return 0;
> > }
> >
> > +static int bt_switch_alt_setting(struct hci_dev *hdev, int new_alts)
> > +{
> > +     struct btusb_data *data = hci_get_drvdata(hdev);
> > +     int err;
> > +
> > +     if (data->isoc_altsetting != new_alts) {
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
> > +             data->sco_skb = NULL;
> > +             spin_unlock_irqrestore(&data->rxlock, flags);
> > +
> > +             err = __set_isoc_interface(hdev, new_alts);
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
> > +static struct usb_host_interface *btusb_find_altsetting(struct btusb_data *data, int alt)
> > +{
> > +     struct usb_interface *intf = data->isoc;
> > +     int i;
> > +
> > +     BT_DBG("Looking for Alt no :%d", alt);
> > +
> > +     if (intf == NULL) {
> > +             BT_ERR("INterface NULL");
>
> I would not put an error here. And we check if (!intf).
>
will remove the error check

> > +             return NULL;
> > +     }
> > +
> > +     for (i = 0; i < intf->num_altsetting; i++) {
> > +             if (intf->altsetting[i].desc.bAlternateSetting == alt)
> > +                     return &intf->altsetting[i];
> > +     }
> > +
> > +     return NULL;
> > +}
> > +
> > static void btusb_work(struct work_struct *work)
> > {
> >       struct btusb_data *data = container_of(work, struct btusb_data, work);
> >       struct hci_dev *hdev = data->hdev;
> > -     int new_alts;
> > +     int new_alts = 0;
> >       int err;
> >
> >       if (data->sco_num > 0) {
> > @@ -1541,44 +1643,27 @@ static void btusb_work(struct work_struct *work)
> >                       set_bit(BTUSB_DID_ISO_RESUME, &data->flags);
> >               }
> >
> > -             if (hdev->voice_setting & 0x0020) {
> > -                     static const int alts[3] = { 2, 4, 5 };
> > -
> > -                     new_alts = alts[data->sco_num - 1];
> > -             } else {
> > -                     new_alts = data->sco_num;
> > -             }
> > -
> > -             if (data->isoc_altsetting != new_alts) {
> > -                     unsigned long flags;
> > +             if (data->air_mode == HCI_NOTIFY_ENABLE_SCO_CVSD) {
> > +                     if (hdev->voice_setting & 0x0020) {
> > +                             static const int alts[3] = { 2, 4, 5 };
> >
> > -                     clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
> > -                     usb_kill_anchored_urbs(&data->isoc_anchor);
> > -
> > -                     /* When isochronous alternate setting needs to be
> > -                      * changed, because SCO connection has been added
> > -                      * or removed, a packet fragment may be left in the
> > -                      * reassembling state. This could lead to wrongly
> > -                      * assembled fragments.
> > -                      *
> > -                      * Clear outstanding fragment when selecting a new
> > -                      * alternate setting.
> > -                      */
> > -                     spin_lock_irqsave(&data->rxlock, flags);
> > -                     kfree_skb(data->sco_skb);
> > -                     data->sco_skb = NULL;
> > -                     spin_unlock_irqrestore(&data->rxlock, flags);
> > +                             new_alts = alts[data->sco_num - 1];
> > +                     } else {
> > +                             new_alts = data->sco_num;
> > +                     }
> > +             } else if (data->air_mode == HCI_NOTIFY_ENABLE_SCO_TRANSP) {
> >
> > -                     if (__set_isoc_interface(hdev, new_alts) < 0)
> > -                             return;
> > -             }
> > +                     data->usb_alt6_packet_flow = true;
> >
> > -             if (!test_and_set_bit(BTUSB_ISOC_RUNNING, &data->flags)) {
> > -                     if (btusb_submit_isoc_urb(hdev, GFP_KERNEL) < 0)
> > -                             clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
> > +                     /* Check if Alt 6 is supported for Transparent audio*/
> > +                     if (btusb_find_altsetting(data, 6))
> > +                             new_alts = 6;
> >                       else
> > -                             btusb_submit_isoc_urb(hdev, GFP_KERNEL);
> > +                             BT_ERR("%s Device does not support ALT setting 6", hdev->name);
>
> Please use bt_dev_err.
>
will change it

> >               }
> > +
> > +             if (bt_switch_alt_setting(hdev, new_alts) < 0)
> > +                     BT_ERR("%s Set USB Alt: %d failed!", hdev->name, new_alts);
>
> Same here. bt_dev_err please.
>
> >       } else {
> >               clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
> >               usb_kill_anchored_urbs(&data->isoc_anchor);
>
> Regards
>
> Marcel
>

Regards
Sathish N
