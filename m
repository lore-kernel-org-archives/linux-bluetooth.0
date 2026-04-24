Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE213C1416
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2026 14:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777041697; cv=pass; b=LvJhAuiAB+jE3riW6ZzITEDzmQw42sHKQc3PIjUWHg0CE0DysqF4MSZQlrqMyiU0Ljl0XGIov0GVXFOXtjgihtMO2b3/1A8ON2Ga9woxKeao5yGrJ8CFcUQGcVKimDEYDyYC1d8VjKTA898nRTcRz8AoH5oDbFn/qgSfV9Es83E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777041697; c=relaxed/simple;
	bh=Hb/N9BhEWECIKeGcYCUWL0bdNwC7njVo2YvdJSCdg74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ShujaK+ERBJFQGd+pK5rFmk/TexXaqRSHIMLl9meDZVb5neY5fJFAafWku7DSLArGhQ+lOA8NyDDEbR/SV2DWUoCIW+8do0TnGZrLxL+3fciI7C/RIPvDB/rgY5gc3cX0niv85IZO1nunuTUQaZdA67U67BjnDkTkMN0LmuReLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cGseifmh; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cGseifmh"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-64937edbc9eso7034656d50.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2026 07:41:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777041695; cv=none;
        d=google.com; s=arc-20240605;
        b=Fk3+Z5pnSD2BhFdvVQMUitpszVH9iGK65WVixE2iEEyPYypxABFCvuPypMK/AcAkG/
         UZ9/JsBFn434PxH6RIt8WkNsDOz5mRiy7NWxrHysxFho5qYV3pqM2sL3qZHixlXOFaLL
         riHAX9U5SWPNg3jK0km+ffTlDk+yu6HVGN+0x0KwvE1sUuqOfRilwUsyFP4cn+W/S5op
         zkMAXFzS4TlAV0OOYSgexo9+X0e1ZxHt97v4Tm/6j4ZaDSWnR/lTLsUrtDABMm8eR58D
         VEiHecfpjdmvs6iPx4MrUJnxwohjiKsJK0UnIu5fV43LRv7FQNdVgD3rZAjWIaGl/8oD
         A5ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+mdrds+Jypjh2CkgH36BmFmMXpEe9MxlGtue5cGpFNw=;
        fh=ZFlyP5+YKgJkmoBW5+QP1miOu0vNYasz89rr0yCZ/+4=;
        b=NAqPhwf36Lg2/UFTJtQapkTw3HYmtvGx74DrStGuE87q7q3eeQJHvQsvR8S4rIOiAM
         dfn0/MzjAc8W/12p8Iqb85JktEhH299rEfl9vTv5qc9q/Q15dzBsD9ToTHXyNH7Ax9ho
         6Zhsa6ktuwCmRoYD1qxcp+F6jnaewn7TlkY4xooGO53dLjbhvwDwvGjXXSYBsO+k2/6s
         ELljFzaN73rsA69WEQGtCvUEdQHoy5b8zEgBRkvadBkKNo0rMFR83JpdtyscSJ8mBPsN
         0Xz1JLFEseuqeUQSCpVQAjS1hoa9QVauzC7JzHIqZLRbkPDbxIBTZoxFc+qcz51nM49S
         wbig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777041695; x=1777646495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+mdrds+Jypjh2CkgH36BmFmMXpEe9MxlGtue5cGpFNw=;
        b=cGseifmhGzl2vpi9EW0eNCcqLB36bcVfCzJ41kBXEHDtkh3tzqA2GQSJXNSe6Kd1Ma
         Qj1paZSkeNFwZLlOcIsDEwUNxNIn7ijyrKJodEMA3NL2OgGq5Zjmwwbqg99Ofwxi9lJP
         hzkuoq6nR46si6zaDJunu6FeDrxCTI3m2UTKI8hTrmf/vQXIRtiyKxHY7MmH1YzmD5Ff
         zk8kwVMP9o+ukmRzH5gTqx1+Ik36o07lh88eZCvdksPwbmi78f0P9eb3GuvWfqjQfZWK
         3MxxrqvekVF/SBmw5Ex0kqIhFYA1yrLAQJT2fr9PH/BT6T4OkwtrrV7jZJeMRKp5icWY
         B8Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777041695; x=1777646495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+mdrds+Jypjh2CkgH36BmFmMXpEe9MxlGtue5cGpFNw=;
        b=AuLDjDPeh0qZAVhRth538x6ZnbanCdfLn3gzuVFelaGz2aY3oASX16/gyCB4zBaTi0
         YqA/OWDkiYvSX9bowLPNq89OV79TYqCfJmfBK/nISFBGJOy/p/3uyyhAk/l1038po0MJ
         dBdtAlbiE63va7V7+lfo2Gswi3fcVobSI9sKtDNZ4lZN0A3eFzM26+QHXATeiNrAfAAC
         /pBAPDN9pMtUaotyJSTdR8kRjfdXpbCOnmXlyBzjP1xnhTfdw00trfqpU8rXe8eAYyRO
         PlcXRwNtLD0NRskBekF1yVOgMn0uJE1gv3PxtJMLKdFYNlCx2ju6snMo2U1J7adgJQt1
         qADA==
