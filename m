Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF67E13633F
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Jun 2025 13:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750252736; cv=none; b=F1SMdBoqNRx4OSYdgPF/glYI0tt/6PMwiZTJ+T1xKwPZSGmqMLRkooDmkdzZLjKOl/AU/Iu4+rO+OwKp+iMbkiPIDG8mh0frfzIQbzqiFr88OViEPdPg8VbV8N450SWP9mTyz5JbPEKfQUDJ0GIpyENz06ZJanPlto2VFId9jbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750252736; c=relaxed/simple;
	bh=lvJjAZQXX6LRJce7iZ0wVrJjc6nQ7oysVdSc1qLQ7po=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uRDtlX8eqzfpP6X+0Eu8yUGn3nC050GVR4Pm1wtKuvVXZYCmgnuCrqBjWiEHm+umIcnrECk6jowOGcX7y+Q9uYcjZzWskfelJOzKTEIZW5GxZ5BAIlC4JtUHhZXUgHOSItVC2F9l6gpBZ93xsmN17MgGw1MnlRUXYJuqG33dwOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QIwbsDrG; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QIwbsDrG"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-32b5931037eso30589611fa.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Jun 2025 06:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750252732; x=1750857532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eID0HQ/1Xro0W2j92MJSYnoTXclDg+2QhHwvwPeuphU=;
        b=QIwbsDrGxf0ws4qYc0vTjlmBZTLW3+dNSS0t6O5K+elPAxd3H+wXagpIOspItt8Z76
         xI1cJdSxDv8O39YlD1yI3E7yuftiyidVVTq+SkD/FEJLO9G8NZIm/NhiisDCLqD2BJGZ
         AuD4t2tE+Sy53KDDA+bCRlvdfa+yvg/Mo2JgxB9KMLDnYqPEKIZnEEH4iYDFsg4VWI8r
         4UTNYDhNGxZYb9hPDK6Ln8VYCjVcBfs1CDUijxTpDlOhxMA1aNFDJp/cJfJTZmE476Wl
         cQs5rzEnCT5UTnULt6kcVW8hMwHtpdZJAwXtXf7QGJr5LhSVtDbMYp0jVuv9w1vR9hrM
         s5Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750252732; x=1750857532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eID0HQ/1Xro0W2j92MJSYnoTXclDg+2QhHwvwPeuphU=;
        b=ilhrkOzXbn88yWwOVFk5NSxI8I575+d9Pmq+5qZYpOUR9FXb+8A396CBkTCLdzKdB8
         0ET4BvVYQvwDceaM2B0vy1d+0Zkhi0VvE6acgxEgtvc5nNH9pjPHUIUSMIi8sfaBwj0N
         ux1ilZqsAUKWNZqNQeUaZys905KflwmKeuqwiiBOKoNPf6IUuBzfNk1rsPMLEZCWxNMh
         W2DTE0+JJQ8rVKjdzsN0YyU+0edjuZKtzsjMPlGSrUlzn2TUiNF3lc0psMqJ7kwkrpKo
         O+V1+7dOV4igcNg/Nm9pLPk0cVth60NzgQDz+aD4Y39eaEIBn/lyqTF0QYUzrg1Eug8Y
         ktMQ==
X-Gm-Message-State: AOJu0Yyy0oLPfhc93qvK0GsSxA9W6DxnXbyr0RxMN5VaFfMOp4O2c8T5
	Tga68PhM5Zs9PFGCqY/nPjDEkWbsUPxBxtrTxeq1m5c4xvHI/2rtq4K+25CVWKSsms/TcHmthm9
	ToOvBb9n1F060iokx8Khqr8FFQS3VpFrvoQ==
X-Gm-Gg: ASbGnctAfbG8geVes9cWt4n1jcVN5rKJkPg02s74DXZRO66PcZImfUjZHCVNqSVQq+r
	LP/QuXYgOXA/izmx7wSGwOG2JqXat3WTabxrzshJlV4/BqJOz8zDwkFsCbdqw6XX2wOHTJUgSQO
	bdC4c8LlImXJLXE77//qAik7kiiITuDV8FkkJ149O1VA==
