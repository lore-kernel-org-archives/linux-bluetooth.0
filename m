Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7515E3803D2
	for <linux-bluetooth@vger.kernel.org>; Sun,  3 May 2026 08:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777797843; cv=pass; b=McHnGRRI5j7FQcgnFuGPvMwlFiycY5VRefG/GmmEaiOJ3KUoPg2e2zf0PjoDbVyrSgFq44RD5I95jVmLx8JKk/W31dqzb6WsVYncV8Lvc/mhI4o09lL8gGchGEFhEvC9v4ha4ZfPq46JgEHk3oQa/jc57qQGqjpOpxACWH8DMRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777797843; c=relaxed/simple;
	bh=BiaFvCJmh2smYr9xmo+NywlmPCx/uXLOhH0s0FDB6rU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WrreSBghaLR3X/MDQW8A514K0YIOTownFpZNKMR10C9gjH0g4gKKg6KWa4j8Colt5+B3xULVc91GrOPqmMtbhVNc66VlWv9ahgoBfiDjsyFr1UXioWaHMebKbFzB1rgYp+8AlAIzwcyTYf7ARE0idpW6cb3s1GsrhoNyX9/79Do=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mwR10ggw; arc=pass smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mwR10ggw"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-82f9fdfc965so1339322b3a.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 03 May 2026 01:44:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777797842; cv=none;
        d=google.com; s=arc-20240605;
        b=NTVWMJPk2iypsx6CFotrfLdsoL17yTSQUBqBbPTvBBFTfG98nRb8U4tkfMk/Mv5CWO
         YmwCTpHmF43H0AZBlVRsmRhoN9G4qeaKZyhq+vXeTzQMSKW8Nb9BuL5ZYW334rdG/1FL
         OpYoP1WfQOFuCtvQoMZSyTm/wxoAtGT5faQX1VIT6fmtuoCkBepko8Qut12xP9Hj9EAX
         5a20K/Y1oSVfDoVMQH0sSB1xvUR9unZEwghN5wjccKLFasCCGF//xrgEkHQNddtZ+MrZ
         S3o/e04bUu5mvxAibIKgHvDw9fTknpbi4LAbsYL7CnEaK0YDhflPEMAYl1opl9es3Ydq
         Ha0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MI1A1UFPYZfvPV8oo35iianwafnkNQWOMiPqsUJkuBY=;
        fh=yo37bdNQkYcLaPvhnXwfo8pXGK8gY8V/j3CWECigDMI=;
        b=SdaL6+PXa765B6hhby/SGcHKGGwVYb5DUwPodLh3mKaYP605d/gN1viTzg9+QSMeUX
         tRdgZufuACOghkbkjnzLjV/EYPoDVE39wVf+usmObCrFXtvv/KJnOQ9GbW0wv3HtlV/f
         ZPTE3AQD5BHKW4vm9dKgE/sCYrc2IZNqvsdJ+Hd7yCmWy+0wiJnq9KhfwPL3/QLyGPFf
         0ndEdnm1ICtOIHSgfbBIdZextZuBs2CozmpEr9KQwTsercsSlL/DRecz9Zzs7rdcx3jx
         YBXOtdJkk1VFaZtqOmLnrAgH94zkQf8PUGzd+V66l9gWpQdIipTz66yDfuqmLc4V7c1k
         Llxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777797842; x=1778402642; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MI1A1UFPYZfvPV8oo35iianwafnkNQWOMiPqsUJkuBY=;
        b=mwR10ggwWmtdG/u+/UT1wunjwKCKlzbpeGnXcailMKe7G5bzi14UJgT7GAcLPlcByG
         XAMOwEccpQgKZReXmv0mAJ4K1dYecxbz1q1d4nX45dZ0I3I7YawFa9Oy3IZqO/nCqLKc
         IgcAu9b3W8Vh3AvKZPH5i9jkd9ay5zGI8RpYQ79SIM4ePAA5nOevghMniv68aSTYdf8o
         Abw4tq1whpGEL8EGADcShwR3f0GX8EflU/2PDMEuU2c7V9fG4idZZf7VQySEfa9nT51M
         TvpD8oXVGbAYlyzsNVA8HEQbvpgGL8iMfu1eeAu6IwQQ3YlSGU5qo+2zkYYXch2hSGK4
         cBuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777797842; x=1778402642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MI1A1UFPYZfvPV8oo35iianwafnkNQWOMiPqsUJkuBY=;
        b=jJYwJhdOg0IUmFgvCizWqt/9h9u4XU1iLAXndZ6YaR7yE6ShgqFI3nHq2UW+MxRD8Y
         84aD8bB11237zDehFuQ7SEiRI44l7voUKE155MIcfPF+dkoxSWaunVfjTHwsovzOXQyo
         Pynzk3Wo+sWyv8DvHpxy+ugVDbSe1OyAE8hXbVZPyTLm2d/NOxy1rX12w0lFziAOZupl
         HzSpsc3zan3P+a1+GD8fizZm2z79m1o6cpJE/YWP09HqqQJm9W/eCb7/P2yuCHAVYDe/
         2y57ptApotM5IU5dQnMNc3XHrI3lufA2R4fnidoVulUz05KxyLGMX0Vjz9owmVMHCIFF
         8Sjg==
