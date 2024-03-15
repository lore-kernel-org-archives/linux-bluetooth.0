Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322621C2B2
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 Mar 2024 16:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710520935; cv=none; b=maUugaIT/fEJ3iX1BwyJmHYg/oEwutM/rT6YQs2h9DsuNCYoEqTMpgUGQMQeTqtpOL9LYsvO024EllOjL7q5DLK7uet8jfvPh8nmocHfamSO/whzX5794DeiBSUD18tMZssy8nuakULvBNBkAziewKl08A6XBwmvSJN1WHM1d+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710520935; c=relaxed/simple;
	bh=gEoOyNQrlNWv3fnS0oVht1gA6vN2lYYhNqnN9E5SU/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jlpdvL0qhyNDpeou/TNWB5GkTyocOZlDsgUnR1au7ZffYV6B/ItGxhySFUb9RPKexWA9fpnf+HHIi6RRfIZhIb+olpULO0WNScUEanImO7qHCqdTo/glOEsh84LyJhzubFLfpBVXfDGDLorJdfpyW4R6GbQ9Lz1HS6xt5O6DxRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gpl3YQpd; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gpl3YQpd"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3c1ea59cf81so1032546b6e.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Mar 2024 09:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710520933; x=1711125733; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6schGoV68dNziElegF1X4bKQlHDTKmK1sTlM0KbmEM=;
        b=gpl3YQpdkGfXJntQUFbgCh6VwjpT6zcLz3MctQ3kK7IQbQ5Y253U9mXKDY7GuMhnGW
         yPnk+PGgQoYnZok8+umW4VVfKABhB5Ua2D35Sv64yyJ0/6Jd4egZ26WUytTQNQCyYHCh
         pjHnCw2YUSMuV9ONzARGPiclpC13O6x/pI5PooucmIVD93YaQ5Z0qQqtKHbvL6sj8k4S
         o3PI8yXInIqPOOoXobICNzNkvtunHuiW6d2XPCGn4WjB9Xs1KkyuVPwlN08IdbCkD5ZA
         y3QvGQSpiBxE0d6QCq24+SVM5LSwnnvU/3TCemHAlDXE6U58gkSzezlTE3LIzFRIMYsb
         XBAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710520933; x=1711125733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q6schGoV68dNziElegF1X4bKQlHDTKmK1sTlM0KbmEM=;
        b=MgbwEc1nAaCys4vL5UjIxfoz9j+JKiHnnNdPebjMIvCz4ThMr6hmAXe59/49EFK3NW
         ovTi77a4ggiO5IZL6AwJvUnt7DUtP5ULLsk/WKm20kQLqvMP2NMexGASObd0gfmtyIeS
         U6+UGNOvUf1uOA0CPk38mAPfyKbo1k74SRQgxp2NBFXTTooapoEEBtwR9D7w+BXZCLdv
         eSm+uAB/v2jMQptz3hQWXLrpePgfebsXSJ4BuNRt3fJ1NzhzTwa8qw0gQ9dAXpVHmbT8
         yFOQTp94ytV+zQnBkK7qjq11tJPCRkGwcxiW9TG04QULhX27/Vz+TkUxQcI9KbFl+QGD
         EMlw==
X-Gm-Message-State: AOJu0Yzy0iRLX7sUAoYmb52BrE4uSyjQIEh5AaFWbf7lnapKR+Rsk/Q4
	3I0P2m1Shov/T0Jh0Hza+0tbFZSvi3+0JZj+CrolnSFfBXzpmMKWbiDWOX9cI47FXzsJOvaE2vI
	qugmfenOgRrsW2HGfrJlFRXxqIFk=
X-Google-Smtp-Source: AGHT+IEeppAA2KGutdV5RbLqF3RAxL6bkuhFbqOkDHqBD1/Sd2QlqV3NiIbOkA8fxy4zwzKqBaqtCJuq62YEIm8ybSQ=
X-Received: by 2002:a05:6808:2e9a:b0:3c2:4f57:9b08 with SMTP id
 gt26-20020a0568082e9a00b003c24f579b08mr6991387oib.42.1710520933118; Fri, 15
 Mar 2024 09:42:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315150158.79715-1-silviu.barbulescu@nxp.com> <20240315150158.79715-2-silviu.barbulescu@nxp.com>
In-Reply-To: <20240315150158.79715-2-silviu.barbulescu@nxp.com>
From: =?UTF-8?Q?Guilherme_Gi=C3=A1como_Sim=C3=B5es?= <trintaeoitogc@gmail.com>
Date: Fri, 15 Mar 2024 13:41:37 -0300
Message-ID: <CAM_RzfYLC10pUrgxcAPonW0qpdUJMTer9HytqV7WeonuQL_wag@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3 1/5] player: Add reconfiguration prompt for
 broadcast source
To: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, mihai-octavian.urzica@nxp.com, 
	vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com, luiz.dentz@gmail.com, 
	iulia.tanasescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I am sorry if what I say is wrong... but for me, the label done is unnecess=
ary.

