Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68D73A872B
	for <linux-bluetooth@vger.kernel.org>; Sat, 15 Aug 2026 10:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786788929; cv=pass; b=Nwp7HpYiwQWFi9AZ7ir6MYXjI3aj5Mm38G5MyLD19uJz+AbHxoDK/+u6TI+Zr4JiQSYAHPxNf9mgj4a6f4QiIum/pAPrKQCLzVcNynRWS+TNRhxfIxDbOHX9lkcQmdBxFzPnxeXkoeSyDF/yqA4+fyFoGWjDrvorncvJM6FDOu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786788929; c=relaxed/simple;
	bh=9SSuA0UPdMvt7vRCQZaKsck+QozxmMeHg2XBeQa/+VQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HxlpCFzQw7SNJWSWjoN+eonlr7uVCSZtYlFmEhB1mKQotNtxT0UchBfD3fA9CBkx/RZEtiDTWyZMqm6vuEoinDWqu+VCZ83NUh/wU70dkneiyk3B/3ZkKryVE+KU6o0C4m4RV/ZtqZVineuv/o1deGWEDE47bfIz46gQkgEe10c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F5yfNuY8; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5yfNuY8"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5b457a0b4e5so1862793e87.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 15 Aug 2026 03:15:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786788922; cv=none;
        d=google.com; s=arc-20260327;
        b=GiBesWEAL520wOQyw5hR3TLAVZZI5qQcgCY4QJZ306bbiawMtV+RYzJWOJXXBESxqE
         NxPNEqhvYi2VBY8iG/93XR+pxwexmkvGvG/KEy+BH7lA9bYNGRbzwAuZPWxwyWLm6VHC
         y483vSXqgz4dFXtN/ZvgbHC8e6cAV0+WKdc7zqKyxRZ83Cx60Mrl5m9kbw6GDLw58l/O
         GT51qgi/oKO0aq6hV7X4N9RwMy89OUmJwkKjYO/CI59SnL/N6011UNgZIWQPwsSQM2mk
         UHeMvftMF6nEFWgFYOyRVI46bJSM0w65ix++/lpgLCAQes8Yfziyvy3X4IsplTQlmSJ9
         0UDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QSEVAvBibBZLKTNVwG+Np7c+wHh3qLLq0McYRf0oAlc=;
        fh=T8e3f5yy16Y8PC+KFAw6O04GUAoeQ9tXs9Z+kJ9L9lg=;
        b=BOMGmSnzpcAv7EMBuqqsC2bXg5gyQjOrqCH6lRCJa0qeEyNJJt4u4mJGLyytcYkyY5
         36lqIU1aw76PW8NZ0rBCociLLKiPpLhaBcGnO3tP/gZV9yvB9pA3pNjphxWExa7IhhS+
         x78PCtrRbAXxCSYsXd5d8pDtZZEPBDkizptb0i682FNChlMFBRMMJw9me1nGlgJstjT7
         ukWismh64djEiiNftW8zwQgNp6l04Leqd1Gvh7jniyaQGBsH7UBbEymmo5T45OkE4cTy
         8rdLDpHwkxZlH/N+PCIeRO/j/YSqSbIF9D3DOhqdpd9TRZKiBufX4SocvialFFkwA3Y1
         jRXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786788922; x=1787393722; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QSEVAvBibBZLKTNVwG+Np7c+wHh3qLLq0McYRf0oAlc=;
        b=F5yfNuY8tsj6W+MtiWsqZEE3xP5QO0PaNzuLUli57vGMOyVHqB1O/JuKlMOWmubo/j
         yyjnghorwMCKixqCUhYmT3rqaMOYRgo8Jwpg1q597fkYB2V3dfCuiUav6XUAjVugOxpy
         GRZUC6AobOPR5QsF4uZwynvgdO0FzdDW2evLk4KFQpBi0Zv7aLRrrlZypcqLlSS/Abgf
         J0vo+uiO8jO8ZA1aC/2n/0fVsrgB6e5LoiSpDgXDK4jpoFQUpqwPXGvNuvbVwM5yb8hP
         9/LPYHJj45yWpZmX/O7e6jqkLyalpnDlWAFruRUAvV2Htrel3VARWNSJODPI4yHFRqQt
         q1vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786788922; x=1787393722;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QSEVAvBibBZLKTNVwG+Np7c+wHh3qLLq0McYRf0oAlc=;
        b=gzDpJI8lg7ARRfYUAhim7y1tX7HLiaYpf2hnXb1G8IU00fIoIafYX8zTMY1sSjol2s
         W6rD3ck8jWYMxrmV/dfY8cshw/pLVHT3ZiO1tcVff7ekik4aUWsFU7ExXbSdYHkbr2AB
         JtMcPD4zee05YgSSe+P36QVqBeDB/AHJtI5WUx4H8+esRLFwbi7YZpx+V90c4wk1NIpS
         9JXJb0GPb431DWjzS4rQZG3p9OwC9JKWJkhDhsbXI5rHKd4attxdFSD4KvtDY3AbsQuW
         Va/8XH2vprBKgGeor7PvjBjWVnPjiKfPL3JivPiZ6k3dbb/iy9Wg72FJfiNQvRdOgUjd
         VaVA==
X-Forwarded-Encrypted: i=1; AHgh+RpiHPjB1pWTgnAuOzc1ITkUSo6grfRSnrFIPY/viGEdnhxa3wCErm1S2OAIuChOlz6bSYoAIG2erHLwQAwMYo4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBBPX5yI8i20NPUu2cxc4ZVlPVJsXtmjSHgMzZzL+Xz+I4yr/i
	TrBLZfwlC5UxlbNur+OZYoO0k2kOHuZnUWpB0UFijtBcIjUAzKJ65ARuAcmV3em23JCzGDutiD/
	ciH99g8wmnFuT+7ra/1DbeB1irDeemI/FoVI+uQ4hmA==
