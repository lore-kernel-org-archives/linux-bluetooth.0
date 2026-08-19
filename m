Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0239948AE00
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 16:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787157352; cv=pass; b=GkC2BQvUsSS8a01Jqz6Fx6JhXqfcrEaC4ymMF9w5ltQ2Pg3FV8mBX+vZd+P2qWKmCgjZ08D4576aqEnMARLVOg5Y6TdOX/w9l1Dt1dIA0T8C1aEFDvlRKfmcgb0hav9rO3XRjic5WlC9oz2hJmzemKNL9QXlZPDy8B7QjrIhTgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787157352; c=relaxed/simple;
	bh=J9y6o6/dWsRxc5CPYHh8nsPbdaWeBD+YMhCu/WMFBZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OeQ9OpSA1dNERtvNi6vrukanuKN54OAmuJdKGrz9laSzLfR/dS87hQRCBToV6uaX7iwY0xmJCa7Xc4acsVPiewoTdHO3+SbmGEyXBznhT/adKOLXXoRNv0Sjpr6rEOSu4m3KbSCcjW0IruEmQL/ODvfU3qT1yTC5GSUEQRu3bJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l5zpjZIj; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5zpjZIj"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-836cb2fa1bcso19141877b3.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 09:35:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787157350; cv=none;
        d=google.com; s=arc-20260327;
        b=KdMJXIu1z0ZMmT8Gvc1Eu2Emu21km1CQXCdViYNZWZLleMYHZZ3Qr4rp12PicIq/X5
         +wKHgHWgmJAbdQ3CxZKq2yDuvx9UaY2+YMmfxd7+u4UYTBRYff0WfVypqx4NANml2sxz
         B6K2Xfv5uQL9fG19eGaymlAWddobR3h6B5yYb1wcD1oVF4GDesUt9XA5y/2VzIT3pi3E
         CIbr5BsLQtpu8CWPHZUaUCUIcRFIkTEIIN57rtRokI4xrJYc0mzLm+H/tNkZLc8pouE5
         1NvnLrWys406bxm4DWIPjp5mhqNC3Z6GJV5rCMU2FYcInLPbB70FdeJ6v3uxYEjBoDXs
         wR8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TRAkgPHFku3K+qajzjnPibaXiy9bxH0hoBjsc6qNOtE=;
        fh=EQ6QZZBUPmEdpR0lCl/R0KH/2ZVslcoCKinFuk/pdeY=;
        b=nxUxgR+o+PDtUeBc6XRqE7XtU1edtnz8GuhPl8qmgL+IXigYfoCJZBSZZ6kw+HDRjP
         BXwKKX7xHy2v9lOv1XXRAHIZZMo7QFb9ykmP+cob9ARC1ua/3xksIJP30D6Dzmw+XItG
         mRLAc4jALnS9hLL4Ep8x1HvhzES+wgIOIR3aVkxMHCoQw1bKPcg5h8SRwtoG6/jku49R
         1TYU3vrYc7icgKRkYcK/9/4v2UkHSqEVjssr7hnn0AQ1bHDrUv+TR5zXabnSspZlpNGV
         z7K/dNebMi4tOz1kHTLIrvRdzQNngrdzbFL/72CthgcJGHFlmwpgxYaNoGm/Ol243/5I
         5hLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787157350; x=1787762150; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TRAkgPHFku3K+qajzjnPibaXiy9bxH0hoBjsc6qNOtE=;
        b=l5zpjZIjp8L2tCTwSO0nFccFzOu65f55vUFNpJOndehDltwY4++5y55N/2M9FB0XyH
         /1fUNSklxs15DKH+dXsqTcTLcAH3crMZ5EVCu144eHQmqR3ubCfJGkUaAw5TTsV8zcL7
         c+IJX1OQJHPGUoIZ3m7UhHWFHiHDsq/6lG5NU0K1NDAy1zaicq2uz95Lu56Nbr9TwW+p
         FG6zMpJIXs9KJakhSwLUy3uA2rMZER3umv38CVhZpBKUWRNjfBHtFHfMiL8PiiT5xhbM
         WeHTN0oLpwV0wYv7YkYARHJepEzuLqsanT7U+PKuuyJUISHb/otmsgy8AKOdOxMNXpl5
         AgQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787157350; x=1787762150;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TRAkgPHFku3K+qajzjnPibaXiy9bxH0hoBjsc6qNOtE=;
        b=gvSGzsSJxpQMc0BUEOoYTbWt+rQgQywl+sqoE2XawK3fTz5fGdOMPQmaEDRD3JQvYV
         g71ZAB1lzGLPzS8T0SNpzSE0T5Grqb2u9eC+YOXYiyKTUMeXLLyKRsoCLCfpWft+NJ4o
         U2fg3ecOCBqVOk+Uski5T5msNbHBgmV0zhZo4NaZCYaTTsD5eH3WmKbPA8DH8JpAXp/K
         A6lRUHJMGscMaEVIp+Pl61Negp6WuIxSplvPqREO1MDvK+x5AegBqOpDsaxo3PP3m3Iv
         Tt7qrkxJQbyipxAkaxD+iuzUbvVTjQfVYnHAQOBcVyrV4plcHI+MJCwL61rk8ETbabdR
         PQDQ==
