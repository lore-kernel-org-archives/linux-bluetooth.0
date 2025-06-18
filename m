Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF6A249E5
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Jun 2025 13:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750253123; cv=none; b=NEIE+cOy5fcO+sXHFYdm87ok7Il0hhy3/Ghiv+n/gIRawOIMY881rIDVDKsP/H8RNcBJu3MUgpCyOKZH+oup1euOJ3FA04v4ILRPEoIHJY90f5NOYGklnw7m8wWh4oL41X1rRmIi1RmROR0qaOOGCi62iiFE22iYidKRCajgLXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750253123; c=relaxed/simple;
	bh=ImHs2BN4Q5eu/xRFZ8RObrc/KIGyntMZ5S5XLv+4dyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RXFpzymtUR1nyYAH+4efCI7RURJ6hbuwI/rDJ4nflv+0QL3NbclOsBZVHId1FZOGtQkctH7GsbfFas13JDVyCysKrlDI7XLFLfPFmbrXyBGbNrF1MXF6GayOt0EC2oqJHO46jZJvvsxD7QzJ1oQiyWW3LDodTFVNRwGbh5GJIew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BjQeWkts; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjQeWkts"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-310447fe59aso73400101fa.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Jun 2025 06:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750253115; x=1750857915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VrujOoZn5ntsrPLm7SP899cZQY5l95ITy0+kX29RdAg=;
        b=BjQeWktsWKsTd6BjXuNMTkis1G1MVXE3zAJ1dq4WBjT6kCdKAU0sAO4TImZ+jQqZAJ
         spWZOfDFNmsswLEC5pagL9TItnetDCj5UZvl7546t/FQeaOXGaaNim2djTG9jgUOZXeU
         /8bJeMhE3+IsAqtMUFKNjIGuzU60ZVf1ksNGvqSZddmwncSecXFJraDRaTskgDMkD1/I
         qqwQ7Uiyz/xEje3kJTeHcGXh/Skz6xXnesdq0QarxcFWv7zi+Cq5TXkcmh2hi8hhZPwd
         cbSMmZS4vvEz9MJy8phDSwSVD7UdXnxWYVKCDjKIng+YE2XnSF1w6sImL3SwGyvukadc
         BOsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750253115; x=1750857915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VrujOoZn5ntsrPLm7SP899cZQY5l95ITy0+kX29RdAg=;
        b=w5aAECH8uaPyHSW0xguIhxhh8pnyYZAGrm8nRin3JvRDCuhLyhF8PS8XYLqlvm6TwO
         Hh4H95Ddq8t73CIJTDNRvLCG7IhwQyp6qTO9njw72bc1/39s89t/CPGrNqqAS99ZnHyA
         0XB3AopHomQU+121kwE6z8bVf3OD9Dv30I4OhRVNS8/e1SgbwMcxFyo2uCxfQqy81tGE
         eKfVX2V2Ax8hwzNsFyhJsCiuPYpd8LnAHqiGFQnXrx1Cq80LaPEQ9S1fd/KBHPgMB4ae
         5i9XEJV44F3i98IzmGAiUJ+7ibe/sO1syLy247TOoA3eiRJ+hg5wQgvFZX7hN8oCSuEs
         Bdmw==
X-Forwarded-Encrypted: i=1; AJvYcCWFnA6y4RIJjysZt8N4bfpjrxHXJfhsEUX69/JzxY4/Mzum9POqx7dN3oiFED4R7+5WXTPBMirP1kPTP2P04f4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnQhpzaEjBXqGoc1lhnB5yj1qi109P2rOr2C3qRjbHRirFGmsp
	e5dfekcba/XSD9YogYsk1ltNAEhCSWZXosjx9vzKrkgW4/nU97jXEB+eWmQ6tQZR8r0FHBnvfmD
	0L1Gl0aHiXu1vz2v19hA+5Cjdjg85BcPO6A==
X-Gm-Gg: ASbGncuvv05MtCuHS1SkA5cJvAC2XlsAsE7Lgrb1y8c+xjaaWDpFJ4VHKvlY5Z21xdC
	sscojT4fVJoUlRHOw8asV/9ASPhQay54DaKIjbZa5O9x+Ucj4Ucm6aWnwJsxnewuURvSiuD3Xnc
	7Zk/JWuy8ybSKFbdskR4ORm8qmgcm42Yz6GTUCfSrjiw==
