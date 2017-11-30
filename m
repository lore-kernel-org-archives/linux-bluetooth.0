Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@kernel.org
Subject: [Bug 198043] New: Bluetooth mgmt api set powered causes kernel race
 condition
Date: Thu, 30 Nov 2017 13:22:45 +0000
Message-ID: <bug-198043-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=198043

            Bug ID: 198043
           Summary: Bluetooth mgmt api set powered causes kernel race
                    condition
           Product: Drivers
           Version: 2.5
    Kernel Version: 4.10
          Hardware: Other
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: blocking
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: matias.karhumaa@gmail.com
        Regression: No

It seems that Bluetooth management api set powered command and socket close may
cause some kind of race condition in kernel. I used CSR 8510 Nanosira Bluetooth
dongle on Ubuntu 16.04.3 LTS, Linux 4.10.0-40-generic #44~16.04.1-Ubuntu SMP
Thu Nov 9 15:37:44 UTC 2017. I am able to reproduce this with simple proof of
concept code by just looping following sequence:

* Open management socket
* send Set Powered off command
* send Set Powered on command
* close management socket

Running btmon at a same time causes hang too but gives different call trace.

Here is a original snippet from kern.log:

Nov 30 08:11:45 makarhum-e6330 kernel: [86926.837240] NMI watchdog: BUG: soft
lockup - CPU#0 stuck for 22s! [java:22267]
Nov 30 08:11:45 makarhum-e6330 kernel: [86926.837243] Modules linked in:
nfnetlink_queue nfnetlink_log pci_stub vboxpci(OE) vboxnetadp(OE)
vboxnetflt(OE) vboxdrv(OE) ipt_MASQUERADE nf_na
t_masquerade_ipv4 nf_conntrack_netlink nfnetlink xfrm_user xfrm_algo
iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 xt_addrtype
iptable_filter ip_tables xt_conntrack x_tables n
f_nat nf_conntrack libcrc32c br_netfilter bridge stp llc aufs bnep binfmt_misc
nls_iso8859_1 dm_crypt dell_wmi sparse_keymap intel_rapl x86_pkg_temp_thermal
intel_powerclamp coretemp kvm
_intel snd_hda_codec_hdmi kvm irqbypass crct10dif_pclmul crc32_pclmul
ghash_clmulni_intel pcbc dell_laptop dell_smbios dcdbas snd_hda_codec_idt
snd_hda_codec_generic dell_smm_hwmon snd_h
da_intel btusb btrtl snd_hda_codec btbcm btintel snd_hda_core snd_hwdep
bluetooth snd_pcm aesni_intel arc4
Nov 30 08:11:45 makarhum-e6330 kernel: [86926.837268]  aes_x86_64 crypto_simd
glue_helper cryptd snd_seq_midi snd_seq_midi_event snd_rawmidi intel_cstate
intel_rapl_perf iwldvm joydev in
put_leds mac80211 serio_raw snd_seq iwlwifi snd_seq_device snd_timer cfg80211
snd lpc_ich soundcore mei_me mei shpchp mac_hid dell_rbtn dell_smo8800
parport_pc ppdev lp parport autofs4 i
915 psmouse i2c_algo_bit drm_kms_helper syscopyarea ahci sysfillrect sysimgblt
e1000e fb_sys_fops libahci sdhci_pci drm sdhci ptp pps_core wmi fjes video
Nov 30 08:11:45 makarhum-e6330 kernel: [86926.837287] CPU: 0 PID: 22267 Comm:
java Tainted: G           OE   4.10.0-40-generic #44~16.04.1-Ubuntu
Nov 30 08:11:45 makarhum-e6330 kernel: [86926.837287] Hardware name: Dell Inc.
Latitude E6330/0JTDD3, BIOS A08 12/10/2012
Nov 30 08:11:45 makarhum-e6330 kernel: [86926.837288] task: ffff8b40d08ac380
task.stack: ffffa3aac3634000
Nov 30 08:11:45 makarhum-e6330 kernel: [86926.837292] RIP:
0010:queued_write_lock_slowpath+0x55/0x90
Nov 30 08:11:45 makarhum-e6330 kernel: [86926.837292] RSP:
0018:ffffa3aac3637dd0 EFLAGS: 00000206 ORIG_RAX: ffffffffffffff10
Nov 30 08:11:45 makarhum-e6330 kernel: [86926.837293] RAX: 0000000000000101
RBX: ffffffffc09badc8 RCX: 0000000000000000
Nov 30 08:11:45 makarhum-e6330 kernel: [86926.837294] RDX: 00000000000000ff
RSI: ffff8b40cb16b800 RDI: ffffffffc09badc8
Nov 30 08:11:45 makarhum-e6330 kernel: [86926.837294] RBP: ffffa3aac3637de0
R08: 0000000000000000 R09: 0000000000000000
Nov 30 08:11:45 makarhum-e6330 kernel: [86926.837295] R10: 0000000000000002
R11: ffff8b40169ebc00 R12: ffffffffc09badcc
Nov 30 08:11:45 makarhum-e6330 kernel: [86926.837295] R13: ffff8b4077cb3c00
R14: ffff8b40d49aef20 R15: ffff8b4071989a80
Nov 30 08:11:45 makarhum-e6330 kernel: [86926.837296] FS: 
00007f4af269c700(0000) GS:ffff8b40de200000(0000) knlGS:0000000000000000
Nov 30 08:11:45 makarhum-e6330 kernel: [86926.837297] CS:  0010 DS: 0000 ES:
0000 CR0: 0000000080050033
Nov 30 08:11:45 makarhum-e6330 kernel: [86926.837297] CR2: 00007f4af1443040
CR3: 000000018def9000 CR4: 00000000001406f0
Nov 30 08:11:45 makarhum-e6330 kernel: [86926.837298] Call Trace:
Nov 30 08:11:45 makarhum-e6330 kernel: [86926.837302] 
_raw_write_lock+0x1e/0x20
Nov 30 08:11:45 makarhum-e6330 kernel: [86926.837314]  bt_sock_unlink+0x1b/0x70
[bluetooth]
Nov 30 08:11:45 makarhum-e6330 kernel: [86926.837323] 
hci_sock_release+0x57/0x1c0 [bluetooth]
Nov 30 08:11:45 makarhum-e6330 kernel: [86926.837324]  sock_release+0x1f/0x80
Nov 30 08:11:45 makarhum-e6330 kernel: [86926.837325]  sock_close+0x12/0x20
Nov 30 08:11:45 makarhum-e6330 kernel: [86926.837327]  __fput+0xe7/0x220
Nov 30 08:11:45 makarhum-e6330 kernel: [86926.837328]  ____fput+0xe/0x10
Nov 30 08:11:45 makarhum-e6330 kernel: [86926.837329]  task_work_run+0x7e/0xa0
Nov 30 08:11:45 makarhum-e6330 kernel: [86926.837331] 
exit_to_usermode_loop+0xaa/0xb0
Nov 30 08:11:45 makarhum-e6330 kernel: [86926.837332] 
syscall_return_slowpath+0x59/0x60
Nov 30 08:11:45 makarhum-e6330 kernel: [86926.837333] 
entry_SYSCALL_64_fastpath+0xab/0xad
Nov 30 08:11:45 makarhum-e6330 kernel: [86926.837334] RIP: 0033:0x7f4b11b2b8dd
Nov 30 08:11:45 makarhum-e6330 kernel: [86926.837335] RSP:
002b:00007f4af269ac50 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
Nov 30 08:11:45 makarhum-e6330 kernel: [86926.837335] RAX: 0000000000000000
RBX: 00007f4af269ac80 RCX: 00007f4b11b2b8dd
Nov 30 08:11:45 makarhum-e6330 kernel: [86926.837336] RDX: 00007f4aa0024df0
RSI: 00007f4aa0000028 RDI: 0000000000000020
Nov 30 08:11:45 makarhum-e6330 kernel: [86926.837336] RBP: 00007f4af269ac80
R08: 00007f4aa0025070 R09: 00007f4ac04a0400
Nov 30 08:11:45 makarhum-e6330 kernel: [86926.837337] R10: 00000000000003e9
R11: 0000000000000293 R12: 00007f4aa0025070
Nov 30 08:11:45 makarhum-e6330 kernel: [86926.837337] R13: 00007f4aa0024e00
R14: 00007f4af269ad58 R15: 00007f4ac04b9800
Nov 30 08:11:45 makarhum-e6330 kernel: [86926.837338] Code: ff 00 00 00 f0 0f
b1 13 85 c0 74 31 ba 01 00 00 00 eb 02 f3 90 0f b6 03 84 c0 75 f7 f0 0f b0 13
84 c0 75 ef ba ff 00 00 00 eb
02 <f3> 90 8b 03 83 f8 01 75 f7 f0 0f b1 13 83 f8 01 75 ee 4c 89 e7
Nov 30 08:11:45 makarhum-e6330 kernel: [86926.845241] NMI watchdog: BUG: soft
lockup - CPU#3 stuck for 22s! [kworker/u9:2:13920]
Nov 30 08:11:45 makarhum-e6330 kernel: [86926.845244] Modules linked in:
nfnetlink_queue nfnetlink_log pci_stub vboxpci(OE) vboxnetadp(OE)
vboxnetflt(OE) vboxdrv(OE) ipt_MASQUERADE nf_na
t_masquerade_ipv4 nf_conntrack_netlink nfnetlink xfrm_user xfrm_algo
iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 xt_addrtype
iptable_filter ip_tables xt_conntrack x_tables n
f_nat nf_conntrack libcrc32c br_netfilter bridge stp llc aufs bnep binfmt_misc
nls_iso8859_1 dm_crypt dell_wmi sparse_keymap intel_rapl x86_pkg_temp_thermal
intel_powerclamp coretemp kvm
_intel snd_hda_codec_hdmi kvm irqbypass crct10dif_pclmul crc32_pclmul
ghash_clmulni_intel pcbc dell_laptop dell_smbios dcdbas snd_hda_codec_idt
snd_hda_codec_generic dell_smm_hwmon snd_hda_intel btusb btrtl snd_hda_codec
btbcm btintel snd_hda_core snd_hwdep bluetooth snd_pcm aesni_intel arc4
Nov 30 08:11:45 makarhum-e6330 kernel: [86926.845270]  aes_x86_64 crypto_simd
glue_helper cryptd snd_seq_midi snd_seq_midi_event snd_rawmidi intel_cstate
intel_rapl_perf iwldvm joydev input_leds mac80211 serio_raw snd_seq iwlwifi
snd_seq_device snd_timer cfg80211 snd lpc_ich soundcore mei_me mei shpchp
mac_hid dell_rbtn dell_smo8800 parport_pc ppdev lp parport autofs4 i915 psmouse
i2c_algo_bit drm_kms_helper syscopyarea ahci sysfillrect sysimgblt e1000e
fb_sys_fops libahci sdhci_pci drm sdhci ptp pps_core wmi fjes video
Nov 30 08:11:45 makarhum-e6330 kernel: [86926.845288] CPU: 3 PID: 13920 Comm:
kworker/u9:2 Tainted: G           OEL  4.10.0-40-generic #44~16.04.1-Ubuntu
Nov 30 08:11:45 makarhum-e6330 kernel: [86926.845289] Hardware name: Dell Inc.
Latitude E6330/0JTDD3, BIOS A08 12/10/2012
Nov 30 08:11:45 makarhum-e6330 kernel: [86926.845304] Workqueue: hci0
hci_power_off [bluetooth]
Nov 30 08:11:45 makarhum-e6330 kernel: [86926.845305] task: ffff8b40cd149680
task.stack: ffffa3aac0e4c000
Nov 30 08:11:45 makarhum-e6330 kernel: [86926.845308] RIP:
0010:native_queued_spin_lock_slowpath+0x178/0x1a0
Nov 30 08:11:45 makarhum-e6330 kernel: [86926.845308] RSP:
0000:ffffa3aac0e4fc38 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff10
Nov 30 08:11:45 makarhum-e6330 kernel: [86926.845309] RAX: 0000000000000101
RBX: ffffffffc09badc8 RCX: 0000000000000001
Nov 30 08:11:45 makarhum-e6330 kernel: [86926.845310] RDX: 0000000000000101
RSI: 0000000000000001 RDI: ffffffffc09badcc
Nov 30 08:11:45 makarhum-e6330 kernel: [86926.845310] RBP: ffffa3aac0e4fc38
R08: 0000000000000101 R09: ffff8b40d58032c0
Nov 30 08:11:45 makarhum-e6330 kernel: [86926.845311] R10: ffff8b40d58032c0
R11: ffff8b40159ece00 R12: ffffffffc09badcc
Nov 30 08:11:45 makarhum-e6330 kernel: [86926.845311] R13: ffff8b40132a1600
R14: 0000000000000000 R15: 0000000000000000
Nov 30 08:11:45 makarhum-e6330 kernel: [86926.845312] FS: 
0000000000000000(0000) GS:ffff8b40de380000(0000) knlGS:0000000000000000
Nov 30 08:11:45 makarhum-e6330 kernel: [86926.845312] CS:  0010 DS: 0000 ES:
0000 CR0: 0000000080050033
Nov 30 08:11:45 makarhum-e6330 kernel: [86926.845313] CR2: 00007f4af9a7e09d
CR3: 000000005c209000 CR4: 00000000001406e0
Nov 30 08:11:45 makarhum-e6330 kernel: [86926.845314] Call Trace:
Nov 30 08:11:45 makarhum-e6330 kernel: [86926.845316] 
queued_read_lock_slowpath+0x8d/0xa0
Nov 30 08:11:45 makarhum-e6330 kernel: [86926.845318]  _raw_read_lock+0x23/0x30
Nov 30 08:11:45 makarhum-e6330 kernel: [86926.845328] 
hci_send_to_channel+0x33/0xf0 [bluetooth]
Nov 30 08:11:45 makarhum-e6330 kernel: [86926.845336] 
hci_send_monitor_ctrl_event+0x167/0x1a0 [bluetooth]
Nov 30 08:11:45 makarhum-e6330 kernel: [86926.845344] 
mgmt_send_event+0x108/0x120 [bluetooth]
Nov 30 08:11:45 makarhum-e6330 kernel: [86926.845352]  new_settings+0x53/0x70
[bluetooth]
Nov 30 08:11:45 makarhum-e6330 kernel: [86926.845360] 
__mgmt_power_off+0xaf/0x120 [bluetooth]
Nov 30 08:11:45 makarhum-e6330 kernel: [86926.845366] 
hci_dev_do_close+0x4c8/0x500 [bluetooth]
Nov 30 08:11:45 makarhum-e6330 kernel: [86926.845373]  hci_power_off+0x1e/0x50
[bluetooth]
Nov 30 08:11:45 makarhum-e6330 kernel: [86926.845375] 
process_one_work+0x16b/0x4a0
Nov 30 08:11:45 makarhum-e6330 kernel: [86926.845376]  worker_thread+0x4b/0x500
Nov 30 08:11:45 makarhum-e6330 kernel: [86926.845377]  kthread+0x109/0x140
Nov 30 08:11:45 makarhum-e6330 kernel: [86926.845378]  ?
process_one_work+0x4a0/0x4a0
Nov 30 08:11:45 makarhum-e6330 kernel: [86926.845380]  ?
kthread_create_on_node+0x60/0x60
Nov 30 08:11:45 makarhum-e6330 kernel: [86926.845381]  ret_from_fork+0x2c/0x40
Nov 30 08:11:45 makarhum-e6330 kernel: [86926.845382] Code: 31 c0 41 39 c0 74
e6 4d 85 c9 c6 07 01 74 30 41 c7 41 08 01 00 00 00 e9 51 ff ff ff 83 fa 01 0f
84 af fe ff ff 8b 07 84 c0 74 08 <f3> 90 8b 07 84 c0 75 f8 b8 01 00 00 00 66 89
07 5d c3 f3 90 4c

-- 
You are receiving this mail because:
You are the assignee for the bug.