Return-Path: <SRS0=Zco+=A3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD6FC433E6
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Jul 2020 16:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 604572071B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Jul 2020 16:14:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kL5hTGoW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbgGPQOS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Jul 2020 12:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728837AbgGPQOP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Jul 2020 12:14:15 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC21C061755
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2020 09:14:15 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id w17so4638516otl.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2020 09:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=p/vg/EWDzWdxpzX57EsqsrVySq1WuKA72MFlaFDcFLo=;
        b=kL5hTGoWpc/i3943s+mgg1anlUDIV9rYKmKzckK5FNEaGpIV1hWMHgu7wM3BzbHSos
         A1fwP2fs9SDUT8UU/gxNrFPEuIXg1qqsJv2oWGqr9+kY09RXp8+ZmJcyrs8vO1gdDeEx
         CFHeDiwDQt55P3DWj5XNvE8ImG7sNNDRUDB8/tqyrdHWAMbJnkzTAr7aX9G84q23Es22
         g5t1rhFcQ0xCx15g6hTCw5PP9Uck8Tktkn6rH5TrFbv73xvrI1dI2ZlASsBdPzuXmrSn
         M89sL5ZNdX3QM5IA8Sxc9BLMLrWmsCmQjwZFezXHe6I6gg0MRylEl3hkfO6HWElGOSvT
         MSYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=p/vg/EWDzWdxpzX57EsqsrVySq1WuKA72MFlaFDcFLo=;
        b=sh32kUEwVeBgu+YGaBbVkNfx8hz8vicBfjxSfbgJ703hN6EAEBdIN/aC3D5MD9gShZ
         56P9Zjet/N6pGu2EEnKAedqL2665EP2+L9+eHTeORlkzVGyI+OYIQAQQ5804hLGxBvvD
         9yrMKI72JtvjeUM643igcBx3xiek9JWsZPLW/dZ59krYU3iyGLCNLVzv9/JsoMTz4rlt
         WLGKAzahVbiERzPfggJWzanLJy/EJwmhfqT98EcJ52Yb7w1Zf2O2tB2rMF29exCnFhXE
         wG3nJOwYRTFzZLNh12qlvXGA2bSPIabbZC2cOnGvq9ykiDDhO4p/b+/o9EPEfruQ6PKu
         FJyw==
X-Gm-Message-State: AOAM53218+4sl6n+rAWj0clJnFvJcjeu/gKUAHNpR7ENwRDR3zPEIWNW
        5FD6MF0J1tQ//pm3k73Gt5Xj5MwIRKJOH3nZAc8=
X-Google-Smtp-Source: ABdhPJwfNUpLakGMDwCO1Psv3iLZUn6Xzf8jSKMmOUFAm3dM+c/zPveOEU6QbV14sjcrattKXAl6U2b2MrT+8acqivs=
X-Received: by 2002:a05:6830:1bd3:: with SMTP id v19mr5104262ota.91.1594916054886;
 Thu, 16 Jul 2020 09:14:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200627235318.Bluez.v2.1.I1322f6745fa50365c1c88de3e2c50c9c5962c094@changeid>
 <CABBYNZ+8bZW7qjzVNsSv7Sc_3h-ZwbSa6Hnz=dAX+2AxmWV9Dw@mail.gmail.com>
 <CAJQfnxHnLKoMQ+Z5bRhAQPWkoN5Lb5m-9o2pe4HTMP4Jy26qrQ@mail.gmail.com>
 <CABBYNZJxcgtkGRTiwjvKgTndT22SbK+gY8tZk-2z2++7d_57ag@mail.gmail.com>
 <CAJQfnxF19gmarFT+Eimuo+UPEu1Lgkrq4XBu2RtBDpKxPQ4dtQ@mail.gmail.com>
 <CABBYNZLytt7Qp=ZXTNF+6MpvaGHb3Eg7hyRCojcDChp1tmrvmw@mail.gmail.com> <CAJQfnxHkKthQVXD_dM=E=mJ7f7SGf1TT4=CDbfrKBy+KQoa2SA@mail.gmail.com>
