Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC54813A25B;
	Wed, 25 Sep 2024 15:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727276610; cv=none; b=mAFu/672Xkv4ndQ2b+kRP4DHCRViLdzcqn3FfgXiMJ09F+ykC2kxuhXH3lV0zCczyMVpx1ZbzbeV5JT1+gZGLaMa5y1zLocOOORlCeICJHh0rSmr/S72b94nbkNNQb3bp3hUnz3PAsByI0jUw6mxzjEn+FALEqC+N38uyRPfsjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727276610; c=relaxed/simple;
	bh=zfQYIeSmrGqAr1oLOpgHPFXklc1HHrWmeccH5tTTESs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RGdmru8FhRSA8OLxuroMEOI63coMcVniI9iJUPZZi7L6gdmLjdTApV36UJecjZQQsPBUuuXb4i2SLLKjz7eTfUzwS3S2qmfGGRDrA8qVUqUJL03LsvNGX+if9mm7InCD8n4eKy7RlCujZ+ySYPiuQfzs+dGT/q2CLukIVFeX7Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HRriJeOp; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRriJeOp"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f7528f4658so60422431fa.3;
        Wed, 25 Sep 2024 08:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727276606; x=1727881406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WyPp28NYrJbi33YU5dd0/uz1wt5cUJUmG1p8KF+fEHg=;
        b=HRriJeOpGzGfZJWEGoAUcVTrCkEfB1padaJYyIRsOHNn97UXqiA1AupP4BPhhwxYji
         H4+umPJKI+MOqksxD52yPlzhHHkO6WTIYRwJrt88GtkXrwgjVqx6g8eHqL9wpi42yj9m
         8Mjvx6LVD0Z0fngeePMdj2/oidFyNAn9w4D3m3+pWz3d9K79NH0xhiVhKHCgdpn+TWIs
         xkzSMqh84j6rNdOU1s6tt3sauQE4QtAm0uZ9dck/daudDO7tYj2MikxVjSloYZjuVWCM
         O/3PhmdAaPIdbV4wSkXpoM63GbPSMW/t6hli8vwUBA50c83GytwK3pjHQX0CM2xdsWJf
         oJfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727276606; x=1727881406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WyPp28NYrJbi33YU5dd0/uz1wt5cUJUmG1p8KF+fEHg=;
        b=k3N9y47rSkXnPtxi01iV+SFJqAfo3ICtQgJkRtJ/l1rODwrnluIs4kZW6b+fOyKuSG
         9YbAm723q/IYmQ2CsFVma6soxDJRXhm1/zplQahRRAT99y60OCMeMI6sOuOwrTAvBw3F
         Bg5BSXub3s7LVtY/D7mrSIiFYl480SHWIK1CQ3vUQHyIfusSXLCRAsqwo4gg+cZO2GNF
         bMlc/Gdb9UyFzLdGj4Ko1HlOkzC9sHHsI5nBhd+dY5q0QsSC9RmoiIbOIqHeDaOndhbs
         2fK6JTsb5o8REvKxXpMKbRqZnfx6MvmBaJS5q+FTfm5i+fczRth40+VK6p0pMki55+/l
         7VZA==
X-Forwarded-Encrypted: i=1; AJvYcCU1i2vL6yy8YNCVwSABkLvRgVQsHltKQ8ysymNhCxKKI0PuP+tpycCfxCUlacS4FgDFlFw7YWus6GwVoL6WLQY=@vger.kernel.org, AJvYcCVTuOEFskojRfFkkudzVASGfhY9jPApi1B0Co8lsJleY5tQGFEJcbWL4h8TGIuimu3UfG0PdZ24CWLbiWKI@vger.kernel.org
X-Gm-Message-State: AOJu0YylSMF5DasBNRM6+AS7yVrf8WixPvPDagdhLPqBsPJPdGvGu2rZ
	mZCH+IDCKay12FE9721X60CL8iMLnC2S+tmFtd3iZhO8Tn3/nrb8xMzbf/9yjbn8SXUqrgUMu24
	r1Zo3r7hj+XL9h3r+u7AA6qzee7Spbg==
