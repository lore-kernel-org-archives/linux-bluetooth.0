Return-Path: <daryl@wideray.com>
Errors-To: <daryl@wideray.com>
From: "Daryl Van Vorst" <daryl@wideray.com>
To: "'Marcel Holtmann'" <marcel@holtmann.org>
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Rfcomm Use Count
Date: Wed, 22 Sep 2004 10:57:40 -0700
Message-ID: <002d01c4a0cd$a7888b60$1a01010a@baked>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1095861229.6223.32.camel@pegasus>
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel,

> after more and more thinking about that problem I am almost=20
> sure that it
> is right to call rfcomm_sock_kill() in the state change=20
> function. Anyway
> we must do this on an unlocked socket. Here is my proposal=20
> for the final
> patch, but we need real testing on this so that I can be sure=20
> that there
> are no side effects. Can anyone test it on SMP or HT systems?

I manually applied your patch to my 2.4 kernel, and it seems to work =
fine. I
haven't been able to break it yet. Looks good. I will keep trying.

Does this change make the "if (sk->state =3D=3D BT_CLOSED)" statement in
bluez_accept_dequeue() redundant?

This is important because if somehow a socket is in BT_CLOSED state and =
is
in the accept queue during shutdown, then rfcomm_cleanup_listen() can't
clean it up (because bluez_accept_dequeue() won't return it). I think =
your
changes make it impossible for there to ever be an rfcomm socket (or =
l2cap
socket) in the BT_CLOSED state in the accept queue. If that's true, then
this isn't an issue. Thoughts?

Do you think we've covered the case where there are incomming =
connections
while things are at various stages of being shut down? I think we're ok, =
but
I wanted to bring it up.

-Daryl.
