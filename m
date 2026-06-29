Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31CA303A07
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2026 17:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782755818; cv=pass; b=dfDulwyw8+WAq0Bub9IJ86ksW8OEzusrQiKnKAQkFd9QMj+zgQEyjDUlijmjMcOhntV4qMny9uZ1Q+l/ogNnWtfrwX0/sc0uxQ1Jgg3yYiMb7XPCcSgIyH9ycQ+e8q9vFuy3iMTD2WzTt4D42Hh3UkUkHSrV4y0O+7ghhsc22mg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782755818; c=relaxed/simple;
	bh=fVxAEU/j9nlYhsTdr8kCi5ri6gQcS9AjAEJJPpWCGlg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ubULhsMdgvldy8Pne+NwXn6xI82qMsCONJLXLBN/1wutdaQ+kevdL2hHV7w4NJ5zkw+el7QG1ZWZ7ghJdJNV1s6DjBMF1A8EWGGmCtYkPVG8wSjs9BhNrCE/wzzkh3V6s9RgJ1C7y1FfYi3XCGRpj+mdnMH3MdeK9+inuBbVL/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cYYk1AmF; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYYk1AmF"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-664a09bc459so3327510d50.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2026 10:56:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782755816; cv=none;
        d=google.com; s=arc-20260327;
        b=DNWEZlcycSWLmxA9TIFoGZaCiSDKRwLcSt/uZ23m1bO0QT+2NbCXM1aQp/fTM1s5G5
         FF97zElPZ1PqPjRI+hYvh90rFMvoK7NgMEkNoVhR5cwR3RTXm0p5m/wB9tjpa0pjtOg5
         6RpQOt6broGR/LvHXLFulZh/HkGR6T+WPrpnW9ZsfnreHTuBGTLsvSFfUuIAXDW+KMNF
         b+W2t0t749swUqHcJ9gTNLtCHmSHYS5gMPsDefp+YgZy5A2bxD0l2CxmzfgPF9hyKMVe
         7CZVzRvv7lpzclDb3OYu6HYbhDHEIhD0OZqqkgBTFndLtGur1dbkFT00QnaYp+T/5Yg6
         bUFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wzKcI0M/3cWSz6/qNk9yJa+jsgNFkdL9PaG5O5CKx3c=;
        fh=f67XxzPrGVZ1PqxhAKYn4i5HCImqmaYFojVAH2UZcCs=;
        b=kdLanC7rqampip8mDi7JKCIpH2mD8k9sS+pDI0aK6+1lC3x4yNxLkfNeROCIlsPXKi
         /CWCCNG0LpEPkVRoIOCj9fp3ip4P8pu0LHmbRiS8H+QjsQoBs3Hrlao2N7SCw4AKbHK0
         Jdd67PWd50onCnv2whQbdlbTxCKhdzwR2/4awPT71yo6+StCsyj7k3cIb0pMjrOQ5vG4
         FMPu/dnZ7D7oVIDz1568mgbfk/QZLX90ugoOlHQGz1lD2PQOEu+tuixbpfWiKyhbpZ9o
         ZiHjOBubrEEBXgRWnG3p6FbdiQslx3HUi8scCGyq952nb1V3QjHCZMwohpHUefZ3Klbw
         /mVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782755816; x=1783360616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wzKcI0M/3cWSz6/qNk9yJa+jsgNFkdL9PaG5O5CKx3c=;
        b=cYYk1AmFhsViEpyTXi0gggUiFXdBGNQViGNdGD+QlZH6Z5RyGtqIv04Ua+b0/hQiTr
         JlXSXwovz/Q3Z12VfTEIUH9HgjkoujZHGlmFAMAIua5OBHQJmr0YmVshhR6CA1Trx9QW
         B2LjfBcmUoMAPe4nqkzP5wACIuoE1xQzFw7C2AzDg6luBgcOT08QTOMTYOpaBWkrgkz7
         tv7HbQZ8309MVJY6ttgGfqpb3fHWyUA1YLRnktA3GZ2vbjQUAEQnZDvudiQh16j0Xt6p
         fQ0POK5xwzV+Ou4TziMKmrrBl/X8KhrfbbzrZWkHIHEns/ekRaVOQtLZ/FBb7mfv9sDL
         eTYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782755816; x=1783360616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wzKcI0M/3cWSz6/qNk9yJa+jsgNFkdL9PaG5O5CKx3c=;
        b=iIWFSWXWryXFHqoTjK7JFmO4MT8JezaibHkAqJteuyHZTznd9FcpoiBezpEIDQ4bXq
         87DQn+d4Poy5cwA3R5nPY3LstJFoupJrtt3fFMEVhSVOdwCitexKj2CDVE4KohVe+1nb
         tPbQFBfy+dyishvZYEpSVkQBAeshTI8tjfBZ7ocQQs0/tM7J6eb4hDW+Fy2u6DMLMxrn
         xkf/EbDnvRbdMYguV8sX/g484kDOIlvQpGjcTFTqQu7Q85B1d1RY9AIKTeVyd9e/HI6s
         BAx1ElSyUW4CKWpb9hKulmYltNYcDhi2kQ+dZVZIxLtwu/sIayNsBGvviAJHdgAC0qUr
         cVrg==
