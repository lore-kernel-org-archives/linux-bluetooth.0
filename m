Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <5f30e2610607260812p561f00aar8cf2e0b79a247cbb@mail.gmail.com>
References: <5f30e2610607260812p561f00aar8cf2e0b79a247cbb@mail.gmail.com>
Date: Thu, 27 Jul 2006 09:39:37 +0200
Message-Id: <1153985977.9543.1.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] DBus and BlueZ 3.x
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

Hi Jeff,

> I've been following the list for a while, but I never picked up on
> what exactly DBus does for BlueZ.  It is my understanding that in
> BlueZ before 3.0, the socket() interface for userland API is
> implemented by an ioctl() interface to the kernel.  In BlueZ 3.x, is
> all the HCI is handled by passing messages via DBus instead of
> ioctl()?

with our D-Bus API for BlueZ we provide a really nice an easy
configuration interface that can be used without linking the Bluetooth
library or be bound the C/C++ language.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
