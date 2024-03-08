Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5AC1E515
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Mar 2024 17:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709919457; cv=none; b=nAx//WSixO/t6znsyIeln6t/CEM2ObrGc/LoHAnsE0ZM2p2CiDkRUroOZjbUqo2F+P5dfGmJXlAECpIlmoswLc7QU6NAx7yZ4LyPi37DXWp270uzoPAcRvAGLkZ0z3lGmc7aTP73qBL+ng0xB7xCMzvHEo2V/36nih4noRoUU2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709919457; c=relaxed/simple;
	bh=JYMt3YJV9irfcRmlBWrADXZM8bHeUsxAJ+Vvcy7Qxd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uau28BsvltnNUr1D5vp4jupEXRYVFz2VdgSA/cZPUwTnv4n0Ch9yt27ceefIE5/Zl9huA2voH6eOmjjU26yxrpNvIMy9wK1B2NfSiaa9pyQZ88t9qBPggQUaLKtXqj1NA6+3q2pYxluayz+qxri0g0Xrhbz4oSSr4zsXFHherX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ow1Ee5CZ; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ow1Ee5CZ"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d3f4fef377so31142951fa.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 Mar 2024 09:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709919454; x=1710524254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w7y0f9QFlXLtv3RFLZNYHWzMIFPPkAOJNu8AX7HeH30=;
        b=Ow1Ee5CZgDbrk7ex7O9n3WwPxcsEdVXH8pT7p1Ti20Rqmz+1EZcWC4Vcjj1UnEmqfK
         xlML4J1EyJPIz+/O966Wlcrjn5MYCC3+7mBFYpX+rb8qYstnnrYOZseiwhxoQRJb5ecN
         2Guzqkb4dWmOfHjsJ5IdwUz63vfMymi3H5utVsy32y7AUf/yNXHwRezxHmbxOlHHDdK5
         oTIRwHb4SlCgyn/gUetwZBMmSyEsJcfsxxb3U8T5e8kghuyzjcrDrSWfN8m48y+N38J1
         0R1MZm8JlW5X8gkMJfBt8y8jG3nf1u/nEJNDfGLLU7EAQw/lASJDUY2J8mgvE/r4g2OU
         LGQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709919454; x=1710524254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w7y0f9QFlXLtv3RFLZNYHWzMIFPPkAOJNu8AX7HeH30=;
        b=K2EzImp48y/xo7ktwDU4BFe/EBIg0QBi6nlqyhQvPiNfLodnOfWmoqgnIjOVnYn8Tx
         JlcV3Qo1DXblj7DzQYM1eBtdIvhpPJESqtHc6dXOvjrzAMySBgOSEgZ3c5wTmpcnYuLA
         GKH/8jB2atYVeu/Uv4LC8mAK/yscYjvYqUDEIbzwWdyTiiaywn7n7QrhVidwZJW5+cFV
         NH+ZgmJVcxoaAyEC0/M/WAH8t34r6UpqqOXUukZ4ynr9R872JnSWVh+4n1h+baRUrAKr
         Td+FPocZbspPZk8RNdmkwy7F3/2BjB3CAf7kwZtnW2SLvnjBYEyu20yHRp1jE6G0Gcyr
         Y++A==
X-Gm-Message-State: AOJu0Ywj4wsOP/SxxXHxDVuxJUP7+PoNZaqwkBUPc13gea5H1qTEGhbT
	IL+NhM2wVKNEK0KahpQrw3JDWQSe+sizLTWzTOK0B/EdRWGDr7/PqzLyWAgnpLsqJiDU9LSys5Y
	1tJXSAzImnuujM4aMsrXmWv4gZsc+XhFZ
X-Google-Smtp-Source: AGHT+IHT4r7DabfJUHLPVUzWZqPyteDRgG+lblElZBIc+8jr2xmkMc4VbsqZT4HcGzhN9cYmGhECxcm/59sJPvqW67c=
X-Received: by 2002:a2e:b1d4:0:b0:2d3:3261:b186 with SMTP id
 e20-20020a2eb1d4000000b002d33261b186mr3970262lja.29.1709919453921; Fri, 08
 Mar 2024 09:37:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308165232.53906-1-silviu.barbulescu@nxp.com> <20240308165232.53906-2-silviu.barbulescu@nxp.com>
