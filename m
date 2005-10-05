Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <43438BDD.5070308@erzia.com>
From: Franz Fuerbass <franz.furbass@erzia.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] Brainboxes BL-752(BCSP) card fails to transmit 1M chunk
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
Date: Wed, 05 Oct 2005 10:16:29 +0200

Hello,

I am using the PCMCIA Brainboxes BL-752 card for measurements of the
Bluetooth network. Currently I also recognized the well known error for
BCSP (at least in this mailing list):

bcsp_recv: Short BCSP packet
bcsp_recv: Short BCSP packet
bcsp_recv: Out-of-order packet arrived, got 3 expected 1
bcsp_recv: Short BCSP packet
bcsp_recv: Out-of-order packet arrived, got 6 expected 4
bcsp_recv: Short BCSP packet

This does not hurt too much until I try to send chunks of 1 megabyte with a
L2CAP MTU of 672 over the network, where the ACL connection (packet type 
DH5)
slows down to 300 kbps.

Using the PAN profile with pand, at least one UDP packet get lost.
The last output from hcidump shows:

 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 41 flags 0x01 dlen 490
    L2CAP(d): cid 0x0040 len 1503 [psm 0]
 > ACL data: handle 41 flags 0x02 dlen 512
 > ACL data: handle 41 flags 0x01 dlen 505
 > ACL data: handle 41 flags 0x01 dlen 339
 > ACL data: handle 41 flags 0x01 dlen 151
    L2CAP(d): cid 0x0040 len 1503 [psm 0]
 > ACL data: handle 41 flags 0x02 dlen 512
 > ACL data: handle 41 flags 0x01 dlen 505
 > ACL data: handle 41 flags 0x01 dlen 194
    L2CAP(d): cid 0x0040 len 1207 [psm 0]


I am using Kernel 2.6.13, the card was connected to a tty device with
    $> /usr/sbin/hciattach $DEVICE bcsp
using the hci_uart + serial driver (h4).

The /etc/pcmcia/bluetooth.conf file has the following entry:

card "Brain Boxes BL-752 Bluetooth Adapter"
  manfid 0x0160,0xaba0
  bind "serial_cs" class "bluetooth"


cat /proc/tty/driver/serial gives:
...
2: uart:TI16750 port:000003E8 irq:3 tx:15970676 rx:17133759 
RTS|CTS|DTR|DSR|CD
...
This looks ok, but seems to me that the flow control is not working 
correctly.



Please let me know if there is a solution for this
thanks
Franz


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
