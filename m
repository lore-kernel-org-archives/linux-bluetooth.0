Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Nicholas A. Preyss" <nalp@gmx.net>
To: bluez-users mailing list <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] can't establish a connection
Message-ID: <20040809214036.GB30443@gmx.net>
References: <1091742606.6143.17.camel@localhost> <1091747064.6143.25.camel@localhost> <1091748133.20839.63.camel@pegasus> <200408060216.05030.cijoml@volny.cz> <1091810383.4570.14.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1091810383.4570.14.camel@localhost>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 9 Aug 2004 23:40:36 +0200

On  0, ben4fun <ben_4_fun@freenet.de> wrote:
> It's done.
> After a reboot, I did  "mount -t usbdevfs none /proc/bus/usb" from the
> USB-howto . It confirmed me it was already mounted. But it is strange
> that /proc/bus/usb/device file is still empty.
> 
> Then I did "hciconfig hci0 up"
> and I still have "Can't init device hci0. Connection timed out(110)"

Check if hcid is running. If it is, try a more recent kernel. 

nicholas


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
