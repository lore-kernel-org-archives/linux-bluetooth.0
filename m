Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3859E76C9C
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Feb 2024 19:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708456227; cv=none; b=lBetnnvLgxM5vc44LohtSMgk3jI9bs3j426YGCXTLPouoia7JpMP/jQsuufW0ywQL4zKuuQIM8SH/O/+4urogz3eiDSP7zlnazFdEYalGn+CbCitonOT+4w2BSI73ipVXwYweNaA7hHDmdRVkKy92NyGpPzySgfIDhiRP9Je6Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708456227; c=relaxed/simple;
	bh=iEHYIou+4+i7VY0TcX+FbGPWw2PKLo/A5wQEkrIexAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a+oHSM5nHLUZpxs517/NnzcS+MuuhN1LT47NQFcGO7gmNIBDmMBPZjA0UhDQk/jTu6dbMTUdxhXlOFa/0qhv/2TZmfO2ACcUFqCg84Lv8LL4cRxn2P7L0P/0ynPCpoBQIg0UYYgDc2PdrU0aGBzZlyHJ4FltqFxZmRmJnKvnMGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KQV6hwjo; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQV6hwjo"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d1094b5568so77315011fa.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Feb 2024 11:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708456223; x=1709061023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u6vzG72NaYuZDX3ICQRal7rxTpULVtCmDxBdOjw42tw=;
        b=KQV6hwjoWGG6usx+3o01F4f1gcnZNpunYp0V7877KMBizMMosYk5nZA7QrWyfRM41Y
         6iZ/yL4MS2kEFYkGIQgT/oOf4z9pE+9iuMVxd0dHduosoXnOYMRBprZW5SpEzlrv8uSD
         qfPtNtT4ZKdb/ddmLU8nEMY2apQARdpPR1vklMwtZjllE+nQqx1Ef3P/JB1S0R/YNW/l
         pLgoRk9wCf/ijljNBAEm8g4iHXUlUpQYW2ycaXpAeyyxg5heGrK5hEfkoyqPN4oIjpsU
         c8qMiltUi3dpkl3GlrFbFFMERTS0B//bHqV+843YzlAzUsOcmqW4WL/i47X55QkklaQw
         kMbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708456223; x=1709061023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u6vzG72NaYuZDX3ICQRal7rxTpULVtCmDxBdOjw42tw=;
        b=jZPSZHXvlNPQa91RBgYllWKCWuz8QhLmjLtgbTQwUyvxBXPnHpVSkPhYrgDKbNsOJf
         SjeincbV/GyAfK0jbB0LfWfyCbHFHDz0YGaUagXTR8U5wfvjvI2SaK3Zua0Z7iddkC9A
         ImqH7lMBMaojWxpzYSBo1IR4tPXWEMlx605zuKbQ0GonQOcR0Swtv9d3vDhjW8VKVCIR
         gRnKTGLyOYwbW4eXVhovBl8DOI4N3B3K22USsqaKf4SYQwNjR+CtmyrvZS74gE/0iMTY
         H7gKnl8SK6Sd6PScgABZIkKiPuk4BmOq1XqMjtU3gZAWdPiwPBZH1vNd7WNR1wsi0f7U
         BPoA==
X-Gm-Message-State: AOJu0YyTtdVAx9BiJQ7+gA0bKENAHoS87JaELiDQaIRGdPZ8BzE5dAbX
	fwahiDlpu0mF5KFL3j6OUQsQfJV3tub5AUSFtEBBdUFmJDZ4c5abMOWqrAqAlrUPwtG1yPQSazk
	FFVU2HmbMRy1BQjqH1efdEpnyK/Mi2KkQ
X-Google-Smtp-Source: AGHT+IHFfVDXAzSCU/3q3kfalscsMeqIRv2IfzLq9n9BusOK9mlxaR+e00AWzfBxA3PH8P2vrdZjkzbkqIFokbTi00A=
X-Received: by 2002:a2e:b4a2:0:b0:2d2:4703:1ac3 with SMTP id
 q2-20020a2eb4a2000000b002d247031ac3mr1804490ljm.5.1708456222953; Tue, 20 Feb
 2024 11:10:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215212356.310301-1-silviu.barbulescu@nxp.com> <20240215212356.310301-5-silviu.barbulescu@nxp.com>
In-Reply-To: <20240215212356.310301-5-silviu.barbulescu@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 20 Feb 2024 14:10:10 -0500
Message-ID: <CABBYNZJ=yn6O8TEJ0p3Q-JF0UpHTKxHy8tEd_Qv+JQ4vuYm6XA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3 4/7] shared/bap: Add state in stream struct for
 bcast source
