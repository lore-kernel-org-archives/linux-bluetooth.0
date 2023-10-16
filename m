Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A560CDB465
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Oct 2023 17:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbjJPRe0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Oct 2023 13:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjJPReZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Oct 2023 13:34:25 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBB683
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Oct 2023 10:34:23 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c1807f3400so56019061fa.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Oct 2023 10:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697477661; x=1698082461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PBt4ueYYlzL1IZJDM3R56oSh68/0VWM5tuNZpg5eLgc=;
        b=Ju0GdNgCz4CV/38mXqHlC6gEHjZM4HxaxIe/coOqNQc9EgwRAdb7wYvvK6Ox1TY2O2
         p2GzEWFpROyLijgWC+AZe1eCsLhXQ8ACJsFW/3VlZCp0K1q1ssaiO789xwsSUH+KXKin
         qR19TBH2SvZNYUxq6xO5MK20v9obSWgSBq+UNvX5w/uE2uGSkXAD07cF41wc/otqXUkS
         gOcvjnPzXoXKkJNL0KSWDhXIg6k3EYOQ/bFl1V/xPZgBl1J2eWvYOYDHpsNMb25CxCfH
         SzMQw/5E4bucHkHxK0ehX/kwpOUqhvpcekcOt1ywhE1VYFGcgsx3dQO7vYphaD1Pakv+
         Afow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697477661; x=1698082461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PBt4ueYYlzL1IZJDM3R56oSh68/0VWM5tuNZpg5eLgc=;
        b=t+QJntmA6oOX4v16iLfB9o8teDNfyf/LsHlzTmpmDy8jkG+8ETgeNQvTUBGD08zlwJ
         6MWHEzSpLoSs3PSa6ZyYCbcQSRUwInMWtjiQonSiIWCcNey/b30Yia2Cx+9PRh/qW2Ca
         a4qx2uHiy7AssGHbPVvAqU1qDfpzJoQPxtNKo2EykQW94JO8LaCMnHIJOHfowluz77Pm
         6WxzBYkUfCxp+uby+4kGNd4zKSG7u8FdifKl3HbEfD0aDXflYHR/V429+yJGBNXR1Oyw
         +C0O7Rvoj9voln5TWTZC7pG/9un+arJXgXXikELZoP6EnJfAlbknJ0DDsnKdgVUlyJcR
         79Uw==
X-Gm-Message-State: AOJu0YxI1E0t0cU0yqylhgarps9fNbjQX17HwPmqPh8SyJWLqxrFs6ii
        wdH7muQbnuovlapntSye7ydG+oWlyTSC0/P8VSk=
X-Google-Smtp-Source: AGHT+IE0wuZ6KHO/z10Zmh2OQUsXp4rBr+ESeach+7Qv119ZIRht41RC7V0RAGa9v68h3nasTkn8j/zWFTzcEfi1/WE=
X-Received: by 2002:a2e:bea1:0:b0:2c3:eed6:f4f with SMTP id
 a33-20020a2ebea1000000b002c3eed60f4fmr96923ljr.5.1697477661295; Mon, 16 Oct
 2023 10:34:21 -0700 (PDT)
MIME-Version: 1.0
References: <20231014074716.1866266-1-arkadiusz.bokowy@gmail.com>
 <e706186e-e64f-490f-9162-11bfdc589619@molgen.mpg.de> <CAGFh026-11qh0jRQ5=NS4SmH7JQy7BfNwJh9N=bs-K-aVNba-g@mail.gmail.com>
In-Reply-To: <CAGFh026-11qh0jRQ5=NS4SmH7JQy7BfNwJh9N=bs-K-aVNba-g@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 16 Oct 2023 10:34:08 -0700
Message-ID: <CABBYNZ+SYtZ48Rc5mife8bLV12ri4EvqL7QDJLnxuSNBmV46rg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] btdev: Broadcast EXT_ADV packets every 200 ms
To:     Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Arkadiusz,

