Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76BC3C0015E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Aug 2023 19:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbjHITyU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Aug 2023 15:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjHITyO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Aug 2023 15:54:14 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632642702
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Aug 2023 12:54:11 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b9b904bb04so3301391fa.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Aug 2023 12:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691610849; x=1692215649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vc/W092M6+kuc4jWBVpdsrvge2BuVWRjg6X6n6lVJlE=;
        b=JLplb8ZXxtOQs+SVHkpwF5zShY1ByeYbVxT0WBclWbtFtlfhsz7wL8gxnu6GsMFqG1
         1kW2pKp+5kmvGnHIBJd3euQdartdJff1rLwa4ZoNgHn3hGbq3wMwAERHHSz7jACtTkCk
         nou0yuSfrsc0X2Phvg1obinP1vwZye4L0dwstwv7ghbgiKhjtEzb+zqpRDTheKSpSagm
         x3GXfOtGC3/+ITbtzhvTLGPVRsCp16kRW1F+FxLGA2dQb0ZlqLHqXTmr4aZX7hou3woy
         I/i2lCAYeD/ROZLl6x5aZJNFgG3Hi7MeB4ijsLltQWInPfZo08LmOgpE3o8cjwJOl/C6
         aajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691610849; x=1692215649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vc/W092M6+kuc4jWBVpdsrvge2BuVWRjg6X6n6lVJlE=;
        b=ZmA4WD2AZubiTZxmPzmk8jwl6dHVqG/QB9cLa4SQ8Fe2ZcvoHmZO+4dFP/pY/kshWc
         74KQ7umRWPeq0An9Mv+CjbeNXiA/r76GBc5fhZoizV7BKDwnbaZaqTZzMACX2Oaxq9bL
         FhZ1H9a6wMxgdF0m1GzHOHb0MUOm3lyMoX0Pk6ImpRpTF7sOJFvRlGHFqLSzl9Pju3Ja
         Noukj6Jx3Y5kJZ5CKgFd+nRoZL1MA4Xdacz5mL81uMLQwxGNfIWuRoapm+GWVeMYaU5b
         ewaDS6JPhwjloqVt9EWPKjvao0kn5x2GNFz84Q1JP/bRfxXSlG0RjANTG4nGiACVbuj1
         mNCA==
X-Gm-Message-State: AOJu0YwvnDdhTiz353wJBufyT3iSsHsF17XRyj2vcGMJigbYMIHVCw+t
        ZOXhATN/PHEe7vlZzcXPUGbfye10UdZ3xeNSNunTTPhlrSo=
X-Google-Smtp-Source: AGHT+IFquObXmYz5dIe63xRbETCr1XQvYrv0wgVs8wazdQHt7SAfkYnVxxLp6J6Q/GbZqZbzhVzukulRDjtHNyNBN7U=
X-Received: by 2002:a2e:9b4c:0:b0:2b9:a6a1:f12 with SMTP id
 o12-20020a2e9b4c000000b002b9a6a10f12mr161215ljj.43.1691610849259; Wed, 09 Aug
 2023 12:54:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230802201538.584029-1-luiz.dentz@gmail.com> <4e26a59c2ba25be76f96aa1806ab2132f5f7e069.camel@iki.fi>
 <CABBYNZKLr1WBtC9ex+1eWTRnJrRmxPDMtv+NgWXGdPYi1umyaw@mail.gmail.com> <ebdfab0c68842c48d5f2dc481d07a7205df291dd.camel@iki.fi>
In-Reply-To: <ebdfab0c68842c48d5f2dc481d07a7205df291dd.camel@iki.fi>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 9 Aug 2023 12:53:57 -0700
Message-ID: <CABBYNZJ=XWhsTsU-kUyurPXM0=oUf7K7F38makP+1htkmmV1nQ@mail.gmail.com>
Subject: Re: [BlueZ RFC] profile: Add probe_on_discover flag
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

On Wed, Aug 9, 2023 at 12:39=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi Luiz,
>
> ke, 2023-08-09 kello 12:17 -0700, Luiz Augusto von Dentz kirjoitti:
> > Hi Pauli,
> >
> > On Wed, Aug 9, 2023 at 11:31=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wro=
te:
> > >
> > > Hi Luiz,
> > >
> > > ke, 2023-08-02 kello 13:15 -0700, Luiz Augusto von Dentz kirjoitti:
> > > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > >
> > > > This adds probe_on_discover flag which indicates if profile needs t=
o be
> > > > probed when the remote_uuid is discovered and changes device logic =
to
> > > > attempt to probe driver when a new UUID is discovered and
> > > > probe_on_discover is set.
> > > > ---
> > > >  src/device.c  | 22 +++++++++++++++++-----
> > > >  src/profile.h |  5 +++++
> > > >  2 files changed, 22 insertions(+), 5 deletions(-)
> > >
> > > Note this seems to break (unicast) BAP for me, bap_probe does not see=
m
> > > to be called any more on the devices.
> >
> > On master?
>
> Yes, at 3370c462552b0 I have on bluetoothd startup
>
> elo 09 22:35:02 fedora bluetoothd[2611]: src/adapter.c:load_irks() hci0 i=
rks 2
> elo 09 22:35:02 fedora bluetoothd[2611]: src/adapter.c:load_conn_params()=
 hci0 conn params 2
