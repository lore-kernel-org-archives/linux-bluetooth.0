Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
From: Martin Weinberg <martin.weinberg@comcast.net>
Subject: PROBLEM: 4.13 generating tracebacks while attempting to load
 bluetooth firmware
Message-ID: <c16044e2-7f75-10e5-afe1-d86cb7d2d613@comcast.net>
Date: Sat, 9 Sep 2017 13:50:10 -0400
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="rUTwRQHl20Dc6mkcoNFufFawhSn308b6H"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rUTwRQHl20Dc6mkcoNFufFawhSn308b6H
Content-Type: multipart/mixed; boundary="q3j4JMFkWXs1WgJFGverEqAMsjK9njtJ6";
 protected-headers="v1"
From: Martin Weinberg <martin.weinberg@comcast.net>
To: linux-bluetooth@vger.kernel.org
Message-ID: <c16044e2-7f75-10e5-afe1-d86cb7d2d613@comcast.net>
Subject: PROBLEM: 4.13 generating tracebacks while attempting to load
 bluetooth firmware

--q3j4JMFkWXs1WgJFGverEqAMsjK9njtJ6
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

[1.] One line summary of the problem:

Kernel generating tracebacks in syslog (oops) on trying to load
bluetooth firmware on boot and resume from suspend.

[2.] Full description of the problem/report:

No obvious consquences for these oopses; it is not fatal and
does not seem to affect the running kernel.  But something is not
right.  This is a Lenovo T440s (Haswell) laptop.

I tried the same kernel on a Lenovo X220 (Sandybridge) and there are no
problems.

I am not a developer or maintainer; just a user trying to help.  Hope
this report is of use.

[3.] Keywords (i.e., modules, networking, kernel):

[4.] Kernel version (from /proc/version):

Linux version 4.13.0-041300-generic (kernel@gloin) (gcc version 7.2.0
(Ubuntu 7.2.0-2ubuntu1)) #201709031731 SMP Sun Sep 3 21:33:09 UTC 2017

[5.] Output of Oops.. message (if applicable) with symbolic information
resolved (see Documentation/oops-tracing.txt)

[101695.231173] Bluetooth: hci0: read Intel version: 370710018002030d00
[101695.231178] firmware request while host is not available
[101695.231190] ------------[ cut here ]------------
[101695.231194] WARNING: CPU: 0 PID: 23988 at
/home/kernel/COD/linux/drivers/base/firmware_class.c:1243
_request_firmware+0x3e4/0x8c0
[101695.231195] Modules linked in: acpi_call(OE) msr ip6table_filter
ip6_tables rfcomm ccm cmac bnep dm_crypt snd_usb_audio snd_usbmidi_lib
cmdlinepart intel_spi_platform intel_spi spi_nor mtd uvcvideo
videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 videobuf2_core btusb
btrtl videodev media btbcm btintel bluetooth ecdh_generic intel_rapl
x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel
snd_hda_codec_hdmi kvm snd_hda_codec_realtek snd_hda_codec_generic
irqbypass snd_hda_intel crct10dif_pclmul crc32_pclmul
ghash_clmulni_intel snd_hda_codec snd_hda_core snd_hwdep snd_pcm
thinkpad_acpi nvram snd_seq_midi snd_seq_midi_event pcbc arc4
snd_rawmidi aesni_intel aes_x86_64 snd_seq joydev input_leds serio_raw
crypto_simd snd_seq_device iwlmvm glue_helper cryptd intel_cstate
intel_rapl_perf snd_timer rtsx_pci_ms
[101695.231238]  mac80211 wmi_bmof memstick mei_me snd iwlwifi mei
cfg80211 soundcore lpc_ich mac_hid shpchp intel_smartconnect binfmt_misc
parport_pc ppdev lp parport ip_tables x_tables autofs4 hid_generic
usbhid hid uas usb_storage i915 i2c_algo_bit rtsx_pci_sdmmc
drm_kms_helper psmouse syscopyarea sysfillrect sysimgblt e1000e
fb_sys_fops ahci libahci drm ptp rtsx_pci pps_core wmi video
[101695.231265] CPU: 0 PID: 23988 Comm: kworker/u17:0 Tainted: G
W  OE   4.13.0-041300-generic #201709031731
[101695.231266] Hardware name: LENOVO 20ARA0S100/20ARA0S100, BIOS
GJET74WW (2.24 ) 03/19/2014
[101695.231283] Workqueue: hci0 hci_power_on [bluetooth]
[101695.231285] task: ffff9416f7721740 task.stack: ffffaffb01518000
[101695.231287] RIP: 0010:_request_firmware+0x3e4/0x8c0
[101695.231288] RSP: 0018:ffffaffb0151bc78 EFLAGS: 00010286
[101695.231290] RAX: 000000000000002c RBX: ffff941660ebae80 RCX:
0000000000000006
[101695.231291] RDX: 0000000000000000 RSI: 0000000000000092 RDI:
ffff94185e20dc70
[101695.231292] RBP: ffffaffb0151bcd8 R08: 0000000000000001 R09:
0000000000000b7e
[101695.231293] R10: fffffd36c0282600 R11: 0000000000000000 R12:
ffffaffb0151bd50
[101695.231294] R13: ffffaffb0151bd38 R14: ffffffff8b59d6e0 R15:
ffff9418524ea480
[101695.231295] FS:  0000000000000000(0000) GS:ffff94185e200000(0000)
knlGS:0000000000000000
[101695.231296] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[101695.231297] CR2: 00007ffd877dcce7 CR3: 00000001af679000 CR4:
00000000001406f0
[101695.231298] Call Trace:
[101695.231302]  request_firmware+0x37/0x50
[101695.231306]  btusb_setup_intel+0x15e/0x640 [btusb]
[101695.231309]  ? rpm_idle+0x58/0x290
[101695.231312]  ? usb_autopm_put_interface+0x30/0x40
[101695.231323]  hci_dev_do_open+0x252/0x5d0 [bluetooth]
[101695.231333]  hci_power_on+0x4e/0x200 [bluetooth]
[101695.231336]  ? __schedule+0x293/0x890
[101695.231338]  process_one_work+0x1e7/0x410
[101695.231340]  worker_thread+0x4a/0x410
[101695.231343]  kthread+0x125/0x140
[101695.231345]  ? process_one_work+0x410/0x410
[101695.231348]  ? kthread_create_on_node+0x70/0x70
[101695.231350]  ret_from_fork+0x25/0x30
[101695.231351] Code: 08 49 83 ff 28 74 68 49 8b 8f c0 de 29 8b e9 39 ff
ff ff 48 c7 c7 c0 2f 7b 8b e8 38 ba 30 00 48 c7 c7 28 88 52 8b e8 0d 17
af ff <0f> ff 41 bf 90 ff ff ff e9 8d fd ff ff 49 8b 8e 88 00 00 00 48
[101695.231383] ---[ end trace d39bef3981462507 ]---
[101695.231385] Bluetooth: hci0 failed to open Intel firmware file:
intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq(-112)
[101695.231389] firmware request while host is not available
[101695.231396] ------------[ cut here ]------------
[101695.231399] WARNING: CPU: 0 PID: 23988 at
/home/kernel/COD/linux/drivers/base/firmware_class.c:1243
_request_firmware+0x3e4/0x8c0
[101695.231399] Modules linked in: acpi_call(OE) msr ip6table_filter
ip6_tables rfcomm ccm cmac bnep dm_crypt snd_usb_audio snd_usbmidi_lib
cmdlinepart intel_spi_platform intel_spi spi_nor mtd uvcvideo
videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 videobuf2_core btusb
btrtl videodev media btbcm btintel bluetooth ecdh_generic intel_rapl
x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel
snd_hda_codec_hdmi kvm snd_hda_codec_realtek snd_hda_codec_generic
irqbypass snd_hda_intel crct10dif_pclmul crc32_pclmul
ghash_clmulni_intel snd_hda_codec snd_hda_core snd_hwdep snd_pcm
thinkpad_acpi nvram snd_seq_midi snd_seq_midi_event pcbc arc4
snd_rawmidi aesni_intel aes_x86_64 snd_seq joydev input_leds serio_raw
crypto_simd snd_seq_device iwlmvm glue_helper cryptd intel_cstate
intel_rapl_perf snd_timer rtsx_pci_ms
[101695.231432]  mac80211 wmi_bmof memstick mei_me snd iwlwifi mei
cfg80211 soundcore lpc_ich mac_hid shpchp intel_smartconnect binfmt_misc
parport_pc ppdev lp parport ip_tables x_tables autofs4 hid_generic
usbhid hid uas usb_storage i915 i2c_algo_bit rtsx_pci_sdmmc
drm_kms_helper psmouse syscopyarea sysfillrect sysimgblt e1000e
fb_sys_fops ahci libahci drm ptp rtsx_pci pps_core wmi video
[101695.231452] CPU: 0 PID: 23988 Comm: kworker/u17:0 Tainted: G
W  OE   4.13.0-041300-generic #201709031731
[101695.231453] Hardware name: LENOVO 20ARA0S100/20ARA0S100, BIOS
GJET74WW (2.24 ) 03/19/2014
[101695.231463] Workqueue: hci0 hci_power_on [bluetooth]
[101695.231465] task: ffff9416f7721740 task.stack: ffffaffb01518000
[101695.231466] RIP: 0010:_request_firmware+0x3e4/0x8c0
[101695.231467] RSP: 0018:ffffaffb0151bc78 EFLAGS: 00010286
[101695.231469] RAX: 000000000000002c RBX: ffff941660ebae80 RCX:
0000000000000006
[101695.231469] RDX: 0000000000000000 RSI: 0000000000000092 RDI:
ffff94185e20dc70
[101695.231470] RBP: ffffaffb0151bcd8 R08: 0000000000000001 R09:
0000000000000ba2
[101695.231471] R10: fffffd36c083ae80 R11: 0000000000000000 R12:
ffffaffb0151bd50
[101695.231472] R13: ffffaffb0151bd38 R14: ffffffff8b59d6e0 R15:
ffff9418524ea480
[101695.231473] FS:  0000000000000000(0000) GS:ffff94185e200000(0000)
knlGS:0000000000000000
[101695.231474] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[101695.231475] CR2: 00007ffd877dcce7 CR3: 00000001af679000 CR4:
00000000001406f0
[101695.231476] Call Trace:
[101695.231479]  ? snprintf+0x45/0x70
[101695.231481]  request_firmware+0x37/0x50
[101695.231483]  btusb_setup_intel+0x1b5/0x640 [btusb]
[101695.231485]  ? rpm_idle+0x58/0x290
[101695.231487]  ? usb_autopm_put_interface+0x30/0x40
[101695.231499]  hci_dev_do_open+0x252/0x5d0 [bluetooth]
[101695.231510]  hci_power_on+0x4e/0x200 [bluetooth]
[101695.231511]  ? __schedule+0x293/0x890
[101695.231514]  process_one_work+0x1e7/0x410
[101695.231515]  worker_thread+0x4a/0x410
[101695.231517]  kthread+0x125/0x140
[101695.231519]  ? process_one_work+0x410/0x410
[101695.231520]  ? kthread_create_on_node+0x70/0x70
[101695.231522]  ret_from_fork+0x25/0x30
[101695.231524] Code: 08 49 83 ff 28 74 68 49 8b 8f c0 de 29 8b e9 39 ff
ff ff 48 c7 c7 c0 2f 7b 8b e8 38 ba 30 00 48 c7 c7 28 88 52 8b e8 0d 17
af ff <0f> ff 41 bf 90 ff ff ff e9 8d fd ff ff 49 8b 8e 88 00 00 00 48
[101695.231553] ---[ end trace d39bef3981462508 ]---
[101695.231554] Bluetooth: hci0 failed to open default Intel fw file:
intel/ibt-hw-37.7.bseq

