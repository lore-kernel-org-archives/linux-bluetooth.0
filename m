Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Michal Semler <cijoml@volny.cz>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200412280908.35348.cijoml@volny.cz>
Subject: [Bluez-users] problem switching via hid2hci
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
Date: Tue, 28 Dec 2004 09:08:35 +0100

Hi Marcel,

when I call hid2hci I get:
# hid2hci
Switching device 0a12:1000 to HCI mode failed (Protocol error)
notas:/home/cijoml# hciconfig
hci0:   Type: USB
        BD Address: 00:0D:88:8E:AB:2F ACL MTU: 192:8 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:107 acl:0 sco:0 events:14 errors:0
        TX bytes:300 acl:0 sco:0 commands:13 errors:0

notas:/home/cijoml# hciconfig hci0 revision
hci0:   Type: USB
        BD Address: 00:0D:88:8E:AB:2F ACL MTU: 192:8 SCO MTU: 64:8
        HCI 18.2
        Chip version: BlueCore02-External
        Max key size: 128 bit
        SCO mapping:  HCI

And in dmesg is:
usb 3-1: usbfs: USBDEVFS_CONTROL failed cmd hid2hci rqt 64 rq 0 len 0 ret -71
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
usb 3-1: USB disconnect, address 3
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: can't resubmit intr, 0000:00:1d.2-1/input1, 
status -19
usb 3-1: new full speed USB device using uhci_hcd and address 4
Bluetooth: HCI USB driver ver 2.7
usbcore: registered new driver hci_usb

Thanks for fixing these stupid messages :)

kernel 2.6.10 without -mh patch

Michal


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
