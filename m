Return-Path: <daryl@wideray.com>
Errors-To: <daryl@wideray.com>
From: "Daryl Van Vorst" <daryl@wideray.com>
To: "'Marcel Holtmann'" <marcel@holtmann.org>
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Rfcomm Use Count
Date: Mon, 20 Sep 2004 13:11:38 -0700
Message-ID: <002d01c49f4e$09d3afb0$1a01010a@baked>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1095709821.5731.47.camel@pegasus>
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel,

> > I can't get it to happen with l2cap. But I did notice that 
> it takes a few
> > seconds for the use count to go down after the listening 
> program exits.
> 
> what do you see when you keep the listing program running and then do
> some connects? Do the module reference count increases every time?

Each time I connect with l2test -n, I see the use count go up by 2. When I
hit ctrl-c on l2test, the use count goes down by 1 after a few seconds.
These excess increments (one for each connection) don't go away until the
test program is killed.

So there is a bit of a problem.

-Daryl.