X-Google-Smtp-Source: AGHT+IH2Bc35HLj6qBDK+jVI3xtp9llD3K5ArIJPhIM2o6FcZCoIItI+hjR7Ux4/buXK7FYs2zpEJz0/lxQ1Yph929Q=
X-Received: by 2002:a2e:a548:0:b0:32a:5fe2:81b2 with SMTP id
 38308e7fff4ca-32b4a4ac887mr54996871fa.23.1750253114874; Wed, 18 Jun 2025
 06:25:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618-device-bearer-level-conn-state-v1-1-dca5df09c0bd@amlogic.com>
 <d57fedd0a0889309c217e9e145d302ba8a5bac83.camel@hadess.net>
In-Reply-To: <d57fedd0a0889309c217e9e145d302ba8a5bac83.camel@hadess.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 18 Jun 2025 09:25:00 -0400
X-Gm-Features: AX0GCFuZKNhkFqv3R-JV6CWVeXFcQ-x5zNzDYjv_5oBZjHvCOR44OUppLT02MhY
Message-ID: <CABBYNZKQVNJJ7iSV=wv3iEgP8RRtK1uD4M_KBr+Lpzu7nh9Ngw@mail.gmail.com>
Subject: Re: [PATCH bluez] device: Add bearer info to Connected/Disconnected signals
To: Bastien Nocera <hadess@hadess.net>
Cc: ye.he@amlogic.com, Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bastien,

On Wed, Jun 18, 2025 at 4:09=E2=80=AFAM Bastien Nocera <hadess@hadess.net> =
wrote:
>
> On Wed, 2025-06-18 at 10:39 +0800, Ye He via B4 Relay wrote:
> > From: Ye He <ye.he@amlogic.com>
> >
> > This patch add a new Connected(string bearer) signal to indicate
> > which transport
> > (LE or BR/EDR) has connected. Also extend the Disconnected signal to
> > include
> > a bearer argument.
> >
> > This allows applications to distinguish transport-specific connection
> > events in dual-mode scenarios.
> >
> > Fixes: https://github.com/bluez/bluez/issues/1350
>
> This is an API change, the commit needs to explain when the
> Disconnected signal API was introduced, and probably mention that the
> because it was introduced in 5.82, it didn't have time to be used.
>
> It might also be a better idea for both signals to send out a
> dictionary of values, so that the "bearer" can be added without an API
> change, and further info can also be passed without an API change.

+1, I don't really like the idea of introducing bearer specific API
into Device interface, using dedicated interface is probably better to
avoid confusions and we can then introduce bearer specific methods and
properties as well.