In-Reply-To: <20240308165232.53906-2-silviu.barbulescu@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 8 Mar 2024 12:37:21 -0500
Message-ID: <CABBYNZJLxD2i+sSduOszVwoH25mZDa0OR0DFAEPGcYxTtQ=thg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/3] player: Add reconfiguration prompt for
 broadcast source
To: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, mihai-octavian.urzica@nxp.com, 
	vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com, iulia.tanasescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Silviu,

On Fri, Mar 8, 2024 at 11:52=E2=80=AFAM Silviu Florian Barbulescu
<silviu.barbulescu@nxp.com> wrote:
>
> endpoint.config /org/bluez/hci0/pac_bcast0 /local/endpoint/ep0 48_4_1
> [/local/endpoint/ep0] This is a BIS Reconfiguration? (yes/no): y
> The BIS index is assigned in the order of the configuration
> starting with 1
> [/local/endpoint/ep0] BIS Index (value): 1
> [/local/endpoint/ep0] BIG (auto/value): 0
> [/local/endpoint/ep0] Enter channel location (value/no): 2
> [/local/endpoint/ep0] Enter Metadata (value/no): n
>
> ---
>  client/player.c | 46 ++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 44 insertions(+), 2 deletions(-)
>
> diff --git a/client/player.c b/client/player.c
> index a40bf66e3..35143115a 100644
> --- a/client/player.c
> +++ b/client/player.c
> @@ -3809,6 +3809,48 @@ static void config_endpoint_iso_group(const char *=
input, void *user_data)
>         }
>  }
>
> +static void endpoint_set_reconfigure_cfg(const char *input, void *user_d=
ata)
> +{
> +       char *endptr =3D NULL;
> +       int value;
> +       struct endpoint_config *cfg =3D user_data;
> +
> +       value =3D strtol(input, &endptr, 0);
> +
> +       if (!endptr || *endptr !=3D '\0' || value > UINT8_MAX) {
> +               bt_shell_printf("Invalid argument: %s\n", input);
> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +       }
> +
> +       cfg->ep->iso_stream =3D value;
> +
> +       bt_shell_prompt_input(cfg->ep->path,
> +               "BIG (auto/value):",
> +               config_endpoint_iso_group, cfg);
> +}
> +
> +static void endpoint_is_reconfigure_cfg(const char *input, void *user_da=
ta)
> +{
> +       struct endpoint_config *cfg =3D user_data;
> +
> +       if (!strcasecmp(input, "n") || !strcasecmp(input, "no")) {
> +               cfg->ep->iso_stream =3D BT_ISO_QOS_STREAM_UNSET;
> +               goto done;
> +       } else {
> +               bt_shell_printf("The BIS index is assigned  in the order =
of "
> +                               "the configuration starting with 1\n");
> +               bt_shell_prompt_input(cfg->ep->path,
> +               "BIS Index (value):",
> +               endpoint_set_reconfigure_cfg, cfg);
> +               return;
> +       }
> +
> +done:
> +       bt_shell_prompt_input(cfg->ep->path,
> +               "BIG (auto/value):",
> +               config_endpoint_iso_group, cfg);
> +}
> +
>  static void endpoint_set_config_bcast(struct endpoint_config *cfg)
>  {
>         cfg->ep->bcode =3D g_new0(struct iovec, 1);
> @@ -3835,8 +3877,8 @@ static void endpoint_set_config_bcast(struct endpoi=
nt_config *cfg)
>         }
>
>         bt_shell_prompt_input(cfg->ep->path,
> -               "BIG (auto/value):",
> -               config_endpoint_iso_group, cfg);
> +               "This is a BIS reconfiguration? (yes/no):",
> +               endpoint_is_reconfigure_cfg, cfg);
>  }
>
>  static void cmd_config_endpoint(int argc, char *argv[])
> --
> 2.39.2

Instead of having a 2 step process we could ask the BIS index right
away and if the user answers no/0 it means it doesn't want to
reconfigure an existing index.

--=20
Luiz Augusto von Dentz
