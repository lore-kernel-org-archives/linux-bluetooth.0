Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8D22765E2
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Sep 2026 15:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788362269; cv=pass; b=QqAx8NDkFN50TxVHOaFXorn5wD8BQP7uxq6eDbQKUKWT8WU/REZFnIIYwozlw+aDQ7FcTlUoGXftMGUdC0icFDSvw3Alz5BGmBSkFgLKnzQTQ66s65uMZPW/22o3eqt8qKrLe0Xpl+BUE5CL3o4rCR+kqZEK9Djt+HFxgQMitYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788362269; c=relaxed/simple;
	bh=bZfs3GmlmJp+9UVl015Wa8TGidJ9KDc+UwsCi87NnRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cooV3Ft6FVX7aBX6BGNFcxHs9ov7nmGZyWywQldY5fUO5czbvGyz4DCd0KuH2tuSDXejaa0fk36M5Az9OXnMXQU7q+XuDGIc8sN11JBoMXBcpi1XnC3wnF4w44oZnSn1C/7CN8k9KB2xP7ecj8BMNXmfv3/wbqM3Zy2PsHAHGtw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y43RX8Rx; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y43RX8Rx"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8623b1e7cb2so16316377b3.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Sep 2026 08:17:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788362266; cv=none;
        d=google.com; s=arc-20260327;
        b=seqrhujzp2YL9UrucIMwVpTv6eH6Ko1ZaOP4LyaPq6tNnbwPjymVdkiyDtVvPDJhtl
         2KezGxfOXkMc/zOMcmu0Dd1pJBr4/0kj/5HgoWUrS7nbi47xZ0ADy+qoraOebwAi0zW7
         nJ8GDgTWxXi5qV4pBKTFy0TySfy6RaW3C93uwmVUUppqisfiO2d40C4hshBedq9cfWAX
         Zl9hJqQv39Nmnjmvrqke6qsf800hFEsahKFACkDmlyqD7yBQrHLZjatpeKWDMDShHxqa
         nqTCJf4bzdbkjB3YvseWXn+q/tcZOOXyr991pDTQgQ5vuufLO2NS6T6oe83/YeKl5dlE
         mJFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dThpWTlOJfitRUpKBKjgJW/n37x+Th1lB39VNPifol0=;
        fh=XsI51gXOqgBMeCZJVNUlILxi9Hl202u0h+LR9AW7l4w=;
        b=h3IJA6pxeYGua1RBTWePtvF6e647ceKftij2ged65K9oA2UFFT7G/Qf5l8fvEh0hjw
         GiqcbW3gV6LJzBnEq6lG3/SSy4kqk1YKTl5A2ZZ5DB8LHftd4bRxTP3iscsShvxeo+vC
         kjNiuZ+HX42e4CiEUII14Mf+A4j9vVrbdfX6mdbhrIYlSjhQjZGL0Bl/tLMsJXF8OHEs
         qNt/nhYT7Tatp+OOoN3JvITTh177CnAwSnx0McmsyMre4d9jE5f38zd14Gu0Y+wRWw2C
         0ZP2GMR/yrPLHlHXAb1d4P3JWi44jVhFwzAmah6C073cE0rs0djzL2aaSBNs0Hjsyz73
         SqYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788362266; x=1788967066; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dThpWTlOJfitRUpKBKjgJW/n37x+Th1lB39VNPifol0=;
        b=Y43RX8RxMyLTdAgxNvHY4Zc5LK7jkM+ZJDkSQK/D+9kPVRnrsiE9+GmVcv3S57sPsl
         xXKbFXithxxGdPEHvecWwaUTAmIt8kzkcwxmWQdDh3AvMvaKIKMwqsnHDxuqL0EwO5u3
         CJa5jKvIoF6teAxDHj0enltYibsXVnAm8YPjNWcDi26Aci3IbDdK8OsHUL8xZO9D88hc
         KYJAzWtJdSp82uGj84PP2OagqEJLQW6qs8u/2G0sU+gOGvrJCQc2e6niJv+Pbsep++ut
         uvUDYqjeEbSYmtvDVkYsEtg81klr3XmFZSAPjZZL3Tgk6wiOp5WPRkGH3Hk3xSLHb8VL
         lpQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788362266; x=1788967066;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dThpWTlOJfitRUpKBKjgJW/n37x+Th1lB39VNPifol0=;
        b=RWktfW8awIAfTiUPtQ9VQtiJ8ZLnj49qFWgS3u/Axwymw4BwMPbnRwyrkIesPSkfzx
         cWuotlkFf3REcBtld1YHfFsypIZE4i3t+OoQSJU+yjWgL0K7Mot1n3Nn4ag6oi3xnVsw
         CLVfXlg/npL1A/jd3O9WClp9QR6ObhXQV48vWn8a/rpURWVgNZccafypILvJUDbRHhKa
         fXqqk67SNSrAo2NHxWOUbNyqjX/15WBYwqu4wprVFLNG8Eu2N4uSILSpHajm9auSmi1x
         v/Nm466QUbbylZl8hi9CK5ovEt8Bhre0/XgOMjuGnJ2Is/RHxx4cB6x0QOy/XzK2gEho
         SExA==
