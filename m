Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92CC28727E
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Dec 2025 15:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765811427; cv=none; b=HKyCfBTP5n9zuybg/rqhDkdLzEyKh67T9hNlIeIhFwiocA3ucHKd95yq+PNiQXobjcNG1nujvbWyyMZumjIh1X9KeaZn/EockG0181J+XLjHTsELTOXNhbU4yMFif6zLyMbZ6nr2alhEm4/L+neT4J0qRvy/XvnHML0IWPYNnm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765811427; c=relaxed/simple;
	bh=kmw4Ro9TAsYi+5vyh2peK+biD3QHPUdRw6mdjtLxZQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LqS7/KhRKLTfo6PvDT4usDn8OaAbNI2szIZcDdUHqIQ0zLmn3LzYoa+cOLC8RiMA2PDMjPJ+FMWTiUbscK+Erej54zcc04Y2n+kvLfi5bWeqteEydRQpPBG7VbRTRXF2yOsHISv5pfKa0iZUYDv7Zd5LAb6mxE98eaHzh+Qm44s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E7nJazbu; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7nJazbu"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso2450111a12.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Dec 2025 07:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765811424; x=1766416224; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XqGS9N8CMqtNia6APpDFHq/KAUI88G+GeQ0nNLSDbzQ=;
        b=E7nJazbutWuRlBGX66Ge7gFJUFhV1VMBtwU7mMVPz3g5ui+Xhdea6B3EfDDW22qLam
         FENOPftFpcOx2rApaeWULqQECYWClO3F6u39/GuL+skvY2tUQ9qpAcU7ZsixsFR5rwwQ
         auR9RBuH/1kfBFVtqKbVOH4hniwB3C2dSMGYvvxdlUae/uvZq9QtYETNJe7WG1QYbghJ
         5dFSAJ8dxrH735itzpiuHjgFLBk1lCRlEbIZQpP/0zvyH0CnWFNS7LCE56mdkrCfdSM/
         2ki2V7hL06mlWev4A0tnbBUrrVK1vJs9CYkK1O12brMTX3rGkDjLOsU4USwtQjRjGDjP
         unUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765811424; x=1766416224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XqGS9N8CMqtNia6APpDFHq/KAUI88G+GeQ0nNLSDbzQ=;
        b=LHUOdfUCIff6swbX92D3YY5Awd+p1F8FdqVEDgyUZj8uQJxp63T3t7PTEUvJTjJme1
         FGAWnGn3d9VOugXSBrrgM2qXhX61xw5of1/Vs5nJ2372VPtSiX949UeeYveGgfJ8+XoA
         l+lPC1H/q1IulDuDLvhgUv47uWduG3mkZzcqzVb3HSnbo8kjOQ9G6wqLYfWMghD4nn/4
         Bdwz1JFWJp9ESFSXTvmrVHmbKC0LlfX9wODyKwEDObDOuaHkFcIz4PhHNGbziCQbLpG1
         KXRvmLn+LKwZCv7rKLyzGvCrW5chELL6/rZIOydAw70wAE52NWAQhEbzSCPiJj1gX5QV
         4IFA==
X-Gm-Message-State: AOJu0YwIyI7T/xFUG3XLBcWKDfwOyln11Dg8f/WFfR6ZfRQp6wHb+KF/
	5PJ7dEtuzr/n1nf7HKjTdhVgQO+XcH1v3cv1Ga0MlW8yzzMY67hOmwj8UhAoCk1P/ktjRBGeJDD
	cvMlknm0lpfJaxsB6f+QD+WbgG1VKZ/c=
