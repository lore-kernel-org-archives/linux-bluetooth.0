Return-Path: <daryl@wideray.com>
Errors-To: <daryl@wideray.com>
From: "Daryl Van Vorst" <daryl@wideray.com>
To: "'Marcel Holtmann'" <marcel@holtmann.org>
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Rfcomm Use Count
Date: Mon, 20 Sep 2004 13:52:48 -0700
Message-ID: <002f01c49f53$ca12fb00$1a01010a@baked>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1095709726.5731.44.camel@pegasus>
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel,

> > With my suggestion above the condition would be handled by=20
> either accept()
> > or cleanup_listen(), whichever is called first. Though I=20
> guess you could
> > still consider that to be garbage collection.
>=20
> when it is handled in ..cleanup_listen() then it gets handled when you
> kill the server process. I think this is far too late, because you can
> have more than one connection attempts in between. We must handle this
> when we close the connection.

Agreed, but if bluez_accept_dequeue() returns closed connections then it =
can
also be handled in accept(). So this would only be an issue in =
situations
where a socket is listening for a long time without there ever being a =
call
to accept().

The topic of cleanup_listen() came up just because the only way it has
appeared for me in normal use was with incomming connections while the
server was being shut down. While the server is running, incomming
connections are returned by accept() before they get closed by the =
remote
side.

It is still unclear to me why I could not bind to the socket (error was
address already in use, 98) when I tried to restart the server. This
behaviour is not seen with the simple test program I sent last week (and =
so
might be unrelated).

> This is correct and so I don't really like this approach. I=20
> think there
> is a simply logic mistake in the closing path of the RFCOMM code.

Could be. Then the closing path of the rfcomm code would need to be able =
to
remove connections from the accept queue. This might be a difficult =
change.

-Daryl.
