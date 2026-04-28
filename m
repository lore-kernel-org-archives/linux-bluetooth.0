Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B203033CF
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2026 14:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777387355; cv=pass; b=rO8NSYB6H86gX3hi+ABJfWmE1C8I6nFRCMNKG4zNpmN8qa3Uq43fAqHPs+YMjvVXFepX2inxXQcMW0miacre73wsLKEINsFVHAZAXntE82PNot3yDbFmtpnL8Asr8tXNj9s8Pee536X8yRaQxpikoj+TALmbjt/rYGc7q6I4hPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777387355; c=relaxed/simple;
	bh=p1wqucepv6wgTUeKXWKODa2B4LwnLJ5ybEfwGe17PGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L6+R/ktxXSJJ13+r7jbxf5yUlezExfR1BsS0nLdilJFAv2kLS31UmHiqNXHdtFZSN87k/cEncEClzClJb/Oh6Rt3tiLkgruMwxzjZylLnpOnF9Vd/LkaR8MWbZAECYJ9sle59RghXoXePTvHMCbNdxZT6iue2i6pCpZeKgRkNG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b+zlRU+1; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+zlRU+1"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-652f220595fso11641132d50.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2026 07:42:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777387346; cv=none;
        d=google.com; s=arc-20240605;
        b=jXwQwN2uXI7EFtvyAnuTKAbv82PJhKCbsmW4+Ca8vPrGaMqN0eP3Mpq+jGYd4zvuHV
         7nR1dnKdKoXwQoTUVDdIfj1qDhQG+c2l6XlKL7MOHcgQOTPqFJyP58BGeL/BmX95CAth
         7CqWa9WIQdlbos7BFXvwHbMfv8xwXxTQ7vkETAIG56V1lG9M7q6xG6Npqx5olVbpBX8U
         1mqlayEqE0pgJcGVcVut6ak0GPAcIVpvR8mPb9TN45GeS753TWsvJKoIWiSew9xh5XJy
         XyRvtp2BndwDTUHDfB0kVKau79nvu8H/YM2GSJiX+8ovxeRJXqyxY5l2NL4JoCqKgwBk
         0gXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=p1wqucepv6wgTUeKXWKODa2B4LwnLJ5ybEfwGe17PGM=;
        fh=2PSdDMOkPZoY5Pg+8FqsRSolwO7zgkokkzv2bf/ICOs=;
        b=Z2b8CKR6qhkmhl5YDP3yQ3Au6cWlvted99mu9mQMVfqL+eI5+C2/lyqqwu+diq4E+2
         QXzJlkWX00V/syyfM8/uc+1HQ6kdrB/x9lYB/p+yJqXVLy6FniKpnir3s7Ae4yrwuBhd
         qYZciL9RrnPmvIsH2ALOk8UUCD87pvuMixo+McRZ0JkYIh45Q6mUgWz+Hz6f0hw5jj1+
         UznOorJ1iSyBysx5zFEYQvrdzaURVmGwm8wYZHhwjuZjI5qOAEZCm/kRyyZ2uhGrIigM
         LU5Ene6jX39D17sXPPcToISm/wtl0O5ZZPxBYpbfygFz0G0Qz+8o6OczAUjHmytG8Gn/
         W1oA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777387346; x=1777992146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p1wqucepv6wgTUeKXWKODa2B4LwnLJ5ybEfwGe17PGM=;
        b=b+zlRU+1RNZmYRuju1+1T5tQ16n6/yOq5NJ2AmqcM1PhCSTZ5uEJUJVG9GBoRg77Y1
         83mQfSxafomzQIm6WsZqTP+uFFkBzzEwYwDiYlpstohT0Emcw8sbAUAUWgXpAKush9+g
         EjUfLzc2Sci628ceiEnwrPQWfj8S03Q1dh9WC/w8toJPonYSY1UARjw3JNTIbRpFGkvf
         O/glUa/k4t3y8SICUtlmQBnoTEqoE880BXnXSMOcZBG8AkcJaaxErdZtypCnUgaWBaTO
         w5BBj1oEI4SEb4d37wYjSzy6sJM1n+ytazYV20mv+yo3SnO1MyyIrAdP6hby1xxnkRNs
         jEnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777387346; x=1777992146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p1wqucepv6wgTUeKXWKODa2B4LwnLJ5ybEfwGe17PGM=;
        b=m4TOwfmaEyYM5JmTtamWkNZln3zp6S7QfetZ9XcM4i2Wni2sUKPVSGEL838VbqelAd
         0Bk/S6tdEOfC7KpOsnEAK84nJaMGRF5Q1Zmj4uH9GLamP/dT0Zp6P8F8LHzouW939Jyz
         N9nBe4aZr3LCrIn7mR73OJ2euV6nQ5FeXeDTvKrgiE+X+NINMNhz6bPpkauw4EQf3Kxq
         nd8EflZmrX5k4vApc39upwJks1hG2gRkeDKiYB7P7Mqr38fagRUXvfe0ARi/xabxeEgL
         mJkh2RlLdfscrX8TtB+mGzWCyuWh49G14zunimp1J9BN3Nd9SHVT4C0n6A5mjUAHZaF/
         xfIg==