X-Forwarded-Encrypted: i=1; AHgh+RrhB4hD6x6NPVyOsWDlivxL/w4NQLUXoB5bjDEmnaOtKRiPJfEohXxemVkm3tCddGRCLnL5rA9ui/FHjWFFdFI=@vger.kernel.org
X-Gm-Message-State: AFuF++kBxxUVyLg9DhwWhrAGZlpUTS0xnVkSHObilzTHldj/jUtsqlH4
	cf0TaKndle85qdpxxGfS0//wj+GLuwrDSWiAHDpEJWGr5LXqVme0C0mGDSPiff4iIROsX41033+
	gh/K/jadaLeXHzWEIVzyDJ1jMvpzhpU8=
X-Gm-Gg: AR+sD10HWEf2SXjcTnKyQOJ+RfYMpvVuZRXvTIUI3Cwk7BYbcebAoD365DS2MzDSjEA
	oo0Vgdrxukfd1CRjEG8ABHGmsiXpktkMjS1z9p0R63HlxsaZJbtqJOhHyGi62shL2FgeZiABICK
	OG+eelwTqidN6dmyofahtahLcYDp2qAvm/gQGGnegQ03xNrwYB9HedxBjUqCFAvbDTsXlSfI9o3
	W+TzIHlxXURAj3ix0uVly3vzN+HZQkuEWKAK9F/me1nI5mPOS9RyItXe/k3Wz1SisGYoZIQ+Mjr
	NHAoa2002/qebwqwXCyn7o7OOnR1a84xanwd9E4vKw/kOn4EEPP5TyyY75jwnP5RgRs8MF1oJOO
	49CfwMNPZ15CxXHxJBICIr/KIOLQ+
X-Received: by 2002:a05:690c:e284:10b0:81f:a7b5:7f0e with SMTP id
 00721157ae682-844e3d5b9camr18778167b3.26.1787157349722; Wed, 19 Aug 2026
 09:35:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ec23dae6c247005e8eccd312d326a626163ea491.1787132512.git.liujiajia@kylinos.cn>
In-Reply-To: <ec23dae6c247005e8eccd312d326a626163ea491.1787132512.git.liujiajia@kylinos.cn>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 19 Aug 2026 12:35:38 -0400
X-Gm-Features: AcwNN1W6XuOgeA5e2OhnPyTrBuVGeEQINGGnNT6mDgRFvBtgWJXRQOG9YTogiw4
Message-ID: <CABBYNZ+Ow7XQTpM6gO_x2c9Z=jKewXk=dknxX6Ly9QZdezi4zA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Bluetooth: btusb: mediatek: Fix leaked runtime PM
 reference in reset
To: Jiajia Liu <liujiajia@kylinos.cn>
Cc: Marcel Holtmann <marcel@holtmann.org>, Ying Hsu <yinghsu@chromium.org>, 
	Archie Pusaka <apusaka@chromium.org>, Abhishek Pandit-Subedi <abhishekpandit@google.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Jing Cai <jing.cai@mediatek.com>, 
	Sean Wang <sean.wang@mediatek.com>, Chris Lu <chris.lu@mediatek.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jiajia,

