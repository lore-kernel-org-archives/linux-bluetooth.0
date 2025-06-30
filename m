Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287C128BA85
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jun 2025 14:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751292064; cv=none; b=nPfJmGmeFCZyOM7F5YWflCD+t91EeDkG2fABHyz0D3Mvq2etlSRtWatumdFtlqGERubA8aN8Xj8Ke8fgjivWz2JDPbsbcuaFUOUdA4Sbsz9rVJ4kad6LZPNoStpWb8tztd6ug2+ERfoOyO0V2pijsaQ5O6vROSkq7D7dxBnQ6GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751292064; c=relaxed/simple;
	bh=2iK4W3/0O+8Uxt6jl2AaFUVxRUVLNJNq+MJ4hRomOu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JxhXBCcfXxKLlCgJKF4Ch7hPJZguHCNx5Y+hiFC3+Eu7vap+dtc9iZRqVsuIOrmGkCoHxlmOf+Klnu8ioc0vNvxewqW461eiLjTf5RH+6DrfJrJKBclXWWmMbjVNJIrK6zK5ecQ+OwFP6wtdk4U/PKsHW54Ccc5e4lxYDoXQGtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cdkzi1a/; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cdkzi1a/"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-32ac42bb4e4so18573221fa.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jun 2025 07:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751292060; x=1751896860; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+fZtxhx9q0w7+VVpVUCd/CgpQL1mWZ8AWif++geqHf4=;
        b=cdkzi1a/bkLhPypDZNlMQz2eupoJ1NKOYUI76ZKsw72BVK4eDCkWXqBEkSsu1F31H2
         yXD2cKs79fCDYGGGBff3b2J4Ej3AH1Vem4vQUR/uhPm2zGOa0mUnK5PEYGOmDL/HJMMs
         hiqsniezSWl22zZD5dSsJuc7+E9KyeC+qiFQV68rubuAo+z5vt1fLBkJ/uxKwV26QdcH
         YWRFDslgXZr/XuKbUCRXuuailK9Kcj79XpuEF0SkSV9ADSQ8aEHEBmrvfec/9JZV7z7i
         MK6RARsYrtUgb2vguxFiqYXXDcDLaQCE3MIE9P8Ynq5pAG8rOhKJhAneZ3uaVRKcyJdi
         YVtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751292060; x=1751896860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+fZtxhx9q0w7+VVpVUCd/CgpQL1mWZ8AWif++geqHf4=;
        b=CG8UrR861pOj/7FAYHONu5F/NvmF9mZ5SNwXbwo0ELbqiKcrKAwc6nmr1mnepSG9KR
         9YCzZfLYa32bdwrsgWUCRc/1DyYk4d/M/slsa0dntdQntGYfMTYCUuEB8aEtkMrLl5zl
         1M5meGG4+J+RyGRV9fSI49ofM2Aj5nk7aru2ZTWaHB3fVI2VCjlxmQpSSXLgHAr5qUCS
         J75ym1xlfmwgOzCpP5kzgTmbIPNSjbIpOw+MVYM4G6PZwfsfdazjJ+/itzVk7Ywz8s//
         vFqZClZojBvJPWADku4j3g6QpJdxrvt2hV0glW+2yQtyaHGkcLTRI1B7HICzR0JQXirS
         I+MQ==
X-Gm-Message-State: AOJu0YyPr+WZiiQNt974tkj68FvF64CeMLdvACanuovL9e0x5HyOuxbd
	z6oe22gGQdXUyRJiCvODE3dltA0LRsaIgMXAgvUoTvpR914+FOMmNdTLV0NzlpTTZg8C5sy7xOf
	Qnc3kVqL5q0iiaulieOfPSHRbYqZBXLY5WPTyY4Bzug==
X-Gm-Gg: ASbGncvjZXdW/xZdLsQcmOO5UdZVXZW7ELz3Xp5/d7tweNm49dmJsYvRjmrVdbS7O6D
	+30GgnOp6UpAzwyNc9pRn0muzLK3S4XeTjy2h+JPbBSuiRpnun98bSBpGK1n+iyJJT+YuuVDk2m
	9jyWA7JaW58+Fl/VsRbbdBO9QfW9G+hwOmMkJ3p2eeFg==
