Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E517223C8A2;
	Mon, 12 May 2025 21:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747085891; cv=none; b=WvfLrdjrAw2Fm4NcOcaW3WToAwj1DTX5FPyiv1ZlI4SI9zZeP8KGqS9vgyCnq3VlmT55871+xHixaq/hVOa4OQLABweui7zeXn5RKYsTpOTMjuSyUfceja0uIPmnIW/tj8ph61HvlWKWe/NwngbC+mYT9Ar/7ARh3LUmB1dvSAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747085891; c=relaxed/simple;
	bh=rkk0jVTiftBqRqcJbbat2x1LR2ChSVnTkK5OpE/QubA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wz5pVZEa+r89llft25/+s3ikY7O+b97M6XHge3uTn7b1GRo2w8RUI31Ggq7n6G2uABlYBKbyVkmYTHCN67Tv/LTOD3EEiYuzZv8cR6x7/KALwzUhX8QeE9uIZos8+5nwtkQSm062TSgHOHr5jewOlCiLY/228SoW7yuLICEhP+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F0H6OFBK; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0H6OFBK"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-54fc80df9b7so4673622e87.2;
        Mon, 12 May 2025 14:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747085888; x=1747690688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xj9wmVOqmHU5f2m/KQnXVsrAMkJ7mytCdgaBUvMqQzo=;
        b=F0H6OFBK8Hy6IWqSAXwBLLnFU36ix75IsshCSWGiOhIT5yvKEb9MT9abBMkYSxe/kC
         7wacfxynaaZaCdrZ0kDdSp0tXGovwOYHNgaSe3/WkhEUjMc9U7qTZWxwjgrtn6PydRSL
         5twKp03YJJDDh20Xp7Da8Oi4mw4VWcliexzVQWFGT+NddMCgfzuOQUcnSGUFRsAJRvvH
         SrGCZObmd5Npcq0Jjog4a/+Dz/X2j4iO2XywI+7FQFVpkI82u5oswqUn5KsHyjudXUcU
         DrEsuCnask2ifuKETPiuzr/E7D/oz3Z0M/gkGkea59YiW0SOjlE7aC+rWPNGe8VaJxhP
         MkUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747085888; x=1747690688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xj9wmVOqmHU5f2m/KQnXVsrAMkJ7mytCdgaBUvMqQzo=;
        b=HpYGLIhEGnQVVpeUw0HLaGgW2RLC9GtqggNwAIQTkzqo4gsGVG5uMuSKrYULZE08Ey
         qfqSOAwt3uQvRi8+7Hz03wgwo3HPfQ/iJf4oI/rfSXVKM6nt4o/hy8Q2Yww34orI+toC
         tkPotW7KMX6pfWsglWpAsOW5GlFTma+CgGlrpeIo0A4ov1AXvd46tPux+2J5fg/BVo1K
         hnt/uZh+Bltps0ij43znESKXsWMvOfopVImRXThi3mZm6Cd+WSP9ebCbaLYM2J6BwZJK
         NTmgI1oNaclJ28aIlvzM8M9bIVx624v9BCAL8Z0iGkYvMFsVkImstOHvWgJbcpkB8b9I
         fcOQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0JZZFiyE0Dhhqo2pyAsKocCtAoyjRqNgmbt5q0SvNOKlB69r2uFOcsHPHJ95v1dh8x8Obz+baGBUyCYR+sjA=@vger.kernel.org, AJvYcCWKLQJE51+n/RniQod+VnKtaErO2SVFbItbqdnEERlS+hNznXXPYuJ8L3ZGLFgnLmkkhLee8JFi57RIhCTi@vger.kernel.org
X-Gm-Message-State: AOJu0YyxbcjpRwpjZhI9mTnAmVtFKAZneAhhEtMy2/AQDwNdqu/LgyFE
	4jocJva5BQFsUyjwWlQzMplwi9fo+MASnDRW/oSNDXmfGB2aWYohx/NtdIqe3KioOnoabuE3qeL
	n1WqQ1VH2ugn12oXRYJGBDmndlao=
X-Gm-Gg: ASbGnctgNPINjiKqZgSQ/r8NSmYHirmX1mAGknHag8K61+dbKek1B7B4yxvnsr5lvOJ
	eHKu/YxSV0VY4pbLBhaBiSXqj4xbnQ/cOv71VW94i2inf/Cm97OKkwAtAoG3BL09anfT6P4vk5n
	eocXmWVhhpgHNk+KslJgJqnbeuhN7peZM=
X-Google-Smtp-Source: AGHT+IEUdvTDYCSdrEmacogKYaTqucHyiNyz284YOLXriy5PdLL2znB0mwZQxdKAK4KuuTSIojrKFSBlveDRFC+D3Hg=
X-Received: by 2002:a05:651c:a11:b0:318:7f36:da6f with SMTP id
 38308e7fff4ca-326c468182cmr59397401fa.26.1747085887523; Mon, 12 May 2025
 14:38:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3fbcee73.2408.196c254dd8f.Coremail.sunliweis@126.com>
In-Reply-To: <3fbcee73.2408.196c254dd8f.Coremail.sunliweis@126.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 12 May 2025 17:37:54 -0400
X-Gm-Features: AX0GCFsBA2wu80RDZIB-rmA9GKwjR72u8rPW9piid1BrUHlNnInCguDcbDA9_FQ
Message-ID: <CABBYNZKT1BOrt5uuK6fDTvV8f+eyd=ctUR-SNXg5G9SoP6Wsnw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: Add new VID/PID 13d3/3584 for MT7922
To: Liwei Sun <sunliweis@126.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Liwei,

