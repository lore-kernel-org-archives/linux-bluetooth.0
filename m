Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030CA28A2A0
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Feb 2025 16:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739464490; cv=none; b=Cs5lhymL28HsgkyTa9B7PV0vTHDrFjaifqRuu6fbrreexlc+34TFX/6TqrjnCEHJBQnFa9UIoqkaJpmwg25ovlhcYdYOGOCO7ZNziJuVwwBdUTNYXSXRsUOZS/A3EAGZ5b4EK1tbN7q+gNx/MkSKf5qC0LjA9dNfoN3lhwrbg3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739464490; c=relaxed/simple;
	bh=YJSqKbk5b6EhdUWVmOIChjWOUhyfJLIW+pGu/1fBGJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HXNBeNzGkQerM0intR8K3V2OsF7/40RPq9aE82pNt3w5viw/MM9OxocbCwXNvKSwLZTeWbaR411by3aU452PPmsDXMHywQjkca84I/XMM7zJ3k08uNF8hQfLvthe08Om265ZNKTVkIkCQ2KcVBkpsJEUd/bCC4K973/sfBO/Ojg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZHP+ibI; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZHP+ibI"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-309025ec288so10633131fa.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Feb 2025 08:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739464487; x=1740069287; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RX9v7hUQe5JQNCF1yZ/adv1iKbJ1paV1DYSHYQi3q0o=;
        b=fZHP+ibI5bx6PIUlEIjQl2WEhlPxv8MI6vQ+7R10YeUaS+4rPdBHM8OH6z7T0dD/Vz
         clyj5uORmksB6CnQlOg2zGeWs8M/Q1S4tyi17lUGSN1y0szdlS+Y+X7rJaTvYUsC0Mts
         +wfsR4GoC5nkWIV1XfKKxgsW5HFVBNqXFp1ptVgq76r24iNYMMLhFkVAuQlvZsyueYHk
         0fAz+raUbaaCPio5SNo9d0viUOwGZsGVIzVKv45umPTsbe0wckYaXPENtmA5kQmrcxtI
         81UvEo91BqZdsLEo8VGSw+wVQKIJC5Ihx/ntZzTUgPFw6U/Nv1P80BDE02WMzVJhijub
         bCuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739464487; x=1740069287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RX9v7hUQe5JQNCF1yZ/adv1iKbJ1paV1DYSHYQi3q0o=;
        b=qgRxyKQd1jtYNNCImWj2A1p59uDmNJ/gxkZNiljL/2fOky+BMwsRVab2QotiInREJT
         LWftrHHbhwWMk4ogcTYDrWlDZN3KMADnw3C9o2T10RG9Qk8xrA1DVOBvfl5IqLn5ZvGC
         ImVbMb6WuNklGWPIQpO01Ci+nWp7d7Vqx6/ALuXrXc1ADXiQiJ4CTQ/luuzNTCwiDY6D
         mY71g+N2GfThIJyKLGQe98YLNQv9I667YkDcuVIEoWIRLWNjdbItxGk7Nw+16KzIpWRE
         lyjGChFTtZPGEeeM6qa5MXm6S0z87n3/si6ZPFBU1Mp2Cs205ASayqt+oUbs8SXf2ddR
         mwqg==
X-Gm-Message-State: AOJu0YxTzeZczhhLk82r+SPG8WYsUgZIACEm0LN+SX8b3SsJKZa96WN9
	GV5s4OHCce8OcwaL+UI1Z2qxU+9p3H2/LFSAjcubv2HRTWzC1LjiqG6pvochri3egX/kZFqz7ZY
	w2Ef+ULjup5mPVIvQwvQNd+2/ObyxsDPLOwFZvA==
X-Gm-Gg: ASbGncvNZRiOtwHP2ztI1kQpOlfnJhhNHQs7rEdx2nO7HeD2GgbKk4SN8+wRrNdrYQR
	XPNi+cIk7/jHThZJhHjb/FIDtTS7EO6pR4aPxljYOIhSY1uQ2x6ltnpuusfNFNx6DsDVqO+IVvg
	==
X-Google-Smtp-Source: AGHT+IGc9czFT+GG/CpJY8tzyzJT0iZFa2nUUHdO6yrbhuEooRx8CDWt9i0ctE9PmhQK8J5SvYp2SQrF+R1Ix8+jPfw=
X-Received: by 2002:a2e:a805:0:b0:300:3a15:8f22 with SMTP id
 38308e7fff4ca-309037d6f62mr31362721fa.21.1739464486548; Thu, 13 Feb 2025
 08:34:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213-ascs_bug-v3-1-d5594f0f20c6@amlogic.com>
In-Reply-To: <20250213-ascs_bug-v3-1-d5594f0f20c6@amlogic.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 13 Feb 2025 11:34:33 -0500
X-Gm-Features: AWEUYZn59C7R0c5vbT-87IFgE0n3rM0C_yXlZG5rB9w7sUhjJQjqHnq8U0Bhm_M
Message-ID: <CABBYNZKT3g4tMc+TNLvgk09_3yUqj-N5ycXMnottHyWpfStV9Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ bluez v3] bap: fixed issue of muting music silent
 after pause and resume.
