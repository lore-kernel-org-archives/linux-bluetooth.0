Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Andreas Krause <Andreas.Krause@web.de>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] ISSC USB Dongle does not work with current bluez?
References: <200407222124.44032.Andreas.Krause@web.de> <200407231303.45860.Andreas.Krause@web.de> <1091269903.7891.121.camel@pegasus>
In-Reply-To: <1091269903.7891.121.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200407311531.20139.Andreas.Krause@web.de>
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
Date: Sat, 31 Jul 2004 15:31:19 +0200

> it looks like that this device needs the HCI_Reset before it can run an
> inquiry. Funny is that every other HCI command work without it. Try the
> attached patch.

Patch works. Thanks! All works as it should.
When will this patch be in the official kernel 2.6 tree?

CU - nak


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
