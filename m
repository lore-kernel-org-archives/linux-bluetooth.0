Return-Path: <SRS0=s7/i=P2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8915CC43387
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jan 2019 09:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FD202086D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jan 2019 09:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XmYU30PG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbfARJHa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Jan 2019 04:07:30 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34198 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfARJH3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Jan 2019 04:07:29 -0500
Received: by mail-ot1-f68.google.com with SMTP id t5so8726023otk.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Jan 2019 01:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dv/O0TtpQwJM2xwiusy466GUMoTFaDwV+EpG5rNZ8rU=;
        b=XmYU30PGfLlLenoNNa7Vq72NBe2FvhbbYx/uO2dupSeoS3SLNeD1YKBebKVtgJp8vv
         wnrafJ4KljuvJpuG441rOcqqpRFHg4rWY00agZaypwmDw+mcvGPuCO6plJVqHwsuBI94
         vePKbI2d7FsuVScHxm6pb6Ne6Qt9Qrf2dTDVkAKcLKn0bVa/TFmJaRq9mJklkPdtP8Jo
         gG80e0sjiXym2ecSHWlO5mz3nPXsyi3nBrymE28vlQ98kUI+GRsLi1D3qwBTqS+VKTYi
         RfVcKDqETX47hVEhn2TwyKBTW7DY91ciMr8iwwHa343OGwyM+FOdvhnQj/DwQ/fq2pcu
         bS1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dv/O0TtpQwJM2xwiusy466GUMoTFaDwV+EpG5rNZ8rU=;
        b=KjP1FVmM9DmJ+x/1oaj69D6olhPYRd5oKpMb/+eqeoti7gEu2JvdT73i7oafC0+6Ib
         zqIptAce91L/ls5GmFv71wNu+icHIzTQw2vBETmK9SbxC/HAN/jXtYgW8x75zuJphrdP
         w/GmeUqn3caIJKctyVA1QmVfHQKlGKWC9fJf0hvJD/UgN+6AE1ngYH+8rXrqjHeZztIN
         e81HLiioAI1kUoiiSCAKHQzvlhszutGOecHISUPf3rgfUv154+KkKeTqXzKqQ1W2pYLE
         IvwWDx1OhIulksrco+z+buUToNzv5SBulH+82x/a+isAi+CY13TgYTC2lUSIYHHcJNSG
         /Kfw==
X-Gm-Message-State: AJcUukfI4nK/TX8BX0ZegTfvUKlYTpr6LrPoy/MsesRnOORO9vV4xTi2
        bR4nA05e91DGxloNJtMqZQx91GNbzU7s6m3C7pCGpw==
X-Google-Smtp-Source: ALg8bN6hi9qOzkM6BgpKpN6gTIzh+YQQbC/ohDtMpstRKC7tRzYjAAaEtRIOadnx8Jbd3LasLxcn5gqed19dZ/BxL/A=
X-Received: by 2002:a9d:4c01:: with SMTP id l1mr11297396otf.242.1547802448834;
 Fri, 18 Jan 2019 01:07:28 -0800 (PST)
MIME-Version: 1.0
References: <20190113172320.17586-1-pali.rohar@gmail.com> <20190117230452.hsxwmoz4oks3snrs@pali>
 <CABBYNZKdCfbNE1P_gW7CB826KJaSPxo0OERARP==70J35UvU0w@mail.gmail.com>
In-Reply-To: <CABBYNZKdCfbNE1P_gW7CB826KJaSPxo0OERARP==70J35UvU0w@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 18 Jan 2019 06:07:16 -0300
Message-ID: <CABBYNZ+8gbXGWmqXhH38as3+6u8xXqvteJftVjb3UHZfy2=2Uw@mail.gmail.com>
Subject: Re: [PATCH] btmon: Fix parsing A2DP FastStream codec configuration
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

On Fri, Jan 18, 2019 at 5:05 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Pali,
>
> On Thu, Jan 17, 2019 at 8:07 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> wr=
ote:
> >
> > On Sunday 13 January 2019 18:23:20 Pali Roh=C3=A1r wrote:
> > > This codec is bi-directional, therefore both sink and source directio=
ns may
> > > be present in configuration at same time.
> > >
> > > Some Creative headsets send more frequency bits in configuration and =
when
> > > both 41kHz and 48kHz are present then headset expects 48kHz. So adjus=
t
> > > FastStream frequency table as find_value_bit() takes first matched bi=
t.
> > > ---
> > >  monitor/a2dp.c | 10 ++++++----
> > >  1 file changed, 6 insertions(+), 4 deletions(-)
> >
> > Hello, can somebody review this bluez patch?
>
> Will do it today.
>
> > > diff --git a/monitor/a2dp.c b/monitor/a2dp.c
> > > index ffdcbb962..42fe395a1 100644
> > > --- a/monitor/a2dp.c
> > > +++ b/monitor/a2dp.c
> > > @@ -201,8 +201,10 @@ static const struct bit_desc faststream_directio=
n_table[] =3D {
> > >  };
> > >
> > >  static const struct bit_desc faststream_sink_frequency_table[] =3D {
> > > -     {  1, "44100" },
> > > +     /* in config buffer, there may be more frequency bits
> > > +      * and 48kHz takes precedence over 41kHz */
> > >       {  0, "48000" },
> > > +     {  1, "44100" },
> > >       { }
> > >  };
> > >
> > > @@ -746,9 +748,9 @@ static bool codec_vendor_faststream_cfg(uint8_t l=
osc, struct l2cap_frame *frame)
> > >
> > >       l2cap_frame_get_u8(frame, &cap);
> > >
> > > -     print_field("%*cDirection: %s (0x%02x)", BASE_INDENT + 2, ' ',
> > > -                     find_value_bit(cap, faststream_direction_table)=
,
> > > -                     cap);
> > > +     /* FastStream codec is bi-directional */
> > > +     print_field("%*cDirection: 0x%02x", BASE_INDENT + 2, ' ', cap);
> > > +     print_value_bits(BASE_INDENT + 2, cap, faststream_direction_tab=
le);
> > >
> > >       l2cap_frame_get_u8(frame, &cap);
> > >
> >
> > --

Applied, thanks.

--=20
Luiz Augusto von Dentz
