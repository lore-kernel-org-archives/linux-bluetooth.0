Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Anssi Saari <as@sci.fi>
To: bluez-users@lists.sourceforge.net
Message-ID: <20040306085928.GA7480@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] PAN almost working, but not quite...
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
Date: Sat, 6 Mar 2004 10:59:28 +0200


Hello,

I'm trying to get my Windows XP laptop to talk to my Linux PC and it's
almost working. I'm running pand --listen --role NAP on Linux, Windows thinks
it's connected and has an IP address 172.16.0.3 and on Linux I get a
log message saying "pand[23934]: New connection from 00:05:16:58:73:30
bnep0". Bnep0 comes up and has an IP address:

bnep0     Link encap:Ethernet  HWaddr 00:04:76:C8:43:EC  
          inet addr:172.16.0.1  Bcast:172.16.255.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:4 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:16 (16.0 b)  TX bytes:100 (100.0 b)
 
I even see the UDP noise Windows likes to make in my firewall log:

Mar 6 10:21:23 REJECT UDP SRC=172.16.0.3:137 DST=172.16.255.255:137
Mar 6 10:22:32 REJECT UDP SRC=172.16.0.3:138 DST=172.16.255.255:138
Mar 6 10:27:06 REJECT UDP SRC=172.16.0.3:138 DST=172.16.255.255:138
Mar 6 10:34:15 REJECT UDP SRC=172.16.0.3:137 DST=172.16.255.255:137
Mar 6 10:34:16 REJECT UDP SRC=172.16.0.3:137 DST=172.16.255.255:137
Mar 6 10:34:17 REJECT UDP SRC=172.16.0.3:137 DST=172.16.255.255:137
Mar 6 10:34:33 REJECT UDP SRC=172.16.0.3:138 DST=172.16.255.255:138

But I can't ping or use any other TCP program in either direction.
Even with the firewall disabled. It's just destination unreachable in
both ends. 

Any hints? Or does anyone know of a live Linux CD that includes Bluez? I
have both Knoppix 3.3 and Morphix 0.41 around, but neither seems to have
the userland parts included, although there is driver support available.



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
