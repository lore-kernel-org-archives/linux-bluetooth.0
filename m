Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24346402BBA
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Mar 2026 15:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774364816; cv=pass; b=DMOdnfGH45hI2rkZiQW4f8a+Iy8FK0GgmsSsyCw12oNHjEoRQWqTOXBPLb2Lgi4rWHUsyzQFPPiJkQ0inmqL62R/v20BugDH4A+LmMYiJHMJPMOAsw7B3n0/4ZnBAQHeajEwHewgm9Z77FCsUrJCQ3mV1YTTiG6fiv35qXndazg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774364816; c=relaxed/simple;
	bh=NaD7W/0+/AzDjzU/YomN7iJVaisIpYn4PnL1wKtQJr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CaZ6KaxDYxDijALRGOgo6vlkzEjvMtk1ZzYpYY9K58anUapDXUP3NQa9giS3CVXRQIGUirJaChjLrlXNqonfHzGKJeIzhIg9z0cYm/RnTp0KOG+fATFwycwV1g7amUvmknRDZPJEGBzuCbDFRIAK8n1XLUQS4A8UgvwSN4mONU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rR+tXm6y; arc=pass smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rR+tXm6y"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-46702742c99so907970b6e.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Mar 2026 08:06:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774364813; cv=none;
        d=google.com; s=arc-20240605;
        b=GiuisF77l4hYBSXgE1nkqPWFSi+zqxaFQyDUVJJhdxZwRYLDtrWioPVi71rxvQ+Cbo
         1Wg753NQfdC8GfR2kDVQ6EXGq5Q4lze22mDF9jRsPKoqT4/ET59tpmKDwK4Ns0UDY+Gk
         1c39FXNYpzwqtPIDbdhLMW6aw4S3XmhWHuWWlr+vl3J4YK/kRzKnwsHKfA51ImD/nM/A
         DfHMBR+SNnTU2PVRopEeUfhEmySFcQC7EWZswokHyYRTKsaCjGJ8nPGHAT9AthRPaI4F
         jFKgxjcnK2RXZBV0Uq4gqxGPrCpymOBEKTzHlvR+il0pVnV/4RP/U0wKSw7xxEZyKKHI
         sxyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h35MYrusxiN2Jc9fAg2QnigGOyjGG2azumkiw02qMJI=;
        fh=nQS1Y1LpCgGLoSAAB+cFxhw5pFu1ryg2CrahOLv++aU=;
        b=ii7Cj/FbPy4dY38LdE9PaFb79N0RN466hUP6aNYPJTC5Ww0YYHsKYOP9+2UzA6eUok
         LSxcu3NV1hFTglSW8F4T97X3tWsIyuQkHoSbs8ksjIgiWd5vtk3F5CIFdWg+AdFaZ24E
         1b1YircifV0NsTiYzaDVhgy6M2ux/NNZaE6IjVjwD+NjETQwYnvfJ54XBWDDOEooy5en
         G/N/oWn1kqvwvjD1OLXnnDi94mkEanvdArITN6MlTOLDbzCRkn7ay6ddDiR4wHrfbvy3
         qzH/M59diF+LT4BmLok+vmRuLTAeOYiVj6NxHA6jjBDiTlTZ6oOoniphtWqGtmAEtqim
         w2rQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774364813; x=1774969613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h35MYrusxiN2Jc9fAg2QnigGOyjGG2azumkiw02qMJI=;
        b=rR+tXm6y6iCgE0Vjkthvf1r6zNd7xd8Eyi1UFu77fJe38f7NACpyUwdhmectg5vqiq
         mAxzMNTtzGqndRI2C8SsDjqz55JdpBNerqGUaychw5dnoiff56XDDInjMk69poXEveF/
         OtKQ7heTbw3S4G4Nn+39hL6BRazlvbx//ZrO6KheZYWUQxJ9afASW9KO18QTn+K4/xml
         heYNmAP1q7q0rL96h1mmrDdnl6y0YrODEx8WiFnZ2MvHUYpizej/vJ84mr1Ed0Cv5juW
         AYJgxwjZgbgbJAbdDNAhNIuHe5e3fP3K7Woz/gV1lAtXZSzuzBRsN3vu/lWfPKIPAfc3
         YCHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774364813; x=1774969613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h35MYrusxiN2Jc9fAg2QnigGOyjGG2azumkiw02qMJI=;
        b=ThTNlDtIu/s/XUVYJ6iR7VRhkz+dIWVDBgSA3PvN2pzd9LkBEJAjfJhBRSrrcAdacX
         b9/ABBRAxLM5h8q7yfP1/zP16AY/EeafmLNTvA9EDzX8dfTnBYK7ey7dw7duJlqRfZ6e
         mmXjVfgSc6oQ9rOjMsdloF1I05o8BQ+pvGq0j3qXoZR89Cehri5M1rL1DwFJuSOZursG
         HxSsGYNmNIltBMidpjJs8CqtAKpoLGsmUQ58g8Zq5EBfmVnRPCYG9nZYhoN2Io6CRvp/
         1VaTk0asZOegv/AbBofueXTGPXjLR5tulMZx1jISZ9HkLXcBa4icpg3hEcSsbvxot3QU
         dipw==
