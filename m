Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEC014EC5B
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Jun 2025 13:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750253658; cv=none; b=PIqK5S61wD/iyk/QGgWPa5bQTcv3t9Ci3rHsZ7h15erWP7B8H6Cpibx4t6cXu1maXQV3PAftFtKGs5orbHmd6DG+w/ELmOCZ7k3FzfFwBGeB/S+VgtG8iwhpjEvOCYNPW28uMMEciiV7/sGVn9LQyjpTQw4PY2fc9CfIbBjFmFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750253658; c=relaxed/simple;
	bh=rzOgQdPuRU48dY/CWDRoa14tLhMW42JuZFmUjcuQkiw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aEUR2wvusppnSV8homJmXshmVv4EueGr1Y+U3ViHWwsSzMMxpTqxkwZIOpjY4yPvBlO9v+AWEP4a5gwuxeayHqE7O+0DQCnv0KMq4w2B80oKtSLPpCuSCiFEzG5aC0rWlPM4NRxBf0sT2tuLoCX4w2vG8WIt1U/hrYVio73hNB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DFYjKz2S; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFYjKz2S"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-32b8134ef6aso4531361fa.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Jun 2025 06:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750253654; x=1750858454; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MA9A3NTQs5LLELUAlB1Kqd4WS0F2CeN78Ha1kTTuWkc=;
        b=DFYjKz2SgLFBt9wxpwrzkqBzehI2NZGHpx7EGNPCnhJny+95P9TEOnKEwzBXE5G44a
         3driYr+v3OreGAUbirNRnf56UZamCyztgY3PuHUpMbPi+gZJMX/yZct8ww+pF1TV6U/a
         ztFjL2eWtVYTnXYq6znY0t/DNSR+S2rB9tqIFBlmsoNtwy3tM3oly+VEnYooO32NDdwe
         J4vszl+WHfG+Eizzn511noTh0yAU7/noyfpCE4irrglNwSJI+TmZ84m2507D4JaaODNw
         UBIfAY1sUyaWQfQ12DLFAhsJIndyk5Knd16hIt/VuYcGl6ObPmmzO5OE8FHEn4iDTDFJ
         Ivdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750253654; x=1750858454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MA9A3NTQs5LLELUAlB1Kqd4WS0F2CeN78Ha1kTTuWkc=;
        b=ut/LUEP4Yx91+VABHpbudt792q7visWu8USJxXjFCqySBm+r8ZsTNWKk3YH/CL4RKp
         RTK1Vhq98DKOHAfMesN/NkNBEXJThA1E/vnH2c2jWV2B7uPe+lp7oNw1XapLloOXX974
         fPN2270cEXyNDtXzgKeLi/irw82IU2azZ9xtm0RoCgSZmCGaj1A2OLWSk+9ANwbCVPUY
         PAC8MI5ooiQRjUoQ/pcCYqhxkfEfOX1wcb2D0QaR/dPI2z9lGA8ONJB82lC69ygtemzw
         MOcsfLX95wds8DiLbjXCXLxejRfhHsiAqMty2Z70BhGGQFe3HCPgfkgaMC/iwWULwhAS
         F+3Q==
X-Gm-Message-State: AOJu0YzLGm3/rNDjMuHXIh7tF96IA1h4YxZqEeu7OSeF867DK9NWAhwx
	vRvyYVs2iTk/mVcHagPSgCiMYLGnPQMRqKw0DDjDP7yNDVopzGuFItn9rmsYnMK7KRZ63qTruZ/
	M+CUkh0Y8zu+2l30cO/mikuJAGXGTJOxsgre1
X-Gm-Gg: ASbGncuWsLPoEkrO3t+NOCRd7iq4GP2WWQXT2h5S8sw1HHgG6vKOYbGCYkM8MnxM1YE
	qlidcYarqLxHwQs36G6SDRG0IW8YDD41xCo9FEZU63HnFgF5YVGIkM3m/N3w8CFTNdh81x1oRT0
	LhwVKyQGuRQ6Qp38T86+H0WLQKqLKyMB5V0CaL1XxGJQ==
X-Google-Smtp-Source: AGHT+IHWHe+y3QSDn8c/+H4IPOK3xvdn3PNWgbRLuIAgDGhgi8eCbG7eTWSMFd1CW40D8JiGNXUQqjt+avo49WOHlhs=
X-Received: by 2002:a05:651c:211f:b0:30b:f283:5ef8 with SMTP id
 38308e7fff4ca-32b4a43b780mr46458811fa.18.1750253654214; Wed, 18 Jun 2025
 06:34:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618130251.774085-1-kiran.k@intel.com>
In-Reply-To: <20250618130251.774085-1-kiran.k@intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 18 Jun 2025 09:34:01 -0400
X-Gm-Features: AX0GCFt9Gla5lDBOC-ODmwyGl3vUSAQmh0oNdpaYdAV2o28_lEyya7GAnQTeINk
Message-ID: <CABBYNZJf9wGcQSR9PPH9RfvrpRYtm_HScmVV6iBQOYwBowMk6A@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: btintel_pcie: Add support for device 0x4d76
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com, 
	chethan.tumkur.narayan@intel.com, chandrashekar.devegowda@intel.com, 
	aluvala.sai.teja@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kiran,

On Wed, Jun 18, 2025 at 8:46=E2=80=AFAM Kiran K <kiran.k@intel.com> wrote:
>
> lspci -v -d  8086:4d76
> 00:14.7 Bluetooth: Intel Corporation Device 4d76
>         Subsystem: Intel Corporation Device 0011
>         Flags: fast devsel, IRQ 255, IOMMU group 12
>         Memory at 13013328000 (64-bit, non-prefetchable) [disabled] [size=
=3D16K]
>         Capabilities: [c8] Power Management version 3
>         Capabilities: [d0] MSI: Enable- Count=3D1/1 Maskable- 64bit+
>         Capabilities: [40] Express Root Complex Integrated Endpoint, MSI =
00
>         Capabilities: [80] MSI-X: Enable- Count=3D32 Masked-
>         Capabilities: [100] Latency Tolerance Reporting

Isn't there something like /sys/kernel/debug/usb/devices that we can
use? For instance lspci doesn't seem to show any information about the
driver.

> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
>  drivers/bluetooth/btintel_pcie.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel=
_pcie.c
> index cb3cf2b9acea..1113a6310bd0 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -35,6 +35,7 @@
>
>  /* Intel Bluetooth PCIe device id table */
>  static const struct pci_device_id btintel_pcie_table[] =3D {
> +       { BTINTEL_PCI_DEVICE(0x4D76, PCI_ANY_ID) },
>         { BTINTEL_PCI_DEVICE(0xA876, PCI_ANY_ID) },
>         { BTINTEL_PCI_DEVICE(0xE476, PCI_ANY_ID) },
>         { 0 }
> --
> 2.43.0
>
>


--=20
Luiz Augusto von Dentz