X-Gm-Message-State: AOJu0YycRd+8dsvf7rWuajySAFIUgsIkuaZ35F32vwvxr4ZWkT0WqiGK
	L3EakB7A/nASWd9TcMQ6DmboTkoU30mNKHRWyJ04JlpYC9xzkxC9AMzGNsDQKVXbqqwmYSc7zqP
	BSTls6Ko2WE6z9Bz/D8NeuJfUBpbf0RQ=
X-Gm-Gg: AfdE7ckaipf2LyAyR3QeY2PAciF39FVp9tttyhdBhAj77Jgbp8a9nvdQKycprda7CAa
	shcrs9lKyXZFkyDfmZrfDn6lOo93SbE4AtRXOJ5vpLdBvHB7n1rgVPjC+iLyc129B06Bvg5CG3K
	MrFStzxz3OO//kihNei+Jea4FZIzeNPlCRNf980kSmb2O8anp/twQNHaurxOd56kW3ja/LWXDp4
	SFc77otJE2C/hGnhzYdMU9wFoN6s+54fTY9ZuzMYJMmLTM9rd5EYjcvvizdAyDvKBkL6xuROoHo
	Qa3Am/2diF1CWCx9ezBnEAayhaDdSER8/5/f3hwZszjj0Notr5pLJLKZuOc=
X-Received: by 2002:a53:af85:0:b0:664:b703:bbd2 with SMTP id
 956f58d0204a3-664f9a35be8mr526823d50.47.1782755815889; Mon, 29 Jun 2026
 10:56:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260627153505.20173-1-silurust@gmail.com>
In-Reply-To: <20260627153505.20173-1-silurust@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 29 Jun 2026 13:56:45 -0400
X-Gm-Features: AVVi8CeSBMfyPRy_UIDcAiGCtJu2dOdiICun_kHDLZ3NK1eblicNzehabb1fAh4
Message-ID: <CABBYNZL=TB=jNi+6TmdQycjdL4rziy2NECU0r+eLgS49rCqy9w@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: Add IMC Networks QCA9377 to quirks table
To: Tibor Harcsa <silurust@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tibor,

On Sat, Jun 27, 2026 at 11:35=E2=80=AFAM Tibor Harcsa <silurust@gmail.com> =
wrote:
>
> Add the USB ID (13d3:3503) for the IMC Networks Qualcomm Atheros
> QCA9377 Bluetooth controller to the btusb quirks table. This
> device requires Qualcomm Rome firmware and wideband speech support
> to function properly; otherwise, BLE scanning fails with HCI
> unexpected event opcode 0x2005 errors.

Need the contents of /sys/kernel/debug/usb/devices (use git log
driver/bluetooth/btusb.c to see what it is typical output).

> Signed-off-by: Tibor Harcsa <silurust@gmail.com>
> ---
>  drivers/bluetooth/btusb.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 08c0a99a6..7963fd48a 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -297,6 +297,8 @@ static const struct usb_device_id quirks_table[] =3D =
{
>                                                      BTUSB_WIDEBAND_SPEEC=
H },
>         { USB_DEVICE(0x13d3, 0x3501), .driver_info =3D BTUSB_QCA_ROME |
>                                                      BTUSB_WIDEBAND_SPEEC=
H },
> +       { USB_DEVICE(0x13d3, 0x3503), .driver_info =3D BTUSB_QCA_ROME |
> +                                                    BTUSB_WIDEBAND_SPEEC=
H },
>
>         /* QCA WCN6855 chipset */
>         { USB_DEVICE(0x0489, 0xe0c7), .driver_info =3D BTUSB_QCA_WCN6855 =
|
> --
> 2.54.0
>


--=20
Luiz Augusto von Dentz
