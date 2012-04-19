Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 0/2] Bluetooth: Fix crash on SCO socket shutdown
Date: Thu, 19 Apr 2012 16:12:27 +0200
Message-ID: <1334844749-13441-1-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <y>
References: <y>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Crash occurs in following scenario

1. First SCO socket and SCO link is created
2. Shutdown and release first SCO socket
3. create second SCO socket before timer for conn->disc_work fired. Meaning SCO link is
still up.
4. shutdown and release second SCO socket -> CRASH

See logs below:

kernel: [ 183.994364] [1610] sco_connect: E4:D5:3D:E3:BB:EA -> 00:1E:DE:88:85:CA
kernel: [ 183.994374] [1610] hci_get_route: E4:D5:3D:E3:BB:EA -> 00:1E:DE:88:85:CA
kernel: [ 183.994384] [1610] hci_connect: hci0 dst 00:1E:DE:88:85:CA
kernel: [ 183.994393] [1610] hci_conn_add: hci0 dst 00:1E:DE:88:85:CA
kernel: [ 183.994425] [1610] hci_conn_enter_active_mode: conn ffff8801afe61000 mode 0
kernel: [ 183.994432] [1610] hci_sco_setup: ffff8801afe61000
kernel: [ 183.994437] [1610] hci_setup_sync: ffff880207366000
kernel: [ 183.994444] [1610] hci_send_cmd: hci0 opcode 0x428 plen 17
kernel: [ 183.994476] [1610] hci_send_cmd: skb len 20
kernel: [ 183.994498] [59] hci_cmd_work: hci0 cmd 1
kernel: [ 183.994505] [1610] sco_conn_add: hcon ffff880207366000 conn ffff8801a9fe4d80
kernel: [ 183.994513] [1610] __sco_chan_add: conn ffff8801a9fe4d80
kernel: [ 183.994523] [1610] sco_sock_set_timer: sock ffff8801bea7dc00 state 5 timeout 10000
kernel: [ 183.994553] [59] hci_send_frame: hci0 type 1 len 20
kernel: [ 183.997506] [59] hci_rx_work: hci0
kernel: [ 183.997517] [59] hci_rx_work: hci0 Event packet
kernel: [ 184.114594] [59] hci_rx_work: hci0
kernel: [ 184.114604] [59] hci_rx_work: hci0 Event packet
kernel: [ 184.115588] [59] hci_rx_work: hci0
kernel: [ 184.115594] [59] hci_rx_work: hci0 Event packet
kernel: [ 184.116499] [59] hci_rx_work: hci0
kernel: [ 184.116509] [59] hci_rx_work: hci0 Event packet
bluetoothd[1610]: /org/bluez/1590/hci0/dev_00_1E_DE_88_85_CA/fd0: fd(25) ready
pulseaudio[2092]: [pulseaudio] bluetooth-util.c: Failed to acquire transport fd: Input/output error
pulseaudio[2092]: [pulseaudio] module.c: Failed to load module "module-bluetooth-device" (argument: "address="00:1E:DE:88:85:CA" path="/org/bluez/1590/hci0/dev_00_1E_DE_88_85_CA""): initialization failed.
kernel: [ 184.322271] [61] hci_rx_work: hci0
kernel: [ 184.322343] [61] hci_rx_work: hci0 Event packet
kernel: [ 184.322984] [61] sco_connect_cfm: hcon ffff880207366000 bdaddr 00:1E:DE:88:85:CA status 0
kernel: [ 184.322992] [61] sco_conn_ready: conn ffff8801a9fe4d80
kernel: [ 184.322999] [61] sco_sock_clear_timer: sock ffff8801bea7dc00 state 5
kernel: [ 184.323367] [1620] hci_send_acl: hci0 chan ffff8801a2d181c0 flags 0x0
kernel: [ 184.323372] [1620] hci_queue_acl: hci0 nonfrag skb ffff8801f8b91f00 len 23
kernel: [ 184.323380] [61] hci_tx_work: hci0 acl 8 sco 1 le 0
kernel: [ 184.323398] [1620] hci_send_acl: hci0 chan ffff8801a2d181c0 flags 0x0
kernel: [ 184.323401] [1620] hci_queue_acl: hci0 nonfrag skb ffff8801b0f37f00 len 23
kernel: [ 184.323407] [61] hci_sched_acl: hci0
kernel: [ 184.323409] [61] hci_chan_sent: hci0
kernel: [ 184.323412] [61] hci_chan_sent: chan ffff8801a2d181c0 quote 8
kernel: [ 184.323415] [61] hci_sched_acl_pkt: chan ffff8801a2d181c0 skb ffff8801f8b91f00 len 23 priority 0
kernel: [ 184.323417] [61] hci_conn_enter_active_mode: conn ffff8801afe61000 mode 0
kernel: [ 184.323420] [61] hci_send_frame: hci0 type 2 len 23
kernel: [ 184.323438] [61] hci_sched_acl_pkt: chan ffff8801a2d181c0 skb ffff8801b0f37f00 len 23 priority 0
kernel: [ 184.323441] [61] hci_conn_enter_active_mode: conn ffff8801afe61000 mode 0
kernel: [ 184.323443] [61] hci_send_frame: hci0 type 2 len 23
kernel: [ 184.323458] [61] hci_chan_sent: hci0
kernel: [ 184.323460] [61] hci_prio_recalculate: hci0
kernel: [ 184.323462] [61] hci_sched_sco: hci0
kernel: [ 184.323464] [61] hci_low_sent: conn (null) quote 0
kernel: [ 184.323467] [61] hci_sched_esco: hci0
kernel: [ 184.323468] [61] hci_low_sent: conn (null) quote 0
kernel: [ 184.323470] [61] hci_sched_le: hci0
kernel: [ 184.323473] [61] hci_tx_work: hci0 acl 6 sco 1 le 0
kernel: [ 184.323474] [61] hci_sched_acl: hci0
kernel: [ 184.323476] [61] hci_chan_sent: hci0
kernel: [ 184.323477] [61] hci_sched_sco: hci0
kernel: [ 184.323479] [61] hci_low_sent: conn (null) quote 0
kernel: [ 184.323480] [61] hci_sched_esco: hci0
kernel: [ 184.323482] [61] hci_low_sent: conn (null) quote 0
kernel: [ 184.323484] [61] hci_sched_le: hci0
pulseaudio[2092]: [pulseaudio] module-bluetooth-device.c: Bluetooth audio service not available
pulseaudio[2092]: [pulseaudio] bluetooth-util.c: Failed to acquire transport fd: Input/output error
pulseaudio[2092]: [pulseaudio] module.c: Failed to load module "module-bluetooth-device" (argument: "address="00:1E:DE:88:85:CA" path="/org/bluez/1590/hci0/dev_00_1E_DE_88_85_CA""): initialization failed.
kernel: [ 184.327316] [1610] sco_sock_shutdown: sock ffff8801a1b40500, sk ffff8801bea7dc00
kernel: [ 184.327322] [1610] sco_sock_clear_timer: sock ffff8801bea7dc00 state 1
kernel: [ 184.327326] [1610] __sco_sock_close: sk ffff8801bea7dc00 state 1 socket ffff8801a1b40500   
kernel: [ 184.327330] [1610] sco_sock_set_timer: sock ffff8801bea7dc00 state 8 timeout 500

