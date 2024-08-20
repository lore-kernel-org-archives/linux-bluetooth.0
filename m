Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DBC192B82
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Aug 2024 14:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724165074; cv=none; b=CGfLLW+qhu/+/nwKg1PjoyFo+5yTgnqeh0jAakYdwVIQVfQ7KtWhzs9L0UYvaXPp7V3n4lb0JmnFpUdMtEarlgFRrWC/UNuLhYhXCgQ21RrUXBYe14hkTD4WVp9Te9Ex6wg2p4Qe+iUWygRGi8DU8iRfKx9aBWY/TkqBIzpoHj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724165074; c=relaxed/simple;
	bh=B4UPAvKlsMMdvysE3dneuyYL2dtOZ0rA1Wih8Zie91A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eJr3JfPyCWz3XmyVeH80WLorO1GDoHMVBmMEeI1dQDdpEnVi9G420bJ8A2/WmSL+R4HfbV2r7FkxmLxl2QmyJusuWaYroLylrI/d/Gk1KQNcz34kz81YrczPqG+21coO26Chx//8V1H4dB9Hmyp0qJxJBbUhWDVxJ5XQj+imXqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YK4ZhZe1; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YK4ZhZe1"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f3bfcc2727so32239021fa.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Aug 2024 07:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724165071; x=1724769871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VSsf5NP937YmorxwPjE0W9kydkJQWvsDHxy/EFokrl8=;
        b=YK4ZhZe10rqynKZIyJWaQjw/+0J9RU7LV/QoVgjE9HgrV6eqf9k2mF4Tni8P8hxsNF
         esbpjrLnY/qeIfqKvWtfHSrNUeZLBWdRkUfBn37RgkLp07ODEfpmplPeuzsvs7qEcG7w
         fvVRUTUQXE0FNGnTZE5d1B1bdJSrqpPrHB+MMSlsXBe1RNcFC2jkNpq6ToCAkBjGEdHq
         fgGVrjQHlRS605CCsdmDTmM4ZyfpgtCF38j2CZcSK6ZCHhGqXbpwumrQwM2bE3TUYsUT
         jwo3wDtgGVYnMUVGwuXFnZD/6UQLcBfwi5ojuxb1W86t3ehJicj2A3CCce5+rWppO07E
         WKfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724165071; x=1724769871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VSsf5NP937YmorxwPjE0W9kydkJQWvsDHxy/EFokrl8=;
        b=tKNLe97V6jzT0fy8tDkVop+usSe0z9HHK+lQvucEj5f6lIFMNtk/t3i5UgTn7efkjq
         TbDq4Yx2WOhuX8i/5eARC6w9nKlEyJ6kNqBYkF3tNlzeH/dQAr2J+Mfz0eIqrQfARl0g
         oVZzqcpw+y/iNDg+SVV04NtM8nPLugMFoZHMAnqzqN4CI9Sgt9wC+Zdq6hGXFqy0Bar8
         CUP4IVm+9M6XmSiB9rshxcNiW54b/i77eBs+hBapJgU16JPOfOFL1TmNALrzFK8KI9Uf
         8OIE0KBDDJXF2y4k4QHoXa8nRYdWYgJNMrgHQMOOXokUlIVqnJIyijeq0JeV0A2akWFl
         kD+g==
X-Gm-Message-State: AOJu0Yx4hx/rIyVsYPd63wuo7DW+Y/4GH4o+CkTuLOLkGHq1VKkTTUDI
	HdU1GLLGm+kKMwHK7bLIYRSqO0zm8Y9aYQqAOu29lEhS582uWDtUvMahxluxUK2nP9Ly/jI0Llr
	VeWMzdyWzWmRqwSVH9k+F8CENzgA=
X-Google-Smtp-Source: AGHT+IFjKV273vlB71V/xb4wt6VqbWKba7s5qnuN8AZi2k2Qf3ZNlB7OrQTWsCkOeoxr+pWsj6Py5p55TkLUppJasa0=
X-Received: by 2002:a2e:a9a8:0:b0:2ef:2c68:a776 with SMTP id
 38308e7fff4ca-2f3be5d9f6bmr134307521fa.37.1724165070448; Tue, 20 Aug 2024
 07:44:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820103918.24246-1-vlad.pruteanu@nxp.com> <20240820103918.24246-6-vlad.pruteanu@nxp.com>
