Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4F23A1A43
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 12:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776430594; cv=none; b=iBeP6uRswcEfVvJorF30Fdf8N5f9S+gNh4fEH84UVUivl8X7yfIauygiO1AFDB9dseNUTKzH6YhNtz/tYaL4IMaJlDQccQbAQMvTsj/V3r74QmflqG6O1WQxBMoLHzf7cz37dCOGZs+3YQk2OIOKI+Y+oWesSCN/zkj+pU0nOz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776430594; c=relaxed/simple;
	bh=Q8NsFEG9ZbxpVev0FTO8qLeWdg9a7p4e0wi67qPhdss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uBvnoug54oylCwVpK2P6arwdeuhhTtR6g6YoOFIOqdKU8YjdBE2naOgEeU5qtdrM9MJ56DOdLC/SpFXltJ+bv4pQ+KuHCSMwOqdzS3sidCJByyXXo3f9qn4JovtQ5myF+KXERQM21QrLGV2SU5Dj1KX/8TM+YzPjK26iZStw/mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7dbd2a0211bso495768a34.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 05:56:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776430592; x=1777035392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cQ7E0BVCzrZ39XOhVCVYNxv43US7LndGBNHCx5jFIzc=;
        b=eiSggkePP3+ZrD7/XI7pJBbvzWROi10YWVDtgqqYSQirODKSedu/4qLAv/ZXzzxlr6
         nmWpz5Y8APPl5jlkaCEzPN70+pHmwftDIOh13Mwxlo7e4RY9Lhe012QDni+03cul6ByX
         pGXV+jRMun4dk9Wdh0eHZcD41FdhCP+8US413HvXyYaGoDFN01JSzT99SVQrgI20n1iy
         c237WXxWBv+eQT5Xxef20lu2maSSFtlhzRV0jkSkdb8j0pOJhj+jsCekn7fLsQF0PRwi
         RE5nP9b68ZSPDNb2Rd6VHISrCgojkBccuXtxoP2ufFOwhu1EwGxL90qrsho0u8c+yRck
         jgiA==
X-Gm-Message-State: AOJu0YxmTaLhNYrez4JcXvxPaavpMyZr+kn44eWkZsJEZT7weZmGWXL9
	pL7Rulo6lNbRxO4wdxyVB5HJuZfQlJppwyu/YShmYwYUqRwCei+yKYOIdahb8A==
X-Gm-Gg: AeBDieufhWsOvUchgDYZQeqEqZMnoN7w9uNZtMiukBEOf/z6rhy9H3WkDU+KkLCEPAw
	jPTPuUV5TJ2R94KkuZERjdGUf7LmS+DoawnniLuHSOm6fidKyUzYbkUGbxP+q9Z57+v6KaA6lIo
	koywn+pUtFV7OOszFN+V6rXrC69vOIA2cmcAMbRjDJpchkABBMasa+f/xjrhMjhwpYSloSdA+6R
	6Z0aBIrnpcuhyz1UHvME0R8je1CYqi4vW/p+aCOUPtS9lqlI2CyuZBvcYkUxtbGU4qrjq9N4PFS
	jdkdim3RDiuGp1IIOxtP5JJ1oCMM720dxrT+NNXafDdkYa4tLrsYvPkRLOZQbEtxkgzx6K9yVtC
	/7hNEMC5eeytHH1r2ASuaZ+5ajhmY/MoM+NA9XGtXk6qTTb2NXLIUEPUQa0/lRNZ8t3Juh9Rf+6
	GWbHniaXTRk5GJSY/0uj3LkdEGfnQkbDH1dbIs64zWPFrPK6ba4cIovurateRoF4REygVOiWun5
	/ucWldI3gJHpCgm5AObgPj+4eAYCzi1xRZH8ARs6/c3cAb1XvAyi0B1T5ZRBkFw2Emr+yCQYw38
	BkLVdVoM
X-Received: by 2002:a05:6820:178a:b0:67e:331c:9ac4 with SMTP id 006d021491bc7-69462e74ac5mr1389565eaf.23.1776430592089;
        Fri, 17 Apr 2026 05:56:32 -0700 (PDT)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com. [209.85.210.45])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69464ea14ddsm882725eaf.6.2026.04.17.05.56.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2026 05:56:31 -0700 (PDT)
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7d4be94eeacso590277a34.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 05:56:31 -0700 (PDT)
X-Received: by 2002:a05:6830:368b:b0:7d7:d2e4:630a with SMTP id
 46e09a7af769-7dc951c7534mr1574853a34.14.1776430590793; Fri, 17 Apr 2026
 05:56:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260417104639.2608008-1-tristmd@gmail.com>
In-Reply-To: <20260417104639.2608008-1-tristmd@gmail.com>
From: Neal Gompa <neal@gompa.dev>
Date: Fri, 17 Apr 2026 08:55:53 -0400
X-Gmail-Original-Message-ID: <CAEg-Je_X1bfKwE44PJdgbHHZtHVy8bt1gotWsqkAWsS5s=_irQ@mail.gmail.com>
X-Gm-Features: AQROBzCi0gDy3D7m8PPBy3zcjwXiwPzD0sMHzUSSerDbzRMjjnlKfNBi1eGHZ2M
Message-ID: <CAEg-Je_X1bfKwE44PJdgbHHZtHVy8bt1gotWsqkAWsS5s=_irQ@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: hci_bcm4377: validate firmware event length
 in completion ring
To: Tristan Madani <tristmd@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	sven@svenpeter.dev, marcan@marcan.st, asahi@lists.linux.dev, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 17, 2026 at 6:49=E2=80=AFAM Tristan Madani <tristmd@gmail.com> =
wrote:
>
> From: Tristan Madani <tristan@talencesecurity.com>
>
> The firmware-controlled entry->len is used as the memcpy size for inline
> payload data without bounds checking when the PAYLOAD_MAPPED flag is not
> set. This causes out-of-bounds reads from the completion ring DMA memory
> for the HCI_D2H and SCO_D2H transfer rings.
>
> Add a length validation against the completion ring payload_size.
>
> Fixes: 8a06127602de ("Bluetooth: hci_bcm4377: Add new driver for BCM4377 =
PCIe boards")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---
>  drivers/bluetooth/hci_bcm4377.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/bluetooth/hci_bcm4377.c b/drivers/bluetooth/hci_bcm4=
377.c
> index 925d0a635..5d2f594c2 100644
> --- a/drivers/bluetooth/hci_bcm4377.c
> +++ b/drivers/bluetooth/hci_bcm4377.c
> @@ -755,6 +755,13 @@ static void bcm4377_handle_completion(struct bcm4377=
_data *bcm4377,
>         msg_id =3D le16_to_cpu(entry->msg_id);
>         transfer_ring =3D le16_to_cpu(entry->ring_id);
>
> +       if (data_len > ring->payload_size) {
> +               dev_warn(&bcm4377->pdev->dev,
> +                        "event data len %zu exceeds payload size %zu for=
 ring %d\n",
> +                        data_len, ring->payload_size, ring->ring_id);
> +               return;
> +       }
> +
>         if ((ring->transfer_rings & BIT(transfer_ring)) =3D=3D 0) {
>                 dev_warn(
>                         &bcm4377->pdev->dev,
> --
> 2.47.3
>
>

Seems sensible enough.

Reviewed-by: Neal Gompa <neal@gompa.dev>


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
