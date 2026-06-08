Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE5D3CDBAA
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 14:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780928948; cv=pass; b=kOxba/VBlOjw7hqXtDQP0FXv3OFvjRGdb0hxN7G2RoYhIkd/wKOAXBQfW0ThwmBWEej0OmgJpm/pTTzKVH+H3N4iIrtybeEScetPbFYXKW7WNLO8w8itGy6esYGsrr08IdY29+ZKu3JgKLBiyxnH+s+kwVevBE3IvLyuV2cVN8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780928948; c=relaxed/simple;
	bh=6x4MZz2yL6Y7auDvHE5F1gRhsQ06G3+72m1RpiAASmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R6FoVVGbUHnH9Hdw45kY9K0Af4rW0auIXdz1+pn2cmZ8f8yQ5iNJa8f8PD4ctcypHDt/lWp13TRbw17jI3mFGy8dkT9nLFlyBfKILPecEA6ieQ+rcxGJXH8heFjAYoYHsUYszsyur7AAHp9uQiy8Nz94sscpzXui0/zdeEfiwRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i9ZZkU6T; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9ZZkU6T"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-660633a60caso154793d50.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jun 2026 07:29:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780928946; cv=none;
        d=google.com; s=arc-20240605;
        b=KgZ901fw7rhomOd20bsCAwFDKIElq8lnf27iY/SJW8zVQGINHJzOj185TfPO7X7i3W
         nU4cPFYbf7W8r0BGWkMmC++ofFbot4ruAmE5AuPNy4RzYOWIVtaXBZXD/m9GY8LZyhDW
         RI5uSzCjRiAY5oUr+ZTYab1uiPp8mQG0OeILcaEJKQ+D7BuF5gMsW4e2zj/lc1jr5hT9
         VLCP11Oi6DDlAlhUU1YIM5sIOLTh6U2z31QyNWShYRB8m//nknSnmlS/aGOy81lf6qan
         RsjINcY79lMLlMr/OCLTx/+NRli4gs6vErwrJIzRmCaXdYEbEmTM0uUB4ENae+1O4oeY
         okFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gDQ9M5pHZMu7/YcPBMgukFWRIxBC0x+I9jUxR1OJYSM=;
        fh=tyq0gYhA4cMcqn+bWakZSAdnDDyh/si+tlAcgOGyoy0=;
        b=PFdn79KTSg3J3hEY90CAgx4ZfDN2D5acBjS8RDXHYY1m5CRv9DIuxV2Uv9bdvRuMzz
         KezD8N8+3vCTIbhUu6i4JKXx311e5mvsnOc6gK9sQZCphPvXSYBF+B888xFiCRdOWvim
         JRvL27Ww5Y0UPHaE7ovQgeLsWDqfush8UaMvWTlsYF2rRapKatinHIIVGxGfmRjEOPcT
         lM/IOUDOvKCAFOiVS95eyiHJyipM3M3oAa+FDLP/ZCjIMIbP+B9+hok3+N8Oxi2egT2B
         Bdlbc96dQX5eypezRHRgQQ2YPxpVzt3KojfNRgcmkWnVV3b4Gk7thG7jgYEoxrKmZKzt
         4ZAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780928946; x=1781533746; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gDQ9M5pHZMu7/YcPBMgukFWRIxBC0x+I9jUxR1OJYSM=;
        b=i9ZZkU6TlCdvZgY1vEZj4XRTNxdi7yR9O0d9PG1AEHy3y2FECHxxplRgHhF4a9r+xM
         iTPMma96If9jCskoW88CYUhUxKTMyIYgKlIFIokWPCV8gMsHqX4U27tqJDekUm8H+8hZ
         yT9O0rTqFHkXAJnq7Y5Vq3OyFM7g/AoMdeGL7CR3M0FVk8pB9qWIauUilaJWuLw/BKwc
         iA1jwXF7p6XB/KV9bEoc/QDmIEAoZoo4WcZQuTviv3uVWMGixD1pSoYE127627N15RJJ
         j88WKOgGuZaGC5vW9NqghSloD3NZLOSXzxTL6mWJ9P9mD0gWEnTC5nfaZM08XTnuXuBw
         vzSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780928946; x=1781533746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gDQ9M5pHZMu7/YcPBMgukFWRIxBC0x+I9jUxR1OJYSM=;
        b=spWLgV1ZykiWThJDIBp5U7ToHYnS5Uokgd2S8dCvIIxspwNeYqKzyHUvlqVaxRKblG
         782xLIVeHHH2ZKr+FIZA3paxNxKMMN6B43Y2hUyY0ZU9TkeXR/R/ISBj9V641eikoYCA
         E2Noi2VLqcHb8eXNvwmhYUWMaL5he+g05dFa6OoEg7+M0z5n9kGHP447XYB0rz3eP7cV
         A6WIKJ8VNfcjh18M3boQe4wLmcjW9qyMI1rlAm8cp2NQMfpPcqsnY5s/5w1BF1YJcMKU
         qXwZQPOUa71fpoTAjXMvM6WfldY0Uu6tsigJSz/JhubA3CeKwlsaCM43AwgrwbyWdfso
         36ag==
