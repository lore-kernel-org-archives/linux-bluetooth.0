Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Arthur Breitman <arthur.breitman@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200511211803.35723.arthur.breitman@gmail.com>
Subject: [Bluez-users] Everything seems normal yet...
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
Date: Mon, 21 Nov 2005 18:03:35 -0500

Hi,
I have a latitude X1 Dell. Bluetooth is reported to work out of the box for 
this model, however I just can't make it work.
I installed a kubuntu hoary on it, the kernel is linux 2.6.12-9.
There is a toggle key on the keyboard for bluetooth, according to a led 
indicator and dmesg it works. Better, KDE used to display an info message 
saying the state had been changed.
Well it said that and right after it would display a message complaining about 
the class being set to 0x0...
I went into hcid.conf as advised and saw the class was NOT 0x0... wtf? Well I 
changed it along with the pin helper application.
Didn't do anything, even after reboots etc.
Finally I tried  hcid -f /etc/bluetooth/hcid.conf and "tada" it didn't 
complain anymore. Well actually the info bubbles where gone too... seems like 
KDE is not aware anymore of the bluetooth status.

Anyway, here are some relevant informations

root@coin:/# lsmod | grep blue
bluetooth              43012  24 hidp,rfcomm,l2cap,hci_usb

root@coin:/# dmesg | grep usb
[4313920.766000] usb 2-1: new full speed USB device using uhci_hcd and address 
21


root     10506  0.0  0.1   1920   820 ?        Ss   17:59   0:00 hcid: 
processing events
root     26060  0.0  0.1   1612   544 ?        Ss   16:35   
0:00 /usr/sbin/sdpd

root@coin:/# lsusb
Bus 002 Device 021: ID 413c:8103 Dell Computer Corp.

root@coin:/# hcitool dev
Devices:
        hci0    00:10:C6:64:69:6B

root@coin:/# hciconfig -a
hci0:   Type: USB
        BD Address: 00:10:C6:64:69:6B ACL MTU: 384:8 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:6478 acl:0 sco:0 events:722 errors:0
        TX bytes:3721 acl:0 sco:0 commands:132 errors:0
        Features: 0xff 0xff 0x9f 0xfe 0x9b 0xf9 0x00 0x80
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'Bluetooth coin-0'
        Class: 0x000100
        Service Classes: Unspecified
        Device Class: Computer, Uncategorized
        HCI Ver: 1.2 (0x2) HCI Rev: 0x679 LMP Ver: 1.2 (0x2) LMP Subver: 0x679
        Manufacturer: Cambridge Silicon Radio (10)

Now  everything looks right to me... unfortunately "hcitool scan" doesn't see 
my motorola, which is in discoverable mode using the "find me" option... 
similarly my motorola doesn't see my computer... also I liked the kde info 
bubble. 

What could be wrong? What haven't I checked?
Thanks for your help,
Arthur





-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
