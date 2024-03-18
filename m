Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C7B55766
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 Mar 2024 17:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710782618; cv=none; b=YQB9akuZLNDxdv6ZU4+rJbdnQQLjDZ1V9Mn/HP/QRyHoptAt95GIs1sX6In32Y2thgbPMzjZm/rIw8Y/bWWpC6uzM4W2oDyN9s/1zVLVvot6V5QjOZ7RGgxMX5R9agzIEmnPbbhm5OAIA6FoNzog3Oscrq92AOmVePz5sOMP3O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710782618; c=relaxed/simple;
	bh=bJqF9O+GdJ3ga2St22sRFc9xNtsscY21+vk+q6DYjZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gvMfWJ6dYKI0DC7Jce46unHlmEBSgtC26C9BBYmajyCNMOSGweewYLCRK5LZhARrnhah9KXvepBA21hcQYH0R/m/rz6jX9vSsXFapM13BUretZt68gIlDkWHUhiLPZAh3RlYsHlw0tklsA0oXfuoirc05RuarRUYIfy3jD9MeOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jw+pgpjc; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jw+pgpjc"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d204e102a9so54328221fa.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Mar 2024 10:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710782615; x=1711387415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j8yBw2XUIzs8AI9CIyeWMypWy3aXK6H8HcTA09+tcB4=;
        b=jw+pgpjcBIvSn9gohE5tOsB9x/bXCcD/jSOG5xMF0k1qQB5n/CnBtRYA/I6V56AaZ6
         AdFHGl86hUnFkJ/tfWMDVSdGsZUG/Deh2P6NevV9+4KCLtG8GVlXTLAbjJF/U+eRWvgZ
         Ub3Fww6WmTZmvwut2iPwFpKvGPKkLrm7/u2+5K4QA1uYa2FBsLvulWlz4BbsVQ7bU6rZ
         sg+GKISOVafdZb2iK7dL2XtLWX2JfotuwbcbpjavgguAOkM90s5Hy9F3U9HLYXOSvEIC
         TjAa6e7aOe1cjWzp+K5jupGuJIyCFP5wYk1gtu3qCUKzDYMSchQgpgm6Aq7kxp6qiESE
         ALjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710782615; x=1711387415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j8yBw2XUIzs8AI9CIyeWMypWy3aXK6H8HcTA09+tcB4=;
        b=SXZuCUynyiOxwvUj+gFihLIpG42Ws/cMTmkQshFd7l8hulvKAzmay9TwQMZkkxfEFV
         RUEoXbk1dlz7dg58iD9e+CNqWIEgNvDpT/ACdHJpuZoUG0qiZZ7ib8LaHCbYOcQv53vu
         nMemyEyVGZOtvT/EEJXchUOyQX63hVVH1KxUwYQp9tUUNg7CMiksD9MU5w21nIX59Ufg
         7PA5KarR8ItAfRkSs/S9qE/Fbi5PG0DEwjgbPS6MnfES2EDI9pbUwk6sw1yIO3nNu40Q
         0Vaz7oAEE89OhxQx6m9EjDA3xD+tanXR3HJeQKK0wjZ5ZjSCme8wG+N3Zx3tg8Gfoi1w
         Y2LA==
X-Gm-Message-State: AOJu0Yycc4g7wYsBPL0KS2pbjhPiXgqtJKjbDkDYC4Lhb+n7tT2FvnV+
	8g0/tbbQbWyot9e7Fq0MNz46CMxYxuncTPCEdCTHJnoPkgIwRw4lC+LjM8x8INdCmvIDaQ+BtMp
	LxYy994BKshbxGZI0W9XRD3PuIzU=
X-Google-Smtp-Source: AGHT+IHKilkerznZ/sm4EzmlGkChViDDIBZxZf8UZn56Gv0slqtSd7GlvY+c15Feyd3Ka6G0ckmhU84ZV5omDNFOCgU=
X-Received: by 2002:a05:651c:2109:b0:2d4:a232:757 with SMTP id
 a9-20020a05651c210900b002d4a2320757mr3366256ljq.7.1710782614812; Mon, 18 Mar
 2024 10:23:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318163853.68598-1-silviu.barbulescu@nxp.com> <20240318163853.68598-3-silviu.barbulescu@nxp.com>
In-Reply-To: <20240318163853.68598-3-silviu.barbulescu@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 18 Mar 2024 17:23:21 +0000
Message-ID: <CABBYNZJPc4fSuH_brvN97NMUQDK9s8cJgw5T-JzhgMswYgMFHA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v4 2/5] transport: Add support to update the
 transport config
To: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, mihai-octavian.urzica@nxp.com, 
	vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com, iulia.tanasescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Silviu,

On Mon, Mar 18, 2024 at 4:39=E2=80=AFPM Silviu Florian Barbulescu
<silviu.barbulescu@nxp.com> wrote:
>
> Add support to update the transport configuration
>
> ---
>  profiles/audio/transport.c | 21 +++++++++++++++++++++
>  profiles/audio/transport.h |  1 +
>  2 files changed, 22 insertions(+)
>
> diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
> index 159fbd575..122c3339e 100644
> --- a/profiles/audio/transport.c
> +++ b/profiles/audio/transport.c
> @@ -1483,6 +1483,27 @@ static void bap_update_bcast_qos(const struct medi=
a_transport *transport)
>                         "Configuration");
>  }
>
> +void bap_update_bcast_config(struct media_transport *transport)
> +{
> +       struct bap_transport *bap =3D transport->data;
> +       struct iovec *cc;
> +
> +       cc =3D bt_bap_stream_get_config(bap->stream);
> +
> +       if (((int)cc->iov_len !=3D transport->size) ||
> +               (memcmp(cc->iov_base, transport->configuration,
> +                       transport->size) !=3D 0)) {

Lets just use util_iov_memcmp, just init transport->configuration into an i=
ov.

> +               free(transport->configuration);
> +               transport->configuration =3D util_memdup(cc->iov_base,
> +                                                       cc->iov_len);
> +               transport->size =3D cc->iov_len;
> +
> +               g_dbus_emit_property_changed(btd_get_dbus_connection(),
> +                       transport->path, MEDIA_TRANSPORT_INTERFACE,
> +                       "Configuration");
> +       }
> +}
> +
>  static guint transport_bap_resume(struct media_transport *transport,
>                                 struct media_owner *owner)
>  {
> diff --git a/profiles/audio/transport.h b/profiles/audio/transport.h
> index b46bc8025..6df419a67 100644
> --- a/profiles/audio/transport.h
> +++ b/profiles/audio/transport.h
> @@ -16,6 +16,7 @@ struct media_transport *media_transport_create(struct b=
td_device *device,
>                                                 uint8_t *configuration,
>                                                 size_t size, void *data,
>                                                 void *stream);
> +void bap_update_bcast_config(struct media_transport *transport);
>
>  void media_transport_destroy(struct media_transport *transport);
>  const char *media_transport_get_path(struct media_transport *transport);
> --
> 2.39.2
>


--=20
Luiz Augusto von Dentz
