Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB0C23AB87
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jun 2026 13:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781789616; cv=pass; b=mffG+jfGmpyhPlcnUHKkVpw8oKdwiTfQ8jukvcPo0I1rPNPCo/TMOYmjqqQElm82+HqYco9sujp+8csDP9e/gWzDE+yGzGw3i9Jh6gpGPS132eN61idW2xEj3frOqqqLwlCneHKWluKrJ0U8uVExKofatsEYeP32aFuckYYC0XA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781789616; c=relaxed/simple;
	bh=qGDCQEupqYXDZ+v0zdmPfbGPEy11+6a//dVVlfL6+bY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dSl7wHNdxRAEP92RqesnqB1NuRzYWmhNMLFy8I/y1mn9Ce5hdmMRIPdIp1+eI4rEFQNg8Kq0eaQMSpD7ROhsnVX8HCmUcnCLd08Jh3l2MRjN6yh7Q8Rg4fvClcuXjQbHc6dxAhf7gjbFP3ubfLIVJovnjblugYxWSe8R/gGwlCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L0mxD8ke; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0mxD8ke"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-662b95934dcso917845d50.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jun 2026 06:33:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781789614; cv=none;
        d=google.com; s=arc-20240605;
        b=caZfBWgIvqjJMtwY0jYjhg13ijp1z1NO8VCLvee5XMgx7Nxb6neG9mPvXXy2H5BkY4
         k6YL48SOjtlQCCSRw5oZB6e0v/WUWrPl559Qc7KDwXi5ug3BfxD8/SNNbX8RoNSzSocQ
         /7mOR5d3BJOgaFLoqSpo8mFFkGXqENZ2W4kX/jJz1MolhxhDuE04Vdf2+8fWgOLIdthv
         Uv8zM2IAKFDfR7w6lX8kTj6E+3o6tW8cMctr8kRMRo8kBzXsb9jiDIIMyotvM+hw0Ezr
         h6+0CunfwfsmvvCzdQFfnSeHWpo1xBvSzRHyxYngdtA4TE6KtDXDbRpOeT8jTg1IikAT
         vs6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wbibQW9dGpVQFDq3KZaDalBVlNF/dLaGt4CzNm5esQQ=;
        fh=G1A8mwHv4E29tTejBXpHC7iOHDh4EgxdwfeWYF0fOi8=;
        b=jgm6AxbC6are9AClpXYC8hXN85ZXZ5IbBBBH0GE82uscmhnPjT3Z56ILB+RGU4mOCE
         WJOa9GZJrrWpdnrjDOYJtDfues+pjDxv/V5PjwGr1V9U1nUKxMmPZpCJZtW9b4HTspfz
         ZlLLsKH6jZ3xaaZUaIXAtNrgg+td/ea32yOpiIbKPO9m7huQe5tRWPApc6oHglbkD8CN
         oYuZiUvfu1ZO9T1weiX9EdVRMgWX3WW9jhAzGrgM4s74Ua4/UCs/4GAoPUIK2CNVdYhk
         V8H516qp2tusOKvED6cBfqsEfkUtYHg3kERvuqzuGLpJH5Q8Wiu8PfC2UmT8hTTQgqar
         1neQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781789614; x=1782394414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wbibQW9dGpVQFDq3KZaDalBVlNF/dLaGt4CzNm5esQQ=;
        b=L0mxD8keBcqdKKM9AxTjuGfTVfe5tjI+gcBJBsEFsB4Bpc1ILqmu61IAjXi7NR9zDn
         0PfoHHTfJlnh95PPebHLFCkbii7NW9tsQFaX+EL+ZDLzuVjFi3U8x4OX99eSzPACiJw+
         FI+Td0iyLqrs8pdIb5tVgeeo+U6TezZe/bzaUecGLpyTZAedm4rndvh8CJbWJhyWxGc4
         ooC7jUbfS/5X45Jtr4m3dR0R+BDq8iEaTTdvP/6Mq+VuF1QOyQCfEwXDJcG1iitHY4hD
         m1d79MY4P4RotVY2cgHbNpbVZexjId21fAA5ZJN1Y+sDekNPzLKMS1mx3zluqP0y2oz2
         sPAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781789614; x=1782394414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wbibQW9dGpVQFDq3KZaDalBVlNF/dLaGt4CzNm5esQQ=;
        b=axPXxUvAMk1r+Xlgc+IJgHhZTWL8zu8+jlx7gw6fcg+mCWPEwv83JpJlB7Cc1h4Wah
         PIVVl2kgkcjn/+D7/6v/bCFIdAPVP649Nd+OtZqY8TtLZSk8WLypqO9o1VuFP/5sMtzM
         IuZUyRrQvd9j6gZrmUx5l6jEXsWe2Xgb/xpIy7ujfCtbKUUXT4iGrj85AoUdFqGjY+Ad
         qlAsJyKB9j5tobOxqFtssuoCa1nNCjvkuW4WuiW0CLDGANcioAYsdfWNS1pwzMlZTTlp
         Nlpfwk0BpRnW94IL4CxJT5VSeYHCtUIOVk3OEZm4giZGpGcHGTp9jC+2ypifYaD5AMhi
         T/ZA==
