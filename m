Return-Path: <daryl@wideray.com>
Errors-To: <daryl@wideray.com>
From: "Daryl Van Vorst" <daryl@wideray.com>
To: "'Marcel Holtmann'" <marcel@holtmann.org>
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Rfcomm Use Count
Date: Mon, 20 Sep 2004 14:03:33 -0700
Message-ID: <003001c49f55$4a2d3610$1a01010a@baked>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1095712488.5731.50.camel@pegasus>
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel,

> > Each time I connect with l2test -n, I see the use count go 
> up by 2. When I
> > hit ctrl-c on l2test, the use count goes down by 1 after a 
> few seconds.
> > These excess increments (one for each connection) don't go 
> away until the
> > test program is killed.
> > 
> > So there is a bit of a problem.
> 
> then we use some kind of garbage collection already. This is 
> bad and we
> shouldn't do so, but right now I don't see the correct fix for this
> behaviour.

I just tried an experiment where I listen for a while before calling
accept(). I can raise the use cound by connecting, disconnecting, etc (as
before). As soon as accept() is called, the excess use count goes away.

Before accept() is called, the server will start refusing connections after
you fill up the accept queue. The queue is emptied with a single call to
accept().

-Daryl.
