Return-Path: <crosser@average.org>
Subject: Re: [gnome-bluetooth] Re: [Bluez-devel] What stuff in
	gnome-bluetooth does, and ideas for its future
From: Eugene Crosser <crosser@average.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Fredrik Noring <noring@nocrew.org>,
   Fred =?ISO-8859-1?Q?Sch=E4ttgen?= <bluez-devel@schaettgen.de>,
   GNOME Bluetooth Mailing List <gnome-bluetooth@usefulinc.com>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1075487167.26729.191.camel@pegasus>
References: <1064593223.12843.127.camel@saag>
	 <200401291230.00801.bluez-devel@schaettgen.de>
	 <1075401893.22564.51.camel@akka.yeti.nocrew.org>
	 <200401292119.45926.bluez-devel@schaettgen.de>
	 <1075486241.14644.34.camel@akka.yeti.nocrew.org>
	 <1075487167.26729.191.camel@pegasus>
Content-Type: text/plain
Message-Id: <1075488593.21795.37.camel@ariel.sovam.com>
Mime-Version: 1.0
Date: Fri, 30 Jan 2004 21:49:53 +0300
List-ID: <bluez-devel.lists.sourceforge.net>

On Fri, 2004-01-30 at 21:26, Marcel Holtmann wrote:

> the best place for Unix sockets is /tmp

Or /var/<something>, and not only sockets, but other variable data as
well.  /etc may be on a read-only filesystem.  Imagine a bluetooth
gadget based on Linux burnt in ROM.

(I continue to think that binary helper is a viable option for the low
level interface.  It is very scalable: "lean" implementation for very
simple environments may be cut down to just a few lines of shell
script.  "Rich" implementation may use whatever database, and/or relay
requests to other programs over D-BUS, or CORBA, or anything...)

Eugene
