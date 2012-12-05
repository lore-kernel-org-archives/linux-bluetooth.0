Return-Path: <cyrus@holtmann.org>
Date: Wed, 5 Dec 2012 21:45:31 +0100
From: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan
 <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: 3.6.8: BT USB with rfcomm/pppd crash on dongle pull
Message-ID: <20121205214531.3eae7aa5@milhouse>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/fsgj9BoaXdywyXaTDM4vzrI"; protocol="application/pgp-signature"
List-ID: <linux-bluetooth.vger.kernel.org>

--Sig_/fsgj9BoaXdywyXaTDM4vzrI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

The following crash happened by pulling a BT USB dongle while
an rfcomm/pppd connection was active over that dongle.

The dongle was connected to a 4-port USB hub. A usb-serial-dongle
was also connected to that hub.
The _hub_ was pulled from the host USB port. (The BT USB dongle remained in=
 the hub).


[427194.250218] usb 1-2: USB disconnect, device number 82
[427194.250243] usb 1-2.1: USB disconnect, device number 89
[427194.250688] cp210x ttyUSB0: cp210x converter now disconnected from ttyU=
SB0
[427194.250771] cp210x 1-2.1:1.0: device disconnected
[427194.251377] usb 1-2.4: USB disconnect, device number 83
[427194.251845] general protection fault: 0000 [#1] PREEMPT SMP=20
[427194.252114] Modules linked in: uvcvideo nfnetlink_log nfnetlink bridge =
stp llc cp210x nls_utf8 nls_cp437 acpi_cpufreq mperf ip6t_REJECT nf_conntra=
ck_ipv6 nf_defrag_ipv6 ip6t_rt ipt_MASQUERADE xt_conntrack ipt_REJECT xt_tc=
pudp ip6table_mangle ip6table_filter ip6_tables iptable_nat nf_nat nf_connt=
rack_ipv4 nf_defrag_ipv4 nf_conntrack iptable_mangle iptable_filter ip_tabl=
es x_tables videobuf2_vmalloc videobuf2_memops videobuf2_core i915 drm_kms_=
helper video kvm_intel kvm [last unloaded: uvcvideo]
[427194.254255] CPU 0=20
[427194.254326] Pid: 30, comm: khubd Not tainted 3.6.8+ #3 ASUSTeK Computer=
 INC. 1011PX/1015PE
[427194.254557] RIP: 0010:[<ffffffff8182e752>]  [<ffffffff8182e752>] l2cap_=
chan_destroy+0x32/0x80
[427194.254811] RSP: 0018:ffff88007c545b90  EFLAGS: 00010246
[427194.254959] RAX: dead000000200200 RBX: ffff8800263dd800 RCX: 0000000000=
000000
[427194.255051] RDX: dead000000100100 RSI: dead000000100100 RDI: dead000000=
200200
[427194.255051] RBP: ffff8800263a8900 R08: ffff88007c544000 R09: 0000000000=
000000
[427194.255051] R10: 000000000000294c R11: 0000000000000000 R12: 0000000000=
000067
[427194.255051] R13: ffff8800263a8800 R14: ffff8800263ddad0 R15: ffff880026=
3a8660
[427194.255051] FS:  0000000000000000(0000) GS:ffff88007f400000(0000) knlGS=
:0000000000000000
[427194.255051] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[427194.255051] CR2: ffffffffff600400 CR3: 0000000001e0c000 CR4: 0000000000=
0007e0
[427194.255051] DR0: 0000000000000001 DR1: 0000000000000002 DR2: 0000000000=
000001
[427194.255051] DR3: 000000000000000a DR6: 00000000ffff0ff0 DR7: 0000000000=
000400
[427194.255051] Process khubd (pid: 30, threadinfo ffff88007c544000, task f=
fff880000153b10)
[427194.255051] Stack:
[427194.255051]  ffff8800263df800 ffffffff81833530 ffff8800263dd800 fffffff=
f8182ebba
[427194.255051]  ffff8800263dd000 ffff8800263a8910 ffff8800024de578 ffff880=
0263dd000
[427194.255051]  ffff8800024de610 ffff8800024de610 ffff880005f12800 0000000=
000000000
[427194.255051] Call Trace:
[427194.255051]  [<ffffffff81833530>] ? l2cap_sock_kill+0x30/0x50
[427194.255051]  [<ffffffff8182ebba>] ? l2cap_conn_del+0xaa/0x170
[427194.255051]  [<ffffffff818329a7>] ? l2cap_disconn_cfm+0x17/0x20
[427194.255051]  [<ffffffff8181a68d>] ? hci_conn_hash_flush+0x9d/0xb0
[427194.255051]  [<ffffffff818164a4>] ? hci_dev_do_close+0xc4/0x3a0
[427194.255051]  [<ffffffff8181853f>] ? hci_unregister_dev+0x5f/0x170
[427194.255051]  [<ffffffff8163e715>] ? btusb_disconnect+0x55/0xd0
[427194.255051]  [<ffffffff8156abfa>] ? usb_unbind_interface+0x6a/0x1c0
[427194.255051]  [<ffffffff81462f37>] ? __device_release_driver+0x77/0xf0
[427194.255051]  [<ffffffff814631a9>] ? device_release_driver+0x29/0x40
[427194.255051]  [<ffffffff814629f3>] ? bus_remove_device+0xc3/0x100
[427194.255051]  [<ffffffff814602bb>] ? device_del+0x11b/0x1a0
[427194.255051]  [<ffffffff815688b4>] ? usb_disable_device+0x94/0x1e0
[427194.255051]  [<ffffffff81560bbf>] ? usb_disconnect+0x7f/0x110
[427194.255051]  [<ffffffff81560ba9>] ? usb_disconnect+0x69/0x110
[427194.255051]  [<ffffffff81562710>] ? hub_thread+0x420/0x1320
[427194.255051]  [<ffffffff819260d3>] ? __schedule+0x2a3/0x670
[427194.255051]  [<ffffffff810887f0>] ? finish_wait+0xa0/0xa0
[427194.255051]  [<ffffffff815622f0>] ? usb_remote_wakeup+0x40/0x40
[427194.255051]  [<ffffffff81087f77>] ? kthread+0x87/0x90
[427194.255051]  [<ffffffff81929074>] ? kernel_thread_helper+0x4/0x10
[427194.255051]  [<ffffffff81087ef0>] ? kthread_freezable_should_stop+0x50/=
0x50
[427194.255051]  [<ffffffff81929070>] ? gs_change+0xb/0xb
[427194.255051] Code: 80 cc ea 81 e8 20 8a 0f 00 48 be 00 01 10 00 00 00 ad=
 de 48 bf 00 02 20 00 00 00 ad de 48 8b 83 b8 02 00 00 48 8b 93 b0 02 00 00=
 <48> 89 42 08 48 89 10 48 89 bb b8 02 00 00 48 89 b3 b0 02 00 00=20
[427194.255051] RIP  [<ffffffff8182e752>] l2cap_chan_destroy+0x32/0x80
[427194.255051]  RSP <ffff88007c545b90>
[427194.349290] ---[ end trace 286151bbf87935e3 ]---
[427194.349306] note: khubd[30] exited with preempt_count 1


--=20
Greetings, Michael.

PGP encryption is encouraged / 908D8B0E

--Sig_/fsgj9BoaXdywyXaTDM4vzrI
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQv7JrAAoJEPUyvh2QjYsOAEAP/0d5ocAWpnXMAPQ+AlZ0eYTh
Sc62UvE2vI2JPRJf/YIN23X8CpcdLFcJPsvj/hWTeu3BWwlUG7xkS/I+Jeur9861
SvHOmFH/HKrBGOxrObQ5l0L5GIVPp5FnOhOzu74ASjWNChAfxa611ry+vpiCA6qi
9LepV9qt9QznZ8GBH92O8CI6+FloyKInc+7grJ5J1RTXxaH6apsq5qt95SbJXI0G
LnWZrXU1TVnqhVd6gDc3GgAHb1GkC6Y1pSuz5xUihnJ66P5lSrRC8LB20SD2qIbK
DzgoOaL1ij8z5sBSmmJCTDzE7FHcYhC8HGyvWfEm6jzGIkFGVl5f488+oC8mh9Wa
fAxAbwRnus1LYJiyGQXGCXNWB/FEmZ/BkSWDgpACy8/5Claj99E9wUTkyAXK9Yfm
udADvWy5aJD3XTnpTj3uPjKUPUDNV03EyUImt8qQv8g+aap/N84MShXC9l7ODqXW
YFmRz1GO9IAL3zk0XytxVcI0Nrm7CnDBZetZuiESJQy2cmD0Kq78Va/sCW1AxMTi
c6fH2LyOefAdv4MKPcoNXF1oTeiFcbzuQIPyODwzrNvaiyO7VP364+Ynnsy6LLdv
aEebQT2gO9ed/snzXtzFb2TZmo840dyv1l9bJTO0ZEb8tWXQ3kyNAEtxCkoghpdu
mZW1yh7rdRqPoS44MAgT
=Tsvt
-----END PGP SIGNATURE-----

--Sig_/fsgj9BoaXdywyXaTDM4vzrI--