X-Gm-Message-State: AOJu0YypgoX4Uq6mKJAHdXg+AbCQHM6L0hBeAxF+V0XZQQqmYTfR3xfG
	gqtHjWFcnNQ2Vt6dkmTetJvTnK4ftSoT+8CR2d8geDJjI4VEPpBpi00ZALT0Srv/KNvileX89T/
	C0+O9m4HJlg0TG0cakaM3b61CkxpjjDo=
X-Gm-Gg: Acq92OHGC6evUt/Ad19XLITvCLDLojW/9UDXeIg7bIPs4U8m0Cq+FquyGjJZtPCq/qI
	C4XAho2SH/u3TAv4d3jucHxj03YWmixd2NDkeZ6ND1x0F9bLm1w5PDXHWwXHT6FC0ArJ3VPRYgT
	BVIjEvH3LGV1B6FJx7W7q7DI3VHoYo1ljofWfrFzSRalj1wWlO9btcSmbktaLuAZjo+uQ+H4+dz
	SFfKw1SPmrT9TAcclrQfZyYs8uz7ih371da/LElCzEEggAzUWiuMc4gMAyNp+RYS5mCFQnYWYNA
	QrAT2qE+wPwLGKmln7MgKbpv2L/gxPU4rdFYjRIf3+vpSk/fLGmWid0EGw++gDsCJy+YrUaxu7Q
	WoMiy
X-Received: by 2002:a05:690e:43d9:b0:660:ec14:ef82 with SMTP id
 956f58d0204a3-66106f3b3e8mr9459990d50.41.1780928946033; Mon, 08 Jun 2026
 07:29:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608112923.3722754-1-simon.mikuda@streamunlimited.com>
In-Reply-To: <20260608112923.3722754-1-simon.mikuda@streamunlimited.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 8 Jun 2026 10:28:54 -0400
X-Gm-Features: AVVi8CcYabU-HJe--9DZaI2VazH0-6LhWPgoQImPcv6zStgmRbpYrZNq-fUZXx0
Message-ID: <CABBYNZLb6VvsnKriwe0A9d8=RQQXCJwWz+egM+2uOPS0Hi3ExA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] avdtp: Fix GET_CONFIGURATION cmd
To: Simon Mikuda <simon.mikuda@streamunlimited.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Simon,

On Mon, Jun 8, 2026 at 7:42=E2=80=AFAM Simon Mikuda
<simon.mikuda@streamunlimited.com> wrote:
>
> This fixes AVDTP/SNK/ACP/SIG/SMG/BV-12-C
> ---
>  profiles/audio/avdtp.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
> index d475a545e..7cfc9a80d 100644
> --- a/profiles/audio/avdtp.c
> +++ b/profiles/audio/avdtp.c
> @@ -1641,7 +1641,6 @@ static gboolean avdtp_getconf_cmd(struct avdtp *ses=
sion, uint8_t transaction,
>                                         struct seid_req *req, int size)
>  {
>         GSList *l;
> -       struct avdtp_local_sep *sep =3D NULL;
>         struct avdtp_stream *stream;
>         int rsp_size;
>         uint8_t err;
> @@ -1656,7 +1655,7 @@ static gboolean avdtp_getconf_cmd(struct avdtp *ses=
sion, uint8_t transaction,
>         memset(buf, 0, sizeof(buf));
>
>         stream =3D find_stream_by_lseid(session, req->acp_seid);
> -       if (!sep) {
> +       if (!stream) {
>                 err =3D AVDTP_BAD_ACP_SEID;
>                 goto failed;
>         }
> --
> 2.43.0
>

Ditto, they seem valid but will probably need to update avdtp-pts.rst
as well, it can probably be a separate set of patches though.


--=20
Luiz Augusto von Dentz
