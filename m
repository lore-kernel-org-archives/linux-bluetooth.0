Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] BT3C ceased working in kernel 2.6.6
From: Marcel Holtmann <marcel@holtmann.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Antti =?ISO-8859-1?Q?M=E4kel=E4?= <zarhan@cs.tut.fi>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1084383638.4426.391.camel@hades.cambridge.redhat.com>
References: <Pine.GSO.4.58.0405111227090.9721@viherkiuru.cs.tut.fi>
	 <1084371696.4426.160.camel@hades.cambridge.redhat.com>
	 <1084382223.25099.72.camel@pegasus>
	 <1084383638.4426.391.camel@hades.cambridge.redhat.com>
Content-Type: text/plain
Message-Id: <1084384099.25099.98.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 12 May 2004 19:48:19 +0200

Hi David,

> > right now I am not going to keep up with a new version of bluefw,
> > because the bt3c_cs driver didn't use it anymore and for 2.6 the bcm203x
> > kernel firmware loader works much better. However I am going to apply
> > patches if they look correct. So this one is in CVS.
> 
> I know it's obsolete for the PC card; is it no longer needed for USB
> either with a 2.6 kernel?

the bcm203x driver can be used to load the firmware into Broadcom based
dongles. It doesn't replaces the bluefw, because in some cases it is
better to not use an extra kernel module. However the method with the
kernel driver for firmware loading is working much better for me.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
