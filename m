Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D801A0AFE
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Dec 2024 18:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734634768; cv=none; b=hhty+usmvEfogJarNWA8DXq7qArvyyBV7BREc2xu+5ddQCeld1yGmjVnv/51FKXH/jUZnZ1qfCvkFml0YVzmgeI2OuciEszuZir4bazwEmsmJDBA8hWekFclRU/knRrgsLk44QwH6qLcTiQICUrUTzBuDcDUqVftfwqvTxd+Fn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734634768; c=relaxed/simple;
	bh=QbH4lL5Wgb8JtRqzSPcCC/Tx+e1Rl7sCHWvvYP69duA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hDo/eN2mPOQIBBHpqtTBU575IBkd1DvaAOfkO/aHWNG5i+PsWbgU2cv0ix1NmGwY237ZOSA0vfz854h0L3Mst5/CT1Z+PRmFWy+Osw1MzhqHP+vO8TdKlVN+N2Sdb7p0hjW5osxAE5u5myPkxf9/4WNBlY6WSS1qZlg4IMs69p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i5yJQ1Fi; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5yJQ1Fi"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3003e203acaso11862991fa.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Dec 2024 10:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734634764; x=1735239564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sKf9OymRdeyOXICNgHL4hfs9o+CDWWbupK2CayDhNZk=;
        b=i5yJQ1Fi+bjqMew4XUxV2+EMzUqCQ7B/lHA2O6q08G7RqEc83kc8WkX7QonKv5QZqB
         NogQXYejonn/IU6bMZHTyrl3l9CASVx62AXMaV7WHkT8tegFqYTKRcGhUmXi+5Y/YWzP
         0IV6wLeyMnSIrNQpRzYcChgZXOz4jkEJwSA6fNucfQde9uaPvHhKjOIR6GFSGzMzQ4Ip
         N5dclJbPqZf9JMDJcSGH1Z3bCEAnFOvFMbM584dz326l09VjkdE80kKuqf/x8GUHdnc9
         njJuVU8/l7dIz8pqOv7qP8Avoy8Ya+CSAVIrFOKnyYlJ1PpYEmkP2ZbKHroxoB662o/M
         IMsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734634764; x=1735239564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sKf9OymRdeyOXICNgHL4hfs9o+CDWWbupK2CayDhNZk=;
        b=MnNB8aLeiAAlxELnbVxTPRy+6tDEDfrVS0KquiNdx6hIL22nL8LVc3qwSSGHiYReRr
         T+gCA4hkO/d+OCFn4Nip+2IWZ1WqYsMatabwVObXGa5qRRQPJbce2iQlfrU7UEtBCZ/S
         b0cX96YptORA1rY3ycVgcAKc0h4m9WfSyhwNMxnaz40CfvTmdcgRO87pBCNtqG5olb20
         kB5A3yhm4W2loHsrBIUL6wcNtPS/ATfHcpueyGpKfW6oK4wv3Vd1fVEN/N9ONDrOZlm5
         T/5NQYo+pYINWJYaPMp5nm4RGbksfyWljuJ+AjlTjiWo23/Ksl97yEhyKLdBegy8rBNI
         9BWA==
X-Gm-Message-State: AOJu0YwhEIENKpL30IrkBglfQgcV+cmyuTyXeMLaATnY4y6clEiTGtqJ
	08C4yyspk+PYx9VqziFd5SSStNGSpEJmgkpfjCk0x+r4ZPYKoQu82jZz7Sc3LLzgA9UbtbJeTpi
	Yz5UaHBxNCtYIsgSTYKqP1EZG7Og=
X-Gm-Gg: ASbGncv01Vy/wZol1G6O3cmcpuskNMNUFg80N2HjBTg8LeMSOEGHcmf1TYh5WlqiIBP
	l2+idp9MSrGIfN+/zSfiWMttvbjwqcQR5WoK+fvc=
X-Google-Smtp-Source: AGHT+IH4ZEXn145CNSbQxXexgHRgIy4h2Uuf0AEANcYpVCpoKWvA/OkbQL6TBjQ7j/jeO5XGTl/DsHiZV5bzgXNJbks=
X-Received: by 2002:a2e:bc26:0:b0:2ff:cfbb:c893 with SMTP id
 38308e7fff4ca-304685032femr616121fa.6.1734634764141; Thu, 19 Dec 2024
 10:59:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241219181140.423916-1-kieran.r.geary@gmail.com> <20241219181140.423916-2-kieran.r.geary@gmail.com>
In-Reply-To: <20241219181140.423916-2-kieran.r.geary@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 19 Dec 2024 13:59:11 -0500
Message-ID: <CABBYNZKSKtzo6=A75pO4McbpC=qVXhniY=P4yBqMJAOJfxboGw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/1] Set `SDP_LARGE_MTU` flag for DS4 Rev. 2 product code
To: Kieran Geary <kieran.r.geary@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kieran,

On Thu, Dec 19, 2024 at 1:13=E2=80=AFPM Kieran Geary <kieran.r.geary@gmail.=
com> wrote:
>
> ---
>  src/device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/src/device.c b/src/device.c
> index 2b3d19f55..4e5a5b945 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -6047,7 +6047,7 @@ static uint16_t get_sdp_flags(struct btd_device *de=
vice)
>          * results in SDP response being dropped by kernel. Workaround th=
is by
>          * forcing SDP code to use bigger MTU while connecting.
>          */
> -       if (vid =3D=3D 0x054c && pid =3D=3D 0x05c4)
> +       if (vid =3D=3D 0x054c && (pid =3D=3D 0x05c4 || pid =3D=3D 0x09cc)=
)
>                 return SDP_LARGE_MTU;
>
>         if (btd_adapter_ssp_enabled(device->adapter))
> --
> 2.47.1

Perhaps it would be a good idea to create a vid:pid table if there are
multiple devices being affected.

--=20
Luiz Augusto von Dentz
