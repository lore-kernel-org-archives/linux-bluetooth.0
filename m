Return-Path: <leidenfrost@corscience.de>
Message-ID: <41652A40.4080209@corscience.de>
Date: Thu, 07 Oct 2004 13:36:32 +0200
From: Thomas Leidenfrost <leidenfrost@corscience.de>
Reply-To: leidenfrost@corscience.de
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluetooth on a MIPS-System
References: <41651D72.7040806@corscience.de> <1097147273.7325.26.camel@pegasus>
In-Reply-To: <1097147273.7325.26.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-users.lists.sourceforge.net>

Hi Marcel,

Marcel Holtmann wrote:

> I don't have a MIPS test system, so I can't really help here. Feel free
> to send me one ;)

I would, but its the only one I have... ;-)
But I think the Problem is not MIPS-specific, the question is where to 
get the missing modules like l2cap, hci_usb, bluez...
Should they be created automaticly after compiling the BlueZ-Libs & 
-Utils? Support for them is activated in the kernel (as module).

> Do a "modprobe hci_usb" and then check with "dmesg" what happens.

# modprobe hci_usb (on target says:)
insmod: hci_usb.o: no module by that name found
modprobe: failed to load module hci_usb

because there is no module on target, searching for it resulted nothing. 
And I think I just can't take them from the host (x86). Are there any 
precompiled modules for MIPS?


Thanks & Regards, Tom
