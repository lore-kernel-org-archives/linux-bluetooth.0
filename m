Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Rfcomm Use Count
From: Marcel Holtmann <marcel@holtmann.org>
To: Daryl Van Vorst <daryl@wideray.com>
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <003301c4a0d7$1982c5b0$1a01010a@baked>
References: <003301c4a0d7$1982c5b0$1a01010a@baked>
Content-Type: text/plain
Message-Id: <1095881636.6223.117.camel@pegasus>
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
Date: Wed, 22 Sep 2004 21:33:56 +0200

Hi Daryl,

> > > Does this change make the "if (sk->state == BT_CLOSED)" statement in
> > > bluez_accept_dequeue() redundant?
> > 
> > I think so. Haven't thought about it so far.
> > 
> > > This is important because if somehow a socket is in 
> > BT_CLOSED state and is
> > > in the accept queue during shutdown, then 
> > rfcomm_cleanup_listen() can't
> > > clean it up (because bluez_accept_dequeue() won't return 
> > it). I think your
> > > changes make it impossible for there to ever be an rfcomm 
> > socket (or l2cap
> > > socket) in the BT_CLOSED state in the accept queue. If 
> > that's true, then
> > > this isn't an issue. Thoughts?
> > 
> > Sorry, but I can't follow your point here. Please explain it again.
> 
> Bluez_accept_dequeue() won't return a socket if it is in the closed state.
> So rfcomm_cleanup_listen() will never call close and kill on the socket
> because ...accept_dequeue() never returns it (it just unlinks it). And then
> we would have the use count problem. But if there is no possibility of a
> socket being in the closed state on the accept queue (for rfcomm at least),
> then this isn't an issue.
> 
> I think this is fixed - so if I'm still talking nonsense, just ignore it. ;)

I understand what you mean and it should be impossible to have an socket
on the accept_q with state BT_CLOSED. May you wanna remove the extra
code in ...accept_dequeue() and only leave a warning message there when
you do your tests. However this extra code should not harm and I don't
see an easy solution for getting the module reference decrementing right
when we have to do it in ...accept_dequeue() for all socket types.

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
