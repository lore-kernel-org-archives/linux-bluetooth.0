Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F72926B94F
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 May 2025 13:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748350869; cv=none; b=CqQydL+6OXOspu1Fo4aSqQASBBorSGBaYh4kFZsr88XcIc+nSUHw6FN31PmxvY5DbYjx5vJDeQEySl1XN5vn3x5Rn6T+SHPm3VftALnfdQsAgvTOjEWgU+qMp4AI10+ZQY++y7uh6AL2jU946zkr4TL+karK+7IVcX4vq3I03oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748350869; c=relaxed/simple;
	bh=YSA3lrBeRCtMPXTf+o+1ZMgeJVH8dFWO93RM767RG3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZH2Fo6pdJT6XCEQZXAPJG4LhAk8hZeuH+GaJJGI+dM70IWNXfgYTZ24RNzrKpvoIP0sNsmfQSwl9tPf8OGyzYfdkPQt+XytzAhiRIUPMiT4u043xLU8vhAuVPTiUalNR66bmzMDtxzA7s6PrLN+lAHZS7KA1eRu7CIpjMyBzyMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vf1IeQuw; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vf1IeQuw"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-310447fe59aso35656841fa.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 May 2025 06:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748350864; x=1748955664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6qSGdUsU8DnHUcblDU2uWTFnvGIDMXFFFlgA+QVGQgs=;
        b=Vf1IeQuwCXfKCMYFsVzHfdRKjQmbGQbqNVD1cOiul1WxGQORtXzh/hVil3ZQtRDCRi
         AKyKGjjYtLnOlb0/OGMPiKLtACqCHUwfhQrsFr/K7BFRF/EriVcMNDjRZaJ2k1R+Ujbk
         8gjbZU2avPDJu1/bbQrw1ELGPe5fJyT+4enmufIV6oMmFKQMBCmNlxTyfyHURXPud3iQ
         v9lsBhmzOPoG2oY+VxyLuIXc+AxF/0qTP9FSq4VgSpWK+jYUx/xUgTFNs19I0uw1iVwn
         zrbKd0mBiwc8Xto1AZxhBGBatcuRQKkL2NkGT8fQ7k5v1D69A3TmDzfddk0uwd1d+42V
         Rukw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748350864; x=1748955664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6qSGdUsU8DnHUcblDU2uWTFnvGIDMXFFFlgA+QVGQgs=;
        b=XrIm7n3TAJgoztYFEmWQJWr5GKN2T6zZkPOGd5jfgkBpCNhhzklDYnUNuckAV76YUG
         kfOHXKvlBtS2/cNQ48vNwmvxIHLEbzpd34oUcCRDXFfpyxLnf8AarfE0S2De+zjIvD+m
         kk1ZyPQNePnAIpqJ0jtua0U29oAGjnUJ5Q1uagWNjRT+akdDWzn4Fwpio5OCIEN8M30D
         RPTfr5KYX8G4BZOi+GJtvh7VXY3EctJYKC9XbbYYoHc66Zmy35oiNIDf2xnwlSb11xil
         FhOTHQDyuTO9uFMMrnmtc82S2uDAjU/n1T2VxWbShN40bEOq0TQDUY5YcPZiNA+5LPxa
         e2aA==
X-Gm-Message-State: AOJu0YyJdSePCNYLOikdCr3Sl9UENRZqBS3sudM9hVZqN1bJLcb8cnLn
	Z+HIovAFK+Xmp/hNSmo0/yAJGH9O6Xxc3JqZD7EYCacu9X/GDBhNjp8OLoNiGVRZ/2m+tlSSEHk
	RmFuIK59zTSzDPi0S9It+Huecsuhi9Lj5GYSW7FE=
X-Gm-Gg: ASbGnctoA/KLBDtozMcOg+tAY68w78AwiVNkmrgwalVmLVW6VsXKJ8GS5ABfeC+ugcx
	TliK/kQQnXNfJR9vcEt0AtfryGdjNXdVNXt+b9JzfGofsdMV+FQCXfvfvgQ4IAMeb+xrO8Ihnnz
	u/RPd44zBVo3tMdkuayzQmWowlclmDdoI=
