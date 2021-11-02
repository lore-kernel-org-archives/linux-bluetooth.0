Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11188C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Nov 2021 22:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E619161058
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Nov 2021 22:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbhKBWm0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 Nov 2021 18:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbhKBWmZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 Nov 2021 18:42:25 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B07C061714
        for <linux-bluetooth@vger.kernel.org>; Tue,  2 Nov 2021 15:39:50 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id j28so651859ila.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Nov 2021 15:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MaWzPuNZbrOVquFPFWZ102QfofIBlGS0eyoWMzwYbuE=;
        b=L2/zK34hr07IgRH21vpJpOn+PkQOeHI03xoDdBzF3S0iaA+ej/RiDB90gzobrAoMcU
         CgJs2/BmPGZz/lNIBUj5wGF1lbWKz+1T0Af7Ts6mPWUnzM46JuSb+Zsgxv59tO37azq3
         b8D6yuC60cRrfQVSOaTLh8RaZ+LZ4eiMYnRIMpNJQeNDnhS3+SeaRIrqiYSMLoWf9vGw
         MJz0n44/S4cY4hdwjzzykPMRhxe/6M5UT0xuWInZCkMXKVOfw6RJD3IzuQ8TEoU3Vv9t
         mKaCZym6OScfg0ndPeFxYjNiCrs1yaAbYcPaQTvI4k8v11bi6TRAnSYysg+FXLgZ+vCd
         xhLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MaWzPuNZbrOVquFPFWZ102QfofIBlGS0eyoWMzwYbuE=;
        b=MDzAw8bFRqcPb2Qw5MTIzICtQwhcvbYOayIlJ58u9qseaAwqks42VsgQ+ZkU7MVERw
         BAkbvBN0KFVLXvrxjTu/qtyQfalqUZcxH1x9E0oVhRyEUKGbJItE6vd6swfp6WHO3bqr
         h0O93ZWaIaypgh4XyfExPdiVnrIA1Yw5VuQJrNVHhUgUSMNIUCObUMygyLaHH8uVWHEN
         Ts6vVseBIPLm/3yx5rF3ZKIqWFPNiFNOM2FkKJHXRzaA7vnXu41e8995A68NGgFdraT7
         57jXlqy3OQvdkR4ae9u5oVYQFVtkR71xg1fvOmgki2cWLeYVHXjNonPSfxclplSTqLP8
         KmnQ==
X-Gm-Message-State: AOAM532+rLritISQs5XfkmB7/JMAC5DdzoSJn75ghLR0waC+7LM6Re90
        a8YsF/J/V9w0hXF5d/RRcf7A8FD+slUbpQw3jueWIsOD
X-Google-Smtp-Source: ABdhPJx+r/rZ3NdsSfaoHn0bL+PdfmO6K5JA9DHO210792DG282LQ1F19MioOhb27tSXs8adO1OfQThCcFU4hpkUQk4=
X-Received: by 2002:a05:6e02:e41:: with SMTP id l1mr22610343ilk.139.1635892789661;
 Tue, 02 Nov 2021 15:39:49 -0700 (PDT)
MIME-Version: 1.0
References: <20211101140544.Bluez.1.I515833d2764b8ec2ac2bb1f87313de80ebb497cd@changeid>
 <CABBYNZJg=Acx_BLyq=RzbkvfWOj-Rik3t7B1Z-XZqemo2LMykQ@mail.gmail.com> <CAJQfnxHP0dRzahhcK2S6sN-e1ssk1S2BZB3Nzs+SCTXufBVfGA@mail.gmail.com>
In-Reply-To: <CAJQfnxHP0dRzahhcK2S6sN-e1ssk1S2BZB3Nzs+SCTXufBVfGA@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 2 Nov 2021 15:39:38 -0700
Message-ID: <CABBYNZK5xdvTsoBCHdEDE86s6UtxKOGLmO7oO5Pn1swY23YWOA@mail.gmail.com>
Subject: Re: [Bluez PATCH 1/3] adapter: Use PeripheralLongTermKey to store LTK
To:     Archie Pusaka <apusaka@google.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

