Return-Path: <SRS0=sIa/=ZV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E758AC432C0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 Nov 2019 13:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9BEC217BC
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 Nov 2019 13:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IrOFAg5L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfK2N6o (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 Nov 2019 08:58:44 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:42745 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbfK2N6o (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 Nov 2019 08:58:44 -0500
Received: by mail-il1-f195.google.com with SMTP id f6so23056422ilh.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Nov 2019 05:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GhfiwhUq58/g3H60pNnwje3UP3DLiMjt/1QxjnlQTF8=;
        b=IrOFAg5L/f2LdGb/yfekZwyECdLn5k5lXxzAr8ZK+NGyYlPxwhVAOqxMSCnBZuDGrS
         IyYV69wQQMBYCNQNYlAoBHtSuw7r2cxXdT6lu0bGJFnva3fkZ7a5wt4ik1Yc4zzs/pu+
         w7yO/idL5A26SjNvXC9iq+WXHBHHWS4vbkjyxDqqfrTroXs0kqIq+iWUWF0MdN8edc1l
         WnqEoaiLrx9RQGF0TZ4B3A0CJ0KPY5Ve+48IN4ERNJoLQ7RopIvSyIJqObKjCwpMygVZ
         3Rfdkf7f0AfxvwUTo12vNKZ0OYfPO+/MTgjfizj7GN3FoGB+moFLjE8ahe/9BiwXXMbq
         GY2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GhfiwhUq58/g3H60pNnwje3UP3DLiMjt/1QxjnlQTF8=;
        b=Uab2vRjKZIa9IpgU8o9jtS/Q/ZKhvPEmTru0XZ2o1kL3CGoslB7qxO/UYvVCvarXDs
         lEE0Fz9FvvI7rVfIisx6a9a3hsKx/W88EvLPrfHA6cz1NvPrJLcS2zeXQxaJBtl/53VJ
         5wI+7E76/61g0GbuoBo8+wFEejnjAkm0M0LH8WWcuekW9nBliJLnThIPEU3LS8pb9gD/
         nlhIoXUwq6xicSW47r9+9ZYeVYBJnd8l2F+xIxCJjQRczjLmtHskJ2JkVvxSSjTjaS5r
         XaMWlYh3z/wCxeOpUtVjFbwVVdAYOFExnbTz+5hNxBBqBCiGi2AOHDt0iGodmgZRONkv
         GbvQ==
X-Gm-Message-State: APjAAAXj7/7ncP+YYM9dIBQwQi2787n2E6gAzOZ4IgOvDeyP8dnC1g7g
        FvTLGo7HbhUxOomdiQFEFpqYiJVCw5dqZkWm2nI=
X-Google-Smtp-Source: APXvYqxwGYO0lmNZezteWoTnRZ3dHT1hutoBZsxVgbX03yG663tBD0b6QXzAjopkltKhVVuNoL7GgPODbQaunjT8Jv0=
X-Received: by 2002:a92:884e:: with SMTP id h75mr1749883ild.199.1575035922535;
 Fri, 29 Nov 2019 05:58:42 -0800 (PST)
MIME-Version: 1.0
References: <20191129121042.3311-1-sathish.narasimman@intel.com>
 <20191129121042.3311-2-sathish.narasimman@intel.com> <CABBYNZLrDOrvJ03FehWv1FRNaNWL6SEecZkhSu_VrHzbHo5PGg@mail.gmail.com>
In-Reply-To: <CABBYNZLrDOrvJ03FehWv1FRNaNWL6SEecZkhSu_VrHzbHo5PGg@mail.gmail.com>
From:   Sathish Narasimman <nsathish41@gmail.com>
Date:   Fri, 29 Nov 2019 19:28:31 +0530
Message-ID: <CAOVXEJJKz--+j0=bYPfjHLr+KH01rdDqG=DsJuCPZU-DjEMm6A@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] bluetooth:btusb: handle msbc audio over USB Endpoints
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Sathish Narasimman <sathish.narasimman@intel.com>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Hsin-Yu Chao <hychao@chromium.org>,
        Amit K Bag <amit.k.bag@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Fri, Nov 29, 2019 at 7:08 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Sathish,
>
> On Fri, Nov 29, 2019 at 2:16 PM Sathish Narsimman <nsathish41@gmail.com> wrote:
> >
> > From: Sathish Narasimman <sathish.narasimman@intel.com>
> >
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
> >  drivers/bluetooth/btusb.c | 157 +++++++++++++++++++++++++++++---------
> >  1 file changed, 121 insertions(+), 36 deletions(-)
> >
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index 9b587e662b48..541048d647d4 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -483,6 +483,8 @@ struct btusb_data {
> >         __u8 cmdreq;
> >
> >         unsigned int sco_num;
> > +       unsigned int air_mode;
> > +       bool usb_alt6_packet_flow;
> >         int isoc_altsetting;
> >         int suspend_count;
> >
> > @@ -974,6 +976,42 @@ static void btusb_isoc_complete(struct urb *urb)
> >         }
> >  }
> >
> > +static inline void __fill_isoc_descriptor_msbc(struct urb *urb, int len,
> > +                                              int mtu, bool packet_flow)
>
> Well I guess is really a role for alt6 since afaik mSBC can be sent in
> other settings as as well, besides we should never assume a specific
> codec is in use since the userspace can use anything with transparent.
I agree the transparent can use any codec.
The patch created considering HFP spec 1.7 which says msbc codec for
WBS(Though we can use any codec)
Also in core spec 5, vol4, part B - Table 2.1(usb primary firmware
interface and endpoint settings)
POinted to this  - > one mSBC voice channel ALT setting 6.
yes, we can achieve the same rate(WBS) using ALT setting 1. But the
usage of ALT 6 is decided from the spec.

