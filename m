Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEB6215F44
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jan 2025 20:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737576864; cv=none; b=lrzVXmXjhiDbmnWnC5hqkeS96Y8NeQLzkYC9WxarxpCxomi+5ZDl9a+IbMsLCJ2AcmlpY+VvtRjytXlbfHUYEzAc15acjY23zXDwud1GfAHxgdWTqdjpVLavWtk1NjNbGlTaKC30zQcnP8JtLEVF8oEtxRN9AHnOa0VVxE4Okl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737576864; c=relaxed/simple;
	bh=heKOZduncDrivxmnxoATbyBfoQAk4NQObYIZttpxHtE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X7CgtIgj7RgeeJ3D0GYvIGPzhDDKPJ0ujZRHRvp7sKttFZFqVAFyU+EbfkcNeLzBErZKDQLs/NgewE3ujkf3cC04P45rIs7/IBDYLBUVeFWAFWNQTNRFk+jjVicCT6s6Nhcv0Vs9N23G5Zt0Nshe5PIxcxbgrEe7wuh5eNA5iGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZuYrjoM; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZuYrjoM"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3076262bfc6so966421fa.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jan 2025 12:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737576860; x=1738181660; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YdbOtzT1Ri3+z78zvSKjm2PGpGJCle4DMkCtr6BSEmE=;
        b=IZuYrjoMSIrUvlUsW0l67Xktz5xuObLmzCq/k0PchuPOGzrQtPpgRvF6j6OWb4+ORV
         XQFdpcqN5eyXWWAkNPAws8MNuplzmhsvrcYvM+Fe3wnERQOc/vjBUERrC7cntQ8oJDxD
         AQbkP0wiMALl+WMwzxMNnCjTzygPaReKyhegTsjx8JZ3JNsfvyBQbzRM0xkzH4J01Jab
         XcV0eoz8SYNm+sb8p55xlpF00fq0uvs/yeeI6deKb8ZbzsBc6iSx8gCE5nKutbtlUIjq
         Zjr/WgDcQjxKmbpkWc4ymBaKoObs1b905j4KxEEHykvWR+H/FoC6Qu/MVGuBdhF1nCIj
         BPlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737576860; x=1738181660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YdbOtzT1Ri3+z78zvSKjm2PGpGJCle4DMkCtr6BSEmE=;
        b=Rdw9gUo0nWXVWwZlW/mpdgBKc1vJTJ0XGQ2h5UbxwCz2DIM1YFeoilivSrLvQ1eY+W
         cR/MoqHhTFImdROg8OWYpAbtLUoEXHwIViW3Z8pIWz9ini8ZhWEutOGUBo5NXqgEGVBV
         WFUVlyW2iJ/RD8efEKEuoBkyzt3AgMspJP2Dux3smHotO0sfSHm/4+P671lskBzhiyCM
         YfO12SCfLEupRbyPXTQfJSTz89rCg0YSQ6gfAn2p7O00IUcM322rqnoO9uUxtk4+aexd
         sHopR+pJ2ln7sSTQoo5CeDlrWZx6k7AadkUpxr+//pU7WJ6bb8ZgsDozE9P5vhJyYmyt
         NrCQ==
X-Gm-Message-State: AOJu0YzxH5Xw+5krSZUZIaPPf9UixRdVNCNEuoZmzBhmw7BrX9BQu9eE
	JXPnbEHhQ1XMtA+jdIMBAWHGsBcrbks1YT2dIcx20HiT4SrWJ49BAQTMeNNVOBoCKDO/Rte02xa
	JPks/b/NHqxkV6hxjoys/dLkdpgCC/DL5
X-Gm-Gg: ASbGncuR98ACT12Gq+MznwJvGxNADdkEQZA+iRS+IRX+iE++ynVDInnD6gR/sPjY8j5
	8vCSenf7KCI+Fblc6Zu+7UDTc1d8VjTP9I6FW+5CDHkZ30nlPC+I/
X-Google-Smtp-Source: AGHT+IHQPMwuxwhn0JVTOqBgO7RQgklRu18q8fFjSSKmPyeZSabu5eqBg5N22it56OsH+YVHaGkUBEVzp3/M9jBKIW0=
X-Received: by 2002:a05:651c:19a8:b0:306:1500:3ec1 with SMTP id
 38308e7fff4ca-3072ca9cd5amr92171121fa.21.1737576859969; Wed, 22 Jan 2025
 12:14:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250121144404.4087658-1-michal.dzik@streamunlimited.com> <20250121144404.4087658-3-michal.dzik@streamunlimited.com>
In-Reply-To: <20250121144404.4087658-3-michal.dzik@streamunlimited.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 22 Jan 2025 15:14:06 -0500
X-Gm-Features: AbW1kvaOgxAumFBnNtEqWWkRHhs4s3uUKtyDcXg3O62puT-rh4J2Y1dqWX5Pu4E
Message-ID: <CABBYNZJJ08oyKJRk4az+d+1Sv4L0r08LJCy_g4jj6AmPFP1d1Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3 2/5] audio: connect VCP profile client to MediaTransport
To: Michal Dzik <michal.dzik@streamunlimited.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michal,

