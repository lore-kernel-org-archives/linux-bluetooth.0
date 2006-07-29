Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <1154079833.10564.5.camel@localhost>
References: <1154042299.16913.6.camel@localhost>
	<1154050360.7650.13.camel@localhost>
	<1154079833.10564.5.camel@localhost>
Date: Sat, 29 Jul 2006 14:58:53 +0200
Message-Id: <1154177933.25939.17.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Several problems with bluez-utils 3.1,
	kbluetoothd and a	Belkin dongle in Debian
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

Hi Alastair,

> > the attached patch might help. If we have a Bluetooth 1.0b or 1.1 device
> > without a quirk to enable inqmode, we shouldn't even try to change the
> > inquiry mode. Seems that the Broadcom dongles are really sensible if you
> > try to send a command they don't support.
> 
> Thanks for the patch. That does get rid of the connection timed out
> error in syslog. Although I'm still experiencing the fact that ISCAN is
> not enabled, although that seems to be another problem associated with
> the way 3.x works for detecting features (According to the another
> thread).

it really looks like a bug. Feel free to send in a patch to fix it.

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
