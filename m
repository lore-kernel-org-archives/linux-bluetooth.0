Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4BA17B427;
	Fri, 20 Sep 2024 14:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726844108; cv=none; b=WqAEv0AvQ6YnA7HhFyPL4yh/O/XLMRZYEWZdzuZoqH8u33W+jF5+0bhMnbi2fPU5Wk36gol60XrtM4iz2EIm/rBBqHV+Xlm08+P1Df3Ph8l054vHGBbaehxEr84vLWiatlyQwe0BGc90HYI6clef1QDfkexmUmi4+ZDdbaCNSgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726844108; c=relaxed/simple;
	bh=RoJg69/sSksKDasmFyN/iEDFBNBh8oRsNnabyTCKEAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CpKbYNwAF8Dz7BH4uAT7wSx9MA0WB08AcoxLHjz7eJwua+tUQiP29b9tUEKfH23TTCRM0tbPnDbr7S6nivk5++NTQ954gmO+Fsp1VdOmfHsBVClPXmJLPNyCidzjaSkEdWTQKfVuliuYRY0EnfBZmDFc+xRCgHPZCpAO2Ho3A4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c8ozusu7; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8ozusu7"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f74e613a10so33832301fa.1;
        Fri, 20 Sep 2024 07:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726844105; x=1727448905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Urf9epkit9Wnq7mh+mMh5qFW8LtYH5Rj1D3J2QjXNes=;
        b=c8ozusu7AUZjY+phJYkaEg9cBuwDEWPwhdNqJVPyjX1BwStdpMa7j/tMmxU3xNR8IO
         W/DxGABXUHaIeeMTiXt3tYFCXWDbDePK3oIEyiOx3nUvLAjk2NgPwoWZz8EOkfDg+Lf7
         Ajg4rMH2Ya8J0ty2n0eLcnboz/KuvPn1wSuDBRmPUhAvpAU0XFA7K5HrhCVgFh7AM7E6
         bT8fL4SSLoVXuw3GeHqqbqnEA6PS/VQmvfh0zmORlcGlocMIfrtQGSvvQEtdRohmQrzf
         HR4LCSAQRvQSpwHXj1bAhi53bsUlA8oERTcYGCJnTJtFaDdzTy7HvslpWnBxj/YvLhG2
         rVyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726844105; x=1727448905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Urf9epkit9Wnq7mh+mMh5qFW8LtYH5Rj1D3J2QjXNes=;
        b=gOc9/F4+5ppdPzaj20OCEFLta0DdCsstUucjIZCyu41LFax7lNBZiJj2wpB2+8l+Xb
         QldQxHLJztHwPtZ/8EqZq9YoRPjSJSaYLuU9Isi7itnGkeWGJwRDger950SCFJM3MOCJ
         uZACzu7/N6uAZSDyTA+4nyU95orACLHLRnVWHAIPWI7N6nE/sRe0qJrwDP+pk7wltb1D
         LEHOLFIqGFwBzZNJV/9J6vwbcDoLISWGTZKKb9fhgneBPl+KXHZRUvmDKFfUhAed5o1M
         VTkxSTh33mO7hmd7vpveRrzSdqLVtrTipBCOAAV1Hfr9FWQPUewj9dXh3/uu05otE9Td
         T4pA==
X-Forwarded-Encrypted: i=1; AJvYcCVGvwxfvvKFTvGYlBV6byJONEKtWuVIlE2/VHDrrXHyQAMQp+Iuw6yhHaS6DsmXES4McSlYUj1mYA1JKmh0Kx4=@vger.kernel.org, AJvYcCXS4qcKSgH5T6jM3YXXy/4tvrIbAZSJ7cpDq/Y6DxBR9zJfsqEzxgerYslAGTAyXqoFMoORQclsCHbi/B9z@vger.kernel.org
X-Gm-Message-State: AOJu0YzjCAyb1hXkTE1mfoLbSRNIIJg1IOKQRVvmfz99eBMcNrOwzT1t
	sDEYDhb29dozuao6y/SEyL9QVhLr9SWnXQZk55BbpQQa/wjue5uldq6j9zdJsiuq5utle2WgaSq
	dTm/WPwQ2enHNrNFAVSWyHyhQlRg=
X-Google-Smtp-Source: AGHT+IGRMbJOtLIe11lU8+yttfrugpnh34xPWQlgkz2BjnvZmPECE9B5LY05OCCCUvgqw8AZro92Tf2rVv9ya4d944k=
X-Received: by 2002:a2e:a9a2:0:b0:2ef:1b1b:7f42 with SMTP id
 38308e7fff4ca-2f7cb367bf3mr29478471fa.36.1726844104528; Fri, 20 Sep 2024
 07:55:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240919074925.22860-1-chris.lu@mediatek.com> <20240919074925.22860-4-chris.lu@mediatek.com>
