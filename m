Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Errors when trying to connect Palm and Linux
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200412121708.iBCH8MCc019533@dja-it.de>
References: <200412121708.iBCH8MCc019533@dja-it.de>
Content-Type: text/plain
Message-Id: <1102871833.8750.77.camel@pegasus>
Mime-Version: 1.0
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
Date: Sun, 12 Dec 2004 18:17:12 +0100

Hi Dirk,

> I newly got a Palm Tungsten T3 with bluetooth and an Acer BT USB dongle for my
> linux pc running SuSE 8.2. I know this is quite an old version but i have my
> reasons...
> 
> I installed the latest versions of BlueZ, sdpd, hcid and rfcommd and so on, i
> think, and configured all well, IMHO. I can see the pc from the Palm and can
> connect it as authorized and i can see it when doing a search for an computer
> in the network setup of the Palm. But when i try to really connect to the pc,
> i only get a timeout after a while. In /var/log/messages on the Linux pc i get
> the messages 
> "Dec 12 17:48:38 linux hcid[18739]: HCI daemon ver 2.2 started
> Dec 12 17:48:38 linux hcid[18739]: Starting security manager 0
> Dec 12 17:48:38 linux sdpd[18744]: SDPd ver 1.0 started
> Dec 12 17:48:38 linux rfcommd[18747]: RFCOMMd server ver 1.2
> Dec 12 17:48:48 linux rfcommd[18748]: Connection from 00:07:E0:3B:51:98
> Dec 12 17:48:48 linux rfcommd[18748]: Session na[00:07:E0:3B:51:98] opened
> Dec 12 17:48:48 linux pppd[18750]: pppd 2.4.1 started by root, uid 0
> Dec 12 17:48:48 linux pppd[18750]: Using interface ppp2
> Dec 12 17:48:48 linux pppd[18750]: not replacing default route to ppp0
> [217.5.98.53]
> Dec 12 17:48:48 linux pppd[18750]: local  IP address 192.168.30.20
> Dec 12 17:48:48 linux pppd[18750]: remote IP address 192.168.30.205
> Dec 12 17:49:20 linux rfcommd[18748]: select() failed: Bad file descriptor
> (9)",
> i think there i will have to look for the error but i get no further
> information on the web.

we don't use rfcommd anymore and these are not the latest versions. You
should better update to SuSE 9.2. If this is not possible remove every
bluez packages and install the newer onces from the source. You must
also update your kernel with at least a -mh patch.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
