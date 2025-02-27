Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B193154BF0;
	Thu, 27 Feb 2025 15:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740668508; cv=none; b=JDTd4iwxaMoiLKjbWpBa4bDgWRTnTAzw98e2XlA/oW0SZGbRNn36fQAQ3bgQhFOqZmh8Sp2jIHgXKqp7zvLsyIjdQUmOyE19Gx5C2bGYfZ8cBxkzv0tOuDEz7W+iJS9ArRrv3PO4GP68ESbpMNmf8nZBahrGfpGm6l/u5cMZbfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740668508; c=relaxed/simple;
	bh=MpNFNYvFbpMRQ0dNsCFuJrisGGKznXaF3ybQ0yuB6iU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FYtJjSo2SQIGVALRDaSEqpCmXdXbHKElflzbug9a1sWcl/2k/+w07U7FCHcwkmy+uQ185pHVzjopIKKFzmP8LsfBVFzMfXn/xdmej3GqHSKCAmcHdSyx3JhlisanoAtmps1BxJ5/dJqaEE0NzUodTKjr/QnCuDnAK49dls98Nco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Omzr/tjM; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Omzr/tjM"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-307c13298eeso13250011fa.0;
        Thu, 27 Feb 2025 07:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740668504; x=1741273304; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qFG5Y5fsjKl2zvRQ9VBEmXYBmDmudyN0YtOflmIP4OY=;
        b=Omzr/tjMfEXzgWnrKrkcTPNzcx1mwBIkNsvWkgm6EFS2O83GnTmbf/zEOOL5INWuma
         WpiC3DMP0Xw0s8B43MOGkU1ftalSiJKaeVY31bqGsDYtELa+rvfCP7JpRxvLzfdVaeJc
         TGMD4fdVDhE5kqE4EqsWMUc4f+klR3nM5fLmr8Fwah6/2Ce9CxKa0RCw5CYHONEQzi4a
         fU4+UnXsQDqWHrfhiwXR7UReJvlCtGTlRYnKxUo6CD9qYm3bSTCIgjnKmI8AFiXGuk7o
         gKpSRKTjVVgNAoZ7aO88nOj1tgL8Kn4cSAhOlR4wIloIYX56LoQMP6fdX9rLo7JRHKqB
         EKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740668504; x=1741273304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qFG5Y5fsjKl2zvRQ9VBEmXYBmDmudyN0YtOflmIP4OY=;
        b=SQT3n/yftmRjrmP7h1exfROTFohJdKnQKX6qwACGyjIJZAweSjHESVkvpixRZTwH/n
         BAnFGaavVq6ryRvLhP1WbI3SXNYkVrH836tNL+bwoDPO1k9k7Dq9C65VXVKh4EG9TQXj
         KbaVkbC56dJSAzQuh+hMPeZ5Wl9UY4NCMTdh89Rfy3Tci09zdZBQ9+EUbslMZJKNJf17
         Zdvx1BXbre00HG/MBEU5TWpzAAwE0fFKTVnfN4dEgvC4chbj9s5Bg5NVRoNDFSRH2drf
         pinualTWn3lySJnDtVZF0JEPFL2Y088TOq8ic5cRgBahykwfojoslBbPXICnJ/NHgLo0
         HinQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTzsim8kwQv0sjBhIHnPTNWLmrwQPBbLpgpbFMBhcykxJczgFmT+D3YViT/d7M62SK9kv5n9og5DTDF0oudbQ=@vger.kernel.org, AJvYcCXxWnkMuF8/TdX1j66L69mALYAKXdKDS4RsXEKZjTuQcHtIfK17iWMyq5UYAfuDlFm7jrORVyQo2lMNJxlj@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3VLTPf8R1xWDb4U9/ULzlmi//HImI8b7zaiOeOmcv5vhtsQ1V
	wFG3dzP8fE1a6bGJdBo00vLi7PlZjfzYXArsfAtfBMpD0sXVdG/qH5Sx7ODBgBbQul1yuxfoJJ0
	wh3eCca/FIjmmGxhyLe76L1Xn+HE=
