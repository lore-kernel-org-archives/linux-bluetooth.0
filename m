Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] DBT-120 firmware upgrade
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200411271655.27322.pavouk@pavouk.org>
References: <200411261152.29925.pavouk@pavouk.org>
	 <1101489949.6514.33.camel@pegasus>  <200411271655.27322.pavouk@pavouk.org>
Content-Type: text/plain
Message-Id: <1101579731.27074.8.camel@pegasus>
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
Date: Sat, 27 Nov 2004 19:22:11 +0100

Hi Pavel,

> when I compare original backuped firmware with downloaded, that
> there are few differences:
> --------------
> Filename        backup.dfu
> bcdDevice       443
> Firmware type   CSR-dfu2
> --------------
> Filename        GenericCSR.dfu
> bcdDevice       ffff
> Firmware type   CSR-dfu1
> --------------
> 
> Can somebody explain me, what does it means and if it is not problem
> for flashing?

the filename difference should be clear, I think. The bcdDevice is the
build id. Uploaded files are filled with the current build id of the
running firmware. The generic firmware files don't contains a build id,
because they are not build to replace a specific one. CSR has two types
of firmware files and you can use type 1 and 2 to download a new one,
but if you upload a firmware you will get the latest type and this is 2.

> Downloaded firmware is much longer than backuped. Is it OK?

The GenericCSR.dfu contains two firmware files. One HCI 18.x for chips
with 8 Mbit flash and a HCI 16.x for chips with 4 Mbit flash.

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
