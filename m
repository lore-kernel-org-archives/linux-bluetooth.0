Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Rfcomm Use Count
From: Marcel Holtmann <marcel@holtmann.org>
To: Daryl Van Vorst <daryl@wideray.com>
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <002601c49f3b$7f80c990$1a01010a@baked>
References: <002601c49f3b$7f80c990$1a01010a@baked>
Content-Type: text/plain
Message-Id: <1095705177.5731.36.camel@pegasus>
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
Date: Mon, 20 Sep 2004 20:32:57 +0200

Hi Daryl,

> > At the moment I must admit that I have no idea how to fix 
> > this in a sane
> > way. It seems that this bug is in there from the beginning and a wrong
> > fix can cause unexpected side effects.
> > 
> > I don't think that the problem is in rfcomm_sock_cleanup_listen(),
> > because the wrong use count is already present after step 3. 
> > So when we
> > close a connected DLC that is not accepted yet, we still have 
> > it on the
> > accept queue then we have a problem. Maybe there is a bug in our state
> > machine and this is not socket related.
> 
> Incoming connections must be added to the accept queue (unless I'm really
> missing something). So the issue is just what to do when the remote side
> closes them before accept() gets to them.

that is correct.

> Making bluez_accept_dequeue() return sockets regardless of state is a
> potential solution. Accept() for rfcomm and l2cap would then need to be
> modified to kill already closed sockets. The existing loop in the accept()'s
> would need to be modified or a new one added to handle
> bluez_accept_dequeue() not always returning an open socket.

I don't like that idea and the problem is not in ...cleanup_listen() and
so I am not sure if it will really help us.

> I may not have been clear about my thoughts on rfcomm_sock_cleanup_listen().
> If bluez_accept_dequeue() did return sockets regardless of state, then
> rfcomm_sock_cleanup_listen() should work (unless calling close on an already
> closed socket causes trouble). When it calls rfcomm_sock_kill(), sock_put()
> gets called which calls destruct() which should decrement the use count.

The ...cleanup_listen() kicks in when you stop the listening server, but
that is far too late. The problematic part already happened. We close a
connection that wasn't accepted. We must fix it there and not afterwards
like somekind of garbage collection. This is the kernel and not some
weird Jave/C++ code.

> What if bluez_accept_dequeue() called sk->shutdown() on sockets which are
> already closed in the accept queue?

I am not sure about the side effects, but this can be a solution. What I
think is that setting the socket to BT_CLOSED is wrong. Maybe using
BT_DISCONN is better, but this involves changing the state machine.

> I'll try out l2cap later for you. We should see the same thing.

I am not sure anymore. Maybe this is only RFCOMM related.

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
