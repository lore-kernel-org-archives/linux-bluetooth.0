Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: Catalin Drula <catalindrula@yahoo.ca>
Date: Tue, 12 Jun 2007 11:40:52 +0000 (UTC)
Message-ID: <loom.20070612T133928-578@post.gmane.org>
Mime-Version: 1.0
Subject: [Bluez-devel] =?utf-8?q?kernel_BUG_in_2=2E6=2E20-1=2E2944=2Efc6_?=
	=?utf-8?q?=28add=5Fconn/hci=5Fsysfs=29?=
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi,

I'm seeing the following oopses and eventually a kernel panic with the 
Fedora Core 6 kernel, 2.6.20-1.2944.fc6. They seem to be originating in 
the add_conn function from net/bluetooth/hci_sysfs.c

21:51:39 kernel: kobject_add failed for acl00180FF2C406 with -EEXIST, 
don't try to register things with the same name in the same directory.
21:51:39 kernel:  [<c04e571b>] kobject_add+0x165/0x18e
21:51:39 kernel:  [<c04e58d5>] kobject_set_name+0x2b/0x92
21:51:39 kernel:  [<c054ee89>] device_add+0x8b/0x49c
21:51:39 kernel:  [<c04e53da>] kobject_release+0x0/0x8
21:51:39 kernel:  [<cf887ffe>] add_conn+0x11/0x5b [bluetooth]
21:51:39 kernel:  [<c043054e>] run_workqueue+0x85/0x125
21:51:39 kernel:  [<c0618137>] _spin_lock_irqsave+0x9/0xd
21:51:39 kernel:  [<cf887fed>] add_conn+0x0/0x5b [bluetooth]
21:51:39 kernel:  [<c0430ec7>] worker_thread+0xf9/0x124
21:51:39 kernel:  [<c041e4a2>] default_wake_function+0x0/0xc
21:51:39 kernel:  [<c0430dce>] worker_thread+0x0/0x124
21:51:39 kernel:  [<c04334db>] kthread+0xb0/0xd9
21:51:39 kernel:  [<c043342b>] kthread+0x0/0xd9
21:51:39 kernel:  [<c04051a7>] kernel_thread_helper+0x7/0x10
21:51:39 kernel:  =======================
21:51:39 kernel: add_conn: Failed to register connection device

and then a few minutes later

21:54:37 kernel: BUG: warning at lib/kref.c:32/kref_get() (Tainted: PF    
)
21:54:37 kernel:  [<c04e5f07>] kref_get+0x3d/0x46
21:54:37 kernel:  [<c04e542a>] kobject_get+0xf/0x13
21:54:37 kernel:  [<c054e902>] get_device+0x10/0x19
21:54:37 kernel:  [<c054ee0a>] device_add+0xc/0x49c
21:54:37 kernel:  [<cf887ffe>] add_conn+0x11/0x5b [bluetooth]
21:54:37 kernel:  [<c043054e>] run_workqueue+0x85/0x125
21:54:37 kernel:  [<c0618137>] _spin_lock_irqsave+0x9/0xd
21:54:37 kernel:  [<cf887fed>] add_conn+0x0/0x5b [bluetooth]
21:54:37 kernel:  [<c0430ec7>] worker_thread+0xf9/0x124
21:54:37 kernel:  [<c041e4a2>] default_wake_function+0x0/0xc
21:54:37 kernel:  [<c0430dce>] worker_thread+0x0/0x124
21:54:37 kernel:  [<c04334db>] kthread+0xb0/0xd9
21:54:37 kernel:  [<c043342b>] kthread+0x0/0xd9
21:54:37 kernel:  [<c04051a7>] kernel_thread_helper+0x7/0x10
21:54:37 kernel:  =======================
21:54:37 kernel: list_add corruption. prev->next should be next 
(c070a528), but was cd94796c. (prev=cd94796c).
21:54:37 kernel: ------------[ cut here ]------------
21:54:37 kernel: kernel BUG at lib/list_debug.c:33!
21:54:37 kernel: invalid opcode: 0000 [#1]
21:54:37 kernel: SMP
21:54:37 kernel: last sysfs file: /class/net/pan0/bridge/stp_state
21:54:37 kernel: Modules linked in: rfcomm bnep l2cap bridge 
wlan_wep(F)(U) ipv6 dm_mirror dm_mod video sbs i2c_ec dock button battery ac 
parport_pc lp parport snd_via82xx gameport snd_ac97_codec ac97_bus 
snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss 
snd_pcm snd_timer
snd_page_alloc via_ircc snd_mpu401_uart irda snd_rawmidi 
wlan_scan_sta(F)(U) snd_seq_device ath_rate_sample(F)(U) snd crc_ccitt
ath_pci(F)(U) 
i2c_viapro pcspkr wlan(F)(U) ath_hal(PF)(U) soundcore i2c_core 8139cp 
8139too mii hci_usb bluetooth serio_raw ext3 jbd ehci_hcd ohci_hcd 
uhci_hcd
21:54:37 kernel: CPU:    0
21:54:37 kernel: EIP:    0060:[<c04ea145>]    Tainted: PF     VLI
21:54:37 kernel: EFLAGS: 00010296   (2.6.20-1.2944.fc6 #1)
21:54:37 kernel: EIP is at __list_add+0x48/0x5c
21:54:37 kernel: eax: 00000061   ebx: cd94796c   ecx: c06f1a90   edx: 
00000086
21:54:37 kernel: esi: cd94796c   edi: cd9479ac   ebp: cd94799c   esp: 
c12d7ed4
21:54:37 kernel: ds: 007b   es: 007b   ss: 0068
21:54:37 kernel: Process events/0 (pid: 5, ti=c12d7000 task=c12d0030 
task.ti=c12d7000)
21:54:37 kernel: Stack: c06af8c1 c070a528 cd94796c cd94796c cd947950 
cd9478a8 c04e5663 cd9478a8
21:54:37 kernel:        cd947954 cd947954 c12d7f28 c04e58d5 fffffffe 
cddd1e84 cd9478a8 cd9478a8
21:54:37 kernel:        cd9479ac cd94799c c054ee89 cd947950 c069ba98 
cd94799c c12b2358 cd9479b4
21:54:37 kernel: Call Trace:
21:54:37 kernel:  [<c04e5663>] kobject_add+0xad/0x18e
21:54:37 kernel:  [<c04e58d5>] kobject_set_name+0x2b/0x92
21:54:37 kernel:  [<c054ee89>] device_add+0x8b/0x49c
21:54:37 kernel:  [<cf887ffe>] add_conn+0x11/0x5b [bluetooth]
21:54:37 kernel:  [<c043054e>] run_workqueue+0x85/0x125
21:54:37 kernel:  [<c0618137>] _spin_lock_irqsave+0x9/0xd
21:54:37 kernel:  [<cf887fed>] add_conn+0x0/0x5b [bluetooth]

Catalin


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
