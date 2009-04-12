Return-Path: <cyrus@holtmann.org>
Date: Sun, 12 Apr 2009 15:07:15 +0300
From: Sami Farin <safari-kernel@safari.iki.fi>
To: Linux Bluetooth Mailing List <linux-bluetooth@vger.kernel.org>
Subject: hci_scodata_packet: hci0 SCO packet for unknown connection handle
	49
Message-ID: <20090412120715.oyfr2jcoi62mhb43@m.safari.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

While playing with Asterisk, after it had been running for ~30 seconds,
I think I moved my mobile phone a bit and lost connection.
Asterisk said "pbx_dundi.c:1989: socket_read Error: bad file descriptor"
a couple dozen times a second.
Before this error command "mobile show devices" showed the mobile phone OK.

I started getting messages about hci_scodata_packet and little after
that I was not able to do anything in asterisk (just hard disk
crunching).  X was totally unusable (mouse cursor not moving, screen
not updating).  Sysrq worked, but I was not able to restart X.

I have kernel 2.6.28.9 SMP x86_64, bluez-4.34, asterisk-addons latest
svn, asterisk-1.6.1.0.21.rc1 (Fedora).
Someone had similar errors reported at
http://bugs.digium.com/view.php?id=13911&nbn=10

Bus 004 Device 002: ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth Dongle (HCI mode)