X-Forwarded-Encrypted: i=1; AFNElJ/EOW7UqP0aIbQzgN5t+JvVuE51W61wdC7J2/zY3DOGDx3xziAvgj2srYXz3QOGv59QqbIkumH6STNI63ZT6Gg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyERTAzNLNON9B0l1Ww93WBlyQ6ogFA3SnvmC1fS46zIbBB1zR7
	J1Aw5XgYvVOBC3e78QT+eoyCTvpgxs1FmkLTfvTv4jcmhaFUZwp/asW0wGIWp6c5v+tDLwwzJlp
	6iXVSqN33d4U9YtxO3rxtXM6TlJ0RFQA=
X-Gm-Gg: AeBDiesFQ7limdyY0ShpMpUoGYU3mTh+JvbuJNoe8GSNvIvB+4V2P9zk0mxtSpgVp3J
	OHhFSpzgFGJx2/ZFM0Lg7KkDd908/iVFdSK5sIXJbUbBARhung+Lcj7fNkbU7RPlwM8Zbqr7802
	3WPB+sjSaaOix9JNeZSHz3YgvEwAJnUsSVA9nR5yVYKSBQ08pDTVZ9xe+Z+ts+DNY6QU2rRuCAr
	nNUX/f5SOtgZnk+95vdQk67sbBuML6Mfq47fYfxXlf9En10o9SCXrI7y8nXU3IZg9w4St285Itn
	PFui8GvNqotIpCySsg==
X-Received: by 2002:a05:6a00:4487:b0:823:9b7:9c0e with SMTP id
 d2e1a72fcca58-8352d24ab51mr5238945b3a.34.1777797841666; Sun, 03 May 2026
 01:44:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL2ecxgBeZNSSuwJROmuvGFsajjpxqV1+LYnoz5dYGUPA30HeA@mail.gmail.com>
 <CAGp9LzqXKwJf7=bFuv_gW9yFH7uBuXva398TC=XOrZkyd-ermQ@mail.gmail.com>
In-Reply-To: <CAGp9LzqXKwJf7=bFuv_gW9yFH7uBuXva398TC=XOrZkyd-ermQ@mail.gmail.com>
From: Kirill Shubin <kirill.kz.902@gmail.com>
Date: Sun, 3 May 2026 11:43:50 +0300
X-Gm-Features: AVHnY4JiNrQcMhNqrTmLQXqOeUArDUsHBNXUmogxuJicF9bAQHuGZvVpYQt98lA
Message-ID: <CAL2ecxgVHBOF2Na-xen4yRCjt7+x1YYtZSp8XLw8m7a0ZJspJA@mail.gmail.com>
Subject: Re: Bluetooth: btusb: Add VID/PID 0489:e156 for MediaTek MT7902
To: Sean Wang <sean.wang@kernel.org>
Cc: sean.wang@mediatek.com, luiz.von.dentz@intel.com, 
	linux-bluetooth@vger.kernel.org, 
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sean,

On Sat, May 2, 2026, Sean Wang wrote:
> Could you help get the USB device information from your test machine
> as the following and reply to the mail?

Sure, here is the full information for 0489:e156 from
/sys/kernel/debug/usb/devices:

