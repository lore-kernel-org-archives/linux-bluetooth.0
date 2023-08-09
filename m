Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74326C001B0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Aug 2023 19:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbjHITkF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Aug 2023 15:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233406AbjHITkE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Aug 2023 15:40:04 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D900F2691
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Aug 2023 12:39:50 -0700 (PDT)
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:4::a04d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav@iki.fi)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4RLgPJ2xrtz49Q3Q;
        Wed,  9 Aug 2023 22:39:48 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1691609988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jHWGFrUbBJ90GD08f0ZQZrJZY3XUYaN06BncOShKI5w=;
        b=vYafqazgd7GdgmPCRbegalGwB+wPgQ0VnJNs5ZcwMuBPtSbVOSqBNCO/+lLsY7gJxMOXJe
        v9ltM3CiehwPCZRY0j/sd2S/nB2LTsEXrAYWwVa+j39kCLLiQPOQSLp5uA4sHuPq7YPp/U
        CxC4yJg2qtka3kEq/ae/cggTwjYFqOLRaIY+VVINMexL+nil84WFd1izgDBqVkFmydyp3r
        LkiJ9q+4k4yO7AABJ8cyIbZ+FtxMviSGm1MdS5O/6bV9ZXLlhceIvoHB7/tipo1BU2zhEb
        /2v12Uu+YAoWVDjC6gXiX1KTLJqiIM1S1ZTDxlKTN6zpabrDIpgpdgQh5hUecQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1691609988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jHWGFrUbBJ90GD08f0ZQZrJZY3XUYaN06BncOShKI5w=;
        b=WqFIuWPjNrkKWrv/qZ7B3cIq7PWJ5LTMKzrecxQ+eqH/o22KqkpwcpAaDldisGL5jRBCMu
        6SNVhSBpOnEVJqcAaVvHKxFqj4ixi3MVNTOAB7H0ZVYhhAIqv41CDdZdAigGtHDIw1eKXn
        mtDhQkoK9RzdwPGTOh6LNok4kV9lAMrHfHLjmp08W5QBmZk+HKzoMrPApiiNL/h0aSXMW7
        hqhshm/JwR9Ay4ZvwZDxAhU8T3bsNzsOQ1tA+7R8W0lR1dSI/ffDYudKbqYyBO6MWEr37T
        /x7Kl6iTRIsL5CWBSQWDohNlyCJKsXNDKbCY5V2An3aL/0y8y4haPAKXGjBFwg==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1691609988; a=rsa-sha256;
        cv=none;
        b=e9uLLlv9eOMECgkGDu7Ys0DPhsuZP2Pjwa8572+WXaIz6npuFkyspvmi4Hw0SLxuCB/jBy
        /EewhFz1XU5LnxA3mJwTfJuiICL3gD6dCMTXU0mpowyDUJ2HFA4OzbWGhJWh/hMHhuZQ2/
        etwamxFsH3c1VvaVaBMAW5E30gwHUQtYaZ1g8OhVw+5xCGku+BETnr+UoQQEvphfTcTFsD
        BXFR4IeReLLcPaSDdcs7Av5HRwRQ/8lK6CmMTRcCflfZAxD7JxbM2cTChqZRk4aUNNV1g4
        AsEKM8SCS9aB22klEiswRMvDwqp2t6e/Nx3p4v5vQUbCH5D4nl2nKJTsO1Rl8g==
Message-ID: <ebdfab0c68842c48d5f2dc481d07a7205df291dd.camel@iki.fi>
Subject: Re: [BlueZ RFC] profile: Add probe_on_discover flag
From:   Pauli Virtanen <pav@iki.fi>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Date:   Wed, 09 Aug 2023 22:39:47 +0300
In-Reply-To: <CABBYNZKLr1WBtC9ex+1eWTRnJrRmxPDMtv+NgWXGdPYi1umyaw@mail.gmail.com>
References: <20230802201538.584029-1-luiz.dentz@gmail.com>
         <4e26a59c2ba25be76f96aa1806ab2132f5f7e069.camel@iki.fi>
         <CABBYNZKLr1WBtC9ex+1eWTRnJrRmxPDMtv+NgWXGdPYi1umyaw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

