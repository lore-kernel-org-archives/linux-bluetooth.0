Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20060725165124.GB14679@esaurito.net>
References: <20060725165124.GB14679@esaurito.net>
Date: Tue, 25 Jul 2006 19:24:01 +0200
Message-Id: <1153848241.31069.31.camel@localhost>
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

> I think we should discuss udev rules for bluez (WRT pcmcia cards) as pointed out
> by Marcel while discussing debian bug #378839.
> So far there's a rules file here:
> http://bugs.debian.org/cgi-bin/bugreport.cgi/bluez-pcmcia-support.rules?bug=378839;msg=72;att=1
> and the bluetooth.sh script here:
> http://bugs.debian.org/cgi-bin/bugreport.cgi/bluetooth.sh?bug=378839;msg=72;att=2
> both borrowed in the wild (from SuSE IIRC). See the full bug log for further
> discussion. I basically agree with Marcel because while the bluetooth.sh script
> is invoked /usr might not be mounted yet thus it should not try to execute
> /etc/init.d/bluetooth.

the first thing is that every line for dtl1_cs, bt3c_cs, bluecard_cs,
bt950_cs and btuart_cs must be removed. These are not TTY drivers and
totally useless lines anyway.

Second is that I prefer to call the script "bluetooth_hciattach" or
better maybe "bluetooth_serial", because this is what it is doing. It is
not a generic udev helper for Bluetooth. The job is to attach the serial
port to the hci_uart driver. We can also strip the "/lib/udev/" prefix
and the ".sh" suffix.

Calling /etc/init.d/bluetooth from the script must go away. Either the
support for Bluetooth is enabled or not. The udev helper shouldn't care
about it at all.

Also the line "DEVICE=`echo $DEVNAME|sed -e 's_/dev/__'`" in the script
is not needed at all, because hciattach can handle full device names
without any problems. And in case of some crazy persistent naming rules
it is the safer choice.

>>From a programming perspective, the TYPEID should be moved into
start_serial, because it is its only user.

If this script isn't distributed via bluez-utils, then the script must
check if hciattach is installed. Otherwise you will see errors and this
might not be what users expect.

And we should actually only call hciattach instances using the specified
device. Don't kill something that you didn't start.

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
