Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C88C1A269;
	Fri, 19 Jul 2024 15:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721401731; cv=none; b=K1NHfMqRl/HbuHz5mvmZQfy7CnwtbwdpXiDw+0n5fa89wVRpR5Pjd9Y1XVbCA6/Hdh81J+hGOhu4GY93N7I3nmYNTRIjoMEirk2CINMpSjStAubMm8bKWhbmLWc+SdmjRx+korCuBRVvrqwDIcYMM8nBmUAEjoDWYjL5lfP9d3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721401731; c=relaxed/simple;
	bh=VhPEroq9S3SvZBq0wNrcLsUcqdls8YtNMYLriQuaKFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PAHYs8g76T2ebKthF0XYv1rc8pRil5gtvvYHMz5TdhpAAufEM8FKwsRdpVoPPSgiZi9Q+t5Vlhgt+L9sTAO6cWnIQyn4oESYZ07hae4Zwtcezv45vrumfpKbelMWpWjIfmVnqCjidXTFabcyFe+/U1nc1QizjRL8HvxTQ9C3/Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HmgzuFt/; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmgzuFt/"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2eeec60a324so30407321fa.2;
        Fri, 19 Jul 2024 08:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721401728; x=1722006528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pxJdvG4GHPuYd2T0/+njfFwbHisz/VRVz1QjmDGv7Rg=;
        b=HmgzuFt/X2CI25m5+6rk7cOy2WvDXYe9WUkgkxcez5rsR91TGAiEMESozOj4geaBc5
         sSvSVPn0vaVb7iS6JN825/iFXd+0HBjGHl0tN5FgKiarDsHY9dj7NjgSwZqcYucddX75
         5UqQCYcNcG8tNOrc43nK3Go5XnIKtRhn1g825RkPO7tjFwwKTdZwh0ZPAfPNNelvw/u4
         w3N6XfDY9imyAGULqS2y9UrjqgQ7lETNU1IF5evkywWjQaJWVIhHFCY7vckZDUZfdPPY
         j1mUfJnNDnusrMvE0/iPHt23gkeV0IAXSIrbmh5xXuXMBpXfowgAIkZqymleQHpDjbu3
         iKZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721401728; x=1722006528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pxJdvG4GHPuYd2T0/+njfFwbHisz/VRVz1QjmDGv7Rg=;
        b=v4JGJZGp8bgMJTyoTCfDk9Ocp4EYl22K1P5mVvqk5PMmBaoMEKFpLQg5rs+8YzTTeS
         ivhZbXG7mKf/mYhAeQNhLS3cUqgzixfFyLmAT74YOf0cCAwh6Y/+OpxAQ3IKAWFSdoRn
         ivbFS4s8+v7UBbTSRXfxdnDQLBP95Cmx/S42hxPv0kqjGmSEkcMCrmeCaebmT/Zh0X7n
         UjwAAYMN3VjaxDr3s03/FZVxnzldzpq4koCIDEHpI907WrPUWwfDbVZefbp5ELjc24K+
         3kLDCEAEv8N3O2A/uKNqCkIJUFYvwZHoW9ZQj5kOLVePsNbOxFCPuykH0D3put4RvJkd
         9YBw==
X-Forwarded-Encrypted: i=1; AJvYcCUTVy4zNyLf8h0qHnzQu4HHgxgmuCD0y8QNcK++C8uSGo5944R+q5/aBykY5nI6wEpSj2mj4ndsWnKJAKcLLUOP2CW6nou2PHDerAYjMLS9GkDp3zgIVG9ISxKKrWlOeuAvfGGeqjMkKJhcQ+1Z
X-Gm-Message-State: AOJu0YzKOJ1zMs58IKBz1KW02h64fhW0ZQhdOTGcEQSd6tom/kW01Rub
	sRVXM3M+jimq1FTrdBU2j5HW9ntvjHBkqnBIfAyPZVGgVy1TGKh7CZHu8xva2CuBwwCVy4ApnV6
	9u7avGeL9OXM+IgONWhErw0DPckQ=
