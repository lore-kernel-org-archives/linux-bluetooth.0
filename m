Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Problems connecting to multiple rfcomm sockets
From: Marcel Holtmann <marcel@holtmann.org>
To: Steve Drew <steve.drew@empics.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <0DD4EA5DCF754A409C4E182C758C37F38204@tigris.i.empics.co.uk>
References: <0DD4EA5DCF754A409C4E182C758C37F38204@tigris.i.empics.co.uk>
Content-Type: text/plain
Message-Id: <1098892142.6730.1.camel@pegasus>
Mime-Version: 1.0
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
Date: Wed, 27 Oct 2004 17:49:02 +0200

Hi Steve,

> I've been experiencing some problems when trying to open multiple rfcomm
> ports, with pppd using the rfcomm ports.
> 
> I have three bluetooth serial ports setup in rfcomm.conf, but it appears
> that I can open connections to two of them at once. 
> 
> While the first two serial ports are connected, and the third is trying
> to connect, running rfcomm gives;
> 
> rfcomm0: 00:0E:6D:1A:9A:3F channel 1 connected [tty-attached]
> rfcomm1: 00:02:EE:82:D9:29 channel 2 connected [tty-attached]
> rfcomm2: 00:60:57:70:CD:E1 channel 3 config [tty-attached]
> 
> Then the terminal with the third connection reports;
> 
> "Failed to open /dev/rfcomm2: Host is down"
> 
> At which point running #rfcomm gives;
> 
> rfcomm0: 00:0E:6D:1A:9A:3F channel 1 connected [tty-attached]
> rfcomm1: 00:02:EE:82:D9:29 channel 2 connected [tty-attached]
> rfcomm2: 00:60:57:70:CD:E1 channel 3 closed.

what does "hcitool con" tell you at this point? Run "hcidump -x" and see
with what error code the third connection fails.

> If I now close the connection to rfcomm1 or rfcomm0, I can connect to
> rfcomm2 (so I can always have a max of 2 active connections).
> 
> However, If before I start the pppd connections to the serial ports, I
> start 3 copies of l2ping (one to each of the MAC addresses listed
> above), and keep these running, I can establish pppd connections on
> rfcomm0+1+2 at the same time.
> 
> With this scenario, if one of the pppd sessions terminates, the l2ping
> to the corresponding rfcomm device's MAC will stop giving:
>  "Send failed: Connection reset by peer", and once again I can only use
> two of the rfcomm ports. 
> 
> Using bluez-utils-2.10-2 and bluez-libs-2.10-2 under a 2.4.22-1 kernel
> 
> Any idea/subjections/requests for more information greatly appreciated!

What devices did you use (hciconfig -a) and to what devices are you
connecting?

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