In-Reply-To: <20240820103918.24246-6-vlad.pruteanu@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 20 Aug 2024 10:44:18 -0400
Message-ID: <CABBYNZ+Y5-4icEuF-yRerhG0ohdnHGQhO1FKOEcOOimekA5p-Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ 5/8] transport: Add set_bcast_qos method
To: Vlad Pruteanu <vlad.pruteanu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, mihai-octavian.urzica@nxp.com, 
	iulia.tanasescu@nxp.com, andrei.istodorescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Vlad,

On Tue, Aug 20, 2024 at 6:43=E2=80=AFAM Vlad Pruteanu <vlad.pruteanu@nxp.co=
m> wrote:
>
> This adds a set method for the QoS property of bcast transports.
> This is needed so that applications like bluetoothctl are able to
> modify the QoS (for example, for setting the broadcast code).
> ---
>  profiles/audio/transport.c | 33 +++++++++++++++++++++++++++++++--
>  1 file changed, 31 insertions(+), 2 deletions(-)
>
> diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
> index e8915490d..854b30601 100644
> --- a/profiles/audio/transport.c
> +++ b/profiles/audio/transport.c
> @@ -5,7 +5,7 @@
>   *
>   *  Copyright (C) 2006-2007  Nokia Corporation
>   *  Copyright (C) 2004-2009  Marcel Holtmann <marcel@holtmann.org>
> - *  Copyright 2023 NXP
> + *  Copyright 2023-2024 NXP
>   *
>   *
>   */
> @@ -1208,13 +1208,42 @@ static gboolean qos_bcast_exists(const GDBusPrope=
rtyTable *property, void *data)
>         return bap->qos.bcast.io_qos.phy !=3D 0x00;
>  }
>
> +static void set_bcast_qos(const GDBusPropertyTable *property,
> +                       DBusMessageIter *dict, GDBusPendingPropertySet id=
,
> +                       void *data)
> +{
> +       DBusMessageIter array, entry, value;
> +       struct media_transport *transport =3D data;
> +       struct bap_transport *bap =3D transport->data;
> +       struct bt_bap_qos *bap_qos =3D bt_bap_stream_get_qos(bap->stream)=
;
> +       char *key, *str;
> +
> +       dbus_message_iter_recurse(dict, &array);
> +
> +       dbus_message_iter_recurse(&array, &entry);
> +       dbus_message_iter_get_basic(&entry, &key);
> +
> +       dbus_message_iter_next(&entry);
> +       dbus_message_iter_recurse(&entry, &value);
> +
> +       if (!strcasecmp(key, "BCode")) {
> +               dbus_message_iter_get_basic(&value, &str);

Hmm, isn't BCode a byte array? How come we are parsing as a string here?

> +               bap_qos->bcast.bcode =3D new0(struct iovec, 1);
> +               util_iov_append(bap_qos->bcast.bcode, str, strlen(str));
> +       }
> +
> +       bt_bap_stream_qos(bap->stream, bap_qos, NULL, NULL);
> +
> +       g_dbus_pending_property_success(id);
> +}
> +
>  static const GDBusPropertyTable transport_bap_bc_properties[] =3D {
>         { "Device", "o", get_device },
>         { "UUID", "s", get_uuid },
>         { "Codec", "y", get_codec },
>         { "Configuration", "ay", get_configuration },
>         { "State", "s", get_state },
> -       { "QoS", "a{sv}", get_bcast_qos, NULL, qos_bcast_exists },
> +       { "QoS", "a{sv}", get_bcast_qos, set_bcast_qos, qos_bcast_exists =
},
>         { "Endpoint", "o", get_endpoint, NULL, endpoint_exists },
>         { "Location", "u", get_location },
>         { "Metadata", "ay", get_metadata },
> --
> 2.40.1
>


--=20
Luiz Augusto von Dentz
