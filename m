Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D6AC0015E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Jul 2023 19:12:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjGYTMq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Jul 2023 15:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbjGYTMm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Jul 2023 15:12:42 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18A71BDA
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jul 2023 12:12:36 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b974031aeaso66950881fa.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jul 2023 12:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690312355; x=1690917155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KluA/XIpxJA1rRKd6K3r2oojJvDMTS0Q5/F5t5pahbU=;
        b=S+RfmZOGqEJ8/Iw2T5wx8wIbQ21BtKUSAH6rBYZCqpJz1Y3m1lR+mlqMGsWr2Wn3Bj
         VhvHZucikE6FER3/tV1+x5Dhi0Phc5lBmHpukfF67rz6eE6qKZVj5l6r97yzRMg49oYm
         GLqv6IkeaXcuNN4tyuoLL082S6DKE6NxlQ1i3VJO/TOA+rWkUNHJSEUo04LJ5zcA+64T
         VA6ZX7Bgi9bMDNDZdD7s4Q/sIlGDPK+uxVcpQYJpnOsiw1/V1e0CIW8ot9CblgyhU8HB
         m8SXk3jYitURJJqzK/9DsSIEx6q8ODdnwa9KcSenuDbtLWQNOkVxXMDMM0FNkPA8Po/E
         hGdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690312355; x=1690917155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KluA/XIpxJA1rRKd6K3r2oojJvDMTS0Q5/F5t5pahbU=;
        b=chwwc6DBsYzJyGVGaX5Yj7QUFg55aak39bxvRazUm0Cvefxzjg8tupzlW0zO/e2pph
         co1cyp8TtrXjoy1qyRD+d1KTV6lBjlNGRmqGCiXFToL9+73pdBIRc0VxMB+0Anfl57vY
         sfMKzheqnLwMdSeLhD9+Z+vDnRmvR3Sw+U6UwI5YFyiusT86f1oX/x5kujQ4YbdqUH7L
         qp3FXiezyWGhmJvzFfPkCkW/Vyy6MKBTM9qmDzevqF2Rsgtgh79nZUc/a5+K+LbBKm3S
         epJwRzy5L2Tcm3Cfc14yDbNMrm/yo3//EC2k4j+dR9SZTgL6UCN38JJjMoM1/QGxaPWF
         FAgA==
X-Gm-Message-State: ABy/qLbx7bsxnwjF4f6rAhNNXz7H0nXdRbsy0X5P7Vp4J2eBCnn8ad51
        nxFl4qfBgg9CyMv13e7kaGj8f/9Bc7/dl4gbhcqwyxhM
X-Google-Smtp-Source: APBJJlHvR4rZApqRYiFRQjj6vQYJheusrGd1kQf5aygYVV8d3Sz8g6GSXs+wKwEbFzjLxNO71T/EKvZaj+R0jvtwCfw=
X-Received: by 2002:a2e:b712:0:b0:2b6:da64:734f with SMTP id
 j18-20020a2eb712000000b002b6da64734fmr9287832ljo.47.1690312354602; Tue, 25
 Jul 2023 12:12:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230725084431.640332-1-simon.mikuda@streamunlimited.com> <20230725084431.640332-6-simon.mikuda@streamunlimited.com>
In-Reply-To: <20230725084431.640332-6-simon.mikuda@streamunlimited.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 25 Jul 2023 12:12:22 -0700
Message-ID: <CABBYNZJ81vnZNnAhBFyu7_-5Mr0yxEtprk-7Gd6ZtzZNvx5nMA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 5/8] device: Fix pairing and discovery with dual
 mode devices
To:     Simon Mikuda <simon.mikuda@streamunlimited.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Simon,

On Tue, Jul 25, 2023 at 1:56=E2=80=AFAM Simon Mikuda
<simon.mikuda@streamunlimited.com> wrote:
>
> We'll prefer to pair and discover services on connected bearer first.
>
> There was a problem with pairing, that select_conn_bearer returned BR/EDR
> even when we have connection to LE bearer only. In these situation we sho=
uld
> pair over connected bearer, since connection to another bearer can fail.
>
> Similar problem with discovery that after connection on LE bearer discove=
ry
> was requested on BR/EDR bearer which can cause connection error (e.g. Pag=
e
> Timeout).
> ---
>  src/device.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
>
> diff --git a/src/device.c b/src/device.c
> index 6f28e261e..446e978ee 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -2504,6 +2504,16 @@ static uint8_t select_conn_bearer(struct btd_devic=
e *dev)
>         return dev->bdaddr_type;
>  }
>
> +static uint8_t select_active_bearer(struct btd_device *dev)
> +{
> +       if (dev->bredr_state.connected)
> +               return BDADDR_BREDR;
> +       else if (dev->le_state.connected)
> +               return dev->bdaddr_type =3D=3D BDADDR_BREDR
> +                       ? BDADDR_LE_PUBLIC : dev->bdaddr_type;

The code above assumes BR/EDR has the priority in case both are
connected, perhaps we should have a clear policy in case both are
connected.

> +       return select_conn_bearer(dev);
> +}
> +
>  static DBusMessage *dev_connect(DBusConnection *conn, DBusMessage *msg,
>                                                         void *user_data)
>  {
> @@ -3018,7 +3028,7 @@ static DBusMessage *pair_device(DBusConnection *con=
n, DBusMessage *msg,
>         else if (device->le_state.bonded)
>                 bdaddr_type =3D BDADDR_BREDR;
>         else
> -               bdaddr_type =3D select_conn_bearer(device);
> +               bdaddr_type =3D select_active_bearer(device);
>
>         state =3D get_state(device, bdaddr_type);
>
> @@ -3055,7 +3065,7 @@ static DBusMessage *pair_device(DBusConnection *con=
n, DBusMessage *msg,
>                         err =3D device_connect_le(device);
>                 else
>                         err =3D adapter_create_bonding(adapter, &device->=
bdaddr,
> -                                                       device->bdaddr_ty=
pe,
> +                                                       bdaddr_type,
>                                                         io_cap);
>         } else {
>                 err =3D adapter_create_bonding(adapter, &device->bdaddr,
> @@ -6207,12 +6217,9 @@ static bool start_discovery_cb(gpointer user_data)
>  {
>         struct btd_device *device =3D user_data;
>
> -       if (device->bredr)
> -               device_browse_sdp(device, NULL);
> -       else
> -               device_browse_gatt(device, NULL);
> -
>         device->discov_timer =3D 0;
> +       device_discover_services(device, select_active_bearer(device),
> +                       NULL);

Perhaps in case of discovery we could do both in parallel, although if
the remote side supports GATT services as part of SDP we may end up
with redundant discovery but bt_gatt_client/gatt_db shall be able to
handle that.

>         return FALSE;
>  }
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
