Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Johan Bilien <jobi@via.ecp.fr>
To: bluez-users@lists.sourceforge.net
Message-ID: <20040707130012.GC27586@via.ecp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] RFComm driver crash with MSI BToes USB dongle
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
Date: Wed, 7 Jul 2004 15:00:12 +0200

Hi,

I'm using the vanilla 2.6.7 kernel and its bluetooth system. I would
like to use my MSI BToes USB dongle to connect to my BT phone. The
devices find each other, and file transfer works fine. However, when I
try to use gnome-phone-manager, which I think uses the RFComm layer, I
get a crash in the driver once the devices have associated with each
other: 


Jul  7 14:49:01 naboo hcid[1801]: link_key_notify (sba=00:0C:76:D3:2D:DF)
Jul  7 14:49:01 naboo hcid[1801]: Replacing link key 00:0C:76:D3:2D:DF 00:0E:07:61:B6:90
Jul  7 14:49:01 naboo kernel: Unable to handle kernel paging request at virtual address 00060073
Jul  7 14:49:01 naboo kernel:  printing eip:
Jul  7 14:49:01 naboo kernel: c01b29f2
Jul  7 14:49:01 naboo kernel: *pde = 00000000
Jul  7 14:49:01 naboo kernel: Oops: 0000 [#1]
Jul  7 14:49:01 naboo kernel: PREEMPT
Jul  7 14:49:01 naboo kernel: Modules linked in: rfcomm l2cap nfsd exportfs lockd sunrpc nsc_ircc irda binfmt_misc orinoco_cs orinoco hermes ds iptable_filter ip_tables snd_cs46xx snd_rawmidi snd_seq_device snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc gameport e100 mii yenta_socket pcmcia_core nls_iso8859_1 nls_cp850 vfat fat psmouse bluetty hci_usb bluetooth usbnet crc32 md5 ipv6 usbmouse uhci_hcd usbcore apm rtc
Jul  7 14:49:01 naboo kernel: CPU:    0
Jul  7 14:49:01 naboo kernel: EIP:    0060:[vsnprintf+818/1232]    Not tainted
Jul  7 14:49:01 naboo kernel: EFLAGS: 00010297   (2.6.7)
Jul  7 14:49:01 naboo kernel: EIP is at vsnprintf+0x332/0x4d0
Jul  7 14:49:01 naboo kernel: eax: 00060073   ebx: 0000000a   ecx: 00060073   edx: fffffffe
Jul  7 14:49:01 naboo kernel: esi: c3967ea8   edi: 00000000   ebp: ffffffff   esp: c3967e38
Jul  7 14:49:01 naboo kernel: ds: 007b   es: 007b   ss: 0068
Jul  7 14:49:01 naboo kernel: Process gnome-phone-man (pid: 2882, threadinfo=c3966000 task=c3c18350)
Jul  7 14:49:01 naboo kernel: Stack: 00100100 00200200 fffffaf5 c3966000 00000246 c021aab9 00000292 00003f32
Jul  7 14:49:01 naboo kernel:        ffffffff ffffffff c3967ea8 01fb0070 00000006 d0d623c0 c01b2c68 c3967ea8
Jul  7 14:49:01 naboo kernel:        3c698158 c0291547 c3967ea4 c01b2c8f c3967ea8 c0291546 c3967ea0 c01c15c2
Jul  7 14:49:01 naboo kernel: Call Trace:
Jul  7 14:49:01 naboo kernel:  [lock_sock+41/112] lock_sock+0x29/0x70
Jul  7 14:49:01 naboo kernel:  [vsprintf+40/48] vsprintf+0x28/0x30
Jul  7 14:49:01 naboo kernel:  [sprintf+31/48] sprintf+0x1f/0x30
Jul  7 14:49:01 naboo kernel:  [tty_register_device+82/160] tty_register_device+0x52/0xa0
Jul  7 14:49:01 naboo kernel:  [vsprintf+40/48] vsprintf+0x28/0x30
Jul  7 14:49:01 naboo kernel:  [sprintf+31/48] sprintf+0x1f/0x30
Jul  7 14:49:01 naboo kernel:  [pg0+278852606/1070133248] rfcomm_dev_add+0x10e/0x2a0 [rfcomm]
Jul  7 14:49:01 naboo kernel:  [copy_from_user+83/128] copy_from_user+0x53/0x80
Jul  7 14:49:01 naboo kernel:  [pg0+278853475/1070133248] rfcomm_create_dev+0x93/0xe0 [rfcomm]
Jul  7 14:49:01 naboo kernel:  [lock_sock+41/112] lock_sock+0x29/0x70
Jul  7 14:49:01 naboo kernel:  [pg0+278851105/1070133248] rfcomm_sock_ioctl+0x31/0x50 [rfcomm]
Jul  7 14:49:01 naboo kernel:  [sock_ioctl+265/800] sock_ioctl+0x109/0x320
Jul  7 14:49:01 naboo kernel:  [sys_ioctl+256/624] sys_ioctl+0x100/0x270
Jul  7 14:49:01 naboo kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul  7 14:49:01 naboo kernel:
Jul  7 14:49:01 naboo kernel: Code: 80 38 00 74 07 40 4a 83 fa ff 75 f4 29 c8 83 e7 10 89 c3 75

Ask me if I can provide more information,

Thanks,
-- 
Johan


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
