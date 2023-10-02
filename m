Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 538A5E7491F
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Oct 2023 21:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjJBVVi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Oct 2023 17:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjJBVVh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Oct 2023 17:21:37 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77047A4
        for <linux-bluetooth@vger.kernel.org>; Mon,  2 Oct 2023 14:21:34 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2bffdf50212so2174231fa.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Oct 2023 14:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696281693; x=1696886493; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jCVLqNqyj1ppWnZ9AH0dZshCKn4F8OT28jO1i4PdCxY=;
        b=RaK+C95hS4w6q+X/FcQo4Cb2doBgQw0oZhK7vRY8bPnClE16KhmoD28f9QH7bMwl2G
         jWbEp/dZYHfeGST2uvfP1BsG36xFV9E8LR0u6YOH0xgEc08Ke76feMQvkNUrExR7CZBL
         ye9QYfK3DSlw36s5oVeTzDFYvMqYs74KkmZJVkz66hUyUpMh0f/maaI99aO2eU7PzabH
         P8e3FgpFGUjLL18z1TXcRsiE53himl3oUTLuSyh5DeFX0i8E5LzoXH7aud6C+tsEotvy
         pQmcv8Tb7eKkPdvvhr2WydGLjM5SJa7Ofgf0wJsae0wJSyHGMaqr6RULdSYK0+v+1Ov/
         TsYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696281693; x=1696886493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jCVLqNqyj1ppWnZ9AH0dZshCKn4F8OT28jO1i4PdCxY=;
        b=jp1JHkcyIaGlDIeMq8SRA+elFx76i7tJe6hw1PRrL4pNJfntCBGrxA702K1cV81pG6
         L0ucehn3I3XTTTTDcCgKxm4PVphN9gswDhiNTOh02xireFdXsdfTke9piyZ3Z6zZZgQi
         eANv08RoE6vN5Rssvs0k0IwNq7yxNWeOZ5ktiRD+C9lMmfzsNZAiSGgQf1d5oofJ/7Jy
         dxkfQKkWJMDCfykLUrYloLa7IdwqzNdh5ItolrMj5uziiVNNmZTXoBUPjDasU9htJ1aE
         yiR7YGY98YU6PfU5DBDsmQd8nHPyrVKKxWJoW43YGV/AJTC8UVGfk7NNn2d0segC/18G
         qZ3Q==
X-Gm-Message-State: AOJu0Ywsjb4gnDQkY0e29yhuKgOJcxeKvKktEFwIIrzcYCWXCBDyBGuz
        /0OdRA6bj2/AaNkkilI7g2vrMnXNBtIXjhlzC4StPiQ8rD1ycA==
X-Google-Smtp-Source: AGHT+IF1ST9ydsVhIqMzpfN+nXG/yhYRfcVakmYrfLLI1Sxm2IeAzfJN8HJTUNfI1LVgYe97Uh+GpucOT3QZ+UzM10o=
X-Received: by 2002:a2e:964d:0:b0:2c0:192a:c567 with SMTP id
 z13-20020a2e964d000000b002c0192ac567mr12798540ljh.20.1696281692314; Mon, 02
 Oct 2023 14:21:32 -0700 (PDT)
MIME-Version: 1.0
References: <20231002123738.22210-1-vlad.pruteanu@nxp.com> <20231002123738.22210-2-vlad.pruteanu@nxp.com>
In-Reply-To: <20231002123738.22210-2-vlad.pruteanu@nxp.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 2 Oct 2023 14:21:19 -0700
Message-ID: <CABBYNZJguwGA6VJRqPmUUP2TiicAFUHu5BifRgDn=6bQhyDjGA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/1] client/player: Allow the user to control BIG encryption
To:     Vlad Pruteanu <vlad.pruteanu@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
        mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com,
        iulia.tanasescu@nxp.com, andrei.istodorescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Vlad,

