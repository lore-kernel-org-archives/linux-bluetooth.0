Return-Path: <leidenfrost@corscience.de>
Message-ID: <41654D83.1090306@corscience.de>
Date: Thu, 07 Oct 2004 16:06:59 +0200
From: Thomas Leidenfrost <leidenfrost@corscience.de>
Reply-To: leidenfrost@corscience.de
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluetooth on a MIPS-System
References: <41651D72.7040806@corscience.de>	 <1097147273.7325.26.camel@pegasus>  <41652A40.4080209@corscience.de>	 <1097152912.7325.30.camel@pegasus>  <41654062.5050009@corscience.de> <1097154841.7325.36.camel@pegasus>
In-Reply-To: <1097154841.7325.36.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-users.lists.sourceforge.net>

Hi Marcel, hi Martin,


>>>So what does "find /lib/modules/ | grep bluetooth" say?
>>This results nothing, just the # again.
> This is wrong unless you copied the BlueZ modules somewhere else by
> hand.

Yes, I did. All modules are located in /lib/modules/2.4.21, but there 
are no other subdirectories like bluetooth or something else.

Now after doing hciconfig hci0 up I am able to ping other devices,
but I guess I'll need rfcomm, too. But there is something missing... but 
what?

# modprobe rfcomm
Using /lib/modules/2.4.21/rfcomm.o
insmod: unresolved symbol putchar
insmod: unresolved symbol obex_dump
insmod: unresolved symbol parser
insmod: unresolved symbol get_proto
insmod: unresolved symbol raw_dump
insmod: unresolved symbol _gp_disp
insmod: unresolved symbol printf
modprobe: failed to load module rfcomm

Trying to figure out whats missing with depmod -a won't help because:

# depmod -a
-sh: depmod: not found


Thx again, Tom
