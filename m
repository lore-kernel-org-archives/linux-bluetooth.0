Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <004b01c41268$7e8ee810$4000fe0a@rtsviec64>
From: "Harald Meier" <meh1@rts.at>
To: <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: [Bluez-users] PAND and RFCOMM simultaneously
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 25 Mar 2004 13:55:43 +0100

Dear list members!

I have a NAP/PANU network with pand running and I need to
set up some (up to 4) rfcomm connection additionally.

Setting up the rfcomm devices when the pand is down works fine
but if pand is up, I get a "Function not implemented" when I try
to bring up a rfcomm connection.

If the rfcomm connection is up and I try to connect to the NAP
via pand, I get the "Function not implemented" from pand.

What I am using:

    Debian (not shure what version, was not installed by me)
    kernel 2.4.18-mh10
    bluez-pan-1.1
    bluez-utils-2.4
    bluez-libs-2.5

    Pico Bluetooth PCI Card (Class 1)


any help appreciated,
Harald.


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
