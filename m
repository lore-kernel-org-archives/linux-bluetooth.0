Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE3D246BCF
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Jun 2025 18:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750704572; cv=none; b=HTOS52t3qBESzsm8N+1/XZoFRLNQ/ROWttoxUWvposNVvRfcmPaPMp6p0xDrNh7+xrw3a6NIyulUMS4Z1Iw//t2QoPe+bzilakHsE0R8Rqkf6wauYhOjrQ7Sm03RgIEcQp1I5OvXArJsIa0OdEwzvyujnwh/GkUihUIPEKJHopk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750704572; c=relaxed/simple;
	bh=wb/92MUhm5uxineCIor2hgDq5XS/PuzDOWrPsMYv0o0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dSm9dc4rMwBp11eR0eogSo4EwmjwdLH7Fdcq6iXlnVilZy+XA9ZgQy2QjEQsB7AvsyaRkxt3JKqxL9bf9KcskhiL9gpv/FgUtPm6t/a+pIBTIX/U6SRUtUzWIYamaRBvJb/ne8i0SqsnTgTy9raZHCQwX78gA71VEHSWy2Nv8iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GzP3U3dO; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GzP3U3dO"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-32b7f41d3e6so40158221fa.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Jun 2025 11:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750704569; x=1751309369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H0jXfglPvh8FBC6ONvH/x0bf0x0uVjlvimQcBK63gBM=;
        b=GzP3U3dOdnC1phd5BEVt2Fz0tNDPZu8mNX9bnZ8OSKN7L4DDYH2JxkFLYKNFJerHKE
         NHT2+VN8q48pTwT0ea4BlyQ3ipE1Y0v5YwLaeU4YBGmxqm9KkNjUrUDF+ZU7j976FMqH
         KsLKOgI1LaExdLyjCmP5jEduFos6Hu3Kf5ThBiEiIyYrVNW3440YxgB0CjviStv+dZkI
         QYDLc0qEY3MSbq9LH1vxcKh2eaWD22lSjaqd2Y8HH0a5u4/XYMkf19B3r4lljAsyHGIo
         Ac9axzo9NTxieoGUUgRhKBjUeGPVEQvo1vRexOA046iQJ5akKRoYOKKz7nCPq9EX607Z
         3mqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750704569; x=1751309369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H0jXfglPvh8FBC6ONvH/x0bf0x0uVjlvimQcBK63gBM=;
        b=e0iDiSqTmU/fpGzyC5dm/3Q3YgRNdkPPVGJkoRUqoSITGyTRDLJSd+oHoG5wiV8oQk
         n94GXcF7LTS+D/jydHUhlTmmL4x5M1kVniuNMATdOcTB/1smuvlhBdmsYpR7CkLt622D
         YumSAL7mvGcYuZ5kuIFGuhQ4+bKTM2akGhIgkPrcVFKRqED1iAQY4bcCv45Lq8G005r5
         ebC5W6cMFGJjY8StYznLua24vuhMft5gFWisQkfJm7kr8eKaTS3oN6VhA2jTAyPLnRFU
         0nVGAFQQpbI9a6dpjDILVm8byHHc0fVAKM7C0/st1XqVeAf/Z4hYvf/9liIAXj9sG9c3
         V9Jg==
X-Forwarded-Encrypted: i=1; AJvYcCVf4b3kUcq5rgtdrPrxoebDYsJqCyje0v9um+OLbMnbniAT9se+Yynbtlyg3TJP8cKOjkuIM3rrlLLtY5JTKYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZwnkQ88d6OQ/2AXd91qDbtRY1Urci9I8H0EM18VVWrtLlYKFC
	Pe4Z1mBfwZOnb311i/TUR5xv/XEewgVVZa/j88ZFvXoegKKarRrDH9c3TINIdPJPpOfgdhZzpsd
	ioy4PpWRfE6tMd6xMI1EEgRLVstImfzGCWXhKd2k=
X-Gm-Gg: ASbGncuyZhUdifyrfU8nKOtoNr0KSFHuyv5jRaKrKJu4HLrinVLf9knzSB1bub/mtwp
	J9sBezvVpmiZpvOINBCe7ff0bQ+FKqPxKRKg/KzGfV/p6lEyzf1Xe/Ww0LEy4oCzll4QN/oyQHe
	U5unO37/n51hdfcVUKuzw0IRxD5tXLbE/Uw+59tvO0Iw==
