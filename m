Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluetooth 1.2 and HID Proxy
From: Marcel Holtmann <marcel@holtmann.org>
To: cijoml@volny.cz
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200406051227.43572.cijoml@volny.cz>
References: <1086429803.16316.44.camel@pegasus>
	 <200406051227.43572.cijoml@volny.cz>
Content-Type: text/plain
Message-Id: <1086432918.16316.74.camel@pegasus>
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
Date: Sat, 05 Jun 2004 12:55:18 +0200

Hi Michal,

> Can you make little photo of this dongle?

look at the Apple of the D-Link website

	http://www.apple.com/bluetooth/
	http://www.dlink.com/products/?pid=34

> > The bad news are that you must extract the file GenericCSR.dfu from the
> > Apple firmware update. Actually that is impossible without using Mac OS.
> 
> So pack it and place somewhere on inet :) We'll download it :)

I am not sure if this is possible. I must first check the rights on
these files. Maybe I won't be able to redistribute them. After further
investigation it seems that Linux misses the program "hdiutil". If we
had this it would be possible to convert the *.dmg file into an ISO
image.

hdiutil convert /path/to/filename.dmg -format UDTO -o /path/to/savefile.iso

> > And the other problem is that you need a DFU Upgrade utility. The CSR
> > one is not for free and I never really finished the download code for
> > btdfu. Right now I don't know how to get these two thinks worked out.
> 
> Where did you get DFU upgrade utility? Nor google has found it :(

As I said it is not available for free. Ask the CSR sales team. I also
think that I have seen a similar tool for the Widcomm stack. However DFU
is an USB specification and all you need to write one by yourself can be
downloaded at www.usb.org.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
