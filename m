Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] PAN with ISSC USB-dongle and MTU
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <010201c62197$be32dae0$14141bac@mgpi.de>
References: <010201c62197$be32dae0$14141bac@mgpi.de>
Content-Type: text/plain
Message-Id: <1138184460.5782.31.camel@localhost>
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
Date: Wed, 25 Jan 2006 11:21:00 +0100

Hi Bernhard,

> I recently bought 2 mini class-1 bluetooth dongles, and they turned out to
> use the ISSC chip.
> 
> It was no problem to establish connections with a GPS mouse (rfcomm) and a
> Palm T5 (ppp).

the default L2CAP MTU for RFCOMM connections is 1024 from our side and
most devices cut them down actually. For BNEP we actually try to get a
L2CAP MTU of 1691 for best performance.

> But I had big problems with PAN between a desktop and my venerable compaq
> armada notebook. I could establish a connection, ping worked. But each time
> I tried to transfer some real payload the connection died, and with it some
> parts of the bluetooth stack. To restablish the connection most of the time
> it's necessary to restart all bluetooth daemons, sometimes even the dongles
> must be re-plugged.
> 
> I started to play with the ping size. 'ping -s 900' works, 'ping -s 1000'
> kills the PAN connection. There was hope! Then I played with MTU (on both
> sides): 'ifconfig bnep0 mtu 1000' solves all my problems (default is
> 1500)!!! With this setting I've a rock solid 75 kByte/s transfer rate over
> ftp. A mtu of 1017 still works, 1018 definitely kills the connection. Then
> the syslog is flooded with:
> > hci_acldata_packet: hci0 ACL packet for unknown connection handle 0
> and some stray
> > hci_usb_rx_complete: hci0 corrupted packet: type 2 count 423
> 
> Small oversteps of MTU 1017 are recoverable, but a MTU 1500 kills my
> daemons.

I still hate these chips, because it seems that they are not really
capable of handling big data flows. Even if they are supposed to be and
this should have been verified in the qualification testing. I need to
find the exact chip you have and then do my own testing, but in general
it seems we have no other choice except including some tweaks into the
daemons to deal we bad chips.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
