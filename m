Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEBA24BC00
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 May 2025 16:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747759332; cv=none; b=Pnp2XKK9OuxVDaiIjw7+ZsYmaDk2ILnIjYw4DAO18bI8YK0313B+rWoEKQhwYJYiGdBLN2NpGUVsrJVt4gsINLuXhMKFGbWbGJIfq3iyNtFD33cJgsRlItitSs4IfEgawk43NMFZ/dIPwYR2qat97MqlP6F9ednKyO3z4TyP9YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747759332; c=relaxed/simple;
	bh=9DMdkQigu6T/fm2i/fi2/D6L63tE/7Bkron0OPZf/2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uNtLudLylDu+xZ6pI634L1o3h+juwGSE8xD6REnGyn6VL3tt+72b4OdYf0khmjX3EuktNhig9boIy85aLWH8UDv3oE/ysvnRIxFer6HfZg/sU0mF7OuwRnbHZ2JeTqrSW7zJq7KZ97GdA4I9M/S2HjjinVvU5AARHwnsRaJ3gXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RjgvZ4o1; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RjgvZ4o1"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3105ef2a071so67335471fa.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 May 2025 09:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747759328; x=1748364128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3vtxUrWuPzgfilRmc8pBrp/+V7/0O4BgW4zMHyks7HE=;
        b=RjgvZ4o1wY79Prz3qf9r1VKTiQTP6S9IVah5HezYeGrRADhSvxXxvulHzfGxSQtJj8
         gaca3cHQPq5H7vxTnWb+S9lm/KlfuZHrTi+uZ62vAIm0HQoyP8CWcIiYJvD/oM8HdEDv
         Wp7o/n8NC5EhpwoQNU4DtufLWViZxrI6cxD9GnRNwtHcbdCDfV/FTUZ9nzn23FhHaNvr
         31a/tK/4eIiN3V1u1qQNyESaR6zd16aGQmWyKTp8mBx/QVtH554QtjMVBio9npwiFt3v
         nJfiJZrWGK2OlEQv12mHj1+StXtX8bxeGpRZOpsNAflY8I0zaJ62v3dwIqJTIf8PW6Af
         T7XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747759328; x=1748364128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3vtxUrWuPzgfilRmc8pBrp/+V7/0O4BgW4zMHyks7HE=;
        b=VVueNKZAUKtPYXbfWVBMM3w32MkcOpFs03ITczOvlTG56J8LcMyoL9uDJ7tKJG9XXR
         4hMcWgJxMc8A8f5Zjg6l7/fDsaPSZDA6l1+irwILV5vmcj8viJ3rgJPQ17qlLIOiY2kH
         mMtxjDZz7sLrAK/Zn23dRg5FKs/K7YKgqMhh0hfWMpEbKH4U6xSIr3/CQu6aHDi+gYk6
         fwhioMozV55IPKT74ge1ODPGU73lzkcdJ7Z0u0wsb5Mh7q6ddWmv7tDsB5rRZEwfYJy5
         S/RZZDPEEpd57FJaYD7H1bOJ0R0/x8/QECUCuP3UFC+JV5LljP3OFS7KCU/g9czHB3Hd
         /Zuw==
X-Gm-Message-State: AOJu0YzQtSHu9oDO2Da2CNuD9tTjzFLt1d8/MERlJd+gxBBMewBLShha
	P1t2HAxhc5V2y89rgol/JLHWYPCzw45DzvP+v+qUqfcbxIsqxyKDsHtRL4qhyHvVVwQW9RhK89a
	+UAXCXBl8imbByxxW1/71MIbjXGg7z57q05ESJTc=
X-Gm-Gg: ASbGncvTIcxGmf/QFitZ2s5v1qQGWhLZEyrkeLGYtuW/5y4Pff/+cgduSa2NF99yQ4e
	Kvjj0aWSnWNKyVV9BlH0cjwmVlAkyDQMAH/qfx78YwUmfe9ZUuXP3VlOQJl52hEXVdi2MmkllZH
	gOGYpveRkvm0jJG263tc4mUxytQCbhyJIKTAIyRDVJ2g==
X-Google-Smtp-Source: AGHT+IHb8LkbqiOr0DwQ3g59PUxmWRSKoaOjDqOD315LtdIirY9SrrpZuhR7IwqZ/LMvk2WP9E9D/eCwF39oUe66OJE=
X-Received: by 2002:a2e:a107:0:b0:328:1f0:95a with SMTP id 38308e7fff4ca-3280971984fmr62132951fa.23.1747759327955;
 Tue, 20 May 2025 09:42:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520162621.190769-1-frederic.danis@collabora.com> <20250520162621.190769-2-frederic.danis@collabora.com>
In-Reply-To: <20250520162621.190769-2-frederic.danis@collabora.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 20 May 2025 12:41:55 -0400
X-Gm-Features: AX0GCFswxWihimNHbI37-ZscNavYsz4PcEok0D7VE22biXihRJ3Gg9u194sSIqE
Message-ID: <CABBYNZ+jMjs2Nj-9LiREM31cwhhT4O9Fv0nay_qFY4JfJKszuw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 1/3] src/device: Add Disconnected signal to
 propagate disconnection reason
