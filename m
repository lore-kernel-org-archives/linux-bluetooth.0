Return-Path: <SRS0=5ENf=AZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF18C433E1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Jul 2020 04:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2132207BB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Jul 2020 04:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="slrqG0LK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725816AbgGNEuV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Jul 2020 00:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgGNEuV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Jul 2020 00:50:21 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5F6C061755
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2020 21:50:20 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f2so19604089wrp.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2020 21:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=37nDfESDIhoSwPGL6Glfvlv9L4EsPmHD+Xrex+aGhCw=;
        b=slrqG0LKVuw2+sgm/xQZ/zSENIZLGqfC9zsi2e658ICRh06VUviRn767AhOl4swsNI
         +hkNJ7K990qpd2rJ/bsn69rIxIj0pcxQb9t8mJRf7LkD8+rYYXmYHELfIf9dmfNPckFg
         HvoZJnjO3Z/TfU8vPMioLPET4gim6n/Z03Pd2FPbOYr6XNa6hJh/kwLs3+sHuabDYQwR
         kTJ5DI2TkraJSdSzglYiEakGXJec8KHzRUm+7NfqHqlGO0AJ58MzcxuTAhXMgT7TWPpC
         cs9/mUyfsThGu+WXaK8F87luPUT41aPfHZPpnlL1ib/nV7dqx5zQ3jnj5OxY3mmS79kk
         +r2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=37nDfESDIhoSwPGL6Glfvlv9L4EsPmHD+Xrex+aGhCw=;
        b=eJAYODPc/ORdGn548lOvP2XnJ0HYsxpSj7gNEDl3uGQLMBz3mlrU5bhj+1aiNWD10Q
         8wEHiLNCcOStqTNfzGv1VXgJvtTQwDXI4viNsj6hvjH0PDoVYKGD9G7V5SJvIvGKX7eZ
         hHztTwmp0QGYQl3CeH+W+zNXOmrt45PwO3FqZVvrF6P5AEao9x0X8IL1zT/xigGuUypx
         k0PppUYFdMkzUWPZiR0kiD7ZIcesdcE//hVCfCEoXN54t4AwQeBc9vvTzcq10dYKjLc2
         mIMTD2nNb0ad3zlc6uHiVETnosRwy4iNbDVC+OYa2jSHitLHhle5GsYITXGGhSJJ30f5
         Aw8w==
X-Gm-Message-State: AOAM533fYxJGLQKICxq++a/XqUkHvO206tNYJ2f5XhHiqlbjr7XJw0rv
        HsyVtvzVxcOEoHkj1Y07AsCGeHMjUZ6HGwYgMVdgww==
X-Google-Smtp-Source: ABdhPJxFO0y0DYtljKyb41i+o7qC8yNnuOIHNUfcvvRxKBr/ZJdlzUvhU3CN/LMGNQGA8mEgP+k5ITQGggPQAouVj/w=
X-Received: by 2002:a5d:6342:: with SMTP id b2mr2957173wrw.262.1594702219246;
 Mon, 13 Jul 2020 21:50:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200627235318.Bluez.v2.1.I1322f6745fa50365c1c88de3e2c50c9c5962c094@changeid>
 <CABBYNZ+8bZW7qjzVNsSv7Sc_3h-ZwbSa6Hnz=dAX+2AxmWV9Dw@mail.gmail.com> <CAJQfnxHnLKoMQ+Z5bRhAQPWkoN5Lb5m-9o2pe4HTMP4Jy26qrQ@mail.gmail.com>
In-Reply-To: <CAJQfnxHnLKoMQ+Z5bRhAQPWkoN5Lb5m-9o2pe4HTMP4Jy26qrQ@mail.gmail.com>
From:   Archie Pusaka <apusaka@google.com>
Date:   Tue, 14 Jul 2020 12:50:08 +0800
Message-ID: <CAJQfnxF6Ff31obXrx9isbxvWa9wQCkX+4bT-hdKLayox5VZ+MA@mail.gmail.com>
Subject: Re: [Bluez PATCH v2 1/2] device: add device_remove_bonding function
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Alain Michaud <alainm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

[Sorry, re-sending in plain text]

Hi Luiz,

Can I have your opinion on this?

Thanks,
Archie

On Wed, 8 Jul 2020 at 12:30, Archie Pusaka <apusaka@google.com> wrote:
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
>
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
