Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20040309161702.24407.qmail@web40713.mail.yahoo.com>
From: Lalith Chakravarthi <lalithvc@yahoo.com>
Subject: Re: [Bluez-users] timeout after rfcomm or pan connection
To: Christoph Torens <c.torens@web.de>
Cc: bluez-users <bluez-users@lists.sourceforge.net>
In-Reply-To: <opr4lpzclieocfdv@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Date: Tue, 9 Mar 2004 08:17:02 -0800 (PST)

Hi Christopher

I have worked on the 2.4.20-8 kernel ... if it helps, go on with
reading this...

first check if all the modules are there (I know this is the basic
stuff but most errors creep up from here)

motospin> lsmod

and you should see bluez, usb-uhci, hci_usb, rfcomm, l2cap and bnep
modules there (doesnt hurt to have extra modules!!)

make sure you have connected both the dongles and that they are 
up and running.

then, get the daemons running
motospin> hcid
motospin> sdpd

motospin2> hcid
motospin2> sdpd

then on the server side run the pand

motospin> pand --listen --role GN

and on the client side

motospin2> pand --connect --search 20 (20 is the time out value)

and then do the ifconfig bnep0 on both the sides..

motospin> ifconfig bnep0 10.0.0.1

motospin2> ifconfig bnep 10.0.0.2

I was able to establish a connection between a laptop with a USB dongle
and a PC with a USB dongle... both on the 2.4.20-8 kernel. I set up the
PS as the gateway and connectd to the net from the laptop also!!!

Hopefully you can also do the same...

regards
lalith



__________________________________
Do you Yahoo!?
Yahoo! Finance: Get your refund fast by filing online.
http://taxes.yahoo.com/filing.html


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