>
> > +{
> > +       int i, offset = 0;
> > +       unsigned int interval;
> > +
> > +       /* For msbc ALT 6 setting the host will send the packet at continuous
> > +        * flow. As per core spec 5, vol 4, part B, table 2.1. For ALT setting
> > +        * 6 the HCI PACKET INTERVAL should be 7.5ms for every usb packets.
> > +        * To maintain the rate we send 63bytes of usb packets alternatively for
> > +        * 7ms and 8ms to maintain the rate as 7.5ms.
> > +        */
> > +       if (packet_flow) {
> > +               interval = 7;
> > +               packet_flow = false;
> > +       } else {
> > +               interval = 6;
> > +               packet_flow = true;
> > +       }
> > +
> > +       BT_DBG("interval:%d len %d mtu %d", interval, len, mtu);
> > +
> > +       for (i = 0; i < interval; i++) {
> > +               urb->iso_frame_desc[i].offset = offset;
> > +               urb->iso_frame_desc[i].length = offset;
> > +       }
> > +
> > +       if (len && i < BTUSB_MAX_ISOC_FRAMES) {
> > +               urb->iso_frame_desc[i].offset = offset;
> > +               urb->iso_frame_desc[i].length = len;
> > +               i++;
> > +       }
> > +
> > +       urb->number_of_packets = i;
> > +}
> > +
> >  static inline void __fill_isoc_descriptor(struct urb *urb, int len, int mtu)
> >  {
> >         int i, offset = 0;
> > @@ -1377,9 +1415,13 @@ static struct urb *alloc_isoc_urb(struct hci_dev *hdev, struct sk_buff *skb)
> >
> >         urb->transfer_flags  = URB_ISO_ASAP;
> >
> > -       __fill_isoc_descriptor(urb, skb->len,
> > +       if (data->isoc_altsetting == 6)
> > +               __fill_isoc_descriptor_msbc(urb, skb->len,
> > +                              le16_to_cpu(data->isoc_tx_ep->wMaxPacketSize),
> > +                              data->usb_alt6_packet_flow);
> > +       else
> > +               __fill_isoc_descriptor(urb, skb->len,
> >                                le16_to_cpu(data->isoc_tx_ep->wMaxPacketSize));
> > -
> >         skb->dev = (void *)hdev;
> >
> >         return urb;
> > @@ -1475,6 +1517,7 @@ static void btusb_notify(struct hci_dev *hdev, unsigned int evt)
> >
> >         if (hci_conn_num(hdev, SCO_LINK) != data->sco_num) {
> >                 data->sco_num = hci_conn_num(hdev, SCO_LINK);
> > +               data->air_mode = evt;
> >                 schedule_work(&data->work);
> >         }
> >  }
> > @@ -1522,11 +1565,70 @@ static inline int __set_isoc_interface(struct hci_dev *hdev, int altsetting)
> >         return 0;
> >  }
> >
> > +static int bt_switch_alt_setting(struct hci_dev *hdev, int new_alts)
> > +{
> > +       struct btusb_data *data = hci_get_drvdata(hdev);
> > +       int err;
> > +
> > +       if (data->isoc_altsetting != new_alts) {
> > +               unsigned long flags;
> > +
> > +               clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
> > +               usb_kill_anchored_urbs(&data->isoc_anchor);
> > +
> > +               /* When isochronous alternate setting needs to be
> > +                * changed, because SCO connection has been added
> > +                * or removed, a packet fragment may be left in the
> > +                * reassembling state. This could lead to wrongly
> > +                * assembled fragments.
> > +                *
> > +                * Clear outstanding fragment when selecting a new
> > +                * alternate setting.
> > +                */
> > +               spin_lock_irqsave(&data->rxlock, flags);
> > +               kfree_skb(data->sco_skb);
> > +               data->sco_skb = NULL;
> > +               spin_unlock_irqrestore(&data->rxlock, flags);
> > +
> > +               err = __set_isoc_interface(hdev, new_alts);
> > +               if (err < 0)
> > +                       return err;
> > +       }
> > +       if (!test_and_set_bit(BTUSB_ISOC_RUNNING, &data->flags)) {
> > +               if (btusb_submit_isoc_urb(hdev, GFP_KERNEL) < 0)
> > +                       clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
> > +               else
> > +                       btusb_submit_isoc_urb(hdev, GFP_KERNEL);
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static struct usb_host_interface *btusb_find_altsetting(struct btusb_data *data, int alt)
> > +{
> > +       struct usb_interface *intf = data->isoc;
> > +       int i;
> > +
> > +       BT_DBG("Looking for Alt no :%d", alt);
> > +
> > +       if (intf == NULL) {
> > +               BT_ERR("INterface NULL");
> > +               return NULL;
> > +       }
> > +
> > +       for (i = 0; i < intf->num_altsetting; i++) {
> > +               if (intf->altsetting[i].desc.bAlternateSetting == alt)
> > +                       return &intf->altsetting[i];
> > +       }
> > +
> > +       return NULL;
> > +}
> > +
> >  static void btusb_work(struct work_struct *work)
> >  {
> >         struct btusb_data *data = container_of(work, struct btusb_data, work);
> >         struct hci_dev *hdev = data->hdev;
> > -       int new_alts;
> > +       int new_alts = 0;
> >         int err;
> >
> >         if (data->sco_num > 0) {
> > @@ -1541,44 +1643,27 @@ static void btusb_work(struct work_struct *work)
> >                         set_bit(BTUSB_DID_ISO_RESUME, &data->flags);
> >                 }
> >
> > -               if (hdev->voice_setting & 0x0020) {
> > -                       static const int alts[3] = { 2, 4, 5 };
> > -
> > -                       new_alts = alts[data->sco_num - 1];
> > -               } else {
> > -                       new_alts = data->sco_num;
> > -               }
> > -
> > -               if (data->isoc_altsetting != new_alts) {
> > -                       unsigned long flags;
> > +               if (data->air_mode == HCI_NOTIFY_ENABLE_SCO_CVSD) {
> > +                       if (hdev->voice_setting & 0x0020) {
> > +                               static const int alts[3] = { 2, 4, 5 };
> >
> > -                       clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
> > -                       usb_kill_anchored_urbs(&data->isoc_anchor);
> > -
> > -                       /* When isochronous alternate setting needs to be
> > -                        * changed, because SCO connection has been added
> > -                        * or removed, a packet fragment may be left in the
> > -                        * reassembling state. This could lead to wrongly
> > -                        * assembled fragments.
> > -                        *
> > -                        * Clear outstanding fragment when selecting a new
> > -                        * alternate setting.
> > -                        */
> > -                       spin_lock_irqsave(&data->rxlock, flags);
> > -                       kfree_skb(data->sco_skb);
> > -                       data->sco_skb = NULL;
> > -                       spin_unlock_irqrestore(&data->rxlock, flags);
> > +                               new_alts = alts[data->sco_num - 1];
> > +                       } else {
> > +                               new_alts = data->sco_num;
> > +                       }
> > +               } else if (data->air_mode == HCI_NOTIFY_ENABLE_SCO_TRANSP) {
> >
> > -                       if (__set_isoc_interface(hdev, new_alts) < 0)
> > -                               return;
> > -               }
> > +                       data->usb_alt6_packet_flow = true;
> >
> > -               if (!test_and_set_bit(BTUSB_ISOC_RUNNING, &data->flags)) {
> > -                       if (btusb_submit_isoc_urb(hdev, GFP_KERNEL) < 0)
> > -                               clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
> > +                       /* Check if Alt 6 is supported for Transparent audio*/
> > +                       if (btusb_find_altsetting(data, 6))
> > +                               new_alts = 6;
> >                         else
> > -                               btusb_submit_isoc_urb(hdev, GFP_KERNEL);
> > +                               BT_ERR("%s Device does not support ALT setting 6", hdev->name);
> >                 }
> > +
> > +               if (bt_switch_alt_setting(hdev, new_alts) < 0)
> > +                       BT_ERR("%s Set USB Alt: %d failed!", hdev->name, new_alts);
> >         } else {
> >                 clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
> >                 usb_kill_anchored_urbs(&data->isoc_anchor);
> > --
> > 2.17.1
> >
>
>
> --
> Luiz Augusto von Dentz