########
Somewhere here in function __sco_sock_close bluez does: conn->hcon = NULL
########

kernel: [ 184.327338] [1610] sco_sock_release: sock ffff8801a1b40500, sk ffff8801bea7dc00
kernel: [ 184.327341] [1610] sco_sock_clear_timer: sock ffff8801bea7dc00 state 8
kernel: [ 184.327344] [1610] __sco_sock_close: sk ffff8801bea7dc00 state 8 socket ffff8801a1b40500
kernel: [ 184.327346] [1610] sco_chan_del: sk ffff8801bea7dc00, conn ffff8801a9fe4d80, err 104
kernel: [ 184.327349] [1610] sco_sock_kill: sk ffff8801bea7dc00 state 9
kernel: [ 184.327352] [1610] sco_sock_destruct: sk ffff8801bea7dc00
pulseaudio[2092]: [pulseaudio] module-bluetooth-device.c: Bluetooth audio service not available

###########
Creating second SCO socket - NOTE that SCO link is still up because HCI_DISCONNECT has not been send yet.
###########

kernel: [ 184.331117] [1610] sco_sock_create: sock ffff8801bb1a3c00
kernel: [ 184.331131] [1610] sco_sock_init: sk ffff880225014800
kernel: [ 184.331172] [1610] sco_sock_bind: sk ffff880225014800 E4:D5:3D:E3:BB:EA
kernel: [ 184.331181] [1610] sco_sock_connect: sk ffff880225014800
kernel: [ 184.331185] [1610] sco_connect: E4:D5:3D:E3:BB:EA -> 00:1E:DE:88:85:CA
kernel: [ 184.331190] [1610] hci_get_route: E4:D5:3D:E3:BB:EA -> 00:1E:DE:88:85:CA
kernel: [ 184.331194] [1610] hci_connect: hci0 dst 00:1E:DE:88:85:CA

