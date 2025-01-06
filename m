Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C877F7081E;
	Mon,  6 Jan 2025 20:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736196258; cv=none; b=e2vLdmVIB+ltbpspwhnFPJtTtt0yDB9uxI3oC9PaM5SS5LjL/sf/U0ZI6lW2HoHv1Xd0zs6AEEt2dAxpzOYAmXzfp1KwpQEYQDleqLqxsOYAF3n8/xXWOO0QKBga2w9Ny+3jUrfddQjhJosP80WBEME6Couypr24x/IEVOPoSos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736196258; c=relaxed/simple;
	bh=HbuFNQYgJiSjg28qszDlFY2e0ynUmwPG6T9938IemQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hpz//WRXpLGJoECHgw0LTMkas3tbwJdvMKYG0AN2T0Ofy9Ef3n29NPkuAUwLo9dVL/GyIhapATWrA790H5e2UCWT1OMEopKwanuBDw9ntOm+aMOege8NDlJW+LwO9MaaDyz9yV6SkHltaFBYVg4NLNDjvI2G5wuTxfVkjBVwjos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KROnHaDZ; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KROnHaDZ"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-300479ca5c6so151604751fa.3;
        Mon, 06 Jan 2025 12:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736196255; x=1736801055; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=np4AwC2TG2aANO3tq1hKZ8t1XEyTiu7VAIhJj+aPhl4=;
        b=KROnHaDZtw7zZfFWoljWpEQhr8Q3UCAs/ei5xPnDaJb932tZL1l6iWEi2Rq73SSngQ
         tAsFOeomPWXizY0Bp9nzEmmuPrFCFp5xJI9LOhfLDO+yR1ow2OXjXerRe+fBYY5dDzTh
         QHcJ9RQ9dQZJucfGSaIAgeKjXodTRqX86KsnVcjJf631gKx/xK8Gl54zC7tzYDcG0d0G
         SVxdAT8E6MhZtNS+hJJ90XdtQor0agd/gGxkhLU3Dw0B1269VhcLcHGCv0zELZoINLPH
         swROykmYN/DPxdYFzQTyM1WEZYK25BxcpDA5jm/KPYsKEbRB24HHZV6v5vDAvjq7l8gS
         fmrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736196255; x=1736801055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=np4AwC2TG2aANO3tq1hKZ8t1XEyTiu7VAIhJj+aPhl4=;
        b=seAjm8+/QtMBF+BRsizFR55WBS1Wfd82n/e4LWw0LkQcSNaoCPA8BWdvAlmb7BAfMC
         hYXfCKi2sO0bcWj+ndPLkc9NAq7k1UC79mnQtraKn2w6xcv6WThL+giynJhahN7EatTe
         Ar4JfSra94Y/ZQ66S+FZj7KOWEx/f0sn3c/mZ8JW6IF1nut2U/HOGlVuaXdUCB1s+D3B
         QOrOsxdcuM+WabsSkuAyvhdtpdBgNlc1ccKX/sJHo9CSdIdwXlV/FNKx6A5Memts/gyT
         kPhlMggIUxLVVMMsRwlojJkxVTr12ihN3mOxBimJPOA02ENE49jczUXfAoZKDkuv0mrU
         hS8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVE5FAXaApiHwPPGbeL0+tPOmjgN0cO+wSe0p3l3Vumrp3e24JPQ77OWSyj84JODrjR+Q/TrgaNmSxSdlWd@vger.kernel.org, AJvYcCXZ/haD9t57XGS9E9SkIWKaXlltB3CRO/H+qaq3QPeLAmPINOamo3eqkMuLBaorWCjG2kicwlD0I7vt2c1Rrdg=@vger.kernel.org
X-Gm-Message-State: AOJu0YylVXojRKRhXtzArTzdQ6mOKX+EVc7kxs2Ci1pyFMtpjNiWW2eX
	rN8rk7Gxp630ezyyBXIgWBuPLA555PY+l7ze5s0TLgi53JjZ/BmqL2Y8PbvgAYJQIZpli4RuPok
	qNQHuQb/ZTtg5XbxVe1B6jGCAvfU=
