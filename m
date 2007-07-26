Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <46A8A7C1.1050200@idlum.be>
Date: Thu, 26 Jul 2007 15:55:13 +0200
From: Pierre-Yves Paulus <py@idlum.be>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <20070709093602.A2C6B58D565@mailflip16.edt02.net>	<46935C56.5060108@idlum.be>	<2EB6297382462046A9427D7324788A4801FD0E6C@MCLNEXVS06.resource.ds.bah.com>
	<4694A485.40904@idlum.be>
In-Reply-To: <4694A485.40904@idlum.be>
Content-Type: multipart/mixed; boundary="------------020504030309040701030200"
Subject: Re: [Bluez-devel] Kernel Oops while transmitting data on several
 RFCOMMlinks
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
--------------020504030309040701030200
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

After upgrading to kernel 2.6.21-2 (in fact, the 
linux-image-2.6.21-2-486_2.6.21-5_i386.deb package from debian 
unstable), I performed some new tests, and it happened again.

Please find attached what I got in the logs. What's wrong here? I will 
gladly perform any test or action which you may ask to help track the 
problem down. Just ask.

Best Regards,
Pierre-Yves Paulus



Pierre-Yves Paulus wrote:
> Hi Richard,
> 
> Thanks a lot for the answer. I will perform the kernel update then.
> 
> Best Regards,
> Pierre-Yves Paulus
> 
> 
> Williams, Richard wrote:
>> M Paulus,
>>
>> I had the same problem. Upgrade to the latest kernel and the problem
>> will be fixed.
>>
>> Regards,
>>
>> Richard Williams 
>>
>>
>> -----Original Message-----
>> From: bluez-devel-bounces@lists.sourceforge.net
>> [mailto:bluez-devel-bounces@lists.sourceforge.net] On Behalf Of
>> Pierre-Yves Paulus
>> Sent: Tuesday, July 10, 2007 6:16 AM
>> To: BlueZ development
>> Subject: [Bluez-devel] Kernel Oops while transmitting data on several
>> RFCOMMlinks
>>
>> Hello,
>>
>> I performed a test on a system with several dongles, establishing
>> several RFCOMM links to remote devices, and transmitting data over them.
>>
>> At one point, there was a kernel Oops. Please find attached the relevant
>> parte of the kernel log. Kernel on the box is 2.6.20-1.
>>
>> Is it a known problem which can be avoided by upgrading the kernel to a
>> latest release?
>>
>> Best Regards,
>> Pierre-Yves Paulus
>>
>>
>> -------------------------------------------------------------------------
>> This SF.net email is sponsored by DB2 Express
>> Download DB2 Express C - the FREE version of DB2 express and take
>> control of your XML. No limits. Just data. Click to get it now.
>> http://sourceforge.net/powerbar/db2/
>> _______________________________________________
>> Bluez-devel mailing list
>> Bluez-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/bluez-devel
> 
> -------------------------------------------------------------------------
> This SF.net email is sponsored by DB2 Express
> Download DB2 Express C - the FREE version of DB2 express and take
> control of your XML. No limits. Just data. Click to get it now.
> http://sourceforge.net/powerbar/db2/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------020504030309040701030200
Content-Type: text/plain;
 name="kernel_crash_trimmed"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kernel_crash_trimmed"


root@p2a:~# uname -a
Linux p2a 2.6.21-2-486 #1 Mon Jun 25 20:09:51 UTC 2007 i686 GNU/Linux

