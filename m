Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D42B199937
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Oct 2024 14:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729609175; cv=none; b=R30989n0re/xOFu6g0pw3YpdNG/7goSkckSvbGaAgSA8GYhhViTU8+tlH2F58UYiMJwF+1sFuv6nmScQzLWjS1LMIly3paWC4ktfOzCDMJdIFp9mWOJWG7DD0LZr4/dZF9dYk9NLhEyBI1OTawFmfNJR4A4cUuxG5A/APPB3bp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729609175; c=relaxed/simple;
	bh=NLTIjr/xAXk+8NYHpgMHRCBIjIBS8RwAvHUA8wVtmHc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E3w2i2Xe+m5oBpngnVmio/KfrVX9ELNxyiX/pdkE1uWBvyPqKIPSwAdAZ6xX1xXHtGP8HpywvTtmL/nJY2IrEOE8WK4DVaB0FEUj/O5alyCwDjzSwe56s/3mR5I2aFmGYaRPTN97pWHqPoos7ZQ9SEc+ksxxdEA8n+jeLY+QAFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ec3VIGhx; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ec3VIGhx"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fb5111747cso64538391fa.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Oct 2024 07:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729609171; x=1730213971; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LjjxBMoTQpbNVVtZ0ylQBaM21Ld9XHpts3YsN2tv3Hg=;
        b=Ec3VIGhxruaXc5XsKs72SGV+rlWM12ns/On5BTyQz6vgk/9Ti41mGCOTw8BMc/jpRZ
         QU/iVhXaIoyr/9n3+tu5vF5ajkFTlSjRscKEjBiGLw+KX9Xdkcg/+klHDfcLHwwwxe2v
         uIyPGSY7DqGvSqQh9HkS4Y6BsaoAaBHM9xqZoPldrdBXfGJQCZewUDtJ4ZNCwsiR+WIy
         NC1c2OpuzTh0SLwXqbVk9UaI+9VoW5zP882E8ZrjwYTJ7fI9sBdNGjgo7ls3KaG/DglF
         6X/DA09OtcjAEFf6pCpRECtHS9sM8khYLfq2agS+GG/isbpKdlu++Ms1lzjK3I3dZe02
         MnaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729609171; x=1730213971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LjjxBMoTQpbNVVtZ0ylQBaM21Ld9XHpts3YsN2tv3Hg=;
        b=ffts87POAQrQgd8W6Muxoetwu33ovt3+otkfMSilNcx7vWCtoy16iPscsnLY61cGk+
         Uo/7XXMV2QfhWvPJsVGAAZrcs0i5W7yAio4hC2aIAboOGUB6gWQSGswd6wGXdXKYKgPM
         To3N/HkYR/cxwVcsemJ5jg9VvNgqO9K8VfLxiC4fbJm2si/HaDOTdIO3PkT3xr6vixJC
         9z8qtuzah69B66yOdNzmKrJp14gJEUzY4sNvGY5asr/E2ssnhxbawPneLS3480Mi9Fdg
         YI9jmoL0mmxtVnHmA02cAiHP8Wt8nsZJEfC76iLokWiHt8xNiUinZlNzGFKO2iqTcXAv
         4ONQ==
X-Gm-Message-State: AOJu0YxO1Mgsgps3pg2WXcw+bvN8jB/HAewTOYWnFF8kDM4Ldh3ESPO+
	6Bdd85uVKe9y/5LhIXDqCv6dpNIZ5/F/IH3qMhwlmEpXzgPIqdn4A2ODGZWianUYKlYbwaKbWTI
	cHAsUf4d1jlp1USeAZEqEcF+A6bIVPQ==
X-Google-Smtp-Source: AGHT+IFl42C4d/FJGLRboDy6YFr9IIkIjfohBh4C7dxSxWJGHAZgP+kJswM6njDP9iTWeJKuBiGu9y8aK0jwJKi8wrA=
X-Received: by 2002:a2e:701:0:b0:2ef:2490:46fb with SMTP id
 38308e7fff4ca-2fc93354c31mr14891411fa.37.1729609171206; Tue, 22 Oct 2024
 07:59:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022120051.123888-1-hadess@hadess.net> <20241022120051.123888-3-hadess@hadess.net>
In-Reply-To: <20241022120051.123888-3-hadess@hadess.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 22 Oct 2024 10:59:17 -0400
Message-ID: <CABBYNZJ1ffrQ1HqnGO-mcgFop1usa9jmLHx1cewep4iJ4C1YHQ@mail.gmail.com>
Subject: Re: [BlueZ v2 2/7] client: Use g_clear_pointer() to clean up menus
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bastien,

On Tue, Oct 22, 2024 at 8:01=E2=80=AFAM Bastien Nocera <hadess@hadess.net> =
wrote:
>
> This would avoid warnings should the client be NULL.
> ---
>  client/admin.c     | 5 ++---
>  client/assistant.c | 5 ++---
>  client/player.c    | 4 ++--
>  3 files changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/client/admin.c b/client/admin.c
> index cd9af6f955da..9d48867bc1d7 100644
> --- a/client/admin.c
> +++ b/client/admin.c
> @@ -191,7 +191,7 @@ static void proxy_removed(GDBusProxy *proxy, void *us=
er_data)
>                 admin_policy_status_removed(proxy);
>  }
>
> -static GDBusClient *client;
> +static GDBusClient *client =3D NULL;
>
>  static void disconnect_handler(DBusConnection *connection, void *user_da=
ta)
>  {
> @@ -215,6 +215,5 @@ void admin_add_submenu(void)
>
>  void admin_remove_submenu(void)
>  {
> -       g_dbus_client_unref(client);
> -       client =3D NULL;
> +       g_clear_pointer(&client, g_dbus_client_unref);

Don't think it is worth bumping the glib dependency just to add a NULL
pointer check, in fact g_dbus_client_unref should be safe to be called
with NULL pointers so I wonder if this is a false positive.

>  }
> diff --git a/client/assistant.c b/client/assistant.c
> index 16e94664a5c3..94052e26fd59 100644
> --- a/client/assistant.c
> +++ b/client/assistant.c
> @@ -390,7 +390,7 @@ static const struct bt_shell_menu assistant_menu =3D =
{
>         {} },
>  };
>
> -static GDBusClient * client;
> +static GDBusClient * client =3D NULL;
>
>  void assistant_add_submenu(void)
>  {
> @@ -409,7 +409,6 @@ void assistant_add_submenu(void)
>
>  void assistant_remove_submenu(void)
>  {
> -       g_dbus_client_unref(client);
> -       client =3D NULL;
> +       g_clear_pointer(&client, g_dbus_client_unref);
>  }
>
> diff --git a/client/player.c b/client/player.c
> index 188378175486..dea5922d56db 100644
> --- a/client/player.c
> +++ b/client/player.c
> @@ -5694,7 +5694,7 @@ static const struct bt_shell_menu transport_menu =
=3D {
>         {} },
>  };
>
> -static GDBusClient *client;
> +static GDBusClient *client =3D NULL;
>
>  void player_add_submenu(void)
>  {
> @@ -5715,6 +5715,6 @@ void player_add_submenu(void)
>
>  void player_remove_submenu(void)
>  {
> -       g_dbus_client_unref(client);
> +       g_clear_pointer(&client, g_dbus_client_unref);
>         queue_destroy(ios, transport_free);
>  }
> --
> 2.47.0
>
>


--=20
Luiz Augusto von Dentz
