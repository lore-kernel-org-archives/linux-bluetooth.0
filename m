Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <6ae15690050306060128edc405@mail.gmail.com>
From: Adis Beglerovic <emerge.gentoo@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] DBT-120 and Siemens S65
In-Reply-To: <1110117308.8302.12.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <6ae1569005030604105d08a56e@mail.gmail.com>
	 <1110111350.8302.9.camel@pegasus>
	 <6ae1569005030605485547bf58@mail.gmail.com>
	 <1110117308.8302.12.camel@pegasus>
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
Date: Sun, 6 Mar 2005 15:01:58 +0100

Thanks for fast answers

Just checkign stuff that was in kernel and everything seams OK.
I don't use modules everything is build inn!
Also when I start bluetooth I get :

/etc/init.d/bluetooth start
 * Starting Bluetooth...
 *     Starting hcid...                                                   [ ok ]
 *     Starting sdpd...                                                   [ ok ]
 *     Starting rfcomm...
Can't open RFCOMM control socket: Address family not supported by protoc  [ !! ]



On Sun, 06 Mar 2005 14:55:08 +0100, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Adis,
> 
> > Well I get this output when I run hciconfig -a
> >
> > Can't open HCI socket.: Address family not supported by protocol
> > What can I do to make that work?
> 
> are you sure that the kernel modules bluetooth.ko and hci_usb.ko are
> loaded?
> 
> > Regarding KDE and GNOME.. I don't use any of them.
> > Is there a nice command tool for that? Tryed obexftp
> > but with no luck.
> 
> The latest version of obexftp and an OpenOBEX library with Bluetooth
> support should work.
> 
> Regards
> 
> Marcel
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
