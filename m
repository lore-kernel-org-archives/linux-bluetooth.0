Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1282205470.23399.156.camel@localhost.localdomain>
References: <1282197259-16609-1-git-send-email-iwamatsu@nigauri.org> <1282205470.23399.156.camel@localhost.localdomain>
From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date: Fri, 20 Aug 2010 16:24:43 +0900
Message-ID: <AANLkTi=gkURZ45ESVov-bH__+XKvhLy7q2aoygNM9DjW@mail.gmail.com>
Subject: Re: [PATCH 1/2] bluetooth: Add support Bluetooth controller of
 MacbookPro 6,2
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org, stable@kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

2010/8/19 Marcel Holtmann <marcel@holtmann.org>:
> Hi Nobuhiro.
>
>> Bluetooth controller of MacbookPro 6,2 does not work.
>> Because Device Class of these controllers was set 255 (Vendor Sepecific =
Class).
>>
>> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
>
> it would be nice if you include the output from /proc/bus/usb/devices or
> usb-devices.sh script to proof the different device class.
>
Oh, sorry. I sent patch with infomation of USB device.

Best regards,
  Nobuhiro
--=20
Nobuhiro Iwamatsu
=A0=A0 iwamatsu at {nigauri.org / debian.org}
=A0=A0 GPG ID: 40AD1FA6
