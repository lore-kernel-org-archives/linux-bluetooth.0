Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: =?ISO-8859-1?Q?Antti_M=E4kel=E4?= <zarhan@cs.tut.fi>
To: bluez-devel@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0405111227090.9721@viherkiuru.cs.tut.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Subject: [Bluez-devel] BT3C ceased working in kernel 2.6.6
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 11 May 2004 12:30:51 +0300 (EEST)

Hi,

  I upgraded from kernel 2.6.6-rc2 to 2.6.6 and it seems that BT3C is now
broken. The driver is compiled as a module.

  The firmware is placed in /usr/lib/hotplug/firmware as it should be, an=
d
it was working in 2.6.6-rc2. The driver is compiled as a module, rest of
the system are in kernel.

  When I insert the card, I get the following in the syslog:

May 11 12:28:54 blackfell cs: memory probe 0xa0000000-0xa0ffffff: clean.
May 11 12:28:54 blackfell cardmgr[5853]: socket 1: 3Com Bluetooth PC Card
May 11 12:28:54 blackfell Unable to handle kernel NULL pointer dereferenc=
e
at virtual address 00000000
May 11 12:28:54 blackfell printing eip:
May 11 12:28:54 blackfell c018a066
May 11 12:28:54 blackfell *pde =3D 00000000
May 11 12:28:54 blackfell Oops: 0000 [#1]
May 11 12:28:54 blackfell PREEMPT
May 11 12:28:54 blackfell CPU:    0
May 11 12:28:54 blackfell EIP:    0060:[<c018a066>]    Not tainted
May 11 12:28:54 blackfell EFLAGS: 00010246   (2.6.6)
May 11 12:28:54 blackfell EIP is at object_path_length+0x26/0x40
May 11 12:28:54 blackfell eax: 00000000   ebx: 00000000   ecx: ffffffff
edx: e087e944
May 11 12:28:54 blackfell esi: 00000001   edi: 00000000   ebp: ffffffff
esp: dea7f6a8
May 11 12:28:54 blackfell ds: 007b   es: 007b   ss: 0068
May 11 12:28:54 blackfell Process cardmgr (pid: 5853, threadinfo=3Ddea7e0=
00
task=3Ddf5d8710)
May 11 12:28:54 blackfell Stack: 00000003 00000000 e087e944 c05f2b20
c018a10a e087e944 c05f2b34 c05f2b20
May 11 12:28:54 blackfell c0293a17 c0535148 df2ea6dc c05f2b80 de87f178
c05f2b80 c05f2b20 c0302221
May 11 12:28:54 blackfell de87f180 e087e944 c054973d c030253d de87f178
de87f1c0 c05f2b6c 00000000
May 11 12:28:54 blackfell Call Trace:
May 11 12:28:54 blackfell [<c018a10a>] sysfs_create_link+0x2a/0x150
May 11 12:28:54 blackfell [<c0293a17>] kobject_hotplug+0x67/0x70
May 11 12:28:54 blackfell [<c0302221>] class_device_dev_link+0x31/0x40
May 11 12:28:54 blackfell [<c030253d>] class_device_add+0xed/0x130
May 11 12:28:54 blackfell [<c03048f3>]
fw_register_class_device+0x113/0x180
May 11 12:28:54 blackfell [<c0104a98>] common_interrupt+0x18/0x20
May 11 12:28:54 blackfell [<c0304995>] fw_setup_class_device+0x35/0xd0
May 11 12:28:54 blackfell [<c0304a98>] request_firmware+0x68/0x170
May 11 12:28:54 blackfell [<e087c790>] bt3c_hci_send_frame+0x0/0x110
[bt3c_cs]
May 11 12:28:54 blackfell [<e087cd32>] bt3c_open+0xc2/0x190 [bt3c_cs]
May 11 12:28:54 blackfell [<e087d456>] bt3c_config+0x2d6/0x420 [bt3c_cs]
May 11 12:28:54 blackfell [<c02162c2>] xfs_bmap_insert_exlist+0xa2/0xc0
May 11 12:28:54 blackfell [<c0210782>] xfs_bmap_add_extent+0x422/0x4b0
May 11 12:28:54 blackfell [<c011807a>] scheduler_tick+0x28a/0x520
May 11 12:28:54 blackfell [<c0123254>] update_process_times+0x44/0x50
May 11 12:28:54 blackfell [<c012338a>] run_timer_softirq+0x10a/0x1c0
May 11 12:28:54 blackfell [<c01230c6>] update_wall_time+0x16/0x40
May 11 12:28:54 blackfell [<c0367b01>] yenta_set_mem_map+0x1a1/0x1f0
May 11 12:28:54 blackfell [<c011f2eb>] __do_softirq+0x7b/0x80
May 11 12:28:54 blackfell [<c0367b01>] yenta_set_mem_map+0x1a1/0x1f0
May 11 12:28:54 blackfell [<c0367b01>] yenta_set_mem_map+0x1a1/0x1f0
May 11 12:28:54 blackfell [<c035d720>] set_cis_map+0x40/0x120
May 11 12:28:54 blackfell [<c035d92c>] read_cis_mem+0x12c/0x1a0
May 11 12:28:54 blackfell [<c035dc23>] read_cis_cache+0x103/0x190
May 11 12:28:54 blackfell [<c014c533>] unmap_area_pmd+0x53/0x60
May 11 12:28:54 blackfell [<c011791e>] try_to_wake_up+0xae/0x160
May 11 12:28:54 blackfell [<c014c6d7>] unmap_vm_area+0x37/0x80
May 11 12:28:54 blackfell [<c011836a>] __wake_up_common+0x3a/0x70
May 11 12:28:54 blackfell [<c0360a2f>] pcmcia_align+0x9f/0xb0
May 11 12:28:54 blackfell [<c011fc59>] find_resource+0x99/0xf0
May 11 12:28:54 blackfell [<c011fd3a>] allocate_resource+0x8a/0x90
May 11 12:28:54 blackfell [<c035e52c>] pcmcia_get_next_tuple+0x24c/0x2b0
May 11 12:28:54 blackfell [<c035e00c>] pcmcia_get_first_tuple+0xbc/0x170
May 11 12:28:54 blackfell [<c0367b01>] yenta_set_mem_map+0x1a1/0x1f0
May 11 12:28:54 blackfell [<e087d678>] bt3c_event+0x78/0x100 [bt3c_cs]
May 11 12:28:54 blackfell [<c0364454>] pcmcia_register_client+0x244/0x290
May 11 12:28:54 blackfell [<c0367b01>] yenta_set_mem_map+0x1a1/0x1f0
May 11 12:28:54 blackfell [<c035d720>] set_cis_map+0x40/0x120
May 11 12:28:54 blackfell [<e087cf55>] bt3c_attach+0xf5/0x140 [bt3c_cs]
May 11 12:28:54 blackfell [<e087d600>] bt3c_event+0x0/0x100 [bt3c_cs]
May 11 12:28:54 blackfell [<c0367334>] get_pcmcia_driver+0x34/0x50
May 11 12:28:54 blackfell [<c03663aa>] bind_request+0x10a/0x230
May 11 12:28:54 blackfell [<c050643c>] xdr_sendpages+0x1fc/0x2b0
May 11 12:28:54 blackfell [<c0366f9f>] ds_ioctl+0x50f/0x630
May 11 12:28:54 blackfell [<c013a3a5>] buffered_rmqueue+0xf5/0x1d0
May 11 12:28:54 blackfell [<c013a524>] __alloc_pages+0xa4/0x320
May 11 12:28:54 blackfell [<c0144668>] do_anonymous_page+0x158/0x210
May 11 12:28:54 blackfell [<c0144782>] do_no_page+0x62/0x330
May 11 12:28:54 blackfell [<c0144c50>] handle_mm_fault+0xe0/0x180
May 11 12:28:54 blackfell [<c050d1ab>] schedule+0x32b/0x5a0
May 11 12:28:54 blackfell [<c0118421>] __wake_up_locked+0x21/0x30
May 11 12:28:54 blackfell [<c0118310>] default_wake_function+0x0/0x20
May 11 12:28:54 blackfell [<c0143043>] zap_pmd_range+0x63/0x80
May 11 12:28:54 blackfell [<c01430b3>] unmap_page_range+0x53/0x80
May 11 12:28:54 blackfell [<c01431b6>] unmap_vmas+0xd6/0x190
May 11 12:28:54 blackfell [<c01469fa>] unmap_region+0x9a/0xe0
May 11 12:28:54 blackfell [<c01468e8>] unmap_vma+0x48/0x90
May 11 12:28:54 blackfell [<c014694f>] unmap_vma_list+0x1f/0x30
May 11 12:28:54 blackfell [<c0146d8a>] do_munmap+0x14a/0x190
May 11 12:28:54 blackfell [<c050643c>] xdr_sendpages+0x1fc/0x2b0
May 11 12:28:54 blackfell [<c0164650>] sys_ioctl+0x100/0x270
May 11 12:28:54 blackfell [<c050643c>] xdr_sendpages+0x1fc/0x2b0
May 11 12:28:54 blackfell [<c0146e14>] sys_munmap+0x44/0x70
May 11 12:28:54 blackfell [<c010412b>] syscall_call+0x7/0xb
May 11 12:28:54 blackfell [<c050643c>] xdr_sendpages+0x1fc/0x2b0
May 11 12:28:54 blackfell
May 11 12:28:54 blackfell Code: f2 ae f7 d1 49 8b 52 24 8d 74 31 01 85 d2
75 ea 5b 89 f0 5e

  Waiting for a fix...thank you.


--=20
- Antti M=E4kel=E4 - http://www.cs.tut.fi/~zarhan - zarhan@cs.tut.fi -
There is a theory which states that if ever anyone discovers exactly
what the Universe is for and why it is here,it will instantly disappear
and be replaced by something even more bizarre and inexplicable.



-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
