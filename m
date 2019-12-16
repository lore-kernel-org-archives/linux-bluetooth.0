Return-Path: <SRS0=kuCk=2G=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FF3C43603
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Dec 2019 04:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E15CA20674
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Dec 2019 04:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNNzFnB/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfLPEu7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 15 Dec 2019 23:50:59 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:42457 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbfLPEu7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 15 Dec 2019 23:50:59 -0500
Received: by mail-io1-f67.google.com with SMTP id f82so5519098ioa.9
        for <linux-bluetooth@vger.kernel.org>; Sun, 15 Dec 2019 20:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W5alZDYh7WSnX6XVGmA0RNNT60fcmcS2F+1BRe6E+vI=;
        b=KNNzFnB/oRj9yq4r4rclch1qJt86l5S9abuHFFatZt4Krab68uL+fc7wewwb0RISai
         9akF0NDtokmG0Oasn947U2NVgH15YT6t5/ZMPdPv9X4I/M3ioj5g3uL8DpqPnVVlmSV5
         PUY2TojhJ3keHQEVZg23Ffg4Yt1TgXGACBIJq0tpDLnKik12mLJm/mGV+RL4wrvAYGAZ
         IKQRsmnfFPeJhz0PHh9mzldWGAmEoJaKABSheBmm94tHq6ojBbb/mwJUauAQTvuJvrdj
         JiRhkx2w6wbWCzsPa5f8+GoCkXDciu/t3/59iA7ndyZKV75kh+Y+HrPeahY5NrW3SScd
         1rCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W5alZDYh7WSnX6XVGmA0RNNT60fcmcS2F+1BRe6E+vI=;
        b=oKAJ9tJpcZpl9oxHMMjBlmHLk82lKmobryDz3OzUlMiRJgnKfZNrAIflMXMK4dAYi6
         F2c8IVwMDF2v3XvmbuxzYJdTkAg8g+F0LJFffdBfLTUrcIGHG+wxZLU+W9fVJ++Dky6c
         bZxwriUyRk6Gf79XBTq7q8azvWZqZAOsVojaLDfT8tnBMv3jFCAvVWCwnqJWm9bZc51k
         M9y6wYswE7O0OZT8VTHjmYJo+HIMuhx7u0DZtntnmgGlenhqT9vHz0+69Pw+9agXhVZt
         +WP6xtpx5+pet9hDXnY4p5YHxz1hUYBT5Yy9cxjcvutRmAcXY2/Gc5y9U2fp5ny6IW7V
         Oltg==
X-Gm-Message-State: APjAAAX/RrxSvAiqiLXr0xVS9UwmNMSnQZcEwy9MB9cF96k3UQDHI5co
        xxPmnT6veSqbKPGYOmw5Q8MQ52V0igxwO2r42G6s0DYu
X-Google-Smtp-Source: APXvYqw672hT9nDJ4539zBGxHm8zcJTgrsAt5tvK2ZrATc0mNvId10YFqsPUKvqFYmCT8kfyhfpfUnGLraI4+J6ApIU=
X-Received: by 2002:a5d:8c89:: with SMTP id g9mr16324626ion.221.1576471857882;
 Sun, 15 Dec 2019 20:50:57 -0800 (PST)
MIME-Version: 1.0
References: <20191205083229.29890-1-sathish.narasimman@intel.com> <CAOVXEJ+ZVDVrs88vimdv4ct3-2=gYUXGsHr_2fRoPO5B3-frTQ@mail.gmail.com>
In-Reply-To: <CAOVXEJ+ZVDVrs88vimdv4ct3-2=gYUXGsHr_2fRoPO5B3-frTQ@mail.gmail.com>
From:   Sathish Narasimman <nsathish41@gmail.com>
Date:   Mon, 16 Dec 2019 10:20:47 +0530
Message-ID: <CAOVXEJLtD_te7XRePkNCq1zy0_Ymwk8X=m3jkFUtq+huSOCpdw@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] bluetooth:btusb: handle msbc audio over USB Endpoints
To:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Cc:     Sathish Narasimman <sathish.narasimman@intel.com>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Hsin-Yu Chao <hychao@chromium.org>,
        Amit K Bag <amit.k.bag@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

HI,

A gentle reminder

On Tue, Dec 10, 2019 at 10:27 AM Sathish Narasimman
<nsathish41@gmail.com> wrote:
>
> Hi,
>
> Any more comments regarding this patch?
>
> On Thu, Dec 5, 2019 at 2:02 PM Sathish Narsimman <nsathish41@gmail.com> wrote:
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
> > index d9cd0677d41c..5563569f4473 100644
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
> > +                                              int mtu, struct btusb_data *data)
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
> > +       if (data->usb_alt6_packet_flow) {
> > +               interval = 7;
> > +               data->usb_alt6_packet_flow = false;
> > +       } else {
> > +               interval = 6;
> > +               data->usb_alt6_packet_flow = true;
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
> > +                              data);
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
> Regards
> Sathish N

Sathish N
