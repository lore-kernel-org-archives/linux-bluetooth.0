Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Sat, 24 Mar 2007 13:57:04 +0100
From: Benjamin Hase <benjamin.hase@web.de>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <45EF24B7.70908@thebmwz3.co.uk>
References: <45EF24B7.70908@thebmwz3.co.uk>
Mime-Version: 1.0
Message-Id: <20070324125513.CBCC84546C1@can03.de>
Subject: Re: [Bluez-users] pand, bnep0 and no traffic flow
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Am Wed, 07 Mar 2007 20:46:47 +0000
schrieb Andy <andy@thebmwz3.co.uk>:

Hi Andy,

> I'm trying to figure out where things are going wrong with my connection 
> here.
> Server A has /usr/bin/pand --listen -M --role=NAP
> Server B has pand --connect 00:02:72:B2:EF:21
> 
> The two initiate the connection, and create the bnep0 interface. I set 
> the IP addresses
> ifconfig bnep0 10.0.0.1 netmask 255.255.255.0
> ifconfig bnep0 10.0.0.2 netmask 255.255.255.0
> respectively, and neither can ping each other.
> 

I had a similar setup and the same problem. pand -l shows a connection,
l2ping is okay, but not an ICMP-ping.
The solution for me was to use another Bluetooth-dongle. The new one is
with a Bluecore 4 chipset, no problems. I tried the same setup with the
other dongle: Same problem as before -- it looks like a problem with the
hardware.

HTH
Benjamin

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
