Return-Path: <bluez-devel-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Message-ID: <A1F0D47583A2D711919F00600819B3A45BDAA3@goofy.vitronics.com>
From: "Williams, Richard" <Richard.Williams@VITRONICS.com>
To: "BlueZ Mailing List" <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] Handling multiple rfcomm connections
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 30 Jan 2004 14:14:02 -0500

Hi all,

We have a small single board computer (SBC) that will act as a personal
network server. This SBC has WiFi to get out to the network and
Bluetooth to connect to various Bluetooth equipped peripheral=20
devices. Some of the peripheral devices are sensors - they only send=20
data to the SBC. Other peripherals both send and receive data. The
applications send small amounts of data through rfcomm connections.
Occasionally, there are also non-rfcomm connections - OBEX and SCO=20
are being done simultaneously with the rfcomms.

Now we're writing the software for the SBC, and we have multiple BT=20
connections to manage. We've thought about a BT daemon that will manage=20
the BT radio and the various rfcomm connections, providing a standard
socket interface from the BT stack toward the rest of the applications.
We want to completely isolate the BT hardware from the applications, so=20
the applications designer only needs to know about socket connections =
and
need not be concerned with BT.

Has anyone done this type of thing?

What do you think of the idea?

If this hasn't been done, please, I welcome your suggestions.

thanks,

Rich


Richard B. Williams
Vitronics, Inc.
3 Corbett Way
Eatontown, NJ 07724-2262
732-389-0244 x29
Richard.Williams@vitronics.com


-----Original Message-----
From: Marcel Holtmann [mailto:marcel@holtmann.org]
Sent: Friday, January 30, 2004 1:19 PM
To: Fredrik Noring
Cc: Edd Dumbill; GNOME Bluetooth Mailing List; BlueZ Mailing List
Subject: [Bluez-devel] Re: [gnome-bluetooth] What stuff in
gnome-bluetooth does, and ideas for its future


Hi Fredrik,

> Make hcid create a socket in /etc/bluetooth/keytab.socket. Preferably,
> having the same group membership as the socket (for examle =
"bluetooth")
> enables a user to send commands like:
>=20
>     DELETE <sba> <dba>
>=20
> This makes hcid delete the link and update /etc/bluetooth/keytab and
> /etc/bluetooth/keytab.shadow accordingly. These are ASCII files of
> course and can also be maintained with Emacs or whatever tool although
> this is not as safe because of race conditions.
>=20
> Then we'll extend hcitool with the ability to connect to this socket
> and do this stuff too.
>=20
> The protocol can be extended in the future. Like for example =
initiating
> pairing procedures and so on.

I had some similar ideas some time ago and the idea of accessing the
Bluetooth databases through a Unix socket with our own protocol is one
of my favourites. This makes you independent from the database format (I
prefer Berkeley DB at the moment) and you don't need to have database
code in the Bluetooth library. But when we design it this way, we must
make sure that we have the highest security for the link key
transactions.

Additional commands can be NAME or ISPAIRED, but I am also not sure if a
binary protocol would be better. Maybe we can use D-BUS for it.

Some other comments from me. I am not going to include such big changes
into hcid. This is development work for the new security manager or call
it device manager which is going to replace hcid.

Fredrik, would you please start a new post on the bluez-devel mailing
list, so we have a new thread for it. This is not really GNOME related
and I am not a big friend of cross-posting.

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
