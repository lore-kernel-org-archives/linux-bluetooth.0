Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050714155156.16265.qmail@web33507.mail.mud.yahoo.com>
From: Vinod <geekvinod@yahoo.com>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <42D5EB4B.6040206@cc.lv>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: [Bluez-users] can't open hcid socket
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
Date: Thu, 14 Jul 2005 08:51:55 -0700 (PDT)

Hi All.

I am trying to send create a bluetooth connection
between my ipaq 3870 running familiar v0.8.2,GPE,
(2.4.19 .. hh37) and a desktop with usb dongle.

I was following a link
http://opie.handhelds.org/cgi-bin/moin.cgi/BluetoothGprs

But i ran into trouble,

#/etc/init.d/bluetooth start

i got

Starting Bluetooth subsystem: hcid sdpdCan't open HIDP
control socket: Invalid argument
 hidd rfcomm.

This is what the log had to say

root@h3600:/var/log# cat /var/log/messages
Oct 21 12:14:40 h3600 syslog.info syslogd started:
BusyBox v1.00 (2005.04.07-12:
08+0000)
Oct 21 12:14:48 h3600 daemon.info hcid[5948]:
Bluetooth HCI daemon
Oct 21 12:14:48 h3600 daemon.err sdpd[5952]:
init_server: binding L2CAP socket:
Address already in use
Oct 21 12:14:48 h3600 daemon.err sdp

I found a bug report on this

Bug
report:https://bugzilla.altlinux.org/show_bug.cgi?id=5247

There were some more posts on the web with similar
problems but i did not find a concrete solution.

Can anyone tell me what is going wrong? The l2cap
socket 'address already in use' is somethign that may
be causing it or somethign with the hcid interface. I
have two serial ports on my desktop, one of which i am
using as a serial console to my ipaq. I am  a newbie
to bluetooth and don't understand the protocols well
enough yet.

Thanks,
Vinod



__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