X-Gm-Gg: ASbGnctx+nJlppR29cIcnXGmBy1qv2xf8dNqGw261l5+RGs8ZTf6BHlqcCFf4+WOSDC
	cQUdkM3IHnrzyD1exO/R14vm/dggGYguXl/CQPwzDp2Yr+/RJCcGxabUfjFSa879WrHkT6i3eeh
	kI3NPXqg==
X-Google-Smtp-Source: AGHT+IHatpsMbgwoNVwaLM9LkHVMcCjPk3Np1qRZkSm2cC2JnV7lxUJIwAdE84ICXIcwrpm5DRTH7s0/xqmqqw6APRc=
X-Received: by 2002:a2e:7c14:0:b0:30a:cb8:6de7 with SMTP id
 38308e7fff4ca-30b8463c53emr12774361fa.1.1740668502479; Thu, 27 Feb 2025
 07:01:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227132132.1171583-1-arnd@kernel.org>
In-Reply-To: <20250227132132.1171583-1-arnd@kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 27 Feb 2025 20:01:29 +0500
X-Gm-Features: AQ5f1JoTB21tqACyTRfjho0CRnXS0OMjktLV3uqtibDJbBobunvn6NYRnOkT22o
Message-ID: <CABBYNZL5s1xipGg7Ft7Cgccp6X81ae_jhQ9ETyh9T9ap9siaRQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btintel_pcie: fix 32-bit warning
To: Arnd Bergmann <arnd@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Kiran K <kiran.k@intel.com>, 
	Vijay Satija <vijay.satija@intel.com>, Arnd Bergmann <arnd@arndb.de>, 
	Devegowda Chandrashekar <chandrashekar.devegowda@intel.com>, Tedd Ho-Jeong An <tedd.an@intel.com>, 
	Philipp Stanner <pstanner@redhat.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

On Thu, Feb 27, 2025 at 8:21=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The open-coded upper_32_bits() produces a warning when building
> for 32-bit targets:
>
> drivers/bluetooth/btintel_pcie.c: In function 'btintel_pcie_setup_dbgc':
> drivers/bluetooth/btintel_pcie.c:142:72: error: right shift count >=3D wi=
dth of type [-Werror=3Dshift-count-overflow]
>   142 |                 db_frag.bufs[i].buf_addr_msb =3D (u32)((buf->data=
_p_addr >> 32) & 0xffffffff);
>       |                                                                  =
      ^~
>
> Use the provided upper/lower helpers instead.
>
> Fixes: 3104ae5ad1b7 ("Bluetooth: btintel_pcie: Setup buffers for firmware=
 traces")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/bluetooth/btintel_pcie.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel=
_pcie.c
> index cecb926bce1c..e8307eeb971f 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -138,8 +138,8 @@ static int btintel_pcie_setup_dbgc(struct btintel_pci=
e_data *data)
>                 buf =3D &data->dbgc.bufs[i];
>                 buf->data_p_addr =3D data->dbgc.buf_p_addr + i * BTINTEL_=
PCIE_DBGC_BUFFER_SIZE;
>                 buf->data =3D data->dbgc.buf_v_addr + i * BTINTEL_PCIE_DB=
GC_BUFFER_SIZE;
> -               db_frag.bufs[i].buf_addr_lsb =3D (u32)(buf->data_p_addr &=
 0xffffffff);
> -               db_frag.bufs[i].buf_addr_msb =3D (u32)((buf->data_p_addr =
>> 32) & 0xffffffff);
> +               db_frag.bufs[i].buf_addr_lsb =3D lower_32_bits(buf->data_=
p_addr);
> +               db_frag.bufs[i].buf_addr_msb =3D upper_32_bits(buf->data_=
p_addr);

Great, I was going to ask Kiran to fix these, btw we might just amend
the original change but I will keep your Signed-off-by.

>                 db_frag.bufs[i].buf_size =3D BTINTEL_PCIE_DBGC_BUFFER_SIZ=
E;
>         }
>
> --
> 2.39.5
>


--=20
Luiz Augusto von Dentz
