Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAA5m=uDQaKsBLnA1iFnU1TaA-pqUb4pAsmK9jWtMkhT9AWB25Q@mail.gmail.com>
References: <CAA5m=uDQaKsBLnA1iFnU1TaA-pqUb4pAsmK9jWtMkhT9AWB25Q@mail.gmail.com>
From: Jebb Stewart <jebb.q.stewart@noaa.gov>
Date: Wed, 10 Oct 2012 16:34:28 -0600
Message-ID: <CAA5m=uAPojU+rce0QhhUwe3N=tJRa=Jjw+YZDKVT_bTKc4vDsg@mail.gmail.com>
Subject: Problem pairing wiimote device via bluetooth
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I have an issue where I receive a kernel panic/trace messages if I
re-pair a wiimote immediately after turning the wiimote off. Whatever
is causing this problem also disables bluetooth on my system and
requires a system reboot to regain functionality.

Normally if you turn off the wiimote, eventually the /sys/devices/
.... /bluetooth/hci0/hci0:xx directory will disappear after some time.
However if you immediately re-pair the wiimote before this directory
is removed you receive the kernel trace message and bluetooth enters a
stuck state. I cannot restart the bluetooth daemon once I encounter
this problem. A system reboot is required to use a wiimote again.

The wiimote was originally paired with my Ubuntu system using the red
sync button on the back. I usually just hit the A button to activate
and re-pair the wiimote. I am running Ubuntu 12.04 64bit with
3.3.6-030306-generic kernel. I do see same problem with the default
3.2.0-29-generic kernel as well. I see similar issues if I try to pair
two different wiimotes at the same time.

Output from the syslog is below, any ideas or hints would be appreciated?

Re-pairing wiimote:

