Return-Path: <noring@nocrew.org>
Subject: Re: [gnome-bluetooth] Re: [Bluez-devel] What stuff in
	gnome-bluetooth does, and ideas for its future
From: Fredrik Noring <noring@nocrew.org>
To: Eugene Crosser <crosser@average.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1075488593.21795.37.camel@ariel.sovam.com>
References: <1064593223.12843.127.camel@saag>
	 <200401291230.00801.bluez-devel@schaettgen.de>
	 <1075401893.22564.51.camel@akka.yeti.nocrew.org>
	 <200401292119.45926.bluez-devel@schaettgen.de>
	 <1075486241.14644.34.camel@akka.yeti.nocrew.org>
	 <1075487167.26729.191.camel@pegasus>
	 <1075488593.21795.37.camel@ariel.sovam.com>
Content-Type: text/plain
Message-Id: <1075495308.14644.60.camel@akka.yeti.nocrew.org>
Mime-Version: 1.0
Date: Fri, 30 Jan 2004 21:41:48 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Eugene,

fre 2004-01-30 klockan 19.49 skrev Eugene Crosser:
> /etc may be on a read-only filesystem.  Imagine a bluetooth gadget based 
> on Linux burnt in ROM.

I suppose this easily can solved with a symlink? (Although I agree
with Marcel that /tmp is a better place.)

> (I continue to think that binary helper is a viable option for the low
> level interface.  It is very scalable: "lean" implementation for very
> simple environments may be cut down to just a few lines of shell
> script.  "Rich" implementation may use whatever database, and/or relay
> requests to other programs over D-BUS, or CORBA, or anything...)

How are you going to setup access permissions for the services with
your binary helpers? That's easy using sockets.

Fredrik
