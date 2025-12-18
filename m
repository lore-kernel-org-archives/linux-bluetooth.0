Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B6F1D6187
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Dec 2025 14:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766067539; cv=none; b=Kc+NV5IxH1MgTqtyhGoWwNKNuYcjgXXvOXNnf5Uacm10u1WYZixa99wvCIt55rY+wh5s1sdfuDzpgAgTdEgB3io6wJ4po7NadTQ/FJELWcfhSlIhPdYc/42wNCl2obiIKw88r88KxjVwuEVbEv95codP6qtdLLTwBSJAfg3ewYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766067539; c=relaxed/simple;
	bh=PvtOosfbzxZk2u3/+j6VarnwB1NQ5LFRGk54y2ZhUU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s2c1gEE1BdeAxTu4fS57OAIqPQ+6Q5cT2c+Ci03gzMZHFq1aX1/tbXaLFapKz7r7rH6ocprut3TqR4Awb7zVy1ehoEwY6yM2Wg8iZOOU1+56YYoAbIcQGUJ014ec0vKhV/Yzan5l657MCyO/MdE9ngbh4t+GWK/Qm8+hDksqEns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GZhhUWrU; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZhhUWrU"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-37fccf7035aso4538561fa.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Dec 2025 06:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766067535; x=1766672335; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yE7OB+M0Rlu4NoQ0B85zu3o6xWOAdn14eLMpJsXQbdU=;
        b=GZhhUWrUXN0caexGv+mrH0bbaAr+XmtBlj2dKsXfSzMV2e4NmxA8fHFSXpEAExiL8y
         UxmAnN/LrThblGl78M0AJynqj7rlY4KRrWoNWKROdWIX7PAQM2DbggwD/Utpeag5Fbry
         8WSGsZoFV1hYjwshl3RjI+SazpH6NQm87Pt9gkRLmKtIf0CqYJNU+pxuhwbGDBZYLEs0
         btea1ArL5pgcHGoYMznFGzlpxw6IVVCNn3UZVfEHQ25iWtKpfEXqjMWOajlANGXyM3j7
         6CAycQAfzrPgJByFImMY+osAp5zSbFM7ENPc6WOaawCxxBYtDw84VSUJujvRZiGwy9wy
         00cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766067535; x=1766672335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yE7OB+M0Rlu4NoQ0B85zu3o6xWOAdn14eLMpJsXQbdU=;
        b=PPfVSx1ixSaM1vR5jmH3HNM4Da2rd9+5dWoNIlf4asauhoekdDwDcLyzXzYWvRKft/
         X+D+mG1ZDk36eugA5kVy6LreXa6ezTWAajZvHPYdfMSQbqXbPCtXXmvSPoy6UWqtvSlU
         J569gEG1FhtuX9cHj/jcIGYM8vuB+VMrWNf2pPMgruPR+lngeG8DrSLPYmcLHDygA0Vw
         43cJ64bhUB6aAl1rR7KZJ1oUMLru6faXcVGHTL0dBwqaS/loBjtw/n8bPvJ+I362h1eF
         mIr8ILkDyZITHiI5Euuch59+39yC4cUPPvDlLeLiTjG9H+IHkmILTPqjyJbus8TI8JJh
         ZCEw==
X-Forwarded-Encrypted: i=1; AJvYcCWggwa0Udz1MzMg+3ftq/daCVVvTQB/Bqyudhv0tc4GQYcYfbDdCu11trK5D+GhgwyifSGwt5RJk6m7nuwVaBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxM2mtoitiDEQzMTDcEs1g1lRQp/4/wEDxBHZeG59FQgbu8NnY
	1ROHrh5ZPSL12vD2fBvBQxeopKUOKsRbnEWd9bGlI33tv5NNDFLUxnMqv+tDiuZ5IiF/7LuJ9rG
	B8qDMEHI6RnjdnlQWXk4rcOQ0/zok3oQbRqilU2bv3w==
X-Gm-Gg: AY/fxX5M0G5boZNnFBACBrZ9H8BZEAoMfqr5R3w0DUdupL4l5z/r6ub/Qp/g/VLJYkH
	n2D19FyCPr1Ca61sOPBHtKv162Ka4lmqdzn8CJYo+TdNxaWAukC0hdLj+9wyGR4WOXmtCdtpkPx
	Anbt5jGx8OjQBlJifXEmLz2sQwA/WPZQwJL4Eurqbao8EiUKOdqd9TTBzKdzyRiv4ZNRBN7/hnS
	lB+/kkLuE0+oU9A0M8+CNE8OZzhu9vczqxIxEQMwl+hjemL8HVfbAPBN+oxrB9Pcgwu7w==
X-Google-Smtp-Source: AGHT+IGVgA9EGmGClPDtWIPx5aEW/mZS0lWS+VZufUiSovNlLQz5NxT8eH8ia5a2JdxsXSlO0xmnHw9D5mkD1ii48BM=
X-Received: by 2002:a2e:bc82:0:b0:37a:3123:fd9a with SMTP id
 38308e7fff4ca-37fd08e75a4mr64558941fa.42.1766067535198; Thu, 18 Dec 2025
 06:18:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218120826.533081-1-ssorensen@roku.com>
In-Reply-To: <20251218120826.533081-1-ssorensen@roku.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 18 Dec 2025 09:18:42 -0500
X-Gm-Features: AQt7F2o3_u0JUdYwy_OUA8dULCClBB5Yrk4Eulrf7CMAPC6jrwIWelZj1Gm1EK8
Message-ID: <CABBYNZK6XfUbk_FG581Ujt6+XftskcfF8-ztL=KTQNPyHBaW+A@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: mgmt: Fix TLV parameter code type conversion
To: =?UTF-8?Q?Stefan_S=C3=B8rensen?= <ssorensen@roku.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, 
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stefan,

On Thu, Dec 18, 2025 at 7:09=E2=80=AFAM Stefan S=C3=B8rensen <ssorensen@rok=
u.com> wrote:
>
> Use the correct le16 conversion for the TLV type field when adding a
> TLV using a u32 data field.
>
> Fixes: afa20d8099ddf ("Bluetooth: mgmt: Add idle_timeout to configurable =
system parameters")
> Signed-off-by: Stefan S=C3=B8rensen <ssorensen@roku.com>
> ---
>  net/bluetooth/mgmt_config.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/mgmt_config.c b/net/bluetooth/mgmt_config.c
> index 4ec6c008cb7e6..fdcc752c6f13f 100644
> --- a/net/bluetooth/mgmt_config.c
> +++ b/net/bluetooth/mgmt_config.c
> @@ -37,7 +37,7 @@
>
>  #define TLV_SET_U32(_param_code_, _param_name_) \
>         { \
> -               { cpu_to_le32(_param_code_), sizeof(__u32) }, \
> +               { cpu_to_le16(_param_code_), sizeof(__u32) }, \
>                 cpu_to_le32(hdev->_param_name_) \
>         }
>
> --
> 2.52.0

Ive fixed up it in place, that said I realized that these macros are
sort of not really helping in my opinion, so we might as well do
something similar to eir_append_data and not use a stack variable
since we might want to exclude the bearer specific configuration if it
is disabled. And the double parsing on set_def_system_config is also
suboptimal, anyway this is nothing you introduced it was just left out
sort of incomplete.

--=20
Luiz Augusto von Dentz