<3>[1279571.573912] btusb_isoc_complete: hci0 corrupted SCO packet
<3>[1279571.573931] hci_scodata_packet: hci0 SCO packet for unknown connection handle 49
<3>[1279571.573936] hci_scodata_packet: hci0 SCO packet for unknown connection handle 0
<3>[1279571.573939] hci_scodata_packet: hci0 SCO packet for unknown connection handle 0
<3>[1279571.573942] hci_scodata_packet: hci0 SCO packet for unknown connection handle 0
<3>[1279571.573945] hci_scodata_packet: hci0 SCO packet for unknown connection handle 0
<3>[1279571.573948] hci_scodata_packet: hci0 SCO packet for unknown connection handle 0
<3>[1279576.724642] hci_scodata_packet: hci0 SCO packet for unknown connection handle 46
<3>[1279576.724651] hci_scodata_packet: hci0 SCO packet for unknown connection handle 46
<3>[1279576.724655] hci_scodata_packet: hci0 SCO packet for unknown connection handle 46
<3>[1279576.724658] hci_scodata_packet: hci0 SCO packet for unknown connection handle 46
<6>[1279753.344703] SysRq : SAK
<5>[1279753.344736] SAK: killed process 5227 (X): task_session_nr(p)==tty->session
<5>[1279753.345060] SAK: killed process 5227 (X): task_session_nr(p)==tty->session
<6>[1279867.746301] SysRq : Show Regs
<6>[1279867.746382] CPU 0:
<4>[1279867.746385] Modules linked in: hidp rfcomm btusb bridge stp llc bnep sco i915 xt_NOTRACK xt_CLASSIFY ipt_ECN xt_CONNMARK xt_connlimit xt_length ipt_set xt_multiport ip_set_iptreemap ip_set_nethash ip_set_portmap nf_conntrack_netlink nfnetlink ipt_REJECT ip6t_LOG xt_limit ipt_LOG xt_hashlimit xt_owner nf_conntrack_ipv4 nf_defrag_ipv4 xt_state xt_tcpudp ip6table_filter ip6table_mangle ip6_tables iptable_filter iptable_mangle iptable_raw ip_tables tcp_highspeed tcp_htcp tcp_hybla tcp_scalable tcp_vegas tcp_westwood ip_set sch_netem sch_hfsc sch_htb sch_sfq cls_fw cls_u32 cls_route sch_ingress sch_red sch_tbf sch_teql sch_prio sch_gred cls_rsvp cls_rsvp6 cls_tcindex sch_cbq sch_dsmark rtc_cmos oprofile nf_conntrack xt_TARPIT x_tables dccp_diag dccp e1000 cmtp kernelcapi l2cap bluetooth intelfb i2c_algo_bit i810 lp i2c_dev ftdi_sio usbserial usb_storage ohci_hcd irlan irda crc_ccitt binfmt_misc loop dm_mod video rfkill input_polldev battery ac tcp_cubic snd_hda_intel snd_seq_dummy 
snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device dvb_usb_af9015 tda18271 snd_pcm_oss af9013 dvb_pll mt2060 mxl5005s i2c_i801 dvb_usb dvb_core qt1010 snd_mixer_oss pcspkr ppdev i2c_core parport_pc snd_pcm parport ohci1394 ieee1394 ehci_hcd uhci_hcd iTCO_wdt iTCO_vendor_support snd_timer snd soundcore e1000e button snd_page_alloc
<6>[1279867.746509] Pid: 26326, comm: asterisk Not tainted 2.6.28.9 #16
<6>[1279867.746512] RIP: 0033:[<0000003000c7c8d8>]  [<0000003000c7c8d8>] 0x3000c7c8d8
<6>[1279867.746524] RSP: 002b:0000000002e07ce0  EFLAGS: 00000246
<6>[1279867.746526] RAX: 0000000000000000 RBX: 0000000002e07d90 RCX: 0000000000000000
<6>[1279867.746529] RDX: 0000000000000001 RSI: 0000000000000009 RDI: 0000000000000001
<6>[1279867.746532] RBP: 0000000002e07d90 R08: fefefefefefefeff R09: 0000000000000000
<6>[1279867.746535] R10: 0000000000000000 R11: 000000300b80aa90 R12: 0000000000000001
<6>[1279867.746537] R13: 0000000000000000 R14: 0000000002e09f60 R15: 0000000002e07f60
<6>[1279867.746541] FS:  0000000002e0a910(0063) GS:ffffffff809f2080(0000) knlGS:0000000000000000
<6>[1279867.746544] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<6>[1279867.746546] CR2: 00007fa7b9bcb138 CR3: 000000005554a000 CR4: 00000000000006e0
<6>[1279867.746550] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
<6>[1279867.746553] DR3: 0000000000000000 DR6: 00000000ffff4ff0 DR7: 0000000000000400
<4>[1279867.746555] Call Trace:
<6>[1279871.890954] SysRq : Show Blocked State
<6>[1279871.891001]   task                        PC stack   pid father
<6>[1279871.891001] kswapd0       D 0000000000000064     0   303      2
<4>[1279871.891001]  ffff8800bd557d00 0000000000000046 ffff880001024908 ffff880001024880
<4>[1279871.891001]  ffff8800bdbc2e68 ffff8800bd557ca0 ffff880001024880 ffff8800bdbc2e30
<4>[1279871.891001]  ffff8800bd557c80 ffff8800bdb92f60 ffffffff809dd000 ffff8800bdb92f60
<4>[1279871.891001] Call Trace:
<4>[1279871.891001]  [<ffffffff80249ffb>] ? __mod_timer+0xbb/0xe0
<4>[1279871.891001]  [<ffffffff8071ad20>] schedule_timeout+0x80/0x100
<4>[1279871.891001]  [<ffffffff80249bd0>] ? process_timeout+0x0/0x10
<4>[1279871.891001]  [<ffffffff80719f17>] io_schedule_timeout+0x37/0x50
<4>[1279871.891001]  [<ffffffff8029b2d0>] congestion_wait+0x70/0x90
<4>[1279871.891001]  [<ffffffff80255e80>] ? autoremove_wake_function+0x0/0x40
<4>[1279871.891001]  [<ffffffff80298e52>] kswapd+0x402/0x700
<4>[1279871.891001]  [<ffffffff802965c0>] ? isolate_pages_global+0x0/0x240
<4>[1279871.891001]  [<ffffffff80255e80>] ? autoremove_wake_function+0x0/0x40
<4>[1279871.891001]  [<ffffffff80298a50>] ? kswapd+0x0/0x700
<4>[1279871.891001]  [<ffffffff80255a3d>] kthread+0x4d/0x90
<4>[1279871.891001]  [<ffffffff8020c899>] child_rip+0xa/0x11
<4>[1279871.891001]  [<ffffffff802559f0>] ? kthread+0x0/0x90
<4>[1279871.891001]  [<ffffffff8020c88f>] ? child_rip+0x0/0x11
<6>[1279871.891001] restorecond   D ffff8800a94e7c18     0 26091   2799
<4>[1279871.891001]  ffff8800a94e7b68 0000000000000082 ffffffff804090e0 ffff8800bbcb7980
<4>[1279871.891001]  0000000000000000 ffff8800a94e7b08 ffffe20001afb0b8 000000000056254d
<4>[1279871.891001]  0000000000004000 ffff88002817bc40 ffffffff809dd000 ffff88002817bc40
<4>[1279871.891001] Call Trace:
<4>[1279871.891001]  [<ffffffff804090e0>] ? xfs_get_blocks+0x0/0x20
<4>[1279871.891001]  [<ffffffff8046fb6d>] ? blk_unplug+0x3d/0x70
<4>[1279871.891001]  [<ffffffff8028bb10>] ? sync_page_killable+0x0/0x40
<4>[1279871.891001]  [<ffffffff8071a967>] io_schedule+0x37/0x50
<4>[1279871.891001]  [<ffffffff8028baf5>] sync_page+0x45/0x60
<4>[1279871.891001]  [<ffffffff8028bb1e>] sync_page_killable+0xe/0x40
<4>[1279871.891001]  [<ffffffff8071ae5a>] __wait_on_bit_lock+0x5a/0xc0
<4>[1279871.891001]  [<ffffffff8028ba17>] __lock_page_killable+0x67/0x70
<4>[1279871.891001]  [<ffffffff80255ec0>] ? wake_bit_function+0x0/0x50
<4>[1279871.891001]  [<ffffffff8028b8ae>] ? find_get_page+0x1e/0xb0
<4>[1279871.891001]  [<ffffffff8028db8d>] generic_file_aio_read+0x38d/0x670
<4>[1279871.891001]  [<ffffffff802c767d>] ? __link_path_walk+0xe0d/0xf80
<4>[1279871.891001]  [<ffffffff80412475>] xfs_read+0x125/0x2a0
<4>[1279871.891001]  [<ffffffff8071cda9>] ? _spin_lock+0x9/0x20
<4>[1279871.891001]  [<ffffffff8040d8ac>] ? xfs_file_open+0x1c/0x40
<4>[1279871.891001]  [<ffffffff8040d7f3>] xfs_file_aio_read+0x53/0x60
<4>[1279871.891001]  [<ffffffff802bb8ba>] do_sync_read+0xfa/0x140
<4>[1279871.891001]  [<ffffffff802b9df7>] ? nameidata_to_filp+0x47/0x60
<4>[1279871.891001]  [<ffffffff80255e80>] ? autoremove_wake_function+0x0/0x40
<4>[1279871.891001]  [<ffffffff80420b16>] ? security_file_permission+0x16/0x20
<4>[1279871.891001]  [<ffffffff802bc445>] vfs_read+0xb5/0x160
<4>[1279871.891001]  [<ffffffff802bc5e1>] sys_read+0x51/0x90
<4>[1279871.891001]  [<ffffffff80277683>] ? audit_syscall_exit+0x2e3/0x340
<4>[1279871.891001]  [<ffffffff8020b93b>] system_call_fastpath+0x16/0x1b
<6>[1279871.891001] asterisk      D ffff8800579d9d08     0 26282  14840
<4>[1279871.891001]  ffff8800579d9c68 0000000000000086 ffff8800579d9be8 ffffffff8046fb6d
<4>[1279871.891001]  ffff8800579d9be8 ffff8800579d9c08 ffff8800be047240 0500000000000000
<4>[1279871.891001]  0000000000000001 ffff8800a3cc5a80 ffffffff809dd000 ffff8800a3cc5a80
<4>[1279871.891001] Call Trace:
<4>[1279871.891001]  [<ffffffff8046fb6d>] ? blk_unplug+0x3d/0x70
<4>[1279871.891001]  [<ffffffff804865aa>] ? __up_read+0x9a/0xc0
<4>[1279871.891001]  [<ffffffff8028bab0>] ? sync_page+0x0/0x60
<4>[1279871.891001]  [<ffffffff8071a967>] io_schedule+0x37/0x50
<4>[1279871.891001]  [<ffffffff8028baf5>] sync_page+0x45/0x60
<4>[1279871.891001]  [<ffffffff8071ae5a>] __wait_on_bit_lock+0x5a/0xc0
<4>[1279871.891001]  [<ffffffff8029537c>] ? drain_cpu_pagevecs+0xac/0xb0
<4>[1279871.891001]  [<ffffffff8028ba87>] __lock_page+0x67/0x70
<4>[1279871.891001]  [<ffffffff80255ec0>] ? wake_bit_function+0x0/0x50
<4>[1279871.891001]  [<ffffffff8029f4a0>] handle_mm_fault+0x8b0/0x8d0
<4>[1279871.891001]  [<ffffffff80229434>] do_page_fault+0x2c4/0x940
<4>[1279871.891001]  [<ffffffff80255e80>] ? autoremove_wake_function+0x0/0x40
<4>[1279871.891001]  [<ffffffff802353fb>] ? __dequeue_entity+0x2b/0x50
<4>[1279871.891001]  [<ffffffff80420b16>] ? security_file_permission+0x16/0x20
<4>[1279871.891001]  [<ffffffff802bb95d>] ? rw_verify_area+0x5d/0xc0
<4>[1279871.891001]  [<ffffffff802bc1b8>] ? vfs_write+0xb8/0x160
<4>[1279871.891001]  [<ffffffff8071d179>] error_exit+0x0/0x51
<6>[1279871.891001] asterisk      D ffffffff807300e0     0 26326  14840
<4>[1279871.891001]  ffff880040bf3eb8 0000000000000086 0000000000000000 0000001a00000001
<4>[1279871.891001]  ffff880000200001 ffff880040bf3e58 ffff8800a3cc5850 ffff8800bd43abb0
<4>[1279871.891001]  0000000140bf3e48 ffff8800bd43ade0 ffffffff809dd000 ffff8800bd43ade0
<4>[1279871.891001] Call Trace:
<4>[1279871.891001]  [<ffffffff8020a055>] ? __switch_to+0x315/0x480
<4>[1279871.891001]  [<ffffffff8071cb2d>] __down_write_nested+0x7d/0xb0
<4>[1279871.891001]  [<ffffffff8071cb6b>] __down_write+0xb/0x10
<4>[1279871.891001]  [<ffffffff8071bd8f>] down_write+0x2f/0x40
<4>[1279871.891001]  [<ffffffff802a4e70>] sys_brk+0x40/0x140
<4>[1279871.891001]  [<ffffffff8020b93b>] system_call_fastpath+0x16/0x1b
task_fair+0x1ad/0x1c0
<4>[1279872.604001]  [<ffffffff802353fb>] ? __dequeue_entity+0x2b/0x50
<4>[1279872.604001]  [<ffffffff80255e80>] ? autoremove_wake_function+0x0/0x40
<4>[1279872.604001]  [<ffffffff805ed3d0>] ? hub_thread+0x0/0x1020
<4>[1279872.604001]  [<ffffffff80255a3d>] kthread+0x4d/0x90
<4>[1279872.604001]  [<ffffffff8020c899>] child_rip+0xa/0x11
<4>[1279872.604001]  [<ffffffff802559f0>] ? kthread+0x0/0x90
<4>[1279872.604001]  [<ffffffff8020c88f>] ? child_rip+0x0/0x11
<6>[1279872.604001] kseriod       S ffffffff807300e0     0   236      2
<4>[1279872.604001]  ffff8800bd473eb0 0000000000000046 00000000ffffffed 0000000000000282
<4>[1279872.604001]  ffff8800bd473e30 ffff8800bd473e50 ffff8800bcc284d0 ffffffff80939d30
<4>[1279872.604001]  00000000bd473e70 ffff8800bd4d6480 ffffffff809dd000 ffff8800bd4d6480
<4>[1279872.604001] Call Trace:
<4>[1279872.604001]  [<ffffffff80539380>] ? __driver_attach+0x0/0xb0
<4>[1279872.604001]  [<ffffffff805ff7c6>] serio_thread+0x356/0x400
<4>[1279872.604001]  [<ffffffff80255e80>] ? autoremove_wake_function+0x0/0x40
<4>[1279872.604001]  [<ffffffff805ff470>] ? serio_thread+0x0/0x400
<4>[1279872.604001]  [<ffffffff80255a3d>] kthread+0x4d/0x90
<4>[1279872.604001]  [<ffffffff8020c899>] child_rip+0xa/0x11
<4>[1279872.604001]  [<ffffffff802559f0>] ? kthread+0x0/0x90
<4>[1279872.604001]  [<ffffffff8020c88f>] ? child_rip+0x0/0x11
<6>[1279872.604001] kswapd0       D 0000000000000064     0   303      2
<4>[1279872.604001]  ffff8800bd557d00 0000000000000046 ffff880001024908 ffff880001024880
<4>[1279872.604001]  ffff8800bdbc2e68 ffff8800bd557ca0 ffff880001024880 ffff8800bdbc2e30
<4>[1279872.604001]  ffff8800bd557c80 ffff8800bdb92f60 ffffffff809dd000 ffff8800bdb92f60
<4>[1279872.604001] Call Trace:
<4>[1279872.604001]  [<ffffffff80249ffb>] ? __mod_timer+0xbb/0xe0
<4>[1279872.604001]  [<ffffffff8071ad20>] schedule_timeout+0x80/0x100
<4>[1279872.604001]  [<ffffffff80249bd0>] ? process_timeout+0x0/0x10
<4>[1279872.604001]  [<ffffffff80719f17>] io_schedule_timeout+0x37/0x50
<4>[1279872.604001]  [<ffffffff8029b2d0>] congestion_wait+0x70/0x90
<4>[1279872.604001]  [<ffffffff80255e80>] ? autoremove_wake_function+0x0/0x40
<4>[1279872.604001]  [<ffffffff80298e52>] kswapd+0x402/0x700
<4>[1279872.604001]  [<ffffffff802965c0>] ? isolate_pages_global+0x0/0x240
<4>[1279872.604001]  [<ffffffff80255e80>] ? autoremove_wake_function+0x0/0x40
<4>[1279872.604001]  [<ffffffff80298a50>] ? kswapd+0x0/0x700
<4>[1279872.604001]  [<ffffffff80255a3d>] kthread+0x4d/0x90
<4>[1279872.604001]  [<ffffffff8020c899>] child_rip+0xa/0x11
<4>[1279872.604001]  [<ffffffff802559f0>] ? kthread+0x0/0x90
<4>[1279872.604001]  [<ffffffff8020c88f>] ? child_rip+0x0/0x11
<6>[1279872.604001] aio/0         S ffff8800bd4b22c0     0   304      2
<4>[1279872.604001]  ffff8800bd589ec0 0000000000000046 ffff8800bd589e20 ffffffff802353fb
<4>[1279872.604001]  ffff8800be0f9138 ffff8800bd589e60 ffff880001024880 ffffffff808ed020
<4>[1279872.604001]  ffffffff809b7a80 ffff8800bdbf6b50 ffffffff809dd000 ffff8800bdbf6b50
<4>[1279872.604001] Call Trace:
<4>[1279872.604001]  [<ffffffff802353fb>] ? __dequeue_entity+0x2b/0x50
<4>[1279872.604001]  [<ffffffff80251835>] worker_thread+0xe5/0x120
<4>[1279872.604001]  [<ffffffff80255e80>] ? autoremove_wake_function+0x0/0x40
<4>[1279872.604001]  [<ffffffff80251750>] ? worker_thread+0x0/0x120
<4>[1279872.604001]  [<ffffffff80251750>] ? worker_thread+0x0/0x120
<4>[1279872.604001]  [<ffffffff80255a3d>] kthread+0x4d/0x90
<4>[1279872.604001]  [<ffffffff8020c899>] child_rip+0xa/0x11
<4>[1279872.604001]  [<ffffffff802559f0>] ? kthread+0x0/0x90
<4>[1279872.604001]  [<ffffffff8020c88f>] ? child_rip+0x0/0x11
<6>[1279872.604001] aio/1         S ffffffff807300e0     0   305      2
<4>[1279872.604001]  ffff8800bd58bec0 0000000000000046 ffff8800bd58be20 ffffffff802353fb
<4>[1279872.604001]  ffff8800be0f9138 ffff8800bd58be60 ffff880001030880 ffffffff808ed020
<4>[1279872.604001]  0000000100000000 ffff8800bdbf65c0 ffffffff809dd000 ffff8800bdbf65c0
<4>[1279872.604001] Call Trace:
<4>[1279872.604001]  [<ffffffff802353fb>] ? __dequeue_entity+0x2b/0x50
<4>[1279872.604001]  [<ffffffff80251835>] worker_thread+0xe5/0x120
<4>[1279872.604001]  [<ffffffff80255e80>] ? autoremove_wake_function+0x0/0x40
<4>[1279872.604001]  [<ffffffff80251750>] ? worker_thread+0x0/0x120
<4>[1279872.604001]  [<ffffffff80251750>] ? worker_thread+0x0/0x120
<4>[1279872.604001]  [<ffffffff80255a3d>] kthread+0x4d/0x90
<4>[1279872.604001]  [<ffffffff8020c899>] child_rip+0xa/0x11
<4>[1279872.604001]  [<ffffffff802559f0>] ? kthread+0x0/0x90
<4>[1279872.604001]  [<ffffffff8020c88f>] ? child_rip+0x0/0x11
<6>[1279872.604001] xfs_mru_cache S ffffffff807300e0     0   306      2
<4>[1279872.604001]  ffff8800bd5cbec0 0000000000000046 ffff8800bd5cbe20 ffffffff802353fb
<4>[1279872.604001]  ffff8800be0f9138 ffff8800bd5cbe60 ffff880001024880 ffffffff808ed020
<4>[1279872.604001]  00000000809b7a80 ffff8800bd403c40 ffffffff809dd000 ffff8800bd403c40
<4>[1279872.604001] Call Trace:
<4>[1279872.604001]  [<ffffffff802353fb>] ? __dequeue_entity+0x2b/0x50
<4>[1279872.604001]  [<ffffffff80251835>] worker_thread+0xe5/0x120
<4>[1279872.604001]  [<ffffffff80255e80>] ? autoremove_wake_function+0x0/0x40
<4>[1279872.604001]  [<ffffffff80251750>] ? worker_thread+0x0/0x120
<4>[1279872.604001]  [<ffffffff80251750>] ? worker_thread+0x0/0x120
<4>[1279872.604001]  [<ffffffff80255a3d>] kthread+0x4d/0x90
<4>[1279872.604001]  [<ffffffff8020c899>] child_rip+0xa/0x11
<4>[1279872.604001]  [<ffffffff802559f0>] ? kthread+0x0/0x90
<4>[1279872.604001]  [<ffffffff8020c88f>] ? child_rip+0x0/0x11
<6>[1279872.604001] xfslogd/0     S ffff8800bd5b89c0     0   307      2
<4>[1279872.604001]  ffff8800bd5cdec0 0000000000000046 ffff8800bd5cde10 ffffffff8040cef4
<4>[1279872.604001]  ffff8800bd5cde70 ffff8800bd5cde60 ffff8800ba83d980 ffff88008e891200
<4>[1279872.604001]  ffff88008e891a00 ffff8800bd491470 ffffffff809dd000 ffff8800bd491470
<4>[1279872.604001] Call Trace:
<4>[1279872.604001]  [<ffffffff8040cef4>] ? xfs_buf_ioend+0x84/0xc0
<4>[1279872.604001]  [<ffffffff8040ce00>] ? xfs_buf_iodone_work+0x30/0xa0
<4>[1279872.604001]  [<ffffffff80251835>] worker_thread+0xe5/0x120
<4>[1279872.604001]  [<ffffffff80255e80>] ? autoremove_wake_function+0x0/0x40
<4>[1279872.604001]  [<ffffffff80251750>] ? worker_thread+0x0/0x120
<4>[1279872.604001]  [<ffffffff80251750>] ? worker_thread+0x0/0x120
<4>[1279872.604001]  [<ffffffff80255a3d>] kthread+0x4d/0x90
<4>[1279872.604001]  [<ffffffff8020c899>] child_rip+0xa/0x11
<4>[1279872.604001]  [<ffffffff802559f0>] ? kthread+0x0/0x90
<4>[1279872.604001]  [<ffffffff8020c88f>] ? child_rip+0x0/0x11
<6>[1279872.604001] xfslogd/1     S ffffffff807300e0     0   308      2
<4>[1279872.604001]  ffff8800bd5cfec0 0000000000000046 ffff8800af93e200 ffff880093df6508
<4>[1279872.604001]  ffff8800af93e278 ffff8800bd5cfe60 ffff8800bd5cfe40 ffffffff8040c287
<4>[1279872.604001]  00000001af93e200 ffff8800bd490ee0 ffffffff809dd000 ffff8800bd490ee0
<4>[1279872.604001] Call Trace:
<4>[1279872.604001]  [<ffffffff8040c287>] ? xfs_buf_free+0x67/0xa0
<4>[1279872.604001]  [<ffffffff8040ce2c>] ? xfs_buf_iodone_work+0x5c/0xa0
<4>[1279872.604001]  [<ffffffff80251835>] worker_thread+0xe5/0x120
<4>[1279872.604001]  [<ffffffff80255e80>] ? autoremove_wake_function+0x0/0x40
<4>[1279872.604001]  [<ffffffff80251750>] ? worker_thread+0x0/0x120
<4>[1279872.604001]  [<ffffffff80251750>] ? worker_thread+0x0/0x120
<4>[1279872.604001]  [<ffffffff80255a3d>] kthread+0x4d/0x90
<4>[1279872.604001]  [<ffffffff8020c899>] child_rip+0xa/0x11
<4>[1279872.604001]  [<ffffffff802559f0>] ? kthread+0x0/0x90
<4>[1279872.604001]  [<ffffffff8020c88f>] ? child_rip+0x0/0x11
<6>[1279872.604001] xfsdatad/0    S ffff8800bd5b8740     0   309      2
<4>[1279872.604001]  ffff8800bd5d1ec0 0000000000000046 ffff880067f97310 ffff8800bd5b8748
<4>[1279872.604001]  ffff8800bd5b8748 ffff8800bd5d1e60 ffff8800bd5d1e30 ffffffff8028dfc7
<4>[1279872.604001]  ffff8800bd5d1e50 ffff8800bd490950 ffffffff809dd000 ffff8800bd490950
<4>[1279872.604001] Call Trace:
<4>[1279872.604001]  [<ffffffff8028dfc7>] ? mempool_free_slab+0x17/0x20
<4>[1279872.604001]  [<ffffffff80408cc0>] ? xfs_end_bio_written+0x0/0x30
<4>[1279872.604001]  [<ffffffff80408ce2>] ? xfs_end_bio_written+0x22/0x30
<4>[1279872.604001]  [<ffffffff80251835>] worker_thread+0xe5/0x120
<4>[1279872.604001]  [<ffffffff80255e80>] ? autoremove_wake_function+0x0/0x40
<4>[1279872.604001]  [<ffffffff80251750>] ? worker_thread+0x0/0x120
<4>[1279872.604001]  [<ffffffff80251750>] ? worker_thread+0x0/0x120
<4>[1279872.604001]  [<ffffffff80255a3d>] kthread+0x4d/0x90
<4>[1279872.604001]  [<ffffffff8020c899>] child_rip+0xa/0x11
<4>[1279872.604001]  [<ffffffff802559f0>] ? kthread+0x0/0x90
<4>[1279872.604001]  [<ffffffff8020c88f>] ? child_rip+0x0/0x11
<6>[1279872.604001] xfsdatad/1    S ffff8800bd5b86c0     0   310      2
<4>[1279872.604001]  ffff8800bd5d3ec0 0000000000000046 ffff880067f97310 ffff8800bd5b86c8
<4>[1279872.604001]  ffff8800bd5b86c8 ffff8800bd5d3e60 ffff8800bd5d3e30 ffffffff8028dfc7
<4>[1279872.604001]  ffff8800bd5d3e50 ffff8800bd4903c0 ffffffff809dd000 ffff8800bd4903c0
<4>[1279872.604001] Call Trace:
<4>[1279872.604001]  [<ffffffff8028dfc7>] ? mempool_free_slab+0x17/0x20
<4>[1279872.604001]  [<ffffffff80408cc0>] ? xfs_end_bio_written+0x0/0x30
<4>[1279872.604001]  [<ffffffff80408ce2>] ? xfs_end_bio_written+0x22/0x30
<4>[1279872.604001]  [<ffffffff80251835>] worker_thread+0xe5/0x120
<4>[1279872.604001]  [<ffffffff80255e80>] ? autoremove_wake_function+0x0/0x40
<4>[1279872.604001]  [<ffffffff80251750>] ? worker_thread+0x0/0x120
<4>[1279872.604001]  [<ffffffff80251750>] ? worker_thread+0x0/0x120
<4>[1279872.604001]  [<ffffffff80255a3d>] kthread+0x4d/0x90
<4>[1279872.604001]  [<ffffffff8020c899>] child_rip+0xa/0x11
<4>[1279872.604001]  [<ffffffff802559f0>] ? kthread+0x0/0x90
<4>[1279872.604001]  [<ffffffff8020c88f>] ? child_rip+0x0/0x11
<6>[1279872.604001] scsi_eh_0     S ffffffff807300e0     0   572      2
<4>[1279872.604001]  ffff8800bcd03e50 0000000000000046 0000000000000000 0000000000000082
<4>[1279872.604001]  ffff8800bcd03de0 ffff8800bcd03df0 0000000000000001 ffff8800bd550000
<4>[1279872.604001]  0000000100000282 ffff8800bd452e60 ffffffff809dd000 ffff8800bd452e60
<4>[1279872.604001] Call Trace:
<4>[1279872.604001]  [<ffffffff80560758>] ? __scsi_iterate_devices+0x68/0xa0
<4>[1279872.604001]  [<ffffffff80565d2a>] scsi_error_handler+0x9a/0x5f0
<4>[1279872.604001]  [<ffffffff80565c90>] ? scsi_error_handler+0x0/0x5f0
<4>[1279872.604001]  [<ffffffff80255a3d>] kthread+0x4d/0x90
<4>[1279872.604001]  [<ffffffff8020c899>] child_rip+0xa/0x11
<4>[1279872.604001]  [<ffffffff802559f0>] ? kthread+0x0/0x90
<4>[1279872.604001]  [<ffffffff8020c88f>] ? child_rip+0x0/0x11
<6>[1279872.604001] scsi_eh_1     S ffffffff807300e0     0   575      2
<4>[1279872.604001]  ffff8800bcd1de50 0000000000000046 0000000000000000 0000000000000082
<4>[1279872.604001]  ffff8800bcd1dde0 ffff8800bcd1ddf0 0000000000000001 ffff8800bcd04000
<4>[1279872.604001]  0000000100000282 ffff8800bd4528d0 ffffffff809dd000 ffff8800bd4528d0
<4>[1279872.604001] Call Trace:
<4>[1279872.604001]  [<ffffffff80560758>] ? __scsi_iterate_devices+0x68/0xa0
<4>[1279872.604001]  [<ffffffff80565d2a>] scsi_error_handler+0x9a/0x5f0
<4>[1279872.604001]  [<ffffffff80565c90>] ? scsi_error_handler+0x0/0x5f0
<4>[1279872.604001]  [<ffffffff80255a3d>] kthread+0x4d/0x90
<4>[1279872.604001]  [<ffffffff8020c899>] child_rip+0xa/0x11
<4>[1279872.604001]  [<ffffffff802559f0>] ? kthread+0x0/0x90
<4>[1279872.604001]  [<ffffffff8020c88f>] ? child_rip+0x0/0x11
<6>[1279872.604001] scsi_eh_2     S 0000000000000001     0   578      2
<4>[1279872.604001]  ffff8800bcde3e50 0000000000000046 0000000000000000 0000000000000082
<4>[1279872.604001]  ffff8800bcde3de0 ffff8800bcde3df0 0000000000000001 ffff8800bcd08000
<4>[1279872.604001]  0000000000000282 ffff8800bd452340 ffffffff809dd000 ffff8800bd452340
<4>[1279872.604001] Call Trace:
<4>[1279872.604001]  [<ffffffff80560758>] ? __scsi_iterate_devices+0x68/0xa0
<4>[1279872.604001]  [<ffffffff80565d2a>] scsi_error_handler+0x9a/0x5f0
<4>[1279872.604001]  [<ffffffff80565c90>] ? scsi_error_handler+0x0/0x5f0
<4>[1279872.604001]  [<ffffffff80255a3d>] kthread+0x4d/0x90
<4>[1279872.604001]  [<ffffffff8020c899>] child_rip+0xa/0x11
<4>[1279872.604001]  [<ffffffff802559f0>] ? kthread+0x0/0x90
<4>[1279872.604001]  [<ffffffff8020c88f>] ? child_rip+0x0/0x11
<6>[1279872.604001] scsi_eh_3     S 0000000000000001     0   581      2
<4>[1279872.604001]  ffff8800bcde9e50 0000000000000046 ffff8800bcc5da10 ffff8800bcc5d800
<4>[1279872.604001]  ffff8800bcde9dc0 ffff8800bcde9df0 ffff8800bcc39800 0000000000000000
<4>[1279872.604001]  ffff8800bcde9dd0 ffff8800bdbab570 ffffffff809dd000 ffff8800bdbab570
<4>[1279872.604001] Call Trace:
<4>[1279872.604001]  [<ffffffff80560765>] ? __scsi_iterate_devices+0x75/0xa0
<4>[1279872.604001]  [<ffffffff80565d2a>] scsi_error_handler+0x9a/0x5f0
<4>[1279872.604001]  [<ffffffff80565c90>] ? scsi_error_handler+0x0/0x5f0
<4>[1279872.604001]  [<ffffffff80255a3d>] kthread+0x4d/0x90
<4>[1279872.604001]  [<ffffffff8020c899>] child_rip+0xa/0x11
<4>[1279872.604001]  [<ffffffff802559f0>] ? kthread+0x0/0x90
<4>[1279872.604001]  [<ffffffff8020c88f>] ? child_rip+0x0/0x11
<6>[1279872.604001] scsi_eh_4     S ffffffff807300e0     0   584      2
<4>[1279872.604001]  ffff8800bcdefe50 0000000000000046 0000000000000000 0000000000000082
<4>[1279872.604001]  ffff8800bcdefde0 ffff8800bcdefdf0 0000000000000001 ffff8800bcd10000
<4>[1279872.604001]  0000000100000282 ffff8800bd411330 ffffffff809dd000 ffff8800bd411330
<4>[1279872.604001] Call Trace:
<4>[1279872.604001]  [<ffffffff80560758>] ? __scsi_iterate_devices+0x68/0xa0
<4>[1279872.604001]  [<ffffffff80565d2a>] scsi_error_handler+0x9a/0x5f0
<4>[1279872.604001]  [<ffffffff80565c90>] ? scsi_error_handler+0x0/0x5f0
<4>[1279872.604001]  [<ffffffff80255a3d>] kthread+0x4d/0x90
<4>[1279872.604001]  [<ffffffff8020c899>] child_rip+0xa/0x11
<4>[1279872.604001]  [<ffffffff802559f0>] ? kthread+0x0/0x90
<4>[1279872.604001]  [<ffffffff8020c88f>] ? child_rip+0x0/0x11
<6>[1279872.604001] scsi_eh_5     S ffffffff807300e0     0   587      2
<4>[1279872.604001]  ffff8800bcd2de50 0000000000000046 0000000000000000 0000000000000082
<4>[1279872.604001]  ffff8800bcd2dde0 ffff8800bcd2ddf0 0000000000000001 ffff8800bcd14000
<4>[1279872.604001]  0000000100000282 ffff8800bdbb7020 ffffffff809dd000 ffff8800bdbb7020
<4>[1279872.604001] Call Trace:
<4>[1279872.604001]  [<ffffffff80560758>] ? __scsi_iterate_devices+0x68/0xa0
<4>[1279872.604001]  [<ffffffff80565d2a>] scsi_error_handler+0x9a/0x5f0
<4>[1279872.604001]  [<ffffffff80565c90>] ? scsi_error_handler+0x0/0x5f0
<4>[1279872.604001]  [<ffffffff80255a3d>] kthread+0x4d/0x90
<4>[1279872.604001]  [<ffffffff8020c899>] child_rip+0xa/0x11
<4>[1279872.604001]  [<ffffffff802559f0>] ? kthread+0x0/0x90
<4>[1279872.604001]  [<ffffffff8020c88f>] ? child_rip+0x0/0x11
<6>[1279872.604001] kpsmoused     S ffff8800bcc5c2c0     0   650      2
<4>[1279872.604001]  ffff8800bccabec0 0000000000000046 ffff8800bccabe20 ffffffff802353fb
<4>[1279872.604001]  ffff8800be0f9138 ffff8800bccabe60 ffff880001024880 ffffffff808ed020
<4>[1279872.604001]  0000000000000000 ffff8800bdbb75b0 ffffffff809dd000 ffff8800bdbb75b0
<4>[1279872.604001] Call Trace:
<4>[1279872.604001]  [<ffffffff802353fb>] ? __dequeue_entity+0x2b/0x50
<4>[1279872.604001]  [<ffffffff80251835>] worker_thread+0xe5/0x120
<4>[1279872.604001]  [<ffffffff80255e80>] ? autoremove_wake_function+0x0/0x40
<4>[1279872.604001]  [<ffffffff80251750>] ? worker_thread+0x0/0x120
<4>[1279872.604001]  [<ffffffff80251750>] ? worker_thread+0x0/0x120
<4>[1279872.604001]  [<ffffffff80255a3d>] kthread+0x4d/0x90
<4>[1279872.604001]  [<ffffffff8020c899>] child_rip+0xa/0x11
<4>[1279872.604001]  [<ffffffff802559f0>] ? kthread+0x0/0x90
<4>[1279872.604001]  [<ffffffff8020c88f>] ? child_rip+0x0/0x11
<6>[1279872.604001] edac-poller   S ffffffff807300e0     0   654      2
<4>[1279872.604001]  ffff8800bcd27ec0 0000000000000046 ffff8800be0fff00 0000000000000001
<4>[1279872.604001]  ffff8800bcd27e30 ffff8800bcd27e60 ffff880001030880 ffffffff808ed020
<4>[1279872.604001]  0000000100000000 ffff8800bd453980 ffffffff809dd000 ffff8800bd453980
<4>[1279872.604001] Call Trace:
<4>[1279872.604001]  [<ffffffff80251835>] worker_thread+0xe5/0x120
<4>[1279872.604001]  [<ffffffff80255e80>] ? autoremove_wake_function+0x0/0x40
<4>[1279872.604001]  [<ffffffff80251750>] ? worker_thread+0x0/0x120
<4>[1279872.604001]  [<ffffffff80251750>] ? worker_thread+0x0/0x120
<4>[1279872.604001]  [<ffffffff80255a3d>] kthread+0x4d/0x90
<4>[1279872.604001]  [<ffffffff8020c899>] child_rip+0xa/0x11
<4>[1279872.604001]  [<ffffffff802559f0>] ? kthread+0x0/0x90
<4>[1279872.604001]  [<ffffffff8020c88f>] ? child_rip+0x0/0x11
<6>[1279872.604001] hid_compat    S ffffffff807300e0     0   662      2
<4>[1279872.604001]  ffff8800bcd29ec0 0000000000000046 ffffffff80861aa1 ffff8800bcd29db0
<4>[1279872.604001]  0000000000000000 ffff8800bcd29e60 ffff880000000008 ffff8800bcd29e90
<4>[1279872.604001]  00000000bcd29e40 ffff8800bd446300 ffffffff809dd000 ffff8800bd446300
<4>[1279872.604001] Call Trace:
<4>[1279872.604001]  [<ffffffff80251835>] worker_thread+0xe5/0x120
<4>[1279872.604001]  [<ffffffff80255e80>] ? autoremove_wake_function+0x0/0x40
<4>[1279872.604001]  [<ffffffff80251750>] ? worker_thread+0x0/0x120
<4>[1279872.604001]  [<ffffffff80251750>] ? worker_thread+0x0/0x120
<4>[1279872.604001]  [<ffffffff80255a3d>] kthread+0x4d/0x90
<4>[1279872.604001]  [<ffffffff8020c899>] child_rip+0xa/0x11
<4>[1279872.604001]  [<ffffffff802559f0>] ? kthread+0x0/0x90
<4>[1279872.604001]  [<ffffffff8020c88f>] ? child_rip+0x0/0x11
<6>[1279872.604001] xfsbufd       S ffff8800bce3b4c0     0   692      2
<4>[1279872.604001]  ffff8800bcd3fe70 0000000000000046 0000000000000000 ffff8800bdb2d7d8
<4>[1279872.604001]  ffff8800bcd3e000 ffff8800bcd3fe10 ffff8800bac61e90 ffff88009ec5be90
<4>[1279872.604001]  0000000000000282 ffff8800bdbc3060 ffffffff809dd000 ffff8800bdbc3060
<4>[1279872.604001] Call Trace:
<4>[1279872.604001]  [<ffffffff80249ffb>] ? __mod_timer+0xbb/0xe0
<4>[1279872.604001]  [<ffffffff8071ad20>] schedule_timeout+0x80/0x100
<4>[1279872.604001]  [<ffffffff80249bd0>] ? process_timeout+0x0/0x10
<4>[1279872.604001]  [<ffffffff8071adfe>] schedule_timeout_interruptible+0x1e/0x20
<4>[1279872.604001]  [<ffffffff8040cada>] xfsbufd+0x7a/0x170
<4>[1279872.604001]  [<ffffffff8040ca60>] ? xfsbufd+0x0/0x170
<4>[1279872.604001]  [<ffffffff80255a3d>] kthread+0x4d/0x90
<4>[1279872.604001]  [<ffffffff8020c899>] child_rip+0xa/0x11
<4>[1279872.604001]  [<ffffffff802559f0>] ? kthread+0x0/0x90
<4>[1279872.604001]  [<ffffffff8020c88f>] ? child_rip+0x0/0x11
<6>[1279872.604001] xfsaild       S ffffffff807300e0     0   693      2
<4>[1279872.604001]  ffff8800bce73e70 0000000000000046 0000000000000001 0000000000000000
<4>[1279872.604001]  ffff8800bce72000 ffff8800bce73e10 000000014bd72422 ffff88001a572478
<4>[1279872.604001]  0000000000000286 ffff8800bdbc2ad0 ffffffff809dd000 ffff8800bdbc2ad0
<4>[1279872.604001] Call Trace:
<4>[1279872.604001]  [<ffffffff80249ffb>] ? __mod_timer+0xbb/0xe0
<4>[1279872.604001]  [<ffffffff8071ad20>] schedule_timeout+0x80/0x100
<4>[1279872.604001]  [<ffffffff80249bd0>] ? process_timeout+0x0/0x10
<4>[1279872.604001]  [<ffffffff8071adfe>] schedule_timeout_interruptible+0x1e/0x20
<4>[1279872.604001]  [<ffffffff80414a85>] xfsaild+0xa5/0xb0
<4>[1279872.604001]  [<ffffffff804149e0>] ? xfsaild+0x0/0xb0
<4>[1279872.604001]  [<ffffffff80255a3d>] kthread+0x4d/0x90
<4>[1279872.604001]  [<ffffffff8020c899>] child_rip+0xa/0x11
<4>[1279872.604001]  [<ffffffff802559f0>] ? kthread+0x0/0x90
<4>[1279872.604001]  [<ffffffff8020c88f>] ? child_rip+0x0/0x11
<6>[1279872.604001] xfssyncd      S ffff8800bcd35000     0   694      2
<4>[1279872.604001]  ffff8800bcf8de40 0000000000000046 ffff8800bcf8ddd0 ffffffff8071cacc
<4>[1279872.604001]  ffff8800069f8cc8 ffff8800bcf8dde0 ffff8800bcf8ddf0 ffffffff804864a5
<4>[1279872.604001]  0000000000000282 ffff8800bdbc2540 ffffffff809dd000 ffff8800bdbc2540
<4>[1279872.604001] Call Trace:
<4>[1279872.604001]  [<ffffffff8071cacc>] ? __down_write_nested+0x1c/0xb0
<4>[1279872.604001]  [<ffffffff804864a5>] ? __up_write+0xe5/0x150
<4>[1279872.604001]  [<ffffffff80249ffb>] ? __mod_timer+0xbb/0xe0
<4>[1279872.604001]  [<ffffffff8071ad20>] schedule_timeout+0x80/0x100
<4>[1279872.604001]  [<ffffffff802350ee>] ? __wake_up+0x4e/0x70
<4>[1279872.604001]  [<ffffffff80249bd0>] ? process_timeout+0x0/0x10
<4>[1279872.604001]  [<ffffffff8071adfe>] schedule_timeout_interruptible+0x1e/0x20
<4>[1279872.604001]  [<ffffffff80414518>] xfssyncd+0x78/0x1e0
<4>[1279872.604001]  [<ffffffff804144a0>] ? xfssyncd+0x0/0x1e0
<4>[1279872.604001]  [<ffffffff80255a3d>] kthread+0x4d/0x90
<4>[1279872.604001]  [<ffffffff8020c899>] child_rip+0xa/0x11
<4>[1279872.604001]  [<ffffffff802559f0>] ? kthread+0x0/0x90
<4>[1279872.604001]  [<ffffffff8020c88f>] ? child_rip+0x0/0x11

