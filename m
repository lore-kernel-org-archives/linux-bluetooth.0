Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] ISSC USB Dongle does not work with current bluez?
From: Marcel Holtmann <marcel@holtmann.org>
To: Andreas Krause <Andreas.Krause@web.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200407311531.20139.Andreas.Krause@web.de>
References: <200407222124.44032.Andreas.Krause@web.de>
	 <200407231303.45860.Andreas.Krause@web.de>
	 <1091269903.7891.121.camel@pegasus>
	 <200407311531.20139.Andreas.Krause@web.de>
Content-Type: text/plain
Message-Id: <1091294431.27018.0.camel@pegasus>
Mime-Version: 1.0
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
Date: Sat, 31 Jul 2004 19:20:31 +0200

Hi Andreas,

> > it looks like that this device needs the HCI_Reset before it can run an
> > inquiry. Funny is that every other HCI command work without it. Try the
> > attached patch.
> 
> Patch works. Thanks! All works as it should.
> When will this patch be in the official kernel 2.6 tree?

very soon I hope. In the meantime you can use patch-2.6.7-mh4 which
includes this patch and also the BNEP default protocol filters fix.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
