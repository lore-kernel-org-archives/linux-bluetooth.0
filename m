Return-Path: <gnome-bluetooth-bounces@usefulinc.com>
From: Fredrik Noring <noring@nocrew.org>
To: Fred =?ISO-8859-1?Q?Sch=E4ttgen?= <bluez-devel@schaettgen.de>
In-Reply-To: <200401292119.45926.bluez-devel@schaettgen.de>
References: <1064593223.12843.127.camel@saag>
	<200401291230.00801.bluez-devel@schaettgen.de>
	<1075401893.22564.51.camel@akka.yeti.nocrew.org>
	<200401292119.45926.bluez-devel@schaettgen.de>
Message-Id: <1075486241.14644.34.camel@akka.yeti.nocrew.org>
Mime-Version: 1.0
Date: Fri, 30 Jan 2004 19:10:42 +0100
Content-Type: text/plain; charset=ISO-8859-1
Cc: GNOME Bluetooth Mailing List <gnome-bluetooth@usefulinc.com>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: [gnome-bluetooth] Re: [Bluez-devel] What stuff in gnome-bluetooth
	does, and ideas for its future
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

tor 2004-01-29 klockan 21.19 skrev Fred Sch=E4ttgen:
> I also think that wouldn't be misplaced in bluez. But since it can be e=
asily=20
> done with a gnome/kde service, this proposal will surely go to the bott=
om=20
> part of the wishlist if there is no demand from other unrelated project=
s.=20

Here's a proposal:

Similar to the idea with /etc/bluetooth/keytab.socket, additional
sockets can be created for other Bluetooth interface services such
as name scans, lookups etc. Regular users have access to these
capabilities based on socket file permissions.

Example:

   /etc/bluetooth/names          # The device name cache
   /etc/bluetooth/names.conf     # The device name configuration file
   /etc/bluetooth/names.socket   # The command socket

Command examples:

   SCAN            - Returns something similar to "hcitool scan"
   LOOKUP <bdaddr> - Returns the name if available in the names file
   DELETE <bdaddr> - Removes the name from the names file
   LIST            - Lists all names in the names file

The hcitool utility can be extended with these features too.

Would this make it?

Fredrik



_______________________________________________
gnome-bluetooth mailing list
gnome-bluetooth@usefulinc.com
http://lists.usefulinc.com/mailman/listinfo/gnome-bluetooth
