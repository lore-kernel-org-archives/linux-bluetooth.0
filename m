Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A7156B841
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Sep 2026 15:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788882620; cv=pass; b=SZ3eFiaKI4Z/vZ5v3m6t3462jKE+XJj9cVZvGk0jOJ1x0VXczrVmnAWyj56rLUlLR8/iYnX7XYY2CwpJDxYBTWC7iY3jTJ/iyOLgqwD2LZzE9qua92buEj2ohHCatuikVi1zPWK54/6uiTJSISMM7FyNAfZs8YmQokceMBlDC0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788882620; c=relaxed/simple;
	bh=Uy7d6cWsWhUqP4Er/V0wrHkot2OhlG/j1NYjesuetsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LA4UKkvIqa1zUcgr41UaVhIhXnd/PuHGCXWTIgtl+0CCC/wzMET8/jnt5D+XE3aOy3AaAz8Llau3n7QCMI0bTjVJxJGCWRADS7QtY0iwkDCNXaXvuw8i3b9LwtVjjB+WZG6PUmBpeN9gOV9vjxrT391YvfHfLHFAZHDY17SEQDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E1iNWXGt; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1iNWXGt"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8706dfdcd4fso60481947b3.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Sep 2026 08:50:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788882617; cv=none;
        d=google.com; s=arc-20260327;
        b=Bdqkk61M+f7g6sVAqbTl9rdhRksb4xhuNLVDOZfQNfwMkt+qNBkWNKl64w/jrhfqkh
         6GDzxXvHo7s1N1OCyABJkw6I5IgidbuHpcCqiWrjWFIol69GE/AZgXWZpTayufxa++F0
         0ghcz3zp4rscS9w6VZYC9sej8AnFHK49DWRMgu/0zEvaVVx4LB/WPdHu4CLOKViotRoz
         RWkJLNp/GY6yQ8vHNTTww4MIVNUr/mZ8iyPZrP38e0VkpEOrqTdP4Q3VIEvF2VhBfLZK
         FyfhVfAWsKW4PihhZ3Wq3bqF3piB+wIHLbfI5ukX+79u+aOiGwCSKh8r3TsCmGpJrYXy
         3UVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=27jc5aCnOb5lF6q1kPnA+hKgGFclE1wOxMyKQuZNOVs=;
        fh=E/KJZZnTTLB0XqUzit6qEvQ3V5Vd+nJKhvqRGQKqD7o=;
        b=GrqjOVmYFzBmBPMfiYsAYsfy2fi0MUip6cD626BD23G/Lb7mc7PtQKbVAncS9QuPhE
         MpdeT15WJLcUbMdQK9BCh5TK5kvNHydTdhtksVEdV6E0HfIWsF6lPXyqt3MgIDoKi3jZ
         VudTlszK45rY0olv6kWlwqV0PoiT57ZV+WDO6LVV5hPlC0ZLjRZlKjygw+tZ3vh5z1KH
         6DMk1alo2ZI/dKbJIiX7X9fI03LeOKTjcjqFp8t1Haa5GrCQrpQPxJ7CNnFju9a+SiYk
         jGbUgJwJX4gpaV3JDhK6KSnmdFSkFudFRC9E7oFJHCOU8GH7KqgzxnEv3TaCpfPEX4xk
         6hJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788882617; x=1789487417; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=27jc5aCnOb5lF6q1kPnA+hKgGFclE1wOxMyKQuZNOVs=;
        b=E1iNWXGtMPv51J939MjU7abiUREiKNwccdHMtBXqv8bnTOe4UyKByoSvLVlBpFRHCQ
         mrIInukZamf/3F1tPUrJgjknES8+JfLiOMiYrBkX4R5zx2BedIKk3zBcoIdu28vJA6uZ
         h3ctBuvHH2C4qYuE27bJxOy5lCA8P39W3TnqeNeTzWDjGQgzws+R4l19zWArIkGxdXWH
         i3hN62eATD57ELvLgCB0bUaAjxJuwjbg/HHQrSrQZLxTVehBTCdnHsiCplMCL8+RgXuR
         QqtDWjGki2+Tiy5DOOJ0fRbvjswZPu4RDkwOrlZDNMWlWzeziprQ82nhlAo6grMXmAnG
         1Asw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788882617; x=1789487417;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=27jc5aCnOb5lF6q1kPnA+hKgGFclE1wOxMyKQuZNOVs=;
        b=fRTALcItvteWrt9AvD2tr4U8SiG2snwC2kgpmQ6kIELxtFP8R/EBb+/yP3/bswVmJU
         1ZuHw73e+Aa8xHvekuHyzsCJEwGr6svIzZs8mejwQj+NLGuyZ6EtoWCJctjrDZDmh4e1
         THBz7UEa9ELg14JJpPZjEOsSfuA0O4+HSTVKQIzPDWnCFwvYGRqWTHmN0+bv7SiO8nFF
         9v5WGsmQSdheqF9EfS1y2cCyEMbOarNXjeitkpQnZihy+LvlWWpGKV1sTPuimRpYPlG2
         YA7PZStkYvFGNKP5MhL0bkF9WuglYPkp+LTBJ6ykiyWlqnUgyCV8SwswI61X3JvwLs7N
         u0bA==
