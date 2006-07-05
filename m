Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.63.0607051445110.3048@redbean.intranet.gw-instruments.de>
References: <003e01c69e8c$c0717970$2800a8c0@Desarrollo>
	<Pine.LNX.4.63.0607031426320.28132@redbean.intranet.gw-instruments.de>
	<e1effdeb0607030546w38382e5ct4bb6bed8c0271da8@mail.gmail.com>
	<01e101c69eb9$50f41670$2800a8c0@Desarrollo>
	<003001c69f95$0b1ab140$2800a8c0@Desarrollo>
	<e1effdeb0607041156y797a376cn2081738e19559605@mail.gmail.com>
	<e1effdeb0607041532x5701ab2eib524b5c70f0dc436@mail.gmail.com>
	<1152053676.29250.4.camel@localhost>
	<003501c6a02d$e6b8c8c0$2800a8c0@Desarrollo>
	<1152102849.4260.12.camel@localhost>
	<Pine.LNX.4.63.0607051445110.3048@redbean.intranet.gw-instruments.de>
Date: Wed, 05 Jul 2006 15:07:51 +0200
Message-Id: <1152104871.4260.15.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Serial comunication RFCOMM
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Peter,

> > specify always the source interface (dongle). All BlueZ tools accept the
> > parameter --device (-i hci0 for example).
> Obvious :-). 
> 
> Sorry, can't resist 

yeah. This one is funny. It is legacy. The -i was for interface as used
by many IP related tools and --device for the actual Bluetooth device.
We screwed that up, but it is consistent. Nowadays I would refer to
adapter and not devices for the local ones.

Regards

Marcel



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