X-Google-Smtp-Source: AGHT+IHclq8G6lZmqiClsVpYhUU8uH4PHhqZcQ11/na9kXhX5DTaYq0EOx8xyP3fN0UlxUQFfY9EZIk5HvE68VZXH/k=
X-Received: by 2002:a05:651c:b14:b0:2f7:90b9:7534 with SMTP id
 38308e7fff4ca-2f915fe4a35mr20741691fa.11.1727276606111; Wed, 25 Sep 2024
 08:03:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240916032228.6601-1-jiande.lu@mediatek.com>
In-Reply-To: <20240916032228.6601-1-jiande.lu@mediatek.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 25 Sep 2024 11:03:13 -0400
Message-ID: <CABBYNZJQ4WVAgTPpQBsPp+wBqymN_inisdFZXoMT_b9YdXf2Jw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: Add USB HW IDs for MT7920/MT7925
To: Jiande Lu <jiande.lu@mediatek.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Sean Wang <sean.wang@mediatek.com>, Chris Lu <chris.lu@mediatek.com>, 
	Deren Wu <deren.Wu@mediatek.com>, Aaron Hou <aaron.hou@mediatek.com>, 
	Steve Lee <steve.lee@mediatek.com>, linux-bluetooth <linux-bluetooth@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-mediatek <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jiande,

On Sun, Sep 15, 2024 at 11:22=E2=80=AFPM Jiande Lu <jiande.lu@mediatek.com>=
 wrote:
>
> Add HW IDs for wireless module. These HW IDs are extracted from
> Windows driver inf file and the test for card bring up successful.

Well this is not enough if we don't have firmware published for them,
or you have confirmed that firmware is available and it does load
properly? In that case please add the information about the firmware
as well and perhaps some logs that it can be loaded properly.

> Signed-off-by: Jiande Lu <jiande.lu@mediatek.com>
> ---
>  drivers/bluetooth/btusb.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 6c9c761d5b93..8946aafae640 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -563,6 +563,16 @@ static const struct usb_device_id quirks_table[] =3D=
 {
>         { USB_DEVICE(0x043e, 0x3109), .driver_info =3D BTUSB_MEDIATEK |
>                                                      BTUSB_WIDEBAND_SPEEC=
H },
>
> +       /* Additional MediaTek MT7920 Bluetooth devices */
> +       { USB_DEVICE(0x0489, 0xe134), .driver_info =3D BTUSB_MEDIATEK |
> +                                                    BTUSB_WIDEBAND_SPEEC=
H },
> +       { USB_DEVICE(0x13d3, 0x3620), .driver_info =3D BTUSB_MEDIATEK |
> +                                                    BTUSB_WIDEBAND_SPEEC=
H },
> +       { USB_DEVICE(0x13d3, 0x3621), .driver_info =3D BTUSB_MEDIATEK |
> +                                                    BTUSB_WIDEBAND_SPEEC=
H },
> +       { USB_DEVICE(0x13d3, 0x3622), .driver_info =3D BTUSB_MEDIATEK |
> +                                                    BTUSB_WIDEBAND_SPEEC=
H },
> +
>         /* Additional MediaTek MT7921 Bluetooth devices */
>         { USB_DEVICE(0x0489, 0xe0c8), .driver_info =3D BTUSB_MEDIATEK |
>                                                      BTUSB_WIDEBAND_SPEEC=
H },
> @@ -636,6 +646,8 @@ static const struct usb_device_id quirks_table[] =3D =
{
>                                                      BTUSB_WIDEBAND_SPEEC=
H },
>         { USB_DEVICE(0x0489, 0xe11e), .driver_info =3D BTUSB_MEDIATEK |
>                                                      BTUSB_WIDEBAND_SPEEC=
H },
> +       { USB_DEVICE(0x0489, 0xe139), .driver_info =3D BTUSB_MEDIATEK |
> +                                                    BTUSB_WIDEBAND_SPEEC=
H },
>         { USB_DEVICE(0x13d3, 0x3602), .driver_info =3D BTUSB_MEDIATEK |
>                                                      BTUSB_WIDEBAND_SPEEC=
H },
>         { USB_DEVICE(0x13d3, 0x3603), .driver_info =3D BTUSB_MEDIATEK |
> --
> 2.45.2
>


--=20
Luiz Augusto von Dentz
