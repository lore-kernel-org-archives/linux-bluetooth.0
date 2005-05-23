Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: =?ISO-8859-2?Q?Szab=F3_Zolt=E1n?= <szz@freemail.hu>
To: bluez-users@lists.sourceforge.net
Message-Id: <20050523165711.055d97c2.szz@freemail.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Subject: [Bluez-users] 3CRWB6096 PCMCIA card
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
Date: Mon, 23 May 2005 16:57:11 +0200

I would like to ask you some help to make my 3CRWB6096 PCMCIA card to
work. According to some documentation
I use bt3c_cs driver.
I use this:
Linux localhost 2.6.9-19 #1 SMP Wed Apr 13 15:09:16 CEST 2005 i686
UHU-Linux

Here is the output of some events:
[After insterting the PCMCIA card: ]
May 23 09:37:49 kernel: cs: memory probe 0xa0000000-0xa0ffffff: clean.
May 23 09:37:49 cardmgr[2407]: socket 1: 3Com Bluetooth PC Card
May 23 09:37:49 kernel: Bluetooth: Core ver 2.6
May 23 09:37:49 kernel: NET: Registered protocol family 31
May 23 09:37:49 kernel: Bluetooth: HCI device and connection manager
 initialized
May 23 09:37:49 kernel: Bluetooth: HCI socket layer initialized
May 23 09:37:59 kernel: bt3c_open: Firmware request failed
May 23 09:37:59 kernel: bt3c_interrupt: Call of irq 3 for unknown device
May 23 09:38:00 cardmgr[2407]: get dev info on socket 1 failed: Resource
temporarily unavailable

[A part of the dmesg output:]
cs: memory probe 0xa0000000-0xa0ffffff: clean.
Bluetooth: Core ver 2.6
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
bt3c_open: Firmware request failed
bt3c_interrupt: Call of irq 3 for unknown device

#lsmod|grep bt
bt3c_cs                15236  0
firmware_class         11392  1 bt3c_cs
bluetooth              43268  1 bt3c_cs
ds                     21124  5 bt3c_cs
pcmcia_core            62004  4 bt3c_cs,ds,i82092,yenta_socket

#modinfo bt3c_cs
author:         Marcel Holtmann <marcel@holtmann.org>, Jose Orlando
Pereira <jop@di.uminho.pt>
description:    Bluetooth driver for the 3Com Bluetooth PCMCIA card
license:        GPL
vermagic:       2.6.9-19 SMP 586 gcc-3.3
depends:        ds,pcmcia_core,bluetooth,firmware_class

# dpkg -l "bluez*"
||  Name                  Version               Description
ii  bluez-bluefw          1.0-1.22              Bluetooth firmware
ii  bluez-hcidump         1.16-1.2              HCI csomag analiz=E1tor
ii  bluez-hciemu          1.1-1.2               HCI emul=E1ci=F3 a linux
ii  bluez-libs            2.13-1.2              Bluetooth protokoll
ii  bluez-libs-dev        2.13-1.2              Bluetooth protokoll
ii  bluez-pin             0.24-1.2              PIN bek=E9r=F5 BlueTooth
ii  bluez-utils           2.13-1.2              Bluetooth seg=E9dprogramok

#ls /dev/rf*
[nothing]

# /etc/init.d/bluetooth start
Starting Bluetooth subsystem: hcid sdpd hidd hid2hci rfcomm.
root@localhost:~# tail /var/log/syslog
May 23 09:59:08 localhost kernel: [ACPI Debug] String: [0x12]
"=3D=3D=3D=3D=3DQUERY_42=3D=3D=3D=3D=3D"
May 23 09:59:18 localhost hcid[3725]: Bluetooth HCI daemon
May 23 09:59:18 localhost kernel: Bluetooth: L2CAP ver 2.4
May 23 09:59:18 localhost kernel: Bluetooth: L2CAP socket layer
initialized
May 23 09:59:18 localhost sdpd[3727]: Bluetooth SDP daemon
May 23 09:59:18 localhost kernel: Bluetooth: HIDP (Human Interface
Emulation) ver 1.0
May 23 09:59:18 localhost hidd[3733]: Bluetooth HID daemon
May 23 09:59:18 localhost kernel: Bluetooth: RFCOMM ver 1.3
May 23 09:59:18 localhost kernel: Bluetooth: RFCOMM socket layer
initialized
May 23 09:59:18 localhost kernel: Bluetooth: RFCOMM TTY layer
initialized

#ls /dev/rf*
[nothing]

# hciconfig
[nothing]
# hcidump
HCIDump - HCI packet analyzer ver 1.16
Can't attach to device hci0. No such device(19)

---
Could you please help me?
Thank you,
Zol




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
