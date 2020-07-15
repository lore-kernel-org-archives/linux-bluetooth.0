Return-Path: <SRS0=eiFZ=A2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3409C433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jul 2020 17:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D0F22065D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jul 2020 17:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSGJIJn9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbgGORbv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Jul 2020 13:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgGORbu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Jul 2020 13:31:50 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6888AC061755
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2020 10:31:50 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id z23so619935ood.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2020 10:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qM/ZiioFc4rdDTmDUJQeOmStFmzxuCXtcg1ziNREXcA=;
        b=nSGJIJn98mwsiM8Qrk3LaSPeqUB1r7j0gLAqpBo8ig+0eW/F51AadHNDvqbNuYXaI4
         TkQrUwkkE39EHHSsNJZY+ZTFpeQ3lWyWbLBjRCswEk0K+aYKjGQdXUfNJCrRDxpb9dox
         EMCZDbLIr+1S6aQO6Nocbs0hK90DQ8YDah8iHkIPZPD1SyVuWcMZzomeU9yAxkImzcpW
         4C1NnbmkfjL4RszXhWyuZQ07Mw3SigKx3MwdBcXVhLDKYcm+GbGKwBJ3ggSKjaF1g+xx
         i4wZqLjyCHQ5EptWI7LoQBHmY7TH2ugUDozz4nEuJ8Id/GQ2KnU3sFKt+UKH2FxU2PSI
         i3pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qM/ZiioFc4rdDTmDUJQeOmStFmzxuCXtcg1ziNREXcA=;
        b=T480qXw/8iNWIr+hFDGzTSkaT9Y3YZHC8bA3I3CFKu711g5gzubod49mvjPYf/UJGU
         GayHJpSN9oIrG74lJrVRmG9T0RwCAjuldjM84jZ4/bqbB4div4L+r+lTbgUVLW5Z12vB
         8FFVtvq1Pc3ehuF1iol19lvCMSwitIUdsK6AsJUvynfF3J9mym1x9oPb4wYMLNo9tsOd
         fMx2W5zqQ1e9yRIFqyttDWtoxNVGusjJakuwPOGf1QoLeqkXt90fQfg6svZqqpjlOFto
         NxEAxXTPgeeGjLwej9riGFP0aDX+SBX4IbduDbadZaFNeAh1dWG9NJfiKgjZUqHzQynb
         SwFg==
X-Gm-Message-State: AOAM532gRinoBk3C6cCvMGfHba4Jg97nQSYI2jFO9dsK9goVw+RPavxf
        nDuR08aCxcbIMHkuo+gsDgfrqeXT0zUlzgtqNcY=
X-Google-Smtp-Source: ABdhPJyX0A8uvkXCEe0gdLPGnMu6Fp09/FXMHvt6FMTz2hX1/Hosn4CTRzP5cb44nqI5C2zNxilEPUYw9cqVl5W7E0E=
X-Received: by 2002:a4a:3405:: with SMTP id b5mr251603ooa.9.1594834309229;
 Wed, 15 Jul 2020 10:31:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200627235318.Bluez.v2.1.I1322f6745fa50365c1c88de3e2c50c9c5962c094@changeid>
 <CABBYNZ+8bZW7qjzVNsSv7Sc_3h-ZwbSa6Hnz=dAX+2AxmWV9Dw@mail.gmail.com>
 <CAJQfnxHnLKoMQ+Z5bRhAQPWkoN5Lb5m-9o2pe4HTMP4Jy26qrQ@mail.gmail.com>
 <CABBYNZJxcgtkGRTiwjvKgTndT22SbK+gY8tZk-2z2++7d_57ag@mail.gmail.com> <CAJQfnxF19gmarFT+Eimuo+UPEu1Lgkrq4XBu2RtBDpKxPQ4dtQ@mail.gmail.com>
In-Reply-To: <CAJQfnxF19gmarFT+Eimuo+UPEu1Lgkrq4XBu2RtBDpKxPQ4dtQ@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 15 Jul 2020 10:31:37 -0700
Message-ID: <CABBYNZLytt7Qp=ZXTNF+6MpvaGHb3Eg7hyRCojcDChp1tmrvmw@mail.gmail.com>
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

On Wed, Jul 15, 2020 at 7:15 AM Archie Pusaka <apusaka@google.com> wrote:
>
> Hi Luiz,
>
> If we mark it as temporary, then the device will immediately get
> deleted upon disconnection.
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/adapter.c#n68=
75
> This is the same situation as directly calling device_remove.
>
> May I know the reason why we want to put the device as temporary?
>
> If we currently don't have a way to keep a "previously connected but
> no longer bonded" device, then removing the device perhaps is the next
> best option. It still makes the user scan for the virtually
> disconnected device though.

We keep a cache of previously known devices, but we only display them
once they are actually found otherwise it may grow too big which is
inconvenient, I wonder where this concept of "previously connected but
no longer bonded" comes from though, we had the temporary to map
devices that would not be persisted on the storage which I guess this
is what it is about, that said we could perhaps have a timeout before
setting it as temporary but we might want to integrate with the logic
of detecting devices disappearing.

