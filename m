Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Bc. Michal Semler" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200409162334.37159.cijoml@volny.cz>
Subject: [Bluez-users] 2.6.9-rc2 hibernate and BlueZ
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
Date: Thu, 16 Sep 2004 23:34:37 +0200

Hi Marcel,

after resume from hibernate, kernel oopses:

PM: Preparing system for suspend
Stopping tasks:=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D|
hci_usb 4-1:1.0: resume is unsafe!
hci_usb 4-1:1.1: resume is unsafe!
uhci_hcd 0000:00:1d.0: Unlink after no-IRQ?  Different ACPI or APIC setting=
s=20
ma
y help.
PCI: Setting latency timer of device 0000:00:1d.7 to 64
hci_usb: probe of 4-1:1.2 failed with error -113
Could not suspend device 0000:00:1d.7: error -5
PCI: Found IRQ 10 for device 0000:00:1f.1
PCI: Sharing IRQ 10 with 0000:00:1d.2
PCI: Enabling device 0000:00:1f.5 (0000 -> 0003)
PCI: Found IRQ 10 for device 0000:00:1f.5
PCI: Sharing IRQ 10 with 0000:00:1f.3
PCI: Sharing IRQ 10 with 0000:00:1f.6
i810_audio: Primary codec has ID 0
ac97_codec: AC97 Audio codec, id: CRY52 (Cirrus Logic CS4299 rev D)
prism2_hw_init: initialized in 194 ms
wifi0: NIC: id=3D0x800c v1.0.0
wifi0: PRI: id=3D0x15 v1.1.1
wifi0: STA: id=3D0x1f v1.8.0
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
hub 1-0:1.0: reactivate --> -22
hci_usb: probe of 4-1:1.2 failed with error -113
hub 1-0:1.0: reactivate --> -22
hci_usb: probe of 4-1:1.2 failed with error -113
hub 2-0:1.0: reactivate --> -22
hci_usb: probe of 4-1:1.2 failed with error -113
hub 3-0:1.0: reactivate --> -22
hub 4-0:1.0: reactivate --> -22
Restarting tasks... done
Bluetooth: HCI USB driver ver 2.7
hci_usb_probe: Can't set isoc interface settings
Unable to handle kernel NULL pointer dereference at virtual address 00000120
 printing eip:
cf97e842
*pde =3D 00000000
Oops: 0000 [#1]
PREEMPT
Modules linked in: hci_usb rfcomm hidp l2cap hostap_cs hostap irda crc_ccit=
t=20
id
e_cd cdrom bluetooth 8139too mii crc32 8250_pci 8250 serial_core i810_audio=
=20
ac9
7_codec parport_pc parport pcspkr nls_iso8859_2 ntfs rtc
CPU:    0
EIP:    0060:[<cf97e842>]    Not tainted VLI
EFLAGS: 00210296   (2.6.8.1)
EIP is at hci_usb_close+0xf/0x60 [hci_usb]
eax: c1230e80   ebx: 00000000   ecx: ced155f8   edx: c1230e90
esi: 00000000   edi: 00000002   ebp: cf981200   esp: c7c11e3c
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 6924, threadinfo=3Dc7c10000 task=3Dc0735aa0)
Stack: ced3c800 c1230c80 00000000 cf97f9ff 00000000 c1230e80 cf981320 c1230=
e80
       cf981320 c02662e9 c1230e80 c1230e80 ce769050 c1230e90 cf981340 c0233=
37d
       c1230e90 c1230eb8 c1230e90 c1230c80 c0266544 c1230e90 00000005 cf97f=
91a
Call Trace:
 [<cf97f9ff>] hci_usb_disconnect+0x2f/0x94 [hci_usb]
 [<c02662e9>] usb_unbind_interface+0x7a/0x7c
 [<c023337d>] device_release_driver+0x64/0x66
 [<c0266544>] usb_driver_release_interface+0x50/0x52
 [<cf97f91a>] hci_usb_probe+0x36a/0x420 [hci_usb]
 [<c018ed7c>] init_dir+0x0/0x1f
 [<c0266262>] usb_probe_interface+0x68/0x75
 [<c02331dd>] bus_match+0x3f/0x6a
 [<c02332ef>] driver_attach+0x56/0x80
 [<c0233742>] bus_add_driver+0x91/0xaf
 [<c0233c5d>] driver_register+0x2f/0x33
 [<c011de9a>] vprintk+0x110/0x16a
 [<c026632a>] usb_register+0x3f/0x9d
 [<c011dd86>] printk+0x17/0x1b
 [<cfcd2027>] hci_usb_init+0x27/0x4d [hci_usb]
 [<c013445e>] sys_init_module+0x183/0x22f
 [<c010608b>] syscall_call+0x7/0xb
Code: 44 24 04 08 83 44 24 08 08 83 7c 24 0c 03 0f 8e 0f ff ff ff 83 c4 10 =
5b=20
5                                                              e 5f 5d c3 8=
3=20
ec 0c 89 5c 24 04 89 74 24 08 8b 5c 24 10 <8b> b3 20 01 00 00 0f           =
                                                   =20
ba 73 14 02 19 c0 85 c0 74 2b 9c 58 fa ba
 <6>usb 4-1: USB disconnect, address 2
notas:/home/cijoml/filmy/Klub Sr=E1=E8=F9#

Maybe it is a job for you?? :)

Michal


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
