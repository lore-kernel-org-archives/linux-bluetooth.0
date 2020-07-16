Return-Path: <SRS0=Zco+=A3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CEFC433E3
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Jul 2020 07:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C3BB2071B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Jul 2020 07:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GPs6wigM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbgGPH2q (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Jul 2020 03:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbgGPH2p (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Jul 2020 03:28:45 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970F6C061755
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2020 00:28:45 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id o2so10266384wmh.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2020 00:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VwEVcaUw3v/2qY3aPbUo4gTJ+U9r5Oqzgbzm9DK6XoU=;
        b=GPs6wigMsGSnzi70Vn3gAsuNeVbDKUfYx7IGCVSGY0VSxq0n9OT1tDkFlFOzAbYtD5
         2uQ9ovIGXgS8s/4anKp6q6KZWobcXURAWtwNhI9lJHX+C6J4UUGKW82SHKrCcp3xsQQm
         QebuflIob+5ZAEt+htIpSwAOPXzQKf/MfgDWa2cQkl23cEuxIw5iVWfmIUuJgEJg6616
         tAopYNmPI6ZGO+7P8ll3APzYeIP9SXy/pjuV0uizoRH/JaN967nmDej5P7q3Fu6XNb7b
         3egp7nlwpDk7Rp9ZTTLedOlo707iEw3vW+pXHvz0KOTiNsU5+Xe7H1tm6LVUIUnzEQqu
         OzKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VwEVcaUw3v/2qY3aPbUo4gTJ+U9r5Oqzgbzm9DK6XoU=;
        b=j/XjmZ642h/NdEfctzMK228CS1oz9gV68P+Ur1KatIm7yz6LVcV6OAu28LjrMdwKtW
         s5Ltm5aVP3TnXoGqFx01YXIKlE1Bf7xTDbJZ2UWc/dRQNjg8IMEWQwGInXGSa8m1vSBt
         A6j2SdonPJO46wGi0w7GgdtjxXXP++KvRC+z1FqPYThfk1dSf9EfowqFX1uF+lk92Dv/
         ZhsBOMScLnhTe0COLynY14A73oYD9MYVepsYzHzlmxeCN2oPCEr6U/uEggF4hHPMqzTQ
         WgHJHInoFEpQeOkh6ZAeqk31piHPZsHvDh3xeLtwqGEhKjSHCU3mVriAXH/KJtsTia7Y
         p0IQ==
X-Gm-Message-State: AOAM532NpP1Tg9mOpiEh9ywJogkwB8ilIzrW3PZbpMbYA7ZkGUDIj/S1
        5hYfAf8pXx6VoWm5cpp8H0D+9BQcPywbkArJP8jkvw==
X-Google-Smtp-Source: ABdhPJwlDSk7UZViDeHPn6wRtL99mpSy0b7jXQ+6FkSkIKX4Lhz7vj0IlYOd0EHP4NdlsXM9r5SV4v+I64JNWXlUAcc=
X-Received: by 2002:a1c:b608:: with SMTP id g8mr3056156wmf.55.1594884523988;
 Thu, 16 Jul 2020 00:28:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200627235318.Bluez.v2.1.I1322f6745fa50365c1c88de3e2c50c9c5962c094@changeid>
 <CABBYNZ+8bZW7qjzVNsSv7Sc_3h-ZwbSa6Hnz=dAX+2AxmWV9Dw@mail.gmail.com>
 <CAJQfnxHnLKoMQ+Z5bRhAQPWkoN5Lb5m-9o2pe4HTMP4Jy26qrQ@mail.gmail.com>
 <CABBYNZJxcgtkGRTiwjvKgTndT22SbK+gY8tZk-2z2++7d_57ag@mail.gmail.com>
 <CAJQfnxF19gmarFT+Eimuo+UPEu1Lgkrq4XBu2RtBDpKxPQ4dtQ@mail.gmail.com> <CABBYNZLytt7Qp=ZXTNF+6MpvaGHb3Eg7hyRCojcDChp1tmrvmw@mail.gmail.com>
In-Reply-To: <CABBYNZLytt7Qp=ZXTNF+6MpvaGHb3Eg7hyRCojcDChp1tmrvmw@mail.gmail.com>
From:   Archie Pusaka <apusaka@google.com>
Date:   Thu, 16 Jul 2020 15:28:32 +0800
Message-ID: <CAJQfnxHkKthQVXD_dM=E=mJ7f7SGf1TT4=CDbfrKBy+KQoa2SA@mail.gmail.com>
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

Hi Luiz,

I think spec writers' idea is to have a list of previously connected
devices which is ordered by most recently connected. The size of this
list may be limited to a number, meaning that the least recently
connected device will be removed from the list. The devices in this
list may or may not be bonded. This list is accessible to users, so
they can easily reconnect to the most recently used device.

I don't suppose we currently have this list, so I'm happy with just
removing the virtually unplugged device.

Thanks,
Archie

On Thu, 16 Jul 2020 at 01:31, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Archie,
>
> On Wed, Jul 15, 2020 at 7:15 AM Archie Pusaka <apusaka@google.com> wrote:
> >
> > Hi Luiz,
> >
> > If we mark it as temporary, then the device will immediately get
> > deleted upon disconnection.
> > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/adapter.c#n=
6875
> > This is the same situation as directly calling device_remove.
> >
> > May I know the reason why we want to put the device as temporary?
> >
> > If we currently don't have a way to keep a "previously connected but
> > no longer bonded" device, then removing the device perhaps is the next
> > best option. It still makes the user scan for the virtually
> > disconnected device though.
>
> We keep a cache of previously known devices, but we only display them
> once they are actually found otherwise it may grow too big which is
> inconvenient, I wonder where this concept of "previously connected but
> no longer bonded" comes from though, we had the temporary to map
> devices that would not be persisted on the storage which I guess this
> is what it is about, that said we could perhaps have a timeout before
> setting it as temporary but we might want to integrate with the logic
> of detecting devices disappearing.
>
> > Thanks,
> > Archie
> >
> > On Wed, 15 Jul 2020 at 01:10, Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Archie,
> > >
> > > On Tue, Jul 7, 2020 at 9:30 PM Archie Pusaka <apusaka@google.com> wro=
te:
> > > >
> > > > Hi Luiz,
> > > >
> > > > As far as the spec is concerned, we can also remove the device by
> > > > calling device_remove. However, I suppose it would be confusing for
> > > > end users if they can no longer find their HID device on the device
> > > > list just because the device previously sent a virtual cable
> > > > disconnection.
> > > > The HID 1.0 spec part 6.4.2 also gives an example of a possible
> > > > scenario when a virtually cabled device is removed: "Unplugged devi=
ces
> > > > shall be marked as known and put into a =E2=80=9Cmost recently used=
 list=E2=80=9D of
> > > > known devices to facilitate future re-connecting".
> > >
> > > Then perhaps we shall have it marked as temporary as well, that said
> > > we do want to introduce disappearing logic so temporary devices are
> > > not left dangling for too long.
> > >
> > > > Thanks,
> > > > Archie
> > > >
> > > >
> > > > On Wed, 8 Jul 2020 at 02:03, Luiz Augusto von Dentz
> > > > <luiz.dentz@gmail.com> wrote:
> > > > >
> > > > > Hi Archie,
> > > > >
> > > > > On Sat, Jun 27, 2020 at 8:54 AM Archie Pusaka <apusaka@google.com=
> wrote:
> > > > > >
> > > > > > From: Archie Pusaka <apusaka@chromium.org>
> > > > > >
> > > > > > This patch splits the "bonding removal" function in device.c,
> > > > > > because we need to remove bonding information when receiving
> > > > > > "virtual cable unplug" in HID profile.
> > > > > >
> > > > > > Reviewed-by: Alain Michaud <alainm@chromium.org>
> > > > > > ---
> > > > > >
> > > > > > Changes in v2: None
> > > > > >
> > > > > >  src/device.c | 25 +++++++++++++++----------
> > > > > >  src/device.h |  1 +
> > > > > >  2 files changed, 16 insertions(+), 10 deletions(-)
> > > > > >
> > > > > > diff --git a/src/device.c b/src/device.c
> > > > > > index 7b0eb256e..9fb0e018c 100644
> > > > > > --- a/src/device.c
> > > > > > +++ b/src/device.c
> > > > > > @@ -4162,6 +4162,17 @@ static void delete_folder_tree(const cha=
r *dirname)
> > > > > >         rmdir(dirname);
> > > > > >  }
> > > > > >
> > > > > > +void device_remove_bonding(struct btd_device *device, uint8_t =
bdaddr_type)
> > > > > > +{
> > > > > > +       if (bdaddr_type =3D=3D BDADDR_BREDR)
> > > > > > +               device->bredr_state.bonded =3D false;
> > > > > > +       else
> > > > > > +               device->le_state.bonded =3D false;
> > > > > > +
> > > > > > +       btd_adapter_remove_bonding(device->adapter, &device->bd=
addr,
> > > > > > +                                                       bdaddr_=
type);
> > > > > > +}
> > > > > > +
> > > > > >  static void device_remove_stored(struct btd_device *device)
> > > > > >  {
> > > > > >         char device_addr[18];
> > > > > > @@ -4170,17 +4181,11 @@ static void device_remove_stored(struct=
 btd_device *device)
> > > > > >         char *data;
> > > > > >         gsize length =3D 0;
> > > > > >
> > > > > > -       if (device->bredr_state.bonded) {
> > > > > > -               device->bredr_state.bonded =3D false;
> > > > > > -               btd_adapter_remove_bonding(device->adapter, &de=
vice->bdaddr,
> > > > > > -                                                              =
 BDADDR_BREDR);
> > > > > > -       }
> > > > > > +       if (device->bredr_state.bonded)
> > > > > > +               device_remove_bonding(device, BDADDR_BREDR);
> > > > > >
> > > > > > -       if (device->le_state.bonded) {
> > > > > > -               device->le_state.bonded =3D false;
> > > > > > -               btd_adapter_remove_bonding(device->adapter, &de=
vice->bdaddr,
> > > > > > -                                                       device-=
>bdaddr_type);
> > > > > > -       }
> > > > > > +       if (device->le_state.bonded)
> > > > > > +               device_remove_bonding(device, device->bdaddr_ty=
pe);
> > > > > >
> > > > > >         device->bredr_state.paired =3D false;
> > > > > >         device->le_state.paired =3D false;
> > > > > > diff --git a/src/device.h b/src/device.h
> > > > > > index 06b100499..907c7c5c4 100644
> > > > > > --- a/src/device.h
> > > > > > +++ b/src/device.h
> > > > > > @@ -49,6 +49,7 @@ uint16_t btd_device_get_vendor(struct btd_dev=
ice *device);
> > > > > >  uint16_t btd_device_get_vendor_src(struct btd_device *device);
> > > > > >  uint16_t btd_device_get_product(struct btd_device *device);
> > > > > >  uint16_t btd_device_get_version(struct btd_device *device);
> > > > > > +void device_remove_bonding(struct btd_device *device, uint8_t =
bdaddr_type);
> > > > > >  void device_remove(struct btd_device *device, gboolean remove_=
stored);
> > > > >
> > > > > Is there any particular reason why device_remove is not enough he=
re? I
> > > > > don't see any reason to leave the device object around after remo=
ving
> > > > > its bonding.
> > > > >
> > > > > >  int device_address_cmp(gconstpointer a, gconstpointer b);
> > > > > >  int device_bdaddr_cmp(gconstpointer a, gconstpointer b);
> > > > > > --
> > > > > > 2.27.0.212.ge8ba1cc988-goog
> > > > > >
> > > > >
> > > > >
> > > > > --
> > > > > Luiz Augusto von Dentz
> > >
> > >
> > >
> > > --
> > > Luiz Augusto von Dentz
>
>
>
> --
> Luiz Augusto von Dentz
