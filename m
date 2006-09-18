Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Pavel Machek <pavel@ucw.cz>
In-Reply-To: <20060917193659.GB2973@elf.ucw.cz>
References: <20060917140952.GA3349@elf.ucw.cz>
	<1158511979.24941.1.camel@localhost> <20060917193659.GB2973@elf.ucw.cz>
Date: Mon, 18 Sep 2006 08:20:11 +0200
Message-Id: <1158560411.30486.20.camel@localhost>
Mime-Version: 1.0
Cc: bluez-devel@lists.sf.net, kernel list <linux-kernel@vger.kernel.org>,
        maxk@qualcomm.com
Subject: Re: [Bluez-devel] bluetooth oops during resume from ram
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

Hi Pavel,

> > > If I suspend-to-RAM with usb active on thinkpad x60, I get an
> > > oops. Machine works okay after that, but...
> > > 
> > > it seems bluetooth is scribbling over more memory than was allocated
> > > (?)
> > 
> > not that I am aware of. Is this a plain 2.6.18-rc6 or did you apply
> > additional patches that might have caused this behavior?
> 
> I have some additional changes, but they should not affect this...
> 
> OTOH, I probably used this script:
> 
> 
> killall hciattach
> sleep .1
> setserial /dev/ttyBT baud_base 921600

whatever that is for. I thought the ttyBT was iPAQ specific or something
like that.

> hciattach -s 921600 /dev/ttyS0 bcsp

This is non-sense for a X60.

> hciconfig hci0 up
> hciconfig hci0 name billionton
> hciconfig /dev/ttyUB1

And what has ttyUB1 to do with it.

> ...even through there's no bluetooth at ttyS0 (as this machine has
> bluetooth on usb).

With my X41 the suspend to/from RAM works without problems.

I think this is something else.

Regards

Marcel



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
