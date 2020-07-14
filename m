Return-Path: <SRS0=5ENf=AZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6888C433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Jul 2020 17:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB11922464
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Jul 2020 17:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EwyPLZj1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgGNRKK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Jul 2020 13:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgGNRKJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Jul 2020 13:10:09 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA611C061755
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jul 2020 10:10:09 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id 18so13563679otv.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jul 2020 10:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wZ225EF+OkAAsyxWL9/lOWbhPOMvqnQib3F5lTrCkho=;
        b=EwyPLZj1k8QMnRROeJbtHVgVX33zeKb6gZ7U1WCFLFR02ZYsZLX5HukLKpy0t9pAga
         VrHVNQUAJ7QPQvN1Xwp2yMQoecHM5P5oRg78LzWcpI5/Y93kGOvakdoM5KBlOHPIlv5M
         DtLsE2YVOyOZWeBE/nQPw4CIjtmiALYX065zvR2lytzTe0Z7BEY5zun6qFifl/rLyVSj
         S91LJI/b2XE2RpBreBAtB9qfmxJneal5g6wU2K0ON7sI+9HYhC8nW4pfyVjlvye6WGpD
         ztxWj/bH3I3DBC/gHXJQU6d/J3/8OHg359Qo1w/XFZXoJLhJiqoBRoeMUGwreoBaApMY
         kv5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wZ225EF+OkAAsyxWL9/lOWbhPOMvqnQib3F5lTrCkho=;
        b=np9winhAMjc1xPh9FFV9tsSklVwnvZ+lxoMHPadF4Y9i9ttnAstSUXxz1caONxFbNA
         pPrQh7ODIUn+C69/TMRLakq4fY267OziDnesI6rWieqnnXcyzeziBF2VSH2eCN87VKSr
         TUX+7IJ7kVlvZAE3ScMs6qIYDKvFiGr4sq1Oidm9psJhCnDYRnGP1EaTqbgI91ECquIe
         9W7hpdzcW5NvAa4gPRbhFo7X1meuJ6uHoaLcx76m4eyB7z/tdPiwx1BIyR+L1TWgD3Rj
         S2T/Wa01Rycpd8m5Ekk3Gnc53bdMc3CmMp4tux8phcmPIaGYYJfYkAQ5+zlpAAlLGWou
         nClQ==
X-Gm-Message-State: AOAM531Qmo+d31VShzwmnIu5aLxe4H/mPqIwNpbWiktQ3hLgkkY2sEV9
        hdBk+Gr66oqrFHJWlGOyDpmwEd7dD9dOezzO7QOWRqcZ
X-Google-Smtp-Source: ABdhPJxBOMLainKilL0xte4NzLnpv3DXC6wbXjK7MKobehG/vHbACpUMUV6YTKVkijKj4BdAiigKLgs97g5UTBaG7d8=
X-Received: by 2002:a05:6830:1bd3:: with SMTP id v19mr4954618ota.91.1594746609062;
 Tue, 14 Jul 2020 10:10:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200627235318.Bluez.v2.1.I1322f6745fa50365c1c88de3e2c50c9c5962c094@changeid>
 <CABBYNZ+8bZW7qjzVNsSv7Sc_3h-ZwbSa6Hnz=dAX+2AxmWV9Dw@mail.gmail.com> <CAJQfnxHnLKoMQ+Z5bRhAQPWkoN5Lb5m-9o2pe4HTMP4Jy26qrQ@mail.gmail.com>
In-Reply-To: <CAJQfnxHnLKoMQ+Z5bRhAQPWkoN5Lb5m-9o2pe4HTMP4Jy26qrQ@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 14 Jul 2020 10:09:57 -0700
Message-ID: <CABBYNZJxcgtkGRTiwjvKgTndT22SbK+gY8tZk-2z2++7d_57ag@mail.gmail.com>
Subject: Re: [Bluez PATCH v2 1/2] device: add device_remove_bonding function
To:     Archie Pusaka <apusaka@google.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Alain Michaud <alainm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

On Tue, Jul 7, 2020 at 9:30 PM Archie Pusaka <apusaka@google.com> wrote:
>
> Hi Luiz,
>
> As far as the spec is concerned, we can also remove the device by
> calling device_remove. However, I suppose it would be confusing for
> end users if they can no longer find their HID device on the device
> list just because the device previously sent a virtual cable
> disconnection.
> The HID 1.0 spec part 6.4.2 also gives an example of a possible
> scenario when a virtually cabled device is removed: "Unplugged devices
> shall be marked as known and put into a =E2=80=9Cmost recently used list=
=E2=80=9D of
> known devices to facilitate future re-connecting".

