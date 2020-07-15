Return-Path: <SRS0=eiFZ=A2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F534C433E2
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jul 2020 14:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAC57206E9
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jul 2020 14:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fru6NuFP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbgGOOPh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Jul 2020 10:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbgGOOPh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Jul 2020 10:15:37 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2AE6C061755
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2020 07:15:36 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id j18so5770111wmi.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2020 07:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1ewJDA+uKRhpNjXIL8tsMezrJq68UXqo5kRUEl5auJs=;
        b=Fru6NuFPC3iRhBULRCMIXdcBJN/ZQLaLKB92qpZ17u/6fH04xPLPYJi4Kiio3F1gdI
         HixvMzkyiM9Iwzx/2JTVtWa24U9zk5+obGxY4yDYTsjOpE/Xw1ste2WnbI3qlPXF+N9k
         uEk1UViISOTlno6Q/mF8MeaBhytkGJQ+kwr2YQLO221CDQx5Dmrqy9INso/0xvNFT245
         yWptLwHN1oA0VKVgBPsltf/PFwI8wb3QgXdw8xquUbN73/eP5DebexH4lJCty6bAFoJN
         sbRBnZAVR59NQUKoTasG3BuvHwcNuxHo3hJBVzMv6Z8/L7BsfSvgBD2v+ZzNjkffiDw3
         mTPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1ewJDA+uKRhpNjXIL8tsMezrJq68UXqo5kRUEl5auJs=;
        b=Rl9p7z8QEfehVHYb3K21gDSTM6xiBnGG+xQlwNXhFDPx9f4Wp/qmRlj2MN+9WHKLU6
         YipvERfzEmHBrcHrAvfIKOJOvDOA1BONQrcATrn4TCpLv2wI2STrM5EL/Os4ku6mpfL1
         iIM/zVRLvZemh4SlS1LL54LdeKFMjzEt3iydVJpwq6eNLVY9vT+vXrScOAvwbeb6H11X
         vyXAr1XdC75+UhdfK7CTSggYhfehmiHPcu/Yo+sYsAgYEQLGmT2YpEK2qQE8hUBRnygj
         z78eju0t2vG25W2ge3YRbHZAWbsCVbp979qpMHjwlclzTFwfT7d3HGMhIV/vPZMfJ7I/
         k+Ew==
X-Gm-Message-State: AOAM533/Eb+tznlwdY1DWBu17QMr7cjU3+l7/tEDJKCrKn0WRPG1xzWK
        /jyoqmIDMlVwgdIfbVcvS4ZvIV4EWc3v6Qz0TtUFnQ==
X-Google-Smtp-Source: ABdhPJzrGwvzSR9TRYQjfx/W/2r9Vxcf1SZC4LAX1ZQ4PjsfbnnqWY/L4HscvKFL2s+gDQzn5WGx2IY0gNDdQV9K2ro=
X-Received: by 2002:a7b:cf18:: with SMTP id l24mr8846396wmg.116.1594822534882;
 Wed, 15 Jul 2020 07:15:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200627235318.Bluez.v2.1.I1322f6745fa50365c1c88de3e2c50c9c5962c094@changeid>
 <CABBYNZ+8bZW7qjzVNsSv7Sc_3h-ZwbSa6Hnz=dAX+2AxmWV9Dw@mail.gmail.com>
 <CAJQfnxHnLKoMQ+Z5bRhAQPWkoN5Lb5m-9o2pe4HTMP4Jy26qrQ@mail.gmail.com> <CABBYNZJxcgtkGRTiwjvKgTndT22SbK+gY8tZk-2z2++7d_57ag@mail.gmail.com>
In-Reply-To: <CABBYNZJxcgtkGRTiwjvKgTndT22SbK+gY8tZk-2z2++7d_57ag@mail.gmail.com>
From:   Archie Pusaka <apusaka@google.com>
Date:   Wed, 15 Jul 2020 22:15:23 +0800
Message-ID: <CAJQfnxF19gmarFT+Eimuo+UPEu1Lgkrq4XBu2RtBDpKxPQ4dtQ@mail.gmail.com>
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

If we mark it as temporary, then the device will immediately get
deleted upon disconnection.
https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/adapter.c#n6875
This is the same situation as directly calling device_remove.

May I know the reason why we want to put the device as temporary?

If we currently don't have a way to keep a "previously connected but
no longer bonded" device, then removing the device perhaps is the next
best option. It still makes the user scan for the virtually
disconnected device though.

Thanks,
Archie

