Return-Path: <SRS0=s7/i=P2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E82C43387
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jan 2019 08:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA28720855
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jan 2019 08:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="olhrbWMf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbfARIGE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Jan 2019 03:06:04 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34435 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbfARIGE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Jan 2019 03:06:04 -0500
Received: by mail-ot1-f68.google.com with SMTP id t5so8601712otk.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Jan 2019 00:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tlEpNku48dSVYhPKkB6rvKrTudELtTUNbGEV4kVhoxg=;
        b=olhrbWMfL07HTohj8M3xFbg0eLC38I0Ecid60Ly7I5/gzjkw9dhNXWkeLzUIoyt1/Y
         HZgbkyGSS83chHTAsZDgz80YQy8XeyupSTBmPDKVfhjaoPphEUQzEkJLuJ/qHMNarp/k
         v51VHWDGMlc7eFgzsOIkJs7XIZBSWBHbhb4IFxTvMDsYpIZXaQqfBrnCrUvEk+uHjfR9
         SfFEgIECrG8U3RNWSHvKB02anI3t1+KERlux1efdC77osWup3kqZGFPf9iVNulZiofqW
         HuvueVFZYd6PoM9VdAhIy68BL8UHkmXVUdYh2vO9G4qlXzwXD54KrEPofKC2RbKDnvEJ
         dtLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tlEpNku48dSVYhPKkB6rvKrTudELtTUNbGEV4kVhoxg=;
        b=kz3wbn+V+Z5WJDc8/ftUcqD9HFd8HsMdn0durmliTN9kz75ixEUwwo7MFKFa6xF0RM
         u+XXo+wsjxZU2W4PN6kXYX+chSGWu+5oouuAco5Ir65fcL/MC9CTjaZcz+XPWbIZ4+Pv
         xfeF5n+1vrpZSIJ4uCDJuuBO8pQ4jT1AxsRHJbVG4713UpDGZCqmUUNAGUvsJVzxUMCk
         4D8DCqSc6juSUzj0J952rSSO06ND45P749l5V75za6WBgmP4RyoB6EvgFtdfrLDKy8G7
         i541j+tPbvM0WNobFf0pvYt7jgTnhnDbwb7p7ER1oY0PDvjQNJZaGDUQw5kCr5jnDaEG
         Y3gg==
X-Gm-Message-State: AJcUukdZhrwFfTjGw+/kCPUCg+a7HDwmC9jeJXMroi6VC2VdDOUYSL7a
        kuRFBalvu402/cvDFO70F+doCGzFE6xneYd7/u8=
X-Google-Smtp-Source: ALg8bN5r1B/2cULa4uzpcGlW0nIXXGfJzYv4RQ9QPt5GEysfI32gi2TgUGRiZvMynwOorzDYywXMnFcTuyVqzCHzOis=
X-Received: by 2002:a9d:18f:: with SMTP id e15mr11590015ote.84.1547798763470;
 Fri, 18 Jan 2019 00:06:03 -0800 (PST)
MIME-Version: 1.0
References: <20190113172320.17586-1-pali.rohar@gmail.com> <20190117230452.hsxwmoz4oks3snrs@pali>
In-Reply-To: <20190117230452.hsxwmoz4oks3snrs@pali>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 18 Jan 2019 05:05:52 -0300
Message-ID: <CABBYNZKdCfbNE1P_gW7CB826KJaSPxo0OERARP==70J35UvU0w@mail.gmail.com>
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

On Thu, Jan 17, 2019 at 8:07 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> wrot=
e:
>
> On Sunday 13 January 2019 18:23:20 Pali Roh=C3=A1r wrote:
> > This codec is bi-directional, therefore both sink and source directions=
 may
> > be present in configuration at same time.
> >
> > Some Creative headsets send more frequency bits in configuration and wh=
en
> > both 41kHz and 48kHz are present then headset expects 48kHz. So adjust
> > FastStream frequency table as find_value_bit() takes first matched bit.
> > ---
> >  monitor/a2dp.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
>
> Hello, can somebody review this bluez patch?

Will do it today.

> > diff --git a/monitor/a2dp.c b/monitor/a2dp.c
> > index ffdcbb962..42fe395a1 100644
> > --- a/monitor/a2dp.c
> > +++ b/monitor/a2dp.c
> > @@ -201,8 +201,10 @@ static const struct bit_desc faststream_direction_=
table[] =3D {
> >  };
> >
> >  static const struct bit_desc faststream_sink_frequency_table[] =3D {
> > -     {  1, "44100" },
> > +     /* in config buffer, there may be more frequency bits
> > +      * and 48kHz takes precedence over 41kHz */
> >       {  0, "48000" },
> > +     {  1, "44100" },
> >       { }
> >  };
> >
> > @@ -746,9 +748,9 @@ static bool codec_vendor_faststream_cfg(uint8_t los=
c, struct l2cap_frame *frame)
> >
> >       l2cap_frame_get_u8(frame, &cap);
> >
> > -     print_field("%*cDirection: %s (0x%02x)", BASE_INDENT + 2, ' ',
> > -                     find_value_bit(cap, faststream_direction_table),
> > -                     cap);
> > +     /* FastStream codec is bi-directional */
> > +     print_field("%*cDirection: 0x%02x", BASE_INDENT + 2, ' ', cap);
> > +     print_value_bits(BASE_INDENT + 2, cap, faststream_direction_table=
);
> >
> >       l2cap_frame_get_u8(frame, &cap);
> >
>
> --
> Pali Roh=C3=A1r
> pali.rohar@gmail.com



--=20
Luiz Augusto von Dentz
