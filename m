Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A7B31A64
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Nov 2023 15:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7WBjnZ4"
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422548843
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Nov 2023 07:04:32 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c5210a1515so79150771fa.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Nov 2023 07:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699369470; x=1699974270; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lYDnQdJGT/xF5HkXjdZy2PqDPtWcAWfBfGXDxo74eY0=;
        b=f7WBjnZ45Eo4yVWFreSL69hQq6Fb/qiIkE9+dVCLmLRx4Rufsa9r3sO1h7JT1GEZy+
         Enax0LFUBIwwf5SdPqL0zb+nVJfRPLolc4wGAHMsbdMYXU/GmOQpHhXUiQGonoOPv5Ct
         wXvILtxlIyQSoObpWp/2reQeyM6LlYDA52yRiWJvaaCVkocMJArU1wV2GC1Ux9LDJfV3
         ctHCAA6VUrNtTOfIhN+c4J1zHZt3aS1kNVc7m6dHonnDWBckfhGuIGA032IY/iROBlb/
         RfRvgAqehtrybuZoGuR9nakj+H9APQPAX7v1lHCL7PL3S6nWXk2mc2RzBL+Sa61GRkAs
         Il9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699369470; x=1699974270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lYDnQdJGT/xF5HkXjdZy2PqDPtWcAWfBfGXDxo74eY0=;
        b=mC3UEA2GOVTEecCKnu3UZuv7oP/srkfy+2kApA5rCWKfVdrwzCih+oA4Et5wAHYr2T
         6z9Z3AiWVFLRB/Sqaw72ve761z6WRtTf2LcANBNht8tXUqtVxa9DcAzbmBie94RzlMDV
         ORcuM1fD4K4cJ0JocQmQwSV6OoBUleNTWF/5skbPop6O6jVDbQiAS9zUZtSU32uChbFQ
         g9BAm6iHqvakBNxjQaiOaZ19C2+mfMqSXvkElZUkXjSfAZ1dY6Mm0czSfhPeQMti1Xea
         y+F3oAFkDWhHidmVfoLRhLVG0c9Iz639eESnjHHLCuPdsX/gC2bUsxJ/Mf1ZoX0NOlYk
         ROuA==
X-Gm-Message-State: AOJu0YyeB7VWXL04qKHbJU9rygpWjIePIew8KguL0BbNV4Y4JhkHSjeO
	xvHDKpYFaXbuycR4rLJoi7ppMJG8m9GGhbu9Jm5a0hDwAKg=
X-Google-Smtp-Source: AGHT+IG2vLA1gOyQdK08vcV2ccq0wtEmQ+aHrgCQ91U4m5diBV2eicTCvFDXVn5ypz03j2nqdgHSlykn8tALfZZlYCc=
X-Received: by 2002:a05:651c:10a5:b0:2c6:f6b6:f8db with SMTP id
 k5-20020a05651c10a500b002c6f6b6f8dbmr10822722ljn.16.1699369470052; Tue, 07
 Nov 2023 07:04:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c0df9d614f2a220bc93227eafcc68f73f1751528.camel@hadess.net>
 <CA+5PdQagTBRK09kMX=npZO9OawqtOp-CHGcYeVmQ5BpC+Uyi5A@mail.gmail.com> <31050102f726a4e89a9ef3d1719d6305de2ee61b.camel@hadess.net>
In-Reply-To: <31050102f726a4e89a9ef3d1719d6305de2ee61b.camel@hadess.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 7 Nov 2023 10:04:17 -0500
Message-ID: <CABBYNZLCsBZ5eD+zRMC_YjSYU6C8FS5vw=DVHd947D+eiKY5Tg@mail.gmail.com>
Subject: Re: Using Laird Connectivity Bluetooth LE PTS dongle with Linux
To: Bastien Nocera <hadess@hadess.net>
Cc: Christoph Schweers <christoph.schweers@gmail.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bastien,

