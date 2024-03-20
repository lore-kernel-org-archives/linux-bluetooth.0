Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47486A031
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Mar 2024 17:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710955967; cv=none; b=fB2eSfKJbJRCV57YT9XqMJCXws+HGbpDeheX2Y5H6+cY37V3DRLVhpCr7W1OrN2gL+OnlwlHvRx5VtqqNkja/XA16REEo2N87jecZ9WpaBDcGQZtOMhYFrNZQQReoKJC/+wuCH9DrzA2ezvs5nG5xRNHdLlw3CX+PeQm5+qH4s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710955967; c=relaxed/simple;
	bh=EoGgYWtvZyh3lFFflV6BCH9H6HGj2rHw/w6Y7yeDC8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e7ZQCrtY/0/WXS+YYO2yWWR9mHp0jwLLnqwml/puomNP2a4Q3q4GJt3SISWEbhht5XycrknF/92ln/xNXAF5l4tCMsvAIX/eD6gmX7Hw93mmMR4dTFRgDdrQzvpnb0dXkMJCHIC87BX7pVq0LNuFrGgu0nj/O48xrXKXGIzLDpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JcOSbl1H; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JcOSbl1H"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d220e39907so1772341fa.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Mar 2024 10:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710955964; x=1711560764; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+TPL+eiivbDib0+dVtTV5dkeu2T8plVk938CGyQMwkI=;
        b=JcOSbl1HNLFw7lYs7FFq5EZqOS/6FO/mm/Oa4azoU2pNxAMuxlfvZgClKVd5V/LCkB
         6PSOiteLZqqRDLKGxLdwXPuwiM8n7143Ff8kgWNKoR6FVOwG5YiBMGZZAzBevhvQNQaq
         z/ZNDr7pAQEyEOeOGWg+pWbdE89/Ov6mWvuL8UhFQJXVr84qENHExpMxKih9NNJvWcaI
         wNV7l0L/KMyLaRjYqzbMUz9myLLYsfAbFpEqDVdHanxAK4D8BHF42S2ftUD418rNmYos
         eKezyKk5X9rUi+wLcTqi2X0WmvQniR3GgYKo5j6g1InAwZneNphCKTaGYpCzSAeYimh9
         C5+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710955964; x=1711560764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+TPL+eiivbDib0+dVtTV5dkeu2T8plVk938CGyQMwkI=;
        b=hjAk9GwDKemMRY8K5ZCU5p1W1OeTvDdWGo9UE7O17wqsk8QobFipPq7ysdZJmWYstl
         F14jlGGo1mKh+PRUQHh/TfReT3gNVaNGW4EnATJdwt7+WOcSoxHeEXQSIBbXQJLdamSX
         Hqy1Mo+6cdpxYLOoIiKp0U3pRq0seaDm2v4U7675/QPgIry0xu7hZEBBeMCQpQHdJej/
         4I/x/tw7TM8BLSVktgA658Q+q9qLCc7jizulxBENaxuEXPbU1FjlCUojVTxeQ7Sz0LmS
         pUIznhuakykTdX1iiVHMkOaftcuVetA++QIy7uamtj37PXwzl8ml3ELGbbxDj5d55z/A
         +gcA==
X-Gm-Message-State: AOJu0YxKi0U09jzSdWCw1zHXEDLhJ2dAl531ZIeOt8EQlDSuxfICnJHq
	IFilBMjKPLwFsnxsZyUhArsDR9GZv2NgBzi5YZ7x7Iz2NOtPPF5RHZdD0LeShmJ8gG7J0S6Dy4J
	xNzTLZa+d+Y8O/NyBbBnXQQpSgRM=
X-Google-Smtp-Source: AGHT+IFd4F6d79W69Du5hJx5Nbqo5sDQm1rTkvBMi7TiHGcnpDlSBsc4JJ4/1oGSoy0HMUKve0mmciNpHBpUObqtyXQ=
X-Received: by 2002:a05:651c:1414:b0:2d5:9d0c:9ff8 with SMTP id
 u20-20020a05651c141400b002d59d0c9ff8mr3821302lje.28.1710955963467; Wed, 20
 Mar 2024 10:32:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240320144153.46408-1-silviu.barbulescu@nxp.com> <20240320144153.46408-3-silviu.barbulescu@nxp.com>
In-Reply-To: <20240320144153.46408-3-silviu.barbulescu@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 20 Mar 2024 17:32:30 +0000
Message-ID: <CABBYNZL-JFqb5wq-k4Ge2zOVPf71E3pVsnu5X-h4LOy1tziNCQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/2] player: Allow endpoint config without local
 endpoint argument
To: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, mihai-octavian.urzica@nxp.com, 
	vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com, iulia.tanasescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Silviu,

On Wed, Mar 20, 2024 at 2:42=E2=80=AFPM Silviu Florian Barbulescu
<silviu.barbulescu@nxp.com> wrote:
>
> Update endpoint config command to create local endpoint for broadcast
>  endpoint, this will be used to configure a broadcast source\sink if
>  register endpoint is done from another application like PipeWire

Sorry but will not gona fly, we don't have any business with endpoints
from other process in the system, in fact we might actually make it
strictly prohibit for third-party process to use SetConfiguration with
endpoint that do not belong their own D-Bus connection, same for
MediaTransport, they shall only be acquired by the process that
created them.

