Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Rfcomm Use Count
From: Marcel Holtmann <marcel@holtmann.org>
To: Daryl Van Vorst <daryl@wideray.com>
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <000c01c49c4a$ca42b9a0$1a01010a@baked>
References: <000c01c49c4a$ca42b9a0$1a01010a@baked>
Content-Type: text/plain
Message-Id: <1095411534.3280.17.camel@pegasus>
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
Date: Fri, 17 Sep 2004 10:58:54 +0200

Hi Daryl,

> I have a simple way to reproduce at least part of this bug. I don't have an
> up-to-date x86 machine to try this on, but I suspect you'll see the same
> behaviour:
> 
> 1. Compile and run the attached code on one machine
> 2. Connect to it from another machine using: rctest -n -P1 <bd_addr>
> 3. Hit ctrl-c on rctest
> 4. Hit ctrl-c on bzt (or whatever you called the compiled code)
> 5. lsmod and look at the rfcomm use count.
> 
> I think the problem stems from rfcomm_cleanup_listen() and
> bluez_accept_dequeue(). Bluez_accept_dequeue() won't return the socket if it
> is in the closed state, and so rfcomm_cleanup_listen() can't fully cleanup.
> 
> And if accept is called before rfcomm_cleanup_listen(), then (I think) the
> socket will be unlinked from the accept queue (by accept) but not killed,
> and so also will not get cleaned up.
> 
> Things appear to work if you reverse the order of steps 3 and 4.

I can verify that this bug exists even in a 2.6 kernel. There is no need
to execute step 4, because the missing decrementing of the use count is
already there after step 3. And I think the same problem will exists for
the L2CAP module. Please verify this for me.

> I'd send you a patch if I had a simple one, but I don't know what the best
> approach is. On solution may be to make bluez_accept_dequeue() always return
> the socket regardless of state and then fix anything that calls
> bluez_accept_dequeue() to handle the possibility of a closed socket being
> returned.

At the moment I must admit that I have no idea how to fix this in a sane
way. It seems that this bug is in there from the beginning and a wrong
fix can cause unexpected side effects.

I don't think that the problem is in rfcomm_sock_cleanup_listen(),
because the wrong use count is already present after step 3. So when we
close a connected DLC that is not accepted yet, we still have it on the
accept queue then we have a problem. Maybe there is a bug in our state
machine and this is not socket related.

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
