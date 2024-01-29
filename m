Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25322E657
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jan 2024 19:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706555157; cv=none; b=r2DwTWj9+U4qzwcJFl3Ov2PVRclreuNs21+7Oqn7YeMZK3yw3ez7+FfPBDh620h1RSjDoVW+zFSkk4CbwcbcM0uMsBRojYCrUjufpv24z8oidrJV9MsM55ge2Wf/jDUJ9ToM0MCuztxxFi0MfmMYZuWGvnhDSxAgWAQbtEgnLds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706555157; c=relaxed/simple;
	bh=3+GvjBsE7ka7OvHq8K1QMll6jkM+5fbTaCtUpIegFgc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MYz25frxIRxARxt+PD8SXsFerNFDf2FDgfyTWD1ZHXgIdaSwwKvEnJgEy7P6N50VsBTUBaoGbl3K3oP/z5PorsKvw0J3SP7Gm83UpHf0th+JtOxDn3HHG6X9nZhV3/1HF1SuNhI2DGVeZkzsJ0G7Wyj1z19kf0c2fql1GYzI9gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fD5ZvpPj; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fD5ZvpPj"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d04c0b1cacso15144501fa.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jan 2024 11:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706555153; x=1707159953; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NVq+qoCIHtjbtG9w2XRVTlngBUcmTjLTSz3PCw8/dPc=;
        b=fD5ZvpPjjk+RuP/DMPyCggFu2n/BZ58j9aVq9PwJh7r86nHQJWJmIBRc74Ca4C1t/j
         bIK6IUqa10TCQ1WiG39UoM/BXDvVsFC0QbQeOHPETSc6kxZGHNh9m2hvxHMnDoFm98vH
         Ynz5qan3swTOFfU4H8JQJywH0uKZbCeRz5fp0z+jLXwHCbKI+RM8PN6oT0DOISeUfNwD
         tMh1RrhPyPhtC5OElMW5trZrV9kS2FWqHJxjY54+5PXT4Kttxecw7uFCt3tJuaob128A
         1AH45qgG/JG1FWr7aG6NNQoj3xQqy0fmASC2bzKxLncyQJVBdDw4PXQBQKzMBHQwcSHY
         9jaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706555153; x=1707159953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NVq+qoCIHtjbtG9w2XRVTlngBUcmTjLTSz3PCw8/dPc=;
        b=ZkXNve8ev2VvEWZHnuk5lUkltEA/a1N+OKpy7pXADp6kejE+5zgNRXfLCqVEXBwWwU
         GJyImT0NOlrF1uap2Zm3QPJwFYHUWcc/NtLNbv3vZ0ugx05Yr0Gi84QWRoT67lzGtuNh
         R+DzoJrhmBVGZaK7wv59qJaR1ITlZlS5dE9CBRPn/MZzcJyCXAXrWz3KEgmzbLSVap2w
         T74JvZz+ZhxMuBh57wC2RSX+7tOl1+4M0L/Yh2S5agDbVyba9iOcjr1jqpVEs0CC7Rtu
         InrLNbUnc6Q4EIB9BJ1fXliOiyxoLiio9/gjQgJa7g0B5eIKbFdGi4ZpTUMPAIZQZN18
         TgBQ==
X-Gm-Message-State: AOJu0YzmHeATqFSCtDWh5ba4GbRmT8Y+67iQJcv3htcwpK5Q4G0DB9f8
	WCYfnyksOq0RpW1NhIzJCLwdpLhxBsK7YWNxejpxJk1MS76bpt5ZvPsJ3toRdFjEGVXCxdE8adr
	nd79kSSFPEWVA7sEuelqzcz3OVYc=
X-Google-Smtp-Source: AGHT+IFE9oc5NKlQrMeudyNtIjtFgFi3/gPgH/KyzG/s4XSUJ0UakA4v1S0GqCYUOEPA2WG1JQpJmnQTttkjfcTT18Q=
X-Received: by 2002:a2e:b282:0:b0:2cd:7830:5796 with SMTP id
 2-20020a2eb282000000b002cd78305796mr4239869ljx.5.1706555152671; Mon, 29 Jan
 2024 11:05:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129152928.3904-1-iulia.tanasescu@nxp.com> <20240129152928.3904-4-iulia.tanasescu@nxp.com>
In-Reply-To: <20240129152928.3904-4-iulia.tanasescu@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 29 Jan 2024 14:05:40 -0500
Message-ID: <CABBYNZLGfiP-MMRrt1uTtJqhXTd6x_Rah+OA-dHDZmKk0i_DLw@mail.gmail.com>
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

Please add some samples if the changes affect user input, since this
does look like it will have some impact on when BIG/BIS is requested,
also make sure this works out with the likes of -e command line
option, since that automatically registers endpoints.

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

Not a big fan of creating scopes like above in the middle of the
function, how about we have a dedicated function for setting these?

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
> +
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

Ditto, just have the type defined in the beginning of the function.

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
