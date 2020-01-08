Return-Path: <SRS0=1bSD=25=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFDDC282DD
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 18:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D55CF20692
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 18:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n70hVPcF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbgAHSWb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Jan 2020 13:22:31 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41461 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727169AbgAHSWb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Jan 2020 13:22:31 -0500
Received: by mail-ot1-f66.google.com with SMTP id r27so4490621otc.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Jan 2020 10:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dz8pTDoAK19a20LvhUIc71rgxAGGzMqU+MjUEoV+aoM=;
        b=n70hVPcFKRMVjy9tuaxWR7lBB/VPSC73rfZcd1phWbTMWyypfSXRzQEXFQ9w3P1UvV
         /rvi45oCSX+dRkeO6BGagDVfyfpQW4fBnxJzRWjkqD4sxI6Q8oz+tqXA7LiXwlxmt2Vo
         HeP6pA/bkKuPebciQZuOeEex5ChX02teAjLP+jspGZSF4vWXPFhOJ8GfS533HHDTVF4o
         kNJArbXd9d7nu873jSdUXNfZi5xAuh3JAZ/USCZUdajb5Cu3v5SvTtC3+utwo/SkpORt
         eGSe+oxm9x/5hX8+6Dm9hlqG6vLi+knkOFTDyGhUwtQnx+zlf40owxlgm7hHeh6XExyr
         WeXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dz8pTDoAK19a20LvhUIc71rgxAGGzMqU+MjUEoV+aoM=;
        b=Zhal1GUnD2B2bS4Ait8QLVimy7mi87hYcxS6xsfc5qeW48VcAOKLFx3jVETGwHpNSZ
         mNrBncG61mLV+v5vzwlumBg7nVQY/Z5Zvb0VVaUoXS6Z/dACiWS7bVA+gEGjhP7ORfOI
         WtsSo+SNDXK0jUFokg8FBJRqXUIbwx6JrINYuP7J+HaXuNVhpdd1vVdKJZQgw6JgnQE6
         vtwESxVO3vk+DhE+RLfHNGKHtir3rYsULmQNGedkv7Ok62svTfqwYRV/JjWCvRCGUJ9S
         y8lUFbhK9IAuOQV7xmriLb8PR6JSbOYk6xy8hn4lQr5RcKG1KAkhbutpcqoaQV05SNWb
         dUHg==
X-Gm-Message-State: APjAAAXXZeN8d+MDs55MayTQScSVxDrnsmmJK3W64vHyVAKGXR3a75GU
        Sz41Y7zZcu3L8QCJHu2VkpLFyFtHDcTIc81SNdagyvN5
X-Google-Smtp-Source: APXvYqzJkrU/qWa2Q2rk5UtTs5gfK4VqsZFjWgTtZhu0gISGsTC2Ehsj0/zVwUSH1vxSDzV/TkQ9exuSnT5v4pdv2To=
X-Received: by 2002:a05:6830:1515:: with SMTP id k21mr4852010otp.177.1578507750047;
 Wed, 08 Jan 2020 10:22:30 -0800 (PST)
MIME-Version: 1.0
References: <20200107091833.14921-1-szymon.czapracki@codecoup.pl>
 <20200107091833.14921-2-szymon.czapracki@codecoup.pl> <CABBYNZLwzscUwUwFgpUu4TjbY7XVCVOCXXccvFFtZiU7yLEjcQ@mail.gmail.com>
 <1770049.2qRCXdMzth@ix>
In-Reply-To: <1770049.2qRCXdMzth@ix>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 8 Jan 2020 10:22:16 -0800
Message-ID: <CABBYNZLL_zB7O+hsvh1Yx1MZ_=H4A7E0wwuk=8RQd4KsrxUneg@mail.gmail.com>
Subject: Re: [PATCH 2/8] monitor: Decode LE Periodic Advertising Sync Transfer
 Received Event
To:     Szymon Janc <szymon.janc@codecoup.pl>
Cc:     Szymon Czapracki <szymon.czapracki@codecoup.pl>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Szymon,