To: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, mihai-octavian.urzica@nxp.com, 
	vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com, iulia.tanasescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Silviu,

On Thu, Feb 15, 2024 at 4:24=E2=80=AFPM Silviu Florian Barbulescu
<silviu.barbulescu@nxp.com> wrote:
>
> Add state support in the stream struct for broadcast source.
> ---
>  src/shared/bap.c | 32 ++++++++++++++++++--------------
>  1 file changed, 18 insertions(+), 14 deletions(-)
>
> diff --git a/src/shared/bap.c b/src/shared/bap.c
> index a39b95407..524bfa058 100644
> --- a/src/shared/bap.c
> +++ b/src/shared/bap.c
> @@ -251,6 +251,8 @@ struct bt_bap_stream {
>         struct bt_bap_stream *link;
>         struct bt_bap_stream_io *io;
>         const struct bt_bap_stream_ops *ops;
> +       uint8_t bcast_old_state;
> +       uint8_t bcast_state;

Lets have it as generic one, old_state and state.

>         bool client;
>         void *user_data;
>  };
> @@ -1271,7 +1273,6 @@ static void bap_stream_state_changed(struct bt_bap_=
stream *stream)
>
>  static void stream_set_state(struct bt_bap_stream *stream, uint8_t state=
)
>  {
> -       struct bt_bap_endpoint *ep =3D stream->ep;
>         struct bt_bap *bap =3D stream->bap;
>
>         /* Check if ref_count is already 0 which means detaching is in
> @@ -1283,14 +1284,6 @@ static void stream_set_state(struct bt_bap_stream =
*stream, uint8_t state)
>                 return;
>         }
>
> -       ep->old_state =3D ep->state;
> -       ep->state =3D state;
> -
> -       DBG(bap, "stream %p dir 0x%02x: %s -> %s", stream,
> -                       bt_bap_stream_get_dir(stream),
> -                       bt_bap_stream_statestr(stream->ep->old_state),
> -                       bt_bap_stream_statestr(stream->ep->state));
> -
>         if (stream->ops && stream->ops->set_state)
>                 stream->ops->set_state(stream, state);
>
> @@ -1527,6 +1520,14 @@ static void bap_ucast_set_state(struct bt_bap_stre=
am *stream, uint8_t state)
>  {
>         struct bt_bap_endpoint *ep =3D stream->ep;
>
> +       ep->old_state =3D ep->state;
> +       ep->state =3D state;
> +
> +       DBG(stream->bap, "stream %p dir 0x%02x: %s -> %s", stream,
> +                       bt_bap_stream_get_dir(stream),
> +                       bt_bap_stream_statestr(stream->ep->old_state),
> +                       bt_bap_stream_statestr(stream->ep->state));
> +
>         if (stream->lpac->type =3D=3D BT_BAP_BCAST_SINK || stream->client=
)
>                 goto done;
>
> @@ -1942,22 +1943,25 @@ static void bap_bcast_set_state(struct bt_bap_str=
eam *stream, uint8_t state)
>         struct bt_bap *bap =3D stream->bap;
>         const struct queue_entry *entry;
>
> +       stream->bcast_old_state =3D stream->bcast_state;
> +       stream->bcast_state =3D state;
> +
>         DBG(bap, "stream %p dir 0x%02x: %s -> %s", stream,
>                         bt_bap_stream_get_dir(stream),
> -                       bt_bap_stream_statestr(stream->ep->old_state),
> -                       bt_bap_stream_statestr(stream->ep->state));
> +                       bt_bap_stream_statestr(stream->bcast_old_state),
> +                       bt_bap_stream_statestr(stream->bcast_state));
>
>         for (entry =3D queue_get_entries(bap->state_cbs); entry;
>                                                         entry =3D entry->=
next) {
>                 struct bt_bap_state *state =3D entry->data;
>
>                 if (state->func)
> -                       state->func(stream, stream->ep->old_state,
> -                                       stream->ep->state, state->data);
> +                       state->func(stream, stream->bcast_old_state,
> +                                       stream->bcast_state, state->data)=
;
>         }
>
>         /* Post notification updates */
> -       switch (stream->ep->state) {
> +       switch (stream->bcast_state) {
>         case BT_ASCS_ASE_STATE_IDLE:
>                 bap_stream_detach(stream);
>                 break;
> --
> 2.39.2
>


--=20
Luiz Augusto von Dentz