<6>[1280029.214465] SysRq : Show Memory
<6>[1280029.214473] Mem-Info:
<4>[1280029.214476] DMA per-cpu:
<4>[1280029.214479] CPU    0: hi:    0, btch:   1 usd:   0
<4>[1280029.214481] CPU    1: hi:    0, btch:   1 usd:   0
<4>[1280029.214483] DMA32 per-cpu:
<4>[1280029.214487] CPU    0: hi:  186, btch:  31 usd: 133
<4>[1280029.214489] CPU    1: hi:  186, btch:  31 usd: 150
<4>[1280029.214493] Active_anon:562730 active_file:40 inactive_anon:140701
<4>[1280029.214495]  inactive_file:694 unevictable:510 dirty:1 writeback:37 unstable:0
<4>[1280029.214496]  free:3717 slab:16120 mapped:528 pagetables:6966 bounce:0
<4>[1280029.214500] DMA free:7552kB min:12kB low:12kB high:16kB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB present:6640kB pages_scanned:0 all_unreclaimable? yes
<4>[1280029.214504] lowmem_reserve[]: 0 2988 2988 2988
<4>[1280029.214511] DMA32 free:7316kB min:6988kB low:8732kB high:10480kB active_anon:2250920kB inactive_anon:562804kB active_file:160kB inactive_file:2776kB unevictable:2040kB present:3060432kB pages_scanned:0 all_unreclaimable? no
<4>[1280029.214515] lowmem_reserve[]: 0 0 0 0
<4>[1280029.214519] DMA: 4*4kB 2*8kB 4*16kB 3*32kB 3*64kB 4*128kB 2*256kB 2*512kB 1*1024kB 0*2048kB 1*4096kB = 7552kB
<4>[1280029.214531] DMA32: 150*4kB 7*8kB 3*16kB 0*32kB 12*64kB 4*128kB 1*256kB 0*512kB 1*1024kB 0*2048kB 1*4096kB = 7360kB
<4>[1280029.214541] 13774 total pagecache pages
<4>[1280029.214543] 237 pages in swap cache
<4>[1280029.214546] Swap cache stats: add 1341130, delete 1340893, find 3167268/3183361
<4>[1280029.214548] Free swap  = 4kB
<4>[1280029.214550] Total swap = 3911784kB
<6>[1280029.215127] 780032 pages RAM
<6>[1280029.215127] 14918 pages reserved
<6>[1280029.215127] 52125 pages shared
<6>[1280029.215127] 724625 pages non-shared

<6>[1280129.607345] SysRq : Emergency Remount R/O
<4>[1280130.138611] NETFILTER drop IN=eth0 OUT= SRC=n.n.n.n DST=80.223.84.180 LEN=40 TOS=0x00 PREC=0x00 TTL=117 ID=8963 DF PROTO=TCP SPT=nnn DPT=nnn WINDOW=0 RES=0x00 ACK RST URGP=0 

-- 