X-Google-Smtp-Source: AGHT+IG1gv2/JtJLQh9ykATD8sBrrstpU4YhOBwZGIt8TgvSrlCCkjpfXijl7rsDkLMUaHDsqbLHDSkyJNaQNlms3A4=
X-Received: by 2002:a2e:bb9e:0:b0:30b:f52d:148f with SMTP id
 38308e7fff4ca-32b4a4341eemr32105021fa.18.1750252731763; Wed, 18 Jun 2025
 06:18:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618-device-bearer-level-conn-state-v1-1-dca5df09c0bd@amlogic.com>
In-Reply-To: <20250618-device-bearer-level-conn-state-v1-1-dca5df09c0bd@amlogic.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 18 Jun 2025 09:18:38 -0400
X-Gm-Features: AX0GCFvbzIp_NXh3YqpyPPTXXczWYI3l2NdMotTBPSA7iTny-Rs9p8ktxBrEL8E
Message-ID: <CABBYNZ+Za+3s75Lo6bZbhghvpS-8yNWV=RcVFa071UTzunMVYg@mail.gmail.com>
Subject: Re: [PATCH bluez] device: Add bearer info to Connected/Disconnected signals
To: ye.he@amlogic.com
Cc: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 17, 2025 at 10:40=E2=80=AFPM Ye He via B4 Relay
<devnull+ye.he.amlogic.com@kernel.org> wrote:
>
> From: Ye He <ye.he@amlogic.com>
>
> This patch add a new Connected(string bearer) signal to indicate which tr=
ansport
> (LE or BR/EDR) has connected. Also extend the Disconnected signal to incl=
ude
> a bearer argument.
>
> This allows applications to distinguish transport-specific connection
> events in dual-mode scenarios.
>
> Fixes: https://github.com/bluez/bluez/issues/1350
>
> Signed-off-by: Ye He <ye.he@amlogic.com>
> ---
>  doc/org.bluez.Device.rst | 33 ++++++++++++++++++++++++++++++++-
>  src/device.c             | 34 ++++++++++++++++++++++++++--------
>  2 files changed, 58 insertions(+), 9 deletions(-)
>
> diff --git a/doc/org.bluez.Device.rst b/doc/org.bluez.Device.rst
> index 646e2c77ec2ddcbf7e6897336165d228c349fe00..1022402d95a1cd34dea88103b=
a66fb06f3007de7 100644
> --- a/doc/org.bluez.Device.rst
> +++ b/doc/org.bluez.Device.rst
> @@ -157,7 +157,26 @@ Possible errors:
>  Signals
>  -------
>
> -void Disconnected(string reason, string message)
> +void Connected(string bearer)
> +````````````````````````````````````````````````
> +
> +This signal is emitted when a device establishes a connection, indicatin=
g the
> +bearer (transport type) over which the connection occurred.
> +
> +Client applications may use this signal to take actions such as stopping=
 discovery
> +or advertising, depending on their internal policy.
> +
> +Possible bearer:
> +
> +:"le":
> +
> +       LE transport is cconnected.
> +
> +:"bredr":
> +
> +       BR/EDR transport is connected.
> +
> +void Disconnected(string reason, string message, string bearer)
>  ````````````````````````````````````````````````
>
>  This signal is launched when a device is disconnected, with the reason o=
f the
> @@ -208,6 +227,18 @@ Possible reasons:
>
>         Connection terminated by local host for suspend.
>
> +The additional 'bearer' field indicates which transport was disconnected=
.
> +
> +Possible bearer:
> +
> +:"le":
> +
> +       LE transport is disconnected.
> +
> +:"bredr":
> +
> +       BR/EDR transport is disconnected.

Sometime ago, or perhaps I shall say long time, there was proposal to
introduce bearer specific interfaces e.g.
org.bluez.Device.LE/org.bluez.Device.BREDR, I wonder if that wouldn't
be a better direction, otherwise we may mess up with existing
interface which may cause API breakage, etc.

>  Properties
>  ----------
>
> diff --git a/src/device.c b/src/device.c
> index 902c4aa44d21eb89076eff3a47ffa727420967a8..ae6196eb2e5b6eca10a8e1c33=
60b85023dcddec2 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -3491,8 +3491,10 @@ static const GDBusMethodTable device_methods[] =3D=
 {
>  };
>
>  static const GDBusSignalTable device_signals[] =3D {
> +       { GDBUS_SIGNAL("Connected",
> +                       GDBUS_ARGS({ "bearer", "s" })) },
>         { GDBUS_SIGNAL("Disconnected",
> -                       GDBUS_ARGS({ "name", "s" }, { "message", "s" })) =
},
> +                       GDBUS_ARGS({ "name", "s" }, { "message", "s" }, {=
 "bearer", "s" })) },