Oct 10 15:37:04 milhouse kernel: [515242.335386] wiimote
0005:057E:0306.0016: Device removed
Oct 10 15:37:06 milhouse kernel: [515244.336046] power_supply
wiimote_battery: driver failed to report `capacity' property: -5
Oct 10 15:37:09 milhouse kernel: [515247.013332] ------------[ cut
here ]------------
Oct 10 15:37:09 milhouse kernel: [515247.013341] WARNING: at
/home/apw/COD/linux/fs/sysfs/dir.c:481 sysfs_add_one+0xc1/0xf0()
Oct 10 15:37:09 milhouse kernel: [515247.013344] Hardware name:
Precision WorkStation T3400
Oct 10 15:37:09 milhouse kernel: [515247.013346] sysfs: cannot create
duplicate filename
'/devices/pci0000:00/0000:00:1a.1/usb4/4-2/4-2:1.0/bluetooth/hci0/hci0:11'
Oct 10 15:37:09 milhouse kernel: [515247.013348] Modules linked in:
ipt_MASQUERADE iptable_filter iptable_nat nf_nat nf_conntrack_ipv4
nf_conntrack nf_defrag_ipv4 ip_tables x_tables bridge stp hidp rfcomm
snd_hda_codec_analog bnep nfsd nfs lockd fscache auth_rpcgss nfs_acl
sunrpc snd_hda_intel snd_hda_codec snd_hwdep snd_pcm snd_seq_midi
snd_rawmidi snd_seq_midi_event snd_seq snd_timer snd_seq_device
nvidia(PO) snd option usb_wwan usbserial soundcore joydev hid_wiimote
x38_edac ff_memless snd_page_alloc btusb bluetooth psmouse mac_hid
dcdbas edac_core ppdev serio_raw parport_pc lp parport usbhid hid tg3
Oct 10 15:37:09 milhouse kernel: [515247.013395] Pid: 8876, comm:
kworker/u:0 Tainted: P O 3.3.6-030306-generic #201205121335
Oct 10 15:37:09 milhouse kernel: [515247.013397] Call Trace:
Oct 10 15:37:09 milhouse kernel: [515247.013403] []
warn_slowpath_common+0x7f/0xc0
Oct 10 15:37:09 milhouse kernel: [515247.013405] [] warn_slowpath_fmt+0x46/0x50
Oct 10 15:37:09 milhouse kernel: [515247.013408] [] sysfs_add_one+0xc1/0xf0
Oct 10 15:37:09 milhouse kernel: [515247.013411] [] create_dir+0x81/0xd0
Oct 10 15:37:09 milhouse kernel: [515247.013413] [] sysfs_create_dir+0x7d/0xd0
Oct 10 15:37:09 milhouse kernel: [515247.013418] []
kobject_add_internal+0xb7/0x200
Oct 10 15:37:09 milhouse kernel: [515247.013420] [] kobject_add_varg+0x38/0x60
Oct 10 15:37:09 milhouse kernel: [515247.013422] [] kobject_add+0x44/0x70
Oct 10 15:37:09 milhouse kernel: [515247.013426] [] ?
kmem_cache_alloc_trace+0xc4/0x120
Oct 10 15:37:09 milhouse kernel: [515247.013430] [] device_add+0xd0/0x520
Oct 10 15:37:09 milhouse kernel: [515247.013432] [] ?
device_private_init+0x5b/0x80
Oct 10 15:37:09 milhouse kernel: [515247.013441] []
hci_conn_add_sysfs+0x4f/0xe0 [bluetooth]
Oct 10 15:37:09 milhouse kernel: [515247.013447] []
hci_event_packet+0x18f2/0x2510 [bluetooth]
Oct 10 15:37:09 milhouse kernel: [515247.013451] [] ?
default_wake_function+0x12/0x20
Oct 10 15:37:09 milhouse kernel: [515247.013454] [] ? pollwake+0x56/0x60
Oct 10 15:37:09 milhouse kernel: [515247.013456] [] ? try_to_wake_up+0x2d0/0x2d0
Oct 10 15:37:09 milhouse kernel: [515247.013459] [] ? __wake_up_common+0x59/0x90
Oct 10 15:37:09 milhouse kernel: [515247.013462] [] ?
__wake_up_sync_key+0x5e/0x80
Oct 10 15:37:09 milhouse kernel: [515247.013465] [] ?
sock_def_readable+0x3e/0x80
Oct 10 15:37:09 milhouse kernel: [515247.013468] [] ?
sock_queue_rcv_skb+0x140/0x1d0
Oct 10 15:37:09 milhouse kernel: [515247.013474] [] ?
hci_send_to_sock+0xed/0x1d0 [bluetooth]
Oct 10 15:37:09 milhouse kernel: [515247.013480] []
hci_rx_work+0x253/0x2c0 [bluetooth]
Oct 10 15:37:09 milhouse kernel: [515247.013483] [] ?
finish_task_switch+0x53/0x100
Oct 10 15:37:09 milhouse kernel: [515247.013486] [] ? __schedule+0x3e9/0x700
Oct 10 15:37:09 milhouse kernel: [515247.013492] [] ?
hci_cmd_work+0x110/0x110 [bluetooth]
Oct 10 15:37:09 milhouse kernel: [515247.013495] [] process_one_work+0x12b/0x470
Oct 10 15:37:09 milhouse kernel: [515247.013498] [] worker_thread+0x176/0x420
Oct 10 15:37:09 milhouse kernel: [515247.013501] [] ? manage_workers+0x120/0x120
Oct 10 15:37:09 milhouse kernel: [515247.013504] [] kthread+0x9e/0xb0
Oct 10 15:37:09 milhouse kernel: [515247.013507] []
kernel_thread_helper+0x4/0x10
Oct 10 15:37:09 milhouse kernel: [515247.013509] [] ?
kthread_freezable_should_stop+0x70/0x70
Oct 10 15:37:09 milhouse kernel: [515247.013511] [] ? gs_change+0x13/0x13
Oct 10 15:37:09 milhouse kernel: [515247.013513] ---[ end trace
7d71005368e8477a ]---
Oct 10 15:37:09 milhouse kernel: [515247.013516] kobject_add_internal
failed for hci0:11 with -EEXIST, don't try to register things with the
same name in the same directory.
Oct 10 15:37:09 milhouse kernel: [515247.013519] Pid: 8876, comm:
kworker/u:0 Tainted: P W O 3.3.6-030306-generic #201205121335
Oct 10 15:37:09 milhouse kernel: [515247.013521] Call Trace:
Oct 10 15:37:09 milhouse kernel: [515247.013524] []
kobject_add_internal+0x15d/0x200
Oct 10 15:37:09 milhouse kernel: [515247.013526] [] kobject_add_varg+0x38/0x60
Oct 10 15:37:09 milhouse kernel: [515247.013528] [] kobject_add+0x44/0x70
Oct 10 15:37:09 milhouse kernel: [515247.013531] [] ?
kmem_cache_alloc_trace+0xc4/0x120
Oct 10 15:37:09 milhouse kernel: [515247.013533] [] device_add+0xd0/0x520
Oct 10 15:37:09 milhouse kernel: [515247.013535] [] ?
device_private_init+0x5b/0x80
Oct 10 15:37:09 milhouse kernel: [515247.013541] []
hci_conn_add_sysfs+0x4f/0xe0 [bluetooth]
Oct 10 15:37:09 milhouse kernel: [515247.013547] []
hci_event_packet+0x18f2/0x2510 [bluetooth]
Oct 10 15:37:09 milhouse kernel: [515247.013549] [] ?
default_wake_function+0x12/0x20
Oct 10 15:37:09 milhouse kernel: [515247.013551] [] ? pollwake+0x56/0x60
Oct 10 15:37:09 milhouse kernel: [515247.013553] [] ? try_to_wake_up+0x2d0/0x2d0
Oct 10 15:37:09 milhouse kernel: [515247.013556] [] ? __wake_up_common+0x59/0x90
Oct 10 15:37:09 milhouse kernel: [515247.013558] [] ?
__wake_up_sync_key+0x5e/0x80
Oct 10 15:37:09 milhouse kernel: [515247.013560] [] ?
sock_def_readable+0x3e/0x80
Oct 10 15:37:09 milhouse kernel: [515247.013562] [] ?
sock_queue_rcv_skb+0x140/0x1d0
Oct 10 15:37:09 milhouse kernel: [515247.013568] [] ?
hci_send_to_sock+0xed/0x1d0 [bluetooth]
Oct 10 15:37:09 milhouse kernel: [515247.013574] []
hci_rx_work+0x253/0x2c0 [bluetooth]
Oct 10 15:37:09 milhouse kernel: [515247.013576] [] ?
finish_task_switch+0x53/0x100
Oct 10 15:37:09 milhouse kernel: [515247.013578] [] ? __schedule+0x3e9/0x700
Oct 10 15:37:09 milhouse kernel: [515247.013584] [] ?
hci_cmd_work+0x110/0x110 [bluetooth]
Oct 10 15:37:09 milhouse kernel: [515247.013586] [] process_one_work+0x12b/0x470
Oct 10 15:37:09 milhouse kernel: [515247.013589] [] worker_thread+0x176/0x420
Oct 10 15:37:09 milhouse kernel: [515247.013592] [] ? manage_workers+0x120/0x120
Oct 10 15:37:09 milhouse kernel: [515247.013594] [] kthread+0x9e/0xb0
Oct 10 15:37:09 milhouse kernel: [515247.013596] []
kernel_thread_helper+0x4/0x10
Oct 10 15:37:09 milhouse kernel: [515247.013599] [] ?
kthread_freezable_should_stop+0x70/0x70
Oct 10 15:37:09 milhouse kernel: [515247.013601] [] ? gs_change+0x13/0x13
Oct 10 15:37:09 milhouse kernel: [515247.013604] Bluetooth: Failed to
register connection device

Output attempting to pair to wiimotes:

Oct 10 15:50:52 milhouse kernel: [ 302.472392] wiimote
0005:057E:0306.0005: unknown main item tag 0x0
Oct 10 15:50:52 milhouse kernel: [ 302.472636] wiimote
0005:057E:0306.0005: hidraw4: BLUETOOTH HID v3a.16 Gamepad [Nintendo
RVL-CNT-01] on 00:0A:3A:7E:3E:0A
Oct 10 15:50:52 milhouse kernel: [ 302.472676] input: Nintendo Wii
Remote Accelerometer as
/devices/pci0000:00/0000:00:1a.1/usb4/4-2/4-2:1.0/bluetooth/hci0/hci0:12/0005:057E:0306.0005/input/input10
Oct 10 15:50:52 milhouse kernel: [ 302.474275] input: Nintendo Wii
Remote IR as /devices/pci0000:00/0000:00:1a.1/usb4/4-2/4-2:1.0/bluetooth/hci0/hci0:12/0005:057E:0306.0005/input/input11
Oct 10 15:50:52 milhouse kernel: [ 302.474431] input: Nintendo Wii
Remote as /devices/pci0000:00/0000:00:1a.1/usb4/4-2/4-2:1.0/bluetooth/hci0/hci0:12/0005:057E:0306.0005/input/input12
Oct 10 15:50:52 milhouse kernel: [ 302.474494] ------------[ cut here
]------------
Oct 10 15:50:52 milhouse kernel: [ 302.474501] WARNING: at
/home/apw/COD/linux/fs/sysfs/dir.c:481 sysfs_add_one+0xc1/0xf0()
Oct 10 15:50:52 milhouse kernel: [ 302.474503] Hardware name:
Precision WorkStation T3400

Oct 10 15:50:52 milhouse kernel: [ 302.474504] sysfs: cannot create
duplicate filename '/class/power_supply/wiimote_battery'
Oct 10 15:50:52 milhouse kernel: [ 302.474505] Modules linked in:
ipt_MASQUERADE iptable_filter iptable_nat nf_nat nf_conntrack_ipv4
nf_conntrack nf_defrag_ipv4 ip_tables x_tables bridge stp hidp nfsd
nfs lockd fscache auth_rpcgss bnep nfs_acl rfcomm sunrpc
snd_hda_codec_analog option usb_wwan nvidia(PO) snd_hda_intel
snd_hda_codec usbserial snd_hwdep hid_wiimote snd_pcm joydev
snd_seq_midi ff_memless ppdev psmouse snd_rawmidi snd_seq_midi_event
snd_seq snd_timer snd_seq_device snd dcdbas parport_pc mac_hid
serio_raw soundcore snd_page_alloc x38_edac edac_core btusb bluetooth
lp parport usbhid hid tg3
Oct 10 15:50:52 milhouse kernel: [ 302.474546] Pid: 850, comm:
bluetoothd Tainted: P O 3.3.6-030306-generic #201205121335
Oct 10 15:50:52 milhouse kernel: [ 302.474548] Call Trace:
Oct 10 15:50:52 milhouse kernel: [ 302.474553] [] warn_slowpath_common+0x7f/0xc0
Oct 10 15:50:52 milhouse kernel: [ 302.474556] [] warn_slowpath_fmt+0x46/0x50
Oct 10 15:50:52 milhouse kernel: [ 302.474558] [] sysfs_add_one+0xc1/0xf0
Oct 10 15:50:52 milhouse kernel: [ 302.474561] []
sysfs_do_create_link+0x13b/0x210
Oct 10 15:50:52 milhouse kernel: [ 302.474563] [] sysfs_create_link+0x13/0x20
Oct 10 15:50:52 milhouse kernel: [ 302.474567] [] device_add+0x347/0x520
Oct 10 15:50:52 milhouse kernel: [ 302.474570] []
power_supply_register+0x100/0x140
Oct 10 15:50:52 milhouse kernel: [ 302.474576] []
wiimote_hid_probe+0x1ee/0x320 [hid_wiimote]
Oct 10 15:50:52 milhouse kernel: [ 302.474582] []
hid_device_probe+0xb5/0x130 [hid]
Oct 10 15:50:52 milhouse kernel: [ 302.474586] [] really_probe+0x68/0x190
Oct 10 15:50:52 milhouse kernel: [ 302.474588] [] driver_probe_device+0x45/0x70
Oct 10 15:50:52 milhouse kernel: [ 302.474591] [] ? __driver_attach+0xa0/0xa0
Oct 10 15:50:52 milhouse kernel: [ 302.474594] [] __device_attach+0x53/0x60
Oct 10 15:50:52 milhouse kernel: [ 302.474596] [] bus_for_each_drv+0x68/0x90
Oct 10 15:50:52 milhouse kernel: [ 302.474598] [] device_attach+0xa7/0xc0
Oct 10 15:50:52 milhouse kernel: [ 302.474601] [] bus_probe_device+0x98/0xc0
Oct 10 15:50:52 milhouse kernel: [ 302.474603] [] device_add+0x3c9/0x520
Oct 10 15:50:52 milhouse kernel: [ 302.474608] []
hid_add_device+0x7f/0x200 [hid]
Oct 10 15:50:52 milhouse kernel: [ 302.474611] []
hidp_add_connection+0x3a4/0x6b0 [hidp]
Oct 10 15:50:52 milhouse kernel: [ 302.474614] [] ? wake_up_bit+0x40/0x40
Oct 10 15:50:52 milhouse kernel: [ 302.474617] [] ? security_capable+0x18/0x20
Oct 10 15:50:52 milhouse kernel: [ 302.474620] []
hidp_sock_ioctl+0x1e3/0x2d0 [hidp]
Oct 10 15:50:52 milhouse kernel: [ 302.474623] [] ? security_sk_alloc+0x16/0x20
Oct 10 15:50:52 milhouse kernel: [ 302.474626] [] ? sk_prot_alloc+0x80/0x190
Oct 10 15:50:52 milhouse kernel: [ 302.474630] [] ?
kmem_cache_alloc_trace+0xc4/0x120
Oct 10 15:50:52 milhouse kernel: [ 302.474633] [] ?
apparmor_file_alloc_security+0x2c/0x60
Oct 10 15:50:52 milhouse kernel: [ 302.474636] [] sock_do_ioctl+0x30/0x60
Oct 10 15:50:52 milhouse kernel: [ 302.474639] [] sock_ioctl+0x79/0x2b0
Oct 10 15:50:52 milhouse kernel: [ 302.474641] [] ? sock_alloc_file+0xaf/0x130
Oct 10 15:50:52 milhouse kernel: [ 302.474644] [] do_vfs_ioctl+0x99/0x330
Oct 10 15:50:52 milhouse kernel: [ 302.474646] [] sys_ioctl+0xa1/0xb0
Oct 10 15:50:52 milhouse kernel: [ 302.474650] [] system_call_fastpath+0x16/0x1b
Oct 10 15:50:52 milhouse kernel: [ 302.474652] ---[ end trace
eb8fce2a9b482316 ]---
Oct 10 15:50:53 milhouse kernel: [ 303.472029] power_supply
wiimote_battery: driver failed to report `capacity' property: -5
Oct 10 15:50:53 milhouse kernel: [ 303.472039] wiimote
0005:057E:0306.0005: Cannot register battery device
Oct 10 15:50:53 milhouse kernel: [ 303.475556] wiimote: probe of
0005:057E:0306.0005 failed with error -17
