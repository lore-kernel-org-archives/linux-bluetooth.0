Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <46935C56.5060108@idlum.be>
Date: Tue, 10 Jul 2007 12:15:50 +0200
From: Pierre-Yves Paulus <py@idlum.be>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <20070709093602.A2C6B58D565@mailflip16.edt02.net>
In-Reply-To: <20070709093602.A2C6B58D565@mailflip16.edt02.net>
Content-Type: multipart/mixed; boundary="------------060209080403090105050002"
Subject: [Bluez-devel] Kernel Oops while transmitting data on several RFCOMM
	links
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------060209080403090105050002
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I performed a test on a system with several dongles, establishing 
several RFCOMM links to remote devices, and transmitting data over them. 
At one point, there was a kernel Oops. Please find attached the relevant 
parte of the kernel log. Kernel on the box is 2.6.20-1.

Is it a known problem which can be avoided by upgrading the kernel to a 
latest release?

Best Regards,
Pierre-Yves Paulus



--------------060209080403090105050002
Content-Type: text/plain;
 name="kernel_crash_trimmed"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kernel_crash_trimmed"

Jul  6 15:05:49 p2a kernel: kobject_add failed for rfcomm2 with -EEXIST, don't try to register things with the same name in the same directory.
Jul  6 15:05:49 p2a kernel:  [<c01b698b>] kobject_add+0x152/0x17b
Jul  6 15:05:49 p2a kernel:  [<c01b6b19>] kobject_set_name+0x29/0x92
Jul  6 15:05:49 p2a kernel:  [<c02131c9>] device_add+0x83/0x466
Jul  6 15:05:49 p2a kernel:  [<c01b6a01>] kobject_init+0x2b/0x3b
Jul  6 15:05:49 p2a kernel:  [<c0213634>] device_create+0x78/0x97
Jul  6 15:05:49 p2a kernel:  [<c01fdbbc>] tty_register_device+0xb7/0xbf
Jul  6 15:05:49 p2a kernel:  [<d02a57f4>] hci_get_route+0xa3/0xac [bluetooth]
Jul  6 15:05:49 p2a kernel:  [<d03506d4>] rfcomm_dev_ioctl+0x2ae/0x505 [rfcomm]
Jul  6 15:05:49 p2a kernel:  [<d034f214>] rfcomm_sock_ioctl+0x1e/0x2d [rfcomm]
Jul  6 15:05:49 p2a kernel:  [<c0230b70>] sock_ioctl+0x1a6/0x1c5
Jul  6 15:05:49 p2a kernel:  [<c02309ca>] sock_ioctl+0x0/0x1c5
Jul  6 15:05:49 p2a kernel:  [<c0159b4d>] do_ioctl+0x19/0x47
Jul  6 15:05:49 p2a kernel:  [<c0159d5e>] vfs_ioctl+0x1e3/0x1f1
Jul  6 15:05:49 p2a kernel:  [<c0159dba>] sys_ioctl+0x4e/0x68
Jul  6 15:05:49 p2a kernel:  [<c0102b90>] syscall_call+0x7/0xb
Jul  6 15:05:49 p2a kernel:  =======================
Jul  6 15:06:02 p2a kernel: hci_acldata_packet: hci2 ACL packet for unknown connection handle 13
Jul  6 15:06:02 p2a kernel: hci_acldata_packet: hci2 ACL packet for unknown connection handle 13
Jul  6 15:06:06 p2a kernel: BUG: unable to handle kernel NULL pointer dereference at virtual address 0000003c
Jul  6 15:06:06 p2a kernel:  printing eip:
Jul  6 15:06:06 p2a kernel: d0350b0c
Jul  6 15:06:06 p2a kernel: *pde = 00000000
Jul  6 15:06:06 p2a kernel: Oops: 0000 [#1]
Jul  6 15:06:06 p2a kernel: Modules linked in: rfcomm l2cap button ac battery ipv6 dm_snapshot dm_mirror dm_mod ks8842_pci loop evdev floppy rtc hci_usb bluetooth psmouse serio_raw snd_via82xx gameport snd_ac97_codec ac97_bus snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd i2c_viapro via82cxxx_audio uart401 sound soundcore ac97_codec pcspkr via686a shpchp pci_hotplug parport_pc via_agp agpgart i2c_isa i2c_core parport reiserfs sd_mod generic via82cxxx ide_core pata_via ata_generic 8139cp 8139too mii libata scsi_mod uhci_hcd usbcore thermal processor fan
Jul  6 15:06:06 p2a kernel: CPU:    0
Jul  6 15:06:06 p2a kernel: EIP:    0060:[<d0350b0c>]    Not tainted VLI
Jul  6 15:06:06 p2a kernel: EFLAGS: 00010296   (2.6.20-1-486 #1)
Jul  6 15:06:06 p2a kernel: EIP is at rfcomm_tty_write+0x19/0x163 [rfcomm]
Jul  6 15:06:06 p2a kernel: eax: 00000000   ebx: cee79000   ecx: 00000003   edx: c5a9c800
Jul  6 15:06:06 p2a kernel: esi: c2442400   edi: c5a9c800   ebp: 00000003   esp: cde29ee8
Jul  6 15:06:06 p2a kernel: ds: 007b   es: 007b   ss: 0068
Jul  6 15:06:06 p2a kernel: Process java (pid: 5950, ti=cde28000 task=c9188a50 task.ti=cde28000)
Jul  6 15:06:06 p2a kernel: Stack: 00000000 00000003 c5a9c800 00000000 00000000 00000000 cee79000 c2442400 
Jul  6 15:06:06 p2a kernel:        c5a9c800 00000003 c0200f5c c5a9c800 c2674460 c2442400 00000000 c9188a50 
Jul  6 15:06:06 p2a kernel:        c011495b c244251c c244251c 00000003 c2442400 00000003 00000003 c01fecef 
Jul  6 15:06:06 p2a kernel: Call Trace:
Jul  6 15:06:06 p2a kernel:  [<c0200f5c>] write_chan+0x21a/0x28d
Jul  6 15:06:06 p2a kernel:  [<c011495b>] default_wake_function+0x0/0xc
Jul  6 15:06:06 p2a kernel:  [<c01fecef>] tty_write+0x147/0x1cc
Jul  6 15:06:06 p2a kernel:  [<c0200d42>] write_chan+0x0/0x28d
Jul  6 15:06:06 p2a kernel:  [<c01feba8>] tty_write+0x0/0x1cc
Jul  6 15:06:06 p2a kernel:  [<c0150ce4>] vfs_write+0xab/0x158
Jul  6 15:06:06 p2a kernel:  [<c0151211>] sys_write+0x43/0x69
Jul  6 15:06:06 p2a kernel:  [<c0102b90>] syscall_call+0x7/0xb
Jul  6 15:06:06 p2a kernel:  =======================
Jul  6 15:06:06 p2a kernel: Code: 5e e9 8e f5 ff ff 5a 5b 5e e9 4b e5 ea ef 58 5b 5e c3 55 57 56 53 83 ec 18 89 54 24 08 89 4c 24 04 8b 80 40 01 00 00 89 44 24 0c <8b> 40 3c 89 44 24 10 31 ff c7 44 24 14 00 00 00 00 e9 ee 00 00 
Jul  6 15:06:06 p2a kernel: EIP: [<d0350b0c>] rfcomm_tty_write+0x19/0x163 [rfcomm] SS:ESP 0068:cde29ee8
Jul  6 15:06:09 p2a kernel:  <0>invalid opcode: 0000 [#2]
Jul  6 15:06:09 p2a kernel: Modules linked in: rfcomm l2cap button ac battery ipv6 dm_snapshot dm_mirror dm_mod ks8842_pci loop evdev floppy rtc hci_usb bluetooth psmouse serio_raw snd_via82xx gameport snd_ac97_codec ac97_bus snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd i2c_viapro via82cxxx_audio uart401 sound soundcore ac97_codec pcspkr via686a shpchp pci_hotplug parport_pc via_agp agpgart i2c_isa i2c_core parport reiserfs sd_mod generic via82cxxx ide_core pata_via ata_generic 8139cp 8139too mii libata scsi_mod uhci_hcd usbcore thermal processor fan
Jul  6 15:06:09 p2a kernel: CPU:    0
Jul  6 15:06:09 p2a kernel: EIP:    0060:[<c9188a64>]    Not tainted VLI
Jul  6 15:06:09 p2a kernel: EFLAGS: 00010082   (2.6.20-1-486 #1)
Jul  6 15:06:09 p2a kernel: EIP is at 0xc9188a64
Jul  6 15:06:09 p2a kernel: eax: cde29f20   ebx: cde29f20   ecx: 00000000   edx: 00000001
Jul  6 15:06:09 p2a kernel: esi: cde29f78   edi: 00000001   ebp: cf305f28   esp: cf305f09
Jul  6 15:06:09 p2a kernel: ds: 007b   es: 007b   ss: 0068
Jul  6 15:06:09 p2a kernel: Process events/0 (pid: 3, ti=cf304000 task=cf347030 task.ti=cf304000)
Jul  6 15:06:09 p2a kernel: Stack: 00c0113b 01000000 1c000000 2cc24425 00cde29f 86000000 1c000002 44c24425 
Jul  6 15:06:09 p2a kernel:        99cf305f 00c0114a 00000000 44000000 46c24425 00000002 0cc24424 f6c24424 
Jul  6 15:06:09 p2a kernel:        00c01fe9 00000000 00000000 05000000 2c000000 46c24425 c0000002 f1cf3546 
Jul  6 15:06:09 p2a kernel: Call Trace:
Jul  6 15:06:09 p2a kernel:  =======================
Jul  6 15:06:09 p2a kernel: Code: 8a 18 c9 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 80 00 00 00 00 80 e2 cd 00 00 00 00 44 00 40 00 00 00 00 00 <ff> ff ff ff 80 00 00 00 7d 00 00 00 78 00 00 00 7d 00 00 00 00 
Jul  6 15:06:09 p2a kernel: EIP: [<c9188a64>] 0xc9188a64 SS:ESP 0068:cf305f09
Jul  6 15:06:29 p2a kernel:  <1>BUG: unable to handle kernel NULL pointer dereference at virtual address 00000000
Jul  6 15:06:29 p2a kernel:  printing eip:
Jul  6 15:06:29 p2a kernel: c0184d46
Jul  6 15:06:29 p2a kernel: *pde = 00000000
Jul  6 15:06:29 p2a kernel: Oops: 0000 [#3]
Jul  6 15:06:29 p2a kernel: Modules linked in: rfcomm l2cap button ac battery ipv6 dm_snapshot dm_mirror dm_mod ks8842_pci loop evdev floppy rtc hci_usb bluetooth psmouse serio_raw snd_via82xx gameport snd_ac97_codec ac97_bus snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd i2c_viapro via82cxxx_audio uart401 sound soundcore ac97_codec pcspkr via686a shpchp pci_hotplug parport_pc via_agp agpgart i2c_isa i2c_core parport reiserfs sd_mod generic via82cxxx ide_core pata_via ata_generic 8139cp 8139too mii libata scsi_mod uhci_hcd usbcore thermal processor fan
Jul  6 15:06:29 p2a kernel: CPU:    0
Jul  6 15:06:29 p2a kernel: EIP:    0060:[<c0184d46>]    Not tainted VLI
Jul  6 15:06:29 p2a kernel: EFLAGS: 00010286   (2.6.20-1-486 #1)
Jul  6 15:06:29 p2a kernel: EIP is at sysfs_follow_link+0xac/0x17f
Jul  6 15:06:29 p2a kernel: eax: 00000000   ebx: 00000003   ecx: ffffffff   edx: c271ecf0
Jul  6 15:06:29 p2a kernel: esi: 00000001   edi: 00000000   ebp: c271ecf0   esp: c635deb4
Jul  6 15:06:29 p2a kernel: ds: 007b   es: 007b   ss: 0068
Jul  6 15:06:29 p2a kernel: Process udevd (pid: 7703, ti=c635c000 task=c959e070 task.ti=c635c000)
Jul  6 15:06:29 p2a kernel: Stack: c635dedc cf29b000 c6457868 00000000 c030fbe0 00000200 cef10d34 bfcac19c 
Jul  6 15:06:29 p2a kernel:        c0155dbe 00000004 c0112f44 00000000 00000000 c635dfb8 c8602954 c8602920 
Jul  6 15:06:29 p2a kernel:        00000000 00000000 cf3c3eb0 24730972 468e5a75 c011aa65 00000001 cf7e7400 
Jul  6 15:06:29 p2a kernel: Call Trace:
Jul  6 15:06:31 p2a kernel:  [<c0155dbe>] generic_readlink+0x27/0x6e
Jul  6 15:06:31 p2a kernel:  [<c0112f44>] do_page_fault+0x28d/0x551
Jul  6 15:06:31 p2a kernel:  [<c011aa65>] current_fs_time+0x45/0x50
Jul  6 15:06:31 p2a kernel:  [<c01601f4>] touch_atime+0xa2/0xd6
Jul  6 15:06:31 p2a kernel:  [<c0152f15>] sys_readlinkat+0x84/0x9f
Jul  6 15:06:31 p2a kernel:  [<c0112f44>] do_page_fault+0x28d/0x551
Jul  6 15:06:31 p2a kernel:  [<c0152f57>] sys_readlink+0x27/0x2b
Jul  6 15:06:31 p2a kernel:  [<c0102b90>] syscall_call+0x7/0xb
Jul  6 15:06:31 p2a kernel:  =======================
Jul  6 15:06:31 p2a kernel: Code: e9 c0 00 00 00 b8 40 fb 30 c0 e8 42 3a fa ff 8b 44 24 08 31 db 43 8b 40 24 85 c0 75 f8 89 ea be 01 00 00 00 8b 3a 31 c0 83 c9 ff <f2> ae f7 d1 49 8d 74 0e 01 8b 52 24 85 d2 75 e9 8d 04 5b 8d 4c 
Jul  6 15:06:31 p2a kernel: EIP: [<c0184d46>] sysfs_follow_link+0xac/0x17f SS:ESP 0068:c635deb4
Jul  6 15:06:31 p2a kernel:  <3>hci_acldata_packet: hci2 ACL packet for unknown connection handle 11
Jul  6 15:06:31 p2a kernel: hci_acldata_packet: hci2 ACL packet for unknown connection handle 11
Jul  6 15:06:31 p2a kernel: hci_acldata_packet: hci2 ACL packet for unknown connection handle 11
Jul  6 15:06:31 p2a kernel: l2cap_recv_acldata: Unexpected continuation frame (len 0)
Jul  6 15:06:48 p2a kernel: hci_acldata_packet: hci2 ACL packet for unknown connection handle 11
Jul  6 15:06:48 p2a kernel: hci_acldata_packet: hci2 ACL packet for unknown connection handle 11

--------------060209080403090105050002
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--------------060209080403090105050002
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------060209080403090105050002--
