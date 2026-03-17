Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2644A1A0BD6
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Mar 2026 18:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773770420; cv=pass; b=qJdrFoyqgHs0EBTiXgcsA5aSGWqv22w98ALFIi6a0lYfA3aF25Rc61ZE/qhq/jxeLR4rzE1R6djwDcx/2LxEy6T0IO6RcjYjNpWOgMd+xyyDi89Wj6eDVSnYu3FanMtifM4kQ2+s+4fcx5+sIiYEzowLbHKLF1/1N4O96vJTTTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773770420; c=relaxed/simple;
	bh=UWoHKQV/7X6fHAzBz6u2kAzBTH5GPtXcPai9JgffWF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hf7vv5r/rbTVZCH/syWCzlFApvrC6W5Bx2qo/uFufeeT3I/ZU7Buie/zI4fzPzYLIydJH3pTWrxU+I3R4LkzyaBkcyhptiYL0Q66EHEzv7NBjoQQVs88rZv5ngj2X5T9BiOANcKJKjpFB2kxzksJB6BT6Z7O01fAxb72k0mIODY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XMuJ1rfq; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XMuJ1rfq"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-79a51edef1fso2510057b3.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Mar 2026 11:00:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773770418; cv=none;
        d=google.com; s=arc-20240605;
        b=RGJBBpoqvXjJ4/2m/0QKM6tg6joJkhyyjEtNAKGOTJkHtsOL8NmBYQTTLkRj4KMAMB
         F2jhnX01bTE3LWK6WgHSSoe++NaJe3QOkjICBGGeblD0sIft4y/+90l3nnMPS7okk+cK
         LA+OCa48S8rU06iSm05VwcR6JMf93zcKyz0sxh9Eq1NLzoReCA+9ikIViOUeFEkPM1vP
         SUYjDj2h9NnYuaiIVtERDYSGvJbkEC9vg3f1DPzJpL9N7DiV0GYchiy99f3flYL4gIRM
         tSOo3R9T7jKTLGcNWpusdyESUf89cC3lP3SImSU7Kn71GwSkn6dJkrWaoZ2D71KtlDpO
         aAgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zUAvUcMl3PCkF6JO7STk1BUrBvLuFX6s6bd2OBEcHkQ=;
        fh=GUKqOr3gEuza1+1KW2Hg+YkQW0UXI0kSJuc7hgQtryo=;
        b=C2ZcTSP6LBAj5ep8Z4evgBk2/McvGRW03zsBlOh1a66Lw5CMagkR+M5iR/Vuai6Lz3
         0zxs2YqrSTiDJ2hlmBpglEhE5qJd9oDT2VDblUAmoYH7O+6ZubDVTff+/gAlcxDGS7Or
         VX3BYFGrQ5XSzqkhsLXEtA4oRiofFLRZSXTt5Dv0MWEwt4br+EYlc9fIFZjkGPZ2XKUj
         bh3KdbQYb9VtViaOubJt+JjwZRK/gQU0S/FYgChXgdDueHaMSGUgM9DZ0mz1FQbCPkGu
         YfZDp8RGZazCEXL++bKWNlmoJz/70bw6xg26rG3zIg6zF+pWS86eVxntdirnUhpnj1PP
         XnWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773770418; x=1774375218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zUAvUcMl3PCkF6JO7STk1BUrBvLuFX6s6bd2OBEcHkQ=;
        b=XMuJ1rfq8KUTlG5UhcZ7sFpE1uOtCTyGCED17IBLA5jHierguT2ADbpNF6CPRHs10x
         M4rl+iVxoWpQ5uFE2ISX7qEH/BorL22AH5INBZet6kd6z+WwwaLmXNPs77x3Fy4dMmpK
         CbG/W59ChCGy/EQEow+s9JHp0E60zlkAN+0VXHo7l4uX01ytu6e3x799eeCIDqA/Vr1H
         dgVFsKr6tAoEUc6X+nyuEn3kOHLZc8wp5ajoA6WLMvIbhy168toTlcM3sZc0Ayvyfr/6
         tEWmVjaevi5LGVxnGM4UMFDl3VSJHElnEcwXF10j3iO2347fAeS38K7LLFndESZ8MYiU
         pAJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773770418; x=1774375218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zUAvUcMl3PCkF6JO7STk1BUrBvLuFX6s6bd2OBEcHkQ=;
        b=tQecdP5mjdkFAv7bF2sk63OHcpYrgDNt79j4FDLZAS6LKYvv5gTG2eJCy0SkI3RI6I
         XajMPVif4sBRbHsgPEIb2Ok2EQlplQtIo7Sf8Ux4T+mUFqJ/1LBOWWEE4i/EMI3xYiCd
         aYf/+ktaHWHGBjbHRjemGWXU45sokTxtuiE9l4zzpT7A0rARLreCn27lgIckyLXeg86R
         KDB6TFss1ZYzNM5us/u6mxJucWEfdXylH/wfmezAZlg1avvoqJ7aXjh/EhLQRF5nUvVq
         NtOgJAjkPRH4oB3/sLl6pnrvciOuabwe8kwq2gye8tKww4hg0V0cWYUT85vVAfiOOZen
         MFTg==
