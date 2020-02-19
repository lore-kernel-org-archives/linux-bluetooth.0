Return-Path: <SRS0=cHq6=4H=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E9AC34047
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Feb 2020 14:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C73524670
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Feb 2020 14:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgBSOzv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Feb 2020 09:55:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:58370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726582AbgBSOzv (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Feb 2020 09:55:51 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 206515] Bluetooth drivers crashes the system randomly
Date:   Wed, 19 Feb 2020 14:55:49 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: warxcell@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-206515-62941-mQwSPp3YoL@https.bugzilla.kernel.org/>
In-Reply-To: <bug-206515-62941@https.bugzilla.kernel.org/>
References: <bug-206515-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=206515

--- Comment #1 from Bozhidar Hristov (warxcell@gmail.com) ---
Attaching new log, from todays crash:

Feb 19 16:47:45 bhasus plasmashell[1114]:
file:///usr/share/plasma/plasmoids/org.kde.plasma.bluetooth/contents/ui/logic.js:36:
TypeError: Cannot read property 'devices' of undefined
Feb 19 16:47:45 bhasus kernel: general protection fault: 0000 [#1] PREEMPT SMP
NOPTI
Feb 19 16:47:45 bhasus kernel: CPU: 2 PID: 757709 Comm: kworker/u25:3 Tainted:
P           OE     5.5.4-arch1-1 #1
Feb 19 16:47:45 bhasus kernel: Hardware name: ASUSTeK COMPUTER INC. ROG Strix
G531GT_G531GT/G531GT, BIOS G531GT.305 09/24/2019
Feb 19 16:47:45 bhasus kernel: Workqueue: hci0 hci_rx_work [bluetooth]
Feb 19 16:47:45 bhasus kernel: RIP: 0010:__wake_up_common+0xba/0x140
Feb 19 16:47:45 bhasus kernel: Code: 08 00 74 26 83 c5 01 83 fd 40 7e 1e 49 8d
44 24 18 48 39 04 24 75 6a 8b 44 24 14 48 83 c4 18 5b 5d 41 5c 41 5d 41 5e 41
5f c3 <49> 8b 44 24 18 4c 89 e7 49 8d 54 24 18 48 83 e8 18 48 39 14 24 74
Feb 19 16:47:45 bhasus kernel: RSP: 0018:ffff9f8d487f7c18 EFLAGS: 00010083
Feb 19 16:47:45 bhasus kernel: RAX: 0000000000000000 RBX: 0000000000000000 RCX:
0000000000000000
Feb 19 16:47:45 bhasus kernel: RDX: 0000000000000002 RSI: 0000000000000046 RDI:
00000000ffffffff
Feb 19 16:47:45 bhasus kernel: RBP: 0000000000000002 R08: 0000000000000000 R09:
ffff9f8d487f7ba8
Feb 19 16:47:45 bhasus kernel: R10: ffff9ce8127c5818 R11: ffff9ce81da6cf78 R12:
dead0000000000e8
Feb 19 16:47:45 bhasus kernel: R13: 0000000000000001 R14: 0000000000000000 R15:
0000000000000000
Feb 19 16:47:45 bhasus kernel: FS:  0000000000000000(0000)
GS:ffff9ce81da80000(0000) knlGS:0000000000000000
Feb 19 16:47:45 bhasus kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Feb 19 16:47:45 bhasus kernel: CR2: 000056082fab3968 CR3: 000000055405e004 CR4:
00000000003606e0
Feb 19 16:47:45 bhasus kernel: Call Trace:
Feb 19 16:47:45 bhasus kernel:  __wake_up_common_lock+0x84/0xc0
Feb 19 16:47:45 bhasus kernel:  sock_def_wakeup+0x3b/0x50
Feb 19 16:47:45 bhasus kernel:  l2cap_sock_teardown_cb+0x19d/0x210 [bluetooth]
Feb 19 16:47:45 bhasus kernel:  l2cap_chan_del+0x43/0x2d0 [bluetooth]
Feb 19 16:47:45 bhasus kernel:  l2cap_conn_del+0x10d/0x200 [bluetooth]
Feb 19 16:47:45 bhasus kernel:  hci_event_packet+0xca0/0x2a90 [bluetooth]
Feb 19 16:47:45 bhasus kernel:  ? __switch_to_asm+0x40/0x70
Feb 19 16:47:45 bhasus kernel:  ? __kprobes_text_end+0xaaf90/0xaaf90
Feb 19 16:47:45 bhasus kernel:  ? __switch_to_asm+0x34/0x70
Feb 19 16:47:45 bhasus kernel:  ? __switch_to_asm+0x40/0x70
Feb 19 16:47:45 bhasus kernel:  ? preempt_count_add+0x68/0xa0
Feb 19 16:47:45 bhasus kernel:  hci_rx_work+0x19f/0x380 [bluetooth]
Feb 19 16:47:45 bhasus kernel:  ? __schedule+0x2f0/0x7a0
Feb 19 16:47:45 bhasus kernel:  process_one_work+0x1e1/0x3d0
Feb 19 16:47:45 bhasus kernel:  worker_thread+0x4a/0x3d0
Feb 19 16:47:45 bhasus kernel:  kthread+0xfb/0x130
Feb 19 16:47:45 bhasus kernel:  ? process_one_work+0x3d0/0x3d0
Feb 19 16:47:45 bhasus kernel:  ? kthread_park+0x90/0x90
Feb 19 16:47:45 bhasus kernel:  ret_from_fork+0x1f/0x40
Feb 19 16:47:45 bhasus kernel: Modules linked in: authenc echainiv esp4
xt_state nf_nat_h323 nf_conntrack_h323 nf_nat_pptp nf_conntrack_pptp
nf_nat_tftp nf_conntrack_tftp nf_nat_sip nf_conntrack_sip nf_nat_irc
nf_conntrack_irc nf_nat_ftp nf_conntrack_ftp fuse xt_nat vet>
Feb 19 16:47:45 bhasus kernel:  mac80211 kvm_intel snd_sof nls_iso8859_1
snd_hda_codec_realtek btusb nls_cp437 snd_hda_ext_core nvidia_drm(POE)
snd_soc_acpi_intel_match snd_hda_codec_generic nvidia_modeset(POE) vfat btrtl
snd_soc_acpi btbcm fat btintel libarc4 snd_soc_c>
Feb 19 16:47:45 bhasus kernel:  crc32c_generic crc16 mbcache jbd2 hid_generic
usbhid hid dm_crypt dm_mod crct10dif_pclmul crc32_pclmul crc32c_intel serio_raw
atkbd ghash_clmulni_intel libps2 ahci libahci xhci_pci aesni_intel libata
crypto_simd cryptd scsi_mod xhci_hcd g>
Feb 19 16:47:45 bhasus kernel: ---[ end trace 897b15422388c54d ]---
Feb 19 16:47:45 bhasus kernel: RIP: 0010:__wake_up_common+0xba/0x140
Feb 19 16:47:45 bhasus kernel: Code: 08 00 74 26 83 c5 01 83 fd 40 7e 1e 49 8d
44 24 18 48 39 04 24 75 6a 8b 44 24 14 48 83 c4 18 5b 5d 41 5c 41 5d 41 5e 41
5f c3 <49> 8b 44 24 18 4c 89 e7 49 8d 54 24 18 48 83 e8 18 48 39 14 24 74
Feb 19 16:47:45 bhasus kernel: RSP: 0018:ffff9f8d487f7c18 EFLAGS: 00010083
Feb 19 16:47:45 bhasus kernel: RAX: 0000000000000000 RBX: 0000000000000000 RCX:
0000000000000000
Feb 19 16:47:45 bhasus kernel: RDX: 0000000000000002 RSI: 0000000000000046 RDI:
00000000ffffffff
Feb 19 16:47:45 bhasus kernel: RBP: 0000000000000002 R08: 0000000000000000 R09:
ffff9f8d487f7ba8
Feb 19 16:47:45 bhasus kernel: R10: ffff9ce8127c5818 R11: ffff9ce81da6cf78 R12:
dead0000000000e8
Feb 19 16:47:45 bhasus kernel: R13: 0000000000000001 R14: 0000000000000000 R15:
0000000000000000
Feb 19 16:47:45 bhasus kernel: FS:  0000000000000000(0000)
GS:ffff9ce81da80000(0000) knlGS:0000000000000000
Feb 19 16:47:45 bhasus kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Feb 19 16:47:45 bhasus kernel: CR2: 000056082fab3968 CR3: 000000055405e004 CR4:
00000000003606e0
Feb 19 16:47:45 bhasus kernel: note: kworker/u25:3[757709] exited with
preempt_count 1
Feb 19 16:47:47 bhasus dockerd[1556]:
time="2020-02-19T16:47:47.521563586+02:00" level=error msg="stream copy error:
reading from a closed fifo"
Feb 19 16:47:47 bhasus dockerd[1556]:
time="2020-02-19T16:47:47.521627217+02:00" level=error msg="stream copy error:
reading from a closed fifo"
Feb 19 16:47:47 bhasus dockerd[1556]:
time="2020-02-19T16:47:47.557975141+02:00" level=error msg="stream copy error:
reading from a closed fifo"
Feb 19 16:47:47 bhasus dockerd[1556]:
time="2020-02-19T16:47:47.557982088+02:00" level=error msg="stream copy error:
reading from a closed fifo"
Feb 19 16:48:05 bhasus dockerd[1556]:
time="2020-02-19T16:48:05.416315764+02:00" level=error msg="stream copy error:
reading from a closed fifo"
Feb 19 16:48:05 bhasus dockerd[1556]:
time="2020-02-19T16:48:05.429887185+02:00" level=error msg="stream copy error:
reading from a closed fifo"
Feb 19 16:48:05 bhasus dockerd[1556]:
time="2020-02-19T16:48:05.467247581+02:00" level=error msg="stream copy error:
reading from a closed fifo"
Feb 19 16:48:05 bhasus dockerd[1556]:
time="2020-02-19T16:48:05.467291750+02:00" level=error msg="stream copy error:
reading from a closed fifo"
Feb 19 16:48:05 bhasus dockerd[1556]:
time="2020-02-19T16:48:05.488262660+02:00" level=error msg="stream copy error:
reading from a closed fifo"
Feb 19 16:48:05 bhasus dockerd[1556]:
time="2020-02-19T16:48:05.488271521+02:00" level=error msg="stream copy error:
reading from a closed fifo"
Feb 19 16:48:14 bhasus kernel: watchdog: BUG: soft lockup - CPU#3 stuck for
22s! [runc:790387]
Feb 19 16:48:14 bhasus kernel: Modules linked in: authenc echainiv esp4
xt_state nf_nat_h323 nf_conntrack_h323 nf_nat_pptp nf_conntrack_pptp
nf_nat_tftp nf_conntrack_tftp nf_nat_sip nf_conntrack_sip nf_nat_irc
nf_conntrack_irc nf_nat_ftp nf_conntrack_ftp fuse xt_nat vet>
Feb 19 16:48:14 bhasus kernel:  mac80211 kvm_intel snd_sof nls_iso8859_1
snd_hda_codec_realtek btusb nls_cp437 snd_hda_ext_core nvidia_drm(POE)
snd_soc_acpi_intel_match snd_hda_codec_generic nvidia_modeset(POE) vfat btrtl
snd_soc_acpi btbcm fat btintel libarc4 snd_soc_c>
Feb 19 16:48:14 bhasus kernel:  crc32c_generic crc16 mbcache jbd2 hid_generic
usbhid hid dm_crypt dm_mod crct10dif_pclmul crc32_pclmul crc32c_intel serio_raw
atkbd ghash_clmulni_intel libps2 ahci libahci xhci_pci aesni_intel libata
crypto_simd cryptd scsi_mod xhci_hcd g>
Feb 19 16:48:14 bhasus kernel: CPU: 3 PID: 790387 Comm: runc Tainted: P      D 
  OE     5.5.4-arch1-1 #1
Feb 19 16:48:14 bhasus kernel: Hardware name: ASUSTeK COMPUTER INC. ROG Strix
G531GT_G531GT/G531GT, BIOS G531GT.305 09/24/2019
Feb 19 16:48:14 bhasus kernel: RIP: 0010:smp_call_function_single+0x135/0x170
Feb 19 16:48:14 bhasus kernel: Code: 85 c0 75 84 0f 0b eb 80 e8 f8 6c 34 00 48
c7 c3 00 de 02 00 89 c0 48 03 1c c5 20 59 5b b3 8b 43 18 48 89 de a8 01 74 09
f3 90 <8b> 46 18 a8 01 75 f7 83 4e 18 01 44 89 e7 4c 89 f1 4c 89 ea e8 c2
Feb 19 16:48:14 bhasus kernel: RSP: 0018:ffff9f8d48ac7bc0 EFLAGS: 00000202
ORIG_RAX: ffffffffffffff13
Feb 19 16:48:14 bhasus kernel: RAX: 0000000000000001 RBX: ffff9ce81daede00 RCX:
0000000000000000
Feb 19 16:48:14 bhasus kernel: RDX: 0000000000000000 RSI: ffff9ce81daede00 RDI:
ffffffffb359a628
Feb 19 16:48:14 bhasus kernel: RBP: ffff9f8d48ac7c30 R08: ffffffffb39476e0 R09:
ffff9ce641b8ea78
Feb 19 16:48:14 bhasus kernel: R10: ffff9ce64d297540 R11: 0000000000000000 R12:
0000000000000002
Feb 19 16:48:14 bhasus kernel: R13: ffffffffb24417a0 R14: 0000000000000000 R15:
0000000000000000
Feb 19 16:48:14 bhasus kernel: FS:  00007f81130af740(0000)
GS:ffff9ce81dac0000(0000) knlGS:0000000000000000
Feb 19 16:48:14 bhasus kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Feb 19 16:48:14 bhasus kernel: CR2: 000000c0000bc000 CR3: 00000007b1988002 CR4:
00000000003606e0
Feb 19 16:48:14 bhasus kernel: Call Trace:
Feb 19 16:48:14 bhasus kernel:  aperfmperf_snapshot_cpu+0x40/0x50
Feb 19 16:48:14 bhasus kernel:  arch_freq_prepare_all+0x5e/0xa0
Feb 19 16:48:14 bhasus kernel:  cpuinfo_open+0xe/0x20
Feb 19 16:48:14 bhasus kernel:  proc_reg_open+0x6e/0x120
Feb 19 16:48:14 bhasus kernel:  ? proc_put_link+0x10/0x10
Feb 19 16:48:14 bhasus kernel:  do_dentry_open+0x13d/0x3a0
Feb 19 16:48:14 bhasus kernel:  path_openat+0x592/0x1550
Feb 19 16:48:14 bhasus kernel:  ? __count_memcg_events+0x52/0xb0
Feb 19 16:48:14 bhasus kernel:  do_filp_open+0xab/0x120
Feb 19 16:48:14 bhasus kernel:  do_sys_open+0x19e/0x240
Feb 19 16:48:14 bhasus kernel:  do_syscall_64+0x4e/0x150
Feb 19 16:48:14 bhasus kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xa9
Feb 19 16:48:14 bhasus kernel: RIP: 0033:0x558054f1775a
Feb 19 16:48:14 bhasus kernel: Code: e8 3b 5a f8 ff 48 8b 7c 24 10 48 8b 74 24
18 48 8b 54 24 20 4c 8b 54 24 28 4c 8b 44 24 30 4c 8b 4c 24 38 48 8b 44 24 08
0f 05 <48> 3d 01 f0 ff ff 76 20 48 c7 44 24 40 ff ff ff ff 48 c7 44 24 48
Feb 19 16:48:14 bhasus kernel: RSP: 002b:000000c0000b1bc0 EFLAGS: 00000206
ORIG_RAX: 0000000000000101
Feb 19 16:48:14 bhasus kernel: RAX: ffffffffffffffda RBX: 000000c000022500 RCX:
0000558054f1775a
Feb 19 16:48:14 bhasus kernel: RDX: 0000000000080000 RSI: 000000c00008e6c0 RDI:
ffffffffffffff9c
Feb 19 16:48:14 bhasus kernel: RBP: 000000c0000b1c38 R08: 0000000000000000 R09:
0000000000000000
Feb 19 16:48:14 bhasus kernel: R10: 0000000000000000 R11: 0000000000000206 R12:
000000000000006d
Feb 19 16:48:14 bhasus kernel: R13: 000000000000006c R14: 0000000000000200 R15:
0000000000000034
Feb 19 16:48:14 bhasus kernel: watchdog: BUG: soft lockup - CPU#8 stuck for
22s! [runc:790392]
Feb 19 16:48:14 bhasus kernel: Modules linked in: authenc echainiv esp4
xt_state nf_nat_h323 nf_conntrack_h323 nf_nat_pptp nf_conntrack_pptp
nf_nat_tftp nf_conntrack_tftp nf_nat_sip nf_conntrack_sip nf_nat_irc
nf_conntrack_irc nf_nat_ftp nf_conntrack_ftp fuse xt_nat vet>
Feb 19 16:48:14 bhasus kernel:  mac80211 kvm_intel snd_sof nls_iso8859_1
snd_hda_codec_realtek btusb nls_cp437 snd_hda_ext_core nvidia_drm(POE)
snd_soc_acpi_intel_match snd_hda_codec_generic nvidia_modeset(POE) vfat btrtl
snd_soc_acpi btbcm fat btintel libarc4 snd_soc_c>
Feb 19 16:48:14 bhasus kernel:  crc32c_generic crc16 mbcache jbd2 hid_generic
usbhid hid dm_crypt dm_mod crct10dif_pclmul crc32_pclmul crc32c_intel serio_raw
atkbd ghash_clmulni_intel libps2 ahci libahci xhci_pci aesni_intel libata
crypto_simd cryptd scsi_mod xhci_hcd g>
Feb 19 16:48:14 bhasus kernel: CPU: 8 PID: 790392 Comm: runc Tainted: P      D 
  OEL    5.5.4-arch1-1 #1
Feb 19 16:48:14 bhasus kernel: Hardware name: ASUSTeK COMPUTER INC. ROG Strix
G531GT_G531GT/G531GT, BIOS G531GT.305 09/24/2019
Feb 19 16:48:14 bhasus kernel: RIP: 0010:smp_call_function_single+0x135/0x170
Feb 19 16:48:14 bhasus kernel: Code: 85 c0 75 84 0f 0b eb 80 e8 f8 6c 34 00 48
c7 c3 00 de 02 00 89 c0 48 03 1c c5 20 59 5b b3 8b 43 18 48 89 de a8 01 74 09
f3 90 <8b> 46 18 a8 01 75 f7 83 4e 18 01 44 89 e7 4c 89 f1 4c 89 ea e8 c2
Feb 19 16:48:14 bhasus kernel: RSP: 0018:ffff9f8d4827fbc0 EFLAGS: 00000202
ORIG_RAX: ffffffffffffff13
Feb 19 16:48:14 bhasus kernel: RAX: 0000000000000001 RBX: ffff9ce81dc2de00 RCX:
0000000000000000
Feb 19 16:48:14 bhasus kernel: RDX: 0000000000000000 RSI: ffff9ce81dc2de00 RDI:
ffffffffb359a628
Feb 19 16:48:14 bhasus kernel: RBP: ffff9f8d4827fc30 R08: ffffffffb39476e0 R09:
ffff9ce6fd575320
Feb 19 16:48:14 bhasus kernel: R10: ffff9ce64d297540 R11: 0000000000000000 R12:
0000000000000002
Feb 19 16:48:14 bhasus kernel: R13: ffffffffb24417a0 R14: 0000000000000000 R15:
0000000000000000
Feb 19 16:48:14 bhasus kernel: FS:  00007f7862f28740(0000)
GS:ffff9ce81dc00000(0000) knlGS:0000000000000000
Feb 19 16:48:14 bhasus kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Feb 19 16:48:14 bhasus kernel: CR2: 00005653bc330970 CR3: 0000000829750005 CR4:
00000000003606e0
Feb 19 16:48:14 bhasus kernel: Call Trace:
Feb 19 16:48:14 bhasus kernel:  aperfmperf_snapshot_cpu+0x40/0x50
Feb 19 16:48:14 bhasus kernel:  arch_freq_prepare_all+0x5e/0xa0
Feb 19 16:48:14 bhasus kernel:  cpuinfo_open+0xe/0x20
Feb 19 16:48:14 bhasus kernel:  proc_reg_open+0x6e/0x120
Feb 19 16:48:14 bhasus kernel:  ? proc_put_link+0x10/0x10
Feb 19 16:48:14 bhasus kernel:  do_dentry_open+0x13d/0x3a0
Feb 19 16:48:14 bhasus kernel:  path_openat+0x592/0x1550
Feb 19 16:48:14 bhasus kernel:  ? filemap_map_pages+0x27a/0x3a0
Feb 19 16:48:14 bhasus kernel:  do_filp_open+0xab/0x120
Feb 19 16:48:14 bhasus kernel:  do_sys_open+0x19e/0x240
Feb 19 16:48:14 bhasus kernel:  do_syscall_64+0x4e/0x150
Feb 19 16:48:14 bhasus kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xa9
Feb 19 16:48:14 bhasus kernel: RIP: 0033:0x5653bc21a75a
Feb 19 16:48:14 bhasus kernel: Code: e8 3b 5a f8 ff 48 8b 7c 24 10 48 8b 74 24
18 48 8b 54 24 20 4c 8b 54 24 28 4c 8b 44 24 30 4c 8b 4c 24 38 48 8b 44 24 08
0f 05 <48> 3d 01 f0 ff ff 76 20 48 c7 44 24 40 ff ff ff ff 48 c7 44 24 48
Feb 19 16:48:14 bhasus kernel: RSP: 002b:000000c0000b1bc0 EFLAGS: 00000206
ORIG_RAX: 0000000000000101
Feb 19 16:48:14 bhasus kernel: RAX: ffffffffffffffda RBX: 000000c000022500 RCX:
00005653bc21a75a
Feb 19 16:48:14 bhasus kernel: RDX: 0000000000080000 RSI: 000000c00008e6c0 RDI:
ffffffffffffff9c
Feb 19 16:48:14 bhasus kernel: RBP: 000000c0000b1c38 R08: 0000000000000000 R09:
0000000000000000
Feb 19 16:48:14 bhasus kernel: R10: 0000000000000000 R11: 0000000000000206 R12:
000000000000006d
Feb 19 16:48:14 bhasus kernel: R13: 000000000000006c R14: 0000000000000200 R15:
0000000000000034
Feb 19 16:48:22 bhasus kernel: watchdog: BUG: soft lockup - CPU#4 stuck for
23s! [runc:790434]
Feb 19 16:48:22 bhasus kernel: Modules linked in: authenc echainiv esp4
xt_state nf_nat_h323 nf_conntrack_h323 nf_nat_pptp nf_conntrack_pptp
nf_nat_tftp nf_conntrack_tftp nf_nat_sip nf_conntrack_sip nf_nat_irc
nf_conntrack_irc nf_nat_ftp nf_conntrack_ftp fuse xt_nat vet>
Feb 19 16:48:22 bhasus kernel:  mac80211 kvm_intel snd_sof nls_iso8859_1
snd_hda_codec_realtek btusb nls_cp437 snd_hda_ext_core nvidia_drm(POE)
snd_soc_acpi_intel_match snd_hda_codec_generic nvidia_modeset(POE) vfat btrtl
snd_soc_acpi btbcm fat btintel libarc4 snd_soc_c>
Feb 19 16:48:22 bhasus kernel:  crc32c_generic crc16 mbcache jbd2 hid_generic
usbhid hid dm_crypt dm_mod crct10dif_pclmul crc32_pclmul crc32c_intel serio_raw
atkbd ghash_clmulni_intel libps2 ahci libahci xhci_pci aesni_intel libata
crypto_simd cryptd scsi_mod xhci_hcd g>
Feb 19 16:48:22 bhasus kernel: CPU: 4 PID: 790434 Comm: runc Tainted: P      D 
  OEL    5.5.4-arch1-1 #1
Feb 19 16:48:22 bhasus kernel: Hardware name: ASUSTeK COMPUTER INC. ROG Strix
G531GT_G531GT/G531GT, BIOS G531GT.305 09/24/2019
Feb 19 16:48:22 bhasus kernel: RIP: 0010:smp_call_function_single+0x135/0x170
Feb 19 16:48:22 bhasus kernel: Code: 85 c0 75 84 0f 0b eb 80 e8 f8 6c 34 00 48
c7 c3 00 de 02 00 89 c0 48 03 1c c5 20 59 5b b3 8b 43 18 48 89 de a8 01 74 09
f3 90 <8b> 46 18 a8 01 75 f7 83 4e 18 01 44 89 e7 4c 89 f1 4c 89 ea e8 c2
Feb 19 16:48:22 bhasus kernel: RSP: 0018:ffff9f8d48cb3bc0 EFLAGS: 00000202
ORIG_RAX: ffffffffffffff13
Feb 19 16:48:22 bhasus kernel: RAX: 0000000000000001 RBX: ffff9ce81db2de00 RCX:
0000000000000000
Feb 19 16:48:22 bhasus kernel: RDX: 0000000000000000 RSI: ffff9ce81db2de00 RDI:
ffffffffb359a628
Feb 19 16:48:22 bhasus kernel: RBP: ffff9f8d48cb3c30 R08: ffffffffb39476e0 R09:
ffff9ce5a254c528
Feb 19 16:48:22 bhasus kernel: R10: ffff9ce64d297540 R11: 0000000000000000 R12:
0000000000000002
Feb 19 16:48:22 bhasus kernel: R13: ffffffffb24417a0 R14: 0000000000000000 R15:
0000000000000000
Feb 19 16:48:22 bhasus kernel: FS:  00007f34c5edc740(0000)
GS:ffff9ce81db00000(0000) knlGS:0000000000000000
Feb 19 16:48:22 bhasus kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Feb 19 16:48:22 bhasus kernel: CR2: 000000c0000bc000 CR3: 00000006fbd4e002 CR4:
00000000003606e0
Feb 19 16:48:22 bhasus kernel: Call Trace:
Feb 19 16:48:22 bhasus kernel:  aperfmperf_snapshot_cpu+0x40/0x50
Feb 19 16:48:22 bhasus kernel:  arch_freq_prepare_all+0x5e/0xa0
Feb 19 16:48:22 bhasus kernel:  cpuinfo_open+0xe/0x20
Feb 19 16:48:22 bhasus kernel:  proc_reg_open+0x6e/0x120
Feb 19 16:48:22 bhasus kernel:  ? proc_put_link+0x10/0x10
Feb 19 16:48:22 bhasus kernel:  do_dentry_open+0x13d/0x3a0
Feb 19 16:48:22 bhasus kernel:  path_openat+0x592/0x1550
Feb 19 16:48:22 bhasus kernel:  ? __count_memcg_events+0x52/0xb0
Feb 19 16:48:22 bhasus kernel:  do_filp_open+0xab/0x120
Feb 19 16:48:22 bhasus kernel:  do_sys_open+0x19e/0x240
Feb 19 16:48:22 bhasus kernel:  do_syscall_64+0x4e/0x150
Feb 19 16:48:22 bhasus kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xa9
Feb 19 16:48:22 bhasus kernel: RIP: 0033:0x560ca007475a
Feb 19 16:48:22 bhasus kernel: Code: e8 3b 5a f8 ff 48 8b 7c 24 10 48 8b 74 24
18 48 8b 54 24 20 4c 8b 54 24 28 4c 8b 44 24 30 4c 8b 4c 24 38 48 8b 44 24 08
0f 05 <48> 3d 01 f0 ff ff 76 20 48 c7 44 24 40 ff ff ff ff 48 c7 44 24 48
Feb 19 16:48:22 bhasus kernel: RSP: 002b:000000c0000b1bc0 EFLAGS: 00000206
ORIG_RAX: 0000000000000101
Feb 19 16:48:22 bhasus kernel: RAX: ffffffffffffffda RBX: 000000c000022500 RCX:
0000560ca007475a
Feb 19 16:48:22 bhasus kernel: RDX: 0000000000080000 RSI: 000000c00008e6c0 RDI:
ffffffffffffff9c
Feb 19 16:48:22 bhasus kernel: RBP: 000000c0000b1c38 R08: 0000000000000000 R09:
0000000000000000
Feb 19 16:48:22 bhasus kernel: R10: 0000000000000000 R11: 0000000000000206 R12:
000000000000006d
Feb 19 16:48:22 bhasus kernel: R13: 000000000000006c R14: 0000000000000200 R15:
0000000000000034
Feb 19 16:48:22 bhasus kernel: watchdog: BUG: soft lockup - CPU#5 stuck for
23s! [runc:790439]
Feb 19 16:48:22 bhasus kernel: Modules linked in: authenc echainiv esp4
xt_state nf_nat_h323 nf_conntrack_h323 nf_nat_pptp nf_conntrack_pptp
nf_nat_tftp nf_conntrack_tftp nf_nat_sip nf_conntrack_sip nf_nat_irc
nf_conntrack_irc nf_nat_ftp nf_conntrack_ftp fuse xt_nat vet>
Feb 19 16:48:22 bhasus kernel:  mac80211 kvm_intel snd_sof nls_iso8859_1
snd_hda_codec_realtek btusb nls_cp437 snd_hda_ext_core nvidia_drm(POE)
snd_soc_acpi_intel_match snd_hda_codec_generic nvidia_modeset(POE) vfat btrtl
snd_soc_acpi btbcm fat btintel libarc4 snd_soc_c>
Feb 19 16:48:22 bhasus kernel:  crc32c_generic crc16 mbcache jbd2 hid_generic
usbhid hid dm_crypt dm_mod crct10dif_pclmul crc32_pclmul crc32c_intel serio_raw
atkbd ghash_clmulni_intel libps2 ahci libahci xhci_pci aesni_intel libata
crypto_simd cryptd scsi_mod xhci_hcd g>
Feb 19 16:48:22 bhasus kernel: CPU: 5 PID: 790439 Comm: runc Tainted: P      D 
  OEL    5.5.4-arch1-1 #1
Feb 19 16:48:22 bhasus kernel: Hardware name: ASUSTeK COMPUTER INC. ROG Strix
G531GT_G531GT/G531GT, BIOS G531GT.305 09/24/2019
Feb 19 16:48:22 bhasus kernel: RIP: 0010:smp_call_function_single+0x135/0x170
Feb 19 16:48:22 bhasus kernel: Code: 85 c0 75 84 0f 0b eb 80 e8 f8 6c 34 00 48
c7 c3 00 de 02 00 89 c0 48 03 1c c5 20 59 5b b3 8b 43 18 48 89 de a8 01 74 09
f3 90 <8b> 46 18 a8 01 75 f7 83 4e 18 01 44 89 e7 4c 89 f1 4c 89 ea e8 c2
Feb 19 16:48:22 bhasus kernel: RSP: 0018:ffff9f8d48e77bc0 EFLAGS: 00000202
ORIG_RAX: ffffffffffffff13
Feb 19 16:48:22 bhasus kernel: RAX: 0000000000000001 RBX: ffff9ce81db6de00 RCX:
0000000000000000
Feb 19 16:48:22 bhasus kernel: RDX: 0000000000000000 RSI: ffff9ce81db6de00 RDI:
ffffffffb359a628
Feb 19 16:48:22 bhasus kernel: RBP: ffff9f8d48e77c30 R08: ffffffffb39476e0 R09:
ffff9ce726408b18
Feb 19 16:48:22 bhasus kernel: R10: ffff9ce64d297540 R11: 0000000000000000 R12:
0000000000000002
Feb 19 16:48:22 bhasus kernel: R13: ffffffffb24417a0 R14: 0000000000000000 R15:
0000000000000000
Feb 19 16:48:22 bhasus kernel: FS:  00007f9bb9521740(0000)
GS:ffff9ce81db40000(0000) knlGS:0000000000000000
Feb 19 16:48:22 bhasus kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Feb 19 16:48:22 bhasus kernel: CR2: 000000c0000a41a0 CR3: 000000049c0bc003 CR4:
00000000003606e0
Feb 19 16:48:22 bhasus kernel: Call Trace:
Feb 19 16:48:22 bhasus kernel:  aperfmperf_snapshot_cpu+0x40/0x50
Feb 19 16:48:22 bhasus kernel:  arch_freq_prepare_all+0x5e/0xa0
Feb 19 16:48:22 bhasus kernel:  cpuinfo_open+0xe/0x20
Feb 19 16:48:22 bhasus kernel:  proc_reg_open+0x6e/0x120
Feb 19 16:48:22 bhasus kernel:  ? proc_put_link+0x10/0x10
Feb 19 16:48:22 bhasus kernel:  do_dentry_open+0x13d/0x3a0
Feb 19 16:48:22 bhasus kernel:  path_openat+0x592/0x1550
Feb 19 16:48:22 bhasus kernel:  ? mem_cgroup_commit_charge+0x73/0x140
Feb 19 16:48:22 bhasus kernel:  ? wp_page_copy+0x52a/0x770
Feb 19 16:48:22 bhasus kernel:  do_filp_open+0xab/0x120
Feb 19 16:48:22 bhasus kernel:  do_sys_open+0x19e/0x240
Feb 19 16:48:22 bhasus kernel:  do_syscall_64+0x4e/0x150
Feb 19 16:48:22 bhasus kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xa9
Feb 19 16:48:22 bhasus kernel: RIP: 0033:0x55eb9401775a
Feb 19 16:48:22 bhasus kernel: Code: e8 3b 5a f8 ff 48 8b 7c 24 10 48 8b 74 24
18 48 8b 54 24 20 4c 8b 54 24 28 4c 8b 44 24 30 4c 8b 4c 24 38 48 8b 44 24 08
0f 05 <48> 3d 01 f0 ff ff 76 20 48 c7 44 24 40 ff ff ff ff 48 c7 44 24 48
Feb 19 16:48:22 bhasus kernel: RSP: 002b:000000c000097bc0 EFLAGS: 00000206
ORIG_RAX: 0000000000000101
Feb 19 16:48:22 bhasus kernel: RAX: ffffffffffffffda RBX: 000000c000020000 RCX:
000055eb9401775a
Feb 19 16:48:22 bhasus kernel: RDX: 0000000000080000 RSI: 000000c0000166f0 RDI:
ffffffffffffff9c
Feb 19 16:48:22 bhasus kernel: RBP: 000000c000097c38 R08: 0000000000000000 R09:
0000000000000000
Feb 19 16:48:22 bhasus kernel: R10: 0000000000000000 R11: 0000000000000206 R12:
0000000000000070
Feb 19 16:48:22 bhasus kernel: R13: 000000000000006f R14: 0000000000000200 R15:
0000000000000034
Feb 19 16:48:22 bhasus kernel: watchdog: BUG: soft lockup - CPU#6 stuck for
23s! [runc:790444]
Feb 19 16:48:22 bhasus kernel: Modules linked in: authenc echainiv esp4
xt_state nf_nat_h323 nf_conntrack_h323 nf_nat_pptp nf_conntrack_pptp
nf_nat_tftp nf_conntrack_tftp nf_nat_sip nf_conntrack_sip nf_nat_irc
nf_conntrack_irc nf_nat_ftp nf_conntrack_ftp fuse xt_nat vet>
Feb 19 16:48:22 bhasus kernel:  mac80211 kvm_intel snd_sof nls_iso8859_1
snd_hda_codec_realtek btusb nls_cp437 snd_hda_ext_core nvidia_drm(POE)
snd_soc_acpi_intel_match snd_hda_codec_generic nvidia_modeset(POE) vfat btrtl
snd_soc_acpi btbcm fat btintel libarc4 snd_soc_c>
Feb 19 16:48:22 bhasus kernel:  crc32c_generic crc16 mbcache jbd2 hid_generic
usbhid hid dm_crypt dm_mod crct10dif_pclmul crc32_pclmul crc32c_intel serio_raw
atkbd ghash_clmulni_intel libps2 ahci libahci xhci_pci aesni_intel libata
crypto_simd cryptd scsi_mod xhci_hcd g>
Feb 19 16:48:22 bhasus kernel: CPU: 6 PID: 790444 Comm: runc Tainted: P      D 
  OEL    5.5.4-arch1-1 #1
Feb 19 16:48:22 bhasus kernel: Hardware name: ASUSTeK COMPUTER INC. ROG Strix
G531GT_G531GT/G531GT, BIOS G531GT.305 09/24/2019
Feb 19 16:48:22 bhasus kernel: RIP: 0010:smp_call_function_single+0x135/0x170
Feb 19 16:48:22 bhasus kernel: Code: 85 c0 75 84 0f 0b eb 80 e8 f8 6c 34 00 48
c7 c3 00 de 02 00 89 c0 48 03 1c c5 20 59 5b b3 8b 43 18 48 89 de a8 01 74 09
f3 90 <8b> 46 18 a8 01 75 f7 83 4e 18 01 44 89 e7 4c 89 f1 4c 89 ea e8 c2
Feb 19 16:48:22 bhasus kernel: RSP: 0018:ffff9f8d4848fbc0 EFLAGS: 00000202
ORIG_RAX: ffffffffffffff13
Feb 19 16:48:22 bhasus kernel: RAX: 0000000000000001 RBX: ffff9ce81dbade00 RCX:
0000000000000000
Feb 19 16:48:22 bhasus kernel: RDX: 0000000000000000 RSI: ffff9ce81dbade00 RDI:
ffffffffb359a628
Feb 19 16:48:22 bhasus kernel: RBP: ffff9f8d4848fc30 R08: ffffffffb39476e0 R09:
ffff9ce682506aa0
Feb 19 16:48:22 bhasus kernel: R10: ffff9ce64d297540 R11: 0000000000000000 R12:
0000000000000002
Feb 19 16:48:22 bhasus kernel: R13: ffffffffb24417a0 R14: 0000000000000000 R15:
0000000000000000
Feb 19 16:48:22 bhasus kernel: FS:  00007f48558a4740(0000)
GS:ffff9ce81db80000(0000) knlGS:0000000000000000
Feb 19 16:48:22 bhasus kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Feb 19 16:48:22 bhasus kernel: CR2: 000000c0000bc000 CR3: 0000000232ade003 CR4:
00000000003606e0
Feb 19 16:48:22 bhasus kernel: Call Trace:
Feb 19 16:48:22 bhasus kernel:  aperfmperf_snapshot_cpu+0x40/0x50
Feb 19 16:48:22 bhasus kernel:  arch_freq_prepare_all+0x5e/0xa0
Feb 19 16:48:22 bhasus kernel:  cpuinfo_open+0xe/0x20
Feb 19 16:48:22 bhasus kernel:  proc_reg_open+0x6e/0x120
Feb 19 16:48:22 bhasus kernel:  ? proc_put_link+0x10/0x10
Feb 19 16:48:22 bhasus kernel:  do_dentry_open+0x13d/0x3a0
Feb 19 16:48:22 bhasus kernel:  path_openat+0x592/0x1550
Feb 19 16:48:22 bhasus kernel:  ? __count_memcg_events+0x52/0xb0
Feb 19 16:48:22 bhasus kernel:  do_filp_open+0xab/0x120
Feb 19 16:48:22 bhasus kernel:  do_sys_open+0x19e/0x240
Feb 19 16:48:22 bhasus kernel:  do_syscall_64+0x4e/0x150
Feb 19 16:48:22 bhasus kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xa9
Feb 19 16:48:22 bhasus kernel: RIP: 0033:0x563718eaf75a
Feb 19 16:48:22 bhasus kernel: Code: e8 3b 5a f8 ff 48 8b 7c 24 10 48 8b 74 24
18 48 8b 54 24 20 4c 8b 54 24 28 4c 8b 44 24 30 4c 8b 4c 24 38 48 8b 44 24 08
0f 05 <48> 3d 01 f0 ff ff 76 20 48 c7 44 24 40 ff ff ff ff 48 c7 44 24 48
Feb 19 16:48:22 bhasus kernel: RSP: 002b:000000c0000b1bc0 EFLAGS: 00000206
ORIG_RAX: 0000000000000101
Feb 19 16:48:22 bhasus kernel: RAX: ffffffffffffffda RBX: 000000c000022500 RCX:
0000563718eaf75a
Feb 19 16:48:22 bhasus kernel: RDX: 0000000000080000 RSI: 000000c00008e6c0 RDI:
ffffffffffffff9c
Feb 19 16:48:22 bhasus kernel: RBP: 000000c0000b1c38 R08: 0000000000000000 R09:
0000000000000000
Feb 19 16:48:22 bhasus kernel: R10: 0000000000000000 R11: 0000000000000206 R12:
000000000000006d
Feb 19 16:48:22 bhasus kernel: R13: 000000000000006c R14: 0000000000000200 R15:
0000000000000034
Feb 19 16:48:30 bhasus kernel: iwlwifi 0000:00:14.3: Error sending
STATISTICS_CMD: time out after 2000ms.
Feb 19 16:48:30 bhasus kernel: iwlwifi 0000:00:14.3: Current CMD queue read_ptr
48 write_ptr 49
Feb 19 16:48:30 bhasus kernel: iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
Feb 19 16:48:30 bhasus kernel: iwlwifi 0000:00:14.3: Status: 0x00000040, count:
6
Feb 19 16:48:30 bhasus kernel: iwlwifi 0000:00:14.3: Loaded firmware version:
46.ceaaecdc.0
Feb 19 16:48:30 bhasus kernel: iwlwifi 0000:00:14.3: 0x00000084 |
NMI_INTERRUPT_UNKNOWN       
Feb 19 16:48:30 bhasus kernel: iwlwifi 0000:00:14.3: 0x000022F0 |
trm_hw_status0

-- 
You are receiving this mail because:
You are the assignee for the bug.
