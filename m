Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Conflict bluetooth and soundcard
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAosiAEZOtxUiHqgChZUVmh8KAAAAQAAAAejKkYMP2t0iWvwvgIRffgQEAAAAA@t-online.de>
References: 
	 <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAosiAEZOtxUiHqgChZUVmh8KAAAAQAAAAejKkYMP2t0iWvwvgIRffgQEAAAAA@t-online.de>
Content-Type: text/plain
Message-Id: <1103720272.20258.26.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 22 Dec 2004 13:57:52 +0100

Hi Peter,

> I'm using SuSE 9.2 with kernel 2.6.8-24.5 and recompiled dmabt but no
> positiv result. Again the message Can't access Toshiba device /dev/toshiba
> occured. Then soundcard is also uncorrectly installed but this is to be
> solved by YaST at Sound --> options --> reset all.
> But the target is to have both available dmabt (bluetooth-function on of
> Toshiba-notebook) and a usable soundcard (in windows it is using PCI-bus 0
> and irq 11). So, do you have an idea to solve this problem?

if I remember correctly then the SuSE 9.2 kernel is a 2.6.9-rc2 + extra
patches. The problem you are running in is not Bluetooth related. This
is a system one and most times it is ACPI and the IRQ routing. Since
dmabt and /dev/toshiba is not the right way to go you may a little bit
lost here. Everything must be done through ACPI, but you need to know
where's the on/off switch for Bluetooth in your ACPI tables.

> Why? Marcel Holtmann helped me very well to get the whole BT-function with
> AP started. I tried to get help from SuSE, but this is not really good.
> Sometimes they have heard something about bluetooth and BT on
> Toshiba-notebook is a story itself. So, I'm happy about help from
> bluez-users, especially as Bluez is part of the kernel of SuSE 9.2

As mentioned above this is not a BlueZ problem. Once your Bluetooth USB
adapter is activated everything is working. And as Michal mentioned it
is worth trying the latest vanilla kernel (2.6.10-rc3-bk15) available.
You must look out for ACPI and ALSA updates and try to find a way not
using dmabt to activate your Bluetooth module (toshiba_acpi maybe).

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