X-Google-Smtp-Source: AGHT+IHoX4+ZNE8bVk9D/P91e+Oi984zNZ7bwrNRdfL8movZawx4INWeLiYRsULPnWFtQVFGIynqB5ckLOgj229X7eY=
X-Received: by 2002:a05:651c:31c:b0:32b:4441:e1a6 with SMTP id
 38308e7fff4ca-32cb958b46dmr1694371fa.1.1750704568288; Mon, 23 Jun 2025
 11:49:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618-device-bearer-level-conn-state-v1-1-dca5df09c0bd@amlogic.com>
 <d57fedd0a0889309c217e9e145d302ba8a5bac83.camel@hadess.net>
 <CABBYNZKQVNJJ7iSV=wv3iEgP8RRtK1uD4M_KBr+Lpzu7nh9Ngw@mail.gmail.com> <22da8fc4-f5e2-453b-9b45-5697732e9494@amlogic.com>
In-Reply-To: <22da8fc4-f5e2-453b-9b45-5697732e9494@amlogic.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 23 Jun 2025 14:49:15 -0400
X-Gm-Features: AX0GCFtJjetUdrGP_cssp9kN7tsLrQPyWxp16d9LUAafMtbnkJWmoZMu8gH7QO4
Message-ID: <CABBYNZJ6VMrk=Y8=fc_J_5uz1aK-7s-WXetdHVy1=6WeOUhFbg@mail.gmail.com>
Subject: Re: [PATCH bluez] device: Add bearer info to Connected/Disconnected signals
To: Ye He <ye.he@amlogic.com>
Cc: Bastien Nocera <hadess@hadess.net>, Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jun 18, 2025 at 11:12=E2=80=AFPM Ye He <ye.he@amlogic.com> wrote:
>
> Hi Luiz, Bastien
> > [ EXTERNAL EMAIL ]
> >
> > Hi Bastien,
> >
> > On Wed, Jun 18, 2025 at 4:09=E2=80=AFAM Bastien Nocera <hadess@hadess.n=
et> wrote:
> >> On Wed, 2025-06-18 at 10:39 +0800, Ye He via B4 Relay wrote:
> >>> From: Ye He <ye.he@amlogic.com>
> >>>
> >>> This patch add a new Connected(string bearer) signal to indicate
> >>> which transport
> >>> (LE or BR/EDR) has connected. Also extend the Disconnected signal to
> >>> include
> >>> a bearer argument.
> >>>
> >>> This allows applications to distinguish transport-specific connection
> >>> events in dual-mode scenarios.
> >>>
> >>> Fixes: https://github.com/bluez/bluez/issues/1350
> >> This is an API change, the commit needs to explain when the
> >> Disconnected signal API was introduced, and probably mention that the
> >> because it was introduced in 5.82, it didn't have time to be used.
> >>
> >> It might also be a better idea for both signals to send out a
> >> dictionary of values, so that the "bearer" can be added without an API
> >> change, and further info can also be passed without an API change.
> > +1, I don't really like the idea of introducing bearer specific API
> > into Device interface, using dedicated interface is probably better to
> > avoid confusions and we can then introduce bearer specific methods and
> > properties as well.
> Thanks for the feedback. I understand and agree with your point =E2=80=94
> introducing dedicated org.bluez.Device.LE and org.bluez.Device.BREDR
> interfaces would be a cleaner long term solution. It would certainly
> make the transport specific behavior more explicit and extensible.
>
> At the same time, this approach will be a significant change, requiring
> substantial refactoring and extensive testing across the stack. This may
> be too large an effort for a single contributor, and it would take some
> time to design, implement, and validate thoroughly.
>
> As an interim solution, I'd propose extending the existing Device1
> interface:
> -Adding the new Connected(string bearer) signal, which has no backward
> compatibility risk because it is a completely new signal.
> -Extending the Disconnected signal introduced in BlueZ 5.82 with an
> additional bearer parameter. Since this signal is very new, it's
> unlikely that any application depends on its original signature, so
> updating it now should have minimal impact.

Well, we would have to introduce this as an experimental API to only
then be removed later so this is sort of useless in the end.

