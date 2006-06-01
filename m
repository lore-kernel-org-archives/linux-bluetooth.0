Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <70DCB28C5BB04A4BBB1C8512589BAC65D4F163@MAIL006.mail.lan>
References: <70DCB28C5BB04A4BBB1C8512589BAC65D4F163@MAIL006.mail.lan>
Date: Thu, 01 Jun 2006 19:56:08 +0200
Message-Id: <1149184568.28511.35.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Strange behaviour
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

Hi Chris,

> > > even with the latest FC5 kernel?
> > 
> > No. Now I see the same thing you do.
> 
> I take that back - sorry.
> 
> I actually didn't have a dongle attached. With a single dongle attached,
> my test code does still start fine.
> 
> Kernel is 2.6.16-1.2122_FC5smp (from cat /proc/version)
> I've also got these installed :
> bluez-hcidump.i386 1.30-1
> bluez-libs.i386 2.25-1
> bluez-libs-devel.i386 2.25-1
> bluez-pin.i386 0.30-2
> bluez-utils.i386 2.25-4
> (all from yum list bluez\*)
> 
> Basically, this is a fully-updated FC5.

then it must be the bluez-libs from CVS.

Regards

Marcel




_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