Jul 25 16:06:35 p2a kernel: kobject_add failed for rfcomm0 with -EEXIST, don't try to register things with the same name in the same directory.
Jul 25 16:06:35 p2a kernel:  [<c01babdc>] kobject_shadow_add+0x13b/0x16d
Jul 25 16:06:35 p2a kernel:  [<c01bad94>] kobject_set_name+0x2b/0x92
Jul 25 16:06:35 p2a kernel:  [<c0217128>] device_add+0xab/0x5fb
Jul 25 16:06:35 p2a kernel:  [<c01ba8ad>] kobject_get+0xf/0x13
Jul 25 16:06:35 p2a kernel:  [<c0217b84>] device_create+0x77/0x97
Jul 25 16:06:35 p2a kernel:  [<c0201632>] tty_register_device+0xb5/0xbd
Jul 25 16:06:35 p2a kernel:  [<c01bd839>] vsnprintf+0x44f/0x48b
Jul 25 16:06:35 p2a kernel:  [<d0346627>] rfcomm_dev_ioctl+0x212/0x48f [rfcomm]
Jul 25 16:06:35 p2a kernel:  [<d034521c>] rfcomm_sock_ioctl+0x1e/0x2d [rfcomm]
Jul 25 16:06:35 p2a kernel:  [<c0235739>] sock_ioctl+0x19f/0x1be
Jul 25 16:06:35 p2a kernel:  [<c02358ab>] sys_getsockopt+0x60/0x9c
Jul 25 16:06:35 p2a kernel:  [<c023559a>] sock_ioctl+0x0/0x1be
Jul 25 16:06:35 p2a kernel:  [<c015dfc1>] do_ioctl+0x19/0x4c
Jul 25 16:06:35 p2a kernel:  [<c015e1f3>] vfs_ioctl+0x1ff/0x216
Jul 25 16:06:35 p2a kernel:  [<c015e256>] sys_ioctl+0x4c/0x66
Jul 25 16:06:35 p2a kernel:  [<c0103b90>] syscall_call+0x7/0xb
Jul 25 16:06:35 p2a kernel:  =======================
Jul 25 16:06:35 p2a kernel: BUG: unable to handle kernel NULL pointer dereference at virtual address 0000006f
Jul 25 16:06:35 p2a kernel:  printing eip:
Jul 25 16:06:35 p2a kernel: c01bb361
Jul 25 16:06:35 p2a kernel: *pde = 00000000
Jul 25 16:06:35 p2a kernel: Oops: 0000 [#1]
Jul 25 16:06:35 p2a kernel: Modules linked in: rfcomm l2cap button ac battery ipv6 dm_snapshot dm_mirror dm_mod loop tsdev snd_via82xx gameport snd_ac97_codec ac97_bus snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd evdev via82cxxx_audio uart401 rtc floppy sound pcspkr i2c_viapro via686a psmouse serio_raw soundcore i2c_isa i2c_core ac97_codec hci_usb bluetooth via_agp agpgart shpchp pci_hotplug parport_pc parport reiserfs usbhid hid 8139cp ide_disk generic 8139too mii uhci_hcd usbcore via82cxxx ide_core ata_generic libata scsi_mod thermal processor fan
Jul 25 16:06:35 p2a kernel: CPU:    0
Jul 25 16:06:35 p2a kernel: EIP:    0060:[<c01bb361>]    Not tainted VLI
Jul 25 16:06:35 p2a kernel: EFLAGS: 00010286   (2.6.21-2-486 #1)
Jul 25 16:06:35 p2a kernel: EIP is at kref_get+0x6/0x3d
Jul 25 16:06:35 p2a kernel: eax: 0000006f   ebx: 0000006f   ecx: cd02f674   edx: 00000000
Jul 25 16:06:35 p2a kernel: esi: c15a3400   edi: cee47c00   ebp: ffffffea   esp: c9a8be50
Jul 25 16:06:35 p2a kernel: ds: 007b   es: 007b   fs: 00d8  gs: 0033  ss: 0068
Jul 25 16:06:35 p2a kernel: Process hcid (pid: 31115, ti=c9a8a000 task=c4f695e0 task.ti=c9a8a000)
Jul 25 16:06:35 p2a kernel: Stack: cd02f668 00000000 00000286 c0235739 00000057 c01ba8ad c15a34b8 c0216bb4 
Jul 25 16:06:35 p2a kernel:        c0216bcd 00000000 cd02f640 c15a3400 cee47c00 cee47cf8 d0346a60 0000000a 
Jul 25 16:06:35 p2a kernel:        00000000 cee47cf8 00000000 c4f695e0 c01157a6 00100100 00200200 00000100 
Jul 25 16:06:35 p2a kernel: Call Trace:
Jul 25 16:06:35 p2a kernel:  [<c0235739>] sock_ioctl+0x19f/0x1be
Jul 25 16:06:35 p2a kernel:  [<c01ba8ad>] kobject_get+0xf/0x13
Jul 25 16:06:35 p2a kernel:  [<c0216bb4>] get_device+0xe/0x14
Jul 25 16:06:35 p2a kernel:  [<c0216bcd>] device_move+0x13/0xe2
Jul 25 16:06:35 p2a kernel:  [<d0346a60>] rfcomm_tty_open+0x17d/0x189 [rfcomm]
Jul 25 16:06:35 p2a kernel:  [<c01157a6>] default_wake_function+0x0/0xc
Jul 25 16:06:36 p2a kernel:  [<c02034c9>] tty_open+0x167/0x29b
Jul 25 16:06:36 p2a kernel:  [<c0156b8e>] chrdev_open+0xc5/0xea
Jul 25 16:06:36 p2a kernel:  [<c015d345>] open_namei+0x257/0x543
Jul 25 16:06:36 p2a kernel:  [<c0156ac9>] chrdev_open+0x0/0xea
Jul 25 16:06:36 p2a kernel:  [<c0153801>] __dentry_open+0xb7/0x16d
Jul 25 16:06:36 p2a kernel:  [<c0153931>] nameidata_to_filp+0x24/0x33
Jul 25 16:06:36 p2a kernel:  [<c0153977>] do_filp_open+0x37/0x3e
Jul 25 16:06:36 p2a kernel:  [<c0235739>] sock_ioctl+0x19f/0x1be
Jul 25 16:06:36 p2a kernel:  [<c02358ab>] sys_getsockopt+0x60/0x9c
Jul 25 16:06:36 p2a kernel:  [<c01539c4>] do_sys_open+0x46/0xcd
Jul 25 16:06:36 p2a kernel:  [<c0153a84>] sys_open+0x1c/0x1e
Jul 25 16:06:36 p2a kernel:  [<c0103b90>] syscall_call+0x7/0xb
Jul 25 16:06:36 p2a kernel:  =======================
Jul 25 16:06:36 p2a kernel: Code: cc d3 f5 ff e8 58 a3 f4 ff ff 0b 0f 94 c0 31 d2 84 c0 74 09 89 d8 ff d6 ba 01 00 00 00 83 c4 10 89 d0 5b 5e c3 53 89 c3 83 ec 10 <83> 38 00 75 29 c7 44 24 0c b9 09 2a c0 c7 44 24 08 20 00 00 00 
Jul 25 16:06:36 p2a kernel: EIP: [<c01bb361>] kref_get+0x6/0x3d SS:ESP 0068:c9a8be50
Jul 25 16:06:36 p2a kernel: l2cap_recv_acldata: Unexpected continuation frame (len 0)
Jul 25 16:06:36 p2a kernel: l2cap_recv_acldata: Unexpected continuation frame (len 0)
Jul 25 16:06:49 p2a kernel: BUG: unable to handle kernel NULL pointer dereference at virtual address 0000006f
Jul 25 16:06:49 p2a kernel:  printing eip:
Jul 25 16:06:49 p2a kernel: c01bb361
Jul 25 16:06:49 p2a kernel: *pde = 00000000
Jul 25 16:06:49 p2a kernel: Oops: 0000 [#2]
Jul 25 16:06:49 p2a kernel: Modules linked in: rfcomm l2cap button ac battery ipv6 dm_snapshot dm_mirror dm_mod loop tsdev snd_via82xx gameport snd_ac97_codec ac97_bus snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd evdev via82cxxx_audio uart401 rtc floppy sound pcspkr i2c_viapro via686a psmouse serio_raw soundcore i2c_isa i2c_core ac97_codec hci_usb bluetooth via_agp agpgart shpchp pci_hotplug parport_pc parport reiserfs usbhid hid 8139cp ide_disk generic 8139too mii uhci_hcd usbcore via82cxxx ide_core ata_generic libata scsi_mod thermal processor fan
Jul 25 16:06:49 p2a kernel: CPU:    0
Jul 25 16:06:50 p2a kernel: EIP:    0060:[<c01bb361>]    Not tainted VLI
Jul 25 16:06:50 p2a kernel: EFLAGS: 00010282   (2.6.21-2-486 #1)
Jul 25 16:06:50 p2a kernel: EIP is at kref_get+0x6/0x3d
Jul 25 16:06:50 p2a kernel: eax: 0000006f   ebx: 0000006f   ecx: d034630c   edx: 00000000
Jul 25 16:06:50 p2a kernel: esi: c9a36000   edi: 00000000   ebp: ffffffea   esp: c3929e80
Jul 25 16:06:50 p2a kernel: ds: 007b   es: 007b   fs: 00d8  gs: 0033  ss: 0068
Jul 25 16:06:50 p2a kernel: Process java (pid: 31085, ti=c3928000 task=c86e05e0 task.ti=c3928000)
Jul 25 16:06:50 p2a kernel: Stack: c0295b78 080a2000 080a2000 c0148bf5 00000057 c01ba8ad 00000000 c0216bb4 
Jul 25 16:06:50 p2a kernel:        c0216bcd 00000000 cd02f640 c9a36000 00000000 00000000 d034632f c9a36000 
Jul 25 16:06:50 p2a kernel:        ce9eaae0 c0201f96 ceb964dc d003a887 00000000 ceba1814 0000001a 00000001 
Jul 25 16:06:50 p2a kernel: Call Trace:
Jul 25 16:06:50 p2a kernel:  [<c0295b78>] schedule_timeout+0x13/0x8f
Jul 25 16:06:50 p2a kernel:  [<c0148bf5>] find_extend_vma+0x12/0x49
Jul 25 16:06:50 p2a kernel:  [<c01ba8ad>] kobject_get+0xf/0x13
Jul 25 16:06:50 p2a kernel:  [<c0216bb4>] get_device+0xe/0x14
Jul 25 16:06:50 p2a kernel:  [<c0216bcd>] device_move+0x13/0xe2
Jul 25 16:06:50 p2a kernel:  [<d034632f>] rfcomm_tty_close+0x23/0x61 [rfcomm]
Jul 25 16:06:50 p2a kernel:  [<c0201f96>] release_dev+0x1df/0x5a3
Jul 25 16:06:50 p2a kernel:  [<d003a887>] uhci_giveback_urb+0xc4/0x12f [uhci_hcd]
Jul 25 16:06:50 p2a kernel:  [<d003ab12>] uhci_scan_schedule+0x12a/0x729 [uhci_hcd]
Jul 25 16:06:50 p2a kernel:  [<c0145f11>] do_wp_page+0x147/0x372
Jul 25 16:06:50 p2a kernel:  [<c0202361>] tty_release+0x7/0xa
Jul 25 16:06:50 p2a kernel:  [<c01559bd>] __fput+0x93/0x147
Jul 25 16:06:50 p2a kernel:  [<c01536a8>] filp_close+0x51/0x58
Jul 25 16:06:50 p2a kernel:  [<c015460e>] sys_close+0x55/0x84
Jul 25 16:06:50 p2a kernel:  [<c0103b90>] syscall_call+0x7/0xb
Jul 25 16:06:50 p2a kernel:  =======================
Jul 25 16:06:50 p2a kernel: Code: cc d3 f5 ff e8 58 a3 f4 ff ff 0b 0f 94 c0 31 d2 84 c0 74 09 89 d8 ff d6 ba 01 00 00 00 83 c4 10 89 d0 5b 5e c3 53 89 c3 83 ec 10 <83> 38 00 75 29 c7 44 24 0c b9 09 2a c0 c7 44 24 08 20 00 00 00 
Jul 25 16:06:50 p2a kernel: EIP: [<c01bb361>] kref_get+0x6/0x3d SS:ESP 0068:c3929e80
Jul 25 16:06:54 p2a kernel: hci_acldata_packet: hci3 ACL packet for unknown connection handle 11
Jul 25 16:06:54 p2a last message repeated 6 times
Jul 25 16:06:55 p2a kernel: l2cap_recv_acldata: Unexpected continuation frame (len 0)
Jul 25 16:06:55 p2a last message repeated 25 times
Jul 25 16:06:55 p2a kernel: kobject_add failed for rfcomm0 with -EEXIST, don't try to register things with the same name in the same directory.
Jul 25 16:06:55 p2a kernel:  [<c01babdc>] kobject_shadow_add+0x13b/0x16d
Jul 25 16:06:55 p2a kernel:  [<c01bad94>] kobject_set_name+0x2b/0x92
Jul 25 16:06:55 p2a kernel:  [<c0217128>] device_add+0xab/0x5fb
Jul 25 16:06:55 p2a kernel:  [<c01ba8ad>] kobject_get+0xf/0x13
Jul 25 16:06:55 p2a kernel:  [<c0217b84>] device_create+0x77/0x97
Jul 25 16:06:55 p2a kernel:  [<c0201632>] tty_register_device+0xb5/0xbd
Jul 25 16:06:55 p2a kernel:  [<c01bd839>] vsnprintf+0x44f/0x48b
Jul 25 16:06:55 p2a kernel:  [<d0346627>] rfcomm_dev_ioctl+0x212/0x48f [rfcomm]
Jul 25 16:06:55 p2a kernel:  [<d034521c>] rfcomm_sock_ioctl+0x1e/0x2d [rfcomm]
Jul 25 16:06:55 p2a kernel:  [<c0235739>] sock_ioctl+0x19f/0x1be
Jul 25 16:06:55 p2a kernel:  [<c02358ab>] sys_getsockopt+0x60/0x9c
Jul 25 16:06:55 p2a kernel:  [<c023559a>] sock_ioctl+0x0/0x1be
Jul 25 16:06:55 p2a kernel:  [<c015dfc1>] do_ioctl+0x19/0x4c
Jul 25 16:06:55 p2a kernel:  [<c015e1f3>] vfs_ioctl+0x1ff/0x216
Jul 25 16:06:55 p2a kernel:  [<c015e256>] sys_ioctl+0x4c/0x66
Jul 25 16:06:55 p2a kernel:  [<c0103b90>] syscall_call+0x7/0xb
Jul 25 16:06:55 p2a kernel:  =======================
Jul 25 16:06:55 p2a kernel: BUG: unable to handle kernel NULL pointer dereference at virtual address 0000006f
Jul 25 16:06:55 p2a kernel:  printing eip:
Jul 25 16:06:55 p2a kernel: c01bb361
Jul 25 16:06:55 p2a kernel: *pde = 00000000
Jul 25 16:06:55 p2a kernel: Oops: 0000 [#3]
Jul 25 16:06:55 p2a kernel: Modules linked in: rfcomm l2cap button ac battery ipv6 dm_snapshot dm_mirror dm_mod loop tsdev snd_via82xx gameport snd_ac97_codec ac97_bus snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd evdev via82cxxx_audio uart401 rtc floppy sound pcspkr i2c_viapro via686a psmouse serio_raw soundcore i2c_isa i2c_core ac97_codec hci_usb bluetooth via_agp agpgart shpchp pci_hotplug parport_pc parport reiserfs usbhid hid 8139cp ide_disk generic 8139too mii uhci_hcd usbcore via82cxxx ide_core ata_generic libata scsi_mod thermal processor fan
Jul 25 16:06:55 p2a kernel: CPU:    0
Jul 25 16:06:55 p2a kernel: EIP:    0060:[<c01bb361>]    Not tainted VLI
Jul 25 16:06:55 p2a kernel: EFLAGS: 00010286   (2.6.21-2-486 #1)
Jul 25 16:06:55 p2a kernel: EIP is at kref_get+0x6/0x3d
Jul 25 16:06:55 p2a kernel: eax: 0000006f   ebx: 0000006f   ecx: cd02f174   edx: 00000000
Jul 25 16:06:55 p2a kernel: esi: cee42400   edi: cee47c00   ebp: ffffffea   esp: c3201e50
Jul 25 16:06:55 p2a kernel: ds: 007b   es: 007b   fs: 00d8  gs: 0033  ss: 0068
Jul 25 16:06:55 p2a kernel: Process hcid (pid: 32015, ti=c3200000 task=c03c95a0 task.ti=c3200000)
Jul 25 16:06:55 p2a kernel: Stack: cd02f168 00000000 00000286 cebd5bc0 00000057 c01ba8ad cee424b8 c0216bb4 
Jul 25 16:06:55 p2a kernel:        c0216bcd 00000000 cd02f140 cee42400 cee47c00 cee47cf8 d0346a60 0000000a 
Jul 25 16:06:55 p2a kernel:        00000000 cee47cf8 00000000 c03c95a0 c01157a6 00100100 00200200 00000100 
Jul 25 16:06:55 p2a kernel: Call Trace:
Jul 25 16:06:55 p2a kernel:  [<c01ba8ad>] kobject_get+0xf/0x13
Jul 25 16:06:55 p2a kernel:  [<c0216bb4>] get_device+0xe/0x14
Jul 25 16:06:55 p2a kernel:  [<c0216bcd>] device_move+0x13/0xe2
Jul 25 16:06:55 p2a kernel:  [<d0346a60>] rfcomm_tty_open+0x17d/0x189 [rfcomm]
Jul 25 16:06:55 p2a kernel:  [<c01157a6>] default_wake_function+0x0/0xc
Jul 25 16:06:55 p2a kernel:  [<c02034c9>] tty_open+0x167/0x29b
Jul 25 16:06:55 p2a kernel:  [<c0156b8e>] chrdev_open+0xc5/0xea
Jul 25 16:06:55 p2a kernel:  [<c015d345>] open_namei+0x257/0x543
Jul 25 16:06:55 p2a kernel:  [<c0156ac9>] chrdev_open+0x0/0xea
Jul 25 16:06:55 p2a kernel:  [<c0153801>] __dentry_open+0xb7/0x16d
Jul 25 16:06:55 p2a kernel:  [<c0153931>] nameidata_to_filp+0x24/0x33
Jul 25 16:06:55 p2a kernel:  [<c0153977>] do_filp_open+0x37/0x3e
Jul 25 16:06:55 p2a kernel:  [<c01539c4>] do_sys_open+0x46/0xcd
Jul 25 16:06:55 p2a kernel:  [<c0153a84>] sys_open+0x1c/0x1e
Jul 25 16:06:55 p2a kernel:  [<c0103b90>] syscall_call+0x7/0xb
Jul 25 16:06:55 p2a kernel:  =======================
Jul 25 16:06:55 p2a kernel: Code: cc d3 f5 ff e8 58 a3 f4 ff ff 0b 0f 94 c0 31 d2 84 c0 74 09 89 d8 ff d6 ba 01 00 00 00 83 c4 10 89 d0 5b 5e c3 53 89 c3 83 ec 10 <83> 38 00 75 29 c7 44 24 0c b9 09 2a c0 c7 44 24 08 20 00 00 00 
Jul 25 16:06:55 p2a kernel: EIP: [<c01bb361>] kref_get+0x6/0x3d SS:ESP 0068:c3201e50
Jul 25 16:06:55 p2a kernel: l2cap_recv_acldata: Unexpected continuation frame (len 0)
Jul 25 16:06:55 p2a kernel: l2cap_recv_acldata: Unexpected continuation frame (len 0)
Jul 25 16:07:11 p2a kernel: hci_acldata_packet: hci3 ACL packet for unknown connection handle 11
Jul 25 16:07:11 p2a last message repeated 6 times
Jul 25 16:07:11 p2a kernel: l2cap_recv_acldata: Unexpected continuation frame (len 0)
Jul 25 16:07:11 p2a last message repeated 27 times
Jul 25 16:07:11 p2a kernel: kobject_add failed for rfcomm0 with -EEXIST, don't try to register things with the same name in the same directory.
Jul 25 16:07:11 p2a kernel:  [<c01babdc>] kobject_shadow_add+0x13b/0x16d
Jul 25 16:07:11 p2a kernel:  [<c01bad94>] kobject_set_name+0x2b/0x92
Jul 25 16:07:11 p2a kernel:  [<c0217128>] device_add+0xab/0x5fb
Jul 25 16:07:11 p2a kernel:  [<c01ba8ad>] kobject_get+0xf/0x13
Jul 25 16:07:11 p2a kernel:  [<c0217b84>] device_create+0x77/0x97
Jul 25 16:07:11 p2a kernel:  [<c0201632>] tty_register_device+0xb5/0xbd
Jul 25 16:07:11 p2a kernel:  [<c01bd839>] vsnprintf+0x44f/0x48b
Jul 25 16:07:11 p2a kernel:  [<d0346627>] rfcomm_dev_ioctl+0x212/0x48f [rfcomm]
Jul 25 16:07:11 p2a kernel:  [<d034521c>] rfcomm_sock_ioctl+0x1e/0x2d [rfcomm]
Jul 25 16:07:11 p2a kernel:  [<c0235739>] sock_ioctl+0x19f/0x1be
Jul 25 16:07:11 p2a kernel:  [<c02358ab>] sys_getsockopt+0x60/0x9c
Jul 25 16:07:11 p2a kernel:  [<c023559a>] sock_ioctl+0x0/0x1be
Jul 25 16:07:11 p2a kernel:  [<c015dfc1>] do_ioctl+0x19/0x4c
Jul 25 16:07:11 p2a kernel:  [<c015e1f3>] vfs_ioctl+0x1ff/0x216
Jul 25 16:07:11 p2a kernel:  [<c015e256>] sys_ioctl+0x4c/0x66
Jul 25 16:07:11 p2a kernel:  [<c0103b90>] syscall_call+0x7/0xb
Jul 25 16:07:11 p2a kernel:  =======================
Jul 25 16:07:11 p2a kernel: BUG: unable to handle kernel NULL pointer dereference at virtual address 0000006f
Jul 25 16:07:11 p2a kernel:  printing eip:
Jul 25 16:07:11 p2a kernel: c01bb361
Jul 25 16:07:11 p2a kernel: *pde = 00000000
Jul 25 16:07:11 p2a kernel: Oops: 0000 [#4]
Jul 25 16:07:11 p2a kernel: Modules linked in: rfcomm l2cap button ac battery ipv6 dm_snapshot dm_mirror dm_mod loop tsdev snd_via82xx gameport snd_ac97_codec ac97_bus snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd evdev via82cxxx_audio uart401 rtc floppy sound pcspkr i2c_viapro via686a psmouse serio_raw soundcore i2c_isa i2c_core ac97_codec hci_usb bluetooth via_agp agpgart shpchp pci_hotplug parport_pc parport reiserfs usbhid hid 8139cp ide_disk generic 8139too mii uhci_hcd usbcore via82cxxx ide_core ata_generic libata scsi_mod thermal processor fan
Jul 25 16:07:11 p2a kernel: CPU:    0
Jul 25 16:07:11 p2a kernel: EIP:    0060:[<c01bb361>]    Not tainted VLI
Jul 25 16:07:11 p2a kernel: EFLAGS: 00010286   (2.6.21-2-486 #1)
Jul 25 16:07:11 p2a kernel: EIP is at kref_get+0x6/0x3d
Jul 25 16:07:11 p2a kernel: eax: 0000006f   ebx: 0000006f   ecx: cf2aac74   edx: 00000000
Jul 25 16:07:11 p2a kernel: esi: c15a3400   edi: cee47c00   ebp: ffffffea   esp: c1b87e50
Jul 25 16:07:11 p2a kernel: ds: 007b   es: 007b   fs: 00d8  gs: 0033  ss: 0068
Jul 25 16:07:11 p2a kernel: Process hcid (pid: 32132, ti=c1b86000 task=c86e00f0 task.ti=c1b86000)
Jul 25 16:07:11 p2a kernel: Stack: cf2aac68 00000000 00000286 ce438c20 00000057 c01ba8ad c15a34b8 c0216bb4 
Jul 25 16:07:11 p2a kernel:        c0216bcd 00000000 cf2aac40 c15a3400 cee47c00 cee47cf8 d0346a60 0000000a 
Jul 25 16:07:11 p2a kernel:        00000000 cee47cf8 00000000 c86e00f0 c01157a6 00100100 00200200 00000100 
Jul 25 16:07:11 p2a kernel: Call Trace:
Jul 25 16:07:11 p2a kernel:  [<c01ba8ad>] kobject_get+0xf/0x13
Jul 25 16:07:11 p2a kernel:  [<c0216bb4>] get_device+0xe/0x14
Jul 25 16:07:11 p2a kernel:  [<c0216bcd>] device_move+0x13/0xe2
Jul 25 16:07:11 p2a kernel:  [<d0346a60>] rfcomm_tty_open+0x17d/0x189 [rfcomm]
Jul 25 16:07:11 p2a kernel:  [<c01157a6>] default_wake_function+0x0/0xc
Jul 25 16:07:12 p2a kernel:  [<c02034c9>] tty_open+0x167/0x29b
Jul 25 16:07:12 p2a kernel:  [<c0156b8e>] chrdev_open+0xc5/0xea
Jul 25 16:07:12 p2a kernel:  [<c015d345>] open_namei+0x257/0x543
Jul 25 16:07:12 p2a kernel:  [<c0156ac9>] chrdev_open+0x0/0xea
Jul 25 16:07:12 p2a kernel:  [<c0153801>] __dentry_open+0xb7/0x16d
Jul 25 16:07:12 p2a kernel:  [<c0153931>] nameidata_to_filp+0x24/0x33
Jul 25 16:07:12 p2a kernel:  [<c0153977>] do_filp_open+0x37/0x3e
Jul 25 16:07:12 p2a kernel:  [<c01539c4>] do_sys_open+0x46/0xcd
Jul 25 16:07:12 p2a kernel:  [<c0153a84>] sys_open+0x1c/0x1e
Jul 25 16:07:12 p2a kernel:  [<c0103b90>] syscall_call+0x7/0xb
Jul 25 16:07:12 p2a kernel:  =======================
Jul 25 16:07:12 p2a kernel: Code: cc d3 f5 ff e8 58 a3 f4 ff ff 0b 0f 94 c0 31 d2 84 c0 74 09 89 d8 ff d6 ba 01 00 00 00 83 c4 10 89 d0 5b 5e c3 53 89 c3 83 ec 10 <83> 38 00 75 29 c7 44 24 0c b9 09 2a c0 c7 44 24 08 20 00 00 00 
Jul 25 16:07:12 p2a kernel: EIP: [<c01bb361>] kref_get+0x6/0x3d SS:ESP 0068:c1b87e50
Jul 25 16:07:12 p2a kernel: l2cap_recv_acldata: Unexpected continuation frame (len 0)
Jul 25 16:07:12 p2a kernel: l2cap_recv_acldata: Unexpected continuation frame (len 0)
Jul 25 16:07:42 p2a kernel: hci_acldata_packet: hci3 ACL packet for unknown connection handle 11
Jul 25 16:07:42 p2a last message repeated 4 times
Jul 25 16:08:04 p2a kernel: kobject_add failed for rfcomm0 with -EEXIST, don't try to register things with the same name in the same directory.
Jul 25 16:08:04 p2a kernel:  [<c01babdc>] kobject_shadow_add+0x13b/0x16d
Jul 25 16:08:04 p2a kernel:  [<c01bad94>] kobject_set_name+0x2b/0x92
Jul 25 16:08:04 p2a kernel:  [<c0217128>] device_add+0xab/0x5fb
Jul 25 16:08:04 p2a kernel:  [<c01ba8ad>] kobject_get+0xf/0x13
Jul 25 16:08:04 p2a kernel:  [<c0217b84>] device_create+0x77/0x97
Jul 25 16:08:04 p2a kernel:  [<c0201632>] tty_register_device+0xb5/0xbd
Jul 25 16:08:04 p2a kernel:  [<c01bd839>] vsnprintf+0x44f/0x48b
Jul 25 16:08:04 p2a kernel:  [<d0346627>] rfcomm_dev_ioctl+0x212/0x48f [rfcomm]
Jul 25 16:08:04 p2a kernel:  [<d034521c>] rfcomm_sock_ioctl+0x1e/0x2d [rfcomm]
Jul 25 16:08:04 p2a kernel:  [<c0235739>] sock_ioctl+0x19f/0x1be
Jul 25 16:08:04 p2a kernel:  [<c02358ab>] sys_getsockopt+0x60/0x9c
Jul 25 16:08:04 p2a kernel:  [<c023559a>] sock_ioctl+0x0/0x1be
Jul 25 16:08:04 p2a kernel:  [<c015dfc1>] do_ioctl+0x19/0x4c
Jul 25 16:08:04 p2a kernel:  [<c015e1f3>] vfs_ioctl+0x1ff/0x216
Jul 25 16:08:04 p2a kernel:  [<c015e256>] sys_ioctl+0x4c/0x66
Jul 25 16:08:04 p2a kernel:  [<c0103b90>] syscall_call+0x7/0xb
Jul 25 16:08:04 p2a kernel:  =======================
Jul 25 16:08:04 p2a kernel: BUG: unable to handle kernel NULL pointer dereference at virtual address 0000006f
Jul 25 16:08:04 p2a kernel:  printing eip:
Jul 25 16:08:04 p2a kernel: c01bb361
Jul 25 16:08:04 p2a kernel: *pde = 00000000
Jul 25 16:08:04 p2a kernel: Oops: 0000 [#5]
Jul 25 16:08:04 p2a kernel: Modules linked in: rfcomm l2cap button ac battery ipv6 dm_snapshot dm_mirror dm_mod loop tsdev snd_via82xx gameport snd_ac97_codec ac97_bus snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd evdev via82cxxx_audio uart401 rtc floppy sound pcspkr i2c_viapro via686a psmouse serio_raw soundcore i2c_isa i2c_core ac97_codec hci_usb bluetooth via_agp agpgart shpchp pci_hotplug parport_pc parport reiserfs usbhid hid 8139cp ide_disk generic 8139too mii uhci_hcd usbcore via82cxxx ide_core ata_generic libata scsi_mod thermal processor fan
Jul 25 16:08:04 p2a kernel: CPU:    0
Jul 25 16:08:04 p2a kernel: EIP:    0060:[<c01bb361>]    Not tainted VLI
Jul 25 16:08:04 p2a kernel: EFLAGS: 00010286   (2.6.21-2-486 #1)
Jul 25 16:08:04 p2a kernel: EIP is at kref_get+0x6/0x3d
Jul 25 16:08:04 p2a kernel: eax: 0000006f   ebx: 0000006f   ecx: c7202954   edx: 00000000
Jul 25 16:08:04 p2a kernel: esi: c5464000   edi: cee49800   ebp: ffffffea   esp: cae3be50
Jul 25 16:08:04 p2a kernel: ds: 007b   es: 007b   fs: 00d8  gs: 0033  ss: 0068
Jul 25 16:08:04 p2a kernel: Process hcid (pid: 32215, ti=cae3a000 task=c2c5aa30 task.ti=cae3a000)
Jul 25 16:08:04 p2a kernel: Stack: c7202948 00000000 00000286 c0235739 00000057 c01ba8ad c54640b8 c0216bb4 
Jul 25 16:08:04 p2a kernel:        c0216bcd 00000000 c7202920 c5464000 cee49800 cee498f8 d0346a60 00000009 
Jul 25 16:08:04 p2a kernel:        00000000 cee498f8 00000000 c2c5aa30 c01157a6 00100100 00200200 00000100 
Jul 25 16:08:04 p2a kernel: Call Trace:
Jul 25 16:08:04 p2a kernel:  [<c0235739>] sock_ioctl+0x19f/0x1be
Jul 25 16:08:04 p2a kernel:  [<c01ba8ad>] kobject_get+0xf/0x13
Jul 25 16:08:04 p2a kernel:  [<c0216bb4>] get_device+0xe/0x14
Jul 25 16:08:04 p2a kernel:  [<c0216bcd>] device_move+0x13/0xe2
Jul 25 16:08:04 p2a kernel:  [<d0346a60>] rfcomm_tty_open+0x17d/0x189 [rfcomm]
Jul 25 16:08:04 p2a kernel:  [<c01157a6>] default_wake_function+0x0/0xc
Jul 25 16:08:04 p2a kernel:  [<c02034c9>] tty_open+0x167/0x29b
Jul 25 16:08:04 p2a kernel:  [<c0156b8e>] chrdev_open+0xc5/0xea
Jul 25 16:08:04 p2a kernel:  [<c015d345>] open_namei+0x257/0x543
Jul 25 16:08:04 p2a kernel:  [<c0156ac9>] chrdev_open+0x0/0xea
Jul 25 16:08:04 p2a kernel:  [<c0153801>] __dentry_open+0xb7/0x16d
Jul 25 16:08:04 p2a kernel:  [<c0153931>] nameidata_to_filp+0x24/0x33
Jul 25 16:08:04 p2a kernel:  [<c0153977>] do_filp_open+0x37/0x3e
Jul 25 16:08:04 p2a kernel:  [<c0235739>] sock_ioctl+0x19f/0x1be
Jul 25 16:08:04 p2a kernel:  [<c02358ab>] sys_getsockopt+0x60/0x9c
Jul 25 16:08:04 p2a kernel:  [<c01539c4>] do_sys_open+0x46/0xcd
Jul 25 16:08:04 p2a kernel:  [<c0153a84>] sys_open+0x1c/0x1e
Jul 25 16:08:04 p2a kernel:  [<c0103b90>] syscall_call+0x7/0xb
Jul 25 16:08:05 p2a kernel:  =======================
Jul 25 16:08:05 p2a kernel: Code: cc d3 f5 ff e8 58 a3 f4 ff ff 0b 0f 94 c0 31 d2 84 c0 74 09 89 d8 ff d6 ba 01 00 00 00 83 c4 10 89 d0 5b 5e c3 53 89 c3 83 ec 10 <83> 38 00 75 29 c7 44 24 0c b9 09 2a c0 c7 44 24 08 20 00 00 00 
Jul 25 16:08:05 p2a kernel: EIP: [<c01bb361>] kref_get+0x6/0x3d SS:ESP 0068:cae3be50
Jul 25 16:08:18 p2a kernel: hci_acldata_packet: hci3 ACL packet for unknown connection handle 11
Jul 25 16:08:18 p2a last message repeated 5 times
Jul 25 16:08:18 p2a kernel: l2cap_recv_acldata: Unexpected continuation frame (len 0)
Jul 25 16:08:18 p2a kernel: l2cap_recv_acldata: Unexpected continuation frame (len 0)
Jul 25 16:08:28 p2a kernel: kobject_add failed for rfcomm0 with -EEXIST, don't try to register things with the same name in the same directory.
Jul 25 16:08:28 p2a kernel:  [<c01babdc>] kobject_shadow_add+0x13b/0x16d
Jul 25 16:08:28 p2a kernel:  [<c01bad94>] kobject_set_name+0x2b/0x92
Jul 25 16:08:28 p2a kernel:  [<c0217128>] device_add+0xab/0x5fb
Jul 25 16:08:28 p2a kernel:  [<c01ba8ad>] kobject_get+0xf/0x13
Jul 25 16:08:28 p2a kernel:  [<c0217b84>] device_create+0x77/0x97
Jul 25 16:08:28 p2a kernel:  [<c0201632>] tty_register_device+0xb5/0xbd
Jul 25 16:08:28 p2a kernel:  [<c01bd839>] vsnprintf+0x44f/0x48b
Jul 25 16:08:28 p2a kernel:  [<d0346627>] rfcomm_dev_ioctl+0x212/0x48f [rfcomm]
Jul 25 16:08:28 p2a kernel:  [<d034521c>] rfcomm_sock_ioctl+0x1e/0x2d [rfcomm]
Jul 25 16:08:28 p2a kernel:  [<c0235739>] sock_ioctl+0x19f/0x1be
Jul 25 16:08:28 p2a kernel:  [<c02358ab>] sys_getsockopt+0x60/0x9c
Jul 25 16:08:28 p2a kernel:  [<c023559a>] sock_ioctl+0x0/0x1be
Jul 25 16:08:28 p2a kernel:  [<c015dfc1>] do_ioctl+0x19/0x4c
Jul 25 16:08:28 p2a kernel:  [<c015e1f3>] vfs_ioctl+0x1ff/0x216
Jul 25 16:08:28 p2a kernel:  [<c015e256>] sys_ioctl+0x4c/0x66
Jul 25 16:08:28 p2a kernel:  [<c0103b90>] syscall_call+0x7/0xb
Jul 25 16:08:28 p2a kernel:  =======================
Jul 25 16:08:28 p2a kernel: BUG: unable to handle kernel NULL pointer dereference at virtual address 0000006f
Jul 25 16:08:28 p2a kernel:  printing eip:
Jul 25 16:08:28 p2a kernel: c01bb361
Jul 25 16:08:28 p2a kernel: *pde = 00000000
Jul 25 16:08:28 p2a kernel: Oops: 0000 [#6]
Jul 25 16:08:28 p2a kernel: Modules linked in: rfcomm l2cap button ac battery ipv6 dm_snapshot dm_mirror dm_mod loop tsdev snd_via82xx gameport snd_ac97_codec ac97_bus snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd evdev via82cxxx_audio uart401 rtc floppy sound pcspkr i2c_viapro via686a psmouse serio_raw soundcore i2c_isa i2c_core ac97_codec hci_usb bluetooth via_agp agpgart shpchp pci_hotplug parport_pc parport reiserfs usbhid hid 8139cp ide_disk generic 8139too mii uhci_hcd usbcore via82cxxx ide_core ata_generic libata scsi_mod thermal processor fan
Jul 25 16:08:28 p2a kernel: CPU:    0
Jul 25 16:08:28 p2a kernel: EIP:    0060:[<c01bb361>]    Not tainted VLI
Jul 25 16:08:28 p2a kernel: EFLAGS: 00010286   (2.6.21-2-486 #1)
Jul 25 16:08:28 p2a kernel: EIP is at kref_get+0x6/0x3d
Jul 25 16:08:28 p2a kernel: eax: 0000006f   ebx: 0000006f   ecx: c7202ad4   edx: 00000000
Jul 25 16:08:28 p2a kernel: esi: c15a3400   edi: cee49800   ebp: ffffffea   esp: c6231e50
Jul 25 16:08:28 p2a kernel: ds: 007b   es: 007b   fs: 00d8  gs: 0033  ss: 0068
Jul 25 16:08:28 p2a kernel: Process hcid (pid: 32328, ti=c6230000 task=c6cf4090 task.ti=c6230000)
Jul 25 16:08:28 p2a kernel: Stack: c7202ac8 00000000 00000286 c0235739 00000057 c01ba8ad c15a34b8 c0216bb4 
Jul 25 16:08:28 p2a kernel:        c0216bcd 00000000 c7202aa0 c15a3400 cee49800 cee498f8 d0346a60 00000009 
Jul 25 16:08:28 p2a kernel:        00000000 cee498f8 00000000 c6cf4090 c01157a6 00100100 00200200 00000100 
Jul 25 16:08:28 p2a kernel: Call Trace:
Jul 25 16:08:28 p2a kernel:  [<c0235739>] sock_ioctl+0x19f/0x1be
Jul 25 16:08:28 p2a kernel:  [<c01ba8ad>] kobject_get+0xf/0x13
Jul 25 16:08:28 p2a kernel:  [<c0216bb4>] get_device+0xe/0x14
Jul 25 16:08:28 p2a kernel:  [<c0216bcd>] device_move+0x13/0xe2
Jul 25 16:08:28 p2a kernel:  [<d0346a60>] rfcomm_tty_open+0x17d/0x189 [rfcomm]
Jul 25 16:08:28 p2a kernel:  [<c01157a6>] default_wake_function+0x0/0xc
Jul 25 16:08:28 p2a kernel:  [<c02034c9>] tty_open+0x167/0x29b
Jul 25 16:08:28 p2a kernel:  [<c0156b8e>] chrdev_open+0xc5/0xea
Jul 25 16:08:28 p2a kernel:  [<c015d345>] open_namei+0x257/0x543
Jul 25 16:08:28 p2a kernel:  [<c0156ac9>] chrdev_open+0x0/0xea
Jul 25 16:08:28 p2a kernel:  [<c0153801>] __dentry_open+0xb7/0x16d
Jul 25 16:08:28 p2a kernel:  [<c0153931>] nameidata_to_filp+0x24/0x33
Jul 25 16:08:28 p2a kernel:  [<c0153977>] do_filp_open+0x37/0x3e
Jul 25 16:08:28 p2a kernel:  [<c0235739>] sock_ioctl+0x19f/0x1be
Jul 25 16:08:28 p2a kernel:  [<c02358ab>] sys_getsockopt+0x60/0x9c
Jul 25 16:08:28 p2a kernel:  [<c01539c4>] do_sys_open+0x46/0xcd
Jul 25 16:08:28 p2a kernel:  [<c0153a84>] sys_open+0x1c/0x1e
Jul 25 16:08:28 p2a kernel:  [<c0103b90>] syscall_call+0x7/0xb
Jul 25 16:08:28 p2a kernel:  =======================
Jul 25 16:08:28 p2a kernel: Code: cc d3 f5 ff e8 58 a3 f4 ff ff 0b 0f 94 c0 31 d2 84 c0 74 09 89 d8 ff d6 ba 01 00 00 00 83 c4 10 89 d0 5b 5e c3 53 89 c3 83 ec 10 <83> 38 00 75 29 c7 44 24 0c b9 09 2a c0 c7 44 24 08 20 00 00 00 
Jul 25 16:08:28 p2a kernel: EIP: [<c01bb361>] kref_get+0x6/0x3d SS:ESP 0068:c6231e50
Jul 25 16:08:49 p2a kernel: kobject_add failed for rfcomm0 with -EEXIST, don't try to register things with the same name in the same directory.
Jul 25 16:08:49 p2a kernel:  [<c01babdc>] kobject_shadow_add+0x13b/0x16d
Jul 25 16:08:49 p2a kernel:  [<c01bad94>] kobject_set_name+0x2b/0x92
Jul 25 16:08:49 p2a kernel:  [<c0217128>] device_add+0xab/0x5fb
Jul 25 16:08:49 p2a kernel:  [<c01ba8ad>] kobject_get+0xf/0x13
Jul 25 16:08:49 p2a kernel:  [<c0217b84>] device_create+0x77/0x97
Jul 25 16:08:49 p2a kernel:  [<c0201632>] tty_register_device+0xb5/0xbd
Jul 25 16:08:49 p2a kernel:  [<c01bd839>] vsnprintf+0x44f/0x48b
Jul 25 16:08:49 p2a kernel:  [<d0346627>] rfcomm_dev_ioctl+0x212/0x48f [rfcomm]
Jul 25 16:08:49 p2a kernel:  [<d034521c>] rfcomm_sock_ioctl+0x1e/0x2d [rfcomm]
Jul 25 16:08:49 p2a kernel:  [<c0235739>] sock_ioctl+0x19f/0x1be
Jul 25 16:08:49 p2a kernel:  [<c02358ab>] sys_getsockopt+0x60/0x9c
Jul 25 16:08:49 p2a kernel:  [<c023559a>] sock_ioctl+0x0/0x1be
Jul 25 16:08:49 p2a kernel:  [<c015dfc1>] do_ioctl+0x19/0x4c
Jul 25 16:08:49 p2a kernel:  [<c015e1f3>] vfs_ioctl+0x1ff/0x216
Jul 25 16:08:49 p2a kernel:  [<c015e256>] sys_ioctl+0x4c/0x66
Jul 25 16:08:49 p2a kernel:  [<c0103b90>] syscall_call+0x7/0xb
Jul 25 16:08:49 p2a kernel:  =======================
Jul 25 16:08:49 p2a kernel: BUG: unable to handle kernel NULL pointer dereference at virtual address 0000006f
Jul 25 16:08:49 p2a kernel:  printing eip:
Jul 25 16:08:49 p2a kernel: c01bb361
Jul 25 16:08:49 p2a kernel: *pde = 00000000
Jul 25 16:08:49 p2a kernel: Oops: 0000 [#7]
Jul 25 16:08:49 p2a kernel: Modules linked in: rfcomm l2cap button ac battery ipv6 dm_snapshot dm_mirror dm_mod loop tsdev snd_via82xx gameport snd_ac97_codec ac97_bus snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd evdev via82cxxx_audio uart401 rtc floppy sound pcspkr i2c_viapro via686a psmouse serio_raw soundcore i2c_isa i2c_core ac97_codec hci_usb bluetooth via_agp agpgart shpchp pci_hotplug parport_pc parport reiserfs usbhid hid 8139cp ide_disk generic 8139too mii uhci_hcd usbcore via82cxxx ide_core ata_generic libata scsi_mod thermal processor fan
Jul 25 16:08:49 p2a kernel: CPU:    0
Jul 25 16:08:49 p2a kernel: EIP:    0060:[<c01bb361>]    Not tainted VLI
Jul 25 16:08:49 p2a kernel: EFLAGS: 00010286   (2.6.21-2-486 #1)
Jul 25 16:08:49 p2a kernel: EIP is at kref_get+0x6/0x3d
Jul 25 16:08:49 p2a kernel: eax: 0000006f   ebx: 0000006f   ecx: c471d314   edx: 00000000
Jul 25 16:08:49 p2a kernel: esi: cee4c400   edi: cee49800   ebp: ffffffea   esp: c9a8be50
Jul 25 16:08:49 p2a kernel: ds: 007b   es: 007b   fs: 00d8  gs: 0033  ss: 0068
Jul 25 16:08:49 p2a kernel: Process hcid (pid: 32432, ti=c9a8a000 task=c36ac560 task.ti=c9a8a000)
Jul 25 16:08:49 p2a kernel: Stack: c471d308 00000000 00000286 cf593c00 00000057 c01ba8ad cee4c4b8 c0216bb4 
Jul 25 16:08:49 p2a kernel:        c0216bcd 00000000 c471d2e0 cee4c400 cee49800 cee498f8 d0346a60 00000009 
Jul 25 16:08:49 p2a kernel:        00000000 cee498f8 00000000 c36ac560 c01157a6 00100100 00200200 00000100 
Jul 25 16:08:49 p2a kernel: Call Trace:
Jul 25 16:08:49 p2a kernel:  [<c01ba8ad>] kobject_get+0xf/0x13
Jul 25 16:08:49 p2a kernel:  [<c0216bb4>] get_device+0xe/0x14
Jul 25 16:08:49 p2a kernel:  [<c0216bcd>] device_move+0x13/0xe2
Jul 25 16:08:49 p2a kernel:  [<d0346a60>] rfcomm_tty_open+0x17d/0x189 [rfcomm]
Jul 25 16:08:49 p2a kernel:  [<c01157a6>] default_wake_function+0x0/0xc
Jul 25 16:08:49 p2a kernel:  [<c02034c9>] tty_open+0x167/0x29b
Jul 25 16:08:49 p2a kernel:  [<c0156b8e>] chrdev_open+0xc5/0xea
Jul 25 16:08:49 p2a kernel:  [<c015d345>] open_namei+0x257/0x543
Jul 25 16:08:49 p2a kernel:  [<c0156ac9>] chrdev_open+0x0/0xea
Jul 25 16:08:49 p2a kernel:  [<c0153801>] __dentry_open+0xb7/0x16d
Jul 25 16:08:49 p2a kernel:  [<c0153931>] nameidata_to_filp+0x24/0x33
Jul 25 16:08:49 p2a kernel:  [<c0153977>] do_filp_open+0x37/0x3e
Jul 25 16:08:49 p2a kernel:  [<c01539c4>] do_sys_open+0x46/0xcd
Jul 25 16:08:49 p2a kernel:  [<c0153a84>] sys_open+0x1c/0x1e
Jul 25 16:08:49 p2a kernel:  [<c0103b90>] syscall_call+0x7/0xb
Jul 25 16:08:49 p2a kernel:  =======================
Jul 25 16:08:49 p2a kernel: Code: cc d3 f5 ff e8 58 a3 f4 ff ff 0b 0f 94 c0 31 d2 84 c0 74 09 89 d8 ff d6 ba 01 00 00 00 83 c4 10 89 d0 5b 5e c3 53 89 c3 83 ec 10 <83> 38 00 75 29 c7 44 24 0c b9 09 2a c0 c7 44 24 08 20 00 00 00 
Jul 25 16:08:49 p2a kernel: EIP: [<c01bb361>] kref_get+0x6/0x3d SS:ESP 0068:c9a8be50
Jul 25 16:09:06 p2a kernel: hci_acldata_packet: hci3 ACL packet for unknown connection handle 11
Jul 25 16:09:06 p2a last message repeated 5 times
Jul 25 16:09:06 p2a kernel: l2cap_recv_acldata: Unexpected continuation frame (len 0)
Jul 25 16:09:06 p2a last message repeated 25 times
Jul 25 16:09:06 p2a kernel: kobject_add failed for rfcomm0 with -EEXIST, don't try to register things with the same name in the same directory.
Jul 25 16:09:06 p2a kernel:  [<c01babdc>] kobject_shadow_add+0x13b/0x16d
Jul 25 16:09:06 p2a kernel:  [<c01bad94>] kobject_set_name+0x2b/0x92
Jul 25 16:09:06 p2a kernel:  [<c0217128>] device_add+0xab/0x5fb
Jul 25 16:09:06 p2a kernel:  [<c01ba8ad>] kobject_get+0xf/0x13
Jul 25 16:09:06 p2a kernel:  [<c0217b84>] device_create+0x77/0x97
Jul 25 16:09:06 p2a kernel:  [<c0201632>] tty_register_device+0xb5/0xbd
Jul 25 16:09:06 p2a kernel:  [<c01bd839>] vsnprintf+0x44f/0x48b
Jul 25 16:09:06 p2a kernel:  [<d0346627>] rfcomm_dev_ioctl+0x212/0x48f [rfcomm]
Jul 25 16:09:06 p2a kernel:  [<d034521c>] rfcomm_sock_ioctl+0x1e/0x2d [rfcomm]
Jul 25 16:09:06 p2a kernel:  [<c0235739>] sock_ioctl+0x19f/0x1be
Jul 25 16:09:06 p2a kernel:  [<c02358ab>] sys_getsockopt+0x60/0x9c
Jul 25 16:09:06 p2a kernel:  [<c023559a>] sock_ioctl+0x0/0x1be
Jul 25 16:09:06 p2a kernel:  [<c015dfc1>] do_ioctl+0x19/0x4c
Jul 25 16:09:06 p2a kernel:  [<c015e1f3>] vfs_ioctl+0x1ff/0x216
Jul 25 16:09:06 p2a kernel:  [<c015e256>] sys_ioctl+0x4c/0x66
Jul 25 16:09:06 p2a kernel:  [<c0103b90>] syscall_call+0x7/0xb
Jul 25 16:09:06 p2a kernel:  =======================
Jul 25 16:09:06 p2a kernel: BUG: unable to handle kernel NULL pointer dereference at virtual address 0000006f
Jul 25 16:09:06 p2a kernel:  printing eip:
Jul 25 16:09:06 p2a kernel: c01bb361
Jul 25 16:09:06 p2a kernel: *pde = 00000000
Jul 25 16:09:06 p2a kernel: Oops: 0000 [#8]
Jul 25 16:09:06 p2a kernel: Modules linked in: rfcomm l2cap button ac battery ipv6 dm_snapshot dm_mirror dm_mod loop tsdev snd_via82xx gameport snd_ac97_codec ac97_bus snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd evdev via82cxxx_audio uart401 rtc floppy sound pcspkr i2c_viapro via686a psmouse serio_raw soundcore i2c_isa i2c_core ac97_codec hci_usb bluetooth via_agp agpgart shpchp pci_hotplug parport_pc parport reiserfs usbhid hid 8139cp ide_disk generic 8139too mii uhci_hcd usbcore via82cxxx ide_core ata_generic libata scsi_mod thermal processor fan
Jul 25 16:09:06 p2a kernel: CPU:    0
Jul 25 16:09:06 p2a kernel: EIP:    0060:[<c01bb361>]    Not tainted VLI
Jul 25 16:09:06 p2a kernel: EFLAGS: 00010286   (2.6.21-2-486 #1)
Jul 25 16:09:06 p2a kernel: EIP is at kref_get+0x6/0x3d
Jul 25 16:09:06 p2a kernel: eax: 0000006f   ebx: 0000006f   ecx: c471d294   edx: 00000000
Jul 25 16:09:06 p2a kernel: esi: cec96000   edi: cee47c00   ebp: ffffffea   esp: c43c9e50
Jul 25 16:09:06 p2a kernel: ds: 007b   es: 007b   fs: 00d8  gs: 0033  ss: 0068
Jul 25 16:09:06 p2a kernel: Process hcid (pid: 32531, ti=c43c8000 task=c3c255a0 task.ti=c43c8000)
Jul 25 16:09:06 p2a kernel: Stack: c471d288 00000000 00000286 c0235739 00000057 c01ba8ad cec960b8 c0216bb4 
Jul 25 16:09:06 p2a kernel:        c0216bcd 00000000 c471d260 cec96000 cee47c00 cee47cf8 d0346a60 0000000a 
Jul 25 16:09:06 p2a kernel:        00000000 cee47cf8 00000000 c3c255a0 c01157a6 00100100 00200200 00000100 
Jul 25 16:09:06 p2a kernel: Call Trace:
Jul 25 16:09:06 p2a kernel:  [<c0235739>] sock_ioctl+0x19f/0x1be
Jul 25 16:09:06 p2a kernel:  [<c01ba8ad>] kobject_get+0xf/0x13
Jul 25 16:09:06 p2a kernel:  [<c0216bb4>] get_device+0xe/0x14
Jul 25 16:09:06 p2a kernel:  [<c0216bcd>] device_move+0x13/0xe2
Jul 25 16:09:06 p2a kernel:  [<d0346a60>] rfcomm_tty_open+0x17d/0x189 [rfcomm]
Jul 25 16:09:06 p2a kernel:  [<c01157a6>] default_wake_function+0x0/0xc
Jul 25 16:09:06 p2a kernel:  [<c02034c9>] tty_open+0x167/0x29b
Jul 25 16:09:06 p2a kernel:  [<c0156b8e>] chrdev_open+0xc5/0xea
Jul 25 16:09:06 p2a kernel:  [<c015d345>] open_namei+0x257/0x543
Jul 25 16:09:06 p2a kernel:  [<c0156ac9>] chrdev_open+0x0/0xea
Jul 25 16:09:06 p2a kernel:  [<c0153801>] __dentry_open+0xb7/0x16d
Jul 25 16:09:06 p2a kernel:  [<c0153931>] nameidata_to_filp+0x24/0x33
Jul 25 16:09:06 p2a kernel:  [<c0153977>] do_filp_open+0x37/0x3e
Jul 25 16:09:06 p2a kernel:  [<c0235739>] sock_ioctl+0x19f/0x1be
Jul 25 16:09:06 p2a kernel:  [<c02358ab>] sys_getsockopt+0x60/0x9c
Jul 25 16:09:06 p2a kernel:  [<c01539c4>] do_sys_open+0x46/0xcd
Jul 25 16:09:06 p2a kernel:  [<c0153a84>] sys_open+0x1c/0x1e
Jul 25 16:09:06 p2a kernel:  [<c0103b90>] syscall_call+0x7/0xb
Jul 25 16:09:06 p2a kernel:  =======================
Jul 25 16:09:06 p2a kernel: Code: cc d3 f5 ff e8 58 a3 f4 ff ff 0b 0f 94 c0 31 d2 84 c0 74 09 89 d8 ff d6 ba 01 00 00 00 83 c4 10 89 d0 5b 5e c3 53 89 c3 83 ec 10 <83> 38 00 75 29 c7 44 24 0c b9 09 2a c0 c7 44 24 08 20 00 00 00 
Jul 25 16:09:06 p2a kernel: EIP: [<c01bb361>] kref_get+0x6/0x3d SS:ESP 0068:c43c9e50
Jul 25 16:09:08 p2a kernel: l2cap_recv_acldata: Unexpected continuation frame (len 0)
Jul 25 16:09:08 p2a kernel: l2cap_recv_acldata: Unexpected continuation frame (len 0)
Jul 25 16:09:21 p2a kernel: BUG: unable to handle kernel NULL pointer dereference at virtual address 0000006f
Jul 25 16:09:21 p2a kernel:  printing eip:
Jul 25 16:09:21 p2a kernel: c01bb361
Jul 25 16:09:21 p2a kernel: *pde = 00000000
Jul 25 16:09:21 p2a kernel: Oops: 0000 [#9]
Jul 25 16:09:21 p2a kernel: Modules linked in: rfcomm l2cap button ac battery ipv6 dm_snapshot dm_mirror dm_mod loop tsdev snd_via82xx gameport snd_ac97_codec ac97_bus snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd evdev via82cxxx_audio uart401 rtc floppy sound pcspkr i2c_viapro via686a psmouse serio_raw soundcore i2c_isa i2c_core ac97_codec hci_usb bluetooth via_agp agpgart shpchp pci_hotplug parport_pc parport reiserfs usbhid hid 8139cp ide_disk generic 8139too mii uhci_hcd usbcore via82cxxx ide_core ata_generic libata scsi_mod thermal processor fan
Jul 25 16:09:21 p2a kernel: CPU:    0
Jul 25 16:09:21 p2a kernel: EIP:    0060:[<c01bb361>]    Not tainted VLI
Jul 25 16:09:21 p2a kernel: EFLAGS: 00010286   (2.6.21-2-486 #1)
Jul 25 16:09:21 p2a kernel: EIP is at kref_get+0x6/0x3d
Jul 25 16:09:21 p2a kernel: eax: 0000006f   ebx: 0000006f   ecx: d034630c   edx: 00000000
Jul 25 16:09:21 p2a kernel: esi: c9a36000   edi: 00000000   ebp: ffffffea   esp: c9049d5c
Jul 25 16:09:21 p2a kernel: ds: 007b   es: 007b   fs: 00d8  gs: 0000  ss: 0068
Jul 25 16:09:21 p2a kernel: Process java (pid: 31163, ti=c9048000 task=c4e915e0 task.ti=c9048000)
Jul 25 16:09:21 p2a kernel: Stack: c0681ee0 00000020 00000000 c47ffc48 00000057 c01ba8ad 00000000 c0216bb4 
Jul 25 16:09:21 p2a kernel:        c0216bcd 00000000 c471d260 c9a36000 00000000 00000000 d034632f c9a36000 
Jul 25 16:09:21 p2a kernel:        c2f8c320 c0201f96 00000001 00004000 c47ffa60 0000c170 00000001 00000001 
Jul 25 16:09:21 p2a kernel: Call Trace:
Jul 25 16:09:21 p2a kernel:  [<c01ba8ad>] kobject_get+0xf/0x13
Jul 25 16:09:21 p2a kernel:  [<c0216bb4>] get_device+0xe/0x14
Jul 25 16:09:21 p2a kernel:  [<c0216bcd>] device_move+0x13/0xe2
Jul 25 16:09:21 p2a kernel:  [<d034632f>] rfcomm_tty_close+0x23/0x61 [rfcomm]
Jul 25 16:09:21 p2a kernel:  [<c0201f96>] release_dev+0x1df/0x5a3
Jul 25 16:09:21 p2a kernel:  [<c023ab31>] __alloc_skb+0x53/0xff
Jul 25 16:09:21 p2a kernel:  [<c026862f>] tcp_cwnd_application_limited+0x2f/0x83
Jul 25 16:09:21 p2a kernel:  [<c026ce48>] tcp_send_fin+0x127/0x12f
Jul 25 16:09:21 p2a kernel:  [<c0237899>] release_sock+0xc/0x83
Jul 25 16:09:21 p2a kernel:  [<c0263048>] tcp_close+0x477/0x495
Jul 25 16:09:21 p2a kernel:  [<c0102e7a>] __switch_to+0xdb/0x109
Jul 25 16:09:21 p2a kernel:  [<c0202361>] tty_release+0x7/0xa
Jul 25 16:09:21 p2a kernel:  [<c01559bd>] __fput+0x93/0x147
Jul 25 16:09:21 p2a kernel:  [<c01536a8>] filp_close+0x51/0x58
Jul 25 16:09:21 p2a kernel:  [<c01157e3>] __cond_resched+0x16/0x34
Jul 25 16:09:21 p2a kernel:  [<c0119573>] put_files_struct+0x5e/0xa6
Jul 25 16:09:21 p2a kernel:  [<c011a478>] do_exit+0x1d7/0x644
Jul 25 16:09:21 p2a kernel:  [<c0120a3b>] dequeue_signal+0xe0/0xfd
Jul 25 16:09:21 p2a kernel:  [<c011a94a>] sys_exit_group+0x0/0xd
Jul 25 16:09:21 p2a kernel:  [<c0121186>] get_signal_to_deliver+0x323/0x33c
Jul 25 16:09:21 p2a kernel:  [<c0103317>] do_notify_resume+0x83/0x5bd
Jul 25 16:09:21 p2a kernel:  [<c014611a>] do_wp_page+0x350/0x372
Jul 25 16:09:21 p2a kernel:  [<c01157a6>] default_wake_function+0x0/0xc
Jul 25 16:09:21 p2a kernel:  [<c011e2c9>] do_gettimeofday+0x2c/0xc2
Jul 25 16:09:21 p2a kernel:  [<c012ec3b>] sys_futex+0x99/0xac
Jul 25 16:09:21 p2a kernel:  [<c0103c5b>] work_notifysig+0x13/0x18
Jul 25 16:09:21 p2a kernel:  =======================
Jul 25 16:09:21 p2a kernel: Code: cc d3 f5 ff e8 58 a3 f4 ff ff 0b 0f 94 c0 31 d2 84 c0 74 09 89 d8 ff d6 ba 01 00 00 00 83 c4 10 89 d0 5b 5e c3 53 89 c3 83 ec 10 <83> 38 00 75 29 c7 44 24 0c b9 09 2a c0 c7 44 24 08 20 00 00 00 
Jul 25 16:09:21 p2a kernel: EIP: [<c01bb361>] kref_get+0x6/0x3d SS:ESP 0068:c9049d5c
Jul 25 16:09:21 p2a kernel: Fixing recursive fault but reboot is needed!

--------------020504030309040701030200
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--------------020504030309040701030200
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------020504030309040701030200--
