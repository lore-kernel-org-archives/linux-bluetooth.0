Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47B327A121
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 Aug 2025 15:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754407509; cv=none; b=i1mboMZlAIAT3aevhit/ILEbI3tduK2QAWDIzVSY/BnElrUv/yUm33Fcw/J58xSr+ajeEVNofaaLeOh6gC7W5p4pXBKhRqYo5r9xja7RMZCfHrCqwf+KZanYIalpZKSCtl28kZ4fYdpp/mfiLVS3CGve9Yp6J5Z/p1yOT4KjfvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754407509; c=relaxed/simple;
	bh=3tQPhjRls5jzS+ZsLGbRmxltCcEN8zvpSfSqTTXw7/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VjOHWHdiG52ErbzAyTPGdF/Scjh+7ZKeEZYDXIwZWGKwTU9QZY/tho3MgA8gHXc2AGTdhFB5u5lYaOUh49e7GsmSUlYmLNsmFlnPLDD/Jnty94GUgfaJGDwy43ZwobFgbwSk3Tk73QVmpOktyxVPZhpExShIGO/2F1WrmytgYzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f5Yx7Fis; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5Yx7Fis"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-33275f235ffso9363541fa.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 Aug 2025 08:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754407505; x=1755012305; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lBXR6Q9nB0QOzrdaXqAnKnU6hYf1jf27mcZItgUA0uI=;
        b=f5Yx7FisY2i+vhMBv4fimLLno+DlCVB6XKkBdgFxoobgF8sE23x1jP5TdF4ZqJHj7K
         sofUAdrCzHWI93y/U9ywUYCRl+VBSM9p9w6Sd21rjHEO12pL7dnEcQpLc+LRNv5saI0O
         E2SDXy1MrlPq0jmLQTLTdxWbu+9Q8b7BIugKVjVi6/W29YULI+MdlFJTxbO4E1TSH+Wz
         XUvO9WQXv+VvXCwPC937YlE5dMkHsTuUxxmxT8zLprra+m+g2YkdmvcjwiVR4iFPWgL9
         2y1NU1b6TROTwH/t8KmTFs99SquwH6TPUJa42gvdddWOaqtITSmNQvYpNMzK/DxPwDvS
         Rucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754407505; x=1755012305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lBXR6Q9nB0QOzrdaXqAnKnU6hYf1jf27mcZItgUA0uI=;
        b=GOzZbsPASQeDkrJfbBbUgnL4dYkD82omhtSOrJgBC9ymCMeg7yOIut7lLNLplL7FQR
         dRcghNln7aDtwUPLHfktSNTcwFdMBBe9EQh8h2Pub3l88g8j3Sllorp4/ogstS7jUfLv
         eyBvvQhE+vdItB22eo+LSwejGtS7+GlDI0FshGwOoF+xj9EBr2uAD89hdlLvxW1/r0XT
         mRjKeIgULYanGiSXucnY0PLpFxPCV0hQ04+wHGvYY8puLT/GO9nfskAKpJjcjJbkyDKr
         X95G9oZl9aY+VCfsbzYKiecGG6qNdh08cNSN+lnJuQAEgdTtPTQNzefDiHgEpm7FD9Wz
         1NoQ==
X-Gm-Message-State: AOJu0YxWOM5teGr2zz558eSK8ma/UdcSlvl2DQa+7Gz7VtOnzfLPMuLq
	Zd1ulOR4k0jj8nbHdmx92Yx7OVkd6TcW4qe5B2wEBjP8sUDvox2DbDjfZibSXwRvgeRIKTBbU1p
	zUgcNE/rjC6B1NnrC2K1O2zOFsn1FG3l/OXs6P+g=
X-Gm-Gg: ASbGncsvwjY9kWnUKYml2J7CK52G71R5rHbkipIJpcRDVC0gMFh3EgkzidDP9CTiUUn
	IqZZbS3iiRX8tos7yCt5JaI0ilkyVjb+O2MfoCPNksAguv8afkkGYYqP/WulgSp0WIY5sTug4FO
	ZbY0AoDjzXbRp+Kwqd95svdqJGPKW+oAjcdihODlVe4VGzBPqaQnKhPVaFlV62befgvYhiPKGmK
	w+jmkbRGYTNKPEQ
X-Google-Smtp-Source: AGHT+IHBteYrgsC+jE/jIMGTCXo0yp9TlmMkaZc4UwaLrXcxpUxsiEBRIQUcezIrJrRVOWm1ptAV/ITKRUZMynzXQnk=
X-Received: by 2002:a05:651c:513:b0:332:53af:83da with SMTP id
 38308e7fff4ca-3327b91d164mr10857121fa.13.1754407504583; Tue, 05 Aug 2025
 08:25:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250805-audio-no-reuse-media-player-volume-v1-1-c9fdfaf74a71@qtmlabs.xyz>