X-Forwarded-Encrypted: i=1; AJvYcCXQr386AqlqUfrOpnT3/eVzUv4ZL9IQOWbV1MxdtfecPR3AE0zrWhmIt2FNrCU6QOektmepkOl7cditwtCX5aY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX5pqevilDrafcEmvZbTHgN1WpQbeW8J3RmmrrNoS0agusqOeT
	c5UK38/3sGmIQpvMoAij4XPqCmxHhz+1fAzghShP6BctmFw2EZkqNOTmREP6VqbMMjFr3GY0Jrp
	bIdqW2UBR8qfDjs3WjFCEVH+IRnhkNJk=
X-Gm-Gg: ATEYQzxg8Z9ejUOIJHgJ9zWPevuriil9/05mT571wYfprEOamQNIh7C8Dprms/ZibUT
	JGGK1Ot9nBqZbT6lJGNuwBDXSxcTY6Myd+NxdtZgEWynW4Al832BBaChzCxsmEVS0J0y+HrY+qB
	r9qn64RgCy61AoKIzw0TZf4tL8WRzkLDypkcCBf0uzlJfGWgM/FGrNLxUB1KLTKa8eBVscOsSce
	rs+zB0z0zDoT9t/zwiVY+gMtQ0UCUYfeQYNqEUVq28NpWlol9AXL3eAwkrQj5gDpn6XX9Ji86dF
	wWNpYSiIvYrl2bseQVA8lyplamvJ2SQ+xntJN+QXH6GgcSbfwcYH5v4noZqfL/09uN8=
X-Received: by 2002:a05:6808:2222:b0:467:5571:1b0a with SMTP id
 5614622812f47-467e5ded2admr10127904b6e.26.1774364812967; Tue, 24 Mar 2026
 08:06:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SYBPR01MB7881B5254647551279894DCDAF48A@SYBPR01MB7881.ausprd01.prod.outlook.com>
In-Reply-To: <SYBPR01MB7881B5254647551279894DCDAF48A@SYBPR01MB7881.ausprd01.prod.outlook.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 24 Mar 2026 11:06:41 -0400
X-Gm-Features: AQROBzAxx1Dwwwx89HNgrvwdudAStUv3q7i0ZyWK39fM8C86JX9g0AfOCSmbYD8
Message-ID: <CABBYNZ+Mo-UWu3Z-rg2JMzEbU=GXB3bizVcGqyJnkUfkJabAAg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btintel_pcie: fix off-by-one in RX queue
 bounds check
To: Junrui Luo <moonafterrain@outlook.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Tedd Ho-Jeong An <tedd.an@intel.com>, Kiran K <kiran.k@intel.com>, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi @Kiran K

On Tue, Mar 24, 2026 at 9:27=E2=80=AFAM Junrui Luo <moonafterrain@outlook.c=
om> wrote:
>
> btintel_pcie_submit_rx() reads frbd_index and validates it against
> rxq->count. Since rxq->frbds[] and rxq->bufs[] are allocated with
> rxq->count entries, valid indices are 0 to rxq->count - 1. The current
> check uses > instead of >=3D, allowing frbd_index =3D=3D rxq->count throu=
gh.
>
> This causes an out-of-bounds access in btintel_pcie_prepare_rx() when
> writing to rxq->bufs[frbd_index] and rxq->frbds[frbd_index].
>
> Fix by using >=3D so that frbd_index =3D=3D rxq->count is correctly rejec=
ted.
>
> Fixes: c2b636b3f788 ("Bluetooth: btintel_pcie: Add support for PCIe trans=
port")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
> ---
>  drivers/bluetooth/btintel_pcie.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel=
_pcie.c
> index 37b744e35bc4..cbadcfe86321 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -460,7 +460,7 @@ static int btintel_pcie_submit_rx(struct btintel_pcie=
_data *data)
>
>         frbd_index =3D data->ia.tr_hia[BTINTEL_PCIE_RXQ_NUM];
>
> -       if (frbd_index > rxq->count)
> +       if (frbd_index >=3D rxq->count)
>                 return -ERANGE;
>
>         /* Prepare for RX submit. It updates the FRBD with the address of=
 DMA
>
> ---
> base-commit: c369299895a591d96745d6492d4888259b004a9e
> change-id: 20260324-fixes-8c301e8881f0
>
> Best regards,
> --
> Junrui Luo <moonafterrain@outlook.com>

This one seems valid as well.

--=20
Luiz Augusto von Dentz