X-Google-Smtp-Source: AGHT+IEKV6/lwbIVyxNP3HduGa6GJ48kF+FAfzn+2GtakQhGWGSSWW/vvNhiHswsej3AtB2nD3zNghHPoKfaW/ZXyxs=
X-Received: by 2002:a2e:84ca:0:b0:2ee:8f3d:e68d with SMTP id
 38308e7fff4ca-2ef1685d099mr393111fa.44.1721401727500; Fri, 19 Jul 2024
 08:08:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240719100554.4183635-1-arnd@kernel.org>
In-Reply-To: <20240719100554.4183635-1-arnd@kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 19 Jul 2024 11:08:34 -0400
Message-ID: <CABBYNZKFD7axR5ZSGJL7mn=_mKufGnxopUeeZhL+AL40jWQjzQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btmtk: add USB dependencies
To: Arnd Bergmann <arnd@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Sean Wang <sean.wang@mediatek.com>, Arnd Bergmann <arnd@arndb.de>, Sven Peter <sven@svenpeter.dev>, 
	Tedd Ho-Jeong An <tedd.an@intel.com>, Hector Martin <marcan@marcan.st>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Niklas Schnelle <schnelle@linux.ibm.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

On Fri, Jul 19, 2024 at 6:06=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The mediatek bluetooth drivers have a common portion that is now used for
> all front-ends (usb, sdio, uart) but that internally relies on USB
> interface functions:
>
> ERROR: modpost: "usb_alloc_urb" [drivers/bluetooth/btmtk.ko] undefined!
> ERROR: modpost: "usb_anchor_urb" [drivers/bluetooth/btmtk.ko] undefined!
> ERROR: modpost: "usb_submit_urb" [drivers/bluetooth/btmtk.ko] undefined!
> ERROR: modpost: "usb_free_urb" [drivers/bluetooth/btmtk.ko] undefined!
> ERROR: modpost: "usb_unanchor_urb" [drivers/bluetooth/btmtk.ko] undefined=
!
> ERROR: modpost: "usb_kill_anchored_urbs" [drivers/bluetooth/btmtk.ko] und=
efined!
> ERROR: modpost: "usb_set_interface" [drivers/bluetooth/btmtk.ko] undefine=
d!
> ERROR: modpost: "usb_control_msg" [drivers/bluetooth/btmtk.ko] undefined!
>
> It would be possible to split this up further, but in practice anything
> that uses this driver will have USB enabled anyway and it only matters
> for build testing, so just go with a much stricter dependency.
>
> Fixes: f5c3f98946e3 ("Bluetooth: btmtkuart: rely on BT_MTK module")
> Fixes: 3a722044aacf ("Bluetooth: btmtksido: rely on BT_MTK module")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/bluetooth/Kconfig | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> index 44a2de58337b..2894a345562c 100644
> --- a/drivers/bluetooth/Kconfig
> +++ b/drivers/bluetooth/Kconfig
> @@ -21,6 +21,7 @@ config BT_QCA
>
>  config BT_MTK
>         tristate
> +       depends on USB
>         select FW_LOADER
>
>  config BT_HCIBTUSB
> @@ -413,6 +414,7 @@ config BT_ATH3K
>  config BT_MTKSDIO
>         tristate "MediaTek HCI SDIO driver"
>         depends on MMC
> +       depends on USB
>         select BT_MTK
>         help
>           MediaTek Bluetooth HCI SDIO driver.
> @@ -425,6 +427,7 @@ config BT_MTKSDIO
>  config BT_MTKUART
>         tristate "MediaTek HCI UART driver"
>         depends on SERIAL_DEV_BUS
> +       depends on USB
>         select BT_MTK
>         help
>           MediaTek Bluetooth HCI UART driver.
> --
> 2.39.2

Thanks for the fix, but we went with a different one:
https://patchwork.kernel.org/project/bluetooth/patch/20240719033019.26767-1=
-chris.lu@mediatek.com/

--=20
Luiz Augusto von Dentz