ke, 2023-08-09 kello 12:17 -0700, Luiz Augusto von Dentz kirjoitti:
> Hi Pauli,
>=20
> On Wed, Aug 9, 2023 at 11:31=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote=
:
> >=20
> > Hi Luiz,
> >=20
> > ke, 2023-08-02 kello 13:15 -0700, Luiz Augusto von Dentz kirjoitti:
> > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > >=20
> > > This adds probe_on_discover flag which indicates if profile needs to =
be
> > > probed when the remote_uuid is discovered and changes device logic to
> > > attempt to probe driver when a new UUID is discovered and
> > > probe_on_discover is set.
> > > ---
> > >  src/device.c  | 22 +++++++++++++++++-----
> > >  src/profile.h |  5 +++++
> > >  2 files changed, 22 insertions(+), 5 deletions(-)
> >=20
> > Note this seems to break (unicast) BAP for me, bap_probe does not seem
> > to be called any more on the devices.
>=20
> On master?

Yes, at 3370c462552b0 I have on bluetoothd startup

elo 09 22:35:02 fedora bluetoothd[2611]: src/adapter.c:load_irks() hci0 irk=
s 2
elo 09 22:35:02 fedora bluetoothd[2611]: src/adapter.c:load_conn_params() h=
ci0 conn params 2
elo 09 22:35:02 fedora bluetoothd[2611]: src/device.c:device_probe_profiles=
() Probing profiles for device 28:3D:C2:4A:7D:2A
elo 09 22:35:02 fedora bluetoothd[2611]: profiles/audio/csip.c:csip_probe()=
 28:3D:C2:4A:7D:2A
elo 09 22:35:02 fedora bluetoothd[2611]: profiles/audio/csip.c:csip_data_ad=
d() data 0x603000018250
elo 09 22:35:02 fedora bluetoothd[2611]: src/service.c:change_state() 0x604=
00000b1d0: device 28:3D:C2:4A:7D:2A profile csip state changed: unavailable=
 -> disconnected (0)
elo 09 22:35:02 fedora bluetoothd[2611]: profiles/audio/bass.c:bass_probe()=
 28:3D:C2:4A:7D:2A
elo 09 22:35:02 fedora bluetoothd[2611]: profiles/audio/bass.c:bass_data_ad=
d() data 0x603000018310
elo 09 22:35:02 fedora bluetoothd[2611]: src/service.c:change_state() 0x604=
00000b210: device 28:3D:C2:4A:7D:2A profile bass state changed: unavailable=
 -> disconnected (0)
elo 09 22:35:02 fedora bluetoothd[2611]: profiles/audio/bap.c:bap_probe() 2=
8:3D:C2:4A:7D:2A
elo 09 22:35:02 fedora bluetoothd[2611]: profiles/audio/bap.c:bap_data_add(=
) data 0x60b000019060
elo 09 22:35:02 fedora bluetoothd[2611]: src/service.c:change_state() 0x604=
00000b250: device 28:3D:C2:4A:7D:2A profile bap state changed: unavailable =
-> disconnected (0)
elo 09 22:35:02 fedora bluetoothd[2611]: profiles/battery/battery.c:batt_pr=
obe() BATT profile probe (28:3D:C2:4A:7D:2A)
elo 09 22:35:02 fedora bluetoothd[2611]: src/service.c:change_state() 0x604=
00000b310: device 28:3D:C2:4A:7D:2A profile batt-profile state changed: una=
vailable -> disconnected (0)
elo 09 22:35:02 fedora bluetoothd[2611]: src/service.c:change_state() 0x604=
00000b350: device 28:3D:C2:4A:7D:2A profile deviceinfo state changed: unava=
ilable -> disconnected (0)
elo 09 22:35:02 fedora bluetoothd[2611]: profiles/gap/gas.c:gap_probe() GAP=
 profile probe (28:3D:C2:4A:7D:2A)
elo 09 22:35:02 fedora bluetoothd[2611]: src/service.c:change_state() 0x604=
00000b390: device 28:3D:C2:4A:7D:2A profile gap-profile state changed: unav=
ailable -> disconnected (0)
elo 09 22:35:02 fedora bluetoothd[2611]: src/device.c:device_probe_profiles=
() Probing profiles for device 28:3D:C2:4A:7E:DA
...

but at 67a26abe53bf it becomes

elo 09 22:37:00 fedora bluetoothd[2861]: src/adapter.c:load_irks() hci0 irk=
s 2
elo 09 22:37:00 fedora bluetoothd[2861]: src/adapter.c:load_conn_params() h=
ci0 conn params 2
elo 09 22:37:00 fedora bluetoothd[2861]: src/device.c:device_probe_profiles=
() Probing profiles for device 28:3D:C2:4A:7D:2A
elo 09 22:37:00 fedora bluetoothd[2861]: src/device.c:device_probe_profiles=
() Probing profiles for device 28:3D:C2:4A:7E:DA

