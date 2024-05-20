Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F47182D8
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 May 2024 16:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716223233; cv=none; b=IOIy9sEOjk1kH5BQqjw4bUc0DfwYtqmONsRxY8oBzwV4SKx0iDK54UkNTDuM0k423i8XswdznB9SpwqR8k9yJu4rd8Fm3msDpqJCyPzYF9HJzzNX4atWUBFgP8YL+w4KGgr2xbD75q5y5Z2w/Ajthoj/QdqOqB8ECgtIXEWxxzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716223233; c=relaxed/simple;
	bh=ucJFe87g+Y3tQN+JE4bAEVQOCDcv3GikzpHob/3l2JM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FmSOMmdtWLshlqSUoPzRksL9v0zIbzgRQjMjDbNvlJA30TFGLs5JEpbQwKS0aTU2NH2/d8fNu3n/L93l09RGK9SHsm8JCuwMcapt9oej5NLOoN173UoIgmN40wV82cTxm78LYULODszhN71tNsszy5UOnSq8UJk5vTc32tj2D90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RAQ1UoV6; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RAQ1UoV6"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2e73441edf7so3787891fa.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 May 2024 09:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716223230; x=1716828030; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=44+Shx2cR1Hfv0wx9XFmyGvMXzzZI1ZQdUZwD+SFt+Q=;
        b=RAQ1UoV6G8yt/DkgFzfBYzdTN6zgx+A0I60JOavV8NN148KjYI/o9QZSPKAQaQcLFR
         G37QKN30KugOQzXv6FlAJEkpYXDaxkkjJbwUYEsE2O8u2g9qPeV6TGtMqt05BC5JBf4w
         zEYaSZClVc2/hpJaqrHnoEt9aSR3GeaIH6kjUDvipSHWAjJgd22nscMSvXWApfF29n0f
         JCt55P7X5hhX83xKu9+ulaks1rkDkqUfzVNb0HCLz0nr08WVSA5vGqD2glANwsrKWfr/
         jGGmjuTcM2fpmoAde4AxiIqyJBotP8PukY+sDg4tpV5OzuiCYOXD5faU3GN4L9pednwh
         CZIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716223230; x=1716828030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=44+Shx2cR1Hfv0wx9XFmyGvMXzzZI1ZQdUZwD+SFt+Q=;
        b=gkE/d4l6XvvZR4NYLcQDMPEoWicYbnhGxMyDE+PIfkcfUsnY9abCWPkppPa5aQ/ujt
         nrAc4STYjZWztksdSRZMYd1rWLeeaKwEn3k2W2fkdqiSIAPym2dGvEW4W3Znfl+OE3PB
         Z/iI6bmQI5HdhWHJvY3VO5ox9GymcO+TzozqypcZTTuYYD+fYt7Rw+9fjBTdhtf+YGPi
         kWVBPIaWnoB8lL03Xn6FFrs+B+b8DPTHj60LGbP8re7vCVeOgDN8wBT71fqifZ7/eQ/z
         9SAKQFPuiU5NE0Taxwmd2N5IobvGWfQVbNKXporExIhJ7wnwQpsGB/h633NYoTUgIeFv
         Inxw==
X-Gm-Message-State: AOJu0Yx22DTdB88ji7ouk3SkAcNNxRbGK5Sz43Jx/S+4o0JD5nJahL3+
	3RE8lOtOr95lWZvwYbDRWab5WdRMI7/fHCjFFfaCeD1HbOgazz5YYoW91dqXCQy3w8rw/FaMQH+
	HGAwN8kTxZzUEp6OcoDrrzS4AyFM=
X-Google-Smtp-Source: AGHT+IE6kGEfbZbVPzBgQEHE+GZsqY5QSINd2ADKnrDEAf8zyrz9NjndvEhiB88gq4Zyv/I8H61YoPtG2qqIX3VDUOU=
X-Received: by 2002:a2e:701:0:b0:2e5:374b:bf00 with SMTP id
 38308e7fff4ca-2e5374bbf6fmr168040721fa.33.1716223230150; Mon, 20 May 2024
 09:40:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240520162757.78187-1-silviu.barbulescu@nxp.com> <20240520162757.78187-2-silviu.barbulescu@nxp.com>
In-Reply-To: <20240520162757.78187-2-silviu.barbulescu@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 20 May 2024 12:40:17 -0400
Message-ID: <CABBYNZLzSW1VBxZE_f=Qya31OerUxHuwHFOxQJtzNoNt29ia7g@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] shared/bap: Update BAP Broadcast Source state machine
To: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, mihai-octavian.urzica@nxp.com, 
	vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com, iulia.tanasescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Silviu,

On Mon, May 20, 2024 at 12:28=E2=80=AFPM Silviu Florian Barbulescu
<silviu.barbulescu@nxp.com> wrote:
>
> Update BAP Broadcast Source state machine states to use BAP define states
>  for source Idle, Config, Streaming, and an intermediary state enabling.

Not really following, what is an intermediary state? Or do you mean
internal state? And more importantly why would we need an internal
state like that?