To: =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On Tue, May 20, 2025 at 12:26=E2=80=AFPM Fr=C3=A9d=C3=A9ric Danis
<frederic.danis@collabora.com> wrote:
>
> Currently a client application is informed of the disconnection by the
> update of the Connected property to false.
> This sends a Disconnected signal with the disconnection reason before
> the property is updated.
>
> This helps client application to know the reason for the disconnection
> and to take appropriate action.
> ---
> v1->v2: Propagate numerical reason instead of text one
>
>  src/adapter.c | 13 ++++++++-----
>  src/device.c  | 16 ++++++++++++++--
>  src/device.h  |  3 ++-
>  3 files changed, 24 insertions(+), 8 deletions(-)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index fd425e6d2..a10721489 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -7549,7 +7549,8 @@ struct agent *adapter_get_agent(struct btd_adapter =
*adapter)
>
>  static void adapter_remove_connection(struct btd_adapter *adapter,
>                                                 struct btd_device *device=
,
> -                                               uint8_t bdaddr_type)
> +                                               uint8_t bdaddr_type,
> +                                               uint8_t reason)
>  {
>         bool remove_device =3D false;
>
> @@ -7560,7 +7561,7 @@ static void adapter_remove_connection(struct btd_ad=
apter *adapter,
>                 return;
>         }
>
> -       device_remove_connection(device, bdaddr_type, &remove_device);
> +       device_remove_connection(device, bdaddr_type, &remove_device, rea=
son);
>
>         device_cancel_authentication(device, TRUE);
>
> @@ -7601,9 +7602,11 @@ static void adapter_stop(struct btd_adapter *adapt=
er)
>                 struct btd_device *device =3D adapter->connections->data;
>                 uint8_t addr_type =3D btd_device_get_bdaddr_type(device);
>
> -               adapter_remove_connection(adapter, device, BDADDR_BREDR);
> +               adapter_remove_connection(adapter, device, BDADDR_BREDR,
> +                                               MGMT_DEV_DISCONN_UNKNOWN)=
;
>                 if (addr_type !=3D BDADDR_BREDR)
> -                       adapter_remove_connection(adapter, device, addr_t=
ype);
> +                       adapter_remove_connection(adapter, device, addr_t=
ype,
> +                                               MGMT_DEV_DISCONN_UNKNOWN)=
;
>         }
>
>         g_dbus_emit_property_changed(dbus_conn, adapter->path,
> @@ -8551,7 +8554,7 @@ static void dev_disconnected(struct btd_adapter *ad=
apter,
>
>         device =3D btd_adapter_find_device(adapter, &addr->bdaddr, addr->=
type);
>         if (device) {
> -               adapter_remove_connection(adapter, device, addr->type);
> +               adapter_remove_connection(adapter, device, addr->type, re=
ason);
>                 disconnect_notify(device, reason);
>         }
>
> diff --git a/src/device.c b/src/device.c
> index d230af0a8..00a0fbfc7 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -3417,6 +3417,12 @@ static const GDBusMethodTable device_methods[] =3D=
 {
>         { }
>  };
>
> +static const GDBusSignalTable device_signals[] =3D {
> +       { GDBUS_SIGNAL("Disconnected",
> +                       GDBUS_ARGS({ "reason", "y" })) },

Ive changed my mind regarding this, this should actually have the same
format as Device.Connect error reply, so we use the same domain of
errors org.bluez.Error.{Name} followed by its message.

> +       { }
> +};
> +
>  static gboolean
>  dev_property_get_prefer_bearer(const GDBusPropertyTable *property,
>                                 DBusMessageIter *iter, void *data)
> @@ -3638,7 +3644,8 @@ static void set_temporary_timer(struct btd_device *=
dev, unsigned int timeout)
>  }
>
>  void device_remove_connection(struct btd_device *device, uint8_t bdaddr_=
type,
> -                                                               bool *rem=
ove)
> +                                                               bool *rem=
ove,
> +                                                               uint8_t r=
eason)
>  {
>         struct bearer_state *state =3D get_state(device, bdaddr_type);
>         DBusMessage *reply;
> @@ -3708,6 +3715,11 @@ void device_remove_connection(struct btd_device *d=
evice, uint8_t bdaddr_type,
>         g_slist_free_full(device->eir_uuids, g_free);
>         device->eir_uuids =3D NULL;
>
> +       g_dbus_emit_signal(dbus_conn, device->path, DEVICE_INTERFACE,
> +                                               "Disconnected",
> +                                               DBUS_TYPE_BYTE, &reason,
> +                                               DBUS_TYPE_INVALID);
> +
>         g_dbus_emit_property_changed(dbus_conn, device->path,
>                                                 DEVICE_INTERFACE, "Connec=
ted");
>
> @@ -4611,7 +4623,7 @@ static struct btd_device *device_new(struct btd_ada=
pter *adapter,
>
>         if (g_dbus_register_interface(dbus_conn,
>                                         device->path, DEVICE_INTERFACE,
> -                                       device_methods, NULL,
> +                                       device_methods, device_signals,
>                                         device_properties, device,
>                                         device_free) =3D=3D FALSE) {
>                 error("Unable to register device interface for %s", addre=
ss);
> diff --git a/src/device.h b/src/device.h
> index a35bb1386..4eebcebe9 100644
> --- a/src/device.h
> +++ b/src/device.h
> @@ -134,7 +134,8 @@ gboolean device_is_authenticating(struct btd_device *=
device);
>  void device_add_connection(struct btd_device *dev, uint8_t bdaddr_type,
>                                                         uint32_t flags);
>  void device_remove_connection(struct btd_device *device, uint8_t bdaddr_=
type,
> -                                                               bool *rem=
ove);
> +                                                       bool *remove,
> +                                                       uint8_t reason);
>  void device_request_disconnect(struct btd_device *device, DBusMessage *m=
sg);
>  bool device_is_disconnecting(struct btd_device *device);
>  void device_set_ltk(struct btd_device *device, const uint8_t val[16],
> --
> 2.43.0
>
>


--=20
Luiz Augusto von Dentz
