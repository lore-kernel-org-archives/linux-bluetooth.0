Return-Path: <gnome-bluetooth-bounces@usefulinc.com>
From: Marcel Holtmann <marcel@holtmann.org>
To: Eugene Crosser <crosser@average.org>
In-Reply-To: <1075488593.21795.37.camel@ariel.sovam.com>
References: <1064593223.12843.127.camel@saag>
	<200401291230.00801.bluez-devel@schaettgen.de>
	<1075401893.22564.51.camel@akka.yeti.nocrew.org>
	<200401292119.45926.bluez-devel@schaettgen.de>
	<1075486241.14644.34.camel@akka.yeti.nocrew.org>
	<1075487167.26729.191.camel@pegasus>
	<1075488593.21795.37.camel@ariel.sovam.com>
Message-Id: <1075489580.26729.208.camel@pegasus>
Mime-Version: 1.0
Date: Fri, 30 Jan 2004 20:06:21 +0100
Subject: Re: [gnome-bluetooth] Re: [Bluez-devel] What stuff in
	gnome-bluetooth does, and ideas for its future
Content-Type: text/plain
Cc: Fred =?ISO-8859-1?Q?Sch=E4ttgen?= <bluez-devel@schaettgen.de>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
   GNOME Bluetooth Mailing List <gnome-bluetooth@usefulinc.com>
List-Unsubscribe: <http://lists.usefulinc.com/mailman/listinfo/gnome-bluetooth>,
	<mailto:gnome-bluetooth-request@usefulinc.com?subject=unsubscribe>
List-Archive: <http://lists.usefulinc.com/pipermail/gnome-bluetooth>
List-Post: <mailto:gnome-bluetooth@usefulinc.com>
List-Help: <mailto:gnome-bluetooth-request@usefulinc.com?subject=help>
List-Subscribe: <http://lists.usefulinc.com/mailman/listinfo/gnome-bluetooth>,
	<mailto:gnome-bluetooth-request@usefulinc.com?subject=subscribe>
Sender: gnome-bluetooth-bounces@usefulinc.com
Errors-To: gnome-bluetooth-bounces@usefulinc.com
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Eugene,

> > the best place for Unix sockets is /tmp
> 
> Or /var/<something>, and not only sockets, but other variable data as
> well.  /etc may be on a read-only filesystem.  Imagine a bluetooth
> gadget based on Linux burnt in ROM.

No. The /tmp directory will be cleared on every boot and the Unix socket
must not survive reboots. We can use /var/bluetooth for our databases.

> (I continue to think that binary helper is a viable option for the low
> level interface.  It is very scalable: "lean" implementation for very
> simple environments may be cut down to just a few lines of shell
> script.  "Rich" implementation may use whatever database, and/or relay
> requests to other programs over D-BUS, or CORBA, or anything...)

Calling an extra program for every transaction "costs" too much and it
raises too many security issues. If you talk about the PIN helper I
think we would have in future per BD_ADDR stored PIN's, D-BUS and
calling a helper script.

Regards

Marcel



_______________________________________________
gnome-bluetooth mailing list
gnome-bluetooth@usefulinc.com
http://lists.usefulinc.com/mailman/listinfo/gnome-bluetooth
