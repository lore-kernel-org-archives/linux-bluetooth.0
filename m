Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Rfcomm Use Count
From: Marcel Holtmann <marcel@holtmann.org>
To: Daryl Van Vorst <daryl@wideray.com>
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <004d01c4a0dd$b09a3810$1a01010a@baked>
References: <004d01c4a0dd$b09a3810$1a01010a@baked>
Content-Type: text/plain
Message-Id: <1095883037.5544.5.camel@pegasus>
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
Date: Wed, 22 Sep 2004 21:57:17 +0200

Hi Daryl,

> > I understand what you mean and it should be impossible to 
> > have an socket
> > on the accept_q with state BT_CLOSED. May you wanna remove the extra
> > code in ...accept_dequeue() and only leave a warning message 
> > there when
> > you do your tests. However this extra code should not harm and I don't
> > see an easy solution for getting the module reference 
> > decrementing right
> > when we have to do it in ...accept_dequeue() for all socket types.
> 
> I think I'll leave the code as is, unless you're considering removing the
> code in accept_dequeue(). If there's a problem, we'll see the use count go
> up.

replace it with a BT_ERR message (or only add one), so that you see if
it gets called in your tests. I think the code is useless, but I am not
100% sure.

> Thanks for working on this...  Looks like you spent some late nights on it.

You are welcome. Yes, I spent some time to understand what is really
going on. Btw someone must look at the SCO code and check if we have the
same problem there.

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
