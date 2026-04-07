Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88B73CF03B
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Apr 2026 16:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775579877; cv=pass; b=pdBmg9c6IfesaZCOp4pLbOfQIFmHk5f9tIEPiG6lk32ks1aWsB6RJ/hEWD0BoS186flCIFbD3E2tI2Y+hb2n77lPmpJv+xiBkElgPJIPDiBu4a6HHJpDxQ5mHcnEik9R8+5NCI7MXPd5NH6bVeWhZgvOLUQ1FxkW7Kqdy8L0NK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775579877; c=relaxed/simple;
	bh=d0Rq280+b0RTGZSw4cdoUni8pVhGTByH3GfapUpA96I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FMvEuZBSU7/ZmUDzKgCMqRnl0t5nINKYdqNtcWhPgMz8F6Pk3NNvgq7pq2NMsLKLRo4nN34e+ZF95ZXZQT/vSgpc4/Hy+0f/KFSWYqWcnqd+Bxe7U8Cn9jzclH20UTegFOknmwxWlDmbHhgmaKUykNeRr4sL5FwlP11axJflBUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LIlkgieI; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LIlkgieI"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-65032e9cf01so4992880d50.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Apr 2026 09:37:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775579875; cv=none;
        d=google.com; s=arc-20240605;
        b=CIGW/mI0yDVuXK42oXCJcEkjpAk5iELCeAOqbhdK9+kBGuIhdgqihnfv9pZcuRwk8p
         7BX2IQBpTjv4b0vMMHfYlRXeMvU7wn4aNap1rpZxxvRHwYM8otOogrCmL6Joj0jbSduc
         59WpRI5pbf8QJllK/a6jAQYMeaNpTzuWJZ3s4MtaMiqnf4NtpRfHGsKQ50X2F9Wc2Rpq
         dZsWoCyOD5ddaVnMD11Lk06IvR0ok9xNcGMfm1YakkLkR/FeLJQQrUOsrEPBvGLaueBz
         Mv4bdElr9oIfpJ4QavnP1lQ7ntEhP6NlcGsA7I6FA97BC0i0Tv7Vy6SEo8ro20sSUv84
         4zNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5U67jFro8V8266yLasTS6qz5uFih81qyQ9daWFSEJ4U=;
        fh=enJkaQy1p0wkCdIHP7t0N9wD83bUIsHWTcf6KiXoIfA=;
        b=gUSo05t3ROTtUF9ebgA4pZfMacggQ2hCSOwlJrJvYhOf0ILW+8wJHToLbU6+GORh1J
         redP3yxyWuCsF96n3FMJxf5YWnA9Nqt4xOzmijqeaWhUVkcn/y96N9zjUWRRBpWRnAuu
         35eIvWWZ5OkkN0BF0I6MvAaCnVZvyV4jMxNrzHdUZ7EzVL9J/CUVdDQ9tjM88R6xhT0r
         On+CaP3RkZe1FCmblwxRj6xczIo1Lgm3ehYAEAaXaJ4TZHtEsO1XSvkvhZuuSBdgpyBy
         BfgeXQAmx0lZaK0d4rmAeb9+Md5orpF0F62h3gexjFzPbQzES42kHZ7O4Z9SxgqQIiUw
         8A3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775579875; x=1776184675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5U67jFro8V8266yLasTS6qz5uFih81qyQ9daWFSEJ4U=;
        b=LIlkgieIn6vvcbwhyJV/JropWc0cMwIr3HaVfUQwDrKSb1Knsq4wh7qSGRcZzN9utd
         AhgcXCvjb5fto6z4Nk8NmXU1jBFDu06CUNeoBrapYjmSu8A5Bkkgxgz6PPJdgz9YYQBx
         Fi4Ey3XrlNTocSVcFTo37ajFvk9+DcSsh5un1K1rlzpdcVpXmEQ1jOpFjnCMXGq/anX9
         s3+LUmhKbyeUovnwsknfR1X7JnfKxguOxGPV1J0y9WxSjA96n5sZPodDhR/YOgVcan2C
         MOXEgga07kpwLzvW/G5/cXEvqLwJMtELVLwph+shuC/KOCyBvzJahu9N2u8TDkgkVP32
         3Aiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775579875; x=1776184675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5U67jFro8V8266yLasTS6qz5uFih81qyQ9daWFSEJ4U=;
        b=fV67XuutakBtZ5qgfGcg6ATASlWLb5CIYktEgGiColDIwtt6IAaebhxlrxhOQ4mR9y
         sGh3Gxu6t98/N62SIH3KK4nRV4ZlziCAdQiI5LcbimjK+nHxfF4Cikutf+ZyDw2ohBRD
         MJ49bRJF1GgtxgrmSdqTCx8DLHK+oMmJUQmDa2164hdAPWMlrgzzj9JsdKwBGTgtjvh8
         oNj/lDstJe8XeJOS7hJPuzVywds6IApG3C0pHDnVob9P43baWRsx80SO0vcmEvEmK/Tu
         J0c+U05eP6zCTeOaOm/MThqzvW6yY1bI+k5QIE9yeVUhJsrdb38Ee7CJcjXhc8gmyQn8
         456A==
