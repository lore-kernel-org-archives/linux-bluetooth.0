Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] CSR Firmware upgrade?
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: Nils Faerber <nils@kernelconcepts.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1059732435.2098.289.camel@idoru.kc.de>
References: <Pine.GSO.4.44L0.0307311234210.11864-100000@ug7.ece.ubc.ca>
	<1059732435.2098.289.camel@idoru.kc.de>
Content-Type: text/plain
Message-Id: <1059734101.10884.176.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: 01 Aug 2003 12:34:54 +0200

Hi Nils,

> Just to stress the need, I would be very interested in this too!
> I also have several CSR based dongles around here, some older some
> newer.
> And since there are obviously some imporant differences in the firmware
> it would be really good beein able to update them.
> 
> So if anyone from CSR is listening (I think there is at least one :)
> please consider putting the firmware up for public donwload somewhere
> and support the Linux Bluetooth Firware USB Update project.

the problem is not the loader. The problem is the firmware, because a
CSR firmware can be signed by the manufacturer and so you can only load
a firmware which is meant for your device. Search the mailing list
archive for a posting from Carl Orsborn regarding this.

Anyway I think some dongles can be loaded with the plain CSR firmware or
firmware files from other dongles. I already have started this project
you mention and the upload (archive) mode for firmware is already
working fine. Please check out

	http://www.holtmann.org/linux/bluetooth/btdfu-0.2.tar.gz

and send me your firmware files, so I can find out who really signs the
firmware and which companies does not.

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
