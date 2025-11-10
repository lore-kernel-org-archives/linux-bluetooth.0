Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9678818C26
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Nov 2025 18:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762799824; cv=none; b=Alt55Iz6U9UhAnCrkFIvRTC4lfPDrIpKIvDTpQTEk3I+G7odxRVl+y/Cr/Qb98Yk4nu6+abFZaVRfq6zaN1gTUZsMajea27TCcfaqSsNCGHjXXhJNeUeQD9HV0ZI+5k9zNfra+xrdxDZFlxeNbuA0EqP6EYoP402WjFc0e6FFZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762799824; c=relaxed/simple;
	bh=59YHbw/s+mzUNpMpwR2PCQVE5sGvzqUdGaI8+ZlObsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aFJjEbumICUHiIl/ol0Pl8RoJlsXWCrNAYW3UIbC5FZ96IixA02JcCy4GjQIaLJHJ++TVe/kVIA8KHmXIXH99Jv6B6/rK8Sec8cV+zzMMFVuceDmXohbW86IhrBa96hMAtEeMbPf3+A1UlBVgArUtjPW/uXhwVZIvow1YK+phX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HxGby3+q; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HxGby3+q"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-36bf096b092so26998891fa.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Nov 2025 10:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762799821; x=1763404621; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZW7WOAyHEjvksnGLdqJtCgvuiFqQcZ2gCBobXnaWxY=;
        b=HxGby3+qx12nbxGnNtAxfgfDd4qhKWN5SEW6U6uUgbDKHqjcJRubpv/yFmr05ukc9U
         FJEqtkuI2qV0NAECuH4tbgGbAWZVOeCtGBjhfwMEzVyh0INRbBLASFfp9QfMxBa70jfG
         Duu8TqWlxfFhej6qGVxaTOYc9QLm87E0Us/sDm2qtBa1lvjr6OLIisxomhW6BhthN/4t
         eTF2BETiQea2Ffhc+X7YAwBo1OU6h6QRVmc5U5RHYoCl8e3ehTw1TikvJjw2cB09oq0F
         P/y6JQSh6stPE3EyC65Zd53/m+9qc8N9dXh0Srh7W3Sq5QGj6rxii0OGu4dKLYod0caj
         Y4Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762799821; x=1763404621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IZW7WOAyHEjvksnGLdqJtCgvuiFqQcZ2gCBobXnaWxY=;
        b=QmsAUmx+/JlEyufP5grc/56DETNo/tPXXNUMwIiVtYBW3IpRCNadSheJvBQpaHH0Ko
         LzlRO+HnSCF6V4/wj5axpwecEFO5hO7pHlAMvqE0fD5RR/Oxt5rbLt+CMjQhO95gfUz9
         +xxYDdyOwaQoHT9TpzxYrI/xNEiQQJdYOiXjDvIgRbTDiHs2rha/sFp/NH0qmLyM298t
         8+NaBmhw37HGBjH9FeZXu+AWRaIcnmhLDx3cBRzAiZVAlX77mA8UJPIB1CiuunT2qD3D
         CpXbmnr1IlmaGhEtz2vbtsQApOdW0CkxsKaIAQ3oAyHWZ7OliVoS/nMR9vwVNDftaHwO
         jzEA==
X-Gm-Message-State: AOJu0YxnZDWuTnRfoD04THQnw4CX1FOVUTVimITB634N4mRQM4YM50z5
	WZsUkO5AiozxOhW/YUQqsl/8ZCFTmCqJ2/15OtwBEYInQ8F+j70eaburSC+Gf1QvHAJn/V2Uxot
	w3gEzqFQJLjSYsLfvCszz0i5TnHV7iiFjXMadvj0=
X-Gm-Gg: ASbGncuTnQUzMUbWuDlpuI8CQii4utXU+LNLPZo/YMF48M+p3amXDWE6VzfgFFFj+hF
	Rcced5LtVOKjVrf8pqzhWKT97die7rj8gbrrQ2+XjgEVo1+64/wWmEvJQPHjjw0it5R95y5LFrL
	WMVS/T4R8/iHIvbeYqVdNHYBs1I7UxBJ1viq4vI/9QG9P0NcautQ5hPuWWEjaLXAQy7vc+fHsrJ
	7LBh1ER1yk77eaSAvi/KoHGZwF8Ve/8pCwqMWkP114xYGc33HufmzYdcViOGyqA+U3/LA==
X-Google-Smtp-Source: AGHT+IG1XYqTa+mSvCMFJbWlY1pfmQOifeoY7ey0T4pDlhdd5tl+1NytnEDQgYWBzunhiENn+dQsKIxlT6Oiw2PwtlA=
X-Received: by 2002:a2e:9a8d:0:b0:37a:2d7c:3ce3 with SMTP id
 38308e7fff4ca-37a7b1d7ad7mr19971581fa.14.1762799820435; Mon, 10 Nov 2025
 10:37:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107090016.89520-1-pvbozhko@salutedevices.com>
In-Reply-To: <20251107090016.89520-1-pvbozhko@salutedevices.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 10 Nov 2025 13:36:46 -0500
X-Gm-Features: AWmQ_bn-th1DLEpzj6ubM448Bf1JhZ5CJ2kAfAnUnVFbKjwT_XZFVTXJN1v3Up8
Message-ID: <CABBYNZLbMzyrhgS2tmguH6xhPrZE4mgx0Qt1gN+fm1TyBPRxdw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] avrcp: fix AVRCP_STATUS_INVALID_PARAM
To: Pavel Bozhko <pvbozhko@salutedevices.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

On Fri, Nov 7, 2025 at 4:07=E2=80=AFAM Pavel Bozhko <pvbozhko@salutedevices=
.com> wrote:
>
> The first AVRCP_EVENT_VOLUME_CHANGED event triggers
> an AVRCP_STATUS_INVALID_PARAM response.
>
> When pairing, the org.bluez.MediaTransport1 instance
> may not have time to be created, but the org.bluez.Device1
> instance has already been created.
> avrcp_handle_register_notification receives an
> AVRCP_EVENT_VOLUME_CHANGED event and
> media_transport_get_device_volume will return a Volume
> of -1 from the org.bluez.Device1 object, resulting in
> an AVRCP_STATUS_INVALID_PARAM being sent to the audio source.
> After receiving the first AVRCP_STATUS_INVALID_PARAM,
> the Audio-Source will consider volume changes
> from the Audio-Sink unsupported.
> Relevant for all iPhone models as Audio Source.
> ---
>  src/device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/src/device.c b/src/device.c
> index 91b6cc0c6..352323167 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -4818,7 +4818,7 @@ static struct btd_device *device_new(struct btd_ada=
pter *adapter,
>                 return NULL;
>
>         device->tx_power =3D 127;
> -       device->volume =3D -1;
> +       device->volume =3D 0;

But this will indicate volume is always supported, and worse set to 0,
what we should probably do is initialize it to 0, so we might need a
better way to detect that volume is supported and then perhaps set it
to 0 until the transport is setup.

>         device->wake_id =3D -1U;
>
>         device->db =3D gatt_db_new();
> --
> 2.43.0
>
>


--=20
Luiz Augusto von Dentz