X-Gm-Gg: ASbGncs33sLBLJxOTBOCIwpAU0KvsTy5evE33mZ/bRDqYxvT5IvkJtjYNtY6XyXKVIC
	0gmKW4GelM/K1rS0qwC1JBWcE6UvMDUsE/6ORFec=
X-Google-Smtp-Source: AGHT+IGkYZlQg/yqsRPPg9FkH6/8PxzQuROlITJwodFva38BJJMwG50n8RqMSHpEAyC7kyvAhTepS3DNAW8b69FGyds=
X-Received: by 2002:a2e:be06:0:b0:302:4147:6d21 with SMTP id
 38308e7fff4ca-30468552157mr156651621fa.4.1736196254731; Mon, 06 Jan 2025
 12:44:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241223085818.722707-1-chris.lu@mediatek.com>
In-Reply-To: <20241223085818.722707-1-chris.lu@mediatek.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 6 Jan 2025 15:44:02 -0500
Message-ID: <CABBYNZJOEi_=vLiivGFt7tKiq8TMn9YG=FkC20y-6M75Bi8vYg@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: btmtk: Fix failed to send func ctrl for
 MediaTek devices.
To: Chris Lu <chris.lu@mediatek.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Sean Wang <sean.wang@mediatek.com>, Aaron Hou <aaron.hou@mediatek.com>, 
	Steve Lee <steve.lee@mediatek.com>, linux-bluetooth <linux-bluetooth@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-mediatek <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chris,

On Mon, Dec 23, 2024 at 3:58=E2=80=AFAM Chris Lu <chris.lu@mediatek.com> wr=
ote:
>
> Use usb_autopm_get_interface() and usb_autopm_put_interface()
> in btmtk_usb_shutdown(), it could send func ctrl after enabling
> autosuspend.
>
> Bluetooth: btusb_mtk_hci_wmt_sync() hci0: Execution of wmt command
>            timed out
> Bluetooth: btusb_mtk_shutdown() hci0: Failed to send wmt func ctrl
>            (-110)
>
> Signed-off-by: Chris Lu <chris.lu@mediatek.com>

Missing Fixes tag, Ive been adding it myself for some time now but you
better create the practice to include it so I don't have to go find
what commit introduced btmtk_usb_shutdown to then do git log -1
--pretty=3Dfixes and git commit --amend.

> ---
>  drivers/bluetooth/btmtk.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
> index 7fd9d5ddce02..224eafc27dbe 100644
> --- a/drivers/bluetooth/btmtk.c
> +++ b/drivers/bluetooth/btmtk.c
> @@ -1472,10 +1472,15 @@ EXPORT_SYMBOL_GPL(btmtk_usb_setup);
>
>  int btmtk_usb_shutdown(struct hci_dev *hdev)
>  {
> +       struct btmtk_data *data =3D hci_get_priv(hdev);
>         struct btmtk_hci_wmt_params wmt_params;
>         u8 param =3D 0;
>         int err;
>
> +       err =3D usb_autopm_get_interface(data->intf);
> +       if (err < 0)
> +               return err;
> +
>         /* Disable the device */
>         wmt_params.op =3D BTMTK_WMT_FUNC_CTRL;
>         wmt_params.flag =3D 0;
> @@ -1486,9 +1491,11 @@ int btmtk_usb_shutdown(struct hci_dev *hdev)
>         err =3D btmtk_usb_hci_wmt_sync(hdev, &wmt_params);
>         if (err < 0) {
>                 bt_dev_err(hdev, "Failed to send wmt func ctrl (%d)", err=
);
> +               usb_autopm_put_interface(data->intf);
>                 return err;
>         }
>
> +       usb_autopm_put_interface(data->intf);
>         return 0;
>  }
>  EXPORT_SYMBOL_GPL(btmtk_usb_shutdown);
> --
> 2.45.2
>


--=20
Luiz Augusto von Dentz