##########
Here the funcion sco_conn_add is called but since SCO connection already exist it returns right away.
So note that here conn->hcon is still NULL
##########

kernel: [ 184.331198] [1610] __sco_chan_add: conn ffff8801a9fe4d80
kernel: [ 184.331200] [1610] sco_sock_clear_timer: sock ffff880225014800 state 3
kernel: [ 184.331407] [1620] hci_send_acl: hci0 chan ffff8801a2d181c0 flags 0x0
kernel: [ 184.331412] [1620] hci_queue_acl: hci0 nonfrag skb ffff8801a3873000 len 23
kernel: [ 184.331436] [61] hci_tx_work: hci0 acl 6 sco 1 le 0
kernel: [ 184.331439] [1620] hci_send_acl: hci0 chan ffff8801a2d181c0 flags 0x0
kernel: [ 184.331441] [1620] hci_queue_acl: hci0 nonfrag skb ffff8801a3873c00 len 23
kernel: [ 184.331444] [61] hci_sched_acl: hci0
kernel: [ 184.331446] [61] hci_chan_sent: hci0
kernel: [ 184.331449] [61] hci_chan_sent: chan ffff8801a2d181c0 quote 6
kernel: [ 184.331452] [61] hci_sched_acl_pkt: chan ffff8801a2d181c0 skb ffff8801a3873000 len 23 priority 0
kernel: [ 184.331456] [61] hci_conn_enter_active_mode: conn ffff8801afe61000 mode 0
kernel: [ 184.331460] [61] hci_send_frame: hci0 type 2 len 23
kernel: [ 184.331511] [61] hci_sched_acl_pkt: chan ffff8801a2d181c0 skb ffff8801a3873c00 len 23 priority 0
kernel: [ 184.331524] [61] hci_conn_enter_active_mode: conn ffff8801afe61000 mode 0
kernel: [ 184.331535] [61] hci_send_frame: hci0 type 2 len 23
kernel: [ 184.331585] [61] hci_chan_sent: hci0
kernel: [ 184.331594] [61] hci_prio_recalculate: hci0
kernel: [ 184.331602] [61] hci_sched_sco: hci0
kernel: [ 184.331754] [61] hci_low_sent: conn (null) quote 0
kernel: [ 184.331764] [61] hci_sched_esco: hci0
kernel: [ 184.331773] [61] hci_low_sent: conn (null) quote 0
kernel: [ 184.331782] [61] hci_sched_le: hci0
kernel: [ 184.331793] [61] hci_tx_work: hci0 acl 4 sco 1 le 0
kernel: [ 184.331802] [61] hci_sched_acl: hci0
kernel: [ 184.331809] [61] hci_chan_sent: hci0
kernel: [ 184.331817] [61] hci_sched_sco: hci0
kernel: [ 184.331826] [61] hci_low_sent: conn (null) quote 0
kernel: [ 184.331835] [61] hci_sched_esco: hci0
kernel: [ 184.331843] [61] hci_low_sent: conn (null) quote 0
kernel: [ 184.331852] [61] hci_sched_le: hci0
pulseaudio[2092]: [pulseaudio] bluetooth-util.c: Failed to acquire transport fd: Input/output error
pulseaudio[2092]: [pulseaudio] module.c: Failed to load module "module-bluetooth-device" (argument: "address="00:1E:DE:88:85:CA" path="/org/bluez/1590/hci0/dev_00_1E_DE_88_85_CA""): initialization failed.
pulseaudio[2092]: [pulseaudio] module-bluetooth-device.c: Bluetooth audio service not available
pulseaudio[2092]: [pulseaudio] bluetooth-util.c: Failed to acquire transport fd: Input/output error
pulseaudio[2092]: [pulseaudio] module.c: Failed to load module "module-bluetooth-device" (argument: "address="00:1E:DE:88:85:CA" path="/org/bluez/1590/hci0/dev_00_1E_DE_88_85_CA""): initialization failed.
pulseaudio[2092]: [pulseaudio] module-bluetooth-device.c: Bluetooth audio service not available
kernel: [ 184.335021] [1610] sco_sock_shutdown: sock ffff8801bb1a3c00, sk ffff880225014800
kernel: [ 184.335025] [1610] sco_sock_clear_timer: sock ffff880225014800 state 1
kernel: [ 184.335027] [1610] __sco_sock_close: sk ffff880225014800 state 1 socket ffff8801bb1a3c00
kernel: [ 184.335030] [1610] sco_sock_set_timer: sock ffff880225014800 state 8 timeout 500

#########
Here bluez tries to do hci_conn_put(conn->hcon) and it is how we get crash
########

