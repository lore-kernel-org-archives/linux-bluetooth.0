Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Andrew de Quincey <adq_dvb@lidskialf.net>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200411241854.13007.adq_dvb@lidskialf.net>
Subject: [Bluez-users] rfcomm problems
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 24 Nov 2004 18:54:12 +0000

Hi, I'm using linux kernel 2.6.9, gentoo, bluez-utils/libs 2.10.
I have a Nokia 3650, with firmware 3.16.

I've initially been just trying to connect to the phone using rfcomm...

rfcomm connect 0 MACADDR 1

this works - I get the "Press Ctrl-C to hangup" and /dev/rfcomm0 appears 
(using udev BTW).

I then try to use minicom on /dev/rfcomm0. It opens it OK, but nothing 
happens... I mean, I send AT commands at it, but I get no response. Do I have 
to use a certain set of serial port settings (I've tried quite a few)?

I also tried running hcidump whilst typing stuff in minicom - nothing was 
logged.

What am I missing?


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