[6.] A small shell script or example program which triggers the problem
(if possible)

Suspend and resume laptop does it.

[7.] Environment

Description:	Ubuntu 17.04
Release:	17.04


[7.1.] Software (add the output of the ver_linux script here)

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux magpie 4.13.0-041300-generic #201709031731 SMP Sun Sep 3 21:33:09
UTC 2017 x86_64 x86_64 x86_64 GNU/Linux

GNU C               	6.3.0
GNU Make            	4.1
Binutils            	2.28
Util-linux          	2.29
Mount               	2.29
Linux C Library     	2.24
Dynamic linker (ldd)	2.24
readlink: missing operand
Try 'readlink --help' for more information.
Procps              	3.3.12
Kbd                 	2.0.3
Console-tools       	2.0.3
Sh-utils            	8.26
Udev                	232
Modules Loaded      	acpi_call aesni_intel aes_x86_64 ahci arc4 autofs4
binfmt_misc bluetooth bnep btbcm btintel btrtl btusb ccm cfg80211 cmac
cmdlinepart coretemp crc32_pclmul crct10dif_pclmul cryptd crypto_simd
dm_crypt drm drm_kms_helper e1000e ecdh_generic fb_sys_fops
ghash_clmulni_intel glue_helper hid hid_generic i2c_algo_bit i915
input_leds intel_cstate intel_powerclamp intel_rapl intel_rapl_perf
intel_smartconnect intel_spi intel_spi_platform ip6table_filter
ip6_tables ip_tables irqbypass iwlmvm iwlwifi joydev kvm kvm_intel
libahci lp lpc_ich mac80211 mac_hid media mei mei_me memstick msr mtd
nvram parport parport_pc pcbc ppdev pps_core psmouse ptp rfcomm rtsx_pci
rtsx_pci_ms rtsx_pci_sdmmc serio_raw shpchp snd snd_hda_codec
snd_hda_codec_generic snd_hda_codec_hdmi snd_hda_codec_realtek
snd_hda_core snd_hda_intel snd_hwdep snd_pcm snd_rawmidi snd_seq
snd_seq_device snd_seq_midi snd_seq_midi_event snd_timer snd_usb_audio
snd_usbmidi_lib soundcore spi_nor syscopyarea sysfillrect sysimgblt
thinkpad_acpi uas usbhid usb_storage uvcvideo video videobuf2_core
videobuf2_memops videobuf2_v4l2 videobuf2_vmalloc videodev wmi wmi_bmof
x86_pkg_temp_thermal x_tables

[7.2.] Processor information (from /proc/cpuinfo):

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 69
model name	: Intel(R) Core(TM) i7-4600U CPU @ 2.10GHz
stepping	: 1
microcode	: 0x17
cpu MHz		: 2693.766
cache size	: 4096 KB
physical id	: 0
siblings	: 4
core id		: 0
cpu cores	: 2
apicid		: 0
initial apicid	: 0
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl
xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor
ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2
x2apic movbe popcnt aes xsave avx f16c rdrand lahf_lm abm cpuid_fault
epb tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle
avx2 smep bmi2 erms invpcid rtm xsaveopt dtherm ida arat pln pts
bugs		:
bogomips	: 5387.53
clflush size	: 64
cache_alignment	: 64
address sizes	: 39 bits physical, 48 bits virtual
power management:

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 69
model name	: Intel(R) Core(TM) i7-4600U CPU @ 2.10GHz
stepping	: 1
microcode	: 0x17
cpu MHz		: 2693.766
cache size	: 4096 KB
physical id	: 0
siblings	: 4
core id		: 0
cpu cores	: 2
apicid		: 1
initial apicid	: 1
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl
xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor
ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2
x2apic movbe popcnt aes xsave avx f16c rdrand lahf_lm abm cpuid_fault
epb tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle
avx2 smep bmi2 erms invpcid rtm xsaveopt dtherm ida arat pln pts
bugs		:
bogomips	: 5387.29
clflush size	: 64
cache_alignment	: 64
address sizes	: 39 bits physical, 48 bits virtual
power management:

processor	: 2
vendor_id	: GenuineIntel
cpu family	: 6
model		: 69
model name	: Intel(R) Core(TM) i7-4600U CPU @ 2.10GHz
stepping	: 1
microcode	: 0x17
cpu MHz		: 2693.766
cache size	: 4096 KB
physical id	: 0
siblings	: 4
core id		: 1
cpu cores	: 2
apicid		: 2
initial apicid	: 2
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl
xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor
ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2
x2apic movbe popcnt aes xsave avx f16c rdrand lahf_lm abm cpuid_fault
epb tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle
avx2 smep bmi2 erms invpcid rtm xsaveopt dtherm ida arat pln pts
bugs		:
bogomips	: 5387.34
clflush size	: 64
cache_alignment	: 64
address sizes	: 39 bits physical, 48 bits virtual
power management:

