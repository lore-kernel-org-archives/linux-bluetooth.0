Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <002b01c43680$a4ba19b0$0500a8c0@pii350>
From: "Marc Fouquet" <marc.fouquet@gmx.de>
To: <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: [Bluez-users] BlueZ Timing Resolution
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
Date: Mon, 10 May 2004 12:18:59 +0100

Hello!

I am trying to do "Packet Pair" measurements with Bluetooth for an University
Project. This means that I am sending two IP packets as quickly as possible at
the sender and measure the difference between the arrival times of the packets at
the receiver (with tcpdump for example).

This inter-arrival time between two IP packets always appears to be a multiple of
1 ms when using BlueZ, for example:
0.026006 s between packet 0 and 1
0.041003 s between packet 2 and 3
0.025990 s between packet 4 and 5
0.029987 s between packet 6 and 7
0.029997 s between packet 8 and 8
0.030001 s between packet 10 and 11

With other networks - for example ethernet - I can measure inter-arrival times
that are much shorter than 1 ms.

I would need to know the exact reason for the limited timing resolution with
Bluetooth. Does the BT hardware give packets to my Computer only once a ms? Or
does the BlueZ module only give the packets to the kernel once a ms? Why 1 ms and
not a multiple of the BT slot time of 625 microseconds?

I am using
Fedora Core 1 with Kernel 2.4.22,
bluez-libs 2.5, bluez-utils 2.4 (the lastest versions that were available as
rpms),
a bnep (pand) connection,
2 MSI Bluetooth USB Sticks.

Thanks and greetings from Germany
  Marc Fouquet






-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
