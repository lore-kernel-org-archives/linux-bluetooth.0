Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB2567721
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jan 2024 13:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706536698; cv=none; b=ssQT35WDCYlt1e6C2N4I55GKDV8oHbyVOi/KYOQvoxJrDKdPGDSq3T0P+Mk1J+xdyvGhtbarf6pWLQ+SVGdy6cxZbIjK9OBBZpPLivF9cj8JNYOZWbr/VQmKDThVwRHsfdRLYNS04aqQAoFq4wzGk3AKOm4JSRfGJhtKna0S29E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706536698; c=relaxed/simple;
	bh=Zitl050dGhwx1u2RLlvYnH0IBwgpwaeKS3GEPzetF8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gfRAHAO3g30YshZYfFOtY/n0Yr7v8m2Dx3K1cwhVDS6ntUS+0fUgLpuD/IQJ5JeiV2PraoYB0zRqY4dQQDQibJegUqtO+w9/9TGxSyG11fyoE5XQwtj8FdPbL9KM0IQFaHEvOMs4EJ/TvoIrw0RUZ9xiXtVAzdsVznEX8mIIVVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hm5211ad; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hm5211ad"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2cf33b909e8so38697371fa.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jan 2024 05:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706536694; x=1707141494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E3pltyrYUnYzCic2pC9NYr3dO8UO41hNcc7S33FlDbc=;
        b=Hm5211advc+dBUXglqn4BK9GTe17ylw8XOrIzlJyfHciNsiQNdyOlAYcNdWQW91OJB
         g+fjUZIYhJdON/AlymY7wkb2UBlP9zqXn72GZB7YdgTZFooXCR1i8mRPSRYAc+OXgXvY
         P0cY2aZWU/l6qaPJ7+fKXzJr0FFGsMdzfcp5hUrBwatcwEZprV++TvVv4wgJbTKpmJS0
         44Rz/4TGDpktOBxO9DvAQYDxpv7Ki/g/yolS6sDxQlpG5zjVwZEIKgmgic2ipQTKXU9F
         jL6jvfJLJY2JG9l7Y7Ps/VltRxdsnVYkmrCBi3ABIA5NssGqbByDQOb+8G1HAqs5aBlu
         IkKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706536694; x=1707141494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E3pltyrYUnYzCic2pC9NYr3dO8UO41hNcc7S33FlDbc=;
        b=TUqmtStTr6fpo39eRii4kYtUAJLkKMPv/lhs/7g0XKI7L43r/e66fGa6rhDfoIABgC
         CQaSf01eJoeRVRn2XFESysQJom3f2yyc0rpdo/c+lcv2OKL/7BQjbY2Oc2cmHCXGj1dM
         j64/6SWO7idL/xeYLC40OLx8hyb8ViWPNHSAZTmJd1+0cnrSupFx06w/MNWpN+pwfzi4
         EO7/TWo8r4HyY46mGcDQ7hbSWmH4nE49F5MN20D3/5TubJmV72igviaWiVkVnUUMXMEE
         fzBg00YK5g/tp0U46k77nLoQX9eWJvyTFIQUjBpShRPNkY+11ZddRUoKqcR1bAhshWfQ
         nJSQ==
X-Gm-Message-State: AOJu0YxX2nh1LK2H5HmHcNMJbJWgYLVqiYAt252HT8jONWmeztl3ReRO
	dQtYSjryftYb3hKj5yk9DCpzbrA8fXNeDdWJZO7Z5UsU/JjB1zBah4HzP9PNKDh9IhjyQd47om0
	BEsH5vCKS59a2nOsUgp+eojw8zaAwFFQW
X-Google-Smtp-Source: AGHT+IGiGS2IZV+5/tvgSB+/7TWEccwo8BvW6PFQAPhPGiuoHOhvOebTpjRJuy+ShMfDz4UwXXn2oOLPWmJ6e1QnDl0=
X-Received: by 2002:a2e:9f4b:0:b0:2cf:1de7:1fd with SMTP id
 v11-20020a2e9f4b000000b002cf1de701fdmr2131683ljk.20.1706536694122; Mon, 29
 Jan 2024 05:58:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129114900.92919-1-verdre@v0yd.nl> <20240129114900.92919-4-verdre@v0yd.nl>
In-Reply-To: <20240129114900.92919-4-verdre@v0yd.nl>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 29 Jan 2024 08:58:00 -0500
Message-ID: <CABBYNZ+ujvMRouSMxPavG+mt3p8M6-otphEEj3U6sos_o=wJKg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 3/4] emulator/btdev: Send page timeout after 2 secs delay
To: =?UTF-8?Q?Jonas_Dre=C3=9Fler?= <verdre@v0yd.nl>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On Mon, Jan 29, 2024 at 6:49=E2=80=AFAM Jonas Dre=C3=9Fler <verdre@v0yd.nl>=
 wrote:
>
> Real bluetooth adapters wouldn't send the page timeout immediately
> when trying to page a device, instead it would take a few seconds.
>
> Try to behave more realistically in the emulator and send the page
> timeout after two seconds.
> ---
>  emulator/btdev.c | 30 +++++++++++++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
>
> diff --git a/emulator/btdev.c b/emulator/btdev.c
> index da94f29d1..a40117400 100644
> --- a/emulator/btdev.c
> +++ b/emulator/btdev.c
> @@ -1281,6 +1281,27 @@ static void conn_complete(struct btdev *btdev,
>         send_event(btdev, BT_HCI_EVT_CONN_COMPLETE, &cc, sizeof(cc));
>  }
>
> +struct page_timeout_data {
> +       struct btdev *btdev;
> +       uint8_t bdaddr[6];
> +       unsigned int timeout_id;
> +};
> +
> +static bool page_timeout(void *user_data)
> +{
> +       struct page_timeout_data *pt_data =3D user_data;
> +       struct btdev *btdev =3D pt_data->btdev;
> +       const uint8_t *bdaddr =3D pt_data->bdaddr;
> +
> +       timeout_remove(pt_data->timeout_id);
> +       pt_data->timeout_id =3D 0;
> +
> +       conn_complete(btdev, bdaddr, BT_HCI_ERR_PAGE_TIMEOUT);
> +
> +       free(pt_data);
> +       return false;
> +}
> +
>  static int cmd_create_conn_complete(struct btdev *dev, const void *data,
>                                                 uint8_t len)
>  {
> @@ -1298,7 +1319,14 @@ static int cmd_create_conn_complete(struct btdev *=
dev, const void *data,
>
>                 send_event(remote, BT_HCI_EVT_CONN_REQUEST, &cr, sizeof(c=
r));
>         } else {
> -               conn_complete(dev, cmd->bdaddr, BT_HCI_ERR_PAGE_TIMEOUT);
> +               struct page_timeout_data *pt_data =3D new0(struct page_ti=
meout_data, 1);
> +               pt_data->btdev =3D dev;
> +               memcpy(pt_data->bdaddr, cmd->bdaddr, 6);
> +
> +               /* Send page timeout after 2 seconds to emulate real pagi=
ng */
> +               pt_data->timeout_id =3D timeout_add(2000,
> +                                                 page_timeout,
> +                                                 pt_data, NULL);
>         }
>
>         return 0;
> --
> 2.43.0

We currently don't set a specific page timeout which means we are
using the default value which is 5.12 sec, so I'd replace 2000 with
5120, we might have to do something similar to LE Audio scanning
though since during this period the remote instance could enable
connections which should trigger the connection request event as well.


--=20
Luiz Augusto von Dentz
