Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Hans Bausewein <hans@comerwell.xs4all.nl>
To: Bluez users <bluez-users@lists.sourceforge.net>
Message-ID: <20041030094327.GA8724@comerwell.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] Broadcom Corporation (Firmware 105.105.074) USB dongle
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
Date: Sat, 30 Oct 2004 11:43:27 +0200

My new USB dongle (MyCom label, but it's a Broadcom) does not work with
Linux Debian (unstable) kernel 2.4.27 or 2.6.8 and bluez-utils 2.10-1
(Debian package). It loads, but scanning does not work.

p2:~# hciconfig -a
hci0:   Type: USB
        BD Address: 00:02:72:C0:11:1C ACL MTU: 377:10  SCO MTU: 16:0
        UP RUNNING 
        RX bytes:163 acl:0 sco:0 events:21 errors:0  
        TX bytes:583 acl:0 sco:0 commands:21 errors:0
        Features: 0xff 0xff 0x0d 0x38 0x08 0x08 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT 
Can't read local name on hci0. Input/output error(5)


p2:~# hciconfig hci0 version
hci0:   Type: USB
        BD Address: 00:02:72:C0:11:1C ACL MTU: 377:10  SCO MTU: 16:0
        HCI Ver: 1.2 (0x2) HCI Rev: 0x69 LMP Ver: 1.2 (0x2) LMP Subver:
0x694a
        Manufacturer: Broadcom Corporation (15)

p2:~# hciconfig hci0 revision
hci0:   Type: USB
        BD Address: 00:02:72:C0:11:1C ACL MTU: 377:10  SCO MTU: 16:0
        Firmware 105.105.074

p2:~# lsusb
Bus 001 Device 009: ID 0a5c:3503 Broadcom Corp.
Bus 001 Device 008: ID 0a5c:3502 Broadcom Corp.
Bus 001 Device 007: ID 0a5c:2009 Broadcom Corp.
Bus 001 Device 006: ID 0a5c:3535 Broadcom Corp.
Bus 001 Device 001: ID 0000:0000

hcid says:
  hcid[6544]: Can't set scan mode on hci0. Device or resource busy(16)
  hcid[6544]: Can't set auth on hci0. Device or resource busy(16)   
  hcid[6544]: Can't set encrypt on hci0. Device or resource busy(16)

I guess these happen, because there are 4 devices instead of just one (as
with my MSI dongle, that works fins).

Tried to change to HCI:

p2:~# hid2hci --tohci
No devices in HCI mode found

Installed packages: 
ii  bluez-bluefw   1.0-1          Firmware and loader for BCM2033-based ...
ii  bluez-hcidump  1.12-1         Analyses Bluetooth HCI packets
ii  bluez-pin      0.24-1         Bluetooth PIN helper with D-BUS support
ii  bluez-utils    2.10-1         Bluetooth tools and daemons

Any ideas?

Or should I better swap the device for a (more expensive) MSI ?

I'm compiling kernel 2.6.9, now. Maybe that helps?

Hans


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
