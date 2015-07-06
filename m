Return-Path: <cyrus@holtmann.org>
Message-ID: <559A3918.803@intel.com>
Date: Mon, 06 Jul 2015 10:15:20 +0200
From: Loic Poulain <loic.poulain@intel.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: Johan Hedberg <johan.hedberg@gmail.com>,
 linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_uart: Introduce Intel HCI UART driver
References: <1435746026-1024-1-git-send-email-loic.poulain@intel.com> <188DA073-D50B-4173-B879-0AFD8A0C7915@holtmann.org>
In-Reply-To: <188DA073-D50B-4173-B879-0AFD8A0C7915@holtmann.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> I did apply this patch to bluetooth-next tree, but I had to fix a bunch of coding style mistakes.
>
> Initially I was going to send this back, but in the end they were so easy to fix inline that it would have just delayed the process for getting larger exposure of this patch. However please review these since there were obvious coding style mistakes.

Thanks for the reviewing, fixing and testing of this patch.
It's obvious that my commit message was too poor, sorry for that.

> In addition, I did a test run on one of my development boards and having to wait almost 1 minute for the firmware to load is impressive. Seems we really want to add the higher speed UART support.

Regarding firmware download, with the 115200 default speed, I obtain the 
same result (>1min)
Patch is ongoing to use the final speed. Using 3M, firmware download 
takes about 4s.

> [171933.957748] Bluetooth: hci0: Bootloader revision 0.0 build 2 week 34 2014
> [171933.969914] Bluetooth: hci0: Device revision is 5
> [171933.969916] Bluetooth: hci0: Secure boot is enabled
> [171933.969918] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
> [171933.969918] Bluetooth: hci0: No device address configured
> [171933.975503] Bluetooth: hci0: Found device firmware: intel/ibt-11-5.sfi
> [171988.683798] Bluetooth: hci0: Waiting for firmware download to complete
> [171988.683801] Bluetooth: hci0: Firmware loaded in 53497399 usecs
> [171988.683886] Bluetooth: hci0: Waiting for device to boot
> [171988.696706] Bluetooth: hci0: Device booted in 12593 usecs
> [171988.714708] Bluetooth: hci0 hardware error 0x0e

I don't know why you get this hardware error, maybe a Intel reset param 
issue with your device.


Thanks & Regards,
Loic

-- 
Intel Open Source Technology Center
http://oss.intel.com/