processor	: 3
vendor_id	: GenuineIntel
cpu family	: 6
model		: 69
model name	: Intel(R) Core(TM) i7-4600U CPU @ 2.10GHz
stepping	: 1
microcode	: 0x17
cpu MHz		: 2693.766
cache size	: 4096 KB
physical id	: 0
siblings	: 4
core id		: 1
cpu cores	: 2
apicid		: 3
initial apicid	: 3
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl
xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor
ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2
x2apic movbe popcnt aes xsave avx f16c rdrand lahf_lm abm cpuid_fault
epb tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle
avx2 smep bmi2 erms invpcid rtm xsaveopt dtherm ida arat pln pts
bugs		:
bogomips	: 5387.34
clflush size	: 64
cache_alignment	: 64
address sizes	: 39 bits physical, 48 bits virtual
power management:

[7.3.] Module information (from /proc/modules):

acpi_call 16384 0 - Live 0x0000000000000000 (OE)
msr 16384 0 - Live 0x0000000000000000
ip6table_filter 16384 1 - Live 0x0000000000000000
ip6_tables 28672 1 ip6table_filter, Live 0x0000000000000000
rfcomm 77824 0 - Live 0x0000000000000000
ccm 20480 3 - Live 0x0000000000000000
cmac 16384 0 - Live 0x0000000000000000
bnep 20480 2 - Live 0x0000000000000000
dm_crypt 36864 1 - Live 0x0000000000000000
snd_usb_audio 196608 2 - Live 0x0000000000000000
snd_usbmidi_lib 32768 1 snd_usb_audio, Live 0x0000000000000000
cmdlinepart 16384 0 - Live 0x0000000000000000
intel_spi_platform 16384 0 - Live 0x0000000000000000
intel_spi 20480 1 intel_spi_platform, Live 0x0000000000000000
spi_nor 28672 1 intel_spi, Live 0x0000000000000000
mtd 57344 4 cmdlinepart,intel_spi,spi_nor, Live 0x0000000000000000
uvcvideo 90112 0 - Live 0x0000000000000000
videobuf2_vmalloc 16384 1 uvcvideo, Live 0x0000000000000000
videobuf2_memops 16384 1 videobuf2_vmalloc, Live 0x0000000000000000
videobuf2_v4l2 24576 1 uvcvideo, Live 0x0000000000000000
videobuf2_core 40960 2 uvcvideo,videobuf2_v4l2, Live 0x0000000000000000
btusb 45056 0 - Live 0x0000000000000000
btrtl 16384 1 btusb, Live 0x0000000000000000
videodev 176128 3 uvcvideo,videobuf2_v4l2,videobuf2_core, Live
0x0000000000000000
media 40960 2 uvcvideo,videodev, Live 0x0000000000000000
btbcm 16384 1 btusb, Live 0x0000000000000000
btintel 16384 1 btusb, Live 0x0000000000000000
bluetooth 540672 14 rfcomm,bnep,btusb,btrtl,btbcm,btintel, Live
0x0000000000000000
ecdh_generic 24576 1 bluetooth, Live 0x0000000000000000
intel_rapl 20480 0 - Live 0x0000000000000000
x86_pkg_temp_thermal 16384 0 - Live 0x0000000000000000
intel_powerclamp 16384 0 - Live 0x0000000000000000
coretemp 16384 0 - Live 0x0000000000000000
kvm_intel 200704 0 - Live 0x0000000000000000
snd_hda_codec_hdmi 49152 1 - Live 0x0000000000000000
kvm 581632 1 kvm_intel, Live 0x0000000000000000
snd_hda_codec_realtek 94208 1 - Live 0x0000000000000000
snd_hda_codec_generic 73728 1 snd_hda_codec_realtek, Live 0x0000000000000=
000
irqbypass 16384 1 kvm, Live 0x0000000000000000
snd_hda_intel 40960 10 - Live 0x0000000000000000
crct10dif_pclmul 16384 0 - Live 0x0000000000000000
crc32_pclmul 16384 0 - Live 0x0000000000000000
ghash_clmulni_intel 16384 0 - Live 0x0000000000000000
snd_hda_codec 126976 4
snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_in=
tel,
Live 0x0000000000000000
snd_hda_core 81920 5
snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_in=
tel,snd_hda_codec,
Live 0x0000000000000000
snd_hwdep 20480 2 snd_usb_audio,snd_hda_codec, Live 0x0000000000000000
snd_pcm 98304 5
snd_usb_audio,snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec,snd_hda_core=
,
Live 0x0000000000000000
thinkpad_acpi 94208 1 - Live 0x0000000000000000
nvram 16384 1 thinkpad_acpi, Live 0x0000000000000000
snd_seq_midi 16384 0 - Live 0x0000000000000000
snd_seq_midi_event 16384 1 snd_seq_midi, Live 0x0000000000000000
pcbc 16384 0 - Live 0x0000000000000000
arc4 16384 2 - Live 0x0000000000000000
snd_rawmidi 32768 2 snd_usbmidi_lib,snd_seq_midi, Live 0x0000000000000000=

aesni_intel 188416 729 - Live 0x0000000000000000
aes_x86_64 20480 1 aesni_intel, Live 0x0000000000000000
snd_seq 65536 2 snd_seq_midi,snd_seq_midi_event, Live 0x0000000000000000
joydev 20480 0 - Live 0x0000000000000000
input_leds 16384 0 - Live 0x0000000000000000
serio_raw 16384 0 - Live 0x0000000000000000
crypto_simd 16384 1 aesni_intel, Live 0x0000000000000000
snd_seq_device 16384 3 snd_seq_midi,snd_rawmidi,snd_seq, Live
0x0000000000000000
iwlmvm 385024 0 - Live 0x0000000000000000
glue_helper 16384 1 aesni_intel, Live 0x0000000000000000
cryptd 24576 366 ghash_clmulni_intel,aesni_intel,crypto_simd, Live
0x0000000000000000
intel_cstate 20480 0 - Live 0x0000000000000000
intel_rapl_perf 16384 0 - Live 0x0000000000000000
snd_timer 32768 2 snd_pcm,snd_seq, Live 0x0000000000000000
rtsx_pci_ms 20480 0 - Live 0x0000000000000000
mac80211 778240 1 iwlmvm, Live 0x0000000000000000
wmi_bmof 16384 0 - Live 0x0000000000000000
memstick 16384 1 rtsx_pci_ms, Live 0x0000000000000000
mei_me 40960 0 - Live 0x0000000000000000
snd 81920 38
snd_usb_audio,snd_usbmidi_lib,snd_hda_codec_hdmi,snd_hda_codec_realtek,sn=
d_hda_codec_generic,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,thinkpa=
d_acpi,snd_rawmidi,snd_seq,snd_seq_device,snd_timer,
Live 0x0000000000000000
iwlwifi 249856 1 iwlmvm, Live 0x0000000000000000
mei 98304 1 mei_me, Live 0x0000000000000000
cfg80211 610304 3 iwlmvm,mac80211,iwlwifi, Live 0x0000000000000000
soundcore 16384 1 snd, Live 0x0000000000000000
lpc_ich 24576 0 - Live 0x0000000000000000
mac_hid 16384 0 - Live 0x0000000000000000
shpchp 36864 0 - Live 0x0000000000000000
intel_smartconnect 16384 0 - Live 0x0000000000000000
binfmt_misc 20480 1 - Live 0x0000000000000000
parport_pc 32768 0 - Live 0x0000000000000000
ppdev 20480 0 - Live 0x0000000000000000
lp 20480 0 - Live 0x0000000000000000
parport 49152 3 parport_pc,ppdev,lp, Live 0x0000000000000000
ip_tables 24576 0 - Live 0x0000000000000000
x_tables 40960 3 ip6table_filter,ip6_tables,ip_tables, Live
0x0000000000000000
autofs4 40960 2 - Live 0x0000000000000000
hid_generic 16384 0 - Live 0x0000000000000000
usbhid 49152 0 - Live 0x0000000000000000
hid 118784 2 hid_generic,usbhid, Live 0x0000000000000000
uas 24576 0 - Live 0x0000000000000000
usb_storage 69632 2 uas, Live 0x0000000000000000
i915 1798144 68 - Live 0x0000000000000000
i2c_algo_bit 16384 1 i915, Live 0x0000000000000000
rtsx_pci_sdmmc 24576 0 - Live 0x0000000000000000
drm_kms_helper 167936 1 i915, Live 0x0000000000000000
psmouse 147456 0 - Live 0x0000000000000000
syscopyarea 16384 1 drm_kms_helper, Live 0x0000000000000000
sysfillrect 16384 1 drm_kms_helper, Live 0x0000000000000000
sysimgblt 16384 1 drm_kms_helper, Live 0x0000000000000000
e1000e 245760 0 - Live 0x0000000000000000
fb_sys_fops 16384 1 drm_kms_helper, Live 0x0000000000000000
ahci 36864 2 - Live 0x0000000000000000
libahci 32768 1 ahci, Live 0x0000000000000000
drm 356352 24 i915,drm_kms_helper, Live 0x0000000000000000
ptp 20480 1 e1000e, Live 0x0000000000000000
rtsx_pci 57344 2 rtsx_pci_ms,rtsx_pci_sdmmc, Live 0x0000000000000000
pps_core 20480 1 ptp, Live 0x0000000000000000
wmi 24576 1 wmi_bmof, Live 0x0000000000000000
video 40960 2 thinkpad_acpi,i915, Live 0x0000000000000000

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem=
)