On Wed, 15 Jul 2020 at 01:10, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Archie,
>
> On Tue, Jul 7, 2020 at 9:30 PM Archie Pusaka <apusaka@google.com> wrote:
> >
> > Hi Luiz,
> >
> > As far as the spec is concerned, we can also remove the device by
> > calling device_remove. However, I suppose it would be confusing for
> > end users if they can no longer find their HID device on the device
> > list just because the device previously sent a virtual cable
> > disconnection.
> > The HID 1.0 spec part 6.4.2 also gives an example of a possible
> > scenario when a virtually cabled device is removed: "Unplugged devices
> > shall be marked as known and put into a =E2=80=9Cmost recently used lis=
t=E2=80=9D of
> > known devices to facilitate future re-connecting".
>
> Then perhaps we shall have it marked as temporary as well, that said
> we do want to introduce disappearing logic so temporary devices are
> not left dangling for too long.
>
> > Thanks,
> > Archie
> >
> >
> > On Wed, 8 Jul 2020 at 02:03, Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Archie,
> > >
> > > On Sat, Jun 27, 2020 at 8:54 AM Archie Pusaka <apusaka@google.com> wr=
ote:
> > > >
> > > > From: Archie Pusaka <apusaka@chromium.org>
> > > >
> > > > This patch splits the "bonding removal" function in device.c,
> > > > because we need to remove bonding information when receiving
> > > > "virtual cable unplug" in HID profile.
> > > >
> > > > Reviewed-by: Alain Michaud <alainm@chromium.org>
> > > > ---
> > > >
> > > > Changes in v2: None
> > > >
> > > >  src/device.c | 25 +++++++++++++++----------
> > > >  src/device.h |  1 +
> > > >  2 files changed, 16 insertions(+), 10 deletions(-)
> > > >
> > > > diff --git a/src/device.c b/src/device.c
> > > > index 7b0eb256e..9fb0e018c 100644
> > > > --- a/src/device.c
> > > > +++ b/src/device.c
> > > > @@ -4162,6 +4162,17 @@ static void delete_folder_tree(const char *d=
irname)
> > > >         rmdir(dirname);
> > > >  }
> > > >
> > > > +void device_remove_bonding(struct btd_device *device, uint8_t bdad=
dr_type)
> > > > +{
> > > > +       if (bdaddr_type =3D=3D BDADDR_BREDR)
> > > > +               device->bredr_state.bonded =3D false;
> > > > +       else
> > > > +               device->le_state.bonded =3D false;
> > > > +
> > > > +       btd_adapter_remove_bonding(device->adapter, &device->bdaddr=
,
> > > > +                                                       bdaddr_type=
);
> > > > +}
> > > > +
> > > >  static void device_remove_stored(struct btd_device *device)
> > > >  {
> > > >         char device_addr[18];
> > > > @@ -4170,17 +4181,11 @@ static void device_remove_stored(struct btd=
_device *device)
> > > >         char *data;
> > > >         gsize length =3D 0;
> > > >
> > > > -       if (device->bredr_state.bonded) {
> > > > -               device->bredr_state.bonded =3D false;
> > > > -               btd_adapter_remove_bonding(device->adapter, &device=
->bdaddr,
> > > > -                                                               BDA=
DDR_BREDR);
> > > > -       }
> > > > +       if (device->bredr_state.bonded)
> > > > +               device_remove_bonding(device, BDADDR_BREDR);
> > > >
> > > > -       if (device->le_state.bonded) {
> > > > -               device->le_state.bonded =3D false;
> > > > -               btd_adapter_remove_bonding(device->adapter, &device=
->bdaddr,
> > > > -                                                       device->bda=
ddr_type);
> > > > -       }
> > > > +       if (device->le_state.bonded)
> > > > +               device_remove_bonding(device, device->bdaddr_type);
> > > >
> > > >         device->bredr_state.paired =3D false;
> > > >         device->le_state.paired =3D false;
> > > > diff --git a/src/device.h b/src/device.h
> > > > index 06b100499..907c7c5c4 100644
> > > > --- a/src/device.h
> > > > +++ b/src/device.h
> > > > @@ -49,6 +49,7 @@ uint16_t btd_device_get_vendor(struct btd_device =
*device);
> > > >  uint16_t btd_device_get_vendor_src(struct btd_device *device);
> > > >  uint16_t btd_device_get_product(struct btd_device *device);
> > > >  uint16_t btd_device_get_version(struct btd_device *device);
> > > > +void device_remove_bonding(struct btd_device *device, uint8_t bdad=
dr_type);
> > > >  void device_remove(struct btd_device *device, gboolean remove_stor=
ed);
> > >
> > > Is there any particular reason why device_remove is not enough here? =
I
> > > don't see any reason to leave the device object around after removing
> > > its bonding.
> > >
> > > >  int device_address_cmp(gconstpointer a, gconstpointer b);
> > > >  int device_bdaddr_cmp(gconstpointer a, gconstpointer b);
> > > > --
> > > > 2.27.0.212.ge8ba1cc988-goog
> > > >
> > >
> > >
> > > --
> > > Luiz Augusto von Dentz
>
>
>
> --
> Luiz Augusto von Dentz