On Tue, Nov 7, 2023 at 9:47=E2=80=AFAM Bastien Nocera <hadess@hadess.net> w=
rote:
>
> On Mon, 2023-11-06 at 18:06 +0100, Christoph Schweers wrote:
> >
> > Bastien Nocera <hadess@hadess.net> schrieb am Mo., 6. Nov. 2023,
> > 15:35:
> > > Hey,
> > >
> > > I bought the Laird Connectivity Bluetooth LE-only PTS dongle listed
> > > on:
> > > https://support.bluetooth.com/hc/en-us/articles/360049018492-What-is-=
the-difference-between-the-Profile-Tuning-Suite-PTS-Dongles
> > > -
> > > as I was hoping to have an easy to use Bluetooth LE only device for
> > > testing.
> > >
> > > But the device only shows up as a serial device under kernel 6.5
> > > from
> > > my distribution.
> > >
> > > Is there anything specific that needs to be done for that device to
> > > be
> > > usable as a Bluetooth adapter under Linux? Or does it only work
> > > with
> > > the PTS?
> > >
> > > I spotted the ability to run specific software on the micro-
> > > controller
> > > itself when powered on, but nothing specific to using it as an
> > > adapter:
> > > http://assets.lairdtech.com/home/brandworld/files/BL654%20USB%20Dongl=
e%20User%20Guide%20v1_0.pdf
> > >
> > > Full lsusb output for that device:
> > > Bus 001 Device 018: ID 1915:521f Nordic Semiconductor ASA Nordic
> > > Open
> > > DFU Bootloader
> > > Device Descriptor:
> > >   bLength                18
> > >   bDescriptorType         1
> > >   bcdUSB               2.00
> > >   bDeviceClass            0
> > >   bDeviceSubClass         0
> > >   bDeviceProtocol         0
> > >   bMaxPacketSize0        64
> > >   idVendor           0x1915 Nordic Semiconductor ASA
> > >   idProduct          0x521f
> > >   bcdDevice            1.00
> > >   iManufacturer           1 Laird Connectivity
> > >   iProduct                2 Nordic Open DFU Bootloader
> > >   iSerial                 3 E1BB9211FA41
> > >   bNumConfigurations      1
> > >   Configuration Descriptor:
> > >     bLength                 9
> > >     bDescriptorType         2
> > >     wTotalLength       0x004b
> > >     bNumInterfaces          2
> > >     bConfigurationValue     1
> > >     iConfiguration          4 Default configuration
> > >     bmAttributes         0xc0
> > >       Self Powered
> > >     MaxPower              100mA
> > >     Interface Association:
> > >       bLength                 8
> > >       bDescriptorType        11
> > >       bFirstInterface         0
> > >       bInterfaceCount         2
> > >       bFunctionClass          2 Communications
> > >       bFunctionSubClass       2 Abstract (modem)
> > >       bFunctionProtocol       0
> > >       iFunction               0
> > >     Interface Descriptor:
> > >       bLength                 9
> > >       bDescriptorType         4
> > >       bInterfaceNumber        0
> > >       bAlternateSetting       0
> > >       bNumEndpoints           1
> > >       bInterfaceClass         2 Communications
> > >       bInterfaceSubClass      2 Abstract (modem)
> > >       bInterfaceProtocol      0
> > >       iInterface              0
> > >       CDC Header:
> > >         bcdCDC               1.10
> > >       CDC Call Management:
> > >         bmCapabilities       0x03
> > >           call management
> > >           use DataInterface
> > >         bDataInterface          1
> > >       CDC ACM:
> > >         bmCapabilities       0x02
> > >           line coding and serial state
> > >       CDC Union:
> > >         bMasterInterface        0
> > >         bSlaveInterface         1
> > >       Endpoint Descriptor:
> > >         bLength                 7
> > >         bDescriptorType         5
> > >         bEndpointAddress     0x82  EP 2 IN
> > >         bmAttributes            3
> > >           Transfer Type            Interrupt
> > >           Synch Type               None
> > >           Usage Type               Data
> > >         wMaxPacketSize     0x0040  1x 64 bytes
> > >         bInterval              16
> > >     Interface Descriptor:
> > >       bLength                 9
> > >       bDescriptorType         4
> > >       bInterfaceNumber        1
> > >       bAlternateSetting       0
> > >       bNumEndpoints           2
> > >       bInterfaceClass        10 CDC Data
> > >       bInterfaceSubClass      0
> > >       bInterfaceProtocol      0
> > >       iInterface              0
> > >       Endpoint Descriptor:
> > >         bLength                 7
> > >         bDescriptorType         5
> > >         bEndpointAddress     0x81  EP 1 IN
> > >         bmAttributes            2
> > >           Transfer Type            Bulk
> > >           Synch Type               None
> > >           Usage Type               Data
> > >         wMaxPacketSize     0x0040  1x 64 bytes
> > >         bInterval               0
> > >       Endpoint Descriptor:
> > >         bLength                 7
> > >         bDescriptorType         5
> > >         bEndpointAddress     0x01  EP 1 OUT
> > >         bmAttributes            2
> > >           Transfer Type            Bulk
> > >           Synch Type               None
> > >           Usage Type               Data
> > >         wMaxPacketSize     0x0040  1x 64 bytes
> > >         bInterval               0
> > > Device Status:     0x0001
> > >   Self Powered
> > >
> > > Cheers
> >
> > This dongle must be pre-programmed with a special firmware to work as
> > a PTS dongle.
> > https://support.bluetooth.com/hc/en-us/articles/360049019732-How-to-upg=
rade-the-firmware-of-your-PTS-Dongle
> > -
> >
>
> I updated the firmware using the PTS firmware upgrader, and it still
> doesn't show up as a Bluetooth adapter under Linux:
>
> Nov 07 15:44:11 classic kernel: usb 1-8: new full-speed USB device number=
 22 using xhci_hcd
> Nov 07 15:44:11 classic kernel: usb 1-8: New USB device found, idVendor=
=3D1915, idProduct=3D521f, bcdDevice=3D 1.00
> Nov 07 15:44:11 classic kernel: usb 1-8: New USB device strings: Mfr=3D1,=
 Product=3D2, SerialNumber=3D3
> Nov 07 15:44:11 classic kernel: usb 1-8: Product: nRF52 USB Product
> Nov 07 15:44:11 classic kernel: usb 1-8: Manufacturer: Nordic Semiconduct=
or
> Nov 07 15:44:11 classic kernel: usb 1-8: SerialNumber: E1BB9211FA41
> Nov 07 15:44:11 classic kernel: cdc_acm 1-8:1.0: ttyACM0: USB ACM device
>
> It shows up as:
> Bus 001 Device 023: ID 1915:521f Nordic Semiconductor ASA nRF52 USB Produ=
ct
> in lsusb.

Perhaps it needs to be added to be btusb if it does support a standard
HCI interface. (I'm currently on vacation with limited time to assist
everyone.)

--=20
Luiz Augusto von Dentz
