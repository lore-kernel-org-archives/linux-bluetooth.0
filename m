Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 734E4C001DC
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Jul 2023 18:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjG0SrM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Jul 2023 14:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbjG0SrJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Jul 2023 14:47:09 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5839F3594
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jul 2023 11:46:46 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b72161c6e9so32671831fa.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jul 2023 11:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690483604; x=1691088404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D3dCGkB2CqSVrXijKF0/PGpFfu+hd98oUmpfn0/x8MI=;
        b=LuBRtOU3cA/s7j+HDW3+F0d7X3BZgiMFE1wBTYbtLrFBj3KjD85qPebBTUnFfJ1mCn
         lvehu488sB5rLmA/QYik6TI4Bg6gLUuE6VYuL3kMZxyU80RNm57w/iAuUGdU82STXQjc
         T8gv+sJUOddqWE48gSg7d11E/rxBXauEgu31cEMmGIndPWEagxx0hisv/ikaY98RhAB1
         t7Z0TCSlPbB8tNpPUKdjW4NDsKg1AXcsQqExbZbI+G8fefUXJjWZB0bdwtOjtrvJA8T9
         wJzuGr2ZaYPyFNWxUGo7MYj+09X3n99QAWGa1l9m7ddsW/Lr1lzcAFjtDlVtE6ydNqxS
         M7Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690483604; x=1691088404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D3dCGkB2CqSVrXijKF0/PGpFfu+hd98oUmpfn0/x8MI=;
        b=fmna+D0x5RUBxKm/379fXslfzRzmRlMxjYNyL7qaUoK2l9o9RnFiIvP/N2Yf/CO4zW
         aFY9zAOfCTHRE79ykgLlXi29wwJEMTbX93TwiGy1N/XFMdKMetoLOMv8lYQmzyMzzYbi
         OIvBiU+hh7IrC7b/7fcy3hGeivZUENyYXmVAVaqtMkBUgb3Ay/YPjY4EBVvuRheNp0iH
         Gi9AKwfBKx2USk2ZvWzgl6Uf9YKUTe3RFRgcRT2dFsd9o2pbaoaE5l3wZu0zo+8RdrJF
         bblyfrR/TfUkQ9w8I5FR8EvjBR9fC79CUTIzrtO0GaIitJQ5196T3K5qrZGMV1gn0rj7
         0KOQ==
X-Gm-Message-State: ABy/qLZoaPkRT9A8aMUS3Ao/EgwQrEjAgJa2QGDM8G3OhvyrLKUp7pCy
        ALAWklrCY8SgIvZSaiAajKqXb6hz1jLB0aZIBbhBSmfu
X-Google-Smtp-Source: APBJJlF/MoBC/iBtwKz5L63h+eDW0k2FvD2MYnp5zJqRVYVpMjUca37MjC172sLa74h5+2+NNpo5OGGcSTv4lvpQv6U=
X-Received: by 2002:a2e:b74c:0:b0:2b9:b27c:f77d with SMTP id
 k12-20020a2eb74c000000b002b9b27cf77dmr1155312ljo.3.1690483604236; Thu, 27 Jul
 2023 11:46:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230725084431.640332-1-simon.mikuda@streamunlimited.com> <20230725084431.640332-7-simon.mikuda@streamunlimited.com>
In-Reply-To: <20230725084431.640332-7-simon.mikuda@streamunlimited.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 27 Jul 2023 11:46:32 -0700
Message-ID: <CABBYNZ+R2HFUiMY5xhLVPsWO20qM=+3h6_RVW=ar-gPq-oZTPA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 6/8] device: Handle error from discover services
 request after pair
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
> If discovery was requesed from pair request we will report successfull
> pairing even if there was an error during discovery.
> ---
>  src/device.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/src/device.c b/src/device.c
> index 446e978ee..35c46e451 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -6309,6 +6309,7 @@ void device_bonding_complete(struct btd_device *dev=
ice, uint8_t bdaddr_type,
>         struct bonding_req *bonding =3D device->bonding;
>         struct authentication_req *auth =3D device->authr;
>         struct bearer_state *state =3D get_state(device, bdaddr_type);
> +       int err;
>
>         DBG("bonding %p status 0x%02x", bonding, status);
>
> @@ -6358,8 +6359,16 @@ void device_bonding_complete(struct btd_device *de=
vice, uint8_t bdaddr_type,
>                 DBG("Proceeding with service discovery");
>                 /* If we are initiators remove any discovery timer and ju=
st
>                  * start discovering services directly */
> -               device_discover_services(device, bdaddr_type, bonding->ms=
g);
> -
> +               err =3D device_discover_services(device, bdaddr_type, bon=
ding->msg);
> +               if (err) {
> +                       if (device->pending_paired) {
> +                               g_dbus_emit_property_changed(dbus_conn, d=
evice->path,
> +                                               DEVICE_INTERFACE, "Paired=
");
> +                               device->pending_paired =3D false;
> +                       }
> +                       /* Disregard browse errors in case of Pair */
> +                       g_dbus_send_reply(dbus_conn, bonding->msg, DBUS_T=
YPE_INVALID);
> +               }
>                 bonding_request_free(bonding);
>         } else if (!state->svc_resolved) {
>                 if (!device->browse && !device->discov_timer &&
> --
> 2.34.1

This looks like a fix so I'd recommend sending it separately rewording
the commit to something like: device: Fix returning discovery error
for Device.Pair...

--=20
Luiz Augusto von Dentz