> elo 09 22:35:02 fedora bluetoothd[2611]: src/device.c:device_probe_profil=
es() Probing profiles for device 28:3D:C2:4A:7D:2A
> elo 09 22:35:02 fedora bluetoothd[2611]: profiles/audio/csip.c:csip_probe=
() 28:3D:C2:4A:7D:2A
> elo 09 22:35:02 fedora bluetoothd[2611]: profiles/audio/csip.c:csip_data_=
add() data 0x603000018250
> elo 09 22:35:02 fedora bluetoothd[2611]: src/service.c:change_state() 0x6=
0400000b1d0: device 28:3D:C2:4A:7D:2A profile csip state changed: unavailab=
le -> disconnected (0)
> elo 09 22:35:02 fedora bluetoothd[2611]: profiles/audio/bass.c:bass_probe=
() 28:3D:C2:4A:7D:2A
> elo 09 22:35:02 fedora bluetoothd[2611]: profiles/audio/bass.c:bass_data_=
add() data 0x603000018310
> elo 09 22:35:02 fedora bluetoothd[2611]: src/service.c:change_state() 0x6=
0400000b210: device 28:3D:C2:4A:7D:2A profile bass state changed: unavailab=
le -> disconnected (0)
> elo 09 22:35:02 fedora bluetoothd[2611]: profiles/audio/bap.c:bap_probe()=
 28:3D:C2:4A:7D:2A
> elo 09 22:35:02 fedora bluetoothd[2611]: profiles/audio/bap.c:bap_data_ad=
d() data 0x60b000019060
> elo 09 22:35:02 fedora bluetoothd[2611]: src/service.c:change_state() 0x6=
0400000b250: device 28:3D:C2:4A:7D:2A profile bap state changed: unavailabl=
e -> disconnected (0)
> elo 09 22:35:02 fedora bluetoothd[2611]: profiles/battery/battery.c:batt_=
probe() BATT profile probe (28:3D:C2:4A:7D:2A)
> elo 09 22:35:02 fedora bluetoothd[2611]: src/service.c:change_state() 0x6=
0400000b310: device 28:3D:C2:4A:7D:2A profile batt-profile state changed: u=
navailable -> disconnected (0)
> elo 09 22:35:02 fedora bluetoothd[2611]: src/service.c:change_state() 0x6=
0400000b350: device 28:3D:C2:4A:7D:2A profile deviceinfo state changed: una=
vailable -> disconnected (0)
> elo 09 22:35:02 fedora bluetoothd[2611]: profiles/gap/gas.c:gap_probe() G=
AP profile probe (28:3D:C2:4A:7D:2A)
> elo 09 22:35:02 fedora bluetoothd[2611]: src/service.c:change_state() 0x6=
0400000b390: device 28:3D:C2:4A:7D:2A profile gap-profile state changed: un=
available -> disconnected (0)
> elo 09 22:35:02 fedora bluetoothd[2611]: src/device.c:device_probe_profil=
es() Probing profiles for device 28:3D:C2:4A:7E:DA
> ...
>
> but at 67a26abe53bf it becomes
>
> elo 09 22:37:00 fedora bluetoothd[2861]: src/adapter.c:load_irks() hci0 i=
rks 2
> elo 09 22:37:00 fedora bluetoothd[2861]: src/adapter.c:load_conn_params()=
 hci0 conn params 2
> elo 09 22:37:00 fedora bluetoothd[2861]: src/device.c:device_probe_profil=
es() Probing profiles for device 28:3D:C2:4A:7D:2A
> elo 09 22:37:00 fedora bluetoothd[2861]: src/device.c:device_probe_profil=
es() Probing profiles for device 28:3D:C2:4A:7E:DA
>
> The device is not connected at this point, but it also doesn't probe
> the profiles when connecting.

Yep, seems like we should be checking if the device is temporary
rather than connected:

https://patchwork.kernel.org/project/bluetooth/patch/20230809194620.1595792=
-1-luiz.dentz@gmail.com/

