Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Theo Beisch <theo.beisch@gmx.de>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Message-Id: <200310062337.37090.root <>>
Reply-To: theo.beisch@gmx.de
Content-Type: text/plain;
  charset="iso-8859-1"
Subject: [Bluez-users] help for bluez and bridge configuration needed
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 6 Oct 2003 23:37:57 +0200

I am new to Linux and Bluez so maybe someone could give me a hand here? Thanx 
ahead!

I am using a 2.4.2 kernel (SuSE 8.2) and the bridge within it to tie a 
bluetooth PAN and my Laptop together under one IP address which must come 
from a DHCP server as I am using the constellation in various networks.

The bridge is activated like this:
brctl addbr pan0
brctl addif pan0 eth0
brctl setfd pan0 0
brctl stp pan0 disable
(got those settings from a bluetooth howto, activated by a init.d/rc5 script - 
works fine)

ifconfig eth0 0.0.0.0 then disables the IP on my lan card for the bridge to 
work, set by the ifcfg-eth0 init.d file. 

the ifctrl-pan0 calls the DHCP server for an IP adress and this is assigned - 
works well.

brctl addif pan0 bnep0   gets called from the bluetooth startup (hotplug)

With the bluetooth pan added to the bridge heres the trouble I have:

While before pings to the local machine work ok and I get constant periodic 
reponses, after the bnep0 interface becomes part of the bridge, ping stops 
about every 5 instances, no longer displays the ping'd machine's name and 
goes down with response frequency (from normally one a second to one response 
every 10 or so seconds). While the response frequency remains low, after 8-10 
no-name resolution pings, the machine name comes back with each ping. and so 
on....

Pings directly to the IP address continue to work fine, also pings from 
another machine in the network to both my local linux laptop and the 
bluetooth attached PDA. Also DHCP is working fine for the PDA.

Any ideas? Thanks ahead for your help!

Theo
-- 
Theo Beisch
106 Ronheider Weg
Aachen, Germany 52066
Tel +49 (241) 13935 & +49 (9401) 6000283
Mobil +49 (172) 2102211
theo.beisch@gmx.de


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