X-Forwarded-Encrypted: i=1; AKwUvBwmRCyhUnVzgwrZbu8WnNjrQs7z+elzNDgK5GFfwpM5SG3ArpsHlBYPQ9ZykSvobZEIRby/pK00iF8RhA8hea4=@vger.kernel.org
X-Gm-Message-State: AFuF++lGLnferQybLQQ4pVXHhpDJn+zrVyl2PcpedZcLu6Gn4uiosX7L
	i9a88X0tpbKMhKXrU/awjW19mqOOLZs7Sjkg2GQPIvDLjC1OBd8e0qtxy7DpfEgtJ61YOMPvx7E
	2jyMfBXlng/2GIa2JGHEo6ekiYBk3ekM=
X-Gm-Gg: AYBFou1NevG43N6iiNANnD3yrYWPKFHSrzZ31fJEW/qRJ4HW/ZijsPF1l6C2BGUoPpy
	P6a1FjPwr0zbkod5UxLneitlbyDKUP6JOvgPUWa6nPTeXlSxfyHVSILtpOrlYazaP7IWJic06YV
	l+mwXLjToiCI8LvXjBur+h1Vx7wdgm4vjRupuS46/s75gzSoMbw+G7+cDrPC5HixUs76SfTgiiN
	eJWrallNePsVLWLZGHcBT/zFNO8n8ccmwmd4Z5wdtJ2NQNiwCz/uJmikTLwsSjIUfuRVI8D0K4O
	RXSu/mkPr5sM7QMuNAw9Lw87UjV9hxIcVUa99qMle8Xqw6rhRYjo6sqHXTl8HS2CUlrpSIHzq/D
	KmdsidIK2nc2bfz4NdqBNMi3EJHmS8Qt3Cp4op4FcNg==
X-Received: by 2002:a05:690c:c50f:b0:85c:79d2:91a4 with SMTP id
 00721157ae682-86c52217cfamr26209717b3.17.1788362266227; Wed, 02 Sep 2026
 08:17:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902160407.257899-1-catherine.l@intel.com> <c02e3bfb-dd46-4c58-96e4-8f8bb5ca3508@molgen.mpg.de>
In-Reply-To: <c02e3bfb-dd46-4c58-96e4-8f8bb5ca3508@molgen.mpg.de>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 2 Sep 2026 11:17:33 -0400
X-Gm-Features: AcwNN1Vye-PDzuBaoECK0IHWQJQC-7zg2wTIVZgfc-5uCEXCtPHb8qUQSdBRg70
Message-ID: <CABBYNZKWeag1cAgedSbqizoDee_FmujnWQ+v9hbLAB9oRgBs4w@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: btusb: Add support for Intel Otter Peak2 (OrP2)
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Catherine L <catherine.l@intel.com>, marcel@holtmann.org, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kiran.k@intel.com, L@web.codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Wed, Sep 2, 2026 at 7:07=E2=80=AFAM Paul Menzel <pmenzel@molgen.mpg.de> =
wrote:
>
> Dear Catherine,
>
>
> Thank you for your patch.
>
> Am 02.09.26 um 18:04 schrieb Catherine L:
> > From: "L, Catherine" <catherine.l@intel.com>
>
> Please use the format without comma: Catherine L.
>
> > $ lsusb
> > Bus 003 Device 003: ID 8087:0043 Intel Corp.
> >
> > $ cat /sys/kernel/debug/usb/devices
> > T:  Bus=3D03 Lev=3D01 Prnt=3D01 Port=3D09 Cnt=3D02 Dev#=3D  3 Spd=3D12 =
  MxCh=3D 0
> > D:  Ver=3D 2.01 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 MxPS=3D64 #Cfgs=3D  =
1
> > P:  Vendor=3D8087 ProdID=3D0043 Rev=3D 0.00
> > C:* #Ifs=3D 2 Cfg#=3D 1 Atr=3De0 MxPwr=3D100mA
> > I:* If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driv=
er=3Dbtusb
> > E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D  64 Ivl=3D1ms
> > E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
> > E:  Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
> > I:* If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driv=
er=3Dbtusb
> > E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
> > E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
> >
> > Signed-off-by: L, Catherine <catherine.l@intel.com>
>
> Ditto.
>
> > ---
> >   drivers/bluetooth/btusb.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index 03039ceaa77d..a4fdf6549127 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -488,6 +488,8 @@ static const struct usb_device_id quirks_table[] =
=3D {
> >       { USB_DEVICE(0x8087, 0x0037), .driver_info =3D BTUSB_INTEL_COMBIN=
ED },
> >       { USB_DEVICE(0x8087, 0x0038), .driver_info =3D BTUSB_INTEL_COMBIN=
ED },
> >       { USB_DEVICE(0x8087, 0x0039), .driver_info =3D BTUSB_INTEL_COMBIN=
ED },
> > +     /* Otter Peak2, Wildcat Lake */
> > +     { USB_DEVICE(0x8087, 0x0043), .driver_info =3D BTUSB_INTEL_COMBIN=
ED },
>
> Please sort and put the comment on the same line as below.

That's not a good idea, we still have the 80-column limit for the
Bluetooth subsystem.

> >       { USB_DEVICE(0x8087, 0x0040), .driver_info =3D BTUSB_INTEL_COMBIN=
ED }, /* Lizard Peak 2 */
> >       { USB_DEVICE(0x8087, 0x07da), .driver_info =3D BTUSB_CSR },
> >       { USB_DEVICE(0x8087, 0x07dc), .driver_info =3D BTUSB_INTEL_COMBIN=
ED |
>
>
> Kind regards,
>
> Paul



--=20
Luiz Augusto von Dentz