0000-0000 : PCI Bus 0000:00
  0000-0000 : dma1
  0000-0000 : pic1
  0000-0000 : timer0
  0000-0000 : timer1
  0000-0000 : keyboard
  0000-0000 : PNP0800:00
  0000-0000 : PNP0C09:00
    0000-0000 : EC data
  0000-0000 : keyboard
  0000-0000 : PNP0C09:00
    0000-0000 : EC cmd
  0000-0000 : rtc0
  0000-0000 : dma page reg
  0000-0000 : pic2
  0000-0000 : dma2
  0000-0000 : fpu
    0000-0000 : PNP0C04:00
  0000-0000 : vesafb
  0000-0000 : pnp 00:01
  0000-0000 : pnp 00:01
  0000-0000 : pnp 00:01
  0000-0000 : pnp 00:01
  0000-0000 : pnp 00:01
  0000-0000 : pnp 00:01
  0000-0000 : pnp 00:01
  0000-0000 : pnp 00:01
0000-0000 : PCI conf1
0000-0000 : PCI Bus 0000:00
  0000-0000 : pnp 00:01
  0000-0000 : pnp 00:01
    0000-0000 : pnp 00:01
  0000-0000 : pnp 00:01
    0000-0000 : ACPI PM1a_EVT_BLK
    0000-0000 : ACPI PM1a_CNT_BLK
    0000-0000 : ACPI PM_TMR
    0000-0000 : ACPI CPU throttle
    0000-0000 : iTCO_wdt.0.auto
    0000-0000 : ACPI PM2_CNT_BLK
    0000-0000 : iTCO_wdt.0.auto
    0000-0000 : ACPI GPE0_BLK
  0000-0000 : 0000:00:02.0
  0000-0000 : 0000:00:1f.2
    0000-0000 : ahci
  0000-0000 : 0000:00:19.0
  0000-0000 : 0000:00:1f.2
    0000-0000 : ahci
  0000-0000 : 0000:00:1f.2
    0000-0000 : ahci
  0000-0000 : 0000:00:16.3
    0000-0000 : serial
  0000-0000 : 0000:00:1f.2
    0000-0000 : ahci
  0000-0000 : 0000:00:1f.2
    0000-0000 : ahci
  0000-0000 : 0000:00:1f.3

00000000-00000000 : Reserved
00000000-00000000 : System RAM
00000000-00000000 : Reserved
00000000-00000000 : PCI Bus 0000:00
00000000-00000000 : Video ROM
00000000-00000000 : pnp 00:00
00000000-00000000 : pnp 00:00
00000000-00000000 : pnp 00:00
00000000-00000000 : pnp 00:00
00000000-00000000 : Reserved
  00000000-00000000 : System ROM
00000000-00000000 : System RAM
  00000000-00000000 : Kernel code
  00000000-00000000 : Kernel data
  00000000-00000000 : Kernel bss
00000000-00000000 : Reserved
00000000-00000000 : ACPI Non-volatile Storage
00000000-00000000 : ACPI Tables
00000000-00000000 : Reserved
  00000000-00000000 : Graphics Stolen Memory
00000000-00000000 : PCI Bus 0000:00
  00000000-00000000 : 0000:00:02.0
  00000000-00000000 : 0000:00:02.0
  00000000-00000000 : PCI Bus 0000:03
    00000000-00000000 : 0000:03:00.0
      00000000-00000000 : iwlwifi
  00000000-00000000 : PCI Bus 0000:02
    00000000-00000000 : 0000:02:00.0
      00000000-00000000 : rtsx_pci
  00000000-00000000 : 0000:00:19.0
    00000000-00000000 : e1000e
  00000000-00000000 : 0000:00:14.0
    00000000-00000000 : xhci-hcd
  00000000-00000000 : 0000:00:03.0
    00000000-00000000 : ICH HD audio
  00000000-00000000 : 0000:00:1b.0
    00000000-00000000 : ICH HD audio
  00000000-00000000 : 0000:00:1f.3
  00000000-00000000 : 0000:00:16.0
    00000000-00000000 : mei_me
  00000000-00000000 : 0000:00:1f.2
    00000000-00000000 : ahci
  00000000-00000000 : 0000:00:1d.0
    00000000-00000000 : ehci_hcd
  00000000-00000000 : 0000:00:19.0
    00000000-00000000 : e1000e
  00000000-00000000 : 0000:00:16.3
  00000000-00000000 : PCI MMCONFIG 0000 [bus 00-3f]
    00000000-00000000 : Reserved
      00000000-00000000 : pnp 00:01
  00000000-00000000 : Reserved
00000000-00000000 : Reserved
  00000000-00000000 : IOAPIC 0
00000000-00000000 : HPET 0
  00000000-00000000 : PNP0103:00
00000000-00000000 : Reserved
00000000-00000000 : Reserved
  00000000-00000000 : pnp 00:01
  00000000-00000000 : pnp 00:01
  00000000-00000000 : pnp 00:01
00000000-00000000 : Reserved
  00000000-00000000 : pnp 00:01
    00000000-00000000 : iTCO_wdt.0.auto
    00000000-00000000 : intel-spi
      00000000-00000000 : intel-spi
00000000-00000000 : PCI Bus 0000:00
  00000000-00000000 : TPM
  00000000-00000000 : pnp 00:01
00000000-00000000 : dmar0
00000000-00000000 : dmar1
00000000-00000000 : Local APIC
  00000000-00000000 : Reserved
00000000-00000000 : Reserved
00000000-00000000 : System RAM
00000000-00000000 : RAM buffer

[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Intel Corporation Haswell-ULT DRAM Controller (rev 0=
b)
	Subsystem: Lenovo Haswell-ULT DRAM Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <TAbort=
-
<MAbort+ >SERR- <PERR- INTx-
	Latency: 0
	Capabilities: [e0] Vendor Specific Information: Len=3D0c <?>
	Kernel driver in use: hsw_uncore

00:02.0 VGA compatible controller: Intel Corporation Haswell-ULT
Integrated Graphics Controller (rev 0b) (prog-if 00 [VGA controller])
	Subsystem: Lenovo Haswell-ULT Integrated Graphics Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <TAbort=
-
<MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 46
	Region 0: Memory at f0000000 (64-bit, non-prefetchable) [size=3D4M]
	Region 2: Memory at e0000000 (64-bit, prefetchable) [size=3D256M]
	Region 4: I/O ports at 3000 [size=3D64]
	[virtual] Expansion ROM at 000c0000 [disabled] [size=3D128K]
	Capabilities: [90] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
		Address: fee00018  Data: 0000
	Capabilities: [d0] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3c=
old-)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [a4] PCI Advanced Features
		AFCap: TP+ FLR+
		AFCtrl: FLR-
		AFStatus: TP-
	Kernel driver in use: i915
	Kernel modules: i915

00:03.0 Audio device: Intel Corporation Haswell-ULT HD Audio Controller
(rev 0b)
	Subsystem: Lenovo Haswell-ULT HD Audio Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort=
-
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 45
	Region 0: Memory at f0630000 (64-bit, non-prefetchable) [size=3D16K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3c=
old-)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [60] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
		Address: fee00318  Data: 0000
	Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 00=

		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
	Kernel driver in use: snd_hda_intel
	Kernel modules: snd_hda_intel

