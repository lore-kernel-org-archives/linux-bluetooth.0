Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A9A0C0015E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Aug 2023 19:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbjHITSL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Aug 2023 15:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjHITSF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Aug 2023 15:18:05 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81490272B
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Aug 2023 12:17:57 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b9ab1725bbso2878031fa.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Aug 2023 12:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691608676; x=1692213476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8lkyFJOc1uqM2adjrXXcgPpgUZg3GNQ196fbKOUwia0=;
        b=R3Luyhz9VzfhVepxoPW2aBfB+eT1i4fsg+L3reorv/eDhiykrcOS1y6Aa0AyL54Ygy
         ZU6bv1IDu/FZ1Lstwia3DZrr7pJPdzrZAnvBGL93bnx0kmnBgNnrGwVrFCWuTV2imr+n
         Vr8liHgclcCn/cEUNYJ/aL5PuvU1wob3BOkKG5OdrR+FdPH9uJT0R7n6w2ptEBPTpdsY
         oOymgFB+vlxFDtgZ1n75MqQDuuqQVSO/Hw5JQbmoNwvYQdWtI7IRX4vgeVjM7RQX5/qQ
         KJTbvmA9SRQN8LVNQUakPQx9QLLphGvChYUrFOmOulYvqtgggxbYzGpEjGS0UIP/OAeg
         oY9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691608676; x=1692213476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8lkyFJOc1uqM2adjrXXcgPpgUZg3GNQ196fbKOUwia0=;
        b=Ia2+NgTvxvmgZS+NkJTHeKixlqN41jYECRy5YTiIMcWSh0Xf7pJ4akLv0o0604G0sH
         SvZfsrmYfMiKcbsSeEFmwIVE439X1Kjg07eNWS4RnaifhH7QNCSxqN+ETwGaE6oNVyGV
         KEhw8NyHYqT5kIeh66s5eqXrVm9XJxnGDFkCymccOPucf+HNsUyqJRRdL4YYBg96Tsvv
         OjsI7imEZUCnL/IabbSDLrf3sqj2+SwVjYUv+9iQikJ499BMtiI6jhatmAqrdm+Cd3bk
         GzOKPRH5PHMQkl9oxV9/Ymwk0asM5MvB0WRXKNBkV8UbUu8xa1BuEkB1Nk782k3dhC27
         8QsA==
X-Gm-Message-State: AOJu0YwpFRU6oHDm4eZLbqnbDaPPmuA0hc9SDpf0gAiTkHjhZUcMautF
        nA83WDblFR9/aAKcQpplj6jy67t276gQpMTAqvDfHKH8
X-Google-Smtp-Source: AGHT+IGe1WnFGhQjrHJEm2iCQ1bSmaIcSCQX0X9fja2Lu+8zaJi51LIaUxY6b0kfpLIBZGBLBJXwCx6FGUstFotLVps=
X-Received: by 2002:a2e:720d:0:b0:2b9:7513:3596 with SMTP id
 n13-20020a2e720d000000b002b975133596mr109730ljc.5.1691608675375; Wed, 09 Aug
 2023 12:17:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230802201538.584029-1-luiz.dentz@gmail.com> <4e26a59c2ba25be76f96aa1806ab2132f5f7e069.camel@iki.fi>
In-Reply-To: <4e26a59c2ba25be76f96aa1806ab2132f5f7e069.camel@iki.fi>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 9 Aug 2023 12:17:42 -0700
Message-ID: <CABBYNZKLr1WBtC9ex+1eWTRnJrRmxPDMtv+NgWXGdPYi1umyaw@mail.gmail.com>
Subject: Re: [BlueZ RFC] profile: Add probe_on_discover flag
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

On Wed, Aug 9, 2023 at 11:31=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi Luiz,
>
> ke, 2023-08-02 kello 13:15 -0700, Luiz Augusto von Dentz kirjoitti:
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > This adds probe_on_discover flag which indicates if profile needs to be
> > probed when the remote_uuid is discovered and changes device logic to
> > attempt to probe driver when a new UUID is discovered and
> > probe_on_discover is set.
> > ---
> >  src/device.c  | 22 +++++++++++++++++-----
> >  src/profile.h |  5 +++++
> >  2 files changed, 22 insertions(+), 5 deletions(-)
>
> Note this seems to break (unicast) BAP for me, bap_probe does not seem
> to be called any more on the devices.

