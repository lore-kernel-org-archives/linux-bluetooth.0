Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 23 Nov 2015 12:22:07 -0800
Message-ID: <CAKXz-fT9bjmBx_FELqAABuNj5=V7-H9xrAd-7X2tMF14VxpKpw@mail.gmail.com>
Subject: PROBLEM: Unable to handle kernel NULL pointer in bt_accept_unlink
From: Max Zhao <zhaoyichen@google.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

1. "BUG: unable to handle kernel NULL pointer" encountered in dmesg when
Bluetooth is stress tested.
2.
We're running a RFCOMM server via pybluez. During stress testing, during
which we repeatedly establish an RFCOMM connection from 5+ Bluetooth devices
simultaneously to the server, exchange a message, and close the connection, we
consistently encountered the message "BUG: unable to handle kernel NULL pointer
dereference at 00000000000001a8".

After encountering the error message, sometimes the computer hangs on reboot.

The error message occurs after 20 minutes to 12 hours of testing.

Based on the code on the call trace, it appears that there may be a bug in
bt_accept_dequeue. See (9).

3. bluetooth, kernel
4. Linux version 3.16.0-49-generic (buildd@lgw01-52) (gcc version
4.8.2 (Ubuntu 4.8.2-19ubuntu1) ) #65~14.04.1-Ubuntu SMP Wed Sep 9
10:03:23 UTC 2015
5.
[50510.241632] BUG: unable to handle kernel NULL pointer dereference
at 00000000000001a8
[50510.241694] IP: [<ffffffffc01243f7>] bt_accept_unlink+0x47/0xa0 [bluetooth]
[50510.241759] PGD 0
[50510.241776] Oops: 0002 [#1] SMP
[50510.241802] Modules linked in: rtl8192cu rtl_usb rtlwifi
rtl8192c_common 8021q garp stp mrp llc rfcomm bnep nls_iso8859_1
intel_rapl x86_pkg_temp_thermal intel_powerclamp coretemp arc4 ath9k
ath9k_common ath9k_hw ath kvm eeepc_wmi asus_wmi mac80211
snd_hda_codec_hdmi snd_hda_codec_realtek sparse_keymap
crct10dif_pclmul snd_hda_codec_generic crc32_pclmul snd_hda_intel
snd_hda_controller cfg80211 snd_hda_codec i915 snd_hwdep snd_pcm
ghash_clmulni_intel snd_timer snd soundcore serio_raw cryptd
drm_kms_helper drm i2c_algo_bit shpchp ath3k mei_me lpc_ich btusb
bluetooth 6lowpan_iphc mei lp parport wmi video mac_hid psmouse ahci
libahci r8169 mii
[50510.242279] CPU: 0 PID: 934 Comm: krfcommd Not tainted
3.16.0-49-generic #65~14.04.1-Ubuntu
[50510.242327] Hardware name: ASUSTeK Computer INC. VM40B/VM40B, BIOS
1501 12/09/2014
[50510.242370] task: ffff8800d9068a30 ti: ffff8800d7a54000 task.ti:
ffff8800d7a54000
[50510.242413] RIP: 0010:[<ffffffffc01243f7>]  [<ffffffffc01243f7>]
bt_accept_unlink+0x47/0xa0 [bluetooth]
[50510.242480] RSP: 0018:ffff8800d7a57d58  EFLAGS: 00010246
[50510.242511] RAX: 0000000000000000 RBX: ffff880119bb8c00 RCX: ffff880119bb8eb0
[50510.242552] RDX: ffff880119bb8eb0 RSI: 00000000fffffe01 RDI: ffff880119bb8c00
[50510.242592] RBP: ffff8800d7a57d60 R08: 0000000000000283 R09: 0000000000000001
[50510.242633] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8800d8da9eb0
[50510.242673] R13: ffff8800d74fdb80 R14: ffff880119bb8c00 R15: ffff8800d8da9c00
[50510.242715] FS:  0000000000000000(0000) GS:ffff88011fa00000(0000)
knlGS:0000000000000000
[50510.242761] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[50510.242794] CR2: 00000000000001a8 CR3: 0000000001c13000 CR4: 00000000001407f0
[50510.242835] Stack:
[50510.242849]  ffff880119bb8eb0 ffff8800d7a57da0 ffffffffc0124506
ffff8800d8da9eb0
[50510.242899]  ffff8800d8da9c00 ffff8800d9068a30 0000000000000000
ffff8800d74fdb80
[50510.242949]  ffff8800d6f85208 ffff8800d7a57e08 ffffffffc0159985
000000000000001f
[50510.242999] Call Trace:
[50510.243027]  [<ffffffffc0124506>] bt_accept_dequeue+0xb6/0x180 [bluetooth]
[50510.243085]  [<ffffffffc0159985>] l2cap_sock_accept+0x125/0x220 [bluetooth]
[50510.243128]  [<ffffffff810a1b30>] ? wake_up_state+0x20/0x20
[50510.243163]  [<ffffffff8164946e>] kernel_accept+0x4e/0xa0
[50510.243200]  [<ffffffffc05b97cd>] rfcomm_run+0x1ad/0x890 [rfcomm]
[50510.243238]  [<ffffffffc05b9620>] ? rfcomm_process_rx+0x8a0/0x8a0 [rfcomm]
[50510.243281]  [<ffffffff81091572>] kthread+0xd2/0xf0
[50510.243312]  [<ffffffff810914a0>] ? kthread_create_on_node+0x1c0/0x1c0
[50510.243353]  [<ffffffff8176e9d8>] ret_from_fork+0x58/0x90
[50510.243387]  [<ffffffff810914a0>] ? kthread_create_on_node+0x1c0/0x1c0
[50510.243424] Code: 00 48 8b 93 b8 02 00 00 48 8d 83 b0 02 00 00 48
89 51 08 48 89 0a 48 89 83 b0 02 00 00 48 89 83 b8 02 00 00 48 8b 83
c0 02 00 00 <66> 83 a8 a8 01 00 00 01 48 c7 83 c0 02 00 00 00 00 00 00
f0 ff
[50510.243685] RIP  [<ffffffffc01243f7>] bt_accept_unlink+0x47/0xa0 [bluetooth]
[50510.243737]  RSP <ffff8800d7a57d58>
[50510.243758] CR2: 00000000000001a8
[50510.249457] ---[ end trace bb984f932c4e3ab3 ]---

6. N/A
7.1
Linux hostname 3.16.0-49-generic #65~14.04.1-Ubuntu SMP Wed Sep 9 10:03:23 UTC
2015 x86_64 x86_64 x86_64 GNU/Linux

 Gnu C                  4.8
 Gnu make               3.81
 binutils               2.24
 util-linux             2.20.1
 mount                  support
 module-init-tools      15
 e2fsprogs              1.42.9
 PPP                    2.4.5
 Linux C Library        2.19
 Dynamic linker (ldd)   2.19
 Procps                 3.3.9
 Net-tools              1.60
 Kbd                    1.15.5
 Sh-utils               8.21
 wireless-tools         30
 Modules Loaded         8021q garp stp mrp llc eeepc_wmi asus_wmi
 sparse_keymap arc4 ath9k intel_rapl x86_pkg_temp_thermal intel_powerclamp
 ath9k_common coretemp kvm crct10dif_pclmul ath9k_hw crc32_pclmul ath
 ghash_clmulni_intel cryptd rfcomm serio_raw snd_hda_codec_hdmi bnep mac80211
 btusb bluetooth 6lowpan_iphc cfg80211 lpc_ich tpm_infineon i915
 snd_soc_rt5640 dw_dmac snd_hda_codec_conexant dw_dmac_core snd_soc_sst_acpi
 snd_hda_codec_generic video snd_soc_rl6231 snd_hda_intel snd_soc_core
 drm_kms_helper snd_hda_controller snd_compress snd_hda_codec
 snd_pcm_dmaengine snd_hwdep nls_iso8859_1 snd_pcm i2c_hid hid
 i2c_designware_platform mei_me 8250_dw i2c_designware_core
 spi_pxa2xx_platform shpchp mei snd_timer snd soundcore drm i2c_algo_bit wmi
 mac_hid lp parport psmouse r8169 mii sdhci_acpi sdhci ahci libahci
7.2
processor : 0
vendor_id : GenuineIntel
cpu family  : 6
model   : 69
model name  : Intel(R) Celeron(R) 2957U @ 1.40GHz
stepping  : 1
microcode : 0x17
cpu MHz   : 862.531
cache size  : 2048 KB
physical id : 0
siblings  : 2
core id   : 0
cpu cores : 2
apicid    : 0
initial apicid  : 0
fpu   : yes
fpu_exception : yes
cpuid level : 13
wp    : yes
flags   : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat
pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb
rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology
nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx est
tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 movbe popcnt tsc_deadline_timer
xsave rdrand lahf_lm abm arat epb xsaveopt pln pts dtherm tpr_shadow vnmi
flexpriority ept vpid fsgsbase tsc_adjust erms invpcid
bogomips  : 2793.72
clflush size  : 64
cache_alignment : 64
address sizes : 39 bits physical, 48 bits virtual
power management:

processor : 1
vendor_id : GenuineIntel
cpu family  : 6
model   : 69
model name  : Intel(R) Celeron(R) 2957U @ 1.40GHz
stepping  : 1
microcode : 0x17
cpu MHz   : 800.187
cache size  : 2048 KB
physical id : 0
siblings  : 2
core id   : 1
cpu cores : 2
apicid    : 2
initial apicid  : 2
fpu   : yes
fpu_exception : yes
cpuid level : 13
wp    : yes
flags   : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat
pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb
rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology
nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx est
tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 movbe popcnt tsc_deadline_timer
xsave rdrand lahf_lm abm arat epb xsaveopt pln pts dtherm tpr_shadow vnmi
flexpriority ept vpid fsgsbase tsc_adjust erms invpcid
bogomips  : 2793.72
clflush size  : 64
cache_alignment : 64
address sizes : 39 bits physical, 48 bits virtual
power management:

7.3.
8021q 33029 0 - Live 0x0000000000000000
garp 14383 1 8021q, Live 0x0000000000000000
stp 12976 1 garp, Live 0x0000000000000000
mrp 18777 1 8021q, Live 0x0000000000000000
llc 14396 2 garp,stp, Live 0x0000000000000000
eeepc_wmi 13151 0 - Live 0x0000000000000000
asus_wmi 24094 1 eeepc_wmi, Live 0x0000000000000000
sparse_keymap 13948 1 asus_wmi, Live 0x0000000000000000
arc4 12608 2 - Live 0x0000000000000000
ath9k 141379 0 - Live 0x0000000000000000
intel_rapl 18783 0 - Live 0x0000000000000000
x86_pkg_temp_thermal 14205 0 - Live 0x0000000000000000
intel_powerclamp 18823 0 - Live 0x0000000000000000
ath9k_common 25638 1 ath9k, Live 0x0000000000000000
coretemp 13441 0 - Live 0x0000000000000000
kvm 452096 0 - Live 0x0000000000000000
crct10dif_pclmul 14307 0 - Live 0x0000000000000000
ath9k_hw 446521 2 ath9k,ath9k_common, Live 0x0000000000000000
crc32_pclmul 13133 0 - Live 0x0000000000000000
ath 29006 3 ath9k,ath9k_common,ath9k_hw, Live 0x0000000000000000
ghash_clmulni_intel 13230 0 - Live 0x0000000000000000
cryptd 20359 1 ghash_clmulni_intel, Live 0x0000000000000000
rfcomm 69509 23 - Live 0x0000000000000000
serio_raw 13483 0 - Live 0x0000000000000000
snd_hda_codec_hdmi 47548 1 - Live 0x0000000000000000
bnep 19624 2 - Live 0x0000000000000000
mac80211 652777 1 ath9k, Live 0x0000000000000000
btusb 32497 0 - Live 0x0000000000000000
bluetooth 446409 52 rfcomm,bnep,btusb, Live 0x0000000000000000
6lowpan_iphc 18702 1 bluetooth, Live 0x0000000000000000
cfg80211 498458 4 ath9k,ath9k_common,ath,mac80211, Live 0x0000000000000000
lpc_ich 21093 0 - Live 0x0000000000000000
tpm_infineon 17131 0 - Live 0x0000000000000000
i915 906106 4 - Live 0x0000000000000000
snd_soc_rt5640 93042 0 - Live 0x0000000000000000
dw_dmac 12835 0 - Live 0x0000000000000000
snd_hda_codec_conexant 23109 1 - Live 0x0000000000000000
dw_dmac_core 28390 1 dw_dmac, Live 0x0000000000000000
snd_soc_sst_acpi 13007 0 - Live 0x0000000000000000
snd_hda_codec_generic 69011 1 snd_hda_codec_conexant, Live 0x0000000000000000
video 20128 2 asus_wmi,i915, Live 0x0000000000000000
snd_soc_rl6231 13037 1 snd_soc_rt5640, Live 0x0000000000000000
snd_hda_intel 30469 0 - Live 0x0000000000000000
snd_soc_core 200204 1 snd_soc_rt5640, Live 0x0000000000000000
drm_kms_helper 61574 1 i915, Live 0x0000000000000000
snd_hda_controller 30228 1 snd_hda_intel, Live 0x0000000000000000
snd_compress 19200 1 snd_soc_core, Live 0x0000000000000000
snd_hda_codec 139719 5
snd_hda_codec_hdmi,snd_hda_codec_conexant,snd_hda_codec_generic,snd_hda_intel,snd_hda_controller,
Live 0x0000000000000000
snd_pcm_dmaengine 15172 1 snd_soc_core, Live 0x0000000000000000
snd_hwdep 17698 1 snd_hda_codec, Live 0x0000000000000000
nls_iso8859_1 12713 1 - Live 0x0000000000000000
snd_pcm 104112 7
snd_hda_codec_hdmi,snd_soc_rt5640,snd_hda_intel,snd_soc_core,snd_hda_controller,snd_hda_codec,snd_pcm_dmaengine,
Live 0x0000000000000000
i2c_hid 18726 0 - Live 0x0000000000000000
hid 110426 1 i2c_hid, Live 0x0000000000000000
i2c_designware_platform 12979 0 - Live 0x0000000000000000
mei_me 19696 0 - Live 0x0000000000000000
8250_dw 13551 0 - Live 0x0000000000000000
i2c_designware_core 14768 1 i2c_designware_platform, Live 0x0000000000000000
spi_pxa2xx_platform 23079 0 - Live 0x0000000000000000
shpchp 37047 0 - Live 0x0000000000000000
mei 87875 1 mei_me, Live 0x0000000000000000
snd_timer 29562 1 snd_pcm, Live 0x0000000000000000
snd 79468 10
snd_hda_codec_hdmi,snd_hda_codec_conexant,snd_hda_codec_generic,snd_hda_intel,snd_soc_core,snd_compress,snd_hda_codec,snd_hwdep,snd_pcm,snd_timer,
Live 0x0000000000000000
soundcore 15047 2 snd_hda_codec,snd, Live 0x0000000000000000
drm 311018 3 i915,drm_kms_helper, Live 0x0000000000000000
i2c_algo_bit 13413 1 i915, Live 0x0000000000000000
wmi 19193 1 asus_wmi, Live 0x0000000000000000
mac_hid 13227 0 - Live 0x0000000000000000
lp 17759 0 - Live 0x0000000000000000
parport 42348 1 lp, Live 0x0000000000000000
psmouse 106767 0 - Live 0x0000000000000000
r8169 71694 0 - Live 0x0000000000000000
mii 13934 1 r8169, Live 0x0000000000000000
sdhci_acpi 13351 0 - Live 0x0000000000000000
sdhci 43685 1 sdhci_acpi, Live 0x0000000000000000
ahci 34142 3 - Live 0x0000000000000000
libahci 32424 1 ahci, Live 0x0000000000000000

8. Bluetooth devices used are all USB 2.0 Bluetooth dongles. Two types of
dongles are used:
* IOGear GBU521: BCM20702A.
* SENA Parani-UD100: Cambridge Silicon Radio chipset.

9.
Based on objdump, bt_accept_dequeue+0xb6/0x180 (see call trace above)
corresponds to line 190 below.

Line 189 unlocks the socket before bt_accept_unlink on line 190. This seems to
be causing a race condition.

net/bluetooth/af_bluetooth.c (linux-lts-utopic-3.16.0 from Ubuntu):
175: struct sock *bt_accept_dequeue(struct sock *parent, struct socket *newsock)
...
187: /* FIXME: Is this check still needed */
188: if (sk->sk_state == BT_CLOSED) {
189:         release_sock(sk);
190:         bt_accept_unlink(sk);
191:         continue;
192: }

-- 
Max Zhao
