Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275FF32B11F
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 12:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779281759; cv=pass; b=pRYw8PAFob259nZGt6gSpy29gmtE9Q7aIWsX3zm0HL7gFHotUFKgc1JZEAd0Fq7XblEoYITtWJ9dxk8w8tDkERjB1aPIKCdt09T7a4WDd8l1uGfq17FD//gqHyoJ0JMy4pbIEr6twbqjhlVImmZiuYU5gORhpzdu4wPfUosoN8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779281759; c=relaxed/simple;
	bh=6WD+S9CyuyjigsieHVvvlSUsblICLCEFAEPm9aldkEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FImDV1SSugcD2D4jIO8daMmaTUaKpup8nJdSjR2jpByBz0H+bS1DMqv3Hv9nckKM7wNSTxFMoWPbuIBGPdSxNEjBtDn8ONHcfZLY+2s6NbO1H1obbXr8tPbDKNweGJBHQbTGtGBD33Vfv4axG8T89czLZ5yAIi5Of4Y4I51Zjus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RPX0rBO6; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPX0rBO6"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-651c366f7efso4997802d50.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 05:55:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779281757; cv=none;
        d=google.com; s=arc-20240605;
        b=DaCE1D+aTkPRjrcc++5M4roVvFVhVEtLbk4vtV1UWkNf63lIgBrq/FHWd2LUzia86Z
         ntqr/c+CT9syKWDB5Ke53IY6V9Hy6mURFCcTJTuhAVOCGIJZ3HF7BuLPg5kyFWj74Iwb
         5M+PewvOttXxy9qcbb9is4faDvkSYKNz+8DoxarAvKSpU04hrQAFik5fNnvlI+OlsXeL
         CUq/9jqvKcswrFF+RsRy+xD/M41SmtpcjJ99HiEdTq6Dp7PJw8jKmcf4J+d352ys66O2
         C8ppVbL51L842Q4AyGxkMMVh3hpZTaYcEmaNErNs/UXLe2/MBPM5JEBIRnwfk/hKrbnh
         C/+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w+UZtl8z/kYGpSCumZSlladAkgazeQGoZZRlkbCob3M=;
        fh=+Hlz2GR2jgK587f5gvb8OVl9ZBRNWcIT7Ru9jd1QsQY=;
        b=h/u1aKyH4Ec0nc4xXVZlOJMZ4vPqhKDb/se7C70rywa9PNG3VLmgiNYMVGNANsaNI4
         bVe/NeiTKeNSC6Cbu0Hx9zrMOYtI8yarspQ6xNuPUcqRavZXbClpCkb6OLgybs5RrCbZ
         Lw+BR82V3efJzfinMazeWTXpj/emgJM293U97zBrwpPdr1yxOtjhNH2i3mGfIl1+6T1S
         zn9Fqh4ZOZ5BslfWNV1arWSyBzs3nZoC7MzNmPb2mQUJWagovqveEIdI9hy+JYnKzJB1
         8ROMOtzDSpkGVKWRNGZQg7CCPTSu4WzG1MzF8Lds/ozDk86a5xpU+fkoXBS2iKBO0kD3
         c5+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779281757; x=1779886557; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+UZtl8z/kYGpSCumZSlladAkgazeQGoZZRlkbCob3M=;
        b=RPX0rBO6UyO+VMpr9z0qSvMDayRz7m/4W23B/RSVi7fnA/uIfpAlaJoF/3xyyShDWN
         0kECukhPaVDHdPEXfoetnNDNeIt6EjUwdLbl2CSZyBXsllRYLl14VJarWgGkNYZu6G9r
         c1fdK/4gpNDIxFNRmJQ5boi3ZvirQUMfwaq/q+s+U0LNR483gSBrsC2tEEbKH/PoDCK4
         U5TeNlD45/h+xeCnGnGCslhpX7n0nJY5kjPvM9h0SuVbFxTjuCFphpAUuzypYZHilRek
         KhA6z3aDq0s2UuYIE0Z7DhQGdF+Bwx6dfNLWOclZDvs+kATdglvpA6jCrrZZFAqpJNsC
         j5Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779281757; x=1779886557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w+UZtl8z/kYGpSCumZSlladAkgazeQGoZZRlkbCob3M=;
        b=D29mdNR6Tg+e/Hw64A2vIN+F2fjXuXOVveVbNYlGjGOXwu1n8da0dOUmaPDT9df7ai
         UWH50orLRNGmeaLU6octZQ1NR/jZM6KEH5wRmPxiKYJmQz/Nhir9ogJuLESINlOWpJcf
         Kgb0BX0pr45elIAAzwG7MVqhE9xXNkgDkxdXV/Kbq1D8pmdEgKrAUXaiMFI6mnINFd+y
         213VjQykiLehxon/4PcbNvYxCTT/AJO9QeeWgr5MymU9Ik0K4mJq3U0EMr6tzoBzqHC1
         YhE5c1BYmx/D3KQT1Lh0R93tykV8t00wSc8Ybk+OVmb78tB+KSftOjntzPp2Q9RWMqJF
         91pA==