X-Google-Smtp-Source: AGHT+IF5y8MwrjkejxrzaNk++4eN7sHgntuh957UQJpk/EHiPXdcF2CLZdJc5BxTPWWDFhpDqFZnuASCiar/IHzNxrY=
X-Received: by 2002:a05:651c:4201:b0:32b:8778:6f0f with SMTP id
 38308e7fff4ca-32cdc4fa8cemr29200551fa.34.1751292058747; Mon, 30 Jun 2025
 07:00:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250630-bap_for_big_sync_lost-v2-0-1491b608cda5@amlogic.com> <20250630-bap_for_big_sync_lost-v2-2-1491b608cda5@amlogic.com>
In-Reply-To: <20250630-bap_for_big_sync_lost-v2-2-1491b608cda5@amlogic.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 30 Jun 2025 10:00:46 -0400
X-Gm-Features: Ac12FXzLZfZVzHtEzc6TTfGJ2BKOPMBa_Vjv4PsaIuB2GkLnUFOvUP9CTNFF4SU
Message-ID: <CABBYNZLA3KqrTHXkHnDM=63E1t7Y=CEbJ2hBeJEXQkFOd3wMeQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ bluez v2 2/2] shared/bap: Add stream state check in stream_disable
To: yang.li@amlogic.com
Cc: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 30, 2025 at 4:04=E2=80=AFAM Yang Li via B4 Relay
<devnull+yang.li.amlogic.com@kernel.org> wrote:
>
> From: Yang Li <yang.li@amlogic.com>
>
> Add a state check so that stream_disable() is a no-op when the stream
> is not in ENABLING or STREAMING state. This prevents unexpected state
> transitions or redundant operations during cleanup.
>
> Signed-off-by: Yang Li <yang.li@amlogic.com>
> ---
>  src/shared/bap.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/src/shared/bap.c b/src/shared/bap.c
> index 984ae782d..5445ddd14 100644
> --- a/src/shared/bap.c
> +++ b/src/shared/bap.c
> @@ -2134,10 +2134,14 @@ static uint8_t stream_disable(struct bt_bap_strea=
m *stream, struct iovec *rsp)
>         /* Sink can autonomously transit to QOS while source needs to go =
to
>          * Disabling until BT_ASCS_STOP is received.
>          */
> -       if (stream->ep->dir =3D=3D BT_BAP_SINK)
> +       if (stream->ep->dir =3D=3D BT_BAP_SINK &&
> +          (stream->ep->state =3D=3D BT_ASCS_ASE_STATE_ENABLING ||
> +           stream->ep->state =3D=3D BT_ASCS_ASE_STATE_STREAMING))
>                 stream_set_state(stream, BT_BAP_STREAM_STATE_QOS);
>
> -       if (stream->ep->dir =3D=3D BT_BAP_SOURCE)
> +       if (stream->ep->dir =3D=3D BT_BAP_SOURCE &&
> +          (stream->ep->state =3D=3D BT_ASCS_ASE_STATE_ENABLING ||
> +           stream->ep->state =3D=3D BT_ASCS_ASE_STATE_STREAMING))
>                 stream_set_state(stream, BT_BAP_STREAM_STATE_DISABLING);
>
>         return 0;

Well we are doing:

    if (!stream || stream->ep->state =3D=3D BT_BAP_STREAM_STATE_QOS ||
            stream->ep->state =3D=3D BT_BAP_STREAM_STATE_IDLE)
        return 0;

And on ep_disable we have:

    switch (ep->state) {
    /* Valid only if ASE_State field =3D 0x03 (Enabling) */
    case BT_ASCS_ASE_STATE_ENABLING:
     /* or 0x04 (Streaming) */
    case BT_ASCS_ASE_STATE_STREAMING:
        break;
    default:
        DBG(stream->bap, "Invalid state %s",
                bt_bap_stream_statestr(ep->state));
        ascs_ase_rsp_add(rsp, ep->id,
                BT_ASCS_RSP_INVALID_ASE_STATE,
                BT_ASCS_REASON_NONE);
        return 0;
    }

Perhaps on bap_ucast_disable we shall actually call ep_disale rather
than stream disable directly, that said I wonder why stream_disable
change is suggested here since you were attempting to fix broadcast
and for the likes of bt_bap_stream_disable it shall result in
bap_bcast_disable which doesn't call stream_disable:

static unsigned int bap_bcast_disable(struct bt_bap_stream *stream,
                    bool disable_links,
                    bt_bap_stream_func_t func,
                    void *user_data)
{
    bap_stream_io_detach(stream);
    stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);

    return 1;
}

> --
> 2.42.0
>
>
>


--=20
Luiz Augusto von Dentz
