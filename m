Return-Path: <leidenfrost@corscience.de>
Message-ID: <41654062.5050009@corscience.de>
Date: Thu, 07 Oct 2004 15:10:58 +0200
From: Thomas Leidenfrost <leidenfrost@corscience.de>
Reply-To: leidenfrost@corscience.de
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluetooth on a MIPS-System
References: <41651D72.7040806@corscience.de>	 <1097147273.7325.26.camel@pegasus>  <41652A40.4080209@corscience.de> <1097152912.7325.30.camel@pegasus>
In-Reply-To: <1097152912.7325.30.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-users.lists.sourceforge.net>

Hi Marcel,

> the kernel modules are part of the Linux kernel you use on your MIPS
> system. So you need a Linux kernel compiled for MIPS with activated
> Bluetooth subsystem.

I already had this kernel, but without doing "make modules" I can look 
for them a long long time... ;-)

Now I created the following modules and loaded them on target via modprobe:
-bluez
-l2cap
-hci_vhci
-hci_uart
-hci_usb

Doing hcitool scan now results: Device is not available: Success
So I guess that not all neccessary modules are loaded, right?

>>>Do a "modprobe hci_usb" and then check with "dmesg" what happens.

This results a long output, but nothing with blue* / hci* or something 
similar to this in it. What should I llok for?

> So what does "find /lib/modules/ | grep bluetooth" say?

This results nothing, just the # again.


Thanks for helping again, now it's some steps fewer to the goal! :-)

Regards, Tom
