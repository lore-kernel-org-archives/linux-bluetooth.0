Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] DBT-120 firmware upgrade
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200411291815.iATIFK0a022472@news01.csr.com>
References: <200411261152.29925.pavouk@pavouk.org>
	 <200411271655.27322.pavouk@pavouk.org> <1101579731.27074.8.camel@pegasus>
	 <200411272130.44783.pavouk@pavouk.org> <1101588637.27074.22.camel@pegasus>
	 <41AB14DD.3010807@csr.com> <1101731638.10115.0.camel@pegasus>
	 <41AB1AF5.3030901@csr.com> <1101749410.7562.21.camel@pegasus>
	 <200411291815.iATIFK0a022472@news01.csr.com>
Content-Type: text/plain
Message-Id: <1101753185.7562.36.camel@pegasus>
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
Date: Mon, 29 Nov 2004 19:33:05 +0100

Hi Peter,

> > # hciconfig hci0 revision
> > hci0:   Type: USB
> >         BD Address: 00:C0:DF:xx:xx:xx ACL MTU: 192:8  SCO MTU: 64:8
> >         Build 1354
> >         Chip version: BlueCore02
> >         Max key size: 56 bit
> >         SCO mapping:  HCI
> > 
> > I assume that this is also a HCI 18.2, right?
> 
> That's not a production build and I can't find any record of it being
> sent to anyone.  Very, very interesting.  It should be functionally
> similar to 18.2

but it is an official build, right? This is the HID proxy dongle sold
with the Genius Bluetooth mouse. The mouse has build id 0x417. The USB
descriptors states this as "KYE Systems Corp. (Mouse Systems)" and they
use the VID/PID 0458:1000 and 0458:003f.

Do you have the build information for my web page?

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