On Mon, Oct 2, 2023 at 5:37=E2=80=AFAM Vlad Pruteanu <vlad.pruteanu@nxp.com=
> wrote:
>
> This commit adds support for controling the use of encryption and
> setting the broadcast code. This is done as part of the endpoint.config
> command. For source endpoints the encryption flag and broadcast code can
> be set, while the sink supports only broadcast code setting. If no custom
> broadcast code is provided, the default one will be used.
> ---
>  client/player.c | 50 ++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 43 insertions(+), 7 deletions(-)
>
> diff --git a/client/player.c b/client/player.c
> index d1809f24f..3a9313bfd 100644
> --- a/client/player.c
> +++ b/client/player.c
> @@ -2792,10 +2792,10 @@ static void cmd_config_endpoint(int argc, char *a=
rgv[])
>         const struct capabilities *cap;
>         char *uuid;
>         uint8_t codec_id;
> -       bool broadcast =3D false;
> +       bool local_ep_not_provided =3D false;
> +       uint8_t bcode_arg_position =3D 0;
>
>         cfg =3D new0(struct endpoint_config, 1);
> -
>         /* Search for the remote endpoint name on DBUS */
>         cfg->proxy =3D g_dbus_proxy_lookup(endpoints, NULL, argv[1],
>                                                 BLUEZ_MEDIA_ENDPOINT_INTE=
RFACE);
> @@ -2815,7 +2815,7 @@ static void cmd_config_endpoint(int argc, char *arg=
v[])
>                 codec_id =3D strtol(argv[3], NULL, 0);
>                 cap =3D find_capabilities(uuid, codec_id);
>                 if (cap) {
> -                       broadcast =3D true;
> +                       local_ep_not_provided =3D true;
>                         cfg->ep =3D endpoint_new(cap);
>                         cfg->ep->preset =3D find_presets_name(uuid, argv[=
3]);
>                         if (!cfg->ep->preset)
> @@ -2827,9 +2827,10 @@ static void cmd_config_endpoint(int argc, char *ar=
gv[])
>                 }
>         }
>
> -       if (((broadcast =3D=3D false) && (argc > 3)) ||
> -               ((broadcast =3D=3D true) && (argc > 4))) {
> -               char *preset_name =3D (broadcast =3D=3D false)?argv[3]:ar=
gv[4];
> +       if (((local_ep_not_provided =3D=3D false) && (argc > 3)) ||
> +               ((local_ep_not_provided =3D=3D true) && (argc > 4))) {
> +               uint8_t offset =3D (local_ep_not_provided =3D=3D false)?0=
:1;
> +               char *preset_name =3D argv[3 + offset];
>
>                 preset =3D preset_find_name(cfg->ep->preset, preset_name)=
;
>                 if (!preset) {
> @@ -2837,7 +2838,42 @@ static void cmd_config_endpoint(int argc, char *ar=
gv[])
>                         goto fail;
>                 }
>
> +               /* If the endpoint is configured to be a source allow
> +                *the user to decide if encryption is enabled or not.
> +                */
> +               if (!strcmp(cfg->ep->uuid, BCAA_SERVICE_UUID) &&
> +                       argc > 4 + offset) {
> +                       uint8_t value =3D strtol(argv[4 + offset],
> +                                                       NULL, 0);
> +
> +                       if (value < 2)
> +                               bcast_qos.bcast.encryption =3D value;
> +                       else
> +                               goto fail;
> +               }
> +
> +               /* If the endpoint is configured to be a source or a
> +                *sink allow the user to set a custom broadcast code.
> +                *If no broadcast code is set, the default will be used.
> +                */
> +               if (!strcmp(cfg->ep->uuid, BCAA_SERVICE_UUID) &&
> +                       (argc > 5 + offset))
> +                       bcode_arg_position =3D 5 + offset;
> +
> +               /*The broadcast code is found at a smaller index due to t=
he sink
> +                *config not using the encryption flag parameter.
> +                */
> +               if (!strcmp(cfg->ep->uuid, BAA_SERVICE_UUID) &&
> +                       argc > 4 + offset)
> +                       bcode_arg_position =3D 4  + offset;
> +
> +               if (bcode_arg_position !=3D 0)
> +                       for (uint8_t i =3D 0; i < 16; i++)
> +                               bcast_qos.bcast.bcode[i] =3D
> +                               strtol(argv[bcode_arg_position + i], NULL=
, 16);
> +
>                 if (cfg->ep->broadcast) {
> +
>                         iov_append(&cfg->ep->bcode, bcast_qos.bcast.bcode=
,
>                                 sizeof(bcast_qos.bcast.bcode));
>                         /* Copy capabilities for broadcast*/
> @@ -3253,7 +3289,7 @@ static const struct bt_shell_menu endpoint_menu =3D=
 {
>                                                 "Register Endpoint",
>                                                 local_endpoint_generator =
},
>         { "config",
> -               "<endpoint> [local endpoint/UUID] [preset/codec id] [pres=
et]",
> +               "<endpoint> [local endpoint/UUID] [preset/codec id] [pres=
et] [encryption] [broadcast code=3Dxx xx ...]",

I think I'd prefer to have it prompted (see bt_shell_prompt_input) to
the user when we detect it is configuring a broadcast transport,
rather than have it passed upfront which might confuse the user of
unicast where the encryption is done at a different layer.

>                                                 cmd_config_endpoint,
>                                                 "Configure Endpoint",
>                                                 endpoint_generator },
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
