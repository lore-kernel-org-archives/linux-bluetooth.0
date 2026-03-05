Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB5BF4F1
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Mar 2026 17:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772730042; cv=pass; b=LtUsdi7yzAUEUHRXA9/nouuEu01X5pQzICmNNmbBWM56PUI9ipcd0MHN+Tnq976hfmQWniGTTLS4xGCEepvggPsr3M7lL12nxeqELwdXPN2hwiQaH1czfylUAQPFW4pbPzMz3WGdSSwUmmr96jOXtN076sMBO3RtEJJKTRl4GBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772730042; c=relaxed/simple;
	bh=33+DsmKnPBNIoAfSy6QQSMHyT3SwzIy4MgTwf1Uy3NQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tK5C35YfdQKrBc8kLmYGrpeDRORo8omwgYc3XEEzcoRvoA6X1SJ7Iion6QXeftP+sZloijbuAWa8u+Joj87sc1MRDzsMkcA3rFS0Llh+EBN6nADqwp1h3egboWkqEwU5oePhYwyhZG2v80/urCtzLkZxrhi+1siOr/Cx4pceOl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DubhF/no; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DubhF/no"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-64ad019bbd4so7540647d50.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Mar 2026 09:00:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772730040; cv=none;
        d=google.com; s=arc-20240605;
        b=ORv5Q3bIvgOx0Lcq3UCRJqCL8F7AhWn/izmHf7iYHz7E7ALi0EZwi/ywFIzCDeZTMz
         k7edAt76MoasTglcgpOvS946IQmPeEGK62fNey0cZfFekWPVwp7s/0qYVq/gnnuYbK5Z
         4skYntCxoamiddiTBJR/DRUsstcncLJMvaweSh5OmTQdpZuuE4HKTIGuPtySQxMr0j5T
         Xd8xUf6o8V4+3Jk8LME9aV01dBX4QwUSiekQuEPC87FWV3g4CxOI/Rf6woPVYVMd5wF7
         +P+sjBYYWnhouHNl47pWSQGgRzViHb5H2tyviipyxDd6cgLEMbtimzMCSmbIdI2mt9W+
         ZMrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ITyl1FB3UAPc9zgkZVC4mdKNnilYrItg5Dy1qf7R/tk=;
        fh=rm4UsBpQoFRUVxuhLKOQAdsxvo9NL1j3b7EyLouuwgY=;
        b=EVSyylPq5AVncKpRUotg+RJq4bwjnCubB6x4ILHsTK8yHNKcf0Tvd421t2VwxcrKdk
         6L4Aty2ZTO6LYI3hF/CZ2bxpRujN3xwvTXs32UrN3XRGlamEo6J8tcm+Tj7/kWSi9EOT
         vL38FWhqfuimL3PGZCCY0O4f6qhDllvWAeRe37tJOXp6/atYFGMXwxvtZSrkuRk1Qcl0
         9WdU/4N5S8wgb38s3l7erlpeVmglcNWXouX2Qc1evyCEB4wSFaLgZ+xrukcgN26b+fLq
         zhmEAjlFj80oZYjVdq+KytVUXNfaVzNfcJGdNdcY1xvpMVwSYsT6bEBZ/zWNkS+RldWd
         XxNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772730040; x=1773334840; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ITyl1FB3UAPc9zgkZVC4mdKNnilYrItg5Dy1qf7R/tk=;
        b=DubhF/noIk2SoMH5N9bpcL4uCR+hMn4pk55eB4jDHZb5QmyUL+aCxUvuAAGWmD5oXh
         bdJMmSd7Q32NBkWstiBSTXzwTVe3WSwMQDbUriCRORD7CSpziCwJxOy/XTBCPyaK6RGn
         ErS23ZndQvqlpSJ7GvPOVqU6LOeFBTC37LJH9WQIT7uenjyBmzN0uNdrFovxhtlQYKgi
         dEf3v12uvglyX2yKHtoHnQoSH63S+tYMytIOxyuSMU98TiV7bu8Ayc7b0hICmQpFrZZU
         /xNVcyZhRBv+WUESV+uyd2fTR+OzgFbJOrmhrn1hFeaTynU2dcS8/kXTN4gGvHYk0zI/
         zmYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772730040; x=1773334840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ITyl1FB3UAPc9zgkZVC4mdKNnilYrItg5Dy1qf7R/tk=;
        b=FGv2aPPovgXnO+ImswHOlY4cjiTxV6f79aa4i/2uHtUVnN8HJG8Wq+DXCeVgad9pSo
         o7omMcuINcyl0gkTwt5jMd3lR/x6B+K11v/INAkZYdivwHDRXSX/5r/dVxXCPvLjPvZM
         Bq1qZFP55Cc6ByIe0nTE+Ff3ndWofnLLGfDm1Dp2yDYhbcx0/mDEaQKNHQHJHeUDigVO
         a5zZAf7A8anrsdDlj01bY5OycEnAEqglb6MTXgpWySGPGJX/35QT0lO3kHNZG8GzhG3f
         oRdt3pOTXIiKtwuR2eQc2ZrHqWkEpgz5hE+JMqrSjdJthrKMymXoBMHdzp8l+d17gJVj
         YAvQ==
X-Gm-Message-State: AOJu0YxaKIplnRJxGW1vS4ii8XmQfUlEqQuLvi18kHIkcdJaCQWMsxAX
	gcQSK/5hD1DfZG4/sPNgbjhsFa4YIx6HgOOLV5tJ8nBirA/iOvD4Gc+PKmg5enIWEMx4dlYRP63
	kdcY48H0iEDua7TDR5sYk6R4XSo+9Xc8=