X-Forwarded-Encrypted: i=1; AFNElJ94ctlS0bgxhXCrSEWIWOHUAuyqLrwoHODyv3WyQy6RyW0Ao0ktngbSzMRAC8pW7ii4BN5qAqGOT2enUfq8k1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgnmJ+DiaDiQXLgYiU/2BKKD+c0J1xP/r8KY2OW0SkkbU+92oP
	TTHRpNuKWrVdW5HAv8D+xtuompXzgTnXxBcNvA4wue0yFpdrPw7EvbXONwaqMPQOjvjzJuWT11T
	+hcJrOLym9i8oAK4RP4eC/kW8x2CkX5jDbXz3
X-Gm-Gg: Acq92OECMU0Gg0fch+rYQXni4J9nHmZEOX+IIqsG+TSHou/IRwU64CTEGBLpDD/81xm
	jnpbzqta9UauX4cRwGoSk1VRa29Myj+OGJC1UGjk/RoHUAECJMc9nV8xYIAFmTJ16YNMLvM0HYS
	ndcNOHLfQ1qHntvArWocHho4wz71jokBUeLMwyAvKIWaoVz1V50Z6WjqLvebN/m5yAegB30ImFS
	CBgY5rwJkfOx6NtjxkqUctRFgFPCNr0bJ4zJaiJPRU1/OEQDy6WcgHatwYYqs2QDeefenfSLtn+
	YMjX7Si3xBwaksTA2v7AzfpiJW/W36OwfdYbXq2hYJ+/XfIRGvq2M3FNNbLhaHzd8+5f1w==
X-Received: by 2002:a05:690e:4293:10b0:653:f72:f482 with SMTP id
 956f58d0204a3-65e2275e8fbmr18516144d50.22.1779281756819; Wed, 20 May 2026
 05:55:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520021500.13504-1-liujiajia@kylinos.cn>
In-Reply-To: <20260520021500.13504-1-liujiajia@kylinos.cn>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 20 May 2026 08:55:46 -0400
X-Gm-Features: AVHnY4JAx00s9RY77VuK7Nfrn9COGaPLhAAlt5GNCqKcZP_N4w4YPkGy2JQbhi4
Message-ID: <CABBYNZLLNFNuSv0UBNQ7C2HTTg5W2m41hBTNpPw822GMAVNuhQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btmtk: remove extra copy in cmd array init
To: Jiajia Liu <liujiajia@kylinos.cn>
Cc: Marcel Holtmann <marcel@holtmann.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jiajia,

On Tue, May 19, 2026 at 10:15=E2=80=AFPM Jiajia Liu <liujiajia@kylinos.cn> =
wrote:
>
> In btmtk_setup_firmware_79xx, the data length indicated by wmt_params.dle=
n
> in the cmd buffer is MTK_SEC_MAP_NEED_SEND_SIZE + 1. Except for the first
> byte, the remaining length is MTK_SEC_MAP_NEED_SEND_SIZE. memcpy copied o=
ne
> more byte to cmd + 1 than the remaining length. Align the length passed t=
o
> memcpy to avoid exceeding current section map.
>
> Signed-off-by: Jiajia Liu <liujiajia@kylinos.cn>
> ---
>  drivers/bluetooth/btmtk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
> index ea7a031000cd..53cba71cb07f 100644
> --- a/drivers/bluetooth/btmtk.c
> +++ b/drivers/bluetooth/btmtk.c
> @@ -188,7 +188,7 @@ int btmtk_setup_firmware_79xx(struct hci_dev *hdev, c=
onst char *fwname,
>                                        MTK_FW_ROM_PATCH_GD_SIZE +
>                                        MTK_FW_ROM_PATCH_SEC_MAP_SIZE * i =
+
>                                        MTK_SEC_MAP_COMMON_SIZE,
> -                                      MTK_SEC_MAP_NEED_SEND_SIZE + 1);
> +                                      MTK_SEC_MAP_NEED_SEND_SIZE);
>
>                                 wmt_params.op =3D BTMTK_WMT_PATCH_DWNLD;
>                                 wmt_params.status =3D &status;
> --
> 2.53.0
>

Have you tested this on the actual hardware? If not we need a Tested-by.

--=20
Luiz Augusto von Dentz