X-Gm-Message-State: AOJu0YzAi12gZhPSgYyKfYLn3gCrBj6szkzYX56kSB+xb9ItT6UgSx5p
	NiAga5u1Hd9Ho5IPYQUO+D+12m0DV1kwTI5y7kR5AUr5VylYd+Pt6yuObidqs+VWCyyCWtPdEB3
	1hb48PhvDR7zlWcn0sQJ6oSa+/+Ty1tk=
X-Gm-Gg: AeBDievfJ6paTVD/Rv0fVACFGvS4x0Y9AKpjAQ79z19b6Mi8dSWoMn7bxFcJYui/Otn
	+ssemwcwhvTnZf/ARhsVo9sfjjivhotfT9yJtKTJJvEiQqNf95xnOhHBNNnIb4wwnfN3mZ7/qyQ
	9aXrv9+KJjIFqgcXswfLCKvHIYNpUYbUqVVHOkIAMtlap/Uw7+P1J/+9ElBBsDwEHArM+VF51TP
	FQSDwqia2W0Erta3hLvR6NWbK7/V6HqjIWnzvFPGD2gjqnBhRsgHc98sKfhU2b525t+sLbA/gq3
	tc0ORILFBjE3IyrC11zN8H5dsipJ7JRRJ5UF6GekmjA+zc7WCxvFac/cwEhVREYCgeY=
X-Received: by 2002:a05:690e:150f:b0:650:3831:575d with SMTP id
 956f58d0204a3-65048721dddmr17570519d50.23.1775579874737; Tue, 07 Apr 2026
 09:37:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407151345.126999-1-metze@samba.org>
In-Reply-To: <20260407151345.126999-1-metze@samba.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 7 Apr 2026 12:37:43 -0400
X-Gm-Features: AQROBzD73nrr1Oxu0tCJqahifmsLGRPGRhe66Xns53ZbNWYi7rfE0izX5fyQ95s
Message-ID: <CABBYNZ+H7qnZFSz=Tx-S2Rdet9a1vEbb_kGbzv_VjC1ZGS5t_Q@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: SCO: check for codecs->num_codecs == 1 before
 assigning to sco_pi(sk)->codec
To: Stefan Metzmacher <metze@samba.org>
Cc: linux-bluetooth@vger.kernel.org, Michal Luczaj <mhal@rbox.co>, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, Marcel Holtmann <marcel@holtmann.org>, 
	David Wei <dw@davidwei.uk>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stefan,

On Tue, Apr 7, 2026 at 11:13=E2=80=AFAM Stefan Metzmacher <metze@samba.org>=
 wrote:
>
> copy_struct_from_sockptr() fill 'buffer' in
> sco_sock_setsockopt() with zeros, so there's no
> real problem.
>
> But it actually looks strange to do this,
> without checking all of codecs->codecs[0]
> really comes from userspace:
>
>   sco_pi(sk)->codec =3D codecs->codecs[0];
>
> As only optlen < sizeof(struct bt_codecs) is checked
> and codecs->num_codecs is not checked against !=3D 1,
> but only <=3D 1, and the space for the additional struct bt_codec
> is not checked.
>
> Note I don't understand bluetooth and I didn't do any runtime
> tests with this! I just found it when debugging a problem
> in copy_struct_from_sockptr().
>
> I just added this to check the size is as expected:
>
>   BUILD_BUG_ON(struct_size(codecs, codecs, 0) !=3D 1);
>   BUILD_BUG_ON(struct_size(codecs, codecs, 1) !=3D 8);
>
> And made sure it still compiles using this:
>
>   make CF=3D-D__CHECK_ENDIAN__ W=3D1ce C=3D1 net/bluetooth/sco.o
>
> Fixes: 3e643e4efa1e ("Bluetooth: Improve setsockopt() handling of malform=
ed user input")
> Cc: Michal Luczaj <mhal@rbox.co>
> Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Cc: Marcel Holtmann <marcel@holtmann.org>
> Cc: David Wei <dw@davidwei.uk>
> Cc: linux-bluetooth@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Stefan Metzmacher <metze@samba.org>
> ---
>  net/bluetooth/sco.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> index b84587811ef4..359eabf7dddb 100644
> --- a/net/bluetooth/sco.c
> +++ b/net/bluetooth/sco.c
> @@ -1045,7 +1045,13 @@ static int sco_sock_setsockopt(struct socket *sock=
, int level, int optname,
>
>                 codecs =3D (void *)buffer;
>
> -               if (codecs->num_codecs > 1) {
> +               if (codecs->num_codecs !=3D 1) {
> +                       hci_dev_put(hdev);
> +                       err =3D -EINVAL;
> +                       break;
> +               }
> +
> +               if (optlen < struct_size(codecs, codecs, codecs->num_code=
cs)) {

I guess this is odd because there was no need for this code to exist,
BT_CODEC should have used struct bt_codec rather than struct bt_codecs
since we can only set exactly one codec, that said I don't think we
can change this now thus why we need to perform these checks, anyway
back to your changes why don't we have both checks for num_codecs !=3D 1
&& optlen < struct_size(codecs, codecs, codecs->num_codecs)) since the
handling is the same?

>                         hci_dev_put(hdev);
>                         err =3D -EINVAL;
>                         break;
> --
> 2.43.0
>


--=20
Luiz Augusto von Dentz
