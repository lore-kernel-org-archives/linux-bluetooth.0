Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <409B756D.6000705@telefonica.net>
From: Jose Angel Rodriguez <jrodriguezv@telefonica.net>
MIME-Version: 1.0
To: bluez-users@lists.sf.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] NAP problem
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
Date: Fri, 07 May 2004 13:39:25 +0200

Hi all!!

I hava a Debian Sarge PC as a NAP for a bluetooth network. The computer 
is also connected to an ADSL.

This is my etc/network/interfaces file:
# /etc/network/interfaces -- configuration file for ifup(8), ifdown(8)

# The loopback interface
auto lo
iface lo inet loopback

# The first network card - this entry was created during the Debian 
installation# (network, broadcast and gateway are optional)
auto eth0
iface eth0 inet static
       address 192.168.0.2
       netmask 255.255.255.0
       network 192.168.0.0
       broadcast 192.168.0.255
       gateway 192.168.0.1

# bluetooth network server
iface bnep0 inet static
       address 10.0.0.1
       netmask 255.255.255.0

eth0 is the ADSL connection an bnep0 is the bluetooth connection.

My /etc/bluetooth/pan/dev-up file:
#!/bin/sh
ifup bnep0

I think everytime a client connects it runs /etc/bluetooth/pan/dev-up. 
Everything was working fine, but after updating packages with apt-get 
everytime a client connects I have to configure bnep0 interface by hand 
(ifup bnep0).

¿Does anybody know why /etc/bluetooth/pan/dev-up does not work now? ¿How 
can I configure bnep0 interface automaticaly?

Thanks in advance!!

JOSE


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