00:14.0 USB controller: Intel Corporation 8 Series USB xHCI HC (rev 04)
(prog-if 30 [XHCI])
	Subsystem: Lenovo 8 Series USB xHCI HC
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 42
	Region 0: Memory at f0620000 (64-bit, non-prefetchable) [size=3D64K]
	Capabilities: [70] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA
PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [80] MSI: Enable+ Count=3D1/8 Maskable- 64bit+
		Address: 00000000fee00278  Data: 0000
	Kernel driver in use: xhci_hcd

00:16.0 Communication controller: Intel Corporation 8 Series HECI #0
(rev 04)
	Subsystem: Lenovo 8 Series HECI
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort=
-
<MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 48
	Region 0: Memory at f0639000 (64-bit, non-prefetchable) [size=3D32]
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3c=
old+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [8c] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
		Address: 00000000fee00358  Data: 0000
	Kernel driver in use: mei_me
	Kernel modules: mei_me

00:16.3 Serial controller: Intel Corporation 8 Series HECI KT (rev 04)
(prog-if 02 [16550])
	Subsystem: Lenovo 8 Series HECI KT
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <TAbort=
-
<MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin D routed to IRQ 17
	Region 0: I/O ports at 30b0 [size=3D8]
	Region 1: Memory at f063f000 (32-bit, non-prefetchable) [size=3D4K]
	Capabilities: [c8] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3c=
old-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [d0] MSI: Enable- Count=3D1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Kernel driver in use: serial

00:19.0 Ethernet controller: Intel Corporation Ethernet Connection
I218-LM (rev 04)
	Subsystem: Lenovo ThinkPad X240
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort=
-
<MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 50
	Region 0: Memory at f0600000 (32-bit, non-prefetchable) [size=3D128K]
	Region 1: Memory at f063e000 (32-bit, non-prefetchable) [size=3D4K]
	Region 2: I/O ports at 3080 [size=3D32]
	Capabilities: [c8] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3c=