X-Gm-Gg: AY/fxX7v0874m/QfrrBZ7tcMny/7JM1YoQuOa3QE7LriWPO0SyMETZomEw1rWhr6o9u
	ICS3lv1BDC5Rl9lrtPguoOtrHtyipWFQv3lKFtcI2CBl+ufMrFigcoGF2yPSB9Gh3AP/k5CM0X+
	FIfGOirwunIfSMu633a15yHI57qMGVTNnANbfNRo6uklt9eptH6gYMDJB3afGg26mNH6DBAuxat
	nmXA/vVB0SnLs8LaFqAgFh/GMKxVqQLMq9CK4qYEkYsA0jjOE/dRdAG0uO83IDL/XbzfRBa2n7Y
	AAHH
X-Google-Smtp-Source: AGHT+IHFllX4Hor+0UmSVEQufHLfSU06hPoprhOXOJT1b2PRqktzEepOFzraomzN5bgGvIc5LbJlca5yddRbQyvjb/w=
X-Received: by 2002:a05:7300:6825:b0:2a4:3593:c7c6 with SMTP id
 5a478bee46e88-2ac2f877a28mr7787533eec.6.1765811424457; Mon, 15 Dec 2025
 07:10:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215140203.638669-1-arkadiusz.bokowy@gmail.com>
In-Reply-To: <20251215140203.638669-1-arkadiusz.bokowy@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 15 Dec 2025 10:10:06 -0500
X-Gm-Features: AQt7F2rSmhVlX1ods0Pk2lDrJA9nLKnSoJqWVQCZmbz8k0S-atzbkuerB_SOIqU
Message-ID: <CABBYNZ+bgaa4znWcjW_n_3n3_oKbPsptg0K80eZU8iQwR81kVA@mail.gmail.com>
Subject: Re: [PATCH] client/player: Refcount registered endpoints
To: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arkadiusz,

On Mon, Dec 15, 2025 at 9:58=E2=80=AFAM Arkadiusz Bokowy
<arkadiusz.bokowy@gmail.com> wrote:
>
> In case when more than one adapter is available on the host, the
> endpoint is registered on all of these adapters. When unregistering

org.bluez.Media is per adapter, so the likes of RegisterEndpoint
registers a new object per adapter.

> we need to keep track of registration count, otherwise we might free
> the endpoint structure prematurely (on the first unregister reply)
> which will cause SIGSEGV.

Do you have a backtrace or something? We don't reference struct
endpoint across different adapters afaik so this might be a different
bug or something.

> ---
>  client/player.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/client/player.c b/client/player.c
> index b6b02a000..cedb07d65 100644
> --- a/client/player.c
> +++ b/client/player.c
> @@ -127,6 +127,7 @@ struct endpoint {
>         struct codec_preset *codec_preset;
>         bool broadcast;
>         struct iovec *bcode;
> +       unsigned int refcount;
>  };
>
>  static DBusConnection *dbus_conn;
> @@ -3323,6 +3324,7 @@ static void register_endpoint_reply(DBusMessage *me=
ssage, void *user_data)
>         }
>
>         bt_shell_printf("Endpoint %s registered\n", ep->path);
> +       ep->refcount++;
>
>         return bt_shell_noninteractive_quit(EXIT_SUCCESS);
>  }
> @@ -3737,9 +3739,13 @@ static void unregister_endpoint_reply(DBusMessage =
*message, void *user_data)
>
>         bt_shell_printf("Endpoint %s unregistered\n", ep->path);
>
> -       local_endpoints =3D g_list_remove(local_endpoints, ep);
> -       g_dbus_unregister_interface(dbus_conn, ep->path,
> -                                       BLUEZ_MEDIA_ENDPOINT_INTERFACE);
> +       ep->refcount--;
> +
> +       if (ep->refcount =3D=3D 0) {
> +               local_endpoints =3D g_list_remove(local_endpoints, ep);
> +               g_dbus_unregister_interface(dbus_conn, ep->path,
> +                                           BLUEZ_MEDIA_ENDPOINT_INTERFAC=
E);
> +       }
>
>         return bt_shell_noninteractive_quit(EXIT_SUCCESS);
>  }
> --
> 2.51.0
>
>


--=20
Luiz Augusto von Dentz