On Wed, Aug 19, 2026 at 5:52=E2=80=AFAM Jiajia Liu <liujiajia@kylinos.cn> w=
rote:
>
> MT7925 on HP Pro Mini 260 sometimes timed out during reloading driver
> and reset usb device. btusb_suspend is not called again after closing
> bluetooth interface.
>
>  usbcore: registered new interface driver btusb
>  Bluetooth: hci0: HW/SW Version: 0x00000000, Build Time: 20260605184935
>  Bluetooth: hci0: Execution of wmt command timed out
>  Bluetooth: hci0: Failed to send wmt patch dwnld (-110)
>  Bluetooth: hci0: Failed to set up firmware (-110)
>  usb 3-10: reset high-speed USB device number 4 using xhci_hcd
>  Bluetooth: hci0: HW/SW Version: 0x00000000, Build Time: 20260605184935
>  Bluetooth: hci0: Device setup in 1856545 usecs
>  Bluetooth: hci0: AOSP extensions version v1.00
>  Bluetooth: hci0: AOSP quality report is supported
>  Bluetooth: MGMT ver 1.23
>
> btusb_mtk_reset calls usb_autopm_get_interface to resume the device
> before driving the hardware reset, but never calls the matching
> usb_autopm_put_interface. Every hardware reset therefore leaks a PM
> usage reference of the interface, preventing the device from being
> runtime suspended again until it is unbound.
>
> Add BTUSB_USB_RESET_ACTIVE flag and set it before usb_queue_reset_device.
> Release the PM reference in btusb_disconnect if this flag is set.
>
> Fixes: 25b6d7593a3a ("Bluetooth: btmtk: introduce btmtk reset work")
> Assisted-by: Claude:qwen3.8-max
> Signed-off-by: Jiajia Liu <liujiajia@kylinos.cn>
> ---
>
> Changes in v2:
> - Fix the race window (sashiko)
>   Add and set BTUSB_USB_RESET_ACTIVE flag before usb_queue_reset_device.
>   Release PM reference in btusb_disconnect if this flag is set.
>
> Changes in v1:
> - add usb_autopm_put_interface after usb_queue_reset_device
>
> ---
>  drivers/bluetooth/btusb.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 184e95c1625e..45a726bed0dd 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -957,6 +957,7 @@ struct qca_dump_info {
>  #define BTUSB_USE_ALT3_FOR_WBS 15
>  #define BTUSB_ALT6_CONTINUOUS_TX       16
>  #define BTUSB_HW_SSR_ACTIVE    17
> +#define BTUSB_USB_RESET_ACTIVE 18
>
>  struct btusb_data {
>         struct hci_dev       *hdev;
> @@ -2915,6 +2916,7 @@ static int btusb_mtk_reset(struct hci_dev *hdev, vo=
id *rst_data)
>
>         err =3D btmtk_usb_subsys_reset(hdev, btmtk_data->dev_id);
>
> +       set_bit(BTUSB_USB_RESET_ACTIVE, &data->flags);
>         usb_queue_reset_device(data->intf);
>         clear_bit(BTMTK_HW_RESET_ACTIVE, &btmtk_data->flags);
>
> @@ -4497,6 +4499,9 @@ static void btusb_disconnect(struct usb_interface *=
intf)
>         if (data->reset_gpio)
>                 gpiod_put(data->reset_gpio);
>
> +       if (test_bit(BTUSB_USB_RESET_ACTIVE, &data->flags))
> +               usb_autopm_put_interface_no_suspend(data->intf);

Should this be test_and_clear_bit rather then just test_bit, otherwise
it doesn't seem to be ever cleared? Sashiko also complains about the
handling of multiple resets (is that really possible though?):

https://sashiko.dev/#/patchset/ec23dae6c247005e8eccd312d326a626163ea491.178=
7132512.git.liujiajia%40kylinos.cn

Or perhaps we should check if BTUSB_USB_RESET_ACTIVE (Id rename it to
just BTUSB_RESET) and then don't queue a second time which perhaps is
what sashiko is talking about when it refers to reference.

>         if (intf =3D=3D data->intf) {
>                 if (data->isoc)
>                         usb_driver_release_interface(&btusb_driver, data-=
>isoc);
> --
> 2.55.0
>


--=20
Luiz Augusto von Dentz
