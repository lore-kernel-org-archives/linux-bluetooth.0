Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBED7345CD0
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 14:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783693152; cv=pass; b=OXtArLDdB7HdRMxuLmHtljX4ZjSSfrb0jYDD+XmKnZdtYc1Q/3i2vKapg66wchDwAb3G2NyYVbyQLu4wWA7Lxs8Kc7LW8zMSMrkxjR24iFvvnfUMIcXiWSCxnmF6kK9hAjuXgjRvzRq3bAwGrHdfSLstk/45uwEg/UmJEXf1pRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783693152; c=relaxed/simple;
	bh=DBJR4UvbjeNy1JKdvpSIeljZ5oyIiyGXTKFwvezwqyg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nIy/CwPAOyTYLTsvPeo7fNcYQeFdIxNWS9WFsfnALCgGsGAvMJ5/XEDNzHr+dpdxhnKU5jX/KDQIthYObqkQhXuBTq0J83H+uPK97RGNkFsf0ANw47gGZHfIrgojqBbxIDbL+WLo+7YIS92OZ0nTmNX4J3uYowzAJCRJ0nyKm2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R3QM94YY; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R3QM94YY"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-664d4478a64so1286387d50.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 07:19:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783693150; cv=none;
        d=google.com; s=arc-20260327;
        b=fG3L9KFn1Lv7ZepY1K1opHi1UzCIYV1GSY6vbmzHBVIX85lAK3hNk1OAOsIxljEBDT
         DeBD6XltWHKZG1UT9WSOijzmBrI3NvfNhMbbTLpz71PDZPMrCV5HznUajB0rbCYeFw7k
         PQIfzbXTIE2NtjzDzz4ns9bzmhEJtgGfGTh/jkH+H1IZ1I5iPTJkn0qRuOskFVp5DSYD
         pnclyEgCyiaoRclHyy6MFS1GJWZVBhT5Yo4HmJ9YJ1sb2+BZJyXYzAnU2sUUtQ3Bk0ph
         cwePK6hLbGi65SZXBX0bJslJaul8ihoGg4bIfhJ1CVAAEl70iyQRfasotJgeizzGUB/u
         7NOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cdWC0h0QHi8RFQ3p74TfS0t0enTCy3o7nc/JZUtC7o0=;
        fh=r0v4eiH4C1wx7fILRJ3GtluAz9+xeDBJNToeJoLzLBM=;
        b=kZB3uLBWNGYKX+51miwB7tuHET8rDShYywXEo+pL4R7wPdxBfKYHnooyGKjs/2K6JZ
         wGSmPuPZwmRX/K7WUV9nWbEgwX8rrT2MDfsRS2lydofuKjHfdRJI9YxhkYlj3ylFs87K
         0Xv7WC+imFT+KN9C0pkqBLCBT5J43GYTA9LtRRUv/Wvt3R7+7wFhh6oT0fyPyoXhavag
         S/iZ+NKUn15WQpDDTWLH+2oLvp+ayGudxiRLIiFHF7roh+wjBzhqkvuo142pwWWOmfSR
         3/kGs2uZwbJm16XpGQUBDxN92EcJXTQTxSUJPSqY57BKiO7TU1OhuOQmU/lZxkD0YXk5
         QPhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783693150; x=1784297950; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cdWC0h0QHi8RFQ3p74TfS0t0enTCy3o7nc/JZUtC7o0=;
        b=R3QM94YYbU6tZ3oa8UE1dZgubGaEOivyywd9oyz3ecwwBhMU/0vRNs0NJn4lg/p4Lu
         VjPlkKoUlrhZ7xwlx681zM0YxiepSdSGEknsB+FBOF3LJ1QZyRcFB1REboZ706GIYAzb
         wlpkyy4xClp4F2EKN8EQHDb/LPgGG14TPUVJ2H2sJ9D5b8/GBbLknTmOneqOnYem/DtQ
         UbQQz5+g9aDM8WtSyJ7u/reEuOWgj9kjmMGdjIGDFgvROfSI7shpRL9q8hni0LSCNSov
         GJfDCztzGITCo1XyMwLiIPeQX1UEdYUBs/YSdefV84PrEGe6vbLYnP8MCpSws40IdPu2
         bnkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783693150; x=1784297950;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cdWC0h0QHi8RFQ3p74TfS0t0enTCy3o7nc/JZUtC7o0=;
        b=A/jPpVTA9eGrY/hwmGKr4XcnjYvnwQQitgVnByLI8klEI6VexH8w1L8FxBBkmYzcIY
         g4z0sPlSZQb8ewL0xSbXLiMZgdxEbDWUKT50MoSqsLA+xW/Xi3Js1B/zcrhwRVadl3nm
         LHzaNQ/qS2NNEYs8bihJPumXlSOcs72wJhdqgogH4WtadHrWocwD1iMopTn5ifn6+O2C
         ZKnrWrfU9IdvKYy8AR79GyXJTUsTriUwBiMUnPjn8rA5gJ+NT+0drzQ5g7X6uEwBRp1W
         c0yWZpBFcOwoJIZKKuQXmNkHxP2rHEWchLXT/mXgHDw1SrKRn0y0o7Gi8xlYa7YnrYuo
         biGg==