+static void endpoint_is_reconfigure_cfg(const char *input, void *user_data=
)
+{
+       struct endpoint_config *cfg =3D user_data;
+       int value;
+       char *endptr =3D NULL;
+
+       if (!strcasecmp(input, "n") || !strcasecmp(input, "no")) {
+               cfg->ep->iso_stream =3D BT_ISO_QOS_STREAM_UNSET;
/// this command "goto done" is unnecessary, because if the if()
statement is executed
///the else is not execute, and the chunk of code, that the label done
coverage, go to execute
+               goto done;
+       } else {
+               value =3D strtol(input, &endptr, 0);
+
+               if (!endptr || *endptr !=3D '\0' || value > UINT8_MAX) {
+                       bt_shell_printf("Invalid argument: %s\n", input);
+                       return bt_shell_noninteractive_quit(EXIT_FAILURE);
+               }
+
+               if (value =3D=3D 0x0)
+                       cfg->ep->iso_stream =3D BT_ISO_QOS_STREAM_UNSET;
+               else
+                       cfg->ep->iso_stream =3D value;
+       }
+
/// this label done, is unnecessary, because if the if() executes, the
else does not execute.
/// then, the chunk that the label done is include, already execute
without "goto done;"
+done:
+       bt_shell_prompt_input(cfg->ep->path,
+               "BIG (auto/value):",
+               config_endpoint_iso_group, cfg);
+}


this chunk of code, can rrepalced for this:
+static void endpoint_is_reconfigure_cfg(const char *input, void *user_data=
)
+{
+       struct endpoint_config *cfg =3D user_data;
+       int value;
+       char *endptr =3D NULL;
+
+       if (!strcasecmp(input, "n") || !strcasecmp(input, "no"))
+               cfg->ep->iso_stream =3D BT_ISO_QOS_STREAM_UNSET;
+       else {
+               value =3D strtol(input, &endptr, 0);
+
+               if (!endptr || *endptr !=3D '\0' || value > UINT8_MAX) {
+                       bt_shell_printf("Invalid argument: %s\n", input);
+                       return bt_shell_noninteractive_quit(EXIT_FAILURE);
+               }
+
+               if (value =3D=3D 0x0)
+                       cfg->ep->iso_stream =3D BT_ISO_QOS_STREAM_UNSET;
+               else
+                       cfg->ep->iso_stream =3D value;
+       }
+
+       bt_shell_prompt_input(cfg->ep->path,
+               "BIG (auto/value):",
+               config_endpoint_iso_group, cfg);
+}
+


Em sex., 15 de mar. de 2024 =C3=A0s 12:02, Silviu Florian Barbulescu
<silviu.barbulescu@nxp.com> escreveu:
>
> endpoint.config /org/bluez/hci0/pac_bcast0 /local/endpoint/ep0 48_4_1
> [/local/endpoint/ep0] BIS Index for reconfiguration? (value(1-31)/no): n
> [/local/endpoint/ep0] BIG (auto/value): 0
> [/local/endpoint/ep0] Enter channel location (value/no): 1
> [/local/endpoint/ep0] Enter Metadata (value/no): n
> ---
>  client/player.c | 33 +++++++++++++++++++++++++++++++--
>  1 file changed, 31 insertions(+), 2 deletions(-)
>
> diff --git a/client/player.c b/client/player.c
> index 8081ddc13..c754af33d 100644
> --- a/client/player.c
> +++ b/client/player.c
> @@ -3659,6 +3659,35 @@ static void config_endpoint_iso_group(const char *=
input, void *user_data)
>         }
>  }
>
> +static void endpoint_is_reconfigure_cfg(const char *input, void *user_da=
ta)
> +{
> +       struct endpoint_config *cfg =3D user_data;
> +       int value;
> +       char *endptr =3D NULL;
> +
> +       if (!strcasecmp(input, "n") || !strcasecmp(input, "no")) {
> +               cfg->ep->iso_stream =3D BT_ISO_QOS_STREAM_UNSET;
> +               goto done;
> +       } else {
> +               value =3D strtol(input, &endptr, 0);
> +
> +               if (!endptr || *endptr !=3D '\0' || value > UINT8_MAX) {
> +                       bt_shell_printf("Invalid argument: %s\n", input);
> +                       return bt_shell_noninteractive_quit(EXIT_FAILURE)=
;
> +               }
> +
> +               if (value =3D=3D 0x0)
> +                       cfg->ep->iso_stream =3D BT_ISO_QOS_STREAM_UNSET;
> +               else
> +                       cfg->ep->iso_stream =3D value;
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
> @@ -3674,8 +3703,8 @@ static void endpoint_set_config_bcast(struct endpoi=
nt_config *cfg)
>         }
>
>         bt_shell_prompt_input(cfg->ep->path,
> -               "BIG (auto/value):",
> -               config_endpoint_iso_group, cfg);
> +               "BIS Index for reconfiguration? (value(1-31)/no):",
> +               endpoint_is_reconfigure_cfg, cfg);
>  }
>
>  static void cmd_config_endpoint(int argc, char *argv[])
> --
> 2.39.2
>
>
