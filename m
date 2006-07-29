Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Felix Homann <fexpop@onlinehome.de>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Date: Sat, 29 Jul 2006 14:11:23 +0200
References: <200607271240.49400.fexpop@onlinehome.de>
	<200607281700.24209.fexpop@onlinehome.de>
	<1154099270.2298.41.camel@localhost>
In-Reply-To: <1154099270.2298.41.camel@localhost>
MIME-Version: 1.0
Message-Id: <200607291411.23859.fexpop@onlinehome.de>
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

Hi Marcel,

On Friday 28 July 2006 17:07, Marcel Holtmann wrote:
> > No, unfortunately the settings I've changed via dbus-test are lost after
> > unplugging the dongle.
>
> they must stay, because otherwise it is a bug. You did set the
> discoverable timeout to zero, do you?

sure, I have. It's probably a bug then. But keep in mind I'm using dbus-test 
with the Debian distributed bluez-utils (3.1-3), maybe it's already fixed in 
3.2..

Here's what I did:

# dbus-test -i hci0 SetDiscoverableTimeout 0
# dbus-test -i hci0 SetMode discoverable
# dbus-test -i hci0 GetMode
discoverable
# dbus-test -i hci0 GetDiscoverableTimeout
0

Unplug the dongle, then immediately after plugging it in again:

# dbus-test -i hci0 GetDiscoverableTimeout
180
# dbus-test -i hci0 GetMode
discoverable

Wait some (~3) minutes:

# dbus-test -i hci0 GetMode
connectable

Kind regards,

Felix




-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