On master?

> Previously it is called immediately on bluetoothd start, not clear if
> that is how it should be.

It should be probed as per usual, so there might be a bug with it then.

> >
> > diff --git a/src/device.c b/src/device.c
> > index b43ced8b5c91..19ae03f7d98a 100644
> > --- a/src/device.c
> > +++ b/src/device.c
> > @@ -2156,7 +2156,7 @@ done:
> >  void device_add_eir_uuids(struct btd_device *dev, GSList *uuids)
> >  {
> >       GSList *l;
> > -     bool added =3D false;
> > +     GSList *added =3D NULL;
> >
> >       if (dev->bredr_state.svc_resolved || dev->le_state.svc_resolved)
> >               return;
> > @@ -2165,13 +2165,11 @@ void device_add_eir_uuids(struct btd_device *de=
v, GSList *uuids)
> >               const char *str =3D l->data;
> >               if (g_slist_find_custom(dev->eir_uuids, str, bt_uuid_strc=
mp))
> >                       continue;
> > -             added =3D true;
> > +             added =3D g_slist_append(added, (void *)str);
> >               dev->eir_uuids =3D g_slist_append(dev->eir_uuids, g_strdu=
p(str));
> >       }
> >
> > -     if (added)
> > -             g_dbus_emit_property_changed(dbus_conn, dev->path,
> > -                                             DEVICE_INTERFACE, "UUIDs"=
);
> > +     device_probe_profiles(dev, added);
> >  }
> >
> >  static void add_manufacturer_data(void *data, void *user_data)
> > @@ -2201,6 +2199,7 @@ static void add_service_data(void *data, void *us=
er_data)
> >       struct eir_sd *sd =3D data;
> >       struct btd_device *dev =3D user_data;
> >       bt_uuid_t uuid;
> > +     GSList *l;
> >
> >       if (bt_string_to_uuid(&uuid, sd->uuid) < 0)
> >               return;
> > @@ -2208,6 +2207,10 @@ static void add_service_data(void *data, void *u=
ser_data)
> >       if (!bt_ad_add_service_data(dev->ad, &uuid, sd->data, sd->data_le=
n))
> >               return;
> >
> > +     l =3D g_slist_append(NULL, sd->uuid);
> > +     device_add_eir_uuids(dev, l);
> > +     g_slist_free(l);
> > +
> >       g_dbus_emit_property_changed(dbus_conn, dev->path,
> >                                       DEVICE_INTERFACE, "ServiceData");
> >  }
> > @@ -3930,6 +3933,12 @@ static bool device_match_profile(struct btd_devi=
ce *device,
> >       if (profile->remote_uuid =3D=3D NULL)
> >               return false;
> >
> > +     /* Don't match if device was just discovered (not connected) and =
the
> > +      * profile don't have probe_on_discover flag set.
> > +      */
> > +     if (!btd_device_is_connected(device) && !profile->probe_on_discov=
er)
> > +             return false;
> > +
> >       if (g_slist_find_custom(uuids, profile->remote_uuid,
> >                                                       bt_uuid_strcmp) =
=3D=3D NULL)
> >               return false;
> > @@ -4884,6 +4893,9 @@ void device_probe_profiles(struct btd_device *dev=
ice, GSList *uuids)
> >       struct probe_data d =3D { device, uuids };
> >       char addr[18];
> >
> > +     if (!uuids)
> > +             return;
> > +
> >       ba2str(&device->bdaddr, addr);
> >
> >       if (device->blocked) {
> > diff --git a/src/profile.h b/src/profile.h
> > index 6871f2f0d7d8..cfc50058812d 100644
> > --- a/src/profile.h
> > +++ b/src/profile.h
> > @@ -33,6 +33,11 @@ struct btd_profile {
> >        */
> >       bool experimental;
> >
> > +     /* Indicates the profile needs to be probed when the remote_uuid =
is
> > +      * discovered.
> > +      */
> > +     bool probe_on_discover;
> > +
> >       int (*device_probe) (struct btd_service *service);
> >       void (*device_remove) (struct btd_service *service);
> >
>


--=20
Luiz Augusto von Dentz