In-Reply-To: <20250805-audio-no-reuse-media-player-volume-v1-1-c9fdfaf74a71@qtmlabs.xyz>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 5 Aug 2025 11:24:52 -0400
X-Gm-Features: Ac12FXwgHnXu_R9Ip2smZjAqr08MLKSC-1SjhEdHjBWuoXXjFiXespny1YEIyK0
Message-ID: <CABBYNZJ=Kc_WMa2Srnci=20e+F+JZyPmWFXsjxt8sn_6g0coKQ@mail.gmail.com>
Subject: Re: [PATCH bluez] audio: Don't initialize device volume from media player
To: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>
Cc: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Myrrh,

On Tue, Aug 5, 2025 at 6:29=E2=80=AFAM Myrrh Periwinkle
<myrrhperiwinkle@qtmlabs.xyz> wrote:
>
> Media player objects may be shared between devices. As a result,
> a device without support for hardware volume that is connected after one
> that does may end up being erroneously considered hardware
> volume-capable.

Don't quite follow, avrcp_player is per device, not sure how it can be
shared between devices?

> fa7828bdd ("transport: Fix not being able to initialize volume properly")
> introduced btd_device_{get,set}_volume that is used as an alternative in
> case no media player objects are present. Therefore, we can remove
> media_player_get_device_volume and instead use btd_device_get_volume to
> determine the initial volume.

Don't follow you here, why shouldn;t we use the media player if we have one=
?

> ---
>  profiles/audio/avrcp.c |  2 +-
>  profiles/audio/media.c | 33 +--------------------------------
>  profiles/audio/media.h |  1 -
>  3 files changed, 2 insertions(+), 34 deletions(-)
>
> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> index e2797112fcd580c3fc56793f933e00b1c61e5205..ec07522e6a34eb1dc5f6f413f=
48f1087a609df9a 100644
> --- a/profiles/audio/avrcp.c
> +++ b/profiles/audio/avrcp.c
> @@ -4284,7 +4284,7 @@ static void target_init(struct avrcp *session)
>                 target->player =3D player;
>                 player->sessions =3D g_slist_prepend(player->sessions, se=
ssion);
>
> -               init_volume =3D media_player_get_device_volume(session->d=
ev);
> +               init_volume =3D btd_device_get_volume(session->dev);
>                 media_transport_update_device_volume(session->dev, init_v=
olume);
>         }
>
> diff --git a/profiles/audio/media.c b/profiles/audio/media.c
> index 8e62dca17070edbc5101677c6eebd3707492c824..55f1482d1d9ce52e104481bab=
3ede373f47aee0c 100644
> --- a/profiles/audio/media.c
> +++ b/profiles/audio/media.c
> @@ -499,37 +499,6 @@ struct a2dp_config_data {
>         a2dp_endpoint_config_t cb;
>  };
>
> -int8_t media_player_get_device_volume(struct btd_device *device)
> -{
> -#ifdef HAVE_AVRCP
> -       struct avrcp_player *target_player;
> -       struct media_adapter *adapter;
> -       GSList *l;
> -
> -       if (!device)
> -               return -1;
> -
> -       target_player =3D avrcp_get_target_player_by_device(device);
> -       if (!target_player)
> -               goto done;
> -
> -       adapter =3D find_adapter(device);
> -       if (!adapter)
> -               goto done;
> -
> -       for (l =3D adapter->players; l; l =3D l->next) {
> -               struct media_player *mp =3D l->data;
> -
> -               if (mp->player =3D=3D target_player)
> -                       return mp->volume;
> -       }
> -
> -done:
> -#endif /* HAVE_AVRCP */
> -       /* If media_player doesn't exists use device_volume */
> -       return btd_device_get_volume(device);
> -}
> -
>  static gboolean set_configuration(struct media_endpoint *endpoint,
>                                         uint8_t *configuration, size_t si=
ze,
>                                         media_endpoint_cb_t cb,
> @@ -556,7 +525,7 @@ static gboolean set_configuration(struct media_endpoi=
nt *endpoint,
>         if (transport =3D=3D NULL)
>                 return FALSE;
>
> -       init_volume =3D media_player_get_device_volume(device);
> +       init_volume =3D btd_device_get_volume(device);
>         media_transport_update_volume(transport, init_volume);
>
>         msg =3D dbus_message_new_method_call(endpoint->sender, endpoint->=
path,
> diff --git a/profiles/audio/media.h b/profiles/audio/media.h
> index 2b2e8e1572874d5f71abb28fdd5b92fa2d9efe83..d3954abd6de505a69cab3fcff=
c217d236a52d3e5 100644
> --- a/profiles/audio/media.h
> +++ b/profiles/audio/media.h
> @@ -23,6 +23,5 @@ uint8_t media_endpoint_get_codec(struct media_endpoint =
*endpoint);
>  struct btd_adapter *media_endpoint_get_btd_adapter(
>                                         struct media_endpoint *endpoint);
>  bool media_endpoint_is_broadcast(struct media_endpoint *endpoint);
> -int8_t media_player_get_device_volume(struct btd_device *device);
>
>  const struct media_endpoint *media_endpoint_get_asha(void);
>
> ---
> base-commit: 2c0c323d08357a4ff3065fcd49fee0c83b5835cd
> change-id: 20250805-audio-no-reuse-media-player-volume-fbc2983a287a
>
> Best regards,
> --
> Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>
>
>


--=20
Luiz Augusto von Dentz
