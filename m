Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20060905165333.GB16417@suse.de>
References: <20060905165333.GB16417@suse.de>
Date: Tue, 05 Sep 2006 19:15:14 +0200
Message-Id: <1157476514.5963.7.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] more udev rules for pcmcia cards
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

Hi Stefan,

> while updating my packages i found that we (SUSE) still have additional
> udev rules for pcmcia cards.
> The origin of those is not 100% clear, there are rumours that some 
> unfortunate trainee extracted them from the old pcmcia package 
> configuration.
> I have not verified them with actual hardware.

non of them are needed, because they are for PCMCIA cards that have
their own drivers and don't need hciattach to attach the serial port to
the Bluetooth core. You can strip all of them. No idea on how they ever
worked actually.

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