> Then, as a next step, we can gradually work towards introducing
> dedicated Device.LE and Device.BREDR interfaces and migrating to that
> design when the community has enough bandwidth and agreement.

Id works towards Device.LE and Device.BREDR directly, just start with
the minimal, perhaps Connected property and Disconnected signal that
cover what you have worked, then we can start expanding it like adding
Connect/Disconnect methods, etc.

> Would this approach be acceptable?
> >> Cheers
> >>
> >>> Signed-off-by: Ye He <ye.he@amlogic.com>
> >>> ---
> >>>   doc/org.bluez.Device.rst | 33 ++++++++++++++++++++++++++++++++-
> >>>   src/device.c             | 34 ++++++++++++++++++++++++++--------
> >>>   2 files changed, 58 insertions(+), 9 deletions(-)
> >>>
> >>> diff --git a/doc/org.bluez.Device.rst b/doc/org.bluez.Device.rst
> >>> index
> >>> 646e2c77ec2ddcbf7e6897336165d228c349fe00..1022402d95a1cd34dea88103ba6
> >>> 6fb06f3007de7 100644
> >>> --- a/doc/org.bluez.Device.rst
> >>> +++ b/doc/org.bluez.Device.rst
> >>> @@ -157,7 +157,26 @@ Possible errors:
> >>>   Signals
> >>>   -------
> >>>
> >>> -void Disconnected(string reason, string message)
> >>> +void Connected(string bearer)
> >>> +````````````````````````````````````````````````
> >>> +
> >>> +This signal is emitted when a device establishes a connection,
> >>> indicating the
> >>> +bearer (transport type) over which the connection occurred.
> >>> +
> >>> +Client applications may use this signal to take actions such as
> >>> stopping discovery
> >>> +or advertising, depending on their internal policy.
> >>> +
> >>> +Possible bearer:
> >>> +
> >>> +:"le":
> >>> +
> >>> +     LE transport is cconnected.
> >>> +
> >>> +:"bredr":
> >>> +
> >>> +     BR/EDR transport is connected.
> >>> +
> >>> +void Disconnected(string reason, string message, string bearer)
> >>>   ````````````````````````````````````````````````
> >>>
> >>>   This signal is launched when a device is disconnected, with the
> >>> reason of the
> >>> @@ -208,6 +227,18 @@ Possible reasons:
> >>>
> >>>        Connection terminated by local host for suspend.
> >>>
> >>> +The additional 'bearer' field indicates which transport was
> >>> disconnected.
> >>> +
> >>> +Possible bearer:
> >>> +
> >>> +:"le":
> >>> +
> >>> +     LE transport is disconnected.
> >>> +
> >>> +:"bredr":
> >>> +
> >>> +     BR/EDR transport is disconnected.
> >>> +
> >>>   Properties
> >>>   ----------
> >>>
> >>> diff --git a/src/device.c b/src/device.c
> >>> index
> >>> 902c4aa44d21eb89076eff3a47ffa727420967a8..ae6196eb2e5b6eca10a8e1c3360
> >>> b85023dcddec2 100644
> >>> --- a/src/device.c
> >>> +++ b/src/device.c
> >>> @@ -3491,8 +3491,10 @@ static const GDBusMethodTable device_methods[]
> >>> =3D {
> >>>   };
> >>>
> >>>   static const GDBusSignalTable device_signals[] =3D {
> >>> +     { GDBUS_SIGNAL("Connected",
> >>> +                     GDBUS_ARGS({ "bearer", "s" })) },
> >>>        { GDBUS_SIGNAL("Disconnected",
> >>> -                     GDBUS_ARGS({ "name", "s" }, { "message", "s"
> >>> })) },
> >>> +                     GDBUS_ARGS({ "name", "s" }, { "message", "s"
> >>> }, { "bearer", "s" })) },
> >>>        { }
> >>>   };
> >>>
> >>> @@ -3676,6 +3678,7 @@ void device_add_connection(struct btd_device
> >>> *dev, uint8_t bdaddr_type,
> >>>                                                        uint32_t
> >>> flags)
> >>>   {
> >>>        struct bearer_state *state =3D get_state(dev, bdaddr_type);
> >>> +     const char *bearer;
> >>>
> >>>        device_update_last_seen(dev, bdaddr_type, true);
> >>>        device_update_last_used(dev, bdaddr_type);
> >>> @@ -3691,14 +3694,22 @@ void device_add_connection(struct btd_device
> >>> *dev, uint8_t bdaddr_type,
> >>>        dev->conn_bdaddr_type =3D dev->bdaddr_type;
> >>>
> >>>        /* If this is the first connection over this bearer */
> >>> -     if (bdaddr_type =3D=3D BDADDR_BREDR)
> >>> +     if (bdaddr_type =3D=3D BDADDR_BREDR) {
> >>>                device_set_bredr_support(dev);
> >>> -     else
> >>> +             bearer =3D "bredr";
> >>> +     } else {
> >>>                device_set_le_support(dev, bdaddr_type);
> >>> +             bearer =3D "le";
> >>> +     }
> >>>
> >>>        state->connected =3D true;
> >>>        state->initiator =3D flags & BIT(3);
> >>>
> >>> +     g_dbus_emit_signal(dbus_conn, dev->path, DEVICE_INTERFACE,
> >>> +                             "Connected",
> >>> +                             DBUS_TYPE_STRING, &bearer,
> >>> +                             DBUS_TYPE_INVALID);
> >>> +
> >>>        if (dev->le_state.connected && dev->bredr_state.connected)
> >>>                return;
> >>>
> >>> @@ -3747,7 +3758,7 @@ static void set_temporary_timer(struct
> >>> btd_device *dev, unsigned int timeout)
> >>>                                                                dev,
> >>> NULL);
> >>>   }
> >>>
> >>> -static void device_disconnected(struct btd_device *device, uint8_t
> >>> reason)
> >>> +static void device_disconnected(struct btd_device *device, uint8_t
> >>> reason, const char *bearer)
> >>>   {
> >>>        const char *name;
> >>>        const char *message;
> >>> @@ -3787,6 +3798,7 @@ static void device_disconnected(struct
> >>> btd_device *device, uint8_t reason)
> >>>                                                "Disconnected",
> >>>                                                DBUS_TYPE_STRING,
> >>> &name,
> >>>                                                DBUS_TYPE_STRING,
> >>> &message,
> >>> +                                             DBUS_TYPE_STRING,
> >>> &bearer,
> >>>                                                DBUS_TYPE_INVALID);
> >>>   }
> >>>
> >>> @@ -3798,10 +3810,16 @@ void device_remove_connection(struct
> >>> btd_device *device, uint8_t bdaddr_type,
> >>>        DBusMessage *reply;
> >>>        bool remove_device =3D false;
> >>>        bool paired_status_updated =3D false;
> >>> +     const char *bearer;
> >>>
> >>>        if (!state->connected)
> >>>                return;
> >>>
> >>> +     if (bdaddr_type =3D=3D BDADDR_BREDR)
> >>> +             bearer =3D "bredr";
> >>> +     else
> >>> +             bearer =3D "le";
> >>> +
> >>>        state->connected =3D false;
> >>>        state->initiator =3D false;
> >>>        device->general_connect =3D FALSE;
> >>> @@ -3854,15 +3872,15 @@ void device_remove_connection(struct
> >>> btd_device *device, uint8_t bdaddr_type,
> >>>                                                DEVICE_INTERFACE,
> >>>                                                "Paired");
> >>>
> >>> -     if (device->bredr_state.connected || device-
> >>>> le_state.connected)
> >>> -             return;
> >>> -
> >>>        device_update_last_seen(device, bdaddr_type, true);
> >>>
> >>>        g_slist_free_full(device->eir_uuids, g_free);
> >>>        device->eir_uuids =3D NULL;
> >>>
> >>> -     device_disconnected(device, reason);
> >>> +     device_disconnected(device, reason, bearer);
> >>> +
> >>> +     if (device->bredr_state.connected || device-
> >>>> le_state.connected)
> >>> +             return;
> >>>
> >>>        g_dbus_emit_property_changed(dbus_conn, device->path,
> >>>                                                DEVICE_INTERFACE,
> >>> "Connected");
> >>>
> >>> ---
> >>> base-commit: dc8db3601001de9a085da063e0c5e456074b8963
> >>> change-id: 20250618-device-bearer-level-conn-state-3e29d56bda88
> >>>
> >>> Best regards,
> >
> > --
> > Luiz Augusto von Dentz
>
>


--=20
Luiz Augusto von Dentz