X-Gm-Message-State: AOJu0YwBlHxpdWHVS6PE6caPGbmBNnMZ9+v4JWZC+GjrYEhlHXQ80ScF
	vQLe0ANTL48VWhoYRJjt3aS4K340PG1+BsqlByOA+7klEItPlQet+oHL5Ba2DUedJqRuOacjAgF
	8j3fX3XBaYvm7yEtgYBzwLXSLjEcZQ0HHCA==
X-Gm-Gg: ATEYQzy4g80fTNlQpyhJDxoR1oQkLLSGIwC6kl8/jbFM5MB+pDrPuWqleHX1+hSCmAR
	IGIaPHjkp96vM/otxDPfmIED4o5WoLQs20ooFEaM0tBFpeGCDoWCgasKgu2oBIRF47LvebR8wNi
	cFMxdIK2ocfPmzc4jdnluo6OfPv3h3QCH6oX0Qz4sqpGgmhu2S9NhBHYF8MooYedCw162Woa1lf
	Y4Pw7JFpqm5+LSC/TVGu2/SHZkUjucNleW60K5s4uKAoEs9rlEEHi6xc0PhFiEKEuOvrWPG2Z0p
	mkH4dTMx7SwzFaZSdARu0HKCPAoWBucuZVtxr/DE4FFqbFUxMD5SaoNkYkjV0EsbFN1lPQ==
X-Received: by 2002:a05:690e:1aa2:b0:64c:9ac2:2cde with SMTP id
 956f58d0204a3-64e88a45c67mr2829520d50.17.1773770417913; Tue, 17 Mar 2026
 11:00:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317142645.6332-1-raghavendra.rao@collabora.com> <20260317142645.6332-2-raghavendra.rao@collabora.com>
In-Reply-To: <20260317142645.6332-2-raghavendra.rao@collabora.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 17 Mar 2026 14:00:06 -0400
X-Gm-Features: AaiRm52EJcaFV0_BI9cjYkprriOdZAcpIs3p83Cc6XDkbD3JHvLGWDWVykwv2Ns
Message-ID: <CABBYNZ+O232jp2PPdne=sSGhiynZZa7=rComj+7uzmjBwCT2fA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/1] client: Add public-broadcast profile advertise command
To: raghava447 <raghavendra.rao@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 17, 2026 at 10:42=E2=80=AFAM raghava447
<raghavendra.rao@collabora.com> wrote:
>
> Add an advertise submenu command for BLE Audio public broadcast profile
> advertising in bluetoothctl.
>
> The new "public-broadcast" command reuses the existing staged AD
> ServiceData field for UUID 0x1856.
> It supports:
> - public-broadcast sq
> - public-broadcast hq
> - public-broadcast

Perhaps we could detect when broadcast is in use and then set the name
as the public broadcast name if one is set.