Also I remember quite clearly stating that we would move away from
using MediaEndpoint for Broadcast Sink, instead what we shall be doing
is enumerating BIS as MediaTransport directly so the likes of pipewire
can Acquire them directly without doing any configuration since they
are already configured over the air. Broadcast source will probably
require a special interface at pipewire side, or perhaps a dedicated
card which gets configured via some configuration file, etc, but we
shall not depend on bluetoothctl to configured it, that will just make
things more complicated than really helping.

> ---
>  client/player.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 77 insertions(+), 3 deletions(-)
>
> diff --git a/client/player.c b/client/player.c
> index ab33bfc46..b02a40423 100644
> --- a/client/player.c
> +++ b/client/player.c
> @@ -3662,10 +3662,15 @@ static void endpoint_set_config_bcast(struct endp=
oint_config *cfg)
>                 config_endpoint_iso_group, cfg);
>  }
>
> +static void endpoint_init_defaults(struct endpoint *ep);
>  static void cmd_config_endpoint(int argc, char *argv[])
>  {
> +       DBusMessageIter iter;
>         struct endpoint_config *cfg;
> -       const struct codec_preset *preset;
> +       const struct codec_preset *preset =3D NULL;
> +       const struct capabilities *cap;
> +       uint8_t codec;
> +       const char *uuid;
>
>         cfg =3D new0(struct endpoint_config, 1);
>
> @@ -3680,8 +3685,75 @@ static void cmd_config_endpoint(int argc, char *ar=
gv[])
>         /* Search for the local endpoint */
>         cfg->ep =3D endpoint_find(argv[2]);
>         if (!cfg->ep) {
> -               bt_shell_printf("Local Endpoint %s not found\n", argv[2])=
;
> -               goto fail;
> +               /* If argc !=3D 3 then argv[2] should be the
> +                * local endpoint. Return error.
> +                */
> +               if (argc !=3D 3) {
> +                       bt_shell_printf("Local Endpoint %s not found\n",
> +                                       argv[2]);
> +                       goto fail;
> +               }
> +
> +               /* If local endpoint is not found verify if this is a
> +                * broadcast remote endpoint because this can be an
> +                * endpoint config command with remote endpoint and
> +                * preset. In this case we have to create its own
> +                * local endpoint.
> +                */
> +               if (!g_dbus_proxy_get_property(cfg->proxy, "UUID", &iter)=
)
> +                       return;
> +               dbus_message_iter_get_basic(&iter, &uuid);
> +
> +               /* The local endpoint must have the UUID of local pac but
> +                * the remote endpoint has the UUID of the remote pac, so
> +                * based on this information we determine the UUID for th=
e
> +                * local endpoint.
> +                */
> +               if (!strcmp(uuid, BAA_SERVICE_UUID))
> +                       uuid =3D BCAA_SERVICE_UUID;
> +               else if (!strcmp(uuid, BCAA_SERVICE_UUID))
> +                       uuid =3D BAA_SERVICE_UUID;
> +               else {
> +                       /* This should be a local endpoint because is not
> +                        * a broadcast endpoint.
> +                        */
> +                       bt_shell_printf("Local Endpoint %s not found\n",
> +                                       argv[2]);
> +                       goto fail;
> +               }
> +
> +               if (!g_dbus_proxy_get_property(cfg->proxy, "Codec", &iter=
))
> +                       return;
> +
> +               dbus_message_iter_get_basic(&iter, &codec);
> +
> +               /* Verify if the local endpoint already exists */
> +               cfg->ep =3D endpoint_find(uuid);
> +               if ((!cfg->ep) || (cfg->ep->codec !=3D codec)) {
> +                       /* Get capabilities to create the local endpoint =
*/
> +                       cap =3D find_capabilities(uuid, codec);
> +                       if (!cap) {
> +                               bt_shell_printf(
> +                                       "Capabilities not found for UUID =
%s, codec id %d",
> +                                       uuid, codec);
> +                               goto fail;
> +                       }
> +
> +                       cfg->ep =3D endpoint_new(cap);
> +                       endpoint_init_defaults(cfg->ep);
> +               }
> +
> +               /* Verify if argv[2] parameter is a valid preset */
> +               preset =3D preset_find_name(cfg->ep->preset, argv[2]);
> +               if (!preset) {
> +                       bt_shell_printf("Preset %s not found\n",
> +                               argv[2]);
> +                       /* Free created endpoint */
> +                       local_endpoints =3D g_list_remove(local_endpoints=
,
> +                                               cfg->ep);
> +                       endpoint_free(cfg->ep);
> +                       goto fail;
> +               }
>         }
>
>         if (argc > 3) {
> @@ -3690,7 +3762,9 @@ static void cmd_config_endpoint(int argc, char *arg=
v[])
>                         bt_shell_printf("Preset %s not found\n", argv[3])=
;
>                         goto fail;
>                 }
> +       }
>
> +       if (preset) {
>                 cfg->caps =3D g_new0(struct iovec, 1);
>                 /* Copy capabilities */
>                 util_iov_append(cfg->caps, preset->data.iov_base,
> --
> 2.39.2
>


--=20
Luiz Augusto von Dentz