X-Gm-Gg: ATEYQzywkTdw/hyNQt8MJP/KUZGBT42fhLSPNfIX3EgrzqVr4nkt5kpEkPmZbL5/BAj
	paKjrL+4EYFipKv60giJ7mS5OcwfcssuPepenF8tWu+gbbcwfTVuDwgkLSa1iUX96OyiTvrC3ti
	qRzOJv4hGBhY0n2NxENW3jBPKIix7XoczHbJlIpY4wof2zXSkZ5RpMWbawPLa5x0u9KnXtPp4uY
	NnpFM8i6UVTjmAOmCGvSS3+tNRT4QbcvUiIflK3W1am+HjckX/ZNTzbHgsVs3xiHfqLj+1tqKTe
	9vxic68TBZdKdcY86Tejb/nca3kHGgOIVwDmS8VNOFAy8EKW6ZehbebdyjYVxqUufyssPoyPqxe
	rnGrM
X-Received: by 2002:a05:690e:140f:b0:64c:9f31:e33 with SMTP id
 956f58d0204a3-64cf9bc0ff6mr5390993d50.65.1772730038369; Thu, 05 Mar 2026
 09:00:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <177272816248.352280.12453518046823439297@jetm.me> <20260305162930.E1A171EA006B@mailuser.phl.internal>
In-Reply-To: <20260305162930.E1A171EA006B@mailuser.phl.internal>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 5 Mar 2026 12:00:27 -0500
X-Gm-Features: AaiRm510e8OSo9xfTserOW5mo_6hsUw6rbCdw2ClbGkb63yBLaHGczXFhrO038g
Message-ID: <CABBYNZL6MOoCE7Ft6tQLLJtUqs_uw5o-D5OSHTWC=Q_PE5kjdg@mail.gmail.com>
Subject: Re: [PATCH 2/2] Bluetooth: btusb: Add USB device IDs for MediaTek
 MT7927 (MT6639)
To: Javier Tia <floss@jetm.me>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Javier,

On Thu, Mar 5, 2026 at 11:33=E2=80=AFAM Javier Tia <floss@jetm.me> wrote:
>
> Add USB device IDs for the Bluetooth interface of the MediaTek MT7927
> (Filogic 380) combo WiFi 7 + BT 5.4 module. The BT side uses hardware
> variant 0x6639 and connects via USB.
>
> Known devices:
> - 0489:e13a - ASUS ROG Crosshair X870E Hero (Foxconn/Hon Hai)
> - 0489:e0fa - Lenovo Legion Pro 7 16ARX9 (Foxconn/Hon Hai)
> - 0489:e10f - Gigabyte Z790 AORUS MASTER X (Foxconn/Hon Hai)
> - 0489:e116 - TP-Link Archer TBE550E PCIe (Foxconn/Hon Hai)
> - 13d3:3588 - ASUS X870E-E / ProArt X870E-Creator (IMC/Azurewave)

Is the lsusb information for these devices present in the links? We
normally require that to confirm these ID's are real/valid.

> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D221096
> Link: https://github.com/openwrt/mt76/issues/927
> Assisted-by: Claude Code <noreply@anthropic.com> [claude-opus-4-6]

Ok, this is especially valid if AI assisted, otherwise we would
probably need to ensure the agent has access to every board to list
its IDs, etc.

Regarding the use of AI, there doesn't seem to be a global policy.
However, for Bluetooth Im not inclined to accept any patches that
hasn't been properly reviewed by the author, so if this was fully
automated and not verified by a human and I definitely don't want my
feedback to just be used as prompt to AI agents, I would do it myself
and not waste my time writing a response.

> Signed-off-by: Javier Tia <floss@jetm.me>
> ---
>  drivers/bluetooth/btusb.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index a5e44887a5b5..d5e990cf8ccd 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -751,6 +751,16 @@ static const struct usb_device_id quirks_table[] =3D=
 {
>                                                      BTUSB_WIDEBAND_SPEEC=
H },
>         { USB_DEVICE(0x0489, 0xe139), .driver_info =3D BTUSB_MEDIATEK |
>                                                      BTUSB_WIDEBAND_SPEEC=
H },
> +       { USB_DEVICE(0x0489, 0xe13a), .driver_info =3D BTUSB_MEDIATEK |
> +                                                    BTUSB_WIDEBAND_SPEEC=
H },
> +       { USB_DEVICE(0x0489, 0xe0fa), .driver_info =3D BTUSB_MEDIATEK |
> +                                                    BTUSB_WIDEBAND_SPEEC=
H },
> +       { USB_DEVICE(0x0489, 0xe10f), .driver_info =3D BTUSB_MEDIATEK |
> +                                                    BTUSB_WIDEBAND_SPEEC=
H },
> +       { USB_DEVICE(0x0489, 0xe116), .driver_info =3D BTUSB_MEDIATEK |
> +                                                    BTUSB_WIDEBAND_SPEEC=
H },
> +       { USB_DEVICE(0x13d3, 0x3588), .driver_info =3D BTUSB_MEDIATEK |
> +                                                    BTUSB_WIDEBAND_SPEEC=
H },
>         { USB_DEVICE(0x0489, 0xe14e), .driver_info =3D BTUSB_MEDIATEK |
>                                                      BTUSB_WIDEBAND_SPEEC=
H },
>         { USB_DEVICE(0x0489, 0xe14f), .driver_info =3D BTUSB_MEDIATEK |
> --
> 2.53.0
>


--=20
Luiz Augusto von Dentz
