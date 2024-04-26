Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F0716F0CD
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Apr 2024 17:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714152217; cv=none; b=lEj+Uk6IVrcguQeFrm7AKZ6ADUDM1DwXla6KtMCPJRyQXNF6ZyrIT6/8ZKJ4XT5qWppVeYD1vwelduLz5gr7EbCv4ANHMR5vZ1ucM/xBmd4DUtcR/gbY/tNJwswO6FIVNHt4lkAVG97UGmgiwqg1ywfUNxk65exHx+TE+NWDilg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714152217; c=relaxed/simple;
	bh=DoeVH595qsmuQPIQOHZlMJzQnEWVUckuQY6sXPiNVxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cxtv/r8ww5qZhkP4CiAtxbt9yItf8Opb8h95fG+WK2ArvP0f5zB/aDVrTkY9BCVd6hNxdYx3AsPB329JhllF2D5bjOtPVAOgNMgGKp/GOiGpRvlpYpgdR5Ts681m92K2MG7DMeqArxYs7dpeGkrz+XfJwUhIa3C0we4dMTuQKDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fBqviliE; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fBqviliE"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-69b4454e2f1so11618006d6.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Apr 2024 10:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714152213; x=1714757013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BgXARGPALUa9HNkXZ7dJ4KGZjVGqNQ8BWrBEfj+sA+g=;
        b=fBqviliE2ur33q/zidQcPI+y1dcba0ss4jaVUAICPGmx0exFlJPLayfwsBtXJQstGP
         NgYLusF4EYISkZ1FmUpuVA/wVeTqhN0y9WSw2BUT/xsRaQEKrN7Lz1D02oEVM5eP6gae
         G09MM7bmqQjoFgVWSrcLsI8rTWTx0WZaAbvLQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714152213; x=1714757013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BgXARGPALUa9HNkXZ7dJ4KGZjVGqNQ8BWrBEfj+sA+g=;
        b=X1LVATq4GRhNnB3CGdXGvfOq5H05UrFBPH5Bmv5NiyEYnFw87oTMHLmk10qBzdbJkF
         YuydeVzRxOxOvrqYk9Hh9h6ofxiefXp20X5Mhp9bbMFelmTBH0u8xOkA43ii3v0mf9a0
         Lc9Y57VoxuMBNyyTkWzg94TyV3JY1iRkpAr10gDk/RCJjMEVD/HIaIrzd7LXD2o8Iuva
         3dwxuHI8fQ2mmy9MU9zF5/tm58F2S1lVMZxskmI2295caSaykpTIcVPMWP8dgXUkwOjh
         Vdz9c/9Nael3N4ST5Eqe1o2OoFot4nSakfDQX0jV7Lspsd/Z9ltn9xmXbs5dGrAkpVOK
         e3mw==
X-Forwarded-Encrypted: i=1; AJvYcCUFkGjjHgzG1uDzE/eWc4Iu2cxfPFlCiiset6VQMGEKTA0TCMYpag9IiJllndlkfK9I+IkhgC098dwJJTjRNIkdVN6OGMSmFaq60zoUXP7Q
X-Gm-Message-State: AOJu0YzNFR73JekwX21AajQtxuat9C9w+4QmJZ34am6XkrhtEKn44xaw
	G/05I+iGzvXDFk9xSMAEuNahQJOPDVFOJc2AXPUNiuFboVIH1BSH6vWUbHEVzA1d3wRGTtJ7aEs
	=
X-Google-Smtp-Source: AGHT+IFIFUkTfutsNpYhaFeP0Slo7elj+bN5VIdif6xj81eUtsp1himE4bAQflQMWlB/EAjxxV/+fA==
X-Received: by 2002:ad4:5d6a:0:b0:69b:3a49:106f with SMTP id fn10-20020ad45d6a000000b0069b3a49106fmr5501378qvb.15.1714152212955;
        Fri, 26 Apr 2024 10:23:32 -0700 (PDT)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com. [209.85.160.177])
        by smtp.gmail.com with ESMTPSA id w17-20020a056214013100b0069b57111a98sm7155829qvs.79.2024.04.26.10.23.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Apr 2024 10:23:31 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-439b1c72676so24641cf.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Apr 2024 10:23:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVbgQnDtF4TtlzPNTziOP3H8+jRuyoDag0K7tAkWE/R7OjHEwP4+fNwqf7hcmbpkTHf4arvbHGG//Ta95JSQFlNpb+eJze3pGES5chhcfS1
X-Received: by 2002:ac8:7493:0:b0:439:891f:bbd2 with SMTP id
 v19-20020ac87493000000b00439891fbbd2mr373509qtq.28.1714152211256; Fri, 26 Apr
 2024 10:23:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426155801.25277-1-johan+linaro@kernel.org>
