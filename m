Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <32949.200.209.60.3.1110447598.squirrel@webmail.indt.org>
From: takahasi@indt.org
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Subject: [Bluez-devel] PAN Setup question
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 10 Mar 2005 06:39:58 -0300 (BRT)

I am a beginner on BlueZ stack. I am trying to create an ad hoc group
network composed by ONE GN and TWO PANU.

     GN_PC (master) -  hci.conf (lm accept,master;)
     PANU01_PC(slave) -  hci.conf (lm accept;)
     PANU02_PC(slave) -  hci.conf(lm accept;)
     commands sequence:
        1. gn_pc$ pand --listen --role GN
        2. panu01_pc$ pand --connect 00:20:E0:**:**:74
        3. panu02_pc$ pand --connect 00:20:E0:**:**:74
        4. gc_pc$ ifconfig bnep0 10.0.0.1 netmask 255.255.255.0
        5. panu01_pc$ ifconfig bnep0 10.0.0.2 netmask 255.255.255.0
        6. panu02_pc$ ifconfig bnep0 10.0.0.3 netmask 255.255.255.0

      gn_pc connections:
        > ACL 00:20:E0:**:**:92 handle 45 state 1 lm SLAVE
        > ACL 00:20:E0:**:**:89 handle 41 state 1 lm SLAVE

     gc_pc dump:
       osmtc11:/usr/src/bluez/bluez-utils-2.15/pand# pand --listen --role
GN --nodetach
       pand[7301]: Bluetooth PAN daemon
       pand[7303]: New connection from 00:20:E0:**:**:89 bnep0
       pand[7329]: New connection from 00:20:E0:**:**:92 bnep1



   I CAN'T REACH PANU02_PC!!!
   l2ping is working among the devices! However at network layer, the GN
is not foward IP packages and i am not able to ping.
   Ping 10.0.0.1 from panu01_pc is working.
   Ping 10.0.0.1 from panu02_pc is NOT WORKING

   How can I add the both panus in the same network?
   According with gc_pc dump, bnep0 and bnep1 are created.
   How can I add panu02_pc to bnep0?

   Thanks,
    Claudio.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