To: yang.li@amlogic.com
Cc: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yang,

On Wed, Feb 12, 2025 at 9:58=E2=80=AFPM Yang Li via B4 Relay
<devnull+yang.li.amlogic.com@kernel.org> wrote:
>
> From: Yang Li <yang.li@amlogic.com>
>
> After the ASE state changes (streaming->releasing->idle),
> the Client needs to be notified. The process as follows:
>
> ...(Sink ASE: ID=3D1, State=3DStreaming)
> ATT Write Command Packet (ASE Control Point: Op=3DRelease)
> ATT Notification Packet (Sink ASE: ID=3D1, State=3DReleasing)
> ATT Notification Packet (Sink ASE: ID=3D1, State=3DIdle)
>
> Signed-off-by: Yang Li <yang.li@amlogic.com>
> ---
> Changes in v3:
> - Solve the compilation error reported by test.bot
> - Link to v2: https://patch.msgid.link/20250208-ascs_bug-v2-1-b7e062d6604=
d@amlogic.com
> ---
>  src/shared/bap.c | 31 ++++++++++++++++++++++---------
>  1 file changed, 22 insertions(+), 9 deletions(-)
>
> diff --git a/src/shared/bap.c b/src/shared/bap.c
> index 167501282..079f7ede0 100644
> --- a/src/shared/bap.c
> +++ b/src/shared/bap.c
> @@ -930,6 +930,18 @@ static void ascs_ase_rsp_success(struct iovec *iov, =
uint8_t id)
>                                         BT_ASCS_REASON_NONE);
>  }
>
> +static void stream_notify_ase_state(struct bt_bap_stream *stream)
> +{
> +       struct bt_bap_endpoint *ep =3D stream->ep;
> +       struct bt_ascs_ase_status status;
> +
> +       status.id =3D ep->id;
> +       status.state =3D ep->state;
> +
> +       gatt_db_attribute_notify(ep->attr, (void *)&status, sizeof(status=
),
> +                                       bt_bap_get_att(stream->bap));
> +}
> +
>  static void stream_notify_config(struct bt_bap_stream *stream)
>  {
>         struct bt_bap_endpoint *ep =3D stream->ep;
> @@ -1634,7 +1646,9 @@ static bool stream_notify_state(void *data)
>         struct bt_bap_stream *stream =3D data;
>         struct bt_bap_endpoint *ep =3D stream->ep;
>
> -       DBG(stream->bap, "stream %p", stream);
> +       DBG(stream->bap, "stream %p state %s",
> +                       stream,
> +                       bt_bap_stream_statestr(ep->state));
>
>         if (stream->state_id) {
>                 timeout_remove(stream->state_id);
> @@ -1643,6 +1657,7 @@ static bool stream_notify_state(void *data)
>
>         switch (ep->state) {
>         case BT_ASCS_ASE_STATE_IDLE:
> +               stream_notify_ase_state(stream);
>                 break;
>         case BT_ASCS_ASE_STATE_CONFIG:
>                 stream_notify_config(stream);
> @@ -1655,6 +1670,9 @@ static bool stream_notify_state(void *data)
>         case BT_ASCS_ASE_STATE_DISABLING:
>                 stream_notify_metadata(stream);
>                 break;
> +       case BT_ASCS_ASE_STATE_RELEASING:
> +               stream_notify_ase_state(stream);
> +               break;
>         }
>
>         return false;
> @@ -2068,17 +2086,11 @@ static unsigned int bap_ucast_metadata(struct bt_=
bap_stream *stream,
>
>  static uint8_t stream_release(struct bt_bap_stream *stream, struct iovec=
 *rsp)
>  {
> -       struct bt_bap_pac *pac;
> -
>         DBG(stream->bap, "stream %p", stream);
>
>         ascs_ase_rsp_success(rsp, stream->ep->id);
>
> -       pac =3D stream->lpac;
> -       if (pac->ops && pac->ops->clear)
> -               pac->ops->clear(stream, pac->user_data);

This part I don't really understand, why are you removing the call to
clear? Or are you relying on bap_stream_clear_cfm? That is only called
on detach/disconnect so I don't think we should be removing the code
above since it is still possible to reconfigure after releasing.

> -       stream_set_state(stream, BT_BAP_STREAM_STATE_IDLE);
> +       stream_set_state(stream, BT_BAP_STREAM_STATE_RELEASING);
>
>         return 0;
>  }
> @@ -6172,7 +6184,8 @@ static bool stream_io_disconnected(struct io *io, v=
oid *user_data)
>
>         DBG(stream->bap, "stream %p io disconnected", stream);
>
> -       bt_bap_stream_set_io(stream, -1);
> +       if (stream->ep->state =3D=3D BT_BAP_STREAM_STATE_RELEASING)
> +               stream_set_state(stream, BT_BAP_STREAM_STATE_IDLE);
>
>         return false;
>  }
>
> ---
> base-commit: 2ee08ffd4d469781dc627fa50b4a015d9ad68007
> change-id: 20250208-ascs_bug-e7c5715d3d8c
>
> Best regards,
> --
> Yang Li <yang.li@amlogic.com>
>
>
>


--=20
Luiz Augusto von Dentz
