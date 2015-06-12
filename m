Return-Path: <cyrus@holtmann.org>
Message-ID: <557A9808.1090206@intel.com>
Date: Fri, 12 Jun 2015 10:27:52 +0200
From: Loic Poulain <loic.poulain@intel.com>
MIME-Version: 1.0
To: Ilya Faenson <ifaenson@broadcom.com>,
 Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org,
 Arend van Spriel <arend@broadcom.com>
Subject: Re: [PATCH v2 0/5] Broadcom Bluetooth UART device driver
References: <1433966720-17482-1-git-send-email-ifaenson@broadcom.com>
In-Reply-To: <1433966720-17482-1-git-send-email-ifaenson@broadcom.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

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
If there is no matching plat device -> just don't use this platform 
driver to manage pm.
This is for hardware backward compatibility. Moreover we should be able 
to use an
external bcm device over serial/FTDI (dev board/simulator...) which is 
not a plat device.

Regards,
Loic

-- 
Intel Open Source Technology Center
http://oss.intel.com/