X-Gm-Message-State: AOJu0YwisxukKdwzmo3afPSKv0elZ9cFB/zg9wnxfgJdBa3g/H0hM/T0
	EbUOO/Od+RZtZfwEQVPqm7+gxLZoe4dUFI8dqXSLXtc8NCdotf9M+6VCDgMuAhqNC4Yrq1bl4M+
	GXScCaf+iDsySJT6MbClmOSvy98VcbkL4fRan
X-Gm-Gg: AfdE7cmbCyz/MZLO58CB01how8hQSOR2V2uCCS0INgbHCDbmYiphC5mgevd+05UY0/s
	/dBTlLjhzsZAP6Qf/n1cfIkw4HzlWC8rRy6ZdBdc/9+Ya+55K/O/iBTKmKkv5pw76BgKLV3m97y
	HKCWUlBeKA5LAkunBEWjWVLH4eSJjT/JZmVM2J+uR58+f/hD3p8g5yu/QdFrNBB9I8kLPORu1BH
	PKWEuPEoHMBx8Mysqg4Y69NCRGPIP5Lf1EexBDy569Ol/hXh1lZ6lA4mHPFWxdmE1FuP6jvigE+
	Z7Y3kSgregq6YpSRnV7te97DyTu8Cetotw9Gdhu/uElXmZN+IcjwQeXhkMw=
X-Received: by 2002:a53:ac8f:0:b0:662:efcd:e7dd with SMTP id
 956f58d0204a3-662efcdeb7bmr2181224d50.56.1781789614303; Thu, 18 Jun 2026
 06:33:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618025239.420860-1-zhangchen200426@163.com>
In-Reply-To: <20260618025239.420860-1-zhangchen200426@163.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 18 Jun 2026 09:33:23 -0400
X-Gm-Features: AVVi8Cf1lb0YjjXthdLHu8b9pL19kMaFUIjr_0R23RCDnVUtdNRVeKr6UedVN1I
Message-ID: <CABBYNZKk7ftTS-pc5mQK_-Y-k6LJZWE8A86Qxp9XkdbEeqhQaw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] set: Abandon the use of the existing set gatt-db
To: zhangchen200426@163.com
Cc: linux-bluetooth@vger.kernel.org, Chen Zhang <zhangchen01@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jun 17, 2026 at 10:53=E2=80=AFPM <zhangchen200426@163.com> wrote:
>
> From: Chen Zhang <zhangchen01@kylinos.cn>
>
> When pairing and connecting a pair of earbuds, if you attempt to connect =
the
> second earbud while one earbud is already connected, reusing the existing
> set gatt-db will interrupt the GATT procedure. Subsequently, the attribut=
e
> values will no longer be read, and the ASE state will not switch. This wi=
ll
> eventually prevent the second earbud from creating a CIS, resulting in no=
 sound
> output from the later-connected earbud during music playback.

Why would it prevent any operation of the ASE though? Perhaps we have
a different problem and this change is just a workaround. Anyway, the
intent is to prevent only the discovery procedure not ASE procedures.

> Signed-off-by: Zhang Chen <zhangchen01@kylinos.cn>
> ---
>  src/set.c | 14 --------------
>  1 file changed, 14 deletions(-)
>
> diff --git a/src/set.c b/src/set.c
> index 4ca2f78c3..0f2e9613c 100644
> --- a/src/set.c
> +++ b/src/set.c
> @@ -282,20 +282,6 @@ static void foreach_rsi(void *data, void *user_data)
>         if (memcmp(ad->data, res, sizeof(res)))
>                 return;
>
> -       /* Attempt to use existing gatt_db from set if device has never b=
een
> -        * connected before.
> -        *
> -        * If dbs don't really match bt_gatt_client will attempt to redis=
cover
> -        * the ranges that don't match.
> -        */
> -       if (gatt_db_isempty(btd_device_get_gatt_db(set->device))) {
> -               struct btd_device *device;
> -
> -               device =3D queue_get_entries(set->devices)->data;
> -               btd_device_set_gatt_db(set->device,
> -                                       btd_device_get_gatt_db(device));
> -       }
> -
>         device_connect_le(set->device);
>  }
>
> --
> 2.25.1
>
>


--=20
Luiz Augusto von Dentz