In-Reply-To: <20240426155801.25277-1-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 26 Apr 2024 10:23:15 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V-pG9+5fLonNvydmjS=ziUFUHAyF8T7YTkEHiO405aSA@mail.gmail.com>
Message-ID: <CAD=FV=V-pG9+5fLonNvydmjS=ziUFUHAyF8T7YTkEHiO405aSA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: qca: generalise device address check
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 26, 2024 at 9:00=E2=80=AFAM Johan Hovold <johan+linaro@kernel.o=
rg> wrote:
>
> The default device address apparently comes from the NVM configuration
> file and can differ quite a bit.
>
> Store the default address when parsing the configuration file and use it
> to determine whether the controller has been provisioned with an
> address.
>
> This makes sure that devices without a unique address start as
> unconfigured unless a valid address has been provided in the devicetree.
>
> Fixes: 00567f70051a ("Bluetooth: qca: fix invalid device address check")
> Cc: stable@vger.kernel.org      # 6.5
> Cc: Doug Anderson <dianders@chromium.org>
> Cc: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/bluetooth/btqca.c | 21 ++++++++++++---------
>  drivers/bluetooth/btqca.h |  2 ++
>  2 files changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> index cfa71708397b..d7a6738e4691 100644
> --- a/drivers/bluetooth/btqca.c
> +++ b/drivers/bluetooth/btqca.c
> @@ -15,9 +15,6 @@
>
>  #define VERSION "0.1"
>
> -#define QCA_BDADDR_DEFAULT (&(bdaddr_t) {{ 0xad, 0x5a, 0x00, 0x00, 0x00,=
 0x00 }})
> -#define QCA_BDADDR_WCN3991 (&(bdaddr_t) {{ 0xad, 0x5a, 0x00, 0x00, 0x98,=
 0x39 }})
> -
>  int qca_read_soc_version(struct hci_dev *hdev, struct qca_btsoc_version =
*ver,
>                          enum qca_btsoc_type soc_type)
>  {
> @@ -351,6 +348,11 @@ static void qca_tlv_check_data(struct hci_dev *hdev,
>
>                         /* Update NVM tags as needed */
>                         switch (tag_id) {
> +                       case EDL_TAG_ID_BD_ADDR:
> +                               if (tag_len !=3D sizeof(bdaddr_t))
> +                                       break;
> +                               memcpy(&config->bdaddr, tlv_nvm->data, si=
zeof(bdaddr_t));
> +                               break;
>                         case EDL_TAG_ID_HCI:

nit: blank line after "break" ?

Also note that on my firmware I never see this tag and thus your patch
breaks trogdor. Specifically I put a printout here and it never gets
hit.

I printed all the tags/lengths:

[   17.961087] DOUG: id 0xde02, len 0x0010
[   17.965081] DOUG: id 0x0000, len 0x0000
[   17.969050] DOUG: id 0x0000, len 0x0011
[   17.973025] DOUG: id 0x0000, len 0x0a00
[   17.976991] DOUG: id 0x0303, len 0x0303
[   17.981066] DOUG: id 0x0033, len 0x1001

Probably EDL_TAG_ID_BD_ADDR should have been 0xde02, not just 2.
...but then the size is wrong? When I print out the bytes in ID 0xde02
I see the address you're looking for 4 bytes in...

[   17.663602] DOUG: 0x00
[   17.666132] DOUG: 0x00
[   17.668638] DOUG: 0x00
[   17.671237] DOUG: 0x00
[   17.673689] DOUG: 0xad
[   17.676120] DOUG: 0x5a
[   17.678551] DOUG: 0x00
[   17.680980] DOUG: 0x00
[   17.683409] DOUG: 0x98
[   17.685846] DOUG: 0x39
[   17.688278] DOUG: 0x08
[   17.690704] DOUG: 0x00
[   17.693137] DOUG: 0x08
[   17.693139] DOUG: 0x00
[   17.693139] DOUG: 0x00
[   17.693140] DOUG: 0x00


> @@ -624,6 +626,9 @@ static int qca_check_bdaddr(struct hci_dev *hdev)
>         if (bacmp(&hdev->public_addr, BDADDR_ANY))
>                 return 0;
>
> +       if (!bacmp(&config->bdaddr, BDADDR_ANY))
> +               return 0;

The above test feels non-obvious enough to deserve a comment. Could
you add one? That would also help alleviate my confusion since I
_think_ your if test is unneeded and maybe wrong? Let's say that the
firmware didn't have a default address stored in it. It still seems
like we could try to read the address and then if the firmware gave
back BDADDR_ANY (0) we should set the `HCI_QUIRK_USE_BDADDR_PROPERTY`
property, right?
