Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Rfcomm Use Count
From: Marcel Holtmann <marcel@holtmann.org>
To: Daryl Van Vorst <daryl@wideray.com>
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <002d01c4a0cd$a7888b60$1a01010a@baked>
References: <002d01c4a0cd$a7888b60$1a01010a@baked>
Content-Type: text/plain
Message-Id: <1095876765.6223.85.camel@pegasus>
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
Date: Wed, 22 Sep 2004 20:12:45 +0200

Hi Daryl,

> I manually applied your patch to my 2.4 kernel, and it seems to work fine. I
> haven't been able to break it yet. Looks good. I will keep trying.

try to test your normal stuff to make sure that it doesn't break
anything else.

> Does this change make the "if (sk->state == BT_CLOSED)" statement in
> bluez_accept_dequeue() redundant?

I think so. Haven't thought about it so far.

> This is important because if somehow a socket is in BT_CLOSED state and is
> in the accept queue during shutdown, then rfcomm_cleanup_listen() can't
> clean it up (because bluez_accept_dequeue() won't return it). I think your
> changes make it impossible for there to ever be an rfcomm socket (or l2cap
> socket) in the BT_CLOSED state in the accept queue. If that's true, then
> this isn't an issue. Thoughts?

Sorry, but I can't follow your point here. Please explain it again.

> Do you think we've covered the case where there are incomming connections
> while things are at various stages of being shut down? I think we're ok, but
> I wanted to bring it up.

Actually I don't know. In general we should be protected against that
with our locking.

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
