Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBDB45BEF
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jan 2024 19:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706555498; cv=none; b=sCT/g+LAcBLvQ30gPbLvY/F3sYT7tmP9fnze2hKF3lF/1QINu7SDci7zjo4QyM9+NiNTzH2beu4c7KOI/N+Yrnh2rd2g2RExj+w3fXMXCNnvPUS92fg3mFGBueZLuYm01jBg/XONOCrSDNpfCSl5g7F2vNpssS1dImSQLJtrVLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706555498; c=relaxed/simple;
	bh=Joo3mYZWhYRd7Z9xLsuyXW9woMsMUM5XUu/v5RKEP0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tc+8PpnCKjuu/4gOeuH6Q3Snk4N8HYxOQIG3EanrZz7Jl+UadqshwaYbsjSdZ0pUEEJvmK5BhTWb2C0NVz28x7N681gNUS5r/X4Sy/hjS6sNLAwh5nWTCa06+Nlkh7voyoYNnLDs9UL9JqVF0Yd5HHah/UnW44DWDGrT0Zz6CFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J376zdV/; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J376zdV/"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d054204a2fso4964971fa.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jan 2024 11:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706555494; x=1707160294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GDKS1sgvBWtTXnYLRaT0LDV6+ILLbusL3017UnKP4d0=;
        b=J376zdV/1mr4nSORMD9Ilsf6BteEKfTLqRoJ+kmPA20Edyt3WJ81EmreAyH8bJw7+D
         cWpBXFg27EqDO3K/zZaSea0C8k86NPVaDpxiynaR5yB2iZVxa+JEPT3j+AjPy/7EQo7P
         BkcFAyjCO/rIJMMtmdOBMH5QIKEWF50QSe26H9+a+emVSQhv67Hu0hz7QBM6dp7dEzXl
         RugBtgujwQ4keNAsvPPcTdXWSE1U6zoooEqFdcBOtZdQwuLwAs+oTwLmHpwJdamG/X/G
         G6/dW/MbbdgP88Y6WyXJA/Ju+w031Cq6l7DexMMuDuZl66HOVTbGMDBaClj8dL1t+/2o
         I2FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706555494; x=1707160294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GDKS1sgvBWtTXnYLRaT0LDV6+ILLbusL3017UnKP4d0=;
        b=w3P7BxaP1drPjFiZaFVfkbDOcFmBGxtGOlVDU6wkw6/IAnlinrKW1lJzygaQiikQ+y
         iJM3RhIrssfoxd1RzA26F2m2amHxCCyQVq+4H8qLU7HWOSY6Erj3TMXWAG9cQkteIq5d
         s7IkqEzp52zYvhb9LaQfLi+uI281yEbtIhg62y8H4gaBMZODaqkxf4eXGhtqOiTrdTmr
         4drQN3jX1rYkcmgUA2fv9f0m8JXiJNdEuJHcM5F7b2f94QI3k6rVakDjiBDje3p+1bi8
         zAsO2wVHiJqcJZhs2PXIsevzwVn8XNQNJP7nsNpY5aHGhWsb3EqJvbJoiL+3YQayswEC
         9Nwg==
X-Gm-Message-State: AOJu0YzSpXBvZ0eR7SzhaQzEBJQrqOy86QZ1Q1/5bEC3xeCH5KRbWqNI
	N01JoTXtbuyN9GBzyHRezMctxNeHRA9aYeFTmrwD7gD/xH9vKmLXs+8wmiPvUchctDV3SMbO3Sz
	b69UjWtjzB837UaxIlWuIFXWCdrVNZRri
X-Google-Smtp-Source: AGHT+IEYz3r13NUJbwt8HtLwepHVfTxIINLqZE1up2vl+xaoUNyOfQjLaT4es3GR6H71de60kQulSTfwStvgxW9OmTk=
X-Received: by 2002:a05:651c:1505:b0:2cf:574c:9224 with SMTP id
 e5-20020a05651c150500b002cf574c9224mr2529899ljf.15.1706555494213; Mon, 29 Jan
 2024 11:11:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129152928.3904-1-iulia.tanasescu@nxp.com> <20240129152928.3904-4-iulia.tanasescu@nxp.com>
