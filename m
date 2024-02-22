Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD173548E4
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Feb 2024 19:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708630034; cv=none; b=KtEEaN5bS1i5keueusFY4z3d4imuM0OHslBKVAPHhWcC6Uf2exhyGCHLpjInuFBFrzjJBCAPDQZ+2+nU4AoMwGbIPxpDKWP1nBNPJTY9rfN5zGTKcFKFlQCs56JFfPa986xODokQbDMeUUdKnjJSo3d7CIWqrgOYO7VUzrw7C68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708630034; c=relaxed/simple;
	bh=1LSpzVFxEkje/D2DXJOE0ThAUSQ8omcZg6hxBaUHBOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m/7VPIMvICkgm3/D1Rw0cwYb4EWWA6E0nWMs55XdUcs3g0pvpgDeI+vlJnN5pIjHGvo1CDScjFo5O1adebcym1CofowuuisfUhEnma26wB/9yiP+IY8UCsADf+un3UMPsvxZqMEPO+Bf0T+44UwLpbL9Zd/Hdv2RnbJQzBDL7bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=unkZ1JQE; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="unkZ1JQE"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-4cc13005119so22954e0c.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Feb 2024 11:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708630031; x=1709234831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MnZQ2Np0LMvJsVvmVZVBPdaruP0xPu3oyHszd2uFf4s=;
        b=unkZ1JQE2si7bOryfcGEUbIz+gsvQVn3MmGS0KuVOXvA1UgWOUoXJ+hVCKeJNQ0Peo
         //N4knhW4Hy3eMUqbbxvEajhewAKKIk00utZxv3JX4SeFm3c5tWzXDwrbkx8JqUXw0qm
         OOsGEN5HgxTT8jjew4pFKXLClEOp4knc0fCG/oBOOHPSE655RPoaRSYqI376qJvGYCpd
         8w03DhoYHMqNkHIDOSy5Yol+lkHxzUGj9pQ5YSonjeWuFtT++Kql/rlQedkVsUOtJ5Rk
         MKZMB6sXcyrVTaosoMC/DkFiuD1vmvi4/9BQ0iOabUnzhJLWgexeLf6uAYSdIknyMGJO
         QmfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708630031; x=1709234831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MnZQ2Np0LMvJsVvmVZVBPdaruP0xPu3oyHszd2uFf4s=;
        b=V1LYnna9fTBXoNv/rd44SjW2t1vd/5d6gfGup/GZFfgUMvEtDcxTMF8omvQaU5/em3
         8N9konY3Yj+6Q97RBTkZZ1+IjiLTbNdyyX2YbqNSAF9N4AN+pkrubhyNsd4/Gfjtyd+0
         yHOHZMXG1V3ebYXiy6AjXd6O2lLhL87YJdWgWF5yX+KkyC1JBL5X9aTMYVsAAjyvjfFF
         /wBF9G5780p1EXT5KvCMl8MxQ2jz8X4usceRF1li8bt3EoH5FrC85b0pugDwbGCkpIam
         qoyRDk6r7jfaRQLV/MeIFS1F9TDWv0cgycXftZanSoPoRRpzWFG5kxr3pJM8/HJw+Qvf
         Wi6g==
X-Gm-Message-State: AOJu0YxlTs/7YolQHsH6PNieXDqhkJ5wjEABoOPUAhYAOsYE1nKbDmHv
	IAlsFl1Yn3aKEKKJSBP5m/SoybBqh3yjxdbfYcnfTFNWYDPF4Q4WVwNnzHdko9iMmTTXbkh7ixg
	Vkjjvz3cdo339jmoQ3CRTYie2q34ayn3glwLQRA==
X-Google-Smtp-Source: AGHT+IGCfLmnerJ2kbWWTwiyuUUE+iAaJee9A08f/LkoUSya+GJWWO4i5dtXri24iTfUKAaN2TuLG1Lg1Pk/5ZGe6uY=
X-Received: by 2002:a1f:e681:0:b0:4cb:2662:3656 with SMTP id
 d123-20020a1fe681000000b004cb26623656mr10217vkh.0.1708630031526; Thu, 22 Feb
 2024 11:27:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208164017.26699-1-brgl@bgdev.pl>
In-Reply-To: <20240208164017.26699-1-brgl@bgdev.pl>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 22 Feb 2024 20:27:00 +0100
Message-ID: <CAMRc=Mcme2PZ7K4K2ZXdgDvzauFvzaRrQQ+-=ua7CykxrwjHCQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_qca: don't use IS_ERR_OR_NULL() with gpiod_get_optional()
To: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Miaoqian Lin <linmq006@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 5:40=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> The optional variants for the gpiod_get() family of functions return NULL
> if the GPIO in question is not associated with this device. They return
> ERR_PTR() on any other error. NULL descriptors are graciously handled by
> GPIOLIB and can be safely passed to any of the GPIO consumer interfaces
> as they will return 0 and act as if the function succeeded. If one is
> using the optional variant, then there's no point in checking for NULL.
>
> Fixes: 6845667146a2 ("Bluetooth: hci_qca: Fix NULL vs IS_ERR_OR_NULL chec=
k in qca_serdev_probe")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/bluetooth/hci_qca.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index edd2a81b4d5e..8a60ad7acd70 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -2326,7 +2326,7 @@ static int qca_serdev_probe(struct serdev_device *s=
erdev)
>
>                 qcadev->bt_en =3D devm_gpiod_get_optional(&serdev->dev, "=
enable",
>                                                GPIOD_OUT_LOW);
> -               if (IS_ERR_OR_NULL(qcadev->bt_en) &&
> +               if (IS_ERR(qcadev->bt_en) &&
>                     (data->soc_type =3D=3D QCA_WCN6750 ||
>                      data->soc_type =3D=3D QCA_WCN6855)) {
>                         dev_err(&serdev->dev, "failed to acquire BT_EN gp=
io\n");
> @@ -2335,7 +2335,7 @@ static int qca_serdev_probe(struct serdev_device *s=
erdev)
>
>                 qcadev->sw_ctrl =3D devm_gpiod_get_optional(&serdev->dev,=
 "swctrl",
>                                                GPIOD_IN);
> -               if (IS_ERR_OR_NULL(qcadev->sw_ctrl) &&
> +               if (IS_ERR(qcadev->sw_ctrl) &&
>                     (data->soc_type =3D=3D QCA_WCN6750 ||
>                      data->soc_type =3D=3D QCA_WCN6855 ||
>                      data->soc_type =3D=3D QCA_WCN7850))
> @@ -2357,7 +2357,7 @@ static int qca_serdev_probe(struct serdev_device *s=
erdev)
>         default:
>                 qcadev->bt_en =3D devm_gpiod_get_optional(&serdev->dev, "=
enable",
>                                                GPIOD_OUT_LOW);
> -               if (IS_ERR_OR_NULL(qcadev->bt_en)) {
> +               if (IS_ERR(qcadev->bt_en)) {
>                         dev_warn(&serdev->dev, "failed to acquire enable =
gpio\n");
>                         power_ctrl_enabled =3D false;
>                 }
> --
> 2.40.1
>

Gentle ping.

Bartosz