X-Gm-Message-State: AOJu0YwDxJQNrBpQ4T6jfpoHqKFOGr0sZkp/tYDvnwwDcsDPJNTI9v9m
	zjf/xstRMAn2G4DkrMYfjZ1iOVSZcW4zoIZQ3Wj/1BK2vHgXnQlOtazvd65eaTV5DtaToK50Llc
	3f50EnAPUZri0aeuZJ0LFhRVDFQPQ/1Q=
X-Gm-Gg: AeBDiesUSPdJjYBer+4z/exNES6jDZP55sM/4QwO4WHzU8cOcwuCRWTvrKZjaaiKo8X
	S+nsg0BVVI86VPcx/vncoKVCg6qRa/BePOdQKgYlYUQUui8KP788K7E1tkd5m++35qys/zvKV6M
	yjnaqwG8UKjtEuBTcSmUnCPv+v3yH66mYpHr5IN/2l9aqTaORJdJyGhqX9ek1gbgxslcqCNOd1q
	DdAZzbPxC774uEe7fwqyxb5YqudZYsyzGpCi5PIUUvmCCCfSiwZD3NGxDcrFnTrKdFUZMDZnqaR
	W77bbNkDheVXRKDbz5carE9LPV5KbQfb3XoPIQlArLHL2fqs+nUDRZe2sxG4JhymFyTQWD3PXb4
	N2A==
X-Received: by 2002:a05:690e:d0a:b0:64c:b81d:2cb7 with SMTP id
 956f58d0204a3-65beee3eccbmr2963908d50.39.1777387346049; Tue, 28 Apr 2026
 07:42:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317142645.6332-1-raghavendra.rao@collabora.com>
 <20260424141831.9172-1-raghavendra.rao@collabora.com> <20260424141831.9172-2-raghavendra.rao@collabora.com>
 <CABBYNZKXGxv0kVVOYZW0AsnQ2Qgx0NhAJ99k3kmjDeGgMcZ84Q@mail.gmail.com> <19dd4843cc9.16a62f4c253537.8494966934612526917@collabora.com>
In-Reply-To: <19dd4843cc9.16a62f4c253537.8494966934612526917@collabora.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 28 Apr 2026 10:42:14 -0400
X-Gm-Features: AVHnY4LCO6nMzXTUaXsXcsWoDJFW6xBJeDeeGZ6BFvrnq-yxNkmQ9r29uKAC1mM
Message-ID: <CABBYNZKTccPXbgbGH7urrhs23FN_aA5HLe-trZUg07wwpcVX5Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] client: add public-broadcast advertising command
To: Raghavendra Rao <raghavendra.rao@collabora.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Raghavendra,

On Tue, Apr 28, 2026 at 10:35=E2=80=AFAM Raghavendra Rao
<raghavendra.rao@collabora.com> wrote:
>
> Hello Luiz,
>
> I agree that adding a decoder for UUID 0x1856 would be useful.
> I would like to work on that and send it as a follow-up patch.

Too late, Ive already send a patch to address it:

https://patchwork.kernel.org/project/bluetooth/patch/20260427192223.2875358=
-1-luiz.dentz@gmail.com/

