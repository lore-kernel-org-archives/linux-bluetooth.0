Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluetooth on a MIPS-System
From: Marcel Holtmann <marcel@holtmann.org>
To: leidenfrost@corscience.de
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <41651D72.7040806@corscience.de>
References: <41651D72.7040806@corscience.de>
Content-Type: text/plain
Message-Id: <1097147273.7325.26.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 07 Oct 2004 13:07:53 +0200

Hi Thomas,

> hope I can get a little help here after some days of vainly trying. 
> Currently I want to make my MIPS-System (AMD-Alchemy) working with 
> Bluetooth. Support for Bluetooth was implemented as a Module in Kernel 
> 2.4.21 (without any patch).

I don't have a MIPS test system, so I can't really help here. Feel free
to send me one ;)

> Then I crosscompiled the BlueZ-Libs & - Utils, and hcitool says:
> 
> "Device ist not available: Address Family not supported by protocol", 
> altough there is a Bluetooth-USB-Dongle present or not. Before it was: 
> "Device ist not available: Success", so I think I am one step closer 
> than before.
> 
> lsmod says:
> 
> Module Size Used by Not tainted
> saa7113 2540 0 (unused)
> sii164 2980 0 (unused)
> i2c-mb86290 1620 0 (unused)
> i2c-algo-mb86290 2828 1 [i2c-mb86290]
> i2c-dev 4428 0 (unused)
> i2c-core 15504 0 [saa7113 sii164 i2c-algo-mb86290 i2c-dev]
> ide-cs 3888 1
> hostap 96208 0
> ds 8012 1 [ide-cs]
> au1x00_ss 8084 1
> pcmcia_core 42176 0 [ide-cs ds au1x00_ss]
> 
> 
> but nothing like:
> 
> l2cap, hci_usb, bluez
> 
> doing # modprobe l2cap.o in /bin results:
> insmod: l2cap.o: no module by that name found
> modprobe: failed to load module l2cap.o

Do a "modprobe hci_usb" and then check with "dmesg" what happens.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
