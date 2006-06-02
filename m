Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <loom.20060602T160736-77@post.gmane.org>
References: <loom.20060602T160736-77@post.gmane.org>
Date: Fri, 02 Jun 2006 17:07:42 +0200
Message-Id: <1149260862.23555.5.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] PAN over bluetooth - no TCP/IP activity
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

Hi Stefan,

> I'm trying to create a PAN between a laptop and a desktop computer. 
> 
> I carefully followed the instructions for creating a PAN network
> (http://bluez.sourceforge.net/contrib/HOWTO-PAN).
> 
> Right now I am able to connect, ending up with correct and configured "bnep0"
> interfaces on both computers.
> 
> The problem is, that I can not even ping them. After a lot of tries, I figured
> out, that if I put the bnep0 interface in promiscuous mode, using 
> 
> ifconfig bnep0 promisc (at the NAP side)
> 
> then ICMP packets starts flowing, and the both nodes are able to ping each
> other. But that's all. 
> 
> On both nodes hcid & sdpd are running, bnep module is loaded, kernel version is
> 2.6.16 (Fedora Core 4), bluez-utils 2.15
> 
> Here is what I do:
> 
> @NAP: # pand -s -r NAP
> @PANU: # pand -Q -r PANU -d NAP
> @Both (after a while): # ifconfig bnep0 10.0.0.x netmask 255.255.255.0 up
> @both: # ifconfig bnep0
> bnep0     Link encap:Ethernet  HWaddr 11:11:11:11:11:11
>           inet addr:10.0.0.x  Bcast:10.0.0.255  Mask:255.255.255.0
>           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>           RX packets:6 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:4 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:1000
>           RX bytes:478 (478.0 b)  TX bytes:64 (64.0 b)

one of these ISSC chips again. The MAC address is bogus and as far as I
recall not valid for Ethernet. However I have no idea how to set a new
address with these chips. Try to get yourself a recent CSR based dongle.

Regards

Marcel




_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
