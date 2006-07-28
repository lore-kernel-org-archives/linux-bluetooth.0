Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <200607281100.44745.fexpop@onlinehome.de>
References: <200607271240.49400.fexpop@onlinehome.de>
	<200607272208.06047.fexpop@onlinehome.de>
	<1154049600.7650.6.camel@localhost>
	<200607281100.44745.fexpop@onlinehome.de>
Date: Fri, 28 Jul 2006 11:09:05 +0200
Message-Id: <1154077745.2298.17.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Several problems with bluez-utils 3.1,
	kbluetoothd and a Belkin dongle in Debian
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Felix,

> > now you are mixing things. 
> 
> I don't think so. In my original post I mentioned two issues. One could be 
> worked around by "hciconfig hci0 inqmode 0". kdebluetoothd can find other 
> devices afterwards. 
> 
> (BTW, why is this only necessary for kdebluetoothd, 'hcitool scan' works fine 
> without setting the inqmode first. Why has this not been an issue with the 
> 2.x series of bluez?)

the default inquiry mode for 2.x is 0. It will never be changed until
you tell it to change. For the 3.x generation the highest possible
inquiry mode will be set. It will be determined from the feature bits or
some hardcoded quirks.

To make inquiry mode 1 or 2, you need to know about Inquiry Results with
RSSI and Extended Inquiry Results. And for some broken dongles also
about Inquiry Results with RSSI and Page Scan. Seems kdebluetooth
doesn't know about them.

And this is where the new D-Bus API comes into play. It takes care of
all these things for you.

> The other issue didn't get a reply. (Maybe I should have put both issues in 
> differnet threads like I did in the Debian BTS, sorry..)
> 
> > The inquiry mode has nothing to do with the 
> > scan mode.
> 
> Sure, but there's still the other issue: My system can't be found by other 
> devices. Here's a more detailed report:
> 
> 1. My system can only be found by other devices if I enable inquiry scan 
> manually using 'hciconfig hci0 iscan' (or piscan). It's the only way I found 
> so far. 'hciconfig -a' will show "UP RUNNING ISCAN". 
> 
> 2. "iscan enable;" in hcid.conf will not make my system visible (in 
> contradiction to what the man page says), 'hciconfig -a' will show "UP 
> RUNNING PSCAN".
> 
> 3. "pscan disable;" in hcid.conf  will not disable PSCAN.  'hciconfig -a' will 
> show "UP RUNNING PSCAN".
> 
> 4. It doesn't matter (with respect to 'hciconfig -a' output and visibility) at 
> all if there is any 'iscan/pscan enable/disable' line at all: PSCAN will show 
> up, ISCAN not.
> 
> 5. All of this happens with every BT card/dongle I have at hand 
> (SPHINX/Belkin/EPoX).

First of all the setting iscan on and pscan off somehow works, but is
totally stupid. It means you set your device visible, but not
connectable. This also means that the remote side can find you, but
can't resolve your name. Think about it.

> > The scan mode defines is you are visible and connectable. The D-Bus API
> > sets you to connectable only unless you disable the discoverable timeout
> > and set your yourself to discoverable.
> 
> How do I set the discoverable timeout? How am I supposed to set myself 
> discoverable? Are there new options in hcid.conf? Where is it documented?

Check utils/hcid/dbus-api.txt in the CVS. It also contains a dbus-test
script that can be used to modify these settings.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