On Tue, Jan 21, 2025 at 9:44=E2=80=AFAM Michal Dzik
<michal.dzik@streamunlimited.com> wrote:
>
> It is now possible to control absolute volume of remote volume renderer
> device via dbus and also get notifications if the volume changes.
> ---
>  Makefile.plugins           |  2 +-
>  profiles/audio/transport.c | 37 +++++++++++++++++++------
>  profiles/audio/vcp.c       | 57 ++++++++++++++++++++++++++++++++++++--
>  profiles/audio/vcp.h       | 12 ++++++++
>  4 files changed, 95 insertions(+), 13 deletions(-)
>  create mode 100644 profiles/audio/vcp.h
>
> diff --git a/Makefile.plugins b/Makefile.plugins
> index 97335d643..81cf3155a 100644
> --- a/Makefile.plugins
> +++ b/Makefile.plugins
> @@ -128,7 +128,7 @@ endif
>
>  if VCP
>  builtin_modules +=3D vcp
> -builtin_sources +=3D profiles/audio/vcp.c
> +builtin_sources +=3D profiles/audio/vcp.h profiles/audio/vcp.c
>  endif
>
>  if MICP
> diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
> index a4198d23a..eff95a7c2 100644
> --- a/profiles/audio/transport.c
> +++ b/profiles/audio/transport.c
> @@ -55,6 +55,7 @@
>  #include "media.h"
>  #include "transport.h"
>  #include "bass.h"
> +#include "vcp.h"
>
>  #define MEDIA_TRANSPORT_INTERFACE "org.bluez.MediaTransport1"
>
> @@ -1420,6 +1421,7 @@ static const GDBusPropertyTable transport_bap_uc_pr=
operties[] =3D {
>         { "Location", "u", get_location },
>         { "Metadata", "ay", get_metadata },
>         { "Links", "ao", get_links, NULL, links_exists },
> +       { "Volume", "q", get_volume, set_volume, volume_exists },
>         { }
>  };
>
> @@ -2188,6 +2190,17 @@ static void bap_connecting(struct bt_bap_stream *s=
tream, bool state, int fd,
>         bap_update_links(transport);
>  }
>
> +static int8_t transport_bap_get_volume(struct media_transport *transport=
)
> +{
> +       return bt_audio_vcp_get_volume(transport->device);
> +}
> +
> +static int transport_bap_set_volume(struct media_transport *transport,
> +                                                               int8_t vo=
lume)
> +{
> +       return bt_audio_vcp_set_volume(transport->device, volume) ? 0 : -=
EIO;
> +}
> +
>  static void transport_bap_destroy(void *data)
>  {
>         struct bap_transport *bap =3D data;
> @@ -2411,7 +2424,8 @@ static void *transport_asha_init(struct media_trans=
port *transport, void *data)
>                         transport_bap_init, \
>                         transport_bap_resume, transport_bap_suspend, \
>                         transport_bap_cancel, _set_state, \
> -                       transport_bap_get_stream, NULL, NULL, NULL, \
> +                       transport_bap_get_stream, transport_bap_get_volum=
e, \
> +                       transport_bap_set_volume, NULL, \
>                         _update_links, transport_bap_destroy)
>
>  #define BAP_UC_OPS(_uuid) \
> @@ -2573,17 +2587,18 @@ struct btd_device *media_transport_get_dev(struct=
 media_transport *transport)