X-Gm-Message-State: AOJu0Yy8HxDmzZcMh65fHBMaajryxs5NraHyk3Ck+CM7JmAwWEquf7en
	mgm9qTDFOKj/rZAh8Uwv3l9/wtVaNUuEJUnllnLQGsT/jYZZbD5bgThw4KCpZLJjaMkMobUQR5Q
	4bnqckexCkmfRS/DwmNbJnXLrKkaiEPY=
X-Gm-Gg: AfdE7cmFbUQrLohTq8wJSY/nTUskwoqXFTjPfaQery6YluVbwpceYftaB/9hE2BIRvX
	XYbCWLBW+9IP6oKEWX3y727oKFrYc4hAicJvUyKtKsfsxlMPthvr2TwlvMBu6w7ahZ82vV+z3fu
	QN3wqeEM4i3H6RLzoHCD69yDdHJ7pNVoLszj35NRrBGh1XQ357yz+GNOp02HnT7QnVOFkiu6v0c
	FHXWArf/2L+dELKuPuINo/HzdBhZjSubIDJNAKgaPAqvxxI4YPo2/SeUJx4H+emjksFhuSHrNo1
	ca8+Vh2+8KDvGoK+mynhmwiBybMfBvdkPznLn7H5zAstfWgCjpyrldHJzYg=
X-Received: by 2002:a05:690e:1347:b0:667:b898:4d84 with SMTP id
 956f58d0204a3-667b89851e3mr4959398d50.28.1783693145210; Fri, 10 Jul 2026
 07:19:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710072817.270328-1-mikhail.v.gavrilov@gmail.com>
In-Reply-To: <20260710072817.270328-1-mikhail.v.gavrilov@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 10 Jul 2026 10:18:54 -0400
X-Gm-Features: AVVi8CcSKwYTO7hjTUqpDsRV6obfWEZ0pi0hz5Gy3TL6wcogZGh7FgBnqDKKWMU
Message-ID: <CABBYNZLCu3hKsf-N8xTaFtUDGOMJTL+bOgppppe5WyhdRkxbdw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] a2dp: Fix loading of remote SEP from cache
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mikhail,

On Fri, Jul 10, 2026 at 3:28=E2=80=AFAM Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> Commit 912f5efb0dd9 ("a2dp: Fix handling of codec capability storage")
> added an 'i >=3D 2' condition to the loop that parses the stored codec
> capabilities. Since i starts at 0 the loop body never runs, i stays 0,
> and the subsequent 'if (i !=3D size)' check discards every endpoint found
> in the cache:
>
>   load_remote_sep() Unable to load LastUsed: rseid 6 not found
>
> With no remote SEP loaded, avdtp_discover() can no longer take the
> cached path and issues AVDTP Discover/Get All Capabilities on every
> reconnect, and a2dp_setup_remote_path() returns NULL so the transport
> ends up at /org/bluez/hciX/dev_YY/fd0 instead of .../sepN/fd0.
>
> The condition was presumably meant to bound the writes into data[128],
> which the original commit did not actually fix: caps is read with
> '%512s' so size / 2 can be up to 256. Validate size up front instead.
>
> Fixes: 912f5efb0dd9 ("a2dp: Fix handling of codec capability storage")
> ---
>
> Reproduced on Fedora Rawhide with bluez-5.87-2.fc45 and a pair of
> Denon PerL Pro TWS earbuds. Without cached remote SEPs the earbuds'
> incoming AVDTP Set Configuration races with the discovery bluetoothd
> now has to perform, the stream never leaves CONFIGURED, and any client
> opening the sink stalls. Fixed with this patch.
>
>  profiles/audio/a2dp.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
> index c8adc3122..a4ba1dacf 100644
> --- a/profiles/audio/a2dp.c
> +++ b/profiles/audio/a2dp.c
> @@ -2398,7 +2398,16 @@ static void load_remote_sep(struct a2dp_channel *c=
han, GKeyFile *key_file,
>                         delay_reporting =3D false;
>                 }
>
> -               for (i =3D 0, size =3D strlen(caps); i < size && i >=3D 2=
; i +=3D 2) {

Would it be simpler to just fix it with size >=3D 2?

> +               size =3D strlen(caps);
> +
> +               g_free(value);
> +
> +               if (size % 2 || size / 2 > (int) sizeof(data)) {
> +                       warn("Unable to load Endpoint: seid %u", rseid);
> +                       continue;
> +               }

Or is this just to warn the system that the endpoint cache is broken
or something?

> +               for (i =3D 0; i < size; i +=3D 2) {
>                         uint8_t *tmp =3D data + i / 2;
>
>                         if (sscanf(caps + i, "%02hhx", tmp) !=3D 1) {
> @@ -2407,8 +2416,6 @@ static void load_remote_sep(struct a2dp_channel *ch=
an, GKeyFile *key_file,
>                         }
>                 }
>
> -               g_free(value);
> -
>                 if (i !=3D size)
>                         continue;
>
> --
> 2.55.0
>
>


--=20
Luiz Augusto von Dentz
