Return-Path: <cyrus@holtmann.org>
From: Ilya Faenson <ifaenson@broadcom.com>
To: Loic Poulain <loic.poulain@intel.com>, Marcel Holtmann
	<marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Arend Van Spriel" <arend@broadcom.com>
Subject: RE: [PATCH v2 0/5] Broadcom Bluetooth UART device driver
Date: Fri, 12 Jun 2015 15:38:48 +0000
Message-ID: <E0D3336E15B58B4294723AC879BA5E9426156E@IRVEXCHMB15.corp.ad.broadcom.com>
References: <1433966720-17482-1-git-send-email-ifaenson@broadcom.com>
 <557A9808.1090206@intel.com>
In-Reply-To: <557A9808.1090206@intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

-----Original Message-----
From: Loic Poulain [mailto:loic.poulain@intel.com]=20
Sent: Friday, June 12, 2015 4:28 AM
To: Ilya Faenson; Marcel Holtmann
Cc: linux-bluetooth@vger.kernel.org; Arend Van Spriel
Subject: Re: [PATCH v2 0/5] Broadcom Bluetooth UART device driver

Hi Ilya,

On 10/06/2015 22:05, Ilya Faenson wrote:
> v2 - Release upon the acceptance of Fred's updates,
> 	updated as per the latest comments from Marcel.
> v1 - Original release against the Fred Danis' updates.
>
> Ilya Faenson (5):
>    Broadcom Bluetooth UART Device Tree bindings
>    H4 line discipline enhancements
>    Broadcom Bluetooth UART Platform Driver
>    Support the BCM4354 Bluetooth UART device
>    BlueZ Broadcom UART Protocol

I think that the bcm line discipline proto should work even if there is
no bcm platform device (due to missing DT/ACPI entry).
If there is no matching plat device -> just don't use this platform=20
driver to manage pm.
This is for hardware backward compatibility. Moreover we should be able=20
to use an
external bcm device over serial/FTDI (dev board/simulator...) which is=20
not a plat device.

IF: Good point. It is certainly possible to configure the platform device t=
o do exactly nothing but it would be easier for the users not to have it at=
 all this case. Will change the code accordingly.

Regards,
Loic

--=20
Intel Open Source Technology Center
http://oss.intel.com/
