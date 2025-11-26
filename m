Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C3D33B97E
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Nov 2025 15:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764172140; cv=none; b=l1uG2NvTytvx1PFXQ8P8neGeqCg9LL6OmmiHn/HTBW8bx0WgCPv4wWdzM5M+nTtm9Y94aiN3PCFqDUcj1xqtmVC0lF++d8xq3RIc/zr68ie9iLLWZa+i8+uHZf2o60GoNPt640bhs7B+qLMgF1RDeSr/6UDm9br06c5n4jm+gTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764172140; c=relaxed/simple;
	bh=6YASY02fQ23f1RDqygF5S199ObV7kVOcbwcCGJNj4Gg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j/NDAT4hOsZWhjiUiOFqsk45rDmzGtjtQQ5PrpB2PcYiqyYgbtjYoDtY9B+HsMUVGT8zTcYKov9CMBOBGrYXBL+etC7zfHFEVw0EzAr8MXjvph5U2DDZcK3f+cWwul2Zxyj7S0Xz43Uh5LNLZyLVHFYnn3aBX0CtWTPZUmW4eUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YhmSRNS5; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YhmSRNS5"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-37d056f5703so22880771fa.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Nov 2025 07:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764172137; x=1764776937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HoRwtJhb9wcPZrMi0TT2OcMTg162LjhvYh/7nz96y18=;
        b=YhmSRNS5FzGwu9X0WUpylj3pHq9BByBLeZetmI/BM8khel0Of/yfG8aDnTdrCFjyV4
         uuo0LzygUbRRsyOQYrdUetCtt30rP6NFfGc7tzsBSXxP+ZprashwiDXsi/DxuOU3V4Xh
         4gUmnUalXDGU9HkZZanwkJ/CT0RpuUog2x/Zv84I1iTMzRdV8a1k9d3nfRcgQ/2eC2TM
         g3Hh+lbQouXFSg6JoDojPTIoehI57Yaii0XCXYUTCQ/T+5Y9AUpy8BoTjX09BW5MnMpN
         KuyQY35EER05OIC26RLv+G6jNLf4LoS5T6IlBPucpsP5Oi7PIRJ3V7DXNwpLjKiz2vxP
         bMLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764172137; x=1764776937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HoRwtJhb9wcPZrMi0TT2OcMTg162LjhvYh/7nz96y18=;
        b=BLWtTXSNryOGzgxtVzjvY2X7SyMUNqb4rpzJg/iF+kdlO6kSjYEA97fKpVv++FM5ln
         SmCPt6vDncK07KO6d55LQg9TcM4IwBSaN2RYPv15ZwBCmo06G5f5z5alEcVt9vXHe918
         QKsG3UeaKj5XornrwmkWEMHdNHxFdXLc8JcmIfWrIyNAzSm8NZ2k1pcq+XlFdXGiqk8W
         jolf4qVsvr+4wI7E5OvZSSlRD0X9AVDpsd0n2987H82dZpDCetZ4pE6Th7iaXvg3KlrW
         Yg/NZwQ7pCxD1xAm+DXeeA45bs7qi2gm734cMHxSje1e3X6OqTn0AARufEgyC3euPyZY
         PIQw==
X-Gm-Message-State: AOJu0YzLqyuuCpt0wP7IVbnlsiXnIbaIiGJHHXorgQmr/DdBczFzDf9P
	lhgFgobjH2et1KXwep3ru+h04DkhhNyZWHjnDd38NUUunZr6zKXogxJA2COLhfw3rxVqNhi0+zP
	qt4fut+m6XQrPszMtXys1XNDkdQoUFzRfgWB6
X-Gm-Gg: ASbGncsMu7sV/cqX5d1hfRq0EFvT+VF75thzOLHiXPMJNAzZ8US/LE7/C9g4xlOQ2jF
	ozR2bH9HtlkYrp4JOBMkcoA1pVw3O1appdKxldzZASGWTpOYnQXu53OQz6lfqU8LnYi3K8FPsov
	pEN3c5jpPWaLkJWsYE/11RZXP+IgylITyDMZVYJALfldNPN3z+yzSxGqCwDDTulyRpwxPT8QdDa
	uyGinzknoD3jrwu2MJrHJc6feZoSw/zNxlzxLM4WGfkKqVRt13+bp4UDBZmwgmwfK/Rlg==
X-Google-Smtp-Source: AGHT+IF4DdppOdxGdhhsclhdCwqvZjSNXeKTwy6U7+naspffXEtbIRlXROFOhDVQj4PsyMTZtJUIIkt/Nzbwc8Wnk+8=
X-Received: by 2002:a05:651c:f14:b0:372:9bf0:aec9 with SMTP id
 38308e7fff4ca-37cd9186ce7mr58248171fa.8.1764172136298; Wed, 26 Nov 2025
 07:48:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <68b8ba8dd63306081aa7630e3b1f8a186e558b6c.1764090857.git.pav@iki.fi>