X-Gm-Message-State: AOJu0YwaW+hKf3E2WtFtvvmdheGfmMwEjNQfZ5w5E1jqF2MYj6242dgj
	tXV6jzEvmneOCwQG9tbq5qeL2mUh/omzGYsHNvEHnNfnuJOUUzUCN9xsHrlRw9qY0JN3LJnxTyM
	JWNTPPkhYgGHjFBbx6yh7RBuaoOBL1Wc=
X-Gm-Gg: AeBDievYxnybPR5fXSikC3Pal2U0cZ+57D38MrmHs7RXP+Difb4zy/K8JLulWIbbM7i
	MI/vC9YoayieG7AkmoUrRbkGdbAti5ao/gOoxYt4RhucCTonsyckRtuD87HY85eI0isCKs8sz97
	wihehN+SMGFC6o0ru+OT8T+3ZP0uGOkBPyP5btiWnw8wrSs3yuPeXpUO8h7vX7iOAVFL2GLvtBB
	z0Enla4v48znu66hvdsYTUbnZQTKOfWcksIDmwga3KrYdaNYzqkoLy6NxJXsl319UYyBlchLgnO
	elM06d5GjEwP8ccDXB5DkKf5pnIIfDjoNG8VcTMxcU/jS12vZecltivX1shjMisX3AJ6N2TIFSK
	zQZTx
X-Received: by 2002:a05:690e:1406:b0:650:6df:681 with SMTP id
 956f58d0204a3-65310a0c16cmr30994332d50.32.1777041695063; Fri, 24 Apr 2026
 07:41:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317142645.6332-1-raghavendra.rao@collabora.com>
 <20260424141831.9172-1-raghavendra.rao@collabora.com> <20260424141831.9172-2-raghavendra.rao@collabora.com>
In-Reply-To: <20260424141831.9172-2-raghavendra.rao@collabora.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 24 Apr 2026 10:41:23 -0400
X-Gm-Features: AQROBzAc2iSsfAZx3TFjLzjkPUHTfJgOYEPoBy6qKzo48Z2anau55oFu5VCZx8o
Message-ID: <CABBYNZJ6ROO7SJ16M_kbAYYyEQY8kMbbrOvB-VOQ2-aqjK1fQQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] client: add public-broadcast advertising command
To: raghu447 <raghavendra.rao@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Raghu,