On Sun, May 11, 2025 at 10:31=E2=80=AFPM Liwei Sun <sunliweis@126.com> wrot=
e:
>
> Apologies for this re-send. It appears my previous attempt to send this p=
atch did not successfully reach the mailing lists (linux-bluetooth@vger.ker=
nel.org and linux-kernel@vger.kernel.org), although some maintainers may ha=
ve received it directly.
> I am resending it now to ensure it is properly distributed to the lists f=
or review and discussion.
> If this one still fails, I may try another way to report the new hardware=
 ID.

Not properly formatted, use git format-patch + git send-email, see:
https://www.kernel.org/doc/html/v6.15-rc5/process/submitting-patches.html

>
> From 4bee2ec5648c48ec5fe62b230caf26985398b0e0 Mon Sep 17 00:00:00 2001
> From: Liwei Sun <sunliweis@126.com>
> Date: Thu, 1 May 2025 17:27:59 +0800
> Subject: [PATCH] Bluetooth: btusb: Add new VID/PID 13d3/3584 for MT7922
>
> A new variant of MT7922 wireless device has been identified.
> The device introduces itself as MEDIATEK MT7922,
> so treat it as MediaTek device.
> With this patch, btusb driver works as expected:
> [    3.151162] Bluetooth: Core ver 2.22
> [    3.151185] Bluetooth: HCI device and connection manager initialized
> [    3.151189] Bluetooth: HCI socket layer initialized
> [    3.151191] Bluetooth: L2CAP socket layer initialized
> [    3.151194] Bluetooth: SCO socket layer initialized
> [    3.295718] Bluetooth: hci0: HW/SW Version: 0x008a008a, Build Time: 20=
241106163512
> [    4.676634] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
> [    4.676637] Bluetooth: BNEP filters: protocol multicast
> [    4.676640] Bluetooth: BNEP socket layer initialized
> [    5.560453] Bluetooth: hci0: Device setup in 2320660 usecs
> [    5.560457] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection=
 command is advertised, but not supported.
> [    5.619197] Bluetooth: hci0: AOSP extensions version v1.00
> [    5.619204] Bluetooth: hci0: AOSP quality report is supported
> [    5.619301] Bluetooth: MGMT ver 1.23
> [    6.741247] Bluetooth: RFCOMM TTY layer initialized
> [    6.741258] Bluetooth: RFCOMM socket layer initialized
> [    6.741261] Bluetooth: RFCOMM ver 1.11
>
> lspci output:
> 04:00.0 Network controller: MEDIATEK Corp. MT7922 802.11ax PCI Express Wi=
reless Network Adapter
>
> USB information:
> T:  Bus=3D01 Lev=3D01 Prnt=3D01 Port=3D04 Cnt=3D02 Dev#=3D  3 Spd=3D480  =
MxCh=3D 0
> D:  Ver=3D 2.10 Cls=3Def(misc ) Sub=3D02 Prot=3D01 MxPS=3D64 #Cfgs=3D  1
> P:  Vendor=3D13d3 ProdID=3D3584 Rev=3D 1.00
> S:  Manufacturer=3DMediaTek Inc.
> S:  Product=3DWireless_Device
> S:  SerialNumber=3D000000000
> C:* #Ifs=3D 3 Cfg#=3D 1 Atr=3De0 MxPwr=3D100mA
> A:  FirstIf#=3D 0 IfCount=3D 3 Cls=3De0(wlcon) Sub=3D01 Prot=3D01
> I:* If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D  16 Ivl=3D125us
> E:  Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> I:* If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
> I:  If#=3D 1 Alt=3D 1 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
> I:  If#=3D 1 Alt=3D 2 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
> I:  If#=3D 1 Alt=3D 3 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
> I:  If#=3D 1 Alt=3D 4 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
> I:  If#=3D 1 Alt=3D 5 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
> I:  If#=3D 1 Alt=3D 6 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  63 Ivl=3D1ms
> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  63 Ivl=3D1ms
> I:  If#=3D 2 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E:  Ad=3D8a(I) Atr=3D03(Int.) MxPS=3D  64 Ivl=3D125us
> E:  Ad=3D0a(O) Atr=3D03(Int.) MxPS=3D  64 Ivl=3D125us
> I:* If#=3D 2 Alt=3D 1 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E:  Ad=3D8a(I) Atr=3D03(Int.) MxPS=3D 512 Ivl=3D125us
>
> Signed-off-by: Liwei Sun <sunliweis@126.com>
> ---
>  drivers/bluetooth/btusb.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 5012b5ff92c8..9850272e83ef 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -678,6 +678,8 @@ static const struct usb_device_id quirks_table[] =3D =
{
>                                                      BTUSB_WIDEBAND_SPEEC=
H },
>         { USB_DEVICE(0x13d3, 0x3568), .driver_info =3D BTUSB_MEDIATEK |
>                                                      BTUSB_WIDEBAND_SPEEC=
H },
> +       { USB_DEVICE(0x13d3, 0x3584), .driver_info =3D BTUSB_MEDIATEK |
> +                                                    BTUSB_WIDEBAND_SPEEC=
H },
>         { USB_DEVICE(0x13d3, 0x3605), .driver_info =3D BTUSB_MEDIATEK |
>                                                      BTUSB_WIDEBAND_SPEEC=
H },
>         { USB_DEVICE(0x13d3, 0x3607), .driver_info =3D BTUSB_MEDIATEK |
> --
> 2.49.0
>


--=20
Luiz Augusto von Dentz