On Wed, Jan 8, 2020 at 1:53 AM Szymon Janc <szymon.janc@codecoup.pl> wrote:
>
> Hi,
>
> On Wednesday, 8 January 2020 00:43:44 CET Luiz Augusto von Dentz wrote:
> > Hi Szymon,
> >
> > On Tue, Jan 7, 2020 at 1:20 AM Szymon Czapracki
> >
> > <szymon.czapracki@codecoup.pl> wrote:
> > > Change-Id: I5a7c2d36ca5aee61441c2aab6adeb16058ab062f
> > > ---
> > >
> > >  monitor/bt.h     | 14 ++++++++++++++
> > >  monitor/packet.c | 27 +++++++++++++++++++++++++++
> > >  2 files changed, 41 insertions(+)
> > >
> > > diff --git a/monitor/bt.h b/monitor/bt.h
> > > index ecf3782c9..e14c1771f 100644
> > > --- a/monitor/bt.h
> > > +++ b/monitor/bt.h
> > > @@ -3140,6 +3140,20 @@ struct bt_hci_evt_le_chan_select_alg {
> > >
> > >         uint8_t  algorithm;
> > >
> > >  } __attribute__ ((packed));
> > >
> > > +#define BT_HCI_EVT_LE_PER_ADV_SYNC_TRANS_REC           0x18
> > > +struct bt_hci_evt_le_per_adv_sync_trans_rec {
> > > +       uint8_t  status;
> > > +       uint16_t handle;
> > > +       uint16_t service_data;
> > > +       uint16_t sync_handle;
> > > +       uint8_t  sid;
> > > +       uint8_t  addr_type;
> > > +       uint8_t  addr[6];
> > > +       uint8_t  phy;
> > > +       uint16_t interval;
> > > +       uint8_t  clock_accuracy;
> > > +} __attribute__ ((packed));
> > > +
> > >
> > >  #define BT_HCI_ERR_SUCCESS                     0x00
> > >  #define BT_HCI_ERR_UNKNOWN_COMMAND             0x01
> > >  #define BT_HCI_ERR_UNKNOWN_CONN_ID             0x02
> > >
> > > diff --git a/monitor/packet.c b/monitor/packet.c
> > > index 64f75cf8e..76bb9f239 100644
> > > --- a/monitor/packet.c
> > > +++ b/monitor/packet.c
> > > @@ -600,6 +600,12 @@ static void print_addr_type(const char *label,
> > > uint8_t addr_type)>
> > >         case 0x01:
> > >                 str = "Random";
> > >                 break;
> > >
> > > +       case 0x02:
> > > +               str = "Public Identity Address";
> > > +               break;
> > > +       case 0x03:
> > > +               str = "Random Identity Address";
> > > +               break;
> >
> > Usually the term Address is already part of the label so we don't need
> > to repeat here, Random Identity also doesn't sound right, it should
> > probably be Static Random or perhaps have Resolved Public and Resolved
> > Static Random to indicate they are actually resolved address from RPA.
>
> Those names are from spec actually but I agree that those are somewhat odd.
> How about just using print_peer_addr_type() to print this?
> Then we have: public, random, resolved public and resolved Random. This is
> short and also makes output consistent with other events.

Yep, lets use that then.

> >
> > >         default:
> > >                 str = "Reserved";
> > >                 break;
> > >
> > > @@ -9788,6 +9794,24 @@ static void le_chan_select_alg_evt(const void
> > > *data, uint8_t size)>
> > >         print_field("Algorithm: %s (0x%2.2x)", str, evt->algorithm);
> > >
> > >  }
> > >
> > > +static void le_per_adv_sync_trans_rec_evt(const void *data, uint8_t size)
> > > +{
> > > +       const struct bt_hci_evt_le_per_adv_sync_trans_rec *evt = data;
> > > +
> > > +       print_status(evt->status);
> > > +       print_field("Handle: %d", evt->handle);
> > > +       print_field("Connection handle: %d", evt->handle);
> > > +       print_field("Service data: 0x%4.4x", evt->service_data);
> > > +       print_field("Sync handle: %d", evt->sync_handle);
> > > +       print_field("SID: 0x%2.2x", evt->sid);
> > > +       print_addr_type("Address type:", evt->addr_type);
> > > +       print_addr("Addres:", evt->addr, evt->addr_type);
> > > +       print_le_phy("PHY:", evt->phy);
> > > +       print_field("Periodic advertising Interval: %.3f",
> > > +                                                       1.25 *
> > > evt->interval); +       print_clock_accuracy(evt->clock_accuracy);
> > > +}
> > > +
> > >
> > >  struct subevent_data {
> > >
> > >         uint8_t subevent;
> > >         const char *str;
> > >
> > > @@ -9871,6 +9895,9 @@ static const struct subevent_data
> > > le_meta_event_table[] = {>
> > >                                 le_scan_req_received_evt, 8, true},
> > >
> > >         { 0x14, "LE Channel Selection Algorithm",
> > >
> > >                                 le_chan_select_alg_evt, 3, true},
> > >
> > > +       { 0x18, "LE Periodic Advertising Sync Transfer Received",
> > > +                                       le_per_adv_sync_trans_rec_evt, 19,
> > > +                                       true},
> > >
> > >         { }
> > >
> > >  };
> > >
> > > --
> > > 2.24.1
>
>
> --
> pozdrawiam
> Szymon Janc
>
>


-- 
Luiz Augusto von Dentz
