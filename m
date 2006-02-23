Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] ISSC USB dongle can't ping with size 1000
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1140692268.24721.22.camel@localhost>
References: <E64BAD5A8AD46740828069A678D9DD73011B03@netbe01.net.unimis>
	 <1140692268.24721.22.camel@localhost>
Content-Type: text/plain
Message-Id: <1140693818.24721.29.camel@localhost>
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
Date: Thu, 23 Feb 2006 12:23:38 +0100

Hi Al,

> >     I have the same problem as below which was posted last month.
> > 
> > >   I started to play with the ping size. 'ping -s 900' works, 'ping -s 1000'
> > > kills the PAN connection. There was hope! Then I played with MTU (on both
> > > sides): 'ifconfig bnep0 mtu 1000' solves all my problems (default is
> > > 1500)!!! With this setting I've a rock solid 75 kByte/s transfer rate over
> > > ftp. A mtu of 1017 still works, 1018 definitely kills the connection. 
> > 
> >      I wonder if there is other solutions to this problem cause the above solution needs to set MTU to 1000 on both sides. 
> > 
> >      I try ISSC dongle with IVT software as NAP on Windows XP. Ping with size
> > 1500 works fine. It seems ISSC chip has some problems to work with BlueZ, in
> > addition to adding HCI_RESET.
> 
> I am pretty sure that your chip is at fault here. I have no internals
> about your chip, but whatever buffer size you tell us, we will use. And
> BlueZ will use it as fast as possible. The latency is very low and the
> HCI flow control works fine. So I assume there exists a race condition
> in your side of the HCI flow control implementation which triggers a
> problem. You can verify with hcidump that we do everything right. The
> faulty application is actually not BNEP here. I think you can reproduce
> it with any program sending big L2CAP packets. So a test setup with
> l2test and different MTU might trigger it more easily.

and I just did a quick search through the mailing list archive and
actually I found these four version:

ACL MTU: 678:12  SCO MTU: 48:5   LMP Ver: 1.1  LMP Subver: 0x172
ACL MTU: 678:8   SCO MTU: 48:5   LMP Ver: 1.1  LMP Subver: 0x1a4
ACL MTU: 678:8   SCO MTU: 48:10  LMP Ver: 1.2  LMP Subver: 0x1ae
ACL MTU: 678:8   SCO MTU: 48:10  LMP Ver: 1.2  LMP Subver: 0x1f4

The LMP Subver must somehow decode into the version number of your
firmware, but I have no idea how. However you see the different ACL MTU
sizes the chip offers and BlueZ is simply using them.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
