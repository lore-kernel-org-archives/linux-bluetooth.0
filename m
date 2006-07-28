Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Felix Homann <fexpop@onlinehome.de>
To: bluez-users@lists.sourceforge.net
Date: Fri, 28 Jul 2006 11:28:09 +0200
References: <200607271240.49400.fexpop@onlinehome.de>
	<200607281100.44745.fexpop@onlinehome.de>
	<1154077745.2298.17.camel@localhost>
In-Reply-To: <1154077745.2298.17.camel@localhost>
MIME-Version: 1.0
Message-Id: <200607281128.09414.fexpop@onlinehome.de>
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

On Friday 28 July 2006 11:09, Marcel Holtmann wrote:
> First of all the setting iscan on and pscan off somehow works, but is
> totally stupid. It means you set your device visible, but not
> connectable. This also means that the remote side can find you, but
> can't resolve your name. Think about it.

Sure it's stupid. I did it only for testing purposes. I've mentioned it here 
just to illustrate that nothing in hcid.conf related to pscan/iscan seems to 
have any effect at all. (I've "iscan enable; pscan enable;" in my hcid.conf). 

> > How do I set the discoverable timeout? How am I supposed to set myself
> > discoverable? Are there new options in hcid.conf? Where is it documented?
>
> Check utils/hcid/dbus-api.txt in the CVS. It also contains a dbus-test
> script that can be used to modify these settings.

So, there's no way to make my system visible directly after plugging the 
dongle in without switching to CVS versions???? 

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
