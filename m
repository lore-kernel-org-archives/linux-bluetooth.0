Return-Path: <gnome-bluetooth-bounces@usefulinc.com>
From: Marcel Holtmann <marcel@holtmann.org>
To: Fredrik Noring <noring@nocrew.org>
In-Reply-To: <1075486241.14644.34.camel@akka.yeti.nocrew.org>
References: <1064593223.12843.127.camel@saag>
	<200401291230.00801.bluez-devel@schaettgen.de>
	<1075401893.22564.51.camel@akka.yeti.nocrew.org>
	<200401292119.45926.bluez-devel@schaettgen.de>
	<1075486241.14644.34.camel@akka.yeti.nocrew.org>
Message-Id: <1075487167.26729.191.camel@pegasus>
Mime-Version: 1.0
Date: Fri, 30 Jan 2004 19:26:07 +0100
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

Hi Fredrik,

> Similar to the idea with /etc/bluetooth/keytab.socket, additional
> sockets can be created for other Bluetooth interface services such
> as name scans, lookups etc. Regular users have access to these
> capabilities based on socket file permissions.

the best place for Unix sockets is /tmp

> Example:
> 
>    /etc/bluetooth/names          # The device name cache
>    /etc/bluetooth/names.conf     # The device name configuration file
>    /etc/bluetooth/names.socket   # The command socket
> 
> Command examples:
> 
>    SCAN            - Returns something similar to "hcitool scan"
>    LOOKUP <bdaddr> - Returns the name if available in the names file
>    DELETE <bdaddr> - Removes the name from the names file
>    LIST            - Lists all names in the names file
> 
> The hcitool utility can be extended with these features too.

If we do it, this should be part of the Bluetooth library itself, so
programmers don't have to worry about it.

Regards

Marcel



_______________________________________________
gnome-bluetooth mailing list
gnome-bluetooth@usefulinc.com
http://lists.usefulinc.com/mailman/listinfo/gnome-bluetooth