In-Reply-To: <CAJQfnxHkKthQVXD_dM=E=mJ7f7SGf1TT4=CDbfrKBy+KQoa2SA@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 16 Jul 2020 09:14:03 -0700
Message-ID: <CABBYNZ+vVAg+oma6S5SsDGZ=ahyDJjqLvK-bTVQMawy-573+XA@mail.gmail.com>
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

On Thu, Jul 16, 2020 at 12:28 AM Archie Pusaka <apusaka@google.com> wrote:
>
> Hi Luiz,
>
> I think spec writers' idea is to have a list of previously connected
> devices which is ordered by most recently connected. The size of this
> list may be limited to a number, meaning that the least recently
> connected device will be removed from the list. The devices in this
> list may or may not be bonded. This list is accessible to users, so
> they can easily reconnect to the most recently used device.
>
> I don't suppose we currently have this list, so I'm happy with just
> removing the virtually unplugged device.

So with the latest developments Im leaning towards using
device_set_temporary since that would trigger a timer to remove the
device after it has expired.

> Thanks,
> Archie
>
> On Thu, 16 Jul 2020 at 01:31, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Archie,
> >
> > On Wed, Jul 15, 2020 at 7:15 AM Archie Pusaka <apusaka@google.com> wrot=
e:
> > >
> > > Hi Luiz,
> > >
> > > If we mark it as temporary, then the device will immediately get
> > > deleted upon disconnection.
> > > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/adapter.c=
#n6875
> > > This is the same situation as directly calling device_remove.
> > >
> > > May I know the reason why we want to put the device as temporary?
> > >
> > > If we currently don't have a way to keep a "previously connected but
> > > no longer bonded" device, then removing the device perhaps is the nex=
t
> > > best option. It still makes the user scan for the virtually
> > > disconnected device though.
> >
> > We keep a cache of previously known devices, but we only display them
> > once they are actually found otherwise it may grow too big which is
> > inconvenient, I wonder where this concept of "previously connected but
> > no longer bonded" comes from though, we had the temporary to map
> > devices that would not be persisted on the storage which I guess this
> > is what it is about, that said we could perhaps have a timeout before
> > setting it as temporary but we might want to integrate with the logic
> > of detecting devices disappearing.
> >
> > > Thanks,
> > > Archie
> > >
> > > On Wed, 15 Jul 2020 at 01:10, Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > > >
> > > > Hi Archie,
> > > >
> > > > On Tue, Jul 7, 2020 at 9:30 PM Archie Pusaka <apusaka@google.com> w=
rote:
> > > > >
> > > > > Hi Luiz,
> > > > >
> > > > > As far as the spec is concerned, we can also remove the device by
> > > > > calling device_remove. However, I suppose it would be confusing f=
or
> > > > > end users if they can no longer find their HID device on the devi=
ce
> > > > > list just because the device previously sent a virtual cable
> > > > > disconnection.
> > > > > The HID 1.0 spec part 6.4.2 also gives an example of a possible
> > > > > scenario when a virtually cabled device is removed: "Unplugged de=
vices
> > > > > shall be marked as known and put into a =E2=80=9Cmost recently us=
ed list=E2=80=9D of
> > > > > known devices to facilitate future re-connecting".
> > > >
> > > > Then perhaps we shall have it marked as temporary as well, that sai=
d
> > > > we do want to introduce disappearing logic so temporary devices are
> > > > not left dangling for too long.
> > > >
> > > > > Thanks,
> > > > > Archie
> > > > >
> > > > >
> > > > > On Wed, 8 Jul 2020 at 02:03, Luiz Augusto von Dentz
> > > > > <luiz.dentz@gmail.com> wrote:
> > > > > >
> > > > > > Hi Archie,
> > > > > >
> > > > > > On Sat, Jun 27, 2020 at 8:54 AM Archie Pusaka <apusaka@google.c=
om> wrote:
> > > > > > >
> > > > > > > From: Archie Pusaka <apusaka@chromium.org>
> > > > > > >
> > > > > > > This patch splits the "bonding removal" function in device.c,
> > > > > > > because we need to remove bonding information when receiving
> > > > > > > "virtual cable unplug" in HID profile.
> > > > > > >
> > > > > > > Reviewed-by: Alain Michaud <alainm@chromium.org>
> > > > > > > ---
> > > > > > >
> > > > > > > Changes in v2: None
> > > > > > >
> > > > > > >  src/device.c | 25 +++++++++++++++----------
> > > > > > >  src/device.h |  1 +
> > > > > > >  2 files changed, 16 insertions(+), 10 deletions(-)
> > > > > > >
> > > > > > > diff --git a/src/device.c b/src/device.c
> > > > > > > index 7b0eb256e..9fb0e018c 100644
> > > > > > > --- a/src/device.c
> > > > > > > +++ b/src/device.c
> > > > > > > @@ -4162,6 +4162,17 @@ static void delete_folder_tree(const c=
har *dirname)
> > > > > > >         rmdir(dirname);
> > > > > > >  }
> > > > > > >
> > > > > > > +void device_remove_bonding(struct btd_device *device, uint8_=
t bdaddr_type)
> > > > > > > +{
> > > > > > > +       if (bdaddr_type =3D=3D BDADDR_BREDR)
> > > > > > > +               device->bredr_state.bonded =3D false;
> > > > > > > +       else
> > > > > > > +               device->le_state.bonded =3D false;
> > > > > > > +
> > > > > > > +       btd_adapter_remove_bonding(device->adapter, &device->=
bdaddr,
> > > > > > > +                                                       bdadd=
r_type);
> > > > > > > +}
> > > > > > > +
> > > > > > >  static void device_remove_stored(struct btd_device *device)
> > > > > > >  {
> > > > > > >         char device_addr[18];
> > > > > > > @@ -4170,17 +4181,11 @@ static void device_remove_stored(stru=
ct btd_device *device)
> > > > > > >         char *data;
> > > > > > >         gsize length =3D 0;
> > > > > > >
> > > > > > > -       if (device->bredr_state.bonded) {
> > > > > > > -               device->bredr_state.bonded =3D false;
> > > > > > > -               btd_adapter_remove_bonding(device->adapter, &=
device->bdaddr,
> > > > > > > -                                                            =
   BDADDR_BREDR);
> > > > > > > -       }
> > > > > > > +       if (device->bredr_state.bonded)
> > > > > > > +               device_remove_bonding(device, BDADDR_BREDR);
> > > > > > >
> > > > > > > -       if (device->le_state.bonded) {
> > > > > > > -               device->le_state.bonded =3D false;
> > > > > > > -               btd_adapter_remove_bonding(device->adapter, &=
device->bdaddr,
> > > > > > > -                                                       devic=
e->bdaddr_type);
> > > > > > > -       }
> > > > > > > +       if (device->le_state.bonded)
> > > > > > > +               device_remove_bonding(device, device->bdaddr_=
type);
> > > > > > >
> > > > > > >         device->bredr_state.paired =3D false;
> > > > > > >         device->le_state.paired =3D false;
> > > > > > > diff --git a/src/device.h b/src/device.h
> > > > > > > index 06b100499..907c7c5c4 100644
> > > > > > > --- a/src/device.h
> > > > > > > +++ b/src/device.h
> > > > > > > @@ -49,6 +49,7 @@ uint16_t btd_device_get_vendor(struct btd_d=
evice *device);
> > > > > > >  uint16_t btd_device_get_vendor_src(struct btd_device *device=
);
> > > > > > >  uint16_t btd_device_get_product(struct btd_device *device);
> > > > > > >  uint16_t btd_device_get_version(struct btd_device *device);
> > > > > > > +void device_remove_bonding(struct btd_device *device, uint8_=
t bdaddr_type);
> > > > > > >  void device_remove(struct btd_device *device, gboolean remov=
e_stored);
> > > > > >
> > > > > > Is there any particular reason why device_remove is not enough =
here? I
> > > > > > don't see any reason to leave the device object around after re=
moving
> > > > > > its bonding.
> > > > > >
> > > > > > >  int device_address_cmp(gconstpointer a, gconstpointer b);
> > > > > > >  int device_bdaddr_cmp(gconstpointer a, gconstpointer b);
> > > > > > > --
> > > > > > > 2.27.0.212.ge8ba1cc988-goog
> > > > > > >
> > > > > >
> > > > > >
> > > > > > --
> > > > > > Luiz Augusto von Dentz
> > > >
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