>
> Thanks & Regards,
> Raghavendra
>
>
>
> From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> To: "raghu447"<raghavendra.rao@collabora.com>
> Cc: <linux-bluetooth@vger.kernel.org>
> Date: Fri, 24 Apr 2026 20:14:00 +0530
> Subject: Re: [PATCH v2 1/2] client: add public-broadcast advertising comm=
and
>
> Hi,
>
> On Fri, Apr 24, 2026 at 10:19=E2=80=AFAM raghu447 <raghavendra.rao@collab=
ora.com> wrote:
> >
> > From: raghavendra <raghavendra.rao@collabora.com>
> >
> > ---
> > client/advertising.c | 71 ++++++++++++++++++++++++++++++++++++++++++++
> > client/advertising.h | 2 ++
> > client/main.c | 19 ++++++++++++
> > 3 files changed, 92 insertions(+)
> >
> > diff --git a/client/advertising.c b/client/advertising.c
> > index f9df1b855..fc51f8193 100644
> > --- a/client/advertising.c
> > +++ b/client/advertising.c
> > @@ -20,6 +20,9 @@
> > #include <string.h>
> > #include <errno.h>
> >
> > +#include "bluetooth/bluetooth.h"
> > +#include "bluetooth/uuid.h"
> > +
> > #include "gdbus/gdbus.h"
> > #include "src/shared/util.h"
> > #include "src/shared/shell.h"
> > @@ -27,6 +30,7 @@
> >
> > #define AD_PATH "/org/bluez/advertising"
> > #define AD_IFACE "org.bluez.LEAdvertisement1"
> > +#define AD_PUBLIC_BROADCAST_UUID "0x1856"
>
> Forgot to mention, we don't seem to have a decoder for 0x1856, would
> you like to create one so we can actually see what is being programmed
> on btmon? That will probably require extending the
> monitor/packet.c:service_data_decoders
>
> > struct ad_data {
> > uint8_t data[245];
> > @@ -1005,6 +1009,73 @@ static void ad_clear_data(int type)
> > memset(&ad.data[type], 0, sizeof(ad.data[type]));
> > }
> >
> > +static bool ad_is_public_broadcast_uuid(const char *uuid)
> > +{
> > + return uuid && !bt_uuid_strcmp(uuid, AD_PUBLIC_BROADCAST_UUID);
> > +}
> > +
> > +static const char *ad_public_broadcast_state(void)
> > +{
> > + if (!ad_is_public_broadcast_uuid(ad.service[AD_TYPE_AD].uuid))
> > + return NULL;
> > +
> > + if (ad.service[AD_TYPE_AD].data.len !=3D 2)
> > + return NULL;
> > +
> > + if (ad.service[AD_TYPE_AD].data.data[0] =3D=3D 0x02 &&
> > + ad.service[AD_TYPE_AD].data.data[1] =3D=3D 0x00)
> > + return "sq";
> > +
> > + if (ad.service[AD_TYPE_AD].data.data[0] =3D=3D 0x04 &&
> > + ad.service[AD_TYPE_AD].data.data[1] =3D=3D 0x00)
> > + return "hq";
> > +
> > + return NULL;
> > +}
> > +
> > +void ad_advertise_public_broadcast(DBusConnection *conn, int argc, cha=
r *argv[])
> > +{
> > + struct ad_data data =3D {
> > + .data =3D { 0x00, 0x00 },
> > + .len =3D 2,
> > + };
> > + const char *state;
> > +
> > + if (argc < 2) {
> > + state =3D ad_public_broadcast_state();
> > + if (state)
> > + bt_shell_printf("Public Broadcast: %s\n", state);
> > + else
> > + bt_shell_printf("Public Broadcast not set\n");
> > +
> > + return bt_shell_noninteractive_quit(EXIT_SUCCESS);
> > + }
> > +
> > + if (!strlen(argv[1])) {
> > + bt_shell_printf("Public broadcast value cannot be empty\n");
> > + return bt_shell_noninteractive_quit(EXIT_FAILURE);
> > + }
> > +
> > + if (!strcasecmp(argv[1], "sq"))
> > + data.data[0] =3D 0x02;
> > + else if (!strcasecmp(argv[1], "hq"))
> > + data.data[0] =3D 0x04;
> > + else {
> > + bt_shell_printf("Invalid argument: accepted values are sq or hq\n");
> > + return bt_shell_noninteractive_quit(EXIT_FAILURE);
> > + }
> > +
> > + ad_clear_service(AD_TYPE_AD);
> > +
> > + ad.service[AD_TYPE_AD].uuid =3D g_strdup(AD_PUBLIC_BROADCAST_UUID);
> > + ad.service[AD_TYPE_AD].data =3D data;
> > +
> > + g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE,
> > + prop_names.service[AD_TYPE_AD]);
> > +
> > + return bt_shell_noninteractive_quit(EXIT_SUCCESS);
> > +}
> > +
> > void ad_advertise_data(DBusConnection *conn, int type, int argc, char *=
argv[])
> > {
> > char *endptr =3D NULL;
> > diff --git a/client/advertising.h b/client/advertising.h
> > index 9d124c7af..98f1bc524 100644
> > --- a/client/advertising.h
> > +++ b/client/advertising.h
> > @@ -34,6 +34,8 @@ void ad_advertise_local_appearance(DBusConnection *co=
nn, long int *value);
> > void ad_advertise_duration(DBusConnection *conn, long int *value);
> > void ad_advertise_timeout(DBusConnection *conn, long int *value);
> > void ad_advertise_data(DBusConnection *conn, int type, int argc, char *=
argv[]);
> > +void ad_advertise_public_broadcast(DBusConnection *conn, int argc,
> > + char *argv[]);
> > void ad_disable_data(DBusConnection *conn, int type);
> > void ad_advertise_discoverable(DBusConnection *conn, dbus_bool_t *value=
);
> > void ad_advertise_discoverable_timeout(DBusConnection *conn, long int *=
value);
> > diff --git a/client/main.c b/client/main.c
> > index 57fa13888..5fd21c80d 100644
> > --- a/client/main.c
> > +++ b/client/main.c
> > @@ -2920,6 +2920,17 @@ static char *scan_generator(const char *text, in=
t state)
> > return argument_generator(text, state, scan_arguments);
> > }
> >
> > +static const char *public_broadcast_arguments[] =3D {
> > + "sq",
> > + "hq",
> > + NULL
> > +};
> > +
> > +static char *public_broadcast_generator(const char *text, int state)
> > +{
> > + return argument_generator(text, state, public_broadcast_arguments);
> > +}
> > +
> > static void cmd_advertise(int argc, char *argv[])
> > {
> > dbus_bool_t enable;
> > @@ -2970,6 +2981,11 @@ static void cmd_advertise_data(int argc, char *a=
rgv[])
> > ad_advertise_data(dbus_conn, AD_TYPE_AD, argc, argv);
> > }
> >
> > +static void cmd_advertise_public_broadcast(int argc, char *argv[])
> > +{
> > + ad_advertise_public_broadcast(dbus_conn, argc, argv);
> > +}
> > +
> > static void cmd_advertise_sr_uuids(int argc, char *argv[])
> > {
> > ad_advertise_uuids(dbus_conn, AD_TYPE_SRD, argc, argv);
> > @@ -3653,6 +3669,9 @@ static const struct bt_shell_menu advertise_menu =
=3D {
> > "Set/Get advertise manufacturer data" },
> > { "data", "[type] [data=3Dxx xx ...]", cmd_advertise_data,
> > "Set/Get advertise data" },
> > + { "public-broadcast", "[sq/hq]", cmd_advertise_public_broadcast,
> > + "Set/Get BLE Audio Public Broadcast Announcement",
> > + public_broadcast_generator },
> > { "sr-uuids", "[uuid1 uuid2 ...]", cmd_advertise_sr_uuids,
> > "Set/Get scan response uuids" },
> > { "sr-solicit", "[uuid1 uuid2 ...]", cmd_advertise_sr_solicit,
> > --
> > 2.53.0
> >
> >
>
>
> --
> Luiz Augusto von Dentz
>
>
>


--=20
Luiz Augusto von Dentz