kernel: [ 184.335043] BUG: unable to handle kernel NULL pointer dereference at 0000000000000010
kernel: [ 184.338294] IP: [<ffffffffa0451ff5>] __sco_sock_close+0xe5/0x1e0 [bluetooth]
kernel: [ 184.339993] PGD 0 
kernel: [ 184.341537] Oops: 0002 [#1] SMP 
kernel: [ 184.343081] CPU 2 
kernel: [ 184.343087] Modules linked in: binfmt_misc rfcomm bnep ipt_REJECT xt_tcpudp nf_conntrack_ipv4 nf_defrag_ipv4 xt_state nf_conntrack iptable_filter ip_tables x_tables ext2 btusb bluetooth snd_hda_codec_hdmi snd_hda_codec_idt uvcvideo videobuf2_core videodev v4l2_compat_ioctl32 videobuf2_vmalloc videobuf2_memops arc4 joydev snd_hda_intel snd_hda_codec snd_hwdep lp ppdev mei(C) snd_pcm mac_hid iwlwifi dell_laptop dell_wmi parport_pc snd_seq_midi snd_rawmidi parport snd_seq_midi_event mac80211 snd_seq snd_timer snd_seq_device snd dcdbas psmouse sparse_keymap serio_raw cfg80211 sdhci_pci sdhci soundcore snd_page_alloc usbhid hid i915 drm_kms_helper drm i2c_algo_bit e1000e wmi video
kernel: [ 184.351753] 
kernel: [ 184.353547] Pid: 1610, comm: bluetoothd Tainted: G C 3.3.0-rc6+ #4 Dell Inc. Latitude E6420/0K0DNP
kernel: [ 184.355305] RIP: 0010:[<ffffffffa0451ff5>] [<ffffffffa0451ff5>] __sco_sock_close+0xe5/0x1e0 [bluetooth]
kernel: [ 184.357030] RSP: 0018:ffff880204c83f08 EFLAGS: 00010292
kernel: [ 184.358742] RAX: ffff8801a9fe4d80 RBX: ffff880225014800 RCX: 00000000ffff8f1d
kernel: [ 184.360399] RDX: ffff880221d95130 RSI: 0000000000000286 RDI: 0000000000000286
kernel: [ 184.362134] RBP: ffff880204c83f28 R08: 0000000000000000 R09: 0000000000000000
kernel: [ 184.363845] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
kernel: [ 184.365598] R13: 00007f20f6201e10 R14: 00007f20f620ab40 R15: 00007f20f61e3a00
kernel: [ 184.367274] FS: 00007f20f4b97720(0000) GS:ffff88022dc40000(0000) knlGS:0000000000000000
kernel: [ 184.368934] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
kernel: [ 184.370611] CR2: 0000000000000010 CR3: 0000000204954000 CR4: 00000000000406e0
kernel: [ 184.372059] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
kernel: [ 184.373456] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
kernel: [ 184.374833] Process bluetoothd (pid: 1610, threadinfo ffff880204c82000, task ffff880205f52de0)
kernel: [ 184.376202] Stack:
kernel: [ 184.377590] ffff880204c83f28 ffff880225014800 0000000000000000 00007f20f6201e10
kernel: [ 184.378961] ffff880204c83f48 ffffffffa0452169 0000000000000002 ffff8801bb1a3c00
kernel: [ 184.380430] ffff880204c83f78 ffffffff815474bd 00007fffd79ca6a0 0000000000000000
kernel: [ 184.381895] Call Trace:
kernel: [ 184.383370] [<ffffffffa0452169>] sco_sock_shutdown+0x79/0xd0 [bluetooth]
kernel: [ 184.384828] [<ffffffff815474bd>] sys_shutdown+0x7d/0x90
kernel: [ 184.386253] [<ffffffff8166bba9>] system_call_fastpath+0x16/0x1b
kernel: [ 184.387672] Code: 1f 80 00 00 00 00 48 83 bb c0 02 00 00 00 74 86 c6 43 0e 08 be f4 01 00 00 48 89 df e8 b5 e9 ff ff 48 8b 83 c0 02 00 00 4c 8b 20 <f0> 41 ff 4c 24 10 0f 94 c0 84 c0 74 55 41 0f b6 44 24 21 3c 80 
kernel: [ 184.390653] RIP [<ffffffffa0451ff5>] __sco_sock_close+0xe5/0x1e0 [bluetooth]
kernel: [ 184.392239] RSP <ffff880204c83f08>
kernel: [ 184.393777] CR2: 0000000000000010

Lukasz Rymanowski (2):
  Bluetooth: Remove not needed status parameter
  Bluetooth: Fix crash on SCO socket shutdown

 net/bluetooth/sco.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

-- 
1.7.9.4

