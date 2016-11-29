Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: "P. Christeas" <xrg@linux.gr>
To: linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: BUG: oops and lock with rfcomm, while connecting
Date: Tue, 29 Nov 2016 22:32:12 +0200
Message-ID: <2290847.AYg7xiucGy@xorhgos3.pefnos>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart1992443.vBt2RZCVju"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.

--nextPart1992443.vBt2RZCVju
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi, 
I would appreciate if somebody can take a quick look and tell me if the 
attached trace makes any sense. 

Story is, this happened while trying to connect ppp over BT, with USB external 
dongle and device (bt phone) in range.

Kernel is Linus's latest, but I suspect the bug is a one-off probability that 
just happened to me here, not strictly contained to this latest version. I 
will be trying to reproduce it in the next days.
All the attached trace was logged at the same sec.

Thank you.

--nextPart1992443.vBt2RZCVju
Content-Disposition: inline; filename="oops-2016-11-29-1.txt"
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; name="oops-2016-11-29-1.txt"

general protection fault: 0000 [#1] PREEMPT SMP
Modules linked in: ppp_deflate bsd_comp rfcomm bnep btusb btrtl btbcm btintel bluetooth xt_CHECKSUM iptable_mangle ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack ipt_REJECT nf_reject_ipv4 xt_tcpudp tun bridge stp llc ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter ip_tables x_tables ctr ccm af_packet ath9k ath9k_common ath9k_hw ath ppp_async ppp_generic slhc capi kernelcapi binfmt_misc msr iTCO_wdt iTCO_vendor_support arc4 uvcvideo videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 videobuf2_core videodev media iwl4965 iwlegacy acer_wmi mac80211 sparse_keymap cfg80211 snd_hda_codec_hdmi coretemp snd_hda_codec_realtek joydev snd_hda_codec_generic i2c_i801 i2c_smbus snd_hda_intel tg3 rfkill
 lpc_ich mfd_core snd_hda_codec ptp pps_core nsc_ircc libphy snd_hda_core irda wmi snd_hwdep snd_pcm thermal snd_timer battery ac snd mac_hid soundcore tpm_tis tpm_tis_core tpm cpufreq_conservative cpufreq_powersave acpi_cpufreq evdev tifm_sd tifm_7xx1 tifm_core sdhci_pci nvram sg nfsd auth_rpcgss oid_registry exportfs nfs_acl lockd grace sunrpc ipv6 crc_ccitt autofs4 ext4 crc16 jbd2 fscrypto pcmcia uhci_hcd ehci_pci mmc_block ehci_hcd sdhci usbcore serio_raw mmc_core sd_mod yenta_socket sr_mod pcmcia_rsrc pcmcia_core usb_common i915 video button i2c_algo_bit drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops drm i2c_core ahci libahci ata_generic pata_acpi ata_piix libata scsi_mod
CPU: 1 PID: 21933 Comm: ppp-watch Tainted: G     U  W       4.9.0-rc7xrg3 #1
Hardware name: Acer            Extensa 5620                   /Columbia                       , BIOS V1.32           02/01/2008
task: ffff88004cb4a640 task.stack: ffffc90001504000
RIP: 0010:[<ffffffff815b8b03>]  [<ffffffff815b8b03>] skb_queue_tail+0x68/0x89
RSP: 0018:ffffc90001507c58  EFLAGS: 00010006
RAX: 0000000000000286 RBX: ffff88002b514c18 RCX: 0000000000000000
RDX: 0000000000000001 RSI: ffff8800b982ec00 RDI: ffff88002b514c30
RBP: ffffc90001507c80 R08: 0000000000000000 R09: 0000000000000000
R10: ffffc90001507d98 R11: ffff88004cb4a640 R12: ffff8800b982ec00
R13: 0020050000000000 R14: ffff88002b514c30 R15: 0000000000000286
FS:  00007f7da8bca700(0000) GS:ffff8800bf300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000001619de8 CR3: 0000000050640000 CR4: 00000000000006e0
Stack:
 ffff88002b514c00 ffff8800b982ec00 ffff880078290400 ffff88002b514c00
 ffff8800b982ec00 ffffc90001507ca8 ffffffffa1128360 0000000000000009
 0000000000000001 0000000000000001 ffffc90001507d08 ffffffffa112d91f
Call Trace:
 [<ffffffffa1128360>] rfcomm_dlc_send_noerror+0x54/0xd1 [rfcomm]
 [<ffffffffa112d91f>] rfcomm_tty_write+0x128/0x19f [rfcomm]
 [<ffffffff81480709>] n_tty_write+0x4e9/0x591
 [<ffffffff810cb84a>] ? wake_atomic_t_function+0x95/0x95
 [<ffffffff8147bfe2>] tty_write+0x23a/0x307
 [<ffffffff81480220>] ? signal_pending+0x28/0x28
 [<ffffffff81230294>] __vfs_write+0x5e/0x11a
 [<ffffffff812fe3c1>] ? security_file_permission+0x4f/0x56
 [<ffffffff812313a4>] ? rw_verify_area+0x11a/0x126
 [<ffffffff812315b2>] vfs_write+0xd4/0x143
 [<ffffffff8123277d>] SyS_write+0x4b/0x79
 [<ffffffff81002f3b>] do_syscall_64+0x7f/0x92
 [<ffffffff816d38c6>] entry_SYSCALL64_slow_path+0x25/0x25
Code: 0e 31 f6 48 c7 c7 40 7d 05 82 e8 4e b7 df ff 4d 85 ed 49 89 1c 24 4d 89 6c 24 08 75 0e 31 f6 48 c7 c7 00 7d 05 82 e8 32 b7 df ff <4d> 89 65 00 4c 89 fe 4c 89 f7 ff 43 10 4c 89 63 08 e8 83 a9 11 
RIP 
 [<ffffffff815b8b03>] skb_queue_tail+0x68/0x89
 RSP <ffffc90001507c58>
---[ end trace 9340916f4aeec733 ]---


BUG: sleeping function called from invalid context at ./include/linux/sched.h:3111
in_atomic(): 1, irqs_disabled(): 1, pid: 21933, name: ppp-watch
Preemption disabled at:
[<ffffffff810adca4>] preempt_count_add+0x60/0x63
CPU: 1 PID: 21933 Comm: ppp-watch Tainted: G     UD W       4.9.0-rc7xrg3 #1
Hardware name: Acer            Extensa 5620                   /Columbia                       , BIOS V1.32           02/01/2008
 ffffc90001507e28 ffffffff8136f227 0000000000000082 0000000000000001
 0000000000000000 ffffc90001507e60 ffffffff810ae3f9 ffff88004cb4a640
 ffffffff81904b66 0000000000000c27 0000000000000000 0000000000000286
Call Trace:
 [<ffffffff8136f227>] dump_stack+0x50/0x6e
 [<ffffffff810ae3f9>] ___might_sleep+0x23d/0x254
 [<ffffffff810ae49f>] __might_sleep+0x8f/0x130
 [<ffffffff8108ff11>] exit_signals+0x1e/0x1ac
 [<ffffffff8107f94b>] do_exit+0x1a6/0xf40
 [<ffffffff816d5857>] rewind_stack_do_exit+0x17/0x20
note: ppp-watch[21933] exited with preempt_count 1

--nextPart1992443.vBt2RZCVju--

