Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024651A2544
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Nov 2024 14:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732112420; cv=none; b=Uv9OVuSawCfvD1pMhiOtz/o/58xgZsYUrFzPw4gLtXL92UViAJUOqjvdsc1A1DsTDrKbi7zNp0ZGdkmWOvT6HbLQI66lhZYND8vLDFEzVxoGlEOX9LppAp3gzPVWS4NsSXw0ZxI2+yeMi7abmkw9HOvZQuvNiY/Lwpaiyz7hsYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732112420; c=relaxed/simple;
	bh=iGHQiyjmhyCra/PGYejSwag27qAz1ximRR13KYcaorY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OTwsPqgKvQCI8naQ6p3mr6g/ciosVtf6fkpfjyYdMpHXfHgJztAbyw+wxyWdOIvPxww1v3aMAldWsdDUNBOYJKWzw0lKxcoC9lhefGAmyjYuVmqEqGS43o8o2482vwOgnVh6y4xGdSnxLSJ5netIOZVZxEb5TiAOBCXZDZ0fsaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GQDKHBGZ; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQDKHBGZ"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2fc96f9c41fso11801551fa.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Nov 2024 06:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732112417; x=1732717217; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hKw0d739odkAjKexoXdTkMeWsPDCgSuCHOlJhCgSnh4=;
        b=GQDKHBGZHo829h7qkNQQBKtbCY9nEWazX73gMSIcSRQwVb7OToTRSiZIJ0HRi/K44P
         sBW9WyLKwg9GvceCAjz9/NCy95i7or7rCZimCGmsDUWDVQO0mKfoWsFfxp/8kljjhrzQ
         +145DyoECvs4B4zxh54pGxHhMoT41BleVoCYzoMSqMnTcJndCX7sAukK9+l+qHnbDB3z
         ep+A21WvTx561+LF3xh4paIZmytMFyEid214dOqRNUdkVvDyzR4eGyj2fU3QMWl5SX5/
         OT9i9+FHnoUy0LO+8T7NJHCkqR/8KVrEXb3gcBiWNtPuQq9Cn7Qie+4jzkOrIPXFkYb1
         GSOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732112417; x=1732717217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hKw0d739odkAjKexoXdTkMeWsPDCgSuCHOlJhCgSnh4=;
        b=BQLFS80VdpCn4BA3Y9o1buSPKJFCGJWR20LhZA8zEM3dDDwaiTJLgM98c9yK2WZpoz
         TxjiK87WxKUSiavMdAvF0epKf8kvTNMHxcWde57hOuJPXjz5nw0PEdFIn3It752LLZg5
         vj6jUNIUu14lkOBo8En48Wyi5AhDTZvqWLwfS9fB29k+FPS427Ww1su+SU5P9e4g9QXy
         M9J+QxYf9Yr3PEKyXSI447eEpx52+lDrlSN1Dbid3dnDq++j9mXQV/5xyhnWHPWKx3Oy
         6xSHCLK3A92nfxVwjwEPQfptme888Ohxo802CgyLRVbkq6kTQiXmRAvE2IXhr7OV6Df+
         8S7A==
X-Gm-Message-State: AOJu0YxXPkvD3uiNtc3TWcOE/CZuPXY/Z4329zDRqCuKwm+ioqPT9qnu
	ok6itfa7LJklOtoEkea19SGq97daXMg+/rMWjnujX1iowNP67sXCC9lYH2h8XC0//CnpzuSGkdR
	CeCeeiqeb6AKUuimsHIxNuL6AcKLX+Tyt
X-Google-Smtp-Source: AGHT+IEWm81tgQ+2sgHP80jDsIS8USNNK4f+XI6uLKyWiuQ4iVbydUDR3Y0J+rtgCv1aOFDCm18iO532IXAOJNHYco8=
X-Received: by 2002:a05:651c:b24:b0:2fb:597e:28f5 with SMTP id
 38308e7fff4ca-2ff83b5b477mr26917731fa.2.1732112416783; Wed, 20 Nov 2024
 06:20:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120080447.233393-1-quic_jiaymao@quicinc.com>
In-Reply-To: <20241120080447.233393-1-quic_jiaymao@quicinc.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 20 Nov 2024 09:20:04 -0500
Message-ID: <CABBYNZJympX_P4vO1Vg6Y-RKZYJDrSrHRh79NmttyDY8hQRSOQ@mail.gmail.com>
Subject: Re: [PATCH v1] att: Check security level before setting
To: Jiayang Mao <quic_jiaymao@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org, quic_chejiang@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jiayang,

On Wed, Nov 20, 2024 at 3:18=E2=80=AFAM Jiayang Mao <quic_jiaymao@quicinc.c=
om> wrote:
>
> bt_gatt_client_set_security could fail if the security level in
> kernel is already BT_ATT_SECURITY_MEDIUM but long term key is not
> ready. So, get and check the security level before setting it.

Ive already pushed a similar fix.

> Signed-off-by: Jiayang Mao <quic_jiaymao@quicinc.com>
> ---
>  src/shared/att.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/src/shared/att.c b/src/shared/att.c
> index 4a406f4b9..dabbdb431 100644
> --- a/src/shared/att.c
> +++ b/src/shared/att.c
> @@ -727,6 +727,9 @@ static bool bt_att_chan_set_security(struct bt_att_ch=
an *chan, int level)
>  {
>         struct bt_security sec;
>
> +       if (level =3D=3D bt_att_chan_get_security(chan))
> +               return true;
> +
>         if (chan->type =3D=3D BT_ATT_LOCAL) {
>                 chan->sec_level =3D level;
>                 return true;
> --
> 2.25.1
>
>


--=20
Luiz Augusto von Dentz
