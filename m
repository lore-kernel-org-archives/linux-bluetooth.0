Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] TPL (transmit power level)
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <de33c8be050221181635c1a751@mail.gmail.com>
References: <de33c8be0502160425215158ad@mail.gmail.com>
	 <1109028291.7626.45.camel@pegasus>
	 <de33c8be050221181635c1a751@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1109039332.7626.102.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 22 Feb 2005 03:28:52 +0100

Hi Flavio,

> In bluetooth core says that the range of the tpl (transmit power
> level) is between -30<=3D N<=3D20 and the step (resolution) is one
> unit,but when i execute the command hci_read_tpl (transmit power
> level) all the values that i receive are:
> 17 ; 14 ; 10 ; 6 ; 2 ; -2 ; -6 ; -9 and no more :(
> why? it=B4s something about Bluez or is the Firmware (of my dongle usb)
> that realy gives that values for tpl?

this should be chip specific. Who is the manufacturer of your Bluetooth
chip inside your dongle?

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