X-Google-Smtp-Source: AGHT+IE9qA84QSSMZ/Pg4vR4mYvL6nGQINbY3xcZFj8mBoWHRUA3J7bidRJESZAjSysuQs7gWdXucL+xunmzMrs/Xag=
X-Received: by 2002:a05:651c:19a1:b0:30b:c96a:750 with SMTP id
 38308e7fff4ca-3295b9aaa34mr40416351fa.1.1748350863796; Tue, 27 May 2025
 06:01:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250526194328.15875-1-repk@triplefau.lt>
In-Reply-To: <20250526194328.15875-1-repk@triplefau.lt>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 27 May 2025 09:00:51 -0400
X-Gm-Features: AX0GCFv8fjL0V1-V1nOfTqMbbbJCaQQmk7CMA6YzvaYTgF28trWGx3Cf3slu9Qs
Message-ID: <CABBYNZLzaOJAQROkLCMWv1_OF6JOFcDN2+Aa=f_Rt9ZS7GJCQg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] policy: Fix reset Control/Target/HS retry counters
To: Remi Pommarel <repk@triplefau.lt>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Remi,

On Mon, May 26, 2025 at 3:52=E2=80=AFPM Remi Pommarel <repk@triplefau.lt> w=
rote:
>
> Control and Target retries counter were reset when service state
> goes from CONNECTED to DISCONNECTED, but usually an extra DISCONNECTING
> state is reach before going to DISCONNECTED. This causes retry counter
> to not being reset in this case, leading to service not being able to
> initialize on next connection. HS retry counter was only reset when
> limit is reached.
>
> Reset the counter as soon as CONNECTED state is reached to avoid that.

Looks correct, but shouldn't we update for other services as well? Not
just HS and CT and TG.

> ---
>  plugins/policy.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/plugins/policy.c b/plugins/policy.c
> index 0e533ba1f..02ce16f67 100644
> --- a/plugins/policy.c
> +++ b/plugins/policy.c
> @@ -383,6 +383,7 @@ static void hs_cb(struct btd_service *service, btd_se=
rvice_state_t old_state,
>                 else if (btd_service_get_state(sink) !=3D
>                                                 BTD_SERVICE_STATE_CONNECT=
ED)
>                         policy_set_sink_timer(data);
> +               data->hs_retries =3D 0;
>                 break;
>         case BTD_SERVICE_STATE_DISCONNECTING:
>                 break;
> @@ -537,8 +538,6 @@ static void controller_cb(struct btd_service *service=
,
>                                 timeout_remove(data->ct_timer);
>                                 data->ct_timer =3D 0;
>                         }
> -               } else if (old_state =3D=3D BTD_SERVICE_STATE_CONNECTED) =
{
> -                       data->ct_retries =3D 0;
>                 }
>                 break;
>         case BTD_SERVICE_STATE_CONNECTING:
> @@ -548,6 +547,7 @@ static void controller_cb(struct btd_service *service=
,
>                         timeout_remove(data->ct_timer);
>                         data->ct_timer =3D 0;
>                 }
> +               data->ct_retries =3D 0;
>                 break;
>         case BTD_SERVICE_STATE_DISCONNECTING:
>                 break;
> @@ -587,8 +587,6 @@ static void target_cb(struct btd_service *service,
>                                 timeout_remove(data->tg_timer);
>                                 data->tg_timer =3D 0;
>                         }
> -               } else if (old_state =3D=3D BTD_SERVICE_STATE_CONNECTED) =
{
> -                       data->tg_retries =3D 0;
>                 }
>                 break;
>         case BTD_SERVICE_STATE_CONNECTING:
> @@ -598,6 +596,7 @@ static void target_cb(struct btd_service *service,
>                         timeout_remove(data->tg_timer);
>                         data->tg_timer =3D 0;
>                 }
> +               data->tg_retries =3D 0;
>                 break;
>         case BTD_SERVICE_STATE_DISCONNECTING:
>                 break;
> --
> 2.40.0
>
>


--=20
Luiz Augusto von Dentz
