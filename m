Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03FE45628B
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 17:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786988560; cv=pass; b=j7xw8BZqe1wNNDHt09SSR/u3glZs087eHs0NeNUL4ojRFyjw73wz59Bduvqenk4HwOkN5dTJymIv72yYzhEr/vtzX2Cxb8A26LGL16rsOhfQJaVtqDHp+wAFScTF/ZQDZ9yBz7I8l7DfS7QICSwGUygtiX5gOXuybxHIkGftp+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786988560; c=relaxed/simple;
	bh=py5sQoQzN8QVO6RQX/oowl91MWw9P76SmG1bUer6xJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lfpwmbTKx10vEiD7/REnZK6su48RTzwXLUik0l+2KkTx1LrEFq8YHKF2TVh8eQRFzvHJ/hYMWiiC8Zm4Cs8FJtV0Gu/TvhFAgLFoS3wHebsnEdfa0YAMtzgaSw8Sdy58xirBwMb3wKFjyA6PMuCVcAEjEEEcOZ5LHuQx8I4MTkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XqK6fP81; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XqK6fP81"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-66cad42593dso1127394d50.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 10:42:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786988558; cv=none;
        d=google.com; s=arc-20260327;
        b=FpwBtGLgNWkg5zH0NazOjDxnLmqhqgPSBHrwsWjS7yBrQq44x89o7zmHZDNy1luCV/
         +aDFvoRDS81OtkboCf9DAfwyYyHuZoEz7924eabYWX5XZcLIKPdDMH4Gfxw/owIjVfGI
         lw2D+9jxSSN3SiC3ERDetQdFKp5knIptRYdvZOaLVqSQ4wSVh8NTd+KpwDJyaVsL5Qbd
         votBFHztlFEj4FtStohUN2Brmp19y9LYTR9Dazn7Qc/afGgqjTcIXjXqF4ccNTVxMI7/
         mGUWnLN0oAz3EMKHUCGPiWZHKUwxS7k6zz8r2v6kfaO2k3PU1IowpQSQAQrDBn6vhyVV
         FVng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FkLUzGUcrjYuBwFtQIWuVlWp9HJK2QnBFMiBnZ+u74k=;
        fh=/z2HEQ5XafIYm0GAaOVRlnrZelsTuYiLcQduTLXAIVs=;
        b=qNqqldKdvUEjhM8gx4Hvqetql1EufbX+iXSjZ0g7N+wjikM6ugeDqDjKGzL2PTwmyJ
         98UcaSpEs8KevN+RH7lJO10GFQ2uwaPhU9TxG9cwf4+7neVjrG69E2c6XoucPxPnMHF7
         QbUrROqwKrfwq6ZBfoogMVLxY55g1tcDc8xp86TfFtCYaWXde6AKKPQLA01OYmBX2Zrx
         inh9ca1wIlrVLD6Uv7DjJ4x1sZszhmq0mezJG2Gs2ydAYejPZuulWxYKHWmhddIMKmpP
         emH2VFpRZ4fxAOmay8xcptOhmZ0Du8u46eEQAn6Cpm3EJpYy1JEIB3DFvXrgPCEB1lwQ
         7rbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786988558; x=1787593358; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FkLUzGUcrjYuBwFtQIWuVlWp9HJK2QnBFMiBnZ+u74k=;
        b=XqK6fP81x9YzQgbeiozrnhL91e66YhVbM9Cp47YG/VUPZotKg05smEe4QVn/t4brfr
         TE0XhApzo2+7qDazkjvcWE4+i3hSkjHSZs4n3j5h4WDGH5+EeyF/m5l530rZ/NYcwQzc
         lQGU3i9dX4z5jagVul3cP7rxYTWzWrkNSUEvbaTQM8s9O4Y8sQNzycB1GxoIVzc1b4KX
         Ti/dA9rfE3OY9YYodk4NBWmbUIefjz8yPf9JuCmBdGSSbfAaYMK/l77usPYQiUK8+tLb
         tAgZ2Y2DwK16jC+fkqHOMA4Vl2CKTcQtP79gzKG3NbNDCW5p9be9DcJGIXU7r11uHDLK
         qUBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786988558; x=1787593358;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FkLUzGUcrjYuBwFtQIWuVlWp9HJK2QnBFMiBnZ+u74k=;
        b=AxcpcS6GeDUMMQaiC7uYkPAlJSls/yzMDfKB5zvDgep8GkoLT1ercQOnxzj9DhBI00
         6rClR2jRZS6tLNLQtixzI91crcIXUznjAuql/FhI9q4WDcB9S/m6jeO0hoUt7G6D/DET
         jfSXse2ux+PH5DBJ5MpwYsOxfIFrSwps5CJXW1mMBx6tUtVaGfaku0Hzg3r1GCkeIiSi
         iOOkOVsrr0lRzB5USKEJis9oqHZ1GcuevwNZU7+q9JQiuncp142K4p14ruHM5t4El3lv
         cHn4k0OTvK/5Yf4IpXY9aSToYmNEAiHDOHFmrA+DV/OSGeQ3vD4u+1aIBMElY7uTe5gd
         BmnA==