>         { }
>  };
>
> @@ -3676,6 +3678,7 @@ void device_add_connection(struct btd_device *dev, =
uint8_t bdaddr_type,
>                                                         uint32_t flags)
>  {
>         struct bearer_state *state =3D get_state(dev, bdaddr_type);
> +       const char *bearer;
>
>         device_update_last_seen(dev, bdaddr_type, true);
>         device_update_last_used(dev, bdaddr_type);
> @@ -3691,14 +3694,22 @@ void device_add_connection(struct btd_device *dev=
, uint8_t bdaddr_type,
>         dev->conn_bdaddr_type =3D dev->bdaddr_type;
>
>         /* If this is the first connection over this bearer */
> -       if (bdaddr_type =3D=3D BDADDR_BREDR)
> +       if (bdaddr_type =3D=3D BDADDR_BREDR) {
>                 device_set_bredr_support(dev);
> -       else
> +               bearer =3D "bredr";
> +       } else {
>                 device_set_le_support(dev, bdaddr_type);
> +               bearer =3D "le";
> +       }
>
>         state->connected =3D true;
>         state->initiator =3D flags & BIT(3);
>
> +       g_dbus_emit_signal(dbus_conn, dev->path, DEVICE_INTERFACE,
> +                               "Connected",
> +                               DBUS_TYPE_STRING, &bearer,
> +                               DBUS_TYPE_INVALID);
> +
>         if (dev->le_state.connected && dev->bredr_state.connected)
>                 return;
>
> @@ -3747,7 +3758,7 @@ static void set_temporary_timer(struct btd_device *=
dev, unsigned int timeout)
>                                                                 dev, NULL=
);
>  }
>
> -static void device_disconnected(struct btd_device *device, uint8_t reaso=
n)
> +static void device_disconnected(struct btd_device *device, uint8_t reaso=
n, const char *bearer)
>  {
>         const char *name;
>         const char *message;
> @@ -3787,6 +3798,7 @@ static void device_disconnected(struct btd_device *=
device, uint8_t reason)
>                                                 "Disconnected",
>                                                 DBUS_TYPE_STRING, &name,
>                                                 DBUS_TYPE_STRING, &messag=
e,
> +                                               DBUS_TYPE_STRING, &bearer=
,
>                                                 DBUS_TYPE_INVALID);
>  }
>
> @@ -3798,10 +3810,16 @@ void device_remove_connection(struct btd_device *=
device, uint8_t bdaddr_type,
>         DBusMessage *reply;
>         bool remove_device =3D false;
>         bool paired_status_updated =3D false;
> +       const char *bearer;
>
>         if (!state->connected)
>                 return;
>
> +       if (bdaddr_type =3D=3D BDADDR_BREDR)
> +               bearer =3D "bredr";
> +       else
> +               bearer =3D "le";
> +
>         state->connected =3D false;
>         state->initiator =3D false;
>         device->general_connect =3D FALSE;
> @@ -3854,15 +3872,15 @@ void device_remove_connection(struct btd_device *=
device, uint8_t bdaddr_type,
>                                                 DEVICE_INTERFACE,
>                                                 "Paired");
>
> -       if (device->bredr_state.connected || device->le_state.connected)
> -               return;
> -
>         device_update_last_seen(device, bdaddr_type, true);
>
>         g_slist_free_full(device->eir_uuids, g_free);
>         device->eir_uuids =3D NULL;
>
> -       device_disconnected(device, reason);
> +       device_disconnected(device, reason, bearer);
> +
> +       if (device->bredr_state.connected || device->le_state.connected)
> +               return;
>
>         g_dbus_emit_property_changed(dbus_conn, device->path,
>                                                 DEVICE_INTERFACE, "Connec=
ted");
>
> ---
> base-commit: dc8db3601001de9a085da063e0c5e456074b8963
> change-id: 20250618-device-bearer-level-conn-state-3e29d56bda88
>
> Best regards,
> --
> Ye He <ye.he@amlogic.com>
>
>
>


--=20
Luiz Augusto von Dentz