The device is not connected at this point, but it also doesn't probe
the profiles when connecting.

>=20
> > Previously it is called immediately on bluetoothd start, not clear if
> > that is how it should be.
>=20
> It should be probed as per usual, so there might be a bug with it then.
>=20
> > >=20
> > > diff --git a/src/device.c b/src/device.c
> > > index b43ced8b5c91..19ae03f7d98a 100644
> > > --- a/src/device.c
> > > +++ b/src/device.c
> > > @@ -2156,7 +2156,7 @@ done:
> > >  void device_add_eir_uuids(struct btd_device *dev, GSList *uuids)
> > >  {
> > >       GSList *l;
> > > -     bool added =3D false;
> > > +     GSList *added =3D NULL;
> > >=20
> > >       if (dev->bredr_state.svc_resolved || dev->le_state.svc_resolved=
)
> > >               return;
> > > @@ -2165,13 +2165,11 @@ void device_add_eir_uuids(struct btd_device *=
dev, GSList *uuids)
> > >               const char *str =3D l->data;
> > >               if (g_slist_find_custom(dev->eir_uuids, str, bt_uuid_st=
rcmp))
> > >                       continue;
> > > -             added =3D true;
> > > +             added =3D g_slist_append(added, (void *)str);
> > >               dev->eir_uuids =3D g_slist_append(dev->eir_uuids, g_str=
dup(str));
> > >       }
> > >=20
> > > -     if (added)
> > > -             g_dbus_emit_property_changed(dbus_conn, dev->path,
> > > -                                             DEVICE_INTERFACE, "UUID=
s");
> > > +     device_probe_profiles(dev, added);
> > >  }
> > >=20
> > >  static void add_manufacturer_data(void *data, void *user_data)
> > > @@ -2201,6 +2199,7 @@ static void add_service_data(void *data, void *=
user_data)
> > >       struct eir_sd *sd =3D data;
> > >       struct btd_device *dev =3D user_data;
> > >       bt_uuid_t uuid;
> > > +     GSList *l;
> > >=20
> > >       if (bt_string_to_uuid(&uuid, sd->uuid) < 0)
> > >               return;
> > > @@ -2208,6 +2207,10 @@ static void add_service_data(void *data, void =
*user_data)
> > >       if (!bt_ad_add_service_data(dev->ad, &uuid, sd->data, sd->data_=
len))
> > >               return;
> > >=20
> > > +     l =3D g_slist_append(NULL, sd->uuid);
> > > +     device_add_eir_uuids(dev, l);
> > > +     g_slist_free(l);
> > > +
> > >       g_dbus_emit_property_changed(dbus_conn, dev->path,
> > >                                       DEVICE_INTERFACE, "ServiceData"=
);
> > >  }
> > > @@ -3930,6 +3933,12 @@ static bool device_match_profile(struct btd_de=
vice *device,
> > >       if (profile->remote_uuid =3D=3D NULL)
> > >               return false;
> > >=20
> > > +     /* Don't match if device was just discovered (not connected) an=
d the
> > > +      * profile don't have probe_on_discover flag set.
> > > +      */
> > > +     if (!btd_device_is_connected(device) && !profile->probe_on_disc=
over)
> > > +             return false;
> > > +
> > >       if (g_slist_find_custom(uuids, profile->remote_uuid,
> > >                                                       bt_uuid_strcmp)=
 =3D=3D NULL)
> > >               return false;
> > > @@ -4884,6 +4893,9 @@ void device_probe_profiles(struct btd_device *d=
evice, GSList *uuids)
> > >       struct probe_data d =3D { device, uuids };
> > >       char addr[18];
> > >=20
> > > +     if (!uuids)
> > > +             return;
> > > +
> > >       ba2str(&device->bdaddr, addr);
> > >=20
> > >       if (device->blocked) {
> > > diff --git a/src/profile.h b/src/profile.h
> > > index 6871f2f0d7d8..cfc50058812d 100644
> > > --- a/src/profile.h
> > > +++ b/src/profile.h
> > > @@ -33,6 +33,11 @@ struct btd_profile {
> > >        */
> > >       bool experimental;
> > >=20
> > > +     /* Indicates the profile needs to be probed when the remote_uui=
d is
> > > +      * discovered.
> > > +      */
> > > +     bool probe_on_discover;
> > > +
> > >       int (*device_probe) (struct btd_service *service);
> > >       void (*device_remove) (struct btd_service *service);
> > >=20
> >=20
>=20
>=20