In-Reply-To: <20240919074925.22860-4-chris.lu@mediatek.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 20 Sep 2024 10:54:52 -0400
Message-ID: <CABBYNZJ62dw0JHTrNK7xe9_kO61_gH9+XGPm+UEWw4CGRVCnnQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] Bluetooth: btusb: mediatek: add intf release flow
 when usb disconnect
To: Chris Lu <chris.lu@mediatek.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Sean Wang <sean.wang@mediatek.com>, Aaron Hou <aaron.hou@mediatek.com>, 
	Steve Lee <steve.lee@mediatek.com>, linux-bluetooth <linux-bluetooth@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-mediatek <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chris,

On Thu, Sep 19, 2024 at 3:49=E2=80=AFAM Chris Lu <chris.lu@mediatek.com> wr=
ote:
>
> MediaTek claim an special usb intr interface for ISO data transmission.
> The interface need to be released before unregistering hci device when
> usb disconnect. Removing BT usb dongle without properly releasing the
> interface may cause Kernel panic while unregister hci device.
>
> Signed-off-by: Chris Lu <chris.lu@mediatek.com>
> ---
>  drivers/bluetooth/btusb.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index dfc42bdc8aaf..37e67b451b34 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -2614,9 +2614,9 @@ static void btusb_mtk_claim_iso_intf(struct btusb_d=
ata *data)
>         set_bit(BTMTK_ISOPKT_OVER_INTR, &btmtk_data->flags);
>  }
>
> -static void btusb_mtk_release_iso_intf(struct btusb_data *data)
> +static int btusb_mtk_release_iso_intf(struct hci_dev *hdev)
>  {
> -       struct btmtk_data *btmtk_data =3D hci_get_priv(data->hdev);
> +       struct btmtk_data *btmtk_data =3D hci_get_priv(hdev);
>
>         if (btmtk_data->isopkt_intf) {
>                 usb_kill_anchored_urbs(&btmtk_data->isopkt_anchor);
> @@ -2630,6 +2630,8 @@ static void btusb_mtk_release_iso_intf(struct btusb=
_data *data)
>         }
>
>         clear_bit(BTMTK_ISOPKT_OVER_INTR, &btmtk_data->flags);
> +
> +       return 0;
>  }
>
>  static int btusb_mtk_reset(struct hci_dev *hdev, void *rst_data)
> @@ -2649,7 +2651,7 @@ static int btusb_mtk_reset(struct hci_dev *hdev, vo=
id *rst_data)
>                 return err;
>
>         if (test_bit(BTMTK_ISOPKT_RUNNING, &btmtk_data->flags))
> -               btusb_mtk_release_iso_intf(data);
> +               btusb_mtk_release_iso_intf(hdev);

We can probably move the check for BTMTK_ISOPKT_RUNNING into
btusb_mtk_release_iso_intf to avoid having to duplicate it whenever
calling btusb_mtk_release_iso_intf.

>
>         btusb_stop_traffic(data);
>         usb_kill_anchored_urbs(&data->tx_anchor);
> @@ -2703,14 +2705,13 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
>
>  static int btusb_mtk_shutdown(struct hci_dev *hdev)
>  {
> -       struct btusb_data *data =3D hci_get_drvdata(hdev);
>         struct btmtk_data *btmtk_data =3D hci_get_priv(hdev);
>         int ret;
>
>         ret =3D btmtk_usb_shutdown(hdev);
>
>         if (test_bit(BTMTK_ISOPKT_RUNNING, &btmtk_data->flags))
> -               btusb_mtk_release_iso_intf(data);
> +               btusb_mtk_release_iso_intf(hdev);

Ditto.

>         return ret;
>  }
> @@ -3824,6 +3825,7 @@ static int btusb_probe(struct usb_interface *intf,
>                 data->recv_acl =3D btmtk_usb_recv_acl;
>                 data->suspend =3D btmtk_usb_suspend;
>                 data->resume =3D btmtk_usb_resume;
> +               data->disconnect =3D btusb_mtk_release_iso_intf;

I'd wrap (e.g. btmtk_usb_disconnect) the call to
btusb_mtk_release_iso_intf since that is only meant to release the ISO
endpoint.

>         }
>
>         if (id->driver_info & BTUSB_SWAVE) {
> --
> 2.18.0
>


--=20
Luiz Augusto von Dentz
