Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Felix Homann <fexpop@onlinehome.de>
To: bluez-users@lists.sourceforge.net
Date: Fri, 28 Jul 2006 12:03:27 +0200
References: <200607271240.49400.fexpop@onlinehome.de>
	<200607281128.09414.fexpop@onlinehome.de>
	<1154079513.2298.20.camel@localhost>
In-Reply-To: <1154079513.2298.20.camel@localhost>
MIME-Version: 1.0
Message-Id: <200607281203.27951.fexpop@onlinehome.de>
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

On Friday 28 July 2006 11:38, Marcel Holtmann wrote:
> the dbus-test is a Python script. Simple checkout the CVS and use this
> one. You need to modify DiscoverableTimeout and Mode. No need to update
> the whole BlueZ packages.

Here's what I get:

#./dbus-test
  File "./dbus-test", line 178
    @dbus.decorators.explicitly_pass_message
    ^
SyntaxError: invalid syntax

BTW, if I could change settings via dbus-test would they be remembered the 
next time I plug the dongle in?

Furthermore, if iscan/pscan options in hcid.conf are not working as before it 
shoud be mentioned somewhere in the documentation.

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