old+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D1 PME-
	Capabilities: [d0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
		Address: 00000000fee003b8  Data: 0000
	Capabilities: [e0] PCI Advanced Features
		AFCap: TP+ FLR+
		AFCtrl: FLR-
		AFStatus: TP+
	Kernel driver in use: e1000e
	Kernel modules: e1000e

00:1b.0 Audio device: Intel Corporation 8 Series HD Audio Controller
(rev 04)
	Subsystem: Lenovo 8 Series HD Audio Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort=
-
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 49
	Region 0: Memory at f0634000 (64-bit, non-prefetchable) [size=3D16K]
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D55mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [60] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
		Address: 00000000fee00398  Data: 0000
	Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 00=

		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
	Capabilities: [100 v1] Virtual Channel
		Caps:	LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=3DFixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=3D01
			Status:	NegoPending- InProgress-
		VC1:	Caps:	PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable- ID=3D2 ArbSelect=3DFixed TC/VC=3D04
			Status:	NegoPending- InProgress-
	Kernel driver in use: snd_hda_intel
	Kernel modules: snd_hda_intel

00:1c.0 PCI bridge: Intel Corporation 8 Series PCI Express Root Port 6
(rev e4) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort=
-
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 17
	Bus: primary=3D00, secondary=3D02, subordinate=3D02, sec-latency=3D0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: f0500000-f05fffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort=
-
<MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #6, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s
<512ns, L1 <16us
			ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp-
		LnkCtl:	ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+
BWMgmt+ ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #5, PowerLimit 10.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-=

			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet- LinkState+
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-=

		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+, OBFF Not
Supported ARIFwd-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF
Disabled ARIFwd-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance-
ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [80] MSI: Enable- Count=3D1/1 Maskable- 64bit-
		Address: 00000000  Data: 0000
	Capabilities: [90] Subsystem: Lenovo 8 Series PCI Express Root Port 6
	Capabilities: [a0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3c=
old+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [100 v0] #00
	Capabilities: [200 v1] L1 PM Substates
		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substat=
es+
			  PortCommonModeRestoreTime=3D40us PortTPowerOnTime=3D10us
	Kernel driver in use: pcieport
	Kernel modules: shpchp

00:1c.1 PCI bridge: Intel Corporation 8 Series PCI Express Root Port 3
(rev e4) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort=
-
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin C routed to IRQ 18
	Bus: primary=3D00, secondary=3D03, subordinate=3D03, sec-latency=3D0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: f0400000-f04fffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort=
-
<MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #3, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s
<512ns, L1 <16us
			ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp-
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+
BWMgmt+ ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #2, PowerLimit 10.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-=

			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet- LinkState+
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-=

		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+, OBFF Not
Supported ARIFwd-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF
Disabled ARIFwd-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance-
ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [80] MSI: Enable- Count=3D1/1 Maskable- 64bit-
		Address: 00000000  Data: 0000
	Capabilities: [90] Subsystem: Lenovo 8 Series PCI Express Root Port 3
	Capabilities: [a0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3c=
old+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [100 v0] #00
	Capabilities: [200 v1] L1 PM Substates
		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substat=
es+
			  PortCommonModeRestoreTime=3D40us PortTPowerOnTime=3D10us
	Kernel driver in use: pcieport
	Kernel modules: shpchp

00:1d.0 USB controller: Intel Corporation 8 Series USB EHCI #1 (rev 04)
(prog-if 20 [EHCI])
	Subsystem: Lenovo T440s
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 23
	Region 0: Memory at f063d000 (32-bit, non-prefetchable) [size=3D1K]
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [58] Debug port: BAR=3D1 offset=3D00a0
	Capabilities: [98] PCI Advanced Features
		AFCap: TP+ FLR+
		AFCtrl: FLR-
		AFStatus: TP-
	Kernel driver in use: ehci-pci

00:1f.0 ISA bridge: Intel Corporation 8 Series LPC Controller (rev 04)
	Subsystem: Lenovo 8 Series LPC Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Capabilities: [e0] Vendor Specific Information: Len=3D0c <?>
	Kernel driver in use: lpc_ich
	Kernel modules: lpc_ich

00:1f.2 SATA controller: Intel Corporation 8 Series SATA Controller 1
[AHCI mode] (rev 04) (prog-if 01 [AHCI 1.0])
	Subsystem: Lenovo 8 Series SATA Controller 1 [AHCI mode]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin B routed to IRQ 44
	Region 0: I/O ports at 30a8 [size=3D8]
	Region 1: I/O ports at 30bc [size=3D4]
	Region 2: I/O ports at 30a0 [size=3D8]
	Region 3: I/O ports at 30b8 [size=3D4]
	Region 4: I/O ports at 3060 [size=3D32]
	Region 5: Memory at f063c000 (32-bit, non-prefetchable) [size=3D2K]
	Capabilities: [80] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
		Address: fee002d8  Data: 0000
	Capabilities: [70] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot+,D3c=
old-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=3D00000004
	Kernel driver in use: ahci
	Kernel modules: ahci

00:1f.3 SMBus: Intel Corporation 8 Series SMBus Controller (rev 04)
	Subsystem: Lenovo 8 Series SMBus Controller
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin C routed to IRQ 10
	Region 0: Memory at f0638000 (64-bit, non-prefetchable) [size=3D256]
	Region 4: I/O ports at efa0 [size=3D32]
	Kernel modules: i2c_i801

02:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. RTS5227
PCI Express Card Reader (rev 01)
	Subsystem: Lenovo RTS5227 PCI Express Card Reader
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort=
-
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 43
	Region 0: Memory at f0500000 (32-bit, non-prefetchable) [size=3D4K]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA
PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [50] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
		Address: 00000000fee00298  Data: 0000
	Capabilities: [70] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1
unlimited
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency
L0s unlimited, L1 <64us
			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive-
BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis+, LTR+, OBFF
Via message/WAKE#
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF
Disabled
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance-
ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [100 v2] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr+ BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [140 v1] Device Serial Number 00-00-00-01-00-4c-e0-00
	Capabilities: [150 v1] Latency Tolerance Reporting
		Max snoop latency: 3145728ns
		Max no snoop latency: 3145728ns
	Capabilities: [158 v1] L1 PM Substates
		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substat=
es+
			  PortCommonModeRestoreTime=3D60us PortTPowerOnTime=3D60us
	Kernel driver in use: rtsx_pci
	Kernel modules: rtsx_pci

03:00.0 Network controller: Intel Corporation Wireless 7260 (rev 83)
	Subsystem: Intel Corporation Dual Band Wireless-AC 7260
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort=
-
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 47
	Region 0: Memory at f0400000 (64-bit, non-prefetchable) [size=3D8K]
	Capabilities: [c8] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3c=
old+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [d0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
		Address: 00000000fee00338  Data: 0000
	Capabilities: [40] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1
unlimited
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr+ NoSnoop+ FLReset-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency
L0s <4us, L1 <32us
			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp-
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive-
BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range B, TimeoutDis+, LTR+, OBFF Via WAKE#=

		DevCtl2: Completion Timeout: 16ms to 55ms, TimeoutDis-, LTR+, OBFF
Disabled
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance-
ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
	Capabilities: [140 v1] Device Serial Number 7c-7a-91-ff-ff-86-f6-5f
	Capabilities: [14c v1] Latency Tolerance Reporting
		Max snoop latency: 3145728ns
		Max no snoop latency: 3145728ns
	Capabilities: [154 v1] Vendor Specific Information: ID=3Dcafe Rev=3D1
Len=3D014 <?>
	Kernel driver in use: iwlwifi
	Kernel modules: iwlwifi

[7.6.] SCSI information (from /proc/scsi/scsi)
While booted into the newest upstream mainline kernel only, execute the
following via a terminal, and paste the results:

Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: HGST HTS725050A7 Rev: B550
  Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi3 Channel: 00 Id: 00 Lun: 00
  Vendor: Plugable Model: USB3-SATA-U3     Rev: 0
  Type:   Direct-Access                    ANSI  SCSI revision: 06


[7.7.] Other information that might be relevant to the problem (please
look in /proc and include all information that you think to be relevant):=


[X.] Other notes, patches, fixes, workarounds:

Output of cat /sys/kernel/debug/usb/devices

T:  Bus=3D01 Lev=3D00 Prnt=3D00 Port=3D00 Cnt=3D00 Dev#=3D  1 Spd=3D480  =
MxCh=3D 3
B:  Alloc=3D  0/800 us ( 0%), #Int=3D  0, #Iso=3D  0
D:  Ver=3D 2.00 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 MxPS=3D64 #Cfgs=3D  1
P:  Vendor=3D1d6b ProdID=3D0002 Rev=3D 4.13
S:  Manufacturer=3DLinux 4.13.0-041300-generic ehci_hcd
S:  Product=3DEHCI Host Controller
S:  SerialNumber=3D0000:00:1d.0
C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3De0 MxPwr=3D  0mA
I:* If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 Driver=
=3Dhub
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   4 Ivl=3D256ms

T:  Bus=3D01 Lev=3D01 Prnt=3D01 Port=3D00 Cnt=3D01 Dev#=3D  2 Spd=3D480  =
MxCh=3D 8
D:  Ver=3D 2.00 Cls=3D09(hub  ) Sub=3D00 Prot=3D01 MxPS=3D64 #Cfgs=3D  1
P:  Vendor=3D8087 ProdID=3D8000 Rev=3D 0.04
C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3De0 MxPwr=3D  0mA
I:* If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 Driver=
=3Dhub
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   2 Ivl=3D256ms

T:  Bus=3D02 Lev=3D00 Prnt=3D00 Port=3D00 Cnt=3D00 Dev#=3D  1 Spd=3D480  =
MxCh=3D 9
B:  Alloc=3D  0/800 us ( 0%), #Int=3D  0, #Iso=3D  0
D:  Ver=3D 2.00 Cls=3D09(hub  ) Sub=3D00 Prot=3D01 MxPS=3D64 #Cfgs=3D  1
P:  Vendor=3D1d6b ProdID=3D0002 Rev=3D 4.13
S:  Manufacturer=3DLinux 4.13.0-041300-generic xhci-hcd
S:  Product=3DxHCI Host Controller
S:  SerialNumber=3D0000:00:14.0
C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3De0 MxPwr=3D  0mA
I:* If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 Driver=
=3Dhub
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   4 Ivl=3D256ms

T:  Bus=3D02 Lev=3D01 Prnt=3D01 Port=3D02 Cnt=3D01 Dev#=3D 84 Spd=3D480  =
MxCh=3D 4
D:  Ver=3D 2.00 Cls=3D09(hub  ) Sub=3D00 Prot=3D01 MxPS=3D64 #Cfgs=3D  1
P:  Vendor=3D17ef ProdID=3D1010 Rev=3D50.30
S:  Manufacturer=3DLENOVO
S:  Product=3DLenovo ThinkPad Dock
C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3De0 MxPwr=3D  0mA
I:* If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 Driver=
=3Dhub
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   1 Ivl=3D256ms

T:  Bus=3D02 Lev=3D02 Prnt=3D84 Port=3D00 Cnt=3D01 Dev#=3D 85 Spd=3D480  =
MxCh=3D 3
D:  Ver=3D 2.00 Cls=3D09(hub  ) Sub=3D00 Prot=3D01 MxPS=3D64 #Cfgs=3D  1
P:  Vendor=3D0409 ProdID=3D005a Rev=3D 1.00
C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3De0 MxPwr=3D100mA
I:* If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 Driver=
=3Dhub
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   1 Ivl=3D256ms

T:  Bus=3D02 Lev=3D03 Prnt=3D85 Port=3D00 Cnt=3D01 Dev#=3D 87 Spd=3D12   =
MxCh=3D 0
D:  Ver=3D 1.10 Cls=3D00(>ifc ) Sub=3D00 Prot=3D00 MxPS=3D 8 #Cfgs=3D  1
P:  Vendor=3D0853 ProdID=3D0100 Rev=3D 1.02
S:  Manufacturer=3DTopre Corporation
S:  Product=3DHHKB Professional
C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3D80 MxPwr=3D100mA
I:* If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D03(HID  ) Sub=3D01 Prot=3D01 Driver=
=3Dusbhid
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   8 Ivl=3D10ms

T:  Bus=3D02 Lev=3D03 Prnt=3D85 Port=3D02 Cnt=3D02 Dev#=3D 88 Spd=3D1.5  =
MxCh=3D 0
D:  Ver=3D 1.10 Cls=3D00(>ifc ) Sub=3D00 Prot=3D00 MxPS=3D 8 #Cfgs=3D  1
P:  Vendor=3D047d ProdID=3D1020 Rev=3D 1.00
S:  Manufacturer=3DKensington
S:  Product=3DKensington Expert Mouse
C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3Da0 MxPwr=3D100mA
I:* If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D03(HID  ) Sub=3D01 Prot=3D02 Driver=
=3Dusbhid
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   4 Ivl=3D10ms

T:  Bus=3D02 Lev=3D02 Prnt=3D84 Port=3D01 Cnt=3D02 Dev#=3D 86 Spd=3D480  =
MxCh=3D 0
D:  Ver=3D 2.00 Cls=3Def(misc ) Sub=3D02 Prot=3D01 MxPS=3D64 #Cfgs=3D  1
P:  Vendor=3D046d ProdID=3D0990 Rev=3D 0.07
S:  SerialNumber=3D48B57A09
C:* #Ifs=3D 4 Cfg#=3D 1 Atr=3D80 MxPwr=3D500mA
A:  FirstIf#=3D 0 IfCount=3D 2 Cls=3D0e(video) Sub=3D03 Prot=3D00
A:  FirstIf#=3D 2 IfCount=3D 2 Cls=3D01(audio) Sub=3D02 Prot=3D00
I:* If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D0e(video) Sub=3D01 Prot=3D00 Driver=
=3Duvcvideo
E:  Ad=3D87(I) Atr=3D03(Int.) MxPS=3D  16 Ivl=3D16ms
I:* If#=3D 1 Alt=3D 0 #EPs=3D 0 Cls=3D0e(video) Sub=3D02 Prot=3D00 Driver=
=3Duvcvideo
I:  If#=3D 1 Alt=3D 1 #EPs=3D 1 Cls=3D0e(video) Sub=3D02 Prot=3D00 Driver=
=3Duvcvideo
E:  Ad=3D81(I) Atr=3D05(Isoc) MxPS=3D 192 Ivl=3D125us
I:  If#=3D 1 Alt=3D 2 #EPs=3D 1 Cls=3D0e(video) Sub=3D02 Prot=3D00 Driver=
=3Duvcvideo
E:  Ad=3D81(I) Atr=3D05(Isoc) MxPS=3D 384 Ivl=3D125us
I:  If#=3D 1 Alt=3D 3 #EPs=3D 1 Cls=3D0e(video) Sub=3D02 Prot=3D00 Driver=
=3Duvcvideo
E:  Ad=3D81(I) Atr=3D05(Isoc) MxPS=3D 512 Ivl=3D125us
I:  If#=3D 1 Alt=3D 4 #EPs=3D 1 Cls=3D0e(video) Sub=3D02 Prot=3D00 Driver=
=3Duvcvideo
E:  Ad=3D81(I) Atr=3D05(Isoc) MxPS=3D 640 Ivl=3D125us
I:  If#=3D 1 Alt=3D 5 #EPs=3D 1 Cls=3D0e(video) Sub=3D02 Prot=3D00 Driver=
=3Duvcvideo
E:  Ad=3D81(I) Atr=3D05(Isoc) MxPS=3D 800 Ivl=3D125us
I:  If#=3D 1 Alt=3D 6 #EPs=3D 1 Cls=3D0e(video) Sub=3D02 Prot=3D00 Driver=
=3Duvcvideo
E:  Ad=3D81(I) Atr=3D05(Isoc) MxPS=3D 944 Ivl=3D125us
I:  If#=3D 1 Alt=3D 7 #EPs=3D 1 Cls=3D0e(video) Sub=3D02 Prot=3D00 Driver=
=3Duvcvideo
E:  Ad=3D81(I) Atr=3D05(Isoc) MxPS=3D1280 Ivl=3D125us
I:  If#=3D 1 Alt=3D 8 #EPs=3D 1 Cls=3D0e(video) Sub=3D02 Prot=3D00 Driver=
=3Duvcvideo
E:  Ad=3D81(I) Atr=3D05(Isoc) MxPS=3D1600 Ivl=3D125us
I:  If#=3D 1 Alt=3D 9 #EPs=3D 1 Cls=3D0e(video) Sub=3D02 Prot=3D00 Driver=
=3Duvcvideo
E:  Ad=3D81(I) Atr=3D05(Isoc) MxPS=3D1984 Ivl=3D125us
I:  If#=3D 1 Alt=3D10 #EPs=3D 1 Cls=3D0e(video) Sub=3D02 Prot=3D00 Driver=
=3Duvcvideo
E:  Ad=3D81(I) Atr=3D05(Isoc) MxPS=3D2688 Ivl=3D125us
I:  If#=3D 1 Alt=3D11 #EPs=3D 1 Cls=3D0e(video) Sub=3D02 Prot=3D00 Driver=
=3Duvcvideo
E:  Ad=3D81(I) Atr=3D05(Isoc) MxPS=3D3060 Ivl=3D125us
I:* If#=3D 2 Alt=3D 0 #EPs=3D 0 Cls=3D01(audio) Sub=3D01 Prot=3D00 Driver=
=3Dsnd-usb-audio
I:* If#=3D 3 Alt=3D 0 #EPs=3D 0 Cls=3D01(audio) Sub=3D02 Prot=3D00 Driver=
=3Dsnd-usb-audio
I:  If#=3D 3 Alt=3D 1 #EPs=3D 1 Cls=3D01(audio) Sub=3D02 Prot=3D00 Driver=
=3Dsnd-usb-audio
E:  Ad=3D86(I) Atr=3D05(Isoc) MxPS=3D  36 Ivl=3D1ms

T:  Bus=3D02 Lev=3D02 Prnt=3D84 Port=3D03 Cnt=3D03 Dev#=3D 89 Spd=3D480  =
MxCh=3D 3
D:  Ver=3D 2.00 Cls=3D09(hub  ) Sub=3D00 Prot=3D02 MxPS=3D64 #Cfgs=3D  1
P:  Vendor=3D17ef ProdID=3D100f Rev=3D 0.01
S:  Manufacturer=3DLenovo
S:  Product=3DLenovo ThinkPad Dock
S:  SerialNumber=3DRev1.2
C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3De0 MxPwr=3D  2mA
I:  If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D09(hub  ) Sub=3D00 Prot=3D01 Driver=
=3Dhub
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   1 Ivl=3D256ms
I:* If#=3D 0 Alt=3D 1 #EPs=3D 1 Cls=3D09(hub  ) Sub=3D00 Prot=3D02 Driver=
=3Dhub
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   1 Ivl=3D256ms

T:  Bus=3D02 Lev=3D03 Prnt=3D89 Port=3D01 Cnt=3D01 Dev#=3D 90 Spd=3D480  =
MxCh=3D 4
D:  Ver=3D 2.00 Cls=3D09(hub  ) Sub=3D00 Prot=3D02 MxPS=3D64 #Cfgs=3D  1
P:  Vendor=3D05e3 ProdID=3D0610 Rev=3D92.24
S:  Manufacturer=3DGenesysLogic
S:  Product=3DUSB2.0 Hub
C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3De0 MxPwr=3D100mA
I:  If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D09(hub  ) Sub=3D00 Prot=3D01 Driver=
=3Dhub
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   1 Ivl=3D256ms
I:* If#=3D 0 Alt=3D 1 #EPs=3D 1 Cls=3D09(hub  ) Sub=3D00 Prot=3D02 Driver=
=3Dhub
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   1 Ivl=3D256ms

T:  Bus=3D02 Lev=3D04 Prnt=3D90 Port=3D00 Cnt=3D01 Dev#=3D 91 Spd=3D480  =
MxCh=3D 0
D:  Ver=3D 2.00 Cls=3D00(>ifc ) Sub=3D00 Prot=3D00 MxPS=3D64 #Cfgs=3D  1
P:  Vendor=3D0d8c ProdID=3D1319 Rev=3D 1.05
S:  Manufacturer=3DSchiit Audio
S:  Product=3DUSB Modi Device
C:* #Ifs=3D 3 Cfg#=3D 1 Atr=3Dc0 MxPwr=3D500mA
I:* If#=3D 0 Alt=3D 0 #EPs=3D 0 Cls=3D01(audio) Sub=3D01 Prot=3D00 Driver=
=3Dsnd-usb-audio
I:* If#=3D 1 Alt=3D 0 #EPs=3D 0 Cls=3D01(audio) Sub=3D02 Prot=3D00 Driver=
=3Dsnd-usb-audio
I:  If#=3D 1 Alt=3D 1 #EPs=3D 2 Cls=3D01(audio) Sub=3D02 Prot=3D00 Driver=
=3Dsnd-usb-audio
E:  Ad=3D05(O) Atr=3D05(Isoc) MxPS=3D 392 Ivl=3D1ms
E:  Ad=3D85(I) Atr=3D01(Isoc) MxPS=3D   3 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 2 #EPs=3D 2 Cls=3D01(audio) Sub=3D02 Prot=3D00 Driver=
=3Dsnd-usb-audio
E:  Ad=3D05(O) Atr=3D05(Isoc) MxPS=3D 588 Ivl=3D1ms
E:  Ad=3D85(I) Atr=3D01(Isoc) MxPS=3D   3 Ivl=3D1ms
I:* If#=3D 2 Alt=3D 0 #EPs=3D 1 Cls=3D03(HID  ) Sub=3D00 Prot=3D00 Driver=
=3Dusbhid
E:  Ad=3D84(I) Atr=3D03(Int.) MxPS=3D  16 Ivl=3D1ms

T:  Bus=3D02 Lev=3D01 Prnt=3D01 Port=3D05 Cnt=3D02 Dev#=3D  3 Spd=3D12   =
MxCh=3D 0
D:  Ver=3D 1.10 Cls=3Dff(vend.) Sub=3D11 Prot=3Dff MxPS=3D 8 #Cfgs=3D  1
P:  Vendor=3D138a ProdID=3D0017 Rev=3D 0.78
S:  SerialNumber=3Dfd3506557e18
C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3Da0 MxPwr=3D100mA
I:* If#=3D 0 Alt=3D 0 #EPs=3D 4 Cls=3Dff(vend.) Sub=3D00 Prot=3D00 Driver=
=3D(none)
E:  Ad=3D01(O) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
E:  Ad=3D81(I) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
E:  Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
E:  Ad=3D83(I) Atr=3D03(Int.) MxPS=3D   8 Ivl=3D4ms

T:  Bus=3D02 Lev=3D01 Prnt=3D01 Port=3D07 Cnt=3D03 Dev#=3D  8 Spd=3D480  =
MxCh=3D 0
D:  Ver=3D 2.00 Cls=3Def(misc ) Sub=3D02 Prot=3D01 MxPS=3D64 #Cfgs=3D  1
P:  Vendor=3D04f2 ProdID=3Db39a Rev=3D26.03
S:  Manufacturer=3DSunplusIT INC.
S:  Product=3DIntegrated Camera
C:* #Ifs=3D 2 Cfg#=3D 1 Atr=3D80 MxPwr=3D500mA
A:  FirstIf#=3D 0 IfCount=3D 2 Cls=3D0e(video) Sub=3D03 Prot=3D00
I:* If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D0e(video) Sub=3D01 Prot=3D00 Driver=
=3Duvcvideo
E:  Ad=3D87(I) Atr=3D03(Int.) MxPS=3D  16 Ivl=3D16ms
I:* If#=3D 1 Alt=3D 0 #EPs=3D 0 Cls=3D0e(video) Sub=3D02 Prot=3D00 Driver=
=3Duvcvideo
I:  If#=3D 1 Alt=3D 1 #EPs=3D 1 Cls=3D0e(video) Sub=3D02 Prot=3D00 Driver=
=3Duvcvideo
E:  Ad=3D81(I) Atr=3D05(Isoc) MxPS=3D 192 Ivl=3D125us
I:  If#=3D 1 Alt=3D 2 #EPs=3D 1 Cls=3D0e(video) Sub=3D02 Prot=3D00 Driver=
=3Duvcvideo
E:  Ad=3D81(I) Atr=3D05(Isoc) MxPS=3D 384 Ivl=3D125us
I:  If#=3D 1 Alt=3D 3 #EPs=3D 1 Cls=3D0e(video) Sub=3D02 Prot=3D00 Driver=
=3Duvcvideo
E:  Ad=3D81(I) Atr=3D05(Isoc) MxPS=3D 512 Ivl=3D125us
I:  If#=3D 1 Alt=3D 4 #EPs=3D 1 Cls=3D0e(video) Sub=3D02 Prot=3D00 Driver=
=3Duvcvideo
E:  Ad=3D81(I) Atr=3D05(Isoc) MxPS=3D 640 Ivl=3D125us
I:  If#=3D 1 Alt=3D 5 #EPs=3D 1 Cls=3D0e(video) Sub=3D02 Prot=3D00 Driver=
=3Duvcvideo
E:  Ad=3D81(I) Atr=3D05(Isoc) MxPS=3D 800 Ivl=3D125us
I:  If#=3D 1 Alt=3D 6 #EPs=3D 1 Cls=3D0e(video) Sub=3D02 Prot=3D00 Driver=
=3Duvcvideo
E:  Ad=3D81(I) Atr=3D05(Isoc) MxPS=3D 944 Ivl=3D125us
I:  If#=3D 1 Alt=3D 7 #EPs=3D 1 Cls=3D0e(video) Sub=3D02 Prot=3D00 Driver=
=3Duvcvideo
E:  Ad=3D81(I) Atr=3D05(Isoc) MxPS=3D1280 Ivl=3D125us
I:  If#=3D 1 Alt=3D 8 #EPs=3D 1 Cls=3D0e(video) Sub=3D02 Prot=3D00 Driver=
=3Duvcvideo
E:  Ad=3D81(I) Atr=3D05(Isoc) MxPS=3D1600 Ivl=3D125us
I:  If#=3D 1 Alt=3D 9 #EPs=3D 1 Cls=3D0e(video) Sub=3D02 Prot=3D00 Driver=
=3Duvcvideo
E:  Ad=3D81(I) Atr=3D05(Isoc) MxPS=3D1984 Ivl=3D125us
I:  If#=3D 1 Alt=3D10 #EPs=3D 1 Cls=3D0e(video) Sub=3D02 Prot=3D00 Driver=
=3Duvcvideo
E:  Ad=3D81(I) Atr=3D05(Isoc) MxPS=3D2880 Ivl=3D125us
I:  If#=3D 1 Alt=3D11 #EPs=3D 1 Cls=3D0e(video) Sub=3D02 Prot=3D00 Driver=
=3Duvcvideo
E:  Ad=3D81(I) Atr=3D05(Isoc) MxPS=3D3060 Ivl=3D125us

T:  Bus=3D03 Lev=3D00 Prnt=3D00 Port=3D00 Cnt=3D00 Dev#=3D  1 Spd=3D5000 =
MxCh=3D 4
B:  Alloc=3D  0/800 us ( 0%), #Int=3D  0, #Iso=3D  0
D:  Ver=3D 3.00 Cls=3D09(hub  ) Sub=3D00 Prot=3D03 MxPS=3D 9 #Cfgs=3D  1
P:  Vendor=3D1d6b ProdID=3D0003 Rev=3D 4.13
S:  Manufacturer=3DLinux 4.13.0-041300-generic xhci-hcd
S:  Product=3DxHCI Host Controller
S:  SerialNumber=3D0000:00:14.0
C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3De0 MxPwr=3D  0mA
I:* If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 Driver=
=3Dhub
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   4 Ivl=3D256ms

T:  Bus=3D03 Lev=3D01 Prnt=3D01 Port=3D02 Cnt=3D01 Dev#=3D 23 Spd=3D5000 =
MxCh=3D 4
D:  Ver=3D 3.00 Cls=3D09(hub  ) Sub=3D00 Prot=3D03 MxPS=3D 9 #Cfgs=3D  1
P:  Vendor=3D17ef ProdID=3D1010 Rev=3D50.31
S:  Manufacturer=3DLENOVO
S:  Product=3DLenovo ThinkPad Dock
C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3De0 MxPwr=3D  0mA
I:* If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 Driver=
=3Dhub
E:  Ad=3D81(I) Atr=3D13(Int.) MxPS=3D   2 Ivl=3D16ms

T:  Bus=3D03 Lev=3D02 Prnt=3D23 Port=3D02 Cnt=3D01 Dev#=3D 24 Spd=3D5000 =
MxCh=3D 0
D:  Ver=3D 3.00 Cls=3D00(>ifc ) Sub=3D00 Prot=3D00 MxPS=3D 9 #Cfgs=3D  1
P:  Vendor=3D174c ProdID=3D55aa Rev=3D 1.00
S:  Manufacturer=3DPlugable Technologies
S:  Product=3DUSB3-SATA-U3
S:  SerialNumber=3D100000000000000090D3
C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3Dc0 MxPwr=3D144mA
I:* If#=3D 0 Alt=3D 0 #EPs=3D 2 Cls=3D08(stor.) Sub=3D06 Prot=3D50 Driver=
=3Dusb-storage
E:  Ad=3D81(I) Atr=3D02(Bulk) MxPS=3D1024 Ivl=3D0ms
E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D1024 Ivl=3D0ms
I:  If#=3D 0 Alt=3D 1 #EPs=3D 4 Cls=3D08(stor.) Sub=3D06 Prot=3D62 Driver=
=3Dusb-storage
E:  Ad=3D81(I) Atr=3D02(Bulk) MxPS=3D1024 Ivl=3D0ms
E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D1024 Ivl=3D0ms
E:  Ad=3D83(I) Atr=3D02(Bulk) MxPS=3D1024 Ivl=3D0ms
E:  Ad=3D04(O) Atr=3D02(Bulk) MxPS=3D1024 Ivl=3D0ms


--q3j4JMFkWXs1WgJFGverEqAMsjK9njtJ6--

--rUTwRQHl20Dc6mkcoNFufFawhSn308b6H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCAAGBQJZtCnTAAoJEDZh49cbf8dpDE8H/0qBRHFr+SLFnt6uFQSU1UNF
17wovu/pe2f12TmaZzecUKgOApljNB2h03r6omStWwjrBF7jQ4h8GYHjzJ86tGMF
sbjpv/ju0IfUcb6hpJS1J2+owX+8r3DPoFLPzsUsQH7UX8RdLDYzNl0HKSXMK2gI
D+52a/xmzXzBk58c8ePO/ogf2aUilZHJFb5Nz7ALyQtpy9HmgMLd5nvz25vkCfV3
Zyzmn865irvS00IwAyuu+cSO5Kc5QiX6kghOJVrL1nqlUJeNXpeae8/KrJoPThTH
zICHNJBdLBCSMQEJrGZTrdyL1Puqv2lHc9er0cEz2lzlyc9WGpiy/BmmxrdheTg=
=fYLw
-----END PGP SIGNATURE-----

--rUTwRQHl20Dc6mkcoNFufFawhSn308b6H--