X-Gm-Gg: AR+sD10Q2uDK4D2Mnlib+7evXgqNYGaA2XAdO79Gl+R5rmDitiygMYafQlHzIMLDToa
	bK28KlaTz6B7lI6lKAXZDQSQEVxK6ViMQmC+WLcfB4yy3nm007MxMkJ2h66wdlxAEm9oX5qNj+S
	7Z4Aea78ciNOsB1+u1V+raknc+sGUI/eX86LPZBcnwfS1hhT0Cn/VtzRudlnNWKeFcc4GgkOm0B
	JXlSPDbxJshBcCaC5dxMcj6fLpDtXJmPcdb8USbMAASVgM63hruKXHgM6s9IN72QlNw/62vCGkL
	ks1bLphGgs01gMo7n7+ww6dETvU7HGuAYPPp7ZVCtfRijdp1Om4=
X-Received: by 2002:a05:6512:1094:b0:5b0:eda:de2a with SMTP id
 2adb3069b0e04-5b45918e8a8mr1505093e87.35.1786788922310; Sat, 15 Aug 2026
 03:15:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260815033346.15882-1-andrewbille@gmail.com> <7b6368b0-f5ab-45a0-a0a3-6384a78c6687@molgen.mpg.de>
In-Reply-To: <7b6368b0-f5ab-45a0-a0a3-6384a78c6687@molgen.mpg.de>
From: Andrew Bille <andrewbille@gmail.com>
Date: Sat, 15 Aug 2026 17:15:10 +0700
X-Gm-Features: AcwNN1WavDjCzNRj0MjWU2DniDQknD2hBv4z_h0ubRezDj4HWrNsVWsoX0uo59E
Message-ID: <CAJnzarxDhh-cHi5O=JtvJ2P6wV7trHC+gb=CTXMgibJKxcg1aA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: treat 0bda:0002 as a generic HCI device
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Daniel Drake <drake@endlessm.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paul,

thank you for the review.

The controller is the internal Bluetooth adapter of an old Quanta JW6H lapt=
op.

Its relevant USB information is:

D:  Ver=3D 2.00 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 MxPS=3D64 #Cfgs=3D 1
P:  Vendor=3D0bda ProdID=3D0002 Rev=3D75.58
S:  Product=3DCSR BS8510
I:* If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb

No external firmware is required when the controller is handled through
the generic HCI path; no Bluetooth firmware is requested by the kernel
in this configuration.

I have addressed the possible regression for other 0bda:0002 devices by
limiting the exception to the observed bcdDevice revision 0x7558. The
driver also logs when the generic HCI path is selected.

I have sent v3 rebased onto the current bluetooth-next tree. I also
re-tested it on the affected hardware: the controller registers
successfully, and scanning, pairing and A2DP audio work correctly.

Thank you again for the review.

Kind regards,
Andrew



On Sat, Aug 15, 2026 at 2:38=E2=80=AFPM Paul Menzel <pmenzel@molgen.mpg.de>=
 wrote:
>
> Dear Andrew,
>
>
> Thank you for your patch.
>
> Am 15.08.26 um 05:33 schrieb Andrew Bille:
> > The 0bda:0002 Bluetooth controller reports itself as "CSR BS8510"
> > and exposes a standard Bluetooth USB interface.
>
> Where did you find this controller?
>
> > It currently matches the vendor-wide Realtek quirk and is therefore
> > initialized through btrtl. The controller does not respond to the
> > Realtek-specific register access and initialization fails with:
> >
> >      Bluetooth: hci0: RTL: RTL: Read reg16 failed (-110)
> >
> > No Bluetooth controller is then available to userspace.
> >
> > Add an exact match for 0bda:0002 before the generic Realtek entry so
> > that the device is handled as a generic USB HCI controller.
>
> Does the device need any firmware?
>
> > With this change the controller registers successfully. Scanning,
> > pairing and A2DP audio have been tested successfully.
>
> Please include relevant output of `/sys/kernel/debug/usb/devices`.
>
> > Fixes: a2698a9bf9b0 ("Bluetooth: btusb: Add Realtek 8723A/8723B/8761A/8=
821A support")
> > Cc: stable@vger.kernel.org
> > Assisted-by: ChatGPT:GPT-5.6-Sol
> > Signed-off-by: Andrew Bille <andrewbille@gmail.com>
> > ---
> >   drivers/bluetooth/btusb.c | 3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index 184e95c1625e..fb9fdf90a3b9 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -615,6 +615,9 @@ static const struct usb_device_id quirks_table[] =
=3D {
> >       { USB_DEVICE(0x0489, 0xe130), .driver_info =3D BTUSB_REALTEK |
> >                                                    BTUSB_WIDEBAND_SPEEC=
H },
> >
> > +     /* CSR BS8510 device using a Realtek USB vendor ID */
> > +     { USB_DEVICE(0x0bda, 0x0002) },
> > +
>
> Could some sort of message be logged, as we don=E2=80=99t know if there a=
ctual
> Realtek devices out there, that would regress? (More info in the commit
> message regarding regression potential would be useful.)
>
> >       /* Realtek Bluetooth devices */
> >       { USB_VENDOR_AND_INTERFACE_INFO(0x0bda, 0xe0, 0x01, 0x01),
> >         .driver_info =3D BTUSB_REALTEK },
>
> With my comments addressed:
>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
>
>
> Kind regards,
>
> Paul