T:  Bus=3D01 Lev=3D01 Prnt=3D01 Port=3D09 Cnt=3D05 Dev#=3D  6 Spd=3D480  Mx=
Ch=3D 0
D:  Ver=3D 2.10 Cls=3Def(misc ) Sub=3D02 Prot=3D01 MxPS=3D64 #Cfgs=3D  1
P:  Vendor=3D0489 ProdID=3De156 Rev=3D 1.00
S:  Manufacturer=3DMediaTek Inc.
S:  Product=3DWireless_Device
S:  SerialNumber=3D000000000
C:* #Ifs=3D 3 Cfg#=3D 1 Atr=3De0 MxPwr=3D100mA
A:  FirstIf#=3D 0 IfCount=3D 3 Cls=3De0(wlcon) Sub=3D01 Prot=3D01
I:* If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D  16 Ivl=3D125us
E:  Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
I:* If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 1 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 2 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 3 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 4 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 5 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 6 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  63 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  63 Ivl=3D1ms
I:  If#=3D 2 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D8a(I) Atr=3D03(Int.) MxPS=3D  64 Ivl=3D125us
E:  Ad=3D0a(O) Atr=3D03(Int.) MxPS=3D  64 Ivl=3D125us
I:* If#=3D 2 Alt=3D 1 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D8a(I) Atr=3D03(Int.) MxPS=3D 512 Ivl=3D125us
E:  Ad=3D0a(O) Atr=3D03(Int.) MxPS=3D 512 Ivl=3D125us

> I will send the patch including the VID/PID
> thanks

Thanks for your help!

Best regards,
Kirill Shubin


=D0=B2=D1=81, 3 =D0=BC=D0=B0=D1=8F 2026=E2=80=AF=D0=B3. =D0=B2 02:17, Sean =
Wang <sean.wang@kernel.org>:
>
> Hi =D0=9A=D0=B8=D1=80=D0=B8=D0=BB=D0=BB,
>
> Could you help get the USB device information from your test machine
> as the following and reply to the mail?
>
> The information in /sys/kernel/debug/usb/devices about the Bluetooth
> device is listed as the below.
>
> T:  Bus=3D07 Lev=3D01 Prnt=3D01 Port=3D00 Cnt=3D01 Dev#=3D  2 Spd=3D480  =
MxCh=3D 0
> D:  Ver=3D 2.10 Cls=3Def(misc ) Sub=3D02 Prot=3D01 MxPS=3D64 #Cfgs=3D  1
> P:  Vendor=3D13d3 ProdID=3D3596 Rev=3D 1.00
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
> I:* If#=3D 2 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3D(none)
> E:  Ad=3D8a(I) Atr=3D03(Int.) MxPS=3D  64 Ivl=3D125us
> E:  Ad=3D0a(O) Atr=3D03(Int.) MxPS=3D  64 Ivl=3D125us
> I:  If#=3D 2 Alt=3D 1 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3D(none)
> E:  Ad=3D8a(I) Atr=3D03(Int.) MxPS=3D 512 Ivl=3D125us
> E:  Ad=3D0a(O) Atr=3D03(Int.) MxPS=3D 512 Ivl=3D125us
>
> I will send the patch including the VID/PID
> thanks
>
> On Sat, May 2, 2026 at 12:20=E2=80=AFPM =D0=9A=D0=B8=D1=80=D0=B8=D0=BB=D0=
=BB <kirill.kz.902@gmail.com> wrote:
> >
> > Hi Sean,
> >
> > Following your MT7902 series, here is one more VID/PID variant
> > that is currently not recognized by btusb: 0489:e156 (Foxconn).
> >
> > Adding the entry below makes Bluetooth work on v7.1-rc1:
> >
> >   /* Additional MediaTek MT7902 Bluetooth devices */
> >   { USB_DEVICE(0x0489, 0xe156), .driver_info =3D BTUSB_MEDIATEK |
> >                                                BTUSB_WIDEBAND_SPEECH },
> >
> > dmesg after loading the patched module:
> >
> >   Bluetooth: hci0: HW/SW Version: 0x008a008a,
> >                    Build Time: 20250826211444
> >
> > /sys/kernel/debug/usb/devices:
> >
> >   T:  Bus=3D01 Lev=3D01 Prnt=3D01 Port=3D09 Cnt=3D05 Dev#=3D6 Spd=3D480=
 MxCh=3D0
> >   D:  Ver=3D 2.10 Cls=3Def(misc ) Sub=3D02 Prot=3D01 MxPS=3D64 #Cfgs=3D=
1
> >   P:  Vendor=3D0489 ProdID=3De156 Rev=3D 1.00
> >   S:  Manufacturer=3DMediaTek Inc.
> >   S:  Product=3DWireless_Device
> >   C:* #Ifs=3D 3 Cfg#=3D 1 Atr=3De0 MxPwr=3D100mA
> >
> > Could you include this VID/PID in the next MT7902 round?
> >
> > Tested-by: Kirill Shubin <kirill.kz.902@gmail.com>
> >
> > Thanks,
> > Kirill
> >
