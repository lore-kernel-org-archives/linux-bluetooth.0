Return-Path: <leidenfrost@corscience.de>
Message-ID: <41655C4D.1070206@corscience.de>
Date: Thu, 07 Oct 2004 17:10:05 +0200
From: Thomas Leidenfrost <leidenfrost@corscience.de>
Reply-To: leidenfrost@corscience.de
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluetooth on a MIPS-System
References: <41651D72.7040806@corscience.de>	 <1097147273.7325.26.camel@pegasus>  <41652A40.4080209@corscience.de>	 <1097152912.7325.30.camel@pegasus>  <41654062.5050009@corscience.de>	 <1097154841.7325.36.camel@pegasus>  <41654D83.1090306@corscience.de> <1097158664.7325.38.camel@pegasus>
In-Reply-To: <1097158664.7325.38.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-users.lists.sourceforge.net>

Hi Marcel,

>>Trying to figure out whats missing with depmod -a won't help because:

Now I have depmod installed and I know that my Linux is Debian-based.
And my System is non-PCI-based, but USB is already working 
(Input-devides). Running depmod -a results:

...
depmod: /lib/modules/2.4.21/sdptool.o: Unhandled relocation of type 12 
for .text
depmod: /lib/modules/2.4.21/sdptool.o: Unhandled relocation of type 12 
for .text
depmod: depmod obj_relocate failed
...
depmod: *** Unresolved symbols in /lib/modules/2.4.21/l2ping.o
depmod: *** Unresolved symbols in /lib/modules/2.4.21/ppporc.o
depmod: *** Unresolved symbols in /lib/modules/2.4.21/rfcomm.o
depmod: *** Unresolved symbols in /lib/modules/2.4.21/sdptool.o

I guess that there is someting totally wrong, but how to solve this?

> this rfcomm.o is not a kernel module. It is a compiled object file from
> the bluez-hcidump package.

What does this mean?

Thx, Tom
