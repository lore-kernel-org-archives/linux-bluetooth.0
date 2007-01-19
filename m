Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Choi Sonim <choisonim@gmail.com>
In-Reply-To: <4f436aae0701181559h63b7d509n5dc73c55353d8c79@mail.gmail.com>
References: <4f436aae0701172208l7ac85a75tc592fa15d1b57f8@mail.gmail.com>
	<1169108019.6853.1.camel@violet>
	<4f436aae0701181523y55ad36bdu9645c786a252c04e@mail.gmail.com>
	<1169164343.6853.7.camel@violet>
	<4f436aae0701181559h63b7d509n5dc73c55353d8c79@mail.gmail.com>
Date: Fri, 19 Jan 2007 02:02:50 +0100
Message-Id: <1169168570.6853.10.camel@violet>
Mime-Version: 1.0
Cc: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] /sys/devices/platform/bluetooth
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

Hi Choi,

> > > > > Where is the code that does the platform registration to this device :
> > > > > /sys/devices/platform/bluetooth
> > > >
> > > > you find it in net/bluetooth/hci_sysfs.c in the kernel source code.
> > >
> > > What is the purpose of the bluetooth platform device (and bus and class..) ?
> > >
> > > I guess that bluetooth devices would prefer to register themselves as children
> > > of their true bus (like USB or PCI or even serial) so when the system goes
> > > to suspend, their suspend function will be called before their father's
> > > (the true hardware bus of our bluetooth device).
> >
> > if they do have a physical parent. Some devices like virtual HCI or
> > serial based chips don't have a physical parent.
> 
> About the serial based chips -
> I'm sure they would like their suspend function to be called before the
> serial uart driver's suspend, so for them to set device parent to the
> serial device
> can be a benefit too, no ?

if you write a chip specific driver then yes. For all line discipline
based ones at the moment, you are simply out of luck.

> About the virtual HCI - I really don't know what are them, can you please
> explain this ?

You can emulate a HCI host device in userspace using hciemu.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