X-Forwarded-Encrypted: i=1; AKwUvBwkAgLxXWGRchLAiYJ0BbQqvI5HuMTfFlHGbyIpxDg03DQvXDEZ8ifooxSArs5TMhljZqcLuJmyGpcotuASN1M=@vger.kernel.org
X-Gm-Message-State: AFuF++modbfNRGCWAq5/wecELWtmCIwzhQ8TkCZDd7EuYM5mggOjCpAY
	uTMbfSqy7rY0hPZ3PootroKbOybGekXM0MVkVAQyPp/zsvUmNkGJq8fKquyyFawtqZMp6P5xyl3
	y7cqhLW9recKFllZ4cSnebztmBIE5w1QF0koYyL02ZQ==
X-Gm-Gg: AYBFou172yw4W7NSFEuqfv6R+bhyQ6u3aF50nhBHCax/vOQQ4OBLXwuYTi96DH7G1wN
	cKX7AanqnNOyKDeKbeNG6SuZkzq2kQX4SIC0IxR5QqxefJhZTzzVG9DHseOwTU6a58JEgEWQcSE
	YsVXIbv6WV8xRKp+wgZYR+VAsM0pMRPXdH0TI2GtmN0jFNuaBsvSdowXPwj5WeF220W9nQAPq/L
	dQsf8g8X0Zy0UjHeFJK6trTOwObIJXNc2NdXLmsAgumOMBTFaArOyZvunGHzc9PBgJIfl1ENiBd
	QtQfreIlQ0wnDBuF274no5E56Wgxzm0dIuC9QPFLiZNfH1J4YIWU/TmLUkBwe/Ps0VZYTyq/WDI
	3EOyzfkv5qogNRhcGLg9WKzhTkTu2cGmrp/Wl5CU=
X-Received: by 2002:a05:690c:3391:b0:873:5bb2:6c30 with SMTP id
 00721157ae682-8735bb26ea7mr83060557b3.55.1788882616660; Tue, 08 Sep 2026
 08:50:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260905194725.284347-1-adrianox@gmail.com>
In-Reply-To: <20260905194725.284347-1-adrianox@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 8 Sep 2026 11:50:05 -0400
X-Gm-Features: AcwNN1X37kIm8-OoWmTMYNL-mXG3nWBgvh6whzxNuC3s7FdK8MvcBiVvPpXbsdk
Message-ID: <CABBYNZ+_KZXEz2210xPShKy=baN2Xrd4T7YijdCn9y3h-t5V8A@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: bnep: linearize skb before sending
To: Adriano Cordova <adrianox@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Adriano,

On Sat, Sep 5, 2026 at 3:48=E2=80=AFPM Adriano Cordova <adrianox@gmail.com>=
 wrote:
>
> kernel_sendmsg expects contiguous data. Check the skb is linear
> before building its kvec. Should be already linearized by the
> stack, so this is defensive, but drops the dead block and the
> FIXME.
>
> Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> ---
>  net/bluetooth/bnep/core.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
> index 5a6a49885ab6..497eb1d2d6ee 100644
> --- a/net/bluetooth/bnep/core.c
> +++ b/net/bluetooth/bnep/core.c
> @@ -457,13 +457,15 @@ static int bnep_tx_frame(struct bnep_session *s, st=
ruct sk_buff *skb)
>         }
>
>  send:
> +       if (skb_linearize(skb)) {
> +               kfree_skb(skb);
> +               return -ENOMEM;
> +       }

Looks like we should be linearizing earlier:

https://sashiko.dev/#/patchset/20260905194725.284347-1-adrianox%40gmail.com

>         iv[il++] =3D (struct kvec) { skb->data, skb->len };
>         len +=3D skb->len;
>
> -       /* FIXME: linearize skb */
> -       {
> -               len =3D kernel_sendmsg(sock, &s->msg, iv, il, len);
> -       }
> +       len =3D kernel_sendmsg(sock, &s->msg, iv, il, len);
>         kfree_skb(skb);
>
>         if (len > 0) {
> --
> 2.51.0
>


--=20
Luiz Augusto von Dentz
