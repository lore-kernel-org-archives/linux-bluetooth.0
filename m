Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Rfcomm Use Count
From: Marcel Holtmann <marcel@holtmann.org>
To: Daryl Van Vorst <daryl@wideray.com>
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <002a01c49f43$03879960$1a01010a@baked>
References: <002a01c49f43$03879960$1a01010a@baked>
Content-Type: text/plain
Message-Id: <1095709726.5731.44.camel@pegasus>
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
Date: Mon, 20 Sep 2004 21:48:46 +0200

Hi Daryl,

> > > I may not have been clear about my thoughts on 
> > rfcomm_sock_cleanup_listen().
> > > If bluez_accept_dequeue() did return sockets regardless of 
> > state, then
> > > rfcomm_sock_cleanup_listen() should work (unless calling 
> > close on an already
> > > closed socket causes trouble). When it calls 
> > rfcomm_sock_kill(), sock_put()
> > > gets called which calls destruct() which should decrement 
> > the use count.
> > 
> > The ...cleanup_listen() kicks in when you stop the listening 
> > server, but
> > that is far too late. The problematic part already happened. 
> > We close a
> > connection that wasn't accepted. We must fix it there and not 
> > afterwards
> > like somekind of garbage collection. This is the kernel and not some
> > weird Jave/C++ code.
> 
> With my suggestion above the condition would be handled by either accept()
> or cleanup_listen(), whichever is called first. Though I guess you could
> still consider that to be garbage collection.

when it is handled in ..cleanup_listen() then it gets handled when you
kill the server process. I think this is far too late, because you can
have more than one connection attempts in between. We must handle this
when we close the connection.

> > > What if bluez_accept_dequeue() called sk->shutdown() on 
> > sockets which are
> > > already closed in the accept queue?
> > 
> > I am not sure about the side effects, but this can be a 
> > solution. What I
> > think is that setting the socket to BT_CLOSED is wrong. Maybe using
> > BT_DISCONN is better, but this involves changing the state machine.
> 
> Calling sk->shutdown() is bluez_accept_dequeue() would be virtually the same
> timing (i.e. garbage collecting likeness) as the suggestion above (returning
> the closed socket in ...accept_dequeue). It would happen only when accept()
> or cleanup_listen() are called.

This is correct and so I don't really like this approach. I think there
is a simply logic mistake in the closing path of the RFCOMM code.

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
