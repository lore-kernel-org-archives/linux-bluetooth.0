Return-Path: <cyrus@holtmann.org>
Message-ID: <557EE045.2090503@roeck-us.net>
Date: Mon, 15 Jun 2015 07:25:09 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Frederic Danis <frederic.danis@linux.intel.com>,
 BlueZ development <linux-bluetooth@vger.kernel.org>,
 linux-serial@vger.kernel.org
Subject: Re: Build error -in -next due to 'Bluetooth: hci_uart: Support operational
 speed during setup'
References: <557ED81D.7090908@roeck-us.net> <7CF3D545-DAE4-4510-9726-5D40740DDC5D@holtmann.org>
In-Reply-To: <7CF3D545-DAE4-4510-9726-5D40740DDC5D@holtmann.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On 06/15/2015 06:58 AM, Marcel Holtmann wrote:
> Hi Guenter,
>
>> alpha:allmodconfig fails to build in -next with
>>
>> drivers/bluetooth/hci_ldisc.c: In function 'hci_uart_set_baudrate':
>> drivers/bluetooth/hci_ldisc.c:276:22: error: 'BOTHER' undeclared
>>
>> BOTHER is not defined for all architectures and otherwise only
>> used with '#ifdef BOTHER'.
>
> thanks for the report. Is this something that should be #ifdef at the using side or maybe just fixed for the other architectures.
>

So far it has been fixed with #ifdef, and this is the first code which
uses it outside drivers/tty. So my first tendency would be to fix it
on the user side.

However, looking into it, I think only alpha and avr32 are affected.
Let me submit patches against those and see where it goes.

Guenter