In-Reply-To: <68b8ba8dd63306081aa7630e3b1f8a186e558b6c.1764090857.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 26 Nov 2025 10:48:42 -0500
X-Gm-Features: AWmQ_blUfxp7bXVNvhFX0slWvnEpj6ySKgSxdOtiatkztu-eTHdiXu_Q6rbCkpU
Message-ID: <CABBYNZ+7CCN2r6GjUEi1jh7Sn00OnVkY4+sho=2eUosgtMdTTw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] transport: fix VCP volume updating and sink volumes
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Tue, Nov 25, 2025 at 12:16=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Signaling VCP volume value update was broken in
> media_transport_update_device_volume() due to inverted strcasecmp(), it
> also has to be done for all transports since they show the volume.
>
> VCP output volume was incorrectly shown on input transports.  Don't
> expose Volume for BAP input transports, since AICS is only partly
> implemented.
> ---
>  profiles/audio/transport.c | 36 +++++++++++++++++++++++++++---------
>  1 file changed, 27 insertions(+), 9 deletions(-)
>
> diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
> index fc23cf33d..d466ec9b6 100644
> --- a/profiles/audio/transport.c
> +++ b/profiles/audio/transport.c
> @@ -2308,16 +2308,32 @@ static void bap_connecting(struct bt_bap_stream *=
stream, bool state, int fd,
>  static int transport_bap_get_volume(struct media_transport *transport)
>  {
>  #ifdef HAVE_VCP
> -       return bt_audio_vcp_get_volume(transport->device);
> -#else
> -       return -ENODEV;
> +       const char *uuid =3D media_endpoint_get_uuid(transport->endpoint)=
;
> +
> +       /* TODO: PAC_SINK_UUID needs AICS */
> +       /* TODO: VOCS */
> +
> +       if (strcasecmp(uuid, PAC_SOURCE_UUID) =3D=3D 0 ||
> +                               strcasecmp(uuid, BAA_SERVICE_UUID) =3D=3D=
 0)
> +               return bt_audio_vcp_get_volume(transport->device);
>  #endif /* HAVE_VCP */
> +
> +       return -ENODEV;
>  }
>
>  static int transport_bap_set_volume(struct media_transport *transport,
>                                                                 int volum=
e)
>  {
>  #ifdef HAVE_VCP
> +       const char *uuid =3D media_endpoint_get_uuid(transport->endpoint)=
;
> +
> +       /* TODO: PAC_SINK_UUID needs AICS */
> +       /* TODO: VOCS */
> +
> +       if (strcasecmp(uuid, PAC_SOURCE_UUID) &&
> +                               strcasecmp(uuid, BAA_SERVICE_UUID))
> +               return -ENODEV;
> +
>         if (volume < 0 || volume > 255)
>                 return -EINVAL;
>
> @@ -2802,7 +2818,6 @@ void media_transport_update_device_volume(struct bt=
d_device *dev,
>         if (dev =3D=3D NULL || volume < 0)
>                 return;
>
> -#ifdef HAVE_A2DP
>         /* Attempt to locate the transport to set its volume */
>         for (l =3D transports; l; l =3D l->next) {
>                 struct media_transport *transport =3D l->data;
> @@ -2811,16 +2826,19 @@ void media_transport_update_device_volume(struct =
btd_device *dev,
>                         continue;
>
>                 /* Volume is A2DP and BAP only */
> -               if (media_endpoint_get_sep(transport->endpoint) ||
> -                               strcasecmp(uuid, PAC_SINK_UUID) ||
> -                               strcasecmp(uuid, PAC_SOURCE_UUID) ||
> -                               strcasecmp(uuid, BAA_SERVICE_UUID)) {
> +#ifdef HAVE_A2DP
> +               if (media_endpoint_get_sep(transport->endpoint)) {
>                         media_transport_update_volume(transport, volume);
>                         break;
>                 }
> -       }
>  #endif
>
> +               /* This is sink volume */
> +               if (strcasecmp(uuid, PAC_SOURCE_UUID) =3D=3D 0 ||
> +                               strcasecmp(uuid, BAA_SERVICE_UUID) =3D=3D=
 0)
> +                       media_transport_update_volume(transport, volume);
> +       }

Current code sounds quite messy with respect to callbacks, we should
really only add the callback if the feature is supported per UUID,
perhaps we have to rethink how media.c interfaces with profiles to
avoid having to do #ifdef everywhere.

>         btd_device_set_volume(dev, volume);
>  }
>
> --
> 2.51.1
>
>


--=20
Luiz Augusto von Dentz