> Thanks,
> Archie
>
> On Wed, 15 Jul 2020 at 01:10, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Archie,
> >
> > On Tue, Jul 7, 2020 at 9:30 PM Archie Pusaka <apusaka@google.com> wrote=
:
> > >
> > > Hi Luiz,
> > >
> > > As far as the spec is concerned, we can also remove the device by
> > > calling device_remove. However, I suppose it would be confusing for
> > > end users if they can no longer find their HID device on the device
> > > list just because the device previously sent a virtual cable
> > > disconnection.
> > > The HID 1.0 spec part 6.4.2 also gives an example of a possible
> > > scenario when a virtually cabled device is removed: "Unplugged device=
s
> > > shall be marked as known and put into a =E2=80=9Cmost recently used l=
ist=E2=80=9D of
> > > known devices to facilitate future re-connecting".
> >
> > Then perhaps we shall have it marked as temporary as well, that said
> > we do want to introduce disappearing logic so temporary devices are
> > not left dangling for too long.
> >
> > > Thanks,
> > > Archie
> > >
> > >
> > > On Wed, 8 Jul 2020 at 02:03, Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > > >
> > > > Hi Archie,
> > > >
> > > > On Sat, Jun 27, 2020 at 8:54 AM Archie Pusaka <apusaka@google.com> =
wrote:
> > > > >
> > > > > From: Archie Pusaka <apusaka@chromium.org>
> > > > >
> > > > > This patch splits the "bonding removal" function in device.c,
> > > > > because we need to remove bonding information when receiving
> > > > > "virtual cable unplug" in HID profile.
> > > > >
> > > > > Reviewed-by: Alain Michaud <alainm@chromium.org>
> > > > > ---
> > > > >
> > > > > Changes in v2: None
> > > > >
> > > > >  src/device.c | 25 +++++++++++++++----------
> > > > >  src/device.h |  1 +
> > > > >  2 files changed, 16 insertions(+), 10 deletions(-)
> > > > >
> > > > > diff --git a/src/device.c b/src/device.c
> > > > > index 7b0eb256e..9fb0e018c 100644
> > > > > --- a/src/device.c
> > > > > +++ b/src/device.c
> > > > > @@ -4162,6 +4162,17 @@ static void delete_folder_tree(const char =
*dirname)
> > > > >         rmdir(dirname);
> > > > >  }
> > > > >
> > > > > +void device_remove_bonding(struct btd_device *device, uint8_t bd=
addr_type)
> > > > > +{
> > > > > +       if (bdaddr_type =3D=3D BDADDR_BREDR)
> > > > > +               device->bredr_state.bonded =3D false;
> > > > > +       else
> > > > > +               device->le_state.bonded =3D false;
> > > > > +
> > > > > +       btd_adapter_remove_bonding(device->adapter, &device->bdad=
dr,
> > > > > +                                                       bdaddr_ty=
pe);
> > > > > +}
> > > > > +
> > > > >  static void device_remove_stored(struct btd_device *device)
> > > > >  {
> > > > >         char device_addr[18];
> > > > > @@ -4170,17 +4181,11 @@ static void device_remove_stored(struct b=
td_device *device)
> > > > >         char *data;
> > > > >         gsize length =3D 0;
> > > > >
> > > > > -       if (device->bredr_state.bonded) {
> > > > > -               device->bredr_state.bonded =3D false;
> > > > > -               btd_adapter_remove_bonding(device->adapter, &devi=
ce->bdaddr,
> > > > > -                                                               B=
DADDR_BREDR);
> > > > > -       }
> > > > > +       if (device->bredr_state.bonded)
> > > > > +               device_remove_bonding(device, BDADDR_BREDR);
> > > > >
> > > > > -       if (device->le_state.bonded) {
> > > > > -               device->le_state.bonded =3D false;
> > > > > -               btd_adapter_remove_bonding(device->adapter, &devi=
ce->bdaddr,
> > > > > -                                                       device->b=
daddr_type);
> > > > > -       }
> > > > > +       if (device->le_state.bonded)
> > > > > +               device_remove_bonding(device, device->bdaddr_type=
);
> > > > >
> > > > >         device->bredr_state.paired =3D false;
> > > > >         device->le_state.paired =3D false;
> > > > > diff --git a/src/device.h b/src/device.h
> > > > > index 06b100499..907c7c5c4 100644
> > > > > --- a/src/device.h
> > > > > +++ b/src/device.h
> > > > > @@ -49,6 +49,7 @@ uint16_t btd_device_get_vendor(struct btd_devic=
e *device);
> > > > >  uint16_t btd_device_get_vendor_src(struct btd_device *device);
> > > > >  uint16_t btd_device_get_product(struct btd_device *device);
> > > > >  uint16_t btd_device_get_version(struct btd_device *device);
> > > > > +void device_remove_bonding(struct btd_device *device, uint8_t bd=
addr_type);
> > > > >  void device_remove(struct btd_device *device, gboolean remove_st=
ored);
> > > >
> > > > Is there any particular reason why device_remove is not enough here=
? I
> > > > don't see any reason to leave the device object around after removi=
ng
> > > > its bonding.
> > > >
> > > > >  int device_address_cmp(gconstpointer a, gconstpointer b);
> > > > >  int device_bdaddr_cmp(gconstpointer a, gconstpointer b);
> > > > > --
> > > > > 2.27.0.212.ge8ba1cc988-goog
> > > > >
> > > >
> > > >
> > > > --
> > > > Luiz Augusto von Dentz
> >
> >
> >
> > --
> > Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
