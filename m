Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] IOGear GBU301 and Kernel 2.4.20
From: Marcel Holtmann <marcel@holtmann.org>
To: cijoml@volny.cz
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200408090833.40336.cijoml@volny.cz>
References: <20040809050753.17815.qmail@web60801.mail.yahoo.com>
	 <200408090811.14790.cijoml@volny.cz> <1092033015.21815.1.camel@pegasus>
	 <200408090833.40336.cijoml@volny.cz>
Content-Type: text/plain
Message-Id: <1092033656.21815.6.camel@pegasus>
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
Date: Mon, 09 Aug 2004 08:40:56 +0200

Hi Michal,

> > > > you must install the development package of the USB library.
> > >
> > > Marcel shouldn't configure script find these missing libs?
> >
> > it does this, but of course you must have installed them. If not it will
> > disable the compilation of that program.
> 
> He wrote, that he --enable-bcm203x - so configure should fail when by hand 
> enabled and libs not available

configure will not fail. It only fails when the Bluetooth library is not
present. The point is even if configure won't compile a specific part,
you still can do Makefile tricks to compile it (call "make bcm203x").

On the other hand it can be possible that his USB library is simply too
old. If this is the problem I must adjust the configure check.

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
