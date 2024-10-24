Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CEE1D63D8;
	Thu, 24 Oct 2024 14:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729781256; cv=none; b=YxCMetHAHzixcDe9nXovAXX+wIFMHqEzv3hWZZ4eQE7LC+lG04kgqTKV71Qj6tCJJsmP4Jf4jVN6rG4thX41VyoRWjjpMX/QIk0ZOEUOe279ODEXf3qGDkgG/qSYGDyZP7+jfNoJ5Y6ilB0fAtd0TqHtvVDa0sEVA9dO32CJDKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729781256; c=relaxed/simple;
	bh=/wUrcsMJVoooubxWmLRAaXefBHzQh8V+SDPSaLoqxdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CLelId0D+p5/ogaCYSafuwvuBPufIe5PWAZo8RMagspaUn4TRHTJdgXooFhYDqHqRNvLzWmmGsuCPXGceqNUzlVg7ZomvkE3yqJQJU/OdhtnMCKs+I5cKkrlVSoqZDqFR9nLSi2whrBPdHYomR1FSkVjyevPAKULrtClPEyakY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vm7oT4CQ; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vm7oT4CQ"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2fb584a8f81so9930531fa.3;
        Thu, 24 Oct 2024 07:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729781252; x=1730386052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ObLFhkfilDgkeJ8S/DOzsvtKeCP3rongHSO0w7aoSKI=;
        b=Vm7oT4CQrdbpMDVujGySCgPWjjPudOz4nFNtKnqA175UcBWA+Gs3eNaDa73S4U+0TI
         uj4AxIY1lLCKevkOd37v8mk9ciSJdqVvRxX2dUgVLTPk6gIidGbB8PGUSTB3LU4dj/wf
         ljQCGKkC0EY+4rVfQH2jr09st39QOrtV48U+CbNij+syfXXI86laeI4oimSwrGPFyvqh
         lGHiOvXqkiR7QBBvNBPjOCViEeK1RItC5UHU0uGHWt9Usr/2Pdhvryr9PueaZgbNa6X7
         Qj4rvrnsjzT2EqJdlb/ImYqe7whHdAe93o8zC4NqWxjcctHWESHfScMengstTK3AxWEr
         7QKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729781252; x=1730386052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ObLFhkfilDgkeJ8S/DOzsvtKeCP3rongHSO0w7aoSKI=;
        b=SE83p3UFJkpt/FCDZ6oc586QDa7pg/peWBjLAFrOU8K60ju2goWAU2rkDxkjZQcpr5
         bLmegwS1MqrP0g8iabJlUZQqxi2GuR6no7/KanRndg+eAqzt2BGpI6eeVT2DNvEnYK4H
         LpQNtjflQ4stRnF6EA1+XqFobI0wcDvuPmvvSpTtOByZAb2MD6Uat0Wbe8hOz7Xg57Qk
         b1aXL5EVfJD+au/vozQ5l4cZ0ounRFW+8UhtcPiwKtzA8wV7sC979r9faqy/5dXjfuko
         HK8+oMfvVsVmbdqI99K5lSnzk0iP8l3E3dYYVmtK95sVAAZQZ127f1V82QEDY1b9Og1F
         HC1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUutcZumFeb49jlm1TENYUiM11IUhNjxRho+sfhNg25UhLAae6/YMSMICTqxhlVtP2G0HLwvX7uegLQ0A+8@vger.kernel.org, AJvYcCWxeNzOZ7/CaZQu8RgpX/yaSfr/5PEOat8pneqQLe0TtwUOOszSrx1JcUlnWLfV67OagB83dchHyDrgP0lmoWc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+bsCYtPM+8dXZvn8wuAaS03DpwA/dwHzXyZITg+/PxfjHC2gP
	SLa8wblhsSrEx4VPQTelS1568M9FpO6doeGgccHGFhQ176bHs7sYs2qsYNZV92thZ7ZAuxY4yEh
	0G8o7PfQ1kDzrS0gqmGDxwE8u8s8=
X-Google-Smtp-Source: AGHT+IEhbTehtHKBddJu+7LbhCF86DQkzEp93FtdZ2l7+F3VCRGEUWQWdfUNYvEcj3Aq130BBZJzRw2RGRA3wyZ/KUI=
X-Received: by 2002:a2e:4609:0:b0:2fb:6198:d230 with SMTP id
 38308e7fff4ca-2fca8201182mr11805571fa.18.1729781251392; Thu, 24 Oct 2024
 07:47:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023113626.12236-1-chris.lu@mediatek.com>
In-Reply-To: <20241023113626.12236-1-chris.lu@mediatek.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 24 Oct 2024 10:47:17 -0400
Message-ID: <CABBYNZLpMCTy8z8ObEU90gqenb58VoB2EZKbZJfWK_J=h45Qew@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: btmtk: adjust the position to init iso data anchor
To: Chris Lu <chris.lu@mediatek.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Sean Wang <sean.wang@mediatek.com>, Aaron Hou <aaron.hou@mediatek.com>, 
	Steve Lee <steve.lee@mediatek.com>, linux-bluetooth <linux-bluetooth@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-mediatek <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chris,

On Wed, Oct 23, 2024 at 7:37=E2=80=AFAM Chris Lu <chris.lu@mediatek.com> wr=
ote:
>
> MediaTek iso data anchor init should be move to where MediaTek
> claims iso data interface.
> If there is an unexpected usb disconnect during setup flow,
> it will cause a NULL pointer crash issue when releasing iso
> anchor since the anchor wan't been init yet. Adjust the position
> to do iso data anchor init.
>
> Signed-off-by: Chris Lu <chris.lu@mediatek.com>

Please add the backtrace or a Link tag if there is an issue/bug open.
Also it is important to always include a Fixes tag with tha hash that
introduced the problem, specially in case of a crash since it might be
a good idea to backport to fix.

> ---
>  drivers/bluetooth/btmtk.c | 1 -
>  drivers/bluetooth/btusb.c | 2 ++
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
> index b7fc14aafc74..8a3f7c3fcfec 100644
> --- a/drivers/bluetooth/btmtk.c
> +++ b/drivers/bluetooth/btmtk.c
> @@ -1215,7 +1215,6 @@ static int btmtk_usb_isointf_init(struct hci_dev *h=
dev)
>         struct sk_buff *skb;
>         int err;
>
> -       init_usb_anchor(&btmtk_data->isopkt_anchor);
>         spin_lock_init(&btmtk_data->isorxlock);
>
>         __set_mtk_intr_interface(hdev);
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 9970470c9d15..15c0885c37cd 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -2628,6 +2628,8 @@ static void btusb_mtk_claim_iso_intf(struct btusb_d=
ata *data)
>         struct btmtk_data *btmtk_data =3D hci_get_priv(data->hdev);
>         int err;
>
> +       init_usb_anchor(&btmtk_data->isopkt_anchor);
> +
>         err =3D usb_driver_claim_interface(&btusb_driver,
>                                          btmtk_data->isopkt_intf, data);
>         if (err < 0) {
> --
> 2.18.0
>


--=20
Luiz Augusto von Dentz
