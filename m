Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <200607272208.06047.fexpop@onlinehome.de>
References: <200607271240.49400.fexpop@onlinehome.de>
	<1153997014.9543.4.camel@localhost>
	<200607271258.45178.fexpop@onlinehome.de>
	<200607272208.06047.fexpop@onlinehome.de>
Date: Fri, 28 Jul 2006 03:20:00 +0200
Message-Id: <1154049600.7650.6.camel@localhost>
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

> > kbluetoothd finds other devices after that command! (It doesn't make my PC
> > visible to other devices though). 
> 
> Part of the visibility issue seems to be that only PSCAN will be enabled 
> regardless of what I specify in hcid.conf. If I manually do a 'hciconfig hci0 
> piscan' everything is fine again. 

now you are mixing things. The inquiry mode has nothing to do with the
scan mode.

The inquiry mode defines what inquiry result events you will see.
Basically you wanna use Inquiry with RSSI from the Bluetooth 1.2
specification to additionally get the RSSI value.

The scan mode defines is you are visible and connectable. The D-Bus API
sets you to connectable only unless you disable the discoverable timeout
and set your yourself to discoverable. This is a feature of the new 3.x
generation that will make you automatically unvisible after a certain
amount of time.

These two things are not related. And start sending in "hcidump -X -V"
outputs instead of speculating.

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
