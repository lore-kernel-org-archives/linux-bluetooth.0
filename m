Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Rfcomm Use Count
From: Marcel Holtmann <marcel@holtmann.org>
To: Daryl Van Vorst <daryl@wideray.com>
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <002d01c49f4e$09d3afb0$1a01010a@baked>
References: <002d01c49f4e$09d3afb0$1a01010a@baked>
Content-Type: text/plain
Message-Id: <1095712488.5731.50.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 20 Sep 2004 22:34:48 +0200

Hi Daryl,

> > > I can't get it to happen with l2cap. But I did notice that 
> > it takes a few
> > > seconds for the use count to go down after the listening 
> > program exits.
> > 
> > what do you see when you keep the listing program running and then do
> > some connects? Do the module reference count increases every time?
> 
> Each time I connect with l2test -n, I see the use count go up by 2. When I
> hit ctrl-c on l2test, the use count goes down by 1 after a few seconds.
> These excess increments (one for each connection) don't go away until the
> test program is killed.
> 
> So there is a bit of a problem.

then we use some kind of garbage collection already. This is bad and we
shouldn't do so, but right now I don't see the correct fix for this
behaviour.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
