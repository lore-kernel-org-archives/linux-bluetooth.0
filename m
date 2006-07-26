Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20060726094906.GB6549@esaurito.net>
References: <20060725165124.GB14679@esaurito.net>
	<1153848241.31069.31.camel@localhost>
	<20060726094906.GB6549@esaurito.net>
Date: Wed, 26 Jul 2006 16:20:21 +0200
Message-Id: <1153923621.746.47.camel@localhost>
Mime-Version: 1.0
Cc: Kay Sievers <kay.sievers@vrfy.org>, Felix Homann <fexpop@onlinehome.de>,
        bluez-devel@lists.sf.net
Subject: Re: [Bluez-devel] bluez udev rules for pcmcia devices
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

Hi Filippo,

> > the first thing is that every line for dtl1_cs, bt3c_cs, bluecard_cs,
> > bt950_cs and btuart_cs must be removed. These are not TTY drivers and
> > totally useless lines anyway.
> > 
> > Second is that I prefer to call the script "bluetooth_hciattach" or
> > better maybe "bluetooth_serial", because this is what it is doing. It is
> > not a generic udev helper for Bluetooth. The job is to attach the serial
> > port to the hci_uart driver. We can also strip the "/lib/udev/" prefix
> > and the ".sh" suffix.
> > 
> > Calling /etc/init.d/bluetooth from the script must go away. Either the
> > support for Bluetooth is enabled or not. The udev helper shouldn't care
> > about it at all.
> > 
> > Also the line "DEVICE=`echo $DEVNAME|sed -e 's_/dev/__'`" in the script
> > is not needed at all, because hciattach can handle full device names
> > without any problems. And in case of some crazy persistent naming rules
> > it is the safer choice.
> 
> agreed, I've fixed this in
> http://svn.debian.org/wsvn/pkg-bluetooth/bluez-utils/trunk/debian/bluetooth_serial?op=file&rev=0&sc=0
> and
> http://svn.debian.org/wsvn/pkg-bluetooth/bluez-utils/trunk/debian/bluez-pcmcia-support.udev?op=file&rev=0&sc=0

looks good.

> > >From a programming perspective, the TYPEID should be moved into
> > start_serial, because it is its only user.
> 
> I'm failing to understand this :(

You have a generic TYPEID variable that you define at the top of the
script. Don't do this until you have to use it for all function. So
define it just before you need it. Like in your new version of the
script.

> > If this script isn't distributed via bluez-utils, then the script must
> > check if hciattach is installed. Otherwise you will see errors and this
> > might not be what users expect.
> 
> fixed as well

In case of stop_serial() you might wanna do the same. If hciattach is
not installed then we are not responsible for cleaning up.

> > And we should actually only call hciattach instances using the specified
> > device. Don't kill something that you didn't start.
> 
> agreed but since the script is (supposed to be) invoked only by udev on
> add/remove pcmcia bt cards, I think we can assume the script is the only user of
> $DEVNAME.

You can't make that assumption.

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
