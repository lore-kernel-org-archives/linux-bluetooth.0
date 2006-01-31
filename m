Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Arthur Breitman <arthur.breitman@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200601310012.39402.arthur.breitman@gmail.com>
Subject: [Bluez-users] Bluetooth with Latitude X1
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
Date: Tue, 31 Jan 2006 00:12:39 -0500

Hi, I already asked questions about this, without any success. I am retrying.
Here are the informations.
I have a Dell Latitude X1 Notebook. Bluetooth works flawlessly on windows and 
is reported to work fine on this notebook on the internet.
I believe I have installed and loaded all the necessary modules.


arthurb@coin:~$ lsmod
Module                  Size  Used by
usbhid                 38624  0
rfcomm                 39704  6
l2cap                  26372  5 rfcomm
ohci1394               35124  0
sdhci                  14208  0
mmc_core               24720  1 sdhci
hci_usb                16020  7
bluetooth              49892  19 rfcomm,l2cap,hci_usb
ehci_hcd               32520  0
uhci_hcd               33680  0
usbcore               129668  5 usbhid,hci_usb,ehci_hcd,uhci_hcd

hcid and sdpd are running

hciconfig -a gives
arthurb@coin:~$ hciconfig -a
hci0:   Type: USB
        BD Address: 00:10:C6:64:69:6B ACL MTU: 384:8 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:5792 acl:0 sco:0 events:562 errors:0
        TX bytes:1070 acl:0 sco:0 commands:95 errors:0
        Features: 0xff 0xff 0x9f 0xfe 0x9b 0xf9 0x00 0x80
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'coin-0'
        Class: 0x3e0100
        Service Classes: Networking, Rendering, Capturing
        Device Class: Computer, Uncategorized
        HCI Ver: 1.2 (0x2) HCI Rev: 0x679 LMP Ver: 1.2 (0x2) LMP Subver: 0x679
        Manufacturer: Cambridge Silicon Radio (10)

arthurb@coin:~$ hcitool dev
Devices:
        hci0    00:10:C6:64:69:6B

if I set my mobile phone in discovery mode and starts a scan on the laptop:

arthurb@coin:~$ sudo hcidump  -V -X
HCI sniffer - Bluetooth packet analyzer ver 1.28
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Inquiry (0x01|0x0001) plen 5
    lap 0x9e8b33 len 8 num 0
> HCI Event: Command Status (0x0f) plen 4
    Inquiry (0x01|0x0001) status 0x00 ncmd 1
> HCI Event: Vendor (0xff) plen 7
  0000: cd 03 00 04 00 00 00                              .......
> HCI Event: Vendor (0xff) plen 7
  0000: cd 03 00 04 00 00 00                              .......
> HCI Event: Vendor (0xff) plen 7
  0000: cd 03 00 04 00 00 00                              .......
> HCI Event: Vendor (0xff) plen 7
  0000: cd 03 00 04 00 00 00                              .......
> HCI Event: Vendor (0xff) plen 7
  0000: cd 03 00 04 00 00 00                              .......
> HCI Event: Vendor (0xff) plen 7
  0000: cd 03 00 04 00 00 00                              .......
> HCI Event: Vendor (0xff) plen 7
  0000: cd 03 00 04 00 00 00                              .......
> HCI Event: Vendor (0xff) plen 7
  0000: cd 03 00 04 00 00 00                              .......
> HCI Event: Vendor (0xff) plen 7
  0000: cd 03 00 04 00 00 00                              .......
> HCI Event: Vendor (0xff) plen 7
  0000: cd 03 00 04 00 00 00                              .......
> HCI Event: Inquiry Complete (0x01) plen 1
    status 0x00

My cell phone has in memory the bluetooth adress of my adaptater, it remembers 
it from its encounter under window... trying to send a file to this device 
doesn't work of course, yet this is detected by my adaptater which starts 
displaying "Vendor" events. weird, but it means the communication is going 
through.

Could anyone help me find out what's going on ?
I am willing to go all the way with this, I can compile development code, run 
debugs etc etc.

Regards,
Arthur B.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