>  void media_transport_update_volume(struct media_transport *transport,
>                                                                 int8_t vo=
lume)
>  {
> -       struct a2dp_transport *a2dp =3D transport->data;
> -
>         if (volume < 0)
>                 return;
>
> -       /* Check if volume really changed */
> -       if (a2dp->volume =3D=3D volume)
> -               return;
> +       if (media_endpoint_get_sep(transport->endpoint)) {
> +               struct a2dp_transport *a2dp =3D transport->data;
>
> -       a2dp->volume =3D volume;
> +               /* Check if volume really changed */
> +               if (a2dp->volume =3D=3D volume)
> +                       return;
>
> +               a2dp->volume =3D volume;
> +       }
>         g_dbus_emit_property_changed(btd_get_dbus_connection(),
>                                         transport->path,
>                                         MEDIA_TRANSPORT_INTERFACE, "Volum=
e");
> @@ -2628,11 +2643,15 @@ void media_transport_update_device_volume(struct =
btd_device *dev,
>         /* Attempt to locate the transport to set its volume */
>         for (l =3D transports; l; l =3D l->next) {
>                 struct media_transport *transport =3D l->data;
> +               const char *uuid =3D media_endpoint_get_uuid(transport->e=
ndpoint);
>                 if (transport->device !=3D dev)
>                         continue;
>
> -               /* Volume is A2DP only */
> -               if (media_endpoint_get_sep(transport->endpoint)) {
> +               /* Volume is A2DP and BAP only */
> +               if (media_endpoint_get_sep(transport->endpoint) ||
> +                               strcasecmp(uuid, PAC_SINK_UUID) ||
> +                               strcasecmp(uuid, PAC_SOURCE_UUID) ||
> +                               strcasecmp(uuid, BAA_SERVICE_UUID)) {
>                         media_transport_update_volume(transport, volume);
>                         break;
>                 }
> diff --git a/profiles/audio/vcp.c b/profiles/audio/vcp.c
> index 175275f2e..cc6f352c1 100644
> --- a/profiles/audio/vcp.c
> +++ b/profiles/audio/vcp.c
> @@ -51,6 +51,9 @@
>  #include "src/log.h"
>  #include "src/error.h"
>
> +#include "vcp.h"
> +#include "transport.h"
> +
>  #define VCS_UUID_STR "00001844-0000-1000-8000-00805f9b34fb"
>  #define MEDIA_ENDPOINT_INTERFACE "org.bluez.MediaEndpoint1"
>
> @@ -83,6 +86,33 @@ static struct vcp_data *vcp_data_new(struct btd_device=
 *device)
>         return data;
>  }
>
> +static bool match_data(const void *data, const void *match_data)
> +{
> +       const struct vcp_data *vdata =3D data;
> +       const struct bt_vcp *vcp =3D match_data;
> +
> +       return vdata->vcp =3D=3D vcp;
> +}
> +
> +static int8_t scale_volume_vcp2transport(uint8_t volume)
> +{
> +       /* Transport has volume range 0-127, VCP has range 0-255 */
> +       return volume / 2;
> +}
> +
> +static uint8_t scale_volume_transport2vcp(int8_t volume)
> +{
> +       return volume * 2;
> +}

Now I understand why you are doing this, it seems there is an
assumption that we should stick to 0-127 range from A2DP, but perhaps
we document that Transport.Volume range is dependent on the
Transport.UUID so for VCP we can use 0-255, in case you were looking
into how ASHA was implemented that has a different problem because
Volume is returning uint16 we can't really use negative numbers thus
why that uses scaling. Anyway for now let go this way but if you have
time please just update the document so we can remove this scaling and
leave it for the clients to interpret based on the Transport.UUID.

> +static void vcp_volume_changed(struct bt_vcp *vcp, uint8_t volume)
> +{
> +       struct vcp_data *data =3D queue_find(sessions, match_data, vcp);
> +
> +       if (data)
> +               media_transport_update_device_volume(data->device, scale_=
volume_vcp2transport(volume));
> +}
> +
>  static void vcp_data_add(struct vcp_data *data)
>  {
>         DBG("data %p", data);
> @@ -93,6 +123,7 @@ static void vcp_data_add(struct vcp_data *data)
>         }
>
>         bt_vcp_set_debug(data->vcp, vcp_debug, NULL, NULL);
> +       bt_vcp_set_volume_callback(data->vcp, vcp_volume_changed);
>
>         if (!sessions)
>                 sessions =3D queue_new();
> @@ -103,12 +134,12 @@ static void vcp_data_add(struct vcp_data *data)
>                 btd_service_set_user_data(data->service, data);
>  }
>
> -static bool match_data(const void *data, const void *match_data)
> +static bool match_device(const void *data, const void *match_data)
>  {
>         const struct vcp_data *vdata =3D data;
> -       const struct bt_vcp *vcp =3D match_data;
> +       const struct btd_device *device =3D match_data;
>
> -       return vdata->vcp =3D=3D vcp;
> +       return vdata->device =3D=3D device;
>  }
>
>  static void vcp_data_free(struct vcp_data *data)
> @@ -137,6 +168,26 @@ static void vcp_data_remove(struct vcp_data *data)
>         }
>  }
>
> +int8_t bt_audio_vcp_get_volume(struct btd_device *device)
> +{
> +       struct vcp_data *data =3D queue_find(sessions, match_device, devi=
ce);
> +
> +       if (data)
> +               return scale_volume_vcp2transport(bt_vcp_get_volume(data-=
>vcp));
> +
> +       return 0;
> +}
> +
> +bool bt_audio_vcp_set_volume(struct btd_device *device, int8_t volume)
> +{
> +       struct vcp_data *data =3D queue_find(sessions, match_device, devi=
ce);
> +
> +       if (data)
> +               return bt_vcp_set_volume(data->vcp, scale_volume_transpor=
t2vcp(volume));
> +
> +       return FALSE;
> +}
> +
>  static void vcp_detached(struct bt_vcp *vcp, void *user_data)
>  {
>         struct vcp_data *data;
> diff --git a/profiles/audio/vcp.h b/profiles/audio/vcp.h
> new file mode 100644
> index 000000000..f313cd96a
> --- /dev/null
> +++ b/profiles/audio/vcp.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2024 StreamUnlimited Engineering GmbH
> + *
> + *
> + */
> +
> +int8_t bt_audio_vcp_get_volume(struct btd_device *device);
> +bool bt_audio_vcp_set_volume(struct btd_device *device, int8_t volume);
> --
> 2.34.1
>
>


--=20
Luiz Augusto von Dentz
