Return-Path: <cyrus@holtmann.org>
Message-ID: <25996983.1208496894429.JavaMail.tomcat@fe-ps03>
Date: Fri, 18 Apr 2008 02:34:54 -0300 (UYT)
From: "fpml@adinet.com.uy" <fpml@adinet.com.uy>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] inconsistent lock state -> oops
Reply-To: "fpml@adinet.com.uy" <fpml@adinet.com.uy>,
	BlueZ development <bluez-devel@lists.sourceforge.net>
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

I run "speaker-test -D headset -b 100000 -t wav -w Side_Right.wav" twice.
The first run results in "inconsistent lock state", the second time it oopses:

[  149.846539] =================================
[  149.846796] [ INFO: inconsistent lock state ]
[  149.846958] 2.6.25 #1
[  149.847084] ---------------------------------
[  149.847231] inconsistent {in-softirq-W} -> {softirq-on-W} usage.
[  149.847407] speaker-test/825 [HC0[0]:SC0[0]:HE1:SE1] takes:
[  149.847555]  (&conn->lock#2){-+..}, at: [<c80290d8>] sco_chan_del+0x28/0xd0 
[sco]
[  149.848066] {in-softirq-W} state was registered at:
[  149.848217]   [<c0137d42>] __lock_acquire+0x372/0x1010
[  149.848593]   [<c0138a45>] lock_acquire+0x65/0x90
[  149.848802]   [<c02cb28a>] _spin_lock+0x1a/0x30
[  149.848802]   [<c802951f>] sco_connect_cfm+0x4f/0x220 [sco]
[  149.848802]   [<c8062668>] hci_event_packet+0x368/0x1a10 [bluetooth]
[  149.848802]   [<c805f827>] hci_rx_task+0x1e7/0x260 [bluetooth]
[  149.848802]   [<c011e548>] tasklet_action+0x38/0x80
[  149.848802]   [<c011e3b7>] __do_softirq+0x57/0xb0
[  149.848802]   [<c011e456>] do_softirq+0x46/0x50
[  149.848802]   [<c011e8c5>] irq_exit+0x65/0x80
[  149.848802]   [<c01068bd>] do_IRQ+0x4d/0x90
[  149.848802]   [<c0104eae>] common_interrupt+0x2e/0x40
[  149.848802]   [<c0102998>] cpu_idle+0x38/0x80
[  149.848802]   [<c02c4423>] rest_init+0x43/0x50
[  149.848802]   [<ffffffff>] 0xffffffff
[  149.848802] irq event stamp: 1844143
[  149.848802] hardirqs last  enabled at (1844143): [<c011e729>] 
local_bh_enable+0x89/0x100
[  149.848802] hardirqs last disabled at (1844141): [<c011e6cb>] 
local_bh_enable+0x2b/0x100
[  149.848802] softirqs last  enabled at (1844142): [<c02587cc>] 
lock_sock_nested+0x9c/0xb0
[  149.848802] softirqs last disabled at (1844140): [<c02cb2ab>] 
_spin_lock_bh+0xb/0x30
[  149.848802] 
[  149.848802] other info that might help us debug this:
[  149.848802] 1 lock held by speaker-test/825:
[  149.848802]  #0:  (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){--..}, at: 
[<c8029795>] sco_sock_close+0x15/0xa0 [sco]
[  149.848802] 
[  149.848802] stack backtrace:
[  149.848802] Pid: 825, comm: speaker-test Not tainted 2.6.25 #1
[  149.848802]  [<c013666a>] print_usage_bug+0x11a/0x130
[  149.848802]  [<c013723d>] mark_lock+0x3cd/0x530
[  149.848802]  [<c0137d88>] __lock_acquire+0x3b8/0x1010
[  149.848802]  [<c01373e0>] ? mark_held_locks+0x40/0x80
[  149.848802]  [<c0138a45>] lock_acquire+0x65/0x90
[  149.848802]  [<c80290d8>] ? sco_chan_del+0x28/0xd0 [sco]
[  149.848802]  [<c02cb28a>] _spin_lock+0x1a/0x30
[  149.848802]  [<c80290d8>] ? sco_chan_del+0x28/0xd0 [sco]
[  149.848802]  [<c80290d8>] sco_chan_del+0x28/0xd0 [sco]
[  149.848802]  [<c80297d2>] sco_sock_close+0x52/0xa0 [sco]
[  149.848802]  [<c8029841>] sco_sock_release+0x21/0xb0 [sco]
[  149.848802]  [<c0257044>] sock_release+0x14/0x60
[  149.848802]  [<c025744c>] sock_close+0x1c/0x40
[  149.848802]  [<c015ccd1>] __fput+0x91/0x160
[  149.848802]  [<c015cf58>] fput+0x18/0x20
[  149.848802]  [<c015a3fe>] filp_close+0x3e/0x70
[  149.848802]  [<c011b7b6>] put_files_struct+0xa6/0xb0
[  149.848802]  [<c011b7f7>] __exit_files+0x37/0x40
[  149.848802]  [<c011c937>] do_exit+0x147/0x680
[  149.848802]  [<c02cb502>] ? _spin_unlock_irq+0x22/0x30
[  149.848802]  [<c011ce98>] do_group_exit+0x28/0x80
[  149.848802]  [<c01249d7>] get_signal_to_deliver+0x217/0x310
[  149.848802]  [<c0103403>] do_notify_resume+0xa3/0x810
[  149.848802]  [<c02cb638>] ? _spin_unlock_irqrestore+0x38/0x40
[  149.848802]  [<c0137569>] ? trace_hardirqs_on+0xb9/0x140
[  149.848802]  [<c01167b7>] ? hrtick_set+0x87/0xc0
[  149.848802]  [<c02c9582>] ? schedule+0x182/0x2e0
[  149.848802]  [<c0103fb8>] work_notifysig+0x13/0x1b
[  149.848802]  =======================
[  150.863625] hci_scodata_packet: hci0 SCO packet for unknown connection 
handle 43
[  150.863933] hci_scodata_packet: hci0 SCO packet for unknown connection 
handle 43
[  150.864473] hci_scodata_packet: hci0 SCO packet for unknown connection 
handle 43
[  150.866830] PM: Removing info for bluetooth:sco00025B109DE4
[  150.866830] bus: 'bluetooth': remove device sco00025B109DE4
[  150.866830] kobject: 'sco00025B109DE4' (c722b9a4): kobject_uevent_env
[  150.867034] kobject: 'sco00025B109DE4' (c722b9a4): fill_kobj_path: path = 
'/devices/pci0000:00/0000:00:01.2/usb1/1-2/1-2:1.0/hci0/sco00025B109DE4'
[  150.867642] kobject: 'sco00025B109DE4' (c722b9a4): kobject_cleanup
[  150.867844] kobject: 'sco00025B109DE4' (c722b9a4): calling ktype release
[  150.868300] kobject: 'sco00025B109DE4': free name
[  157.561734] PM: Removing info for bluetooth:acl00025B109DE4
[  157.562524] bus: 'bluetooth': remove device acl00025B109DE4
[  157.562524] kobject: 'acl00025B109DE4' (c72ac9a4): kobject_uevent_env
[  157.562524] kobject: 'acl00025B109DE4' (c72ac9a4): fill_kobj_path: path = 
'/devices/pci0000:00/0000:00:01.2/usb1/1-2/1-2:1.0/hci0/acl00025B109DE4'
[  157.562524] kobject: 'acl00025B109DE4' (c72ac9a4): kobject_cleanup
[  157.562524] kobject: 'acl00025B109DE4' (c72ac9a4): calling ktype release
[  157.562524] kobject: 'acl00025B109DE4': free name
[  172.342080] device: 'acl00025B109DE4': device_add
[  172.342561] kobject: 'acl00025B109DE4' (c72feda4): kobject_add_internal: 
parent: 'hci0', set: 'devices'
[  172.343068] PM: Adding info for bluetooth:acl00025B109DE4
[  172.343316] bus: 'bluetooth': add device acl00025B109DE4
[  172.343687] kobject: 'acl00025B109DE4' (c72feda4): kobject_uevent_env
[  172.344004] kobject: 'acl00025B109DE4' (c72feda4): fill_kobj_path: path = 
'/devices/pci0000:00/0000:00:01.2/usb1/1-2/1-2:1.0/hci0/acl00025B109DE4'
[  173.511422] device: 'sco00025B109DE4': device_add
[  173.512391] kobject: 'sco00025B109DE4' (c722b9a4): kobject_add_internal: 
parent: 'hci0', set: 'devices'
[  173.513139] PM: Adding info for bluetooth:sco00025B109DE4
[  173.513361] bus: 'bluetooth': add device sco00025B109DE4
[  173.513704] kobject: 'sco00025B109DE4' (c722b9a4): kobject_uevent_env
[  173.514023] kobject: 'sco00025B109DE4' (c722b9a4): fill_kobj_path: path = 
'/devices/pci0000:00/0000:00:01.2/usb1/1-2/1-2:1.0/hci0/sco00025B109DE4'
[  180.376946] hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0004
[  180.377258] ohci_hcd 0000:00:01.2: urb c7249494 path 2 ep2in 5e160000 cc 5 
--> status -62
[  180.377592] ohci_hcd 0000:00:01.2: GetStatus roothub.portstatus [1] = 
0x00030100 PESC CSC PPS
[  180.377930] hub 1-0:1.0: port 2, status 0100, change 0003, 12 Mb/s
[  180.378100] usb 1-2: USB disconnect, address 2
[  180.378273] ohci_hcd 0000:00:01.2: urb c7249494 path 2 ep2in 5e160000 cc 5 
--> status -62
[  180.378713] usb 1-2: unregistering device
[  180.378855] usb 1-2: usb_disable_device nuking all URBs
[  180.379050] ohci_hcd 0000:00:01.2: shutdown urb c7249414 ep1in-intr
[  180.379250] ohci_hcd 0000:00:01.2: urb c7249414 path 2 ep1in 5e160000 cc 5 
--> status -62
[  180.379533] __tx_submit: hci0 tx submit failed urb c7303614 type 3 err -19
[  180.379817] ohci_hcd 0000:00:01.2: shutdown urb c7313a14 ep3out-iso
[  180.386511] __tx_submit: hci0 tx submit failed urb c7303614 type 3 err -19
[  180.386942] ohci_hcd 0000:00:01.2: shutdown urb c71f1214 ep3in-iso
[  180.393634] usb 1-2: unregistering interface 1-2:1.0
[  180.394697] device: 'usbdev1.2_ep81': device_unregister
[  180.394869] PM: Removing info for No Bus:usbdev1.2_ep81
[  180.395711] kobject: 'usbdev1.2_ep81' (c720f4e0): kobject_uevent_env
[  180.395968] kobject: 'usbdev1.2_ep81' (c720f4e0): fill_kobj_path: path = 
'/class/usb_endpoint/usbdev1.2_ep81'
[  180.396205] kobject: '1-2:1.0' (c71a8cf4): fill_kobj_path: path = 
'/devices/pci0000:00/0000:00:01.2/usb1/1-2/1-2:1.0'
[  180.396768] kobject: 'usbdev1.2_ep81' (c720f4e0): kobject_cleanup
[  180.397151] kobject: 'usbdev1.2_ep81' (c720f4e0): calling ktype release
[  180.397341] kobject: 'usbdev1.2_ep81': free name
[  180.398324] device: 'usbdev1.2_ep02': device_unregister
[  180.398483] PM: Removing info for No Bus:usbdev1.2_ep02
[  180.399427] kobject: 'usbdev1.2_ep02' (c720f8e0): kobject_uevent_env
[  180.399690] kobject: 'usbdev1.2_ep02' (c720f8e0): fill_kobj_path: path = 
'/class/usb_endpoint/usbdev1.2_ep02'
[  180.399929] kobject: '1-2:1.0' (c71a8cf4): fill_kobj_path: path = 
'/devices/pci0000:00/0000:00:01.2/usb1/1-2/1-2:1.0'
[  180.400674] kobject: 'usbdev1.2_ep02' (c720f8e0): kobject_cleanup
[  180.400847] kobject: 'usbdev1.2_ep02' (c720f8e0): calling ktype release
[  180.401006] kobject: 'usbdev1.2_ep02': free name
[  180.402016] device: 'usbdev1.2_ep82': device_unregister
[  180.402177] PM: Removing info for No Bus:usbdev1.2_ep82
[  180.403146] kobject: 'usbdev1.2_ep82' (c720fce0): kobject_uevent_env
[  180.403411] kobject: 'usbdev1.2_ep82' (c720fce0): fill_kobj_path: path = 
'/class/usb_endpoint/usbdev1.2_ep82'
[  180.403648] kobject: '1-2:1.0' (c71a8cf4): fill_kobj_path: path = 
'/devices/pci0000:00/0000:00:01.2/usb1/1-2/1-2:1.0'
[  180.404130] kobject: 'usbdev1.2_ep82' (c720fce0): kobject_cleanup
[  180.404306] kobject: 'usbdev1.2_ep82' (c720fce0): calling ktype release
[  180.404464] kobject: 'usbdev1.2_ep82': free name
[  180.405393] PM: Removing info for usb:1-2:1.0
[  180.406237] bus: 'usb': remove device 1-2:1.0
[  180.515450] PM: Removing info for bluetooth:sco00025B109DE4
[  180.515888] bus: 'bluetooth': remove device sco00025B109DE4
[  180.516068] kobject: 'sco00025B109DE4' (c722b9a4): kobject_uevent_env
[  180.516327] kobject: 'sco00025B109DE4' (c722b9a4): fill_kobj_path: path = 
'/devices/pci0000:00/0000:00:01.2/usb1/1-2/1-2:1.0/hci0/sco00025B109DE4'
[  180.516783] kobject: 'sco00025B109DE4' (c722b9a4): kobject_cleanup
[  180.516947] kobject: 'sco00025B109DE4' (c722b9a4): calling ktype release
[  180.517126] kobject: 'sco00025B109DE4': free name
[  180.517306] PM: Removing info for bluetooth:acl00025B109DE4
[  180.517712] bus: 'bluetooth': remove device acl00025B109DE4
[  180.517890] kobject: 'acl00025B109DE4' (c72feda4): kobject_uevent_env
[  180.518141] kobject: 'acl00025B109DE4' (c72feda4): fill_kobj_path: path = 
'/devices/pci0000:00/0000:00:01.2/usb1/1-2/1-2:1.0/hci0/acl00025B109DE4'
[  180.518598] kobject: 'acl00025B109DE4' (c72feda4): kobject_cleanup
[  180.518765] kobject: 'acl00025B109DE4' (c72feda4): calling ktype release
[  180.518914] kobject: 'acl00025B109DE4': free name
[  180.763913] BUG: unable to handle kernel paging request at c6781284
[  180.764172] IP: [<c025c554>] skb_release_data+0x34/0x90
[  180.764413] *pde = 01005067 *pte = 06781160 
[  180.764628] Oops: 0000 [#1] DEBUG_PAGEALLOC
[  180.764810] Modules linked in: sco rfcomm l2cap hci_usb bluetooth ohci_hcd 
usbcore atkbd
[  180.765326] 
[  180.765438] Pid: 460, comm: khubd Not tainted (2.6.25 #1)
[  180.765565] EIP: 0060:[<c025c554>] EFLAGS: 00010246 CPU: 0
[  180.765731] EIP is at skb_release_data+0x34/0x90
[  180.765877] EAX: c68aee40 EBX: 00000000 ECX: 00000000 EDX: c6781280
[  180.766017] ESI: c68aee40 EDI: c801be60 EBP: c720be10 ESP: c720be08
[  180.766157]  DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068
[  180.766299] Process khubd (pid: 460, ti=c720a000 task=c725e000 task.
ti=c720a000)
[  180.766442] Stack: 00000000 c68aee40 c720be20 c025cd2b c68aee40 00000002 
c720be2c c025c40b 
[  180.767001]        c705b000 c720be34 c025c499 c720be44 c805efa8 c7248400 
c705b000 c720be60 
[  180.767024]        c8019ec6 c8043a66 c7248000 c71a8c00 c71a8c00 c71a8c1c 
c720be74 c804666b 
[  180.767024] Call Trace:
[  180.767024]  [<c025cd2b>] ? skb_release_all+0x8b/0xf0
[  180.767024]  [<c025c40b>] ? __kfree_skb+0xb/0x80
[  180.767024]  [<c025c499>] ? kfree_skb+0x19/0x30
[  180.767024]  [<c805efa8>] ? hci_unregister_dev+0x48/0x80 [bluetooth]
[  180.767024]  [<c8019ec6>] ? hci_usb_disconnect+0x46/0x80 [hci_usb]
[  180.767024]  [<c8043a66>] ? usb_disable_interface+0x36/0x50 [usbcore]
[  180.767024]  [<c804666b>] ? usb_unbind_interface+0x3b/0x90 [usbcore]
[  180.767024]  [<c021fb49>] ? __device_release_driver+0x59/0x80
[  180.767024]  [<c021ffd0>] ? device_release_driver+0x20/0x40
[  180.767024]  [<c021efec>] ? bus_remove_device+0x7c/0xb0
[  180.767024]  [<c021d9d8>] ? device_del+0xe8/0x160
[  180.767024]  [<c8043973>] ? usb_disable_device+0xf3/0x1b0 [usbcore]
[  180.767024]  [<c803ea47>] ? usb_disconnect+0xb7/0x120 [usbcore]
[  180.767024]  [<c803ff93>] ? hub_thread+0x443/0xf00 [usbcore]
[  180.767024]  [<c02c0012>] ? unix_bind+0xd2/0x2b0
[  180.767024]  [<c0137569>] ? trace_hardirqs_on+0xb9/0x140
[  180.767024]  [<c012b6d0>] ? autoremove_wake_function+0x0/0x40
[  180.767024]  [<c803fb50>] ? hub_thread+0x0/0xf00 [usbcore]
[  180.767024]  [<c012b406>] ? kthread+0x36/0x60
[  180.767024]  [<c012b3d0>] ? kthread+0x0/0x60
[  180.767024]  [<c0105097>] ? kernel_thread_helper+0x7/0x10
[  180.767024]  =======================
[  180.767024] Code: 64 f6 c2 02 74 1f 83 e2 10 8b 80 94 00 00 00 80 fa 01 19 
d2 81 ca ff ff fe ff 89 d1 0f c1 08 01 ca 85 d2 75 27 8b 96 94 00 00 00 <66> 83 
7a 04 00 75 1e 8b 42 10 85 c0 74 08 8d 42 10 e8 86 ff ff 
[  180.767024] EIP: [<c025c554>] skb_release_data+0x34/0x90 SS:ESP 0068:
c720be08
[  180.767024] ---[ end trace 6c19ed0d6c5f8f25 ]---


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