On Sat, Oct 14, 2023 at 11:58=E2=80=AFAM Arkadiusz Bokowy
<arkadiusz.bokowy@gmail.com> wrote:
>
> Hi Paul,
>
> > > Real BLE devices transmit LE advertisement report packages in given
> > > intervals (typically in range between 20 ms and 10.24 s). With curren=
t
> > > kernel module Bluetooth stack implementation it is possible that the
> > > first LE meta packet just after enabling scanning will be lost. It is
> > > not an issue for real devices, because more advertisement reports wil=
l
> > > be delivered later (in given interval time).
> > >
> > > This patch changes optimistic implementation of sending only one LE
> > > meta packets just after enabling scanning to sending LE meta packets
> > > in 200 ms intervals. Such behavior will better emulate real HCI and
> > > will workaround the issue of dropping the very first LE meta packet
> > > by the kernel.
> >
> > Could you please describe your test setup? I guess you optimized the 20=
0
> > ms for your setup, and that is the reason you did not choose an even
> > lower value like 100 ms?
>
> No, it's not an optimization for my particular setup, but more
> generally for CPU load. I thought that it might be better not to run
> advertisement code too frequently. But I guess that lower values
> should also be OK, e.g. 100 ms or 50 ms. There is one "issue" with
> that, though.... Now, the advertisement packet will be sent one
> interval after the advertisement was enabled. If that's indeed an
> issue, it can be fixed by calling the callback function in the moment
> when the timer is armed.

I'd keep the initial logic of sending the advertisement immediately
since the likes of mgmt-tester, and other testers, do have a number of
tests that connect so adding a delay can probably cause us to spend
more time waiting.

> > > -static void le_set_ext_adv_enable_complete(struct btdev *btdev,
> > > -                                             struct le_ext_adv *ext_=
adv)
> > > +static bool ext_adv_broadcast(void *user_data)
> > >   {
> > > +     struct le_ext_adv *ext_adv =3D user_data;
> > > +     struct btdev *btdev =3D ext_adv->dev;
> >
> > Are these used?
> >
> > Why rename the function?
>
> In the previous implementation, the le_set_ext_adv_enable_complete()
> function was called after advertisement was enabled in order to send
> LE meta packages to devices which have enabled scanning. But this code
> was run only once. I thought that we can reuse this logic to send LE
> meta packages every interval time. That's why I've renamed this
> function, so the name will be more descriptive (it's not enable
> complete callback anymore). And in order to provide compatibility with
> new sygnature, I've added ext_adv and btdev variables.
>
> > >   static void scan_pa(struct btdev *dev, struct btdev *remote)
> > >   {
> > >       if (dev->le_pa_sync_handle !=3D INV_HANDLE || !remote->le_pa_en=
able)
> > > @@ -5440,7 +5411,6 @@ static int cmd_set_ext_scan_enable_complete(str=
uct btdev *dev, const void *data,
> > >               if (!btdev_list[i] || btdev_list[i] =3D=3D dev)
> > >                       continue;
> > >
> > > -             scan_ext_adv(dev, btdev_list[i]);
> > >               scan_pa(dev, btdev_list[i]);
> > >       }
> >
> > Excuse my ignorance, but the remove code is really not necessary anymor=
e?
>
> Maybe I will briefly describe the previous implementation. There are
> two possible cases for sending and receiving advertisements: a) device
> A (B, C, ...) enables advertisement and then device Z enables
> scanning; b) device Z enables scanning and then other devices enable
> advertisement. So, in previous implementation, the LE meta packets
> have been sent to devices with enabled scanning from devices which
> have enabled advertisement either when the scan was enabled (in device
> Z) or when the advertisement was enabled (in device A, B, C ...). The
> removed code corresponds to the case of enabling scanning. It's not
> required any more, because now advertising is governed by the devices
> A, B, C by running advertisement logic every interval time (in the
> original patch, every 200 ms, but that can be changed to lover
> values).
>
> To be honest I'm not sure what about scan_pa(). Maybe that logic
> should also be moved to some timer callback and should be governed by
> the A, C, B, ... devices? I would have to read more about sync in the
> BLE spec.

Btw, make sure you run the testers to confirm you are not breaking any
kernel testers.

--=20
Luiz Augusto von Dentz