In-Reply-To: <20240129152928.3904-4-iulia.tanasescu@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 29 Jan 2024 14:11:21 -0500
Message-ID: <CABBYNZLmFY0ugfi=9Q+4cv6XhNEiri8wejwKKT-pXjExa3+9nA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 3/3] client/player: Update bcast endpoint input prompts
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com, 
	mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com, 
	vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Iulia,

On Mon, Jan 29, 2024 at 10:29=E2=80=AFAM Iulia Tanasescu
<iulia.tanasescu@nxp.com> wrote:
>
> This updates the input prompts for broadcast endpoint register and
> config.
>
> To register a broadcast endpoint, the user will be asked to enter
> the supported stream locations and context types.
>
> At broadcast source endpoint config, the user will provide stream
> config options: The BIG that the new stream will be part of, the
> stream Channel Allocation, and the metadata of the subgroup to
> include the stream. These options will be used to configure the
> BASE and the BIG.
> ---
>  client/player.c | 186 ++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 149 insertions(+), 37 deletions(-)
>
> diff --git a/client/player.c b/client/player.c
> index 623519209..d9a4bce87 100644
> --- a/client/player.c
> +++ b/client/player.c
> @@ -4,7 +4,7 @@
>   *  BlueZ - Bluetooth protocol stack for Linux
>   *
>   *  Copyright (C) 2020  Intel Corporation. All rights reserved.
> - *  Copyright 2023 NXP
> + *  Copyright 2023-2024 NXP
>   *
>   *
>   */
> @@ -3259,12 +3259,8 @@ static void endpoint_iso_group(const char *input, =
void *user_data)
>                 ep->iso_group =3D value;
>         }
>
> -       if (!ep->broadcast)
> -               bt_shell_prompt_input(ep->path, "CIS (auto/value):",
> -                       endpoint_iso_stream, ep);
> -       else
> -               bt_shell_prompt_input(ep->path, "BIS (auto/value):",
> -                       endpoint_iso_stream, ep);
> +       bt_shell_prompt_input(ep->path, "CIS (auto/value):",
> +               endpoint_iso_stream, ep);
>  }
>
>  static void endpoint_context(const char *input, void *user_data)
> @@ -3282,12 +3278,8 @@ static void endpoint_context(const char *input, vo=
id *user_data)
>
>         ep->context =3D value;
>
> -       if (ep->broadcast)
> -               bt_shell_prompt_input(ep->path, "BIG (auto/value):",
> -                       endpoint_iso_group, ep);
> -       else
> -               bt_shell_prompt_input(ep->path, "CIG (auto/value):",
> -                       endpoint_iso_group, ep);
> +       bt_shell_prompt_input(ep->path, "CIG (auto/value):",
> +               endpoint_iso_group, ep);
>  }
>
>  static void endpoint_supported_context(const char *input, void *user_dat=
a)
> @@ -3305,6 +3297,11 @@ static void endpoint_supported_context(const char =
*input, void *user_data)
>
>         ep->supported_context =3D value;
>
> +       if (ep->broadcast) {
> +               endpoint_register(ep);
> +               return;
> +       }
> +
>         bt_shell_prompt_input(ep->path, "Context (value):", endpoint_cont=
ext,
>                                                                         e=
p);
>  }
> @@ -3354,13 +3351,6 @@ static void endpoint_auto_accept(const char *input=
, void *user_data)
>  {
>         struct endpoint *ep =3D user_data;
>
> -       if (!strcmp(ep->uuid, BCAA_SERVICE_UUID) ||
> -               !strcmp(ep->uuid, BAA_SERVICE_UUID)) {
> -               ep->broadcast =3D true;
> -       } else {
> -               ep->broadcast =3D false;
> -       }
> -
>         if (!strcasecmp(input, "y") || !strcasecmp(input, "yes")) {
>                 ep->auto_accept =3D true;
>                 bt_shell_prompt_input(ep->path, "Max Transports (auto/val=
ue):",
> @@ -3478,6 +3468,13 @@ static void cmd_register_endpoint(int argc, char *=
argv[])
>                                         g_list_length(local_endpoints));
>         local_endpoints =3D g_list_append(local_endpoints, ep);
>
> +       if (!strcmp(ep->uuid, BCAA_SERVICE_UUID) ||
> +               !strcmp(ep->uuid, BAA_SERVICE_UUID)) {
> +               ep->broadcast =3D true;
> +       } else {
> +               ep->broadcast =3D false;
> +       }
> +
>         if (strrchr(argv[2], ':')) {
>                 ep->codec =3D 0xff;
>                 parse_vendor_codec(argv[2], &ep->cid, &ep->vid);
> @@ -3626,6 +3623,134 @@ static void endpoint_config(const char *input, vo=
id *user_data)
>
>  static struct endpoint *endpoint_new(const struct capabilities *cap);
>
> +static void endpoint_set_metadata_cfg(const char *input, void *user_data=
)
> +{
> +       struct endpoint_config *cfg =3D user_data;
> +
> +       if (!strcasecmp(input, "n") || !strcasecmp(input, "no"))
> +               goto done;
> +
> +       if (!cfg->meta)
> +               cfg->meta =3D g_new0(struct iovec, 1);
> +
> +       cfg->meta->iov_base =3D str2bytearray((char *) input,
> +                               &cfg->meta->iov_len);
> +       if (!cfg->meta->iov_base) {
> +               free(cfg->meta);
> +               cfg->meta =3D NULL;
> +       }
> +
> +done:
> +       endpoint_set_config(cfg);
> +}
> +
> +static void config_endpoint_channel_location(const char *input, void *us=
er_data)
> +{
> +       struct endpoint_config *cfg =3D user_data;
> +       char *endptr =3D NULL;
> +       uint32_t location;
> +
> +       if (!strcasecmp(input, "n") || !strcasecmp(input, "no"))
> +               goto add_meta;
> +
> +       location =3D strtol(input, &endptr, 0);
> +
> +       if (!endptr || *endptr !=3D '\0') {
> +               bt_shell_printf("Invalid argument: %s\n", input);
> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +       }
> +
> +       /* Add Channel Allocation LTV in capabilities */
> +       {
> +               uint8_t ltv[6] =3D { 0x05, LC3_CONFIG_CHAN_ALLOC };
> +
> +               location =3D cpu_to_le32(location);
> +               memcpy(&ltv[2], &location, sizeof(location));
> +               iov_append(&cfg->caps, ltv, sizeof(ltv));
> +       }
> +
> +add_meta:
> +       /* Add metadata */
> +       bt_shell_prompt_input(cfg->ep->path, "Enter Metadata (value/no):"=
,
> +                       endpoint_set_metadata_cfg, cfg);
> +}
> +
> +static void ltv_find(size_t i, uint8_t l, uint8_t t, uint8_t *v,
> +                                       void *user_data)
> +{
> +       bool *found =3D user_data;
> +
> +       *found =3D true;
> +}
> +
> +static void config_endpoint_iso_group(const char *input, void *user_data=
)
> +{
> +       struct endpoint_config *cfg =3D user_data;
> +       char *endptr =3D NULL;
> +       int value;
> +       bool found =3D false;
> +
> +       value =3D strtol(input, &endptr, 0);
> +
> +       if (!endptr || *endptr !=3D '\0' || value > UINT8_MAX) {
> +               bt_shell_printf("Invalid argument: %s\n", input);
> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +       }

You seem to be removing auto support for some reason? Afaik that is
sort of the normal usage since the user normally doesn't know what adv
instances are available in the system, setting a fixed BIG is only
really useful when doing multiple BIS/streams.

> +       cfg->ep->iso_group =3D value;
> +
> +       /* Check if Channel Allocation is present in caps */
> +       {
> +               uint8_t type =3D LC3_CONFIG_CHAN_ALLOC;
> +
> +               util_ltv_foreach(cfg->caps->iov_base,
> +                               cfg->caps->iov_len, &type,
> +                               ltv_find, &found);
> +       }
> +
> +       /* Add Channel Allocation if it is not present in caps */
> +       if (!found) {
> +               bt_shell_prompt_input(cfg->ep->path,
> +                               "Enter channel location (value/no):",
> +                               config_endpoint_channel_location, cfg);
> +       } else {
> +               /* Add metadata */
> +               bt_shell_prompt_input(cfg->ep->path,
> +                               "Enter Metadata (value/no):",
> +                               endpoint_set_metadata_cfg, cfg);
> +       }
> +}
> +
> +static void endpoint_set_config_bcast(struct endpoint_config *cfg)
> +{
> +       cfg->ep->bcode =3D g_new0(struct iovec, 1);
> +       iov_append(&cfg->ep->bcode, bcast_code,
> +                       sizeof(bcast_code));
> +
> +       /* Add periodic advertisement parameters */
> +       cfg->sync_factor =3D BCAST_SYNC_FACTOR;
> +       cfg->options =3D BCAST_OPTIONS;
> +       cfg->skip =3D BCAST_SKIP;
> +       cfg->sync_timeout =3D BCAST_SYNC_TIMEOUT;
> +       cfg->sync_cte_type =3D BCAST_SYNC_CTE_TYPE;
> +
> +       /* Add BIG create sync parameters */
> +       cfg->mse =3D BCAST_MSE;
> +       cfg->timeout =3D BCAST_TIMEOUT;
> +
> +       if ((strcmp(cfg->ep->uuid, BAA_SERVICE_UUID) =3D=3D 0)) {
> +               /* A broadcast sink endpoint config does not need
> +                * user input.
> +                */
> +               endpoint_set_config(cfg);
> +               return;
> +       }
> +
> +       bt_shell_prompt_input(cfg->ep->path,
> +               "BIG (value):",
> +               config_endpoint_iso_group, cfg);
> +}
> +
>  static void cmd_config_endpoint(int argc, char *argv[])
>  {
>         struct endpoint_config *cfg;
> @@ -3662,24 +3787,11 @@ static void cmd_config_endpoint(int argc, char *a=
rgv[])
>                 /* Set QoS parameters */
>                 cfg->qos =3D preset->qos;
>
> -               if (cfg->ep->broadcast) {
> -                       cfg->ep->bcode =3D g_new0(struct iovec, 1);
> -                       iov_append(&cfg->ep->bcode, bcast_code,
> -                                       sizeof(bcast_code));
> -
> -                       /* Add periodic advertisement parameters */
> -                       cfg->sync_factor =3D BCAST_SYNC_FACTOR;
> -                       cfg->options =3D BCAST_OPTIONS;
> -                       cfg->skip =3D BCAST_SKIP;
> -                       cfg->sync_timeout =3D BCAST_SYNC_TIMEOUT;
> -                       cfg->sync_cte_type =3D BCAST_SYNC_CTE_TYPE;
> -                       /* Add BIG create sync parameters */
> -                       cfg->mse =3D BCAST_MSE;
> -                       cfg->timeout =3D BCAST_TIMEOUT;
> -
> -                       endpoint_set_config(cfg);
> -               } else
> +               if (cfg->ep->broadcast)
> +                       endpoint_set_config_bcast(cfg);
> +               else
>                         endpoint_set_config(cfg);
> +
>                 return;
>         }
>
> --
> 2.39.2
>


--=20
Luiz Augusto von Dentz