X-Forwarded-Encrypted: i=1; AHgh+Rqtm7ajo6BIQXkVQ5wDRbvto/Zq0APdkiVudUdpJAiY24xmdhl3sOUbu/tEtEzQ8OMV/R1+QHMhsNbQV1vOvfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqeuYGrrNadEECw4Ke1lvLjXI16e3FB+YEcQkm9qxR2xcWx1si
	QRBgwxgE/2ylFcdMbd99h1buwuq/4XyLVfQdVNHJTYU9KpfW5zVEidJI0TMeLaXh5H4m/JhlP1b
	UC1WkIadsVRJiFIcv8XmXzs8ZN3IQGL4=
X-Gm-Gg: AR+sD13MO+XQrs12c1HW6902TITkma2m6jl7eJFn434eHz1cmJxJKjHWGJlUgXMd2UT
	Hgp4vFFvzDJntwB9fXrR5fgcYrqtRX7f7d9YGf89pEp9I/6xw0O0kS+gevqEmdfSlru3dW9xmAH
	AhxRy1YNPIfiEL87TofLzSqqAEZLEdB8ftEnewZtRJdX0Tq4hKcZ4ZGhR0pbzLGoKqLBJIYgiNI
	iOZ6HUPW38gJIxATwG/Gllj0CBMXrQqA33mLPOPFW+qP+SN+sdSN+++d1WD6RYVCQ1BDKLPYg5f
	OBZnM+qLabi3nOWGdhMeL+ZkZgATtkfmyYOFsZ8VRAIMVica5/SmmVRfvcV7pNY+KNecDOan6g5
	xPnAvyLhDb1xcifiJIkjRoyENMfodJWs=
X-Received: by 2002:a05:690c:60c7:b0:812:996f:176f with SMTP id
 00721157ae682-8370d9e0573mr87345337b3.11.1786988557548; Mon, 17 Aug 2026
 10:42:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260815033346.15882-1-andrewbille@gmail.com>
In-Reply-To: <20260815033346.15882-1-andrewbille@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 17 Aug 2026 13:42:26 -0400
X-Gm-Features: AcwNN1XrM9yJKJI-pUKg_fcRvQLM1qaf5RIOI7UnpDk6HM2pmlgJym67nzlbass
Message-ID: <CABBYNZ+AWzMR2O2XLuk=GC+aHqYE9Adi6qdZcZoJ5VvPfhaL7g@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: treat 0bda:0002 as a generic HCI device
To: Andrew Bille <andrewbille@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Daniel Drake <drake@endlessm.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Fri, Aug 14, 2026 at 11:34=E2=80=AFPM Andrew Bille <andrewbille@gmail.co=
m> wrote:
>
> The 0bda:0002 Bluetooth controller reports itself as "CSR BS8510"
> and exposes a standard Bluetooth USB interface.
>
> It currently matches the vendor-wide Realtek quirk and is therefore
> initialized through btrtl. The controller does not respond to the
> Realtek-specific register access and initialization fails with:
>
>     Bluetooth: hci0: RTL: RTL: Read reg16 failed (-110)
>
> No Bluetooth controller is then available to userspace.
>
> Add an exact match for 0bda:0002 before the generic Realtek entry so
> that the device is handled as a generic USB HCI controller.

Okay, but what happens to the actual device with id 0x0002? Have you
confirmed with Realtek that no other device uses this ID? If another
device uses it, this change will break support for that device.

> With this change the controller registers successfully. Scanning,
> pairing and A2DP audio have been tested successfully.

I may fix your controller but if breaks others, it is not a long term
solution. To be clear, 0x0bda is controlled by Realtek; putting a CSR
device under it invades another vendor's domain.

> Fixes: a2698a9bf9b0 ("Bluetooth: btusb: Add Realtek 8723A/8723B/8761A/882=
1A support")
> Cc: stable@vger.kernel.org
> Assisted-by: ChatGPT:GPT-5.6-Sol
> Signed-off-by: Andrew Bille <andrewbille@gmail.com>
> ---
>  drivers/bluetooth/btusb.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 184e95c1625e..fb9fdf90a3b9 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -615,6 +615,9 @@ static const struct usb_device_id quirks_table[] =3D =
{
>         { USB_DEVICE(0x0489, 0xe130), .driver_info =3D BTUSB_REALTEK |
>                                                      BTUSB_WIDEBAND_SPEEC=
H },
>
> +       /* CSR BS8510 device using a Realtek USB vendor ID */
> +       { USB_DEVICE(0x0bda, 0x0002) },
> +
>         /* Realtek Bluetooth devices */
>         { USB_VENDOR_AND_INTERFACE_INFO(0x0bda, 0xe0, 0x01, 0x01),
>           .driver_info =3D BTUSB_REALTEK },
> --
> 2.47.3
>


--=20
Luiz Augusto von Dentz