> The sq and hq values map to the existing raw service-data payloads:
> - sq -> 0x02 0x00
> - hq -> 0x04 0x00
>
> When called without arguments, the command reports the currently staged
> public-broadcast state if the staged AD service UUID is 0x1856.
> Else it reports that public broadcast is not set.
> ---
>  client/advertising.c | 70 ++++++++++++++++++++++++++++++++++++++++++++
>  client/advertising.h |  2 ++
>  client/main.c        | 19 ++++++++++++
>  3 files changed, 91 insertions(+)
>
> diff --git a/client/advertising.c b/client/advertising.c
> index f9df1b855..30b89a404 100644
> --- a/client/advertising.c
> +++ b/client/advertising.c
> @@ -20,6 +20,8 @@
>  #include <string.h>
>  #include <errno.h>
>
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/uuid.h"
>  #include "gdbus/gdbus.h"
>  #include "src/shared/util.h"
>  #include "src/shared/shell.h"
> @@ -27,6 +29,7 @@
>
>  #define AD_PATH "/org/bluez/advertising"
>  #define AD_IFACE "org.bluez.LEAdvertisement1"
> +#define AD_PUBLIC_BROADCAST_UUID "0x1856"
>
>  struct ad_data {
>         uint8_t data[245];
> @@ -1005,6 +1008,73 @@ static void ad_clear_data(int type)
>         memset(&ad.data[type], 0, sizeof(ad.data[type]));
>  }
>
> +static bool ad_is_public_broadcast_uuid(const char *uuid)
> +{
> +       return uuid && !bt_uuid_strcmp(uuid, AD_PUBLIC_BROADCAST_UUID);
> +}
> +
> +static const char *ad_public_broadcast_state(void)
> +{
> +       if (!ad_is_public_broadcast_uuid(ad.service[AD_TYPE_AD].uuid))
> +               return NULL;
> +
> +       if (ad.service[AD_TYPE_AD].data.len !=3D 2)
> +               return NULL;
> +
> +       if (ad.service[AD_TYPE_AD].data.data[0] =3D=3D 0x02 &&
> +                       ad.service[AD_TYPE_AD].data.data[1] =3D=3D 0x00)
> +               return "sq";
> +
> +       if (ad.service[AD_TYPE_AD].data.data[0] =3D=3D 0x04 &&
> +                       ad.service[AD_TYPE_AD].data.data[1] =3D=3D 0x00)
> +               return "hq";
> +
> +       return NULL;
> +}
> +
> +void ad_advertise_public_broadcast(DBusConnection *conn, int argc, char =
*argv[])
> +{
> +       struct ad_data data =3D {
> +               .data =3D { 0x00, 0x00 },
> +               .len =3D 2,
> +       };
> +       const char *state;
> +
> +       if (argc < 2) {
> +               state =3D ad_public_broadcast_state();
> +               if (state)
> +                       bt_shell_printf("Public Broadcast: %s\n", state);
> +               else
> +                       bt_shell_printf("Public Broadcast not set\n");
> +
> +               return bt_shell_noninteractive_quit(EXIT_SUCCESS);
> +       }
> +
> +       if (!strlen(argv[1])) {
> +               bt_shell_printf("Public broadcast value cannot be empty\n=
");
> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +       }
> +
> +       if (!strcasecmp(argv[1], "sq"))
> +               data.data[0] =3D 0x02;
> +       else if (!strcasecmp(argv[1], "hq"))
> +               data.data[0] =3D 0x04;
> +       else {
> +               bt_shell_printf("Invalid argument: accepted values are sq=
 or hq\n");
> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +       }
> +
> +       ad_clear_service(AD_TYPE_AD);
> +
> +       ad.service[AD_TYPE_AD].uuid =3D g_strdup(AD_PUBLIC_BROADCAST_UUID=
);
> +       ad.service[AD_TYPE_AD].data =3D data;
> +
> +       g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE,
> +                                               prop_names.service[AD_TYP=
E_AD]);
> +
> +       return bt_shell_noninteractive_quit(EXIT_SUCCESS);
> +}
> +
>  void ad_advertise_data(DBusConnection *conn, int type, int argc, char *a=
rgv[])
>  {
>         char *endptr =3D NULL;
> diff --git a/client/advertising.h b/client/advertising.h
> index 9d124c7af..8c3fd041b 100644
> --- a/client/advertising.h
> +++ b/client/advertising.h
> @@ -34,6 +34,8 @@ void ad_advertise_local_appearance(DBusConnection *conn=
, long int *value);
>  void ad_advertise_duration(DBusConnection *conn, long int *value);
>  void ad_advertise_timeout(DBusConnection *conn, long int *value);
>  void ad_advertise_data(DBusConnection *conn, int type, int argc, char *a=
rgv[]);
> +void ad_advertise_public_broadcast(DBusConnection *conn, int argc,
> +                                                       char *argv[]);
>  void ad_disable_data(DBusConnection *conn, int type);
>  void ad_advertise_discoverable(DBusConnection *conn, dbus_bool_t *value)=
;
>  void ad_advertise_discoverable_timeout(DBusConnection *conn, long int *v=
alue);
> diff --git a/client/main.c b/client/main.c
> index cb016a579..0e050b373 100644
> --- a/client/main.c
> +++ b/client/main.c
> @@ -2892,6 +2892,17 @@ static char *ad_generator(const char *text, int st=
ate)
>         return argument_generator(text, state, ad_arguments);
>  }
>
> +static const char *public_broadcast_arguments[] =3D {
> +       "sq",
> +       "hq",
> +       NULL
> +};
> +
> +static char *public_broadcast_generator(const char *text, int state)
> +{
> +       return argument_generator(text, state, public_broadcast_arguments=
);
> +}
> +
>  static void cmd_advertise_uuids(int argc, char *argv[])
>  {
>         ad_advertise_uuids(dbus_conn, AD_TYPE_AD, argc, argv);
> @@ -2917,6 +2928,11 @@ static void cmd_advertise_data(int argc, char *arg=
v[])
>         ad_advertise_data(dbus_conn, AD_TYPE_AD, argc, argv);
>  }
>
> +static void cmd_advertise_public_broadcast(int argc, char *argv[])
> +{
> +       ad_advertise_public_broadcast(dbus_conn, argc, argv);
> +}
> +
>  static void cmd_advertise_sr_uuids(int argc, char *argv[])
>  {
>         ad_advertise_uuids(dbus_conn, AD_TYPE_SRD, argc, argv);
> @@ -3600,6 +3616,9 @@ static const struct bt_shell_menu advertise_menu =
=3D {
>                         "Set/Get advertise manufacturer data" },
>         { "data", "[type] [data=3Dxx xx ...]", cmd_advertise_data,
>                         "Set/Get advertise data" },
> +       { "public-broadcast", "[sq/hq]", cmd_advertise_public_broadcast,
> +                       "Set/Get BLE Audio Public Broadcast Announcement"=
,
> +                       public_broadcast_generator },
>         { "sr-uuids", "[uuid1 uuid2 ...]", cmd_advertise_sr_uuids,
>                         "Set/Get scan response uuids" },
>         { "sr-solicit", "[uuid1 uuid2 ...]", cmd_advertise_sr_solicit,
> --
> 2.53.0
>
>


--=20
Luiz Augusto von Dentz