> Cheers
>
> >
> > Signed-off-by: Ye He <ye.he@amlogic.com>
> > ---
> >  doc/org.bluez.Device.rst | 33 ++++++++++++++++++++++++++++++++-
> >  src/device.c             | 34 ++++++++++++++++++++++++++--------
> >  2 files changed, 58 insertions(+), 9 deletions(-)
> >
> > diff --git a/doc/org.bluez.Device.rst b/doc/org.bluez.Device.rst
> > index
> > 646e2c77ec2ddcbf7e6897336165d228c349fe00..1022402d95a1cd34dea88103ba6
> > 6fb06f3007de7 100644
> > --- a/doc/org.bluez.Device.rst
> > +++ b/doc/org.bluez.Device.rst
> > @@ -157,7 +157,26 @@ Possible errors:
> >  Signals
> >  -------
> >
> > -void Disconnected(string reason, string message)
> > +void Connected(string bearer)
> > +````````````````````````````````````````````````
> > +
> > +This signal is emitted when a device establishes a connection,
> > indicating the
> > +bearer (transport type) over which the connection occurred.
> > +
> > +Client applications may use this signal to take actions such as
> > stopping discovery
> > +or advertising, depending on their internal policy.
> > +
> > +Possible bearer:
> > +
> > +:"le":
> > +
> > +     LE transport is cconnected.
> > +
> > +:"bredr":
> > +
> > +     BR/EDR transport is connected.
> > +
> > +void Disconnected(string reason, string message, string bearer)
> >  ````````````````````````````````````````````````
> >
> >  This signal is launched when a device is disconnected, with the
> > reason of the
> > @@ -208,6 +227,18 @@ Possible reasons:
> >
> >       Connection terminated by local host for suspend.
> >
> > +The additional 'bearer' field indicates which transport was
> > disconnected.
> > +
> > +Possible bearer:
> > +
> > +:"le":
> > +
> > +     LE transport is disconnected.
> > +
> > +:"bredr":
> > +
> > +     BR/EDR transport is disconnected.
> > +
> >  Properties
> >  ----------
> >
> > diff --git a/src/device.c b/src/device.c
> > index
> > 902c4aa44d21eb89076eff3a47ffa727420967a8..ae6196eb2e5b6eca10a8e1c3360
> > b85023dcddec2 100644
> > --- a/src/device.c
> > +++ b/src/device.c
> > @@ -3491,8 +3491,10 @@ static const GDBusMethodTable device_methods[]
> > =3D {
> >  };
> >
> >  static const GDBusSignalTable device_signals[] =3D {
> > +     { GDBUS_SIGNAL("Connected",
> > +                     GDBUS_ARGS({ "bearer", "s" })) },
> >       { GDBUS_SIGNAL("Disconnected",
> > -                     GDBUS_ARGS({ "name", "s" }, { "message", "s"
> > })) },
> > +                     GDBUS_ARGS({ "name", "s" }, { "message", "s"
> > }, { "bearer", "s" })) },
> >       { }
> >  };
> >
> > @@ -3676,6 +3678,7 @@ void device_add_connection(struct btd_device
> > *dev, uint8_t bdaddr_type,
> >                                                       uint32_t
> > flags)
> >  {
> >       struct bearer_state *state =3D get_state(dev, bdaddr_type);
> > +     const char *bearer;
> >
> >       device_update_last_seen(dev, bdaddr_type, true);
> >       device_update_last_used(dev, bdaddr_type);
> > @@ -3691,14 +3694,22 @@ void device_add_connection(struct btd_device
> > *dev, uint8_t bdaddr_type,
> >       dev->conn_bdaddr_type =3D dev->bdaddr_type;
> >
> >       /* If this is the first connection over this bearer */
> > -     if (bdaddr_type =3D=3D BDADDR_BREDR)
> > +     if (bdaddr_type =3D=3D BDADDR_BREDR) {
> >               device_set_bredr_support(dev);
> > -     else
> > +             bearer =3D "bredr";
> > +     } else {
> >               device_set_le_support(dev, bdaddr_type);
> > +             bearer =3D "le";
> > +     }
> >
> >       state->connected =3D true;
> >       state->initiator =3D flags & BIT(3);
> >
> > +     g_dbus_emit_signal(dbus_conn, dev->path, DEVICE_INTERFACE,
> > +                             "Connected",
> > +                             DBUS_TYPE_STRING, &bearer,
> > +                             DBUS_TYPE_INVALID);
> > +
> >       if (dev->le_state.connected && dev->bredr_state.connected)
> >               return;
> >
> > @@ -3747,7 +3758,7 @@ static void set_temporary_timer(struct
> > btd_device *dev, unsigned int timeout)
> >                                                               dev,
> > NULL);
> >  }
> >
> > -static void device_disconnected(struct btd_device *device, uint8_t
> > reason)
> > +static void device_disconnected(struct btd_device *device, uint8_t
> > reason, const char *bearer)
> >  {
> >       const char *name;
> >       const char *message;
> > @@ -3787,6 +3798,7 @@ static void device_disconnected(struct
> > btd_device *device, uint8_t reason)
> >                                               "Disconnected",
> >                                               DBUS_TYPE_STRING,
> > &name,
> >                                               DBUS_TYPE_STRING,
> > &message,
> > +                                             DBUS_TYPE_STRING,
> > &bearer,
> >                                               DBUS_TYPE_INVALID);
> >  }
> >
> > @@ -3798,10 +3810,16 @@ void device_remove_connection(struct
> > btd_device *device, uint8_t bdaddr_type,
> >       DBusMessage *reply;
> >       bool remove_device =3D false;
> >       bool paired_status_updated =3D false;
> > +     const char *bearer;
> >
> >       if (!state->connected)
> >               return;
> >
> > +     if (bdaddr_type =3D=3D BDADDR_BREDR)
> > +             bearer =3D "bredr";
> > +     else
> > +             bearer =3D "le";
> > +
> >       state->connected =3D false;
> >       state->initiator =3D false;
> >       device->general_connect =3D FALSE;
> > @@ -3854,15 +3872,15 @@ void device_remove_connection(struct
> > btd_device *device, uint8_t bdaddr_type,
> >                                               DEVICE_INTERFACE,
> >                                               "Paired");
> >
> > -     if (device->bredr_state.connected || device-
> > >le_state.connected)
> > -             return;
> > -
> >       device_update_last_seen(device, bdaddr_type, true);
> >
> >       g_slist_free_full(device->eir_uuids, g_free);
> >       device->eir_uuids =3D NULL;
> >
> > -     device_disconnected(device, reason);
> > +     device_disconnected(device, reason, bearer);
> > +
> > +     if (device->bredr_state.connected || device-
> > >le_state.connected)
> > +             return;
> >
> >       g_dbus_emit_property_changed(dbus_conn, device->path,
> >                                               DEVICE_INTERFACE,
> > "Connected");
> >
> > ---
> > base-commit: dc8db3601001de9a085da063e0c5e456074b8963
> > change-id: 20250618-device-bearer-level-conn-state-3e29d56bda88
> >
> > Best regards,
>


--=20
Luiz Augusto von Dentz
