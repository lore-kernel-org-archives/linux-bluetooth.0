Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050219182455.68861.qmail@web53009.mail.yahoo.com>
From: Alfredo Meraz <alfredo_meraz@yahoo.com.mx>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: [Bluez-users] USB Bluetooth works manually, but won't hotplug with the SAME script
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
Date: Sat, 19 Feb 2005 12:24:55 -0600 (CST)

I have a TDK USB Bluetooth dongle, installed on a
computer with RedHat 9. After much research, I managed
to get it working with only bluez-libs 2.8-1 and
bluez-utils 2.8-1 installed with no kernel patch at
all (despite all the information I'd found saying
otherwise). So I thought about automating it with
hotplug and writing a mini-howto... but to my
surprise, the same script I'd used manually to bring
up the connection, loads all the drivers and runs the
programs needed (hcid, sdpd, rfcomm & dund) when run
from the hotplug functions, but there's a sort of
timing error with SDPD reported in all the devices
that try to connect. If I disable the loading through
hotplug and do it manually, it works again :S
I read the source and traced the hotplug programs
(/sbin/hotplug, /etc/hotplug/usb.agent), and found out
the way it works. First it loads the drivers from 3
different driver configuration files. Then, the script
gets loaded by adding a line in usb.usermap, so I
added it. There are actually 2 ways to make it load
the script, one by naming the script as the driver it
loads, the other naming it differently: none worked.
(To be honest, my head is fogged with this point at
the moment :( )
Then I tried to do everything manually through the
script, blacklist-ing the drivers: doesn't work.
I tried the log messages, which other than an error
reported with hcid with SIGCHLD and SIG_IGN, the logs
are the same when loaded manually and hotplugged. I
corrected this problem, by wait'ing for hcid in the
script, and again: doesn't work.
I thought also that it was the environment, but I
didn't try anything because I found nothing to try.

The script goes like this:
#!/bin/bash
/usr/sbin/hcid -f /etc/bluetooth/hcid.conf
/usr/sbin/sdpd
/usr/bin/rfcomm -f /etc/bluetooth/rfcomm.conf bind all
insmod hci_usb
hciconfig hci0 up
wait `pidof hciconfig`
sdptool add --channel=3 SP
dund --listen --channel 3 --msdun noauth
:192.168.1.240 crtscts 115200 ms-dns 192.168.1.1 lock

The only wait left, is my last try, since the PDA's
say something about a timing problem with sdp, which
didn't solve the problem :(

Any help, IS REALLY APPRECIATED. Even something just
to try, I'm willing to try ANYTHING (logic :) )

Thanx.
Alfredo.

_________________________________________________________
Do You Yahoo!?
La mejor conexión a internet y 25MB extra a tu correo por $100 al mes. http://net.yahoo.com.mx


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