Then perhaps we shall have it marked as temporary as well, that said
we do want to introduce disappearing logic so temporary devices are
not left dangling for too long.

> Thanks,
> Archie
>
>
> On Wed, 8 Jul 2020 at 02:03, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Archie,
> >
> > On Sat, Jun 27, 2020 at 8:54 AM Archie Pusaka <apusaka@google.com> wrot=
e:
> > >
> > > From: Archie Pusaka <apusaka@chromium.org>
> > >
> > > This patch splits the "bonding removal" function in device.c,
> > > because we need to remove bonding information when receiving
> > > "virtual cable unplug" in HID profile.
> > >
> > > Reviewed-by: Alain Michaud <alainm@chromium.org>
> > > ---
> > >
> > > Changes in v2: None
> > >
> > >  src/device.c | 25 +++++++++++++++----------
> > >  src/device.h |  1 +
> > >  2 files changed, 16 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/src/device.c b/src/device.c
> > > index 7b0eb256e..9fb0e018c 100644
> > > --- a/src/device.c
> > > +++ b/src/device.c
> > > @@ -4162,6 +4162,17 @@ static void delete_folder_tree(const char *dir=
name)
> > >         rmdir(dirname);
> > >  }
> > >
> > > +void device_remove_bonding(struct btd_device *device, uint8_t bdaddr=
_type)
> > > +{
> > > +       if (bdaddr_type =3D=3D BDADDR_BREDR)
> > > +               device->bredr_state.bonded =3D false;
> > > +       else
> > > +               device->le_state.bonded =3D false;
> > > +
> > > +       btd_adapter_remove_bonding(device->adapter, &device->bdaddr,
> > > +                                                       bdaddr_type);
> > > +}
> > > +
> > >  static void device_remove_stored(struct btd_device *device)
> > >  {
> > >         char device_addr[18];
> > > @@ -4170,17 +4181,11 @@ static void device_remove_stored(struct btd_d=
evice *device)
> > >         char *data;
> > >         gsize length =3D 0;
> > >
> > > -       if (device->bredr_state.bonded) {
> > > -               device->bredr_state.bonded =3D false;
> > > -               btd_adapter_remove_bonding(device->adapter, &device->=
bdaddr,
> > > -                                                               BDADD=
R_BREDR);
> > > -       }
> > > +       if (device->bredr_state.bonded)
> > > +               device_remove_bonding(device, BDADDR_BREDR);
> > >
> > > -       if (device->le_state.bonded) {
> > > -               device->le_state.bonded =3D false;
> > > -               btd_adapter_remove_bonding(device->adapter, &device->=
bdaddr,
> > > -                                                       device->bdadd=
r_type);
> > > -       }
> > > +       if (device->le_state.bonded)
> > > +               device_remove_bonding(device, device->bdaddr_type);
> > >
> > >         device->bredr_state.paired =3D false;
> > >         device->le_state.paired =3D false;
> > > diff --git a/src/device.h b/src/device.h
> > > index 06b100499..907c7c5c4 100644
> > > --- a/src/device.h
> > > +++ b/src/device.h
> > > @@ -49,6 +49,7 @@ uint16_t btd_device_get_vendor(struct btd_device *d=
evice);
> > >  uint16_t btd_device_get_vendor_src(struct btd_device *device);
> > >  uint16_t btd_device_get_product(struct btd_device *device);
> > >  uint16_t btd_device_get_version(struct btd_device *device);
> > > +void device_remove_bonding(struct btd_device *device, uint8_t bdaddr=
_type);
> > >  void device_remove(struct btd_device *device, gboolean remove_stored=
);
> >
> > Is there any particular reason why device_remove is not enough here? I
> > don't see any reason to leave the device object around after removing
> > its bonding.
> >
> > >  int device_address_cmp(gconstpointer a, gconstpointer b);
> > >  int device_bdaddr_cmp(gconstpointer a, gconstpointer b);
> > > --
> > > 2.27.0.212.ge8ba1cc988-goog
> > >
> >
> >
> > --
> > Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