On Tue, Nov 2, 2021 at 2:10 AM Archie Pusaka <apusaka@google.com> wrote:
>
> Hi Luiz,
>
>
> On Tue, 2 Nov 2021 at 14:17, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Archie,
> >
> > On Sun, Oct 31, 2021 at 11:06 PM Archie Pusaka <apusaka@google.com> wrote:
> > >
> > > From: Archie Pusaka <apusaka@chromium.org>
> > >
> > > Introducing PeripheralLongTermKey group for storing LTK info to
> > > replace the less inclusive term. Currently we still need to write/read
> > > from both to ensure smooth transition, but later we should deprecate
> > > the old term.
> > >
> > > Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
> > > ---
> > >
> > >  src/adapter.c | 41 ++++++++++++++++++++++++++++++++---------
> > >  1 file changed, 32 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/src/adapter.c b/src/adapter.c
> > > index d0d38621b8..6b12c9e793 100644
> > > --- a/src/adapter.c
> > > +++ b/src/adapter.c
> > > @@ -3868,7 +3868,11 @@ static struct smp_ltk_info *get_peripheral_ltk_info(GKeyFile *key_file,
> > >
> > >         DBG("%s", peer);
> > >
> > > -       ltk = get_ltk(key_file, peer, bdaddr_type, "SlaveLongTermKey");
> > > +       /* Read from both entries. Later we should deprecate Slave. */
> > > +       ltk = get_ltk(key_file, peer, bdaddr_type, "PeripheralLongTermKey");
> > > +       if (!ltk)
> > > +               ltk = get_ltk(key_file, peer, bdaddr_type, "SlaveLongTermKey");
> >
> > If you find the old name being used you better replace it with the new
> > one and erase the old.
> >
> > >         if (ltk)
> > >                 ltk->central = false;
> > >
> > > @@ -8415,13 +8419,12 @@ static void new_link_key_callback(uint16_t index, uint16_t length,
> > >         bonding_complete(adapter, &addr->bdaddr, addr->type, 0);
> > >  }
> > >
> > > -static void store_longtermkey(struct btd_adapter *adapter, const bdaddr_t *peer,
> > > +static void store_ltk_group(struct btd_adapter *adapter, const bdaddr_t *peer,
> > >                                 uint8_t bdaddr_type, const unsigned char *key,
> > > -                               uint8_t central, uint8_t authenticated,
> > > +                               const char *group, uint8_t authenticated,
> > >                                 uint8_t enc_size, uint16_t ediv,
> > >                                 uint64_t rand)
> > >  {
> > > -       const char *group = central ? "LongTermKey" : "SlaveLongTermKey";
> > >         char device_addr[18];
> > >         char filename[PATH_MAX];
> > >         GKeyFile *key_file;
> > > @@ -8431,11 +8434,6 @@ static void store_longtermkey(struct btd_adapter *adapter, const bdaddr_t *peer,
> > >         char *str;
> > >         int i;
> > >
> > > -       if (central != 0x00 && central != 0x01) {
> > > -               error("Unsupported LTK type %u", central);
> > > -               return;
> > > -       }
> > > -
> > >         ba2str(peer, device_addr);
> > >
> > >         snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/info",
> > > @@ -8475,6 +8473,31 @@ static void store_longtermkey(struct btd_adapter *adapter, const bdaddr_t *peer,
> > >         g_key_file_free(key_file);
> > >  }
> > >
> > > +static void store_longtermkey(struct btd_adapter *adapter, const bdaddr_t *peer,
> > > +                               uint8_t bdaddr_type, const unsigned char *key,
> > > +                               uint8_t central, uint8_t authenticated,
> > > +                               uint8_t enc_size, uint16_t ediv,
> > > +                               uint64_t rand)
> > > +{
> > > +       if (central != 0x00 && central != 0x01) {
> > > +               error("Unsupported LTK type %u", central);
> > > +               return;
> > > +       }
> > > +
> > > +       if (central) {
> > > +               store_ltk_group(adapter, peer, bdaddr_type, key, "LongTermKey",
> > > +                               authenticated, enc_size, ediv, rand);
> > > +       } else {
> > > +               /* Store duplicates for now. Later we should deprecate Slave. */
> > > +               store_ltk_group(adapter, peer, bdaddr_type, key,
> > > +                               "PeripheralLongTermKey", authenticated,
> > > +                               enc_size, ediv, rand);
> > > +               store_ltk_group(adapter, peer, bdaddr_type, key,
> > > +                               "SlaveLongTermKey", authenticated,
> > > +                               enc_size, ediv, rand);
> >
> > In not following why you want to keep duplicate entries?
> >
> Based on the discussion in the other thread with Marcel, we don't want
> to immediately remove the old entry since this would cause friction
> when people are switching around between the newer and older version
> of BlueZ.

I guess the problem would be downgrading wouldn't work since we would
have removed the old value once upgrading, in that case I would be
fine keeping it but Id leave a comment since we should probably remove
that as soon as we have a few releases.

> Instead, for some time we would keep both entries alive, and only
> after that we remove the old entry.
>
> > > +       }
> > > +}
> > > +
> > >  static void new_long_term_key_callback(uint16_t index, uint16_t length,
> > >                                         const void *param, void *user_data)
> > >  {
> > > --
> > > 2.33.1.1089.g2158813163f-goog
> > >
> >
> >
> > --
> > Luiz Augusto von Dentz
>
> Thanks,
> Archie



-- 
Luiz Augusto von Dentz
