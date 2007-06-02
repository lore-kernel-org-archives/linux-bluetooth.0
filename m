Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Sat, 2 Jun 2007 18:40:43 +0200
From: Aldo Maggi <turms@ciaoweb.it>
To: bluez-users@lists.sourceforge.net
Message-ID: <20070602184043.594698c5@topolino>
Mime-Version: 1.0
Subject: [Bluez-users] problems with network via bluetooth
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

my home lan is made up with three desktops.
one of them (GW) has 3 eth cards the first one links to the router
the other 2 connect PC1 and PC2 to GW.
PC1 has 2 eth cards, the first one links it to GW and i use the second
to connect, from time to time, my notebook (NB) to the lan.

recently i have bought 2 bluetooth/usb adapters because i wished to
create a bluetooth net between PC1 and NB

in PC1 i have Ubuntu Gutsy (but i have the problem i'm going to tell
also with Debian Lenny which is installed in PC1 as well) and in the
NB i have Debian Lenny.

the two bluetooth systems see each other:

if i run in the NB:  hcitool scan
correctly get:
11:11:11:11:11:11   paperino-0
 
the same in PC1:
00:15:83:B3:D3:9A    paperinik-0

in PC1 in the /etc/bluetooth/hcid.conf i have the line:
lm accept,master;

in NB in the same file:
lm accept;

in PC1 i run:
pand  --listen --role NAP

in NB i run:
pand --role PANU --persist --search

and i can read in the relevant /var/log/daemon.log the following:
in PC1 - pand: new Connection from 00:15:83:B3:D3:9A bnep0
in NB - pand: Connecting to 11:11:11:11:11:11
        pand: bnep0 Connected

then i run
in PC1: ifconfig bnep0 192.168.6.1 netmask 255.255.255.0
in  NB: ifconfig bnep0 192.168.6.2 netmask 255.255.255.0

and i can read in the relevant /var/log/daemon.log the following:
in PC1
Jun  2 18:15:59 paperino avahi-daemon[4819]: Joining mDNS multicast
group on interface bnep0.IPv4 with address 192.168.6.1. 
Jun  2 18:15:59
paperino avahi-daemon[4819]: New relevant interface bnep0.IPv4 for
mDNS. 
Jun  2 18:15:59 paperino avahi-daemon[4819]: Registering new
address record for 192.168.6.1 on bnep0.IPv4. 
Jun  2 18:16:00 paperino
avahi-daemon[4819]: Registering new address record for
fe80::1311:11ff:fe11:1111 on bnep0.*. 
Jun  2 18:19:53 paperino
ntpd[4885]: Listening on interface #7 bnep0,
fe80::1311:11ff:fe11:1111#123 Enabled 
Jun  2 18:19:53 paperino
ntpd[4885]: Listening on interface #8 bnep0, 192.168.6.1#123 Enabled

and in NB
Jun  2 18:17:07 paperinik avahi-daemon[2750]: New relevant interface bnep0.IPv4 for mDNS.
Jun  2 18:17:07 paperinik avahi-daemon[2750]: Joining mDNS multicast group on interface bnep0.IPv4 with address 192.168.6.2.
Jun  2 18:17:07 paperinik avahi-daemon[2750]: Registering new address record for 192.168.6.2 on bnep0.

the 192.168.6.0 net on bnep0 is correctly shown by netstat -nr in both
PC1 and NB

but if i do ping from one machine the ip of the other i get Destination
Host Unreachable 

where do you think i'm wrong?
thanks

 

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