On Fri, Apr 24, 2026 at 10:19=E2=80=AFAM raghu447 <raghavendra.rao@collabor=
a.com> wrote:
>
> From: raghavendra <raghavendra.rao@collabora.com>
>
> ---
>  client/advertising.c | 71 ++++++++++++++++++++++++++++++++++++++++++++
>  client/advertising.h |  2 ++
>  client/main.c        | 19 ++++++++++++
>  3 files changed, 92 insertions(+)
>
> diff --git a/client/advertising.c b/client/advertising.c
> index f9df1b855..fc51f8193 100644
> --- a/client/advertising.c
> +++ b/client/advertising.c
> @@ -20,6 +20,9 @@
>  #include <string.h>
>  #include <errno.h>
>
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/uuid.h"
> +
>  #include "gdbus/gdbus.h"
>  #include "src/shared/util.h"
>  #include "src/shared/shell.h"
> @@ -27,6 +30,7 @@
>
>  #define AD_PATH "/org/bluez/advertising"
>  #define AD_IFACE "org.bluez.LEAdvertisement1"
> +#define AD_PUBLIC_BROADCAST_UUID "0x1856"
>
>  struct ad_data {
>         uint8_t data[245];
> @@ -1005,6 +1009,73 @@ static void ad_clear_data(int type)
>         memset(&ad.data[type], 0, sizeof(ad.data[type]));
>  }
>
> +static bool ad_is_public_broadcast_uuid(const char *uuid)
> +{
> +    return uuid && !bt_uuid_strcmp(uuid, AD_PUBLIC_BROADCAST_UUID);
> +}
> +
> +static const char *ad_public_broadcast_state(void)
> +{
> +    if (!ad_is_public_broadcast_uuid(ad.service[AD_TYPE_AD].uuid))
> +        return NULL;
> +
> +    if (ad.service[AD_TYPE_AD].data.len !=3D 2)
> +        return NULL;
> +
> +    if (ad.service[AD_TYPE_AD].data.data[0] =3D=3D 0x02 &&
> +        ad.service[AD_TYPE_AD].data.data[1] =3D=3D 0x00)
> +        return "sq";
> +
> +    if (ad.service[AD_TYPE_AD].data.data[0] =3D=3D 0x04 &&
> +        ad.service[AD_TYPE_AD].data.data[1] =3D=3D 0x00)
> +        return "hq";
> +
> +    return NULL;
> +}
> +
> +void ad_advertise_public_broadcast(DBusConnection *conn, int argc, char =
*argv[])
> +{
> +    struct ad_data data =3D {
> +        .data =3D { 0x00, 0x00 },
> +        .len =3D 2,
> +    };
> +    const char *state;
> +
> +    if (argc < 2) {
> +        state =3D ad_public_broadcast_state();
> +               if (state)
> +            bt_shell_printf("Public Broadcast: %s\n", state);
> +        else
> +            bt_shell_printf("Public Broadcast not set\n");
> +
> +               return bt_shell_noninteractive_quit(EXIT_SUCCESS);
> +    }
> +
> +    if (!strlen(argv[1])) {
> +        bt_shell_printf("Public broadcast value cannot be empty\n");
> +        return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +    }
> +
> +    if (!strcasecmp(argv[1], "sq"))
> +        data.data[0] =3D 0x02;
> +    else if (!strcasecmp(argv[1], "hq"))
> +        data.data[0] =3D 0x04;

Are these bits? If they are, let's use BIT(1) and BIT(2).

> +    else {
> +        bt_shell_printf("Invalid argument: accepted values are sq or hq\=
n");
> +        return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +    }
> +
> +    ad_clear_service(AD_TYPE_AD);
> +
> +    ad.service[AD_TYPE_AD].uuid =3D g_strdup(AD_PUBLIC_BROADCAST_UUID);
> +    ad.service[AD_TYPE_AD].data =3D data;
> +
> +    g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE,
> +        prop_names.service[AD_TYPE_AD]);
> +
> +    return bt_shell_noninteractive_quit(EXIT_SUCCESS);
> +}
> +
>  void ad_advertise_data(DBusConnection *conn, int type, int argc, char *a=
rgv[])
>  {
>         char *endptr =3D NULL;
> diff --git a/client/advertising.h b/client/advertising.h
> index 9d124c7af..98f1bc524 100644
> --- a/client/advertising.h
> +++ b/client/advertising.h
> @@ -34,6 +34,8 @@ void ad_advertise_local_appearance(DBusConnection *conn=
, long int *value);
>  void ad_advertise_duration(DBusConnection *conn, long int *value);
>  void ad_advertise_timeout(DBusConnection *conn, long int *value);
>  void ad_advertise_data(DBusConnection *conn, int type, int argc, char *a=
rgv[]);
> +void ad_advertise_public_broadcast(DBusConnection *conn, int argc,
> +                                char *argv[]);
>  void ad_disable_data(DBusConnection *conn, int type);
>  void ad_advertise_discoverable(DBusConnection *conn, dbus_bool_t *value)=
;
>  void ad_advertise_discoverable_timeout(DBusConnection *conn, long int *v=
alue);
> diff --git a/client/main.c b/client/main.c
> index 57fa13888..5fd21c80d 100644
> --- a/client/main.c
> +++ b/client/main.c
> @@ -2920,6 +2920,17 @@ static char *scan_generator(const char *text, int =
state)
>         return argument_generator(text, state, scan_arguments);
>  }
>
> +static const char *public_broadcast_arguments[] =3D {
> +    "sq",
> +    "hq",
> +    NULL
> +};

I wonder if we should have better names for these, Android seems to
have a setting for compatibility, not sure exactly what it means in
terms of adv settings though.

> +
> +static char *public_broadcast_generator(const char *text, int state)
> +{
> +    return argument_generator(text, state, public_broadcast_arguments);
> +}
> +
>  static void cmd_advertise(int argc, char *argv[])
>  {
>         dbus_bool_t enable;
> @@ -2970,6 +2981,11 @@ static void cmd_advertise_data(int argc, char *arg=
v[])
>         ad_advertise_data(dbus_conn, AD_TYPE_AD, argc, argv);
>  }
>
> +static void cmd_advertise_public_broadcast(int argc, char *argv[])
> +{
> +    ad_advertise_public_broadcast(dbus_conn, argc, argv);
> +}
> +
>  static void cmd_advertise_sr_uuids(int argc, char *argv[])
>  {
>         ad_advertise_uuids(dbus_conn, AD_TYPE_SRD, argc, argv);
> @@ -3653,6 +3669,9 @@ static const struct bt_shell_menu advertise_menu =
=3D {
>                         "Set/Get advertise manufacturer data" },
>         { "data", "[type] [data=3Dxx xx ...]", cmd_advertise_data,
>                         "Set/Get advertise data" },
> +       { "public-broadcast", "[sq/hq]", cmd_advertise_public_broadcast,
> +            "Set/Get BLE Audio Public Broadcast Announcement",
> +            public_broadcast_generator },
>         { "sr-uuids", "[uuid1 uuid2 ...]", cmd_advertise_sr_uuids,
>                         "Set/Get scan response uuids" },
>         { "sr-solicit", "[uuid1 uuid2 ...]", cmd_advertise_sr_solicit,
> --
> 2.53.0
>
>


--=20
Luiz Augusto von Dentz
