Return-Path: <noring@nocrew.org>
Subject: Re: [gnome-bluetooth] Re: [Bluez-devel] What stuff in
	gnome-bluetooth does, and ideas for its future
From: Fredrik Noring <noring@nocrew.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Fred =?ISO-8859-1?Q?Sch=E4ttgen?= <bluez-devel@schaettgen.de>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1075487167.26729.191.camel@pegasus>
References: <1064593223.12843.127.camel@saag>
	 <200401291230.00801.bluez-devel@schaettgen.de>
	 <1075401893.22564.51.camel@akka.yeti.nocrew.org>
	 <200401292119.45926.bluez-devel@schaettgen.de>
	 <1075486241.14644.34.camel@akka.yeti.nocrew.org>
	 <1075487167.26729.191.camel@pegasus>
Content-Type: text/plain
Message-Id: <1075494959.14644.53.camel@akka.yeti.nocrew.org>
Mime-Version: 1.0
Date: Fri, 30 Jan 2004 21:35:59 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel,

fre 2004-01-30 klockan 19.26 skrev Marcel Holtmann:
> the best place for Unix sockets is /tmp

Agreed. Perhaps we can have a directory structure similar to this:

   /tmp/hcid/keytab.socket
   /tmp/hcid/nametab.socket
   ...

and so on for each kind of service. This will allow flexible user
access permissions.

> If we do it, this should be part of the Bluetooth library itself, so
> programmers don't have to worry about it.

Good idea.

Fredrik