> Updated test-bap too.
>
> ---
>  src/shared/bap.c | 39 ++++++++++++++++++++-------------------
>  unit/test-bap.c  |  4 ++--
>  2 files changed, 22 insertions(+), 21 deletions(-)
>
> diff --git a/src/shared/bap.c b/src/shared/bap.c
> index 6572ef1d1..639149520 100644
> --- a/src/shared/bap.c
> +++ b/src/shared/bap.c
> @@ -1361,14 +1361,6 @@ static void ep_config_cb(struct bt_bap_stream *str=
eam, int err)
>         if (err)
>                 return;
>
> -       if (bt_bap_stream_get_type(stream) =3D=3D BT_BAP_STREAM_TYPE_BCAS=
T) {
> -               if (bt_bap_stream_io_dir(stream) =3D=3D BT_BAP_BCAST_SINK=
)
> -                       stream_set_state(stream, BT_BAP_STREAM_STATE_QOS)=
;
> -               else if (bt_bap_stream_io_dir(stream) =3D=3D BT_BAP_BCAST=
_SOURCE)
> -                       stream_set_state(stream, BT_BAP_STREAM_STATE_CONF=
IG);
> -               return;
> -       }
> -
>         stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
>  }
>
> @@ -1759,6 +1751,15 @@ static unsigned int bap_stream_metadata(struct bt_=
bap_stream *stream,
>         return req->id;
>  }
>
> +static unsigned int bap_bcast_qos(struct bt_bap_stream *stream,
> +                                       struct bt_bap_qos *data,
> +                                       bt_bap_stream_func_t func,
> +                                       void *user_data)
> +{
> +       stream->qos =3D *data;
> +       return 1;
> +}
> +
>  static unsigned int bap_bcast_config(struct bt_bap_stream *stream,
>                                      struct bt_bap_qos *qos, struct iovec=
 *data,
>                                      bt_bap_stream_func_t func, void *use=
r_data)
> @@ -2071,7 +2072,7 @@ static unsigned int bap_bcast_get_state(struct bt_b=
ap_stream *stream)
>         return stream->state;
>  }
>
> -static unsigned int bap_bcast_enable(struct bt_bap_stream *stream,
> +static unsigned int bap_bcast_sink_enable(struct bt_bap_stream *stream,
>                                         bool enable_links, struct iovec *=
data,
>                                         bt_bap_stream_func_t func,
>                                         void *user_data)
> @@ -2081,22 +2082,21 @@ static unsigned int bap_bcast_enable(struct bt_ba=
p_stream *stream,
>         return 1;
>  }
>
> -static unsigned int bap_bcast_start(struct bt_bap_stream *stream,
> +static unsigned int bap_bcast_src_enable(struct bt_bap_stream *stream,
> +                                       bool enable_links, struct iovec *=
data,
>                                         bt_bap_stream_func_t func,
>                                         void *user_data)
>  {
> -       stream_set_state(stream, BT_BAP_STREAM_STATE_STREAMING);
> +       stream_set_state(stream, BT_BAP_STREAM_STATE_ENABLING);
>
>         return 1;
>  }
>
> -static unsigned int bap_bcast_sink_disable(struct bt_bap_stream *stream,
> -                                       bool disable_links,
> +static unsigned int bap_bcast_start(struct bt_bap_stream *stream,
>                                         bt_bap_stream_func_t func,
>                                         void *user_data)
>  {
> -       bap_stream_io_detach(stream);
> -       stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
> +       stream_set_state(stream, BT_BAP_STREAM_STATE_STREAMING);
>
>         return 1;
>  }
> @@ -2106,7 +2106,8 @@ static unsigned int bap_bcast_disable(struct bt_bap=
_stream *stream,
>                                         bt_bap_stream_func_t func,
>                                         void *user_data)
>  {
> -       stream_set_state(stream, BT_BAP_STREAM_STATE_DISABLING);
> +       bap_stream_io_detach(stream);
> +       stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
>
>         return 1;
>  }
> @@ -2205,14 +2206,14 @@ static const struct bt_bap_stream_ops stream_ops[=
] =3D {
>                         bap_ucast_release, bap_ucast_detach),
>         STREAM_OPS(BT_BAP_BCAST_SINK, bap_bcast_set_state,
>                         bap_bcast_get_state,
> -                       bap_bcast_config, NULL, bap_bcast_enable,
> -                       bap_bcast_start, bap_bcast_sink_disable, NULL,
> +                       bap_bcast_config, NULL, bap_bcast_sink_enable,
> +                       bap_bcast_start, bap_bcast_disable, NULL,
>                         bap_bcast_metadata, bap_bcast_sink_get_dir,
>                         bap_bcast_get_location,
>                         bap_bcast_release, bap_bcast_sink_detach),
>         STREAM_OPS(BT_BAP_BCAST_SOURCE, bap_bcast_set_state,
>                         bap_bcast_get_state,
> -                       bap_bcast_config, NULL, bap_bcast_enable,
> +                       bap_bcast_config, bap_bcast_qos, bap_bcast_src_en=
able,
>                         bap_bcast_start, bap_bcast_disable, NULL,
>                         bap_bcast_metadata, bap_bcast_src_get_dir,
>                         bap_bcast_get_location,
> diff --git a/unit/test-bap.c b/unit/test-bap.c
> index 46ee0e4e5..10f9e348c 100644
> --- a/unit/test-bap.c
> +++ b/unit/test-bap.c
> @@ -547,10 +547,10 @@ static void bsrc_state(struct bt_bap_stream *stream=
, uint8_t old_state,
>         struct test_data *data =3D user_data;
>
>         switch (new_state) {
> -       case BT_BAP_STREAM_STATE_QOS:
> +       case BT_BAP_STREAM_STATE_CONFIG:
>                 bt_bap_stream_enable(stream, true, NULL, NULL, NULL);
>                 break;
> -       case BT_BAP_STREAM_STATE_CONFIG:
> +       case BT_BAP_STREAM_STATE_ENABLING:
>                 data->base =3D bt_bap_stream_get_base(stream);
>
>                 g_assert(data->base);
> --
> 2.40.1
>


--=20
Luiz Augusto von Dentz
