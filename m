Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740373D410E
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2026 14:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777041853; cv=pass; b=errV9JVHtS2b67k+kGp8wyZr5sWwnDKDh5kqoMJNlB75COEVWykZ/+znIz/F9gFSBfU77jlhdjzyxuSws+CxP5Hq6+kNZaWp/eO3ADcfE3T7qjyTPtKh8mIXsp5srJMszGQbRyKbFN3zhrCPn+MynleiNCPQ+TuMrZnuT8yA1xM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777041853; c=relaxed/simple;
	bh=8UyGr+7IDRCoxEfR7IF8+ZFaxLKzqi5IB/dKwh0Jw04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iDAjJ+KjkvCfNj+yt3cQZQ75L0Mj0tAt6U87XvwjQJiVetLYu8MbpFAcKXpHYahtOD6TNuMF3mqGAqMuCf5CHCi8NAbvCR15FRrhleZnVCNn6Afh94TYyZ8Vj+uLDHmqgTuzm6pcL8oi1LDgasSh18CCpEw4O/RZy4GCiAKqtxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LYVtSzLD; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYVtSzLD"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-64d5a7926cfso7932610d50.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2026 07:44:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777041851; cv=none;
        d=google.com; s=arc-20240605;
        b=KGJBp6sjoazKw/FGyYCprll96zAISgond8d5p+PEqNFR7G4u+o/drfEWBXGoLjWaHr
         27ob+IW7kEE/sLKYYywzp8ipKazart9Dl+oK4tqDYO05Ur1sCLzURA7SdWLHUW1jxU4+
         4lw8L2YTYZy3EP62Hqn2ebHPE8dPfzfww3gJsk2sxwu+/70+OhZGuW3hVUJlhPZzypoo
         eUn4lXcCs0LNo99G5E6QTPNAxME5T2fdL1JoJ6JwfYgGEcok5bf4yMAg3W7JMfwLdgIZ
         1xSxuqrGG70+njnnfLUMGijVrqRKhlL5klhv8JmZyQS9aiZ8vnxnTtV20LHG/VKWLWh1
         X1wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dLGeuJPVWr3+lJqklk/j4A0GqiySHErHU3CNareY6Q4=;
        fh=ZFlyP5+YKgJkmoBW5+QP1miOu0vNYasz89rr0yCZ/+4=;
        b=ZBT0V1Jjm2hcvpufMLdH8vMsJdysvLRByywOBXPBzAkawKZnRAI2fg1ORixCwyFbNH
         G9rvOG41KyebEmC5pewnX8LM8/ChLJ3vmQ0AN8VMCRty+gTNZNYyFET7njxU3dzTXXsy
         NbzfkEsqcUVQDMeGs136S6oJ9TRxKR/9fTHDHjSfrk12ytfhelLEqTGxMGV4WPwi9hXt
         dTi1vqt1eqB0OG4YFPiF19aB9btShQmtbU9cl54MiPN7bSThiCHdKYIWK03Vu5uqUAXn
         KOOwjyyZAAIQHued2mHkARTFsvm2FqATmt24+N9eOzmuAhNhf3tlb6kQGMtYLk8TV4I1
         YZmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777041851; x=1777646651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dLGeuJPVWr3+lJqklk/j4A0GqiySHErHU3CNareY6Q4=;
        b=LYVtSzLDkeztT6wSl9NUow678JBNwNmMJuyBFohpd+AZO1My6WScUqnFq9XhOkP78N
         eskmx7cl7zHe4CWl0Ko64QVT5bef9Zk2B0/njvRjuXrscEEIzlMOGRYj1wPdTGttVk6O
         IYUd0AbsYb5UKRKGlpF/ECACXOVXspGcykmqSfcgTWKL2RvP7TOqVqvgkDgBf3otKtef
         SHFQGa1Kx/EEnOWmAH4N1IhAzEAiD5tsNIEHWKvPk5cp2foKYpGG9fajvjOuKKiHfb1Z
         GMg9xzeWv/vl9s0I4TqjCMOC8NCAB2oqLkq3oaTGnPxAaFUn1WZFR95mMioaCKExMWNk
         Tuzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777041851; x=1777646651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dLGeuJPVWr3+lJqklk/j4A0GqiySHErHU3CNareY6Q4=;
        b=Co62E8MyxQDRNJ09L7Anvtryg+VRtrzg4qt9UNVl+JBO/hqrXDnExDkPZsNzETKHEZ
         t/e9oCfMX4+6EZ11KOFmu5yE5naBkKX2vqOw+oM+J2wrvdDw53n5OKcWucDlOYgSktPF
         yfpMfWxVA1G03gFQljmevtRFcSZbpndZtPNP9kFgvq8wurCBfs5hwgPk52n3PQgdzuYr
         lrWUdLd2TcAmOFOrY7qQn3A6ufQ3KcvCfUDV5fOc/ANMi/XRwD47M+3/4GSLbuaUwVQ+
         X2ze123Q6ceE89aH4coBSBVocz1jHsrN7igKdKEdc6/d9kLK9v0zCcGobCct4pJpn4P1
         ayzA==
X-Gm-Message-State: AOJu0YzRDqh8tgvXUdFyzdt/1sc4aiGlPfMCaoa1TDUrw8Uxhj5QtcQp
	ESQ1xV9SjAgxNMoInHJzyKfvyLecRMBa8OtBGxDomc8gud59suTPkYM8AnTptDYWe3HVafjJ6Uj
	7OCruNKtX5xH8kKVgxwWB/4VwBclCBI5+3sAUbaE=
X-Gm-Gg: AeBDievP2lGLKY5lo6Uz2MW15yUedUJ1PZ9fYS+z5vugFW3xBRQrkTeV6lqiOOiWfSt
	WWS93bsnbQyPu+OI/E17bWX8G273oTsG6/MMMSv9vbVigAS7SNbaT5tn4gplVOy2AxzGse0oKvp
	qgSxCrG+jq6BsMyqGwjCzJk6OkLCzjNQoI5t1wDeaL3cbvtBpRSprfbTYcyA70/s2P4nUKMUdXp
	J3rR2YJkoPseCY6AIquQuFrd+1uaSmGxhC98hliNGYfuJJ+wp8ZTmoe0QjZYweoH5ttufk7hnPT
	0szvTveB90xctFeJzVoPFbjDggzyy6+5bPNm9uzvXXNpYFGIs6a0pGHERC8apJze46jvg+9e7MB
	C25Eu
X-Received: by 2002:a05:690e:23db:b0:651:c7b1:d1e2 with SMTP id
 956f58d0204a3-653109ae164mr20830634d50.37.1777041851312; Fri, 24 Apr 2026
 07:44:11 -0700 (PDT)
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
Date: Fri, 24 Apr 2026 10:44:00 -0400
X-Gm-Features: AQROBzCucbTUmxLs69Lem8jceDI1hpAiHaLrOqaKEroUEjsiybMM1kUvdxc2L8I
Message-ID: <CABBYNZKXGxv0kVVOYZW0AsnQ2Qgx0NhAJ99k3kmjDeGgMcZ84Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] client: add public-broadcast advertising command
To: raghu447 <raghavendra.rao@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

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

Forgot to mention, we don't seem to have a decoder for 0x1856, would
you like to create one so we can actually see what is being programmed
on btmon? That will probably require extending the
monitor/packet.c:service_data_decoders

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