> >
> > > Previously it is called immediately on bluetoothd start, not clear if
> > > that is how it should be.
> >
> > It should be probed as per usual, so there might be a bug with it then.
> >
> > > >
> > > > diff --git a/src/device.c b/src/device.c
> > > > index b43ced8b5c91..19ae03f7d98a 100644
> > > > --- a/src/device.c
> > > > +++ b/src/device.c
> > > > @@ -2156,7 +2156,7 @@ done:
> > > >  void device_add_eir_uuids(struct btd_device *dev, GSList *uuids)
> > > >  {
> > > >       GSList *l;
> > > > -     bool added =3D false;
> > > > +     GSList *added =3D NULL;
> > > >
> > > >       if (dev->bredr_state.svc_resolved || dev->le_state.svc_resolv=
ed)
> > > >               return;
> > > > @@ -2165,13 +2165,11 @@ void device_add_eir_uuids(struct btd_device=
 *dev, GSList *uuids)
> > > >               const char *str =3D l->data;
> > > >               if (g_slist_find_custom(dev->eir_uuids, str, bt_uuid_=
strcmp))
> > > >                       continue;
> > > > -             added =3D true;
> > > > +             added =3D g_slist_append(added, (void *)str);
> > > >               dev->eir_uuids =3D g_slist_append(dev->eir_uuids, g_s=
trdup(str));
> > > >       }
> > > >
> > > > -     if (added)
> > > > -             g_dbus_emit_property_changed(dbus_conn, dev->path,
> > > > -                                             DEVICE_INTERFACE, "UU=
IDs");
> > > > +     device_probe_profiles(dev, added);
> > > >  }
> > > >
> > > >  static void add_manufacturer_data(void *data, void *user_data)
> > > > @@ -2201,6 +2199,7 @@ static void add_service_data(void *data, void=
 *user_data)
> > > >       struct eir_sd *sd =3D data;
> > > >       struct btd_device *dev =3D user_data;
> > > >       bt_uuid_t uuid;
> > > > +     GSList *l;
> > > >
> > > >       if (bt_string_to_uuid(&uuid, sd->uuid) < 0)
> > > >               return;
> > > > @@ -2208,6 +2207,10 @@ static void add_service_data(void *data, voi=
d *user_data)
> > > >       if (!bt_ad_add_service_data(dev->ad, &uuid, sd->data, sd->dat=
a_len))
> > > >               return;
> > > >
> > > > +     l =3D g_slist_append(NULL, sd->uuid);
> > > > +     device_add_eir_uuids(dev, l);
> > > > +     g_slist_free(l);
> > > > +
> > > >       g_dbus_emit_property_changed(dbus_conn, dev->path,
> > > >                                       DEVICE_INTERFACE, "ServiceDat=
a");
> > > >  }
> > > > @@ -3930,6 +3933,12 @@ static bool device_match_profile(struct btd_=
device *device,
> > > >       if (profile->remote_uuid =3D=3D NULL)
> > > >               return false;
> > > >
> > > > +     /* Don't match if device was just discovered (not connected) =
and the
> > > > +      * profile don't have probe_on_discover flag set.
> > > > +      */
> > > > +     if (!btd_device_is_connected(device) && !profile->probe_on_di=
scover)
> > > > +             return false;
> > > > +
> > > >       if (g_slist_find_custom(uuids, profile->remote_uuid,
> > > >                                                       bt_uuid_strcm=
p) =3D=3D NULL)
> > > >               return false;
> > > > @@ -4884,6 +4893,9 @@ void device_probe_profiles(struct btd_device =
*device, GSList *uuids)
> > > >       struct probe_data d =3D { device, uuids };
> > > >       char addr[18];
> > > >
> > > > +     if (!uuids)
> > > > +             return;
> > > > +
> > > >       ba2str(&device->bdaddr, addr);
> > > >
> > > >       if (device->blocked) {
> > > > diff --git a/src/profile.h b/src/profile.h
> > > > index 6871f2f0d7d8..cfc50058812d 100644
> > > > --- a/src/profile.h
> > > > +++ b/src/profile.h
> > > > @@ -33,6 +33,11 @@ struct btd_profile {
> > > >        */
> > > >       bool experimental;
> > > >
> > > > +     /* Indicates the profile needs to be probed when the remote_u=
uid is
> > > > +      * discovered.
> > > > +      */
> > > > +     bool probe_on_discover;
> > > > +
> > > >       int (*device_probe) (struct btd_service *service);
> > > >       void (*device_remove) (struct btd_service *service);
> > > >
> > >
> >
> >
>


--=20
Luiz Augusto von Dentz
