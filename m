Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-Id: <540644453@web.de>
MIME-Version: 1.0
From: "Stephan Cremer" <cremer.stephan@web.de>
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset="iso-8859-1"
Subject: [Bluez-users] rfcomm device disappears
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
Date: Thu, 10 Jun 2004 00:03:44 +0200

Hello,

I have been observing a strange and reproduceable problem trying
to setup a PPP server for my Nokia 3650. Briefly, the scenario is
as follows:
 
First, a serial Port is registered: "sdptool add --channel=2 SP"
After that, dund is started and waits for incoming PPP requests:
"dund -n --listen --channel=2 call dun"
When an application - e.g. a web browswer is started on the phone,
using a bluetooth access point configured via gnubox, the PPP link
is fired up and the app works perfectly.

Unfortunately, this works excactly once, because for some reason,
the rfcomm device that was used for the PPP link disappears, which
on the connection request makes dund complain 
"RFCOMM TTY creation failed. No such file or directory(2)" - I
tried to (re-)create the device in /etc/ppp/ip-down but no avail...

Here is the output of "hcidump -x" starting right before the 
application is closed on the phone:

---------- snip -----------
HCIDump - HCI packet analyzer ver 1.5 device: hci0 snap_len: 1028
filter: 0xffffffff > ACL data: handle 0x0029 flags 0x02 dlen 20
    L2CAP(d): cid 0x41 len 16 [psm 0]
      13 EF 19 7E FF 03 C0 21 05 03 00 04 85 72 7E 65 < ACL data:
handle 0x0029 flags 0x02 dlen 25
    L2CAP(d): cid 0x59 len 21 [psm 0]
      11 EF 23 7E FF 7D 23 C0 21 7D 26 7D 23 7D 20 7D 24 48 57 7E
      BF > HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00 < ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x59 len 4 [psm 0]
      11 53 01 16 > HCI Event: Number of Completed  Packets(0x13)
plen 5
  01 29 00 01 00 > ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x41 len 4 [psm 0]
      11 73 01 3C > ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s):  Disconn  req:  dcid 0x0041 scid 0x0059 < ACL data:
handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0059 >  HCI  Event:
Number of Completed Packets(0x13) plen 5
  01 29 00 01 00
---------- snip -----------


And here are some notes on my configuration:

- Gentoo Linux, Kernel 2.6.6 / patch-2.6.6-mh3.gz
- Epox bt-dg02a USB BT dongle
- bluez: kernel 2.3, libs 2.5, pan 1.1, sdp 1.5, utils 2.3-r1, hcidump 1.5


Any help and/or hints pushing me into the 
right direction will be greatly appreceated :-)

Best Regards,
Stephan Cremer.
__________________________________________________________________
Zeigen Sie Emotionen mit der WEB.DE Bild-SMS! Das Bild ist gratis,
Sie bezahlen nur den Versand. http://freemail.web.de/?mc=021196



-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
