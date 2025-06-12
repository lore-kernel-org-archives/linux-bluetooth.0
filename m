Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADB62356CF
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Jun 2025 12:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749733000; cv=none; b=eZKd/5BpiYnSSL8iwlwiRt5Q83QecDg7+zuVyflsxrj/fcYKn0OmjU6Jq1SPdyEXmqCj7XorSvUDXbtrMxelG0hsOtW8Hyl3sWeK7x8mIbdpelaO0u/S7Xkh1jF/tQA7F6+5BfwgvvJwYZ8kdvz/06L8ZVV0EAWgmgj9P7J6+4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749733000; c=relaxed/simple;
	bh=2f7+W0hy9UTc4rIBHc0BeIZ8PfUCNDLO9J9zm9BlxC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bNFBv+0eLYl+svSQ7pMRgTGx+1lD9T0mmtpYRpvSAQXOXhebfDWlsOLGS93smwaeuGLRWWxYZH/StzQH2G4QdiveJ9eZt8nJI9gUl3OHqI/t3JNPrbI9bFRRKwc1PtJizxs+ASBKH0KA5w255YNrMlRnx4V2zrymy2QkDP98PN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KmOGs+8q; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KmOGs+8q"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-552206ac67aso841103e87.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Jun 2025 05:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749732993; x=1750337793; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y8gDjlnvYQL8K+z7FT+uPF9z0sOdB5N3CbytPyoT8po=;
        b=KmOGs+8qIEaRhfzw56YjgPHQGUKmARMtA4l1i2Mb3y8jzMvWg/MZvZzV7NUfxRtyVS
         rzbH+Rr41bhUGSlvH7POJCi5GLmUEfJhUkMl5GlOepu+WCHIoC9F+ZuVCrtSQOKkey9H
         SQUbAr49h8gXaic4Gy0kpTl0JPJDjfZxtUz4SoNO+htYpcjCNw2OjBPhqAcAgLa2treA
         p9JC4nATsEQBM7UCnVaPQxUL0XhMMRyp3ol1stCE6pz64Zem21GVrNcyz7FOFRcU9rMz
         UUb/8TONAU6wlL/BbdKK1xMIGoPuAssFfC4t2vMH51iSUdPkKbiVPDaV4TE7bnBTw2TS
         aDlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749732993; x=1750337793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y8gDjlnvYQL8K+z7FT+uPF9z0sOdB5N3CbytPyoT8po=;
        b=AXOQ2td0L0OrEtWCiY1KSXclV8TNw0hPewekHkyacAvWy6GLkuBZJK9mqPm8NdgqRl
         2HzM5ljGKiPwEGEgwqjneNLesPa/DK9dqlgNQpo+JDjK37UtPWFD+K5tp5tddd3znw2V
         xlrdV8qSt2LGrF312dCrFDQKeSIGTZZ3YGcjYdfyxiZdoyANi0+0jUolFvkfHhA8icDl
         SsbLLxI0NX0QEZrqGWdgHoIgTUwgTSnKiP23Ba9CyW09wkYHn71D6qHmJ/ShH/+RFX5r
         i9OInRhe7Pd6JchZX8T89klfyWZVnTYx7i2ycbdUeNJQO8PvZIJGKKeou3TSgoW9dp2J
         42Dg==
X-Gm-Message-State: AOJu0Yz3FS1GweauzLShSAVHQrwf5FnFEM0vrGtZlJXMD1n1ZT0u9G3h
	EOobJYKoyXEh4a/GWWvWlkPQ2DCe0X4vB97Zu292yKrJ6EWKlDJGUhp3oR+HW9lK4gMw9+GFFA4
	iy3sGN7dzJKAWGuuYoMTimVCNBO+kwxxm4JFG
X-Gm-Gg: ASbGncsM02tHPZadrAUZwS1Wj0GcVcKsShFRO3bkOMWvAJG2j8MWhZDy7r4rpIHGjnu
	wOAoEtfNxhMkg0HQLgUeh2AtGhHU60Mr2Wjhj8XylPcMgz1KsAFGWF36aacB/5X0jrpD1wOcwQA
	zwbzhYDofnwWA8zBIhakcdhvAl5T5woVIGVoqQHAZMJQ==
X-Google-Smtp-Source: AGHT+IG9wiQwb9DCTN2e7noQjhrLeyNKRccz0OQQ0VJ2dQuTYrNBfpcCjsgZJHht6GBiXDNw4UknNI029PCmA9EdthI=
X-Received: by 2002:a05:6512:1052:b0:553:34d6:d67d with SMTP id
 2adb3069b0e04-553a55ff9d8mr907222e87.46.1749732992957; Thu, 12 Jun 2025
 05:56:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609105538.4090716-1-quic_shuaz@quicinc.com>
In-Reply-To: <20250609105538.4090716-1-quic_shuaz@quicinc.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 12 Jun 2025 08:56:20 -0400
X-Gm-Features: AX0GCFuCo__0qk2QHIqEmcT9ZYPo8vR-lGQZML0qsnLK8gX7Yg28E9HzVRO3emY
Message-ID: <CABBYNZLQ9y09-F045U15orG6j7WzcU4ov0=s0xxGGnmC7tR0Tw@mail.gmail.com>
Subject: Re: [PATCH v1] driver: bluetooth: hci_qca: Disable auto_off when
 BT_EN is pulled up by hw
To: Shuai Zhang <quic_shuaz@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org, quic_bt@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shuai,

On Mon, Jun 9, 2025 at 7:00=E2=80=AFAM Shuai Zhang <quic_shuaz@quicinc.com>=
 wrote:
>
> If the BT SoC BT_EN is controlled by hardware, disable the AUTO_OFF
> feature. Otherwise, BT will close the HCI layer except for the UART
> after firmware download. However, the SoC remains active. If the SoC
> sends a packet to the Host after firmware download, the Host cannot
> respond since the HCI layer is closed, which will cause the firmware
> to enter an incorrect state.
>
> Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
> ---
>  drivers/bluetooth/hci_qca.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index a2dc39c00..0cb70a3cf 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -2483,6 +2483,15 @@ static int qca_serdev_probe(struct serdev_device *=
serdev)
>                 set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
>                 hdev->shutdown =3D qca_power_off;
>         }
> +       /* If the BT SoC BT_EN is controlled by hardware, disable the AUT=
O_OFF
> +        * feature. Otherwise, BT will close the HCI layer except for
> +        * the UART after firmware download. However, the SoC remains act=
ive.
> +        * If the SoC sends a packet to the Host after firmware download,
> +        * the Host cannot respond since the HCI layer is closed, which w=
ill
> +        * cause the firmware to enter an incorrect state.
> +        */
> +       else
> +               hci_dev_clear_flag(hdev, HCI_AUTO_OFF);

This sounds like a bug imo, the driver shouldn't be messing up with
HCI_AUTO_OFF, if the packet mentioned above is required as part of the
setup stage then it shall be handled via setup callback otherwise the
stack will consider the setup as completed and proceed with auto off,
etc.

>         if (data) {
>                 /* Wideband speech support must be set per driver since i=
t can't
> --
> 2.34.1
>
>


--=20
Luiz Augusto von Dentz
