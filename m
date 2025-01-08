Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4859D200106
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Jan 2025 17:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736358191; cv=none; b=GBUNzdzvhiqKGKEKoKr838NliydF51ugUQiEDUhCKRWoyP4SeWN1UCrnrWtybI0go7OWHb+C7bBrbbvxTADj7rRcuCjcGd4oAS2DR7hAuGpOfzdNiEpP7cUMISxlQ/VZ4SnNu8fL0j9G1dHgs1lcQJixLg+wfbvjXDiHVW0gw+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736358191; c=relaxed/simple;
	bh=QF3FUuPpmYKoSmDZV7vwrqxrXT7lNU5BsAAbh0VeKZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bz2d+FaxsanHgw0r9m5ffjA6zHA3iNgWNmdI7mWhc25ocAC3Z/XZN+zc6goUkNlOc/lECNi+qWq0c7bECdtYFoPYokF650WZuPyBkCiEkcDNy5yFm1imv8ddXB5Zc7zSqjPS1tlu0kNgkmpSZSWywzhhqSzIlYwhoMS204U7nTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LvlJkwDh; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LvlJkwDh"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-304e4562516so388231fa.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Jan 2025 09:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736358188; x=1736962988; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DPioJGfSrNMu3aSmrAixYKQ0j6Ge39enqX9f6rxfBKY=;
        b=LvlJkwDhDhYNQaehq8eluXHVcBA4C+Zk638Vkkz8qRvdjwlMW9iKV88eGLDp9kccNb
         xh7H9ZheobUfp6XYwCpFp04k9xuyop7Mbbu8dU1MPSZJUbON2ioieTsjCf3wrmy/f5Wh
         kqMigcS5cm7HY5h3SbKJiQPLCCHreQM1YnD/DzYgP/H+b8BGI2h7TfUnzbySbzBJQAEa
         g+0L9CugVxkaXYnv4bnvd/1SdxGEa5tMwAE+HtHuEq3vDkhY5hHA7Uiff57mIf4NSAXa
         nscukzDnX50GnoZ0RK7T18hdyo/zk1z8HPtWec3pAGG5gNwjlI2+Q3+2wKPdkyhOiTdg
         DchQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736358188; x=1736962988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DPioJGfSrNMu3aSmrAixYKQ0j6Ge39enqX9f6rxfBKY=;
        b=aMs0fX1DlbMnkatIJv+whsMcMIPtXxHMZFRli8fm7hmkD51Tta01MG89tfqqaRHTja
         8WHbEFW4uTzKSdUCkEVszxrUNmnUO7hBCvpNnFzjY2mnEHqVgut7xhQO4OLapxV+KQj2
         OL0/XfcEKOShvm3cOOgRkqhJs3U2jY3E3zqGABajPNfOoqKGpeyotM2VJU1y9T75xWBF
         pmNHRkKDV3NSarziXEHRHn1NIUurnRjEnHZ/2HMo8bh8DlgELFAN0AUyXbVdCq7ceY2D
         tD6EMCakxJBeUl3nSVPBGboAzkRNPtwW1RtnGZQdKYQCiIORURwHvimc+H6V9h0DFbPN
         dDRw==
X-Gm-Message-State: AOJu0YyssnUBIw7zgklsONS4Q0d+NRBXSgc6Xo90RqJD0aXvRWosO2mc
	Y5dipQdAlzdaFGXu8s1G8DAAOchdDqfigSxTdCactFtdsmj2nEcFlGMqYhZOL8CI7MLkGZAfdFL
	C0m6lzYtFSASymRsr749cCmtzprE=
X-Gm-Gg: ASbGncv/xADgu4JOQMw8vMq2C5NqxxhQx4kZQT/68fxHG94c61MD8IoriaJPtcPvD1x
	hkjoEWbaF+FU1tb9lryFQSNnO6NNqsGDW4kpp
X-Google-Smtp-Source: AGHT+IH3fRE78fCtVOH1uhz6nu+Zg3xGMBizOWMwgEkh1ba6ow8ArTRx/URKtuj+BplnP+FimrJ9TMMNAOSrUowAo3o=
X-Received: by 2002:a05:651c:2227:b0:2ff:e4e6:2543 with SMTP id
 38308e7fff4ca-305fd223d16mr555151fa.21.1736358188068; Wed, 08 Jan 2025
 09:43:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250108170111.16824-1-tcrawford@system76.com>
In-Reply-To: <20250108170111.16824-1-tcrawford@system76.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 8 Jan 2025 12:42:55 -0500
X-Gm-Features: AbW1kvYTYW2dtTIr1_2fuCVpLQbAIDMNlOWPGSzvYk10MAOqGe-u_YB6k91XGDA
Message-ID: <CABBYNZJHXy5mxg31yL7ZiKtc4bAPtokKv8RB6UrthzxRMTfU7g@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: Add RTL8851BE device 13d3:3600
To: Tim Crawford <tcrawford@system76.com>
Cc: linux-bluetooth@vger.kernel.org, productdev@system76.com, 
	Garrett Wilke <garrett@system76.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tim, Garrett,

On Wed, Jan 8, 2025 at 12:01=E2=80=AFPM Tim Crawford <tcrawford@system76.co=
m> wrote:
>
> From: Garrett Wilke <garrett@system76.com>

Please add the information of the device found in /sys/kernel/debug/usb/dev=
ices:

https://github.com/bluez/bluetooth-next/commit/f597b8982d51f7b2cb499849b8c3=
131d545efe63

> Signed-off-by: Garrett Wilke <garrett@system76.com>
> Signed-off-by: Tim Crawford <tcrawford@system76.com>
> ---
>  drivers/bluetooth/btusb.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index ab0506148e84..71caf297aa70 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -483,6 +483,9 @@ static const struct usb_device_id quirks_table[] =3D =
{
>         { USB_DEVICE(0x13d3, 0x3549), .driver_info =3D BTUSB_REALTEK |
>                                                      BTUSB_WIDEBAND_SPEEC=
H },
>
> +       /* Realtek 8851BE Bluetooth devices */
> +       { USB_DEVICE(0x13d3, 0x3600), .driver_info =3D BTUSB_REALTEK },
> +
>         /* Realtek 8852AE Bluetooth devices */
>         { USB_DEVICE(0x0bda, 0x2852), .driver_info =3D BTUSB_REALTEK |
>                                                      BTUSB_WIDEBAND_SPEEC=
H },
> --
> 2.47.1
>
>


--=20
Luiz Augusto von Dentz
