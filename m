Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Sun, 11 May 2014 18:49:44 +0200
From: fuujuhi <fuujuhi-ml1@immie.org>
To: linux-bluetooth@vger.kernel.org
Subject: 168c:0032 ath3k built-in bluetooth cannot load firmware - sporadic
Message-ID: <88d403ffa5e2545bc5d4a4befd870a3e@immie.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

[1.] 168c:0032 ath3k built-in bluetooth cannot load firmware - sporadic

[2.] Full description of the problem/report:

     This is on an ASUS N550JV, on 3.15.0-031500rc4-generic.
     (using Ubuntu 14.04 LTS Trusty Tahr; first occured in Ubuntu 13.10).
     Basically, the Bluetooth is sporadically available after 
restart/login.
     When not available, we get an error msg in dmesg about a patch that 
failed to load

     $ dmesg | grep -C2 "Bluetooth.*patch"
     [   28.285666] sd 5:0:0:0: [sdb] Attached SCSI removable disk
     [   31.001536] Bluetooth: Error in firmware loading err = -110,len = 
448, size = 4096
     [   31.001546] Bluetooth: Loading patch file failed
     [   31.001554] ath3k: probe of 3-5:1.0 failed with error -110
     [   31.001608] usbcore: registered new interface driver ath3k

     $ sudo lsusb -v
      Bus 003 Device 016: ID 13d3:3402 IMC Networks
      Device Descriptor:
        bDeviceProtocol 1 Bluetooth
        idVendor 0x13d3 IMC Networks
        idProduct 0x3402
        bcdDevice 0.02
        iManufacturer 1 Atheros Communications
        iProduct 2 Bluetooth USB Host Controller
        iSerial 3 Alaska Day 2006

     Things already tried (to no much avail):
      - Update BIOS to latest version
      - Install "bluetooth" package
      - Enable ath9k bt coexistence (as per 
http://5thpeephole.blogspot.be/2013/10/install-ubuntu-1310-in-asus-n550jv.html)
      - unload / reload ath3k module:
        $ sudo modprobe -r ath3k; sleep 1; sudo modprobe ath3k
      - Try latest kernel 3.15.0-031500rc4-generic

[3.] Keywords (i.e., modules, networking, kernel):



[4.] Kernel version (from /proc/version):

     Linux version 3.15.0-031500rc4-generic (apw@gomeisa) (gcc version 
4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201405042135 SMP Mon May 5 
01:36:35 UTC 2014

[5.] Output of Oops.. message (if applicable) with symbolic information
      resolved (see Documentation/oops-tracing.txt)

      N/A

[6.] A small shell script or example program which triggers the
      problem (if possible)

      N/A

[7.] Environment

     $ lsb_release -rd
     Description:	Ubuntu 14.04 LTS
     Release:	14.04

[7.1.] Software (add the output of the ver_linux script here)

     $ /usr/src/linux-headers-3.15.0-031500rc4-generic/scripts/ver_linux
     If some fields are empty or look unusual you may have an old 
version.
     Compare to the current minimal requirements in 
Documentation/Changes.

     Linux zyratastic 3.15.0-031500rc4-generic #201405042135 SMP Mon May 
5 01:36:35 UTC 2014 x86_64 x86_64 x86_64 GNU/Linux

     Gnu C                  4.8
     Gnu make               3.81
     binutils               2.24
     util-linux             2.20.1
     mount                  support
     module-init-tools      15
     e2fsprogs              1.42.9
     pcmciautils            018
     PPP                    2.4.5
     Linux C Library        2.19
     Dynamic linker (ldd)   2.19
     Procps                 3.3.9
     Net-tools              1.60
     Kbd                    1.15.5
     Sh-utils               8.21
     wireless-tools         30
     Modules Loaded         md4 nls_utf8 cifs autofs4 ctr ccm nfsd 
auth_rpcgss nfs_acl nfs lockd sunrpc rfcomm bnep binfmt_misc fscache 
nls_iso8859_1 rts5139 hid_multitouch snd_hda_codec_realtek 
snd_hda_codec_hdmi snd_hda_codec_generic joydev snd_hda_intel 
x86_pkg_temp_thermal intel_powerclamp snd_hda_controller coretemp 
snd_hda_codec kvm_intel snd_hwdep kvm snd_pcm asus_nb_wmi asus_wmi 
snd_seq_midi snd_seq_midi_event snd_rawmidi sparse_keymap snd_seq 
mxm_wmi snd_seq_device arc4 snd_timer ath9k i915 ath9k_common uvcvideo 
snd ath9k_hw crct10dif_pclmul crc32_pclmul videobuf2_vmalloc 
videobuf2_memops videobuf2_core videodev soundcore ghash_clmulni_intel 
ath3k btusb aesni_intel bluetooth ath aes_x86_64 mac80211 drm_kms_helper 
lrw gf128mul glue_helper cfg80211 psmouse drm serio_raw ablk_helper 
parport_pc video ppdev cryptd mei_me lp parport mei lpc_ich i2c_algo_bit 
mac_hid wmi usbhid hid r8169 ahci libahci mii

[7.2.] Processor information (from /proc/cpuinfo):

     $ cat /proc/cpuinfo
     processor	: 0
     vendor_id	: GenuineIntel
     cpu family	: 6
     model		: 60
     model name	: Intel(R) Core(TM) i7-4700HQ CPU @ 2.40GHz
     stepping	: 3
     microcode	: 0x9
     cpu MHz		: 2311.500
     cache size	: 6144 KB
     physical id	: 0
     siblings	: 8
     core id		: 0
     cpu cores	: 4
     apicid		: 0
     initial apicid	: 0
     fpu		: yes
     fpu_exception	: yes
     cpuid level	: 13
     wp		: yes
     flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall 
nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl 
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor 
ds_cpl vmx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic 
movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 
ida arat epb xsaveopt pln pts dtherm tpr_shadow vnmi flexpriority ept 
vpid fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid
     bogomips	: 4788.76
     clflush size	: 64
     cache_alignment	: 64
     address sizes	: 39 bits physical, 48 bits virtual
     power management:

     processor	: 1
     vendor_id	: GenuineIntel
     cpu family	: 6
     model		: 60
     model name	: Intel(R) Core(TM) i7-4700HQ CPU @ 2.40GHz
     stepping	: 3
     microcode	: 0x9
     cpu MHz		: 2424.000
     cache size	: 6144 KB
     physical id	: 0
     siblings	: 8
     core id		: 1
     cpu cores	: 4
     apicid		: 2
     initial apicid	: 2
     fpu		: yes
     fpu_exception	: yes
     cpuid level	: 13
     wp		: yes
     flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall 
nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl 
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor 
ds_cpl vmx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic 
movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 
ida arat epb xsaveopt pln pts dtherm tpr_shadow vnmi flexpriority ept 
vpid fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid
     bogomips	: 4788.76
     clflush size	: 64
     cache_alignment	: 64
     address sizes	: 39 bits physical, 48 bits virtual
     power management:

     processor	: 2
     vendor_id	: GenuineIntel
     cpu family	: 6
     model		: 60
     model name	: Intel(R) Core(TM) i7-4700HQ CPU @ 2.40GHz
     stepping	: 3
     microcode	: 0x9
     cpu MHz		: 2424.000
     cache size	: 6144 KB
     physical id	: 0
     siblings	: 8
     core id		: 2
     cpu cores	: 4
     apicid		: 4
     initial apicid	: 4
     fpu		: yes
     fpu_exception	: yes
     cpuid level	: 13
     wp		: yes
     flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall 
nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl 
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor 
ds_cpl vmx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic 
movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 
ida arat epb xsaveopt pln pts dtherm tpr_shadow vnmi flexpriority ept 
vpid fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid
     bogomips	: 4788.76
     clflush size	: 64
     cache_alignment	: 64
     address sizes	: 39 bits physical, 48 bits virtual
     power management:

     processor	: 3
     vendor_id	: GenuineIntel
     cpu family	: 6
     model		: 60
     model name	: Intel(R) Core(TM) i7-4700HQ CPU @ 2.40GHz
     stepping	: 3
     microcode	: 0x9
     cpu MHz		: 2461.500
     cache size	: 6144 KB
     physical id	: 0
     siblings	: 8
     core id		: 3
     cpu cores	: 4
     apicid		: 6
     initial apicid	: 6
     fpu		: yes
     fpu_exception	: yes
     cpuid level	: 13
     wp		: yes
     flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall 
nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl 
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor 
ds_cpl vmx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic 
movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 
ida arat epb xsaveopt pln pts dtherm tpr_shadow vnmi flexpriority ept 
vpid fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid
     bogomips	: 4788.76
     clflush size	: 64
     cache_alignment	: 64
     address sizes	: 39 bits physical, 48 bits virtual
     power management:

     processor	: 4
     vendor_id	: GenuineIntel
     cpu family	: 6
     model		: 60
     model name	: Intel(R) Core(TM) i7-4700HQ CPU @ 2.40GHz
     stepping	: 3
     microcode	: 0x9
     cpu MHz		: 2424.000
     cache size	: 6144 KB
     physical id	: 0
     siblings	: 8
     core id		: 0
     cpu cores	: 4
     apicid		: 1
     initial apicid	: 1
     fpu		: yes
     fpu_exception	: yes
     cpuid level	: 13
     wp		: yes
     flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall 
nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl 
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor 
ds_cpl vmx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic 
movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 
ida arat epb xsaveopt pln pts dtherm tpr_shadow vnmi flexpriority ept 
vpid fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid
     bogomips	: 4788.76
     clflush size	: 64
     cache_alignment	: 64
     address sizes	: 39 bits physical, 48 bits virtual
     power management:

     processor	: 5
     vendor_id	: GenuineIntel
     cpu family	: 6
     model		: 60
     model name	: Intel(R) Core(TM) i7-4700HQ CPU @ 2.40GHz
     stepping	: 3
     microcode	: 0x9
     cpu MHz		: 2274.000
     cache size	: 6144 KB
     physical id	: 0
     siblings	: 8
     core id		: 1
     cpu cores	: 4
     apicid		: 3
     initial apicid	: 3
     fpu		: yes
     fpu_exception	: yes
     cpuid level	: 13
     wp		: yes
     flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall 
nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl 
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor 
ds_cpl vmx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic 
movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 
ida arat epb xsaveopt pln pts dtherm tpr_shadow vnmi flexpriority ept 
vpid fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid
     bogomips	: 4788.76
     clflush size	: 64
     cache_alignment	: 64
     address sizes	: 39 bits physical, 48 bits virtual
     power management:

     processor	: 6
     vendor_id	: GenuineIntel
     cpu family	: 6
     model		: 60
     model name	: Intel(R) Core(TM) i7-4700HQ CPU @ 2.40GHz
     stepping	: 3
     microcode	: 0x9
     cpu MHz		: 2836.500
     cache size	: 6144 KB
     physical id	: 0
     siblings	: 8
     core id		: 2
     cpu cores	: 4
     apicid		: 5
     initial apicid	: 5
     fpu		: yes
     fpu_exception	: yes
     cpuid level	: 13
     wp		: yes
     flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall 
nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl 
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor 
ds_cpl vmx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic 
movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 
ida arat epb xsaveopt pln pts dtherm tpr_shadow vnmi flexpriority ept 
vpid fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid
     bogomips	: 4788.76
     clflush size	: 64
     cache_alignment	: 64
     address sizes	: 39 bits physical, 48 bits virtual
     power management:

     processor	: 7
     vendor_id	: GenuineIntel
     cpu family	: 6
     model		: 60
     model name	: Intel(R) Core(TM) i7-4700HQ CPU @ 2.40GHz
     stepping	: 3
     microcode	: 0x9
     cpu MHz		: 2424.000
     cache size	: 6144 KB
     physical id	: 0
     siblings	: 8
     core id		: 3
     cpu cores	: 4
     apicid		: 7
     initial apicid	: 7
     fpu		: yes
     fpu_exception	: yes
     cpuid level	: 13
     wp		: yes
     flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall 
nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl 
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor 
ds_cpl vmx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic 
movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 
ida arat epb xsaveopt pln pts dtherm tpr_shadow vnmi flexpriority ept 
vpid fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid
     bogomips	: 4788.76
     clflush size	: 64
     cache_alignment	: 64
     address sizes	: 39 bits physical, 48 bits virtual
     power management:


[7.3.] Module information (from /proc/modules):

     $ cat /proc/modules
     md4 12595 0 - Live 0x0000000000000000
     nls_utf8 12557 0 - Live 0x0000000000000000
     cifs 470607 0 - Live 0x0000000000000000
     autofs4 39275 3 - Live 0x0000000000000000
     ctr 13193 2 - Live 0x0000000000000000
     ccm 17856 2 - Live 0x0000000000000000
     nfsd 287631 2 - Live 0x0000000000000000
     auth_rpcgss 60032 1 nfsd, Live 0x0000000000000000
     nfs_acl 12883 1 nfsd, Live 0x0000000000000000
     nfs 248168 0 - Live 0x0000000000000000
     lockd 95174 2 nfsd,nfs, Live 0x0000000000000000
     sunrpc 301108 6 nfsd,auth_rpcgss,nfs_acl,nfs,lockd, Live 
0x0000000000000000
     rfcomm 75078 8 - Live 0x0000000000000000
     bnep 19884 2 - Live 0x0000000000000000
     binfmt_misc 17508 1 - Live 0x0000000000000000
     fscache 64282 2 cifs,nfs, Live 0x0000000000000000
     nls_iso8859_1 12713 1 - Live 0x0000000000000000
     rts5139 318308 0 - Live 0x0000000000000000 (C)
     hid_multitouch 17656 0 - Live 0x0000000000000000
     snd_hda_codec_realtek 72529 1 - Live 0x0000000000000000
     snd_hda_codec_hdmi 48182 1 - Live 0x0000000000000000
     snd_hda_codec_generic 70087 1 snd_hda_codec_realtek, Live 
0x0000000000000000
     joydev 17587 0 - Live 0x0000000000000000
     snd_hda_intel 30608 5 - Live 0x0000000000000000
     x86_pkg_temp_thermal 14312 0 - Live 0x0000000000000000
     intel_powerclamp 19099 0 - Live 0x0000000000000000
     snd_hda_controller 35518 1 snd_hda_intel, Live 0x0000000000000000
     coretemp 13638 0 - Live 0x0000000000000000
     snd_hda_codec 144671 5 
snd_hda_codec_realtek,snd_hda_codec_hdmi,snd_hda_codec_generic,snd_hda_intel,snd_hda_controller, 
Live 0x0000000000000000
     kvm_intel 148919 0 - Live 0x0000000000000000
     snd_hwdep 13613 1 snd_hda_codec, Live 0x0000000000000000
     kvm 463808 1 kvm_intel, Live 0x0000000000000000
     snd_pcm 113863 4 
snd_hda_codec_hdmi,snd_hda_intel,snd_hda_controller,snd_hda_codec, Live 
0x0000000000000000
     asus_nb_wmi 16990 0 - Live 0x0000000000000000
     asus_wmi 24697 1 asus_nb_wmi, Live 0x0000000000000000
     snd_seq_midi 13564 0 - Live 0x0000000000000000
     snd_seq_midi_event 14899 1 snd_seq_midi, Live 0x0000000000000000
     snd_rawmidi 30865 1 snd_seq_midi, Live 0x0000000000000000
     sparse_keymap 13890 1 asus_wmi, Live 0x0000000000000000
     snd_seq 63540 2 snd_seq_midi,snd_seq_midi_event, Live 
0x0000000000000000
     mxm_wmi 13021 0 - Live 0x0000000000000000
     snd_seq_device 14497 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 
0x0000000000000000
     arc4 12573 2 - Live 0x0000000000000000
     snd_timer 30118 2 snd_pcm,snd_seq, Live 0x0000000000000000
     ath9k 138774 0 - Live 0x0000000000000000
     i915 873369 5 - Live 0x0000000000000000
     ath9k_common 15984 1 ath9k, Live 0x0000000000000000
     uvcvideo 82299 0 - Live 0x0000000000000000
     snd 74195 21 
snd_hda_codec_realtek,snd_hda_codec_hdmi,snd_hda_codec_generic,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_rawmidi,snd_seq,snd_seq_device,snd_timer, 
Live 0x0000000000000000
     ath9k_hw 454417 2 ath9k,ath9k_common, Live 0x0000000000000000
     crct10dif_pclmul 14268 0 - Live 0x0000000000000000
     crc32_pclmul 13180 0 - Live 0x0000000000000000
     videobuf2_vmalloc 13216 1 uvcvideo, Live 0x0000000000000000
     videobuf2_memops 13362 1 videobuf2_vmalloc, Live 0x0000000000000000
     videobuf2_core 45435 1 uvcvideo, Live 0x0000000000000000
     videodev 149504 2 uvcvideo,videobuf2_core, Live 0x0000000000000000
     soundcore 12680 2 snd_hda_codec,snd, Live 0x0000000000000000
     ghash_clmulni_intel 13230 0 - Live 0x0000000000000000
     ath3k 13381 0 - Live 0x0000000000000000
     btusb 32555 0 - Live 0x0000000000000000
     aesni_intel 152648 5 - Live 0x0000000000000000
     bluetooth 447627 27 rfcomm,bnep,ath3k,btusb, Live 0x0000000000000000
     ath 29397 3 ath9k,ath9k_common,ath9k_hw, Live 0x0000000000000000
     aes_x86_64 17131 1 aesni_intel, Live 0x0000000000000000
     mac80211 663788 1 ath9k, Live 0x0000000000000000
     drm_kms_helper 59729 1 i915, Live 0x0000000000000000
     lrw 13323 1 aesni_intel, Live 0x0000000000000000
     gf128mul 14951 1 lrw, Live 0x0000000000000000
     glue_helper 14095 1 aesni_intel, Live 0x0000000000000000
     cfg80211 509833 4 ath9k,ath9k_common,ath,mac80211, Live 
0x0000000000000000
     psmouse 113231 0 - Live 0x0000000000000000
     drm 310655 5 i915,drm_kms_helper, Live 0x0000000000000000
     serio_raw 13483 0 - Live 0x0000000000000000
     ablk_helper 13597 1 aesni_intel, Live 0x0000000000000000
     parport_pc 32906 0 - Live 0x0000000000000000
     video 19932 2 asus_wmi,i915, Live 0x0000000000000000
     ppdev 17711 0 - Live 0x0000000000000000
     cryptd 20531 3 ghash_clmulni_intel,aesni_intel,ablk_helper, Live 
0x0000000000000000
     mei_me 18562 0 - Live 0x0000000000000000
     lp 17799 0 - Live 0x0000000000000000
     parport 42481 3 parport_pc,ppdev,lp, Live 0x0000000000000000
     mei 87522 1 mei_me, Live 0x0000000000000000
     lpc_ich 21176 0 - Live 0x0000000000000000
     i2c_algo_bit 13564 1 i915, Live 0x0000000000000000
     mac_hid 13275 0 - Live 0x0000000000000000
     wmi 19379 2 asus_wmi,mxm_wmi, Live 0x0000000000000000
     usbhid 53121 0 - Live 0x0000000000000000
     hid 106436 2 hid_multitouch,usbhid, Live 0x0000000000000000
     r8169 73316 0 - Live 0x0000000000000000
     ahci 30133 5 - Live 0x0000000000000000
     libahci 32191 1 ahci, Live 0x0000000000000000
     mii 13981 1 r8169, Live 0x0000000000000000

[7.4.] Loaded driver and hardware information (/proc/ioports, 
/proc/iomem)

     $ cat /proc/ioports
     0000-0cf7 : PCI Bus 0000:00
       0000-001f : dma1
       0020-0021 : pic1
       0040-0043 : timer0
       0050-0053 : timer1
       0060-0060 : keyboard
       0062-0062 : EC data
       0064-0064 : keyboard
       0066-0066 : EC cmd
       0070-0077 : rtc0
       0080-008f : dma page reg
       00a0-00a1 : pic2
       00c0-00df : dma2
       00f0-00ff : fpu
       0240-0259 : pnp 00:09
       04d0-04d1 : pnp 00:08
       0680-069f : pnp 00:05
     0cf8-0cff : PCI conf1
     0d00-ffff : PCI Bus 0000:00
       164e-164f : pnp 00:05
       1800-1803 : ACPI PM1a_EVT_BLK
       1804-1805 : ACPI PM1a_CNT_BLK
       1808-180b : ACPI PM_TMR
       1810-1815 : ACPI CPU throttle
       1820-182f : ACPI GPE0_BLK
       1830-1833 : iTCO_wdt
       1850-1850 : ACPI PM2_CNT_BLK
       1854-1857 : pnp 00:07
       1860-187f : iTCO_wdt
       1c00-1cfe : pnp 00:05
       1d00-1dfe : pnp 00:05
       1e00-1efe : pnp 00:05
       1f00-1ffe : pnp 00:05
       2000-2fff : PCI Bus 0000:03
       d000-dfff : PCI Bus 0000:05
         d000-d0ff : 0000:05:00.0
           d000-d0ff : r8169
       e000-efff : PCI Bus 0000:01
         e000-e07f : 0000:01:00.0
       f000-f03f : 0000:00:02.0
       f040-f05f : 0000:00:1f.3
       f060-f07f : 0000:00:1f.2
         f060-f07f : ahci
       f080-f083 : 0000:00:1f.2
         f080-f083 : ahci
       f090-f097 : 0000:00:1f.2
         f090-f097 : ahci
       f0a0-f0a3 : 0000:00:1f.2
         f0a0-f0a3 : ahci
       f0b0-f0b7 : 0000:00:1f.2
         f0b0-f0b7 : ahci
       ffff-ffff : pnp 00:05
         ffff-ffff : pnp 00:05
           ffff-ffff : pnp 00:05
     $ /cat /proc/iomem
     00000000-00000fff : reserved
     00001000-00057fff : System RAM
     00058000-00058fff : reserved
     00059000-0009dfff : System RAM
     0009e000-0009ffff : reserved
     000a0000-000bffff : PCI Bus 0000:00
     000c0000-000c3fff : PCI Bus 0000:00
     000c4000-000c7fff : PCI Bus 0000:00
     000c8000-000cbfff : PCI Bus 0000:00
     000cc000-000cffff : PCI Bus 0000:00
     000d0000-000d3fff : PCI Bus 0000:00
     000d4000-000d7fff : PCI Bus 0000:00
     000d8000-000dbfff : PCI Bus 0000:00
     000dc000-000dffff : PCI Bus 0000:00
     000f0000-000fffff : System ROM
     00100000-c57d9fff : System RAM
       02000000-02771618 : Kernel code
       02771619-02d1dbbf : Kernel data
       02e7a000-02fe2fff : Kernel bss
     c57da000-c57e0fff : ACPI Non-volatile Storage
     c57e1000-c6018fff : System RAM
     c6019000-c629efff : reserved
     c629f000-c98fdfff : System RAM
     c98fe000-c9af2fff : reserved
     c9af3000-c9e25fff : System RAM
     c9e26000-cab25fff : ACPI Non-volatile Storage
     cab26000-caf59fff : reserved
     caf5a000-caffefff : reserved
     cafff000-caffffff : System RAM
     cb000000-cbbfffff : RAM buffer
     cbc00000-cfdfffff : reserved
       cbe00000-cfdfffff : Graphics Stolen Memory
     cfe00000-feafffff : PCI Bus 0000:00
       cfe00000-cfffffff : PCI Bus 0000:03
       d0000000-dfffffff : 0000:00:02.0
       e0000000-f1ffffff : PCI Bus 0000:01
         e0000000-efffffff : 0000:01:00.0
         f0000000-f1ffffff : 0000:01:00.0
       f2100000-f21fffff : PCI Bus 0000:05
         f2100000-f2103fff : 0000:05:00.0
           f2100000-f2103fff : r8169
       f2200000-f23fffff : PCI Bus 0000:03
       f6000000-f70fffff : PCI Bus 0000:01
         f6000000-f6ffffff : 0000:01:00.0
         f7000000-f707ffff : 0000:01:00.0
       f7400000-f77fffff : 0000:00:02.0
       f7800000-f78fffff : PCI Bus 0000:05
         f7800000-f7800fff : 0000:05:00.0
           f7800000-f7800fff : r8169
       f7900000-f79fffff : PCI Bus 0000:04
         f7900000-f797ffff : 0000:04:00.0
           f7900000-f797ffff : ath9k
         f7980000-f798ffff : 0000:04:00.0
       f7a00000-f7a0ffff : 0000:00:14.0
         f7a00000-f7a0ffff : xhci_hcd
       f7a10000-f7a13fff : 0000:00:1b.0
         f7a10000-f7a13fff : ICH HD audio
       f7a14000-f7a17fff : 0000:00:03.0
         f7a14000-f7a17fff : ICH HD audio
       f7a19000-f7a190ff : 0000:00:1f.3
       f7a1a000-f7a1a7ff : 0000:00:1f.2
         f7a1a000-f7a1a7ff : ahci
       f7a1b000-f7a1b3ff : 0000:00:1d.0
         f7a1b000-f7a1b3ff : ehci_hcd
       f7a1c000-f7a1c3ff : 0000:00:1a.0
         f7a1c000-f7a1c3ff : ehci_hcd
       f7a1e000-f7a1e00f : 0000:00:16.0
         f7a1e000-f7a1e00f : mei_me
       f7fef000-f7feffff : pnp 00:0c
       f7ff0000-f7ff0fff : pnp 00:0c
       f8000000-fbffffff : PCI MMCONFIG 0000 [bus 00-3f]
         f8000000-fbffffff : reserved
           f8000000-fbffffff : pnp 00:0c
     fec00000-fec00fff : reserved
       fec00000-fec003ff : IOAPIC 0
     fed00000-fed03fff : reserved
       fed00000-fed003ff : HPET 0
     fed10000-fed17fff : pnp 00:0c
     fed18000-fed18fff : pnp 00:0c
     fed19000-fed19fff : pnp 00:0c
     fed1c000-fed1ffff : reserved
       fed1c000-fed1ffff : pnp 00:0c
         fed1f410-fed1f414 : iTCO_wdt
     fed20000-fed3ffff : pnp 00:0c
     fed40000-fed44fff : pnp 00:00
     fed45000-fed8ffff : pnp 00:0c
     fed90000-fed90fff : dmar0
     fed91000-fed91fff : dmar1
     fee00000-fee00fff : Local APIC
       fee00000-fee00fff : reserved
     ff000000-ffffffff : reserved
       ff000000-ffffffff : pnp 00:0c
     100000000-22f1fffff : System RAM
     22f200000-22fffffff : RAM buffer

[7.5.] PCI information ('lspci -vvv' as root)

     $ sudo lspci -vvv
     00:00.0 Host bridge: Intel Corporation Xeon E3-1200 v3/4th Gen Core 
Processor DRAM Controller (rev 06)
	    Subsystem: ASUSTeK Computer Inc. Device 11cd
	    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR- INTx-
	    Latency: 0
	    Capabilities: [e0] Vendor Specific Information: Len=0c <?>

     00:01.0 PCI bridge: Intel Corporation Xeon E3-1200 v3/4th Gen Core 
Processor PCI Express x16 Controller (rev 06) (prog-if 00 [Normal 
decode])
	    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
	    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	    Latency: 0, Cache Line Size: 64 bytes
	    Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	    I/O behind bridge: 0000e000-0000efff
	    Memory behind bridge: f6000000-f70fffff
	    Prefetchable memory behind bridge: 
00000000e0000000-00000000f1ffffff
	    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ <SERR- <PERR-
	    BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		    PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	    Capabilities: [88] Subsystem: ASUSTeK Computer Inc. Device 11cd
	    Capabilities: [80] Power Management version 3
		    Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		    Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	    Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
		    Address: fee002b8  Data: 0000
	    Capabilities: [a0] Express (v2) Root Port (Slot+), MSI 00
		    DevCap:	MaxPayload 256 bytes, PhantFunc 0
			    ExtTag- RBE+
		    DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			    RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			    MaxPayload 256 bytes, MaxReadReq 128 bytes
		    DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- 
TransPend-
		    LnkCap:	Port #2, Speed 8GT/s, Width x16, ASPM L0s L1, Exit Latency 
L0s <256ns, L1 <8us
			    ClockPM- Surprise- LLActRep- BwNot+
		    LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
			    ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		    LnkSta:	Speed 8GT/s, Width x16, TrErr- Train- SlotClk+ DLActive- 
BWMgmt+ ABWMgmt+
		    SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			    Slot #1, PowerLimit 75.000W; Interlock- NoCompl+
		    SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- 
LinkChg-
			    Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		    SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ 
Interlock-
			    Changed: MRL- PresDet- LinkState-
		    RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ 
CRSVisible-
		    RootCap: CRSVisible-
		    RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		    DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR+, 
OBFF Via WAKE# ARIFwd-
		    DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF 
Via WAKE# ARIFwd-
		    LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
			     Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
			     Compliance De-emphasis: -6dB
		    LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+, 
EqualizationPhase1+
			     EqualizationPhase2+, EqualizationPhase3+, 
LinkEqualizationRequest-
	    Capabilities: [100 v1] Virtual Channel
		    Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		    Arb:	Fixed- WRR32- WRR64- WRR128-
		    Ctrl:	ArbSelect=Fixed
		    Status:	InProgress-
		    VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			    Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			    Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			    Status:	NegoPending- InProgress-
	    Capabilities: [140 v1] Root Complex Link
		    Desc:	PortNumber=02 ComponentID=01 EltType=Config
		    Link0:	Desc:	TargetPort=00 TargetComponent=01 AssocRCRB- 
LinkType=MemMapped LinkValid+
			    Addr:	00000000fed19000
	    Capabilities: [d94 v1] #19
	    Kernel driver in use: pcieport

     00:02.0 VGA compatible controller: Intel Corporation 4th Gen Core 
Processor Integrated Graphics Controller (rev 06) (prog-if 00 [VGA 
controller])
	    Subsystem: ASUSTeK Computer Inc. Device 11cd
	    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
	    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	    Latency: 0
	    Interrupt: pin A routed to IRQ 51
	    Region 0: Memory at f7400000 (64-bit, non-prefetchable) [size=4M]
	    Region 2: Memory at d0000000 (64-bit, prefetchable) [size=256M]
	    Region 4: I/O ports at f000 [size=64]
	    Expansion ROM at <unassigned> [disabled]
	    Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
		    Address: fee00018  Data: 0000
	    Capabilities: [d0] Power Management version 2
		    Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		    Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	    Capabilities: [a4] PCI Advanced Features
		    AFCap: TP+ FLR+
		    AFCtrl: FLR-
		    AFStatus: TP-
	    Kernel driver in use: i915

     00:03.0 Audio device: Intel Corporation Xeon E3-1200 v3/4th Gen Core 
Processor HD Audio Controller (rev 06)
	    Subsystem: Intel Corporation Device 2010
	    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
	    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	    Latency: 0, Cache Line Size: 64 bytes
	    Interrupt: pin A routed to IRQ 53
	    Region 0: Memory at f7a14000 (64-bit, non-prefetchable) [size=16K]
	    Capabilities: [50] Power Management version 2
		    Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		    Status: D3 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	    Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit-
		    Address: fee00478  Data: 0000
	    Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, 
MSI 00
		    DevCap:	MaxPayload 128 bytes, PhantFunc 0
			    ExtTag- RBE-
		    DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			    RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			    MaxPayload 128 bytes, MaxReadReq 128 bytes
		    DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- 
TransPend-
	    Kernel driver in use: snd_hda_intel

     00:14.0 USB controller: Intel Corporation 8 Series/C220 Series 
Chipset Family USB xHCI (rev 04) (prog-if 30 [XHCI])
	    Subsystem: ASUSTeK Computer Inc. Device 11cd
	    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
	    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	    Latency: 0
	    Interrupt: pin A routed to IRQ 47
	    Region 0: Memory at f7a00000 (64-bit, non-prefetchable) [size=64K]
	    Capabilities: [70] Power Management version 2
		    Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0-,D1-,D2-,D3hot+,D3cold+)
		    Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	    Capabilities: [80] MSI: Enable+ Count=1/8 Maskable- 64bit+
		    Address: 00000000fee003b8  Data: 0000
	    Kernel driver in use: xhci_hcd

     00:16.0 Communication controller: Intel Corporation 8 Series/C220 
Series Chipset Family MEI Controller #1 (rev 04)
	    Subsystem: ASUSTeK Computer Inc. Device 11cd
	    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
	    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	    Latency: 0
	    Interrupt: pin A routed to IRQ 50
	    Region 0: Memory at f7a1e000 (64-bit, non-prefetchable) [size=16]
	    Capabilities: [50] Power Management version 3
		    Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		    Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	    Capabilities: [8c] MSI: Enable+ Count=1/1 Maskable- 64bit+
		    Address: 00000000fee00418  Data: 0000
	    Kernel driver in use: mei_me

     00:1a.0 USB controller: Intel Corporation 8 Series/C220 Series 
Chipset Family USB EHCI #2 (rev 04) (prog-if 20 [EHCI])
	    Subsystem: ASUSTeK Computer Inc. Device 11cd
	    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	    Latency: 0
	    Interrupt: pin A routed to IRQ 16
	    Region 0: Memory at f7a1c000 (32-bit, non-prefetchable) [size=1K]
	    Capabilities: [50] Power Management version 2
		    Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		    Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	    Capabilities: [58] Debug port: BAR=1 offset=00a0
	    Capabilities: [98] PCI Advanced Features
		    AFCap: TP+ FLR+
		    AFCtrl: FLR-
		    AFStatus: TP-
	    Kernel driver in use: ehci-pci

     00:1b.0 Audio device: Intel Corporation 8 Series/C220 Series Chipset 
High Definition Audio Controller (rev 04)
	    Subsystem: ASUSTeK Computer Inc. Device 11cd
	    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
	    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	    Latency: 0, Cache Line Size: 64 bytes
	    Interrupt: pin A routed to IRQ 52
	    Region 0: Memory at f7a10000 (64-bit, non-prefetchable) [size=16K]
	    Capabilities: [50] Power Management version 2
		    Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		    Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	    Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
		    Address: 00000000fee00458  Data: 0000
	    Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, 
MSI 00
		    DevCap:	MaxPayload 128 bytes, PhantFunc 0
			    ExtTag- RBE-
		    DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			    RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			    MaxPayload 128 bytes, MaxReadReq 128 bytes
		    DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ 
TransPend-
	    Capabilities: [100 v1] Virtual Channel
		    Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		    Arb:	Fixed- WRR32- WRR64- WRR128-
		    Ctrl:	ArbSelect=Fixed
		    Status:	InProgress-
		    VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			    Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			    Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=01
			    Status:	NegoPending- InProgress-
		    VC1:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			    Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			    Ctrl:	Enable+ ID=2 ArbSelect=Fixed TC/VC=04
			    Status:	NegoPending- InProgress-
	    Kernel driver in use: snd_hda_intel

     00:1c.0 PCI bridge: Intel Corporation 8 Series/C220 Series Chipset 
Family PCI Express Root Port #1 (rev d4) (prog-if 00 [Normal decode])
	    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
	    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	    Latency: 0, Cache Line Size: 64 bytes
	    Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	    I/O behind bridge: 0000f000-00000fff
	    Memory behind bridge: fff00000-000fffff
	    Prefetchable memory behind bridge: 
00000000fff00000-00000000000fffff
	    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ <SERR- <PERR-
	    BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		    PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	    Capabilities: [40] Express (v2) Root Port (Slot-), MSI 00
		    DevCap:	MaxPayload 128 bytes, PhantFunc 0
			    ExtTag- RBE+
		    DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			    RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			    MaxPayload 128 bytes, MaxReadReq 128 bytes
		    DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ 
TransPend-
		    LnkCap:	Port #1, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency 
L0s <1us, L1 <4us
			    ClockPM- Surprise- LLActRep+ BwNot+
		    LnkCtl:	ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk-
			    ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		    LnkSta:	Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ DLActive- 
BWMgmt- ABWMgmt-
		    RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ 
CRSVisible-
		    RootCap: CRSVisible-
		    RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		    DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+, OBFF 
Via WAKE# ARIFwd-
		    DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF 
Disabled ARIFwd-
		    LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
			     Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
			     Compliance De-emphasis: -6dB
		    LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, 
EqualizationPhase1-
			     EqualizationPhase2-, EqualizationPhase3-, 
LinkEqualizationRequest-
	    Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
		    Address: fee002d8  Data: 0000
	    Capabilities: [90] Subsystem: ASUSTeK Computer Inc. Device 11cd
	    Capabilities: [a0] Power Management version 3
		    Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		    Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	    Kernel driver in use: pcieport

     00:1c.1 PCI bridge: Intel Corporation 8 Series/C220 Series Chipset 
Family PCI Express Root Port #2 (rev d4) (prog-if 00 [Normal decode])
	    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
	    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	    Latency: 0, Cache Line Size: 64 bytes
	    Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
	    I/O behind bridge: 00002000-00002fff
	    Memory behind bridge: cfe00000-cfffffff
	    Prefetchable memory behind bridge: 
00000000f2200000-00000000f23fffff
	    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ <SERR- <PERR-
	    BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		    PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	    Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
		    DevCap:	MaxPayload 128 bytes, PhantFunc 0
			    ExtTag- RBE+
		    DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			    RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			    MaxPayload 128 bytes, MaxReadReq 128 bytes
		    DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ 
TransPend-
		    LnkCap:	Port #2, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency 
L0s <1us, L1 <16us
			    ClockPM- Surprise- LLActRep+ BwNot+
		    LnkCtl:	ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk-
			    ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		    LnkSta:	Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ DLActive- 
BWMgmt- ABWMgmt-
		    SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
			    Slot #1, PowerLimit 10.000W; Interlock- NoCompl+
		    SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq+ 
LinkChg+
			    Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		    SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- 
Interlock-
			    Changed: MRL- PresDet- LinkState-
		    RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ 
CRSVisible-
		    RootCap: CRSVisible-
		    RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		    DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+, OBFF 
Not Supported ARIFwd-
		    DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF 
Disabled ARIFwd-
		    LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
			     Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
			     Compliance De-emphasis: -6dB
		    LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, 
EqualizationPhase1-
			     EqualizationPhase2-, EqualizationPhase3-, 
LinkEqualizationRequest-
	    Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
		    Address: fee00318  Data: 0000
	    Capabilities: [90] Subsystem: ASUSTeK Computer Inc. Device 11cd
	    Capabilities: [a0] Power Management version 3
		    Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		    Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	    Kernel driver in use: pcieport

     00:1c.2 PCI bridge: Intel Corporation 8 Series/C220 Series Chipset 
Family PCI Express Root Port #3 (rev d4) (prog-if 00 [Normal decode])
	    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
	    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	    Latency: 0, Cache Line Size: 64 bytes
	    Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
	    I/O behind bridge: 0000f000-00000fff
	    Memory behind bridge: f7900000-f79fffff
	    Prefetchable memory behind bridge: 
00000000fff00000-00000000000fffff
	    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ <SERR- <PERR-
	    BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		    PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	    Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
		    DevCap:	MaxPayload 128 bytes, PhantFunc 0
			    ExtTag- RBE+
		    DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			    RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			    MaxPayload 128 bytes, MaxReadReq 128 bytes
		    DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ 
TransPend-
		    LnkCap:	Port #3, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency 
L0s <512ns, L1 <16us
			    ClockPM- Surprise- LLActRep+ BwNot+
		    LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
			    ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		    LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ 
BWMgmt+ ABWMgmt-
		    SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			    Slot #2, PowerLimit 10.000W; Interlock- NoCompl+
		    SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- 
LinkChg-
			    Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		    SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ 
Interlock-
			    Changed: MRL- PresDet- LinkState-
		    RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ 
CRSVisible-
		    RootCap: CRSVisible-
		    RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		    DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+, OBFF 
Not Supported ARIFwd-
		    DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF 
Disabled ARIFwd-
		    LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
			     Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
			     Compliance De-emphasis: -6dB
		    LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, 
EqualizationPhase1-
			     EqualizationPhase2-, EqualizationPhase3-, 
LinkEqualizationRequest-
	    Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
		    Address: fee00358  Data: 0000
	    Capabilities: [90] Subsystem: ASUSTeK Computer Inc. Device 11cd
	    Capabilities: [a0] Power Management version 3
		    Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		    Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	    Kernel driver in use: pcieport

     00:1c.3 PCI bridge: Intel Corporation 8 Series/C220 Series Chipset 
Family PCI Express Root Port #4 (rev d4) (prog-if 00 [Normal decode])
	    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
	    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	    Latency: 0, Cache Line Size: 64 bytes
	    Bus: primary=00, secondary=05, subordinate=05, sec-latency=0
	    I/O behind bridge: 0000d000-0000dfff
	    Memory behind bridge: f7800000-f78fffff
	    Prefetchable memory behind bridge: 
00000000f2100000-00000000f21fffff
	    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ <SERR- <PERR-
	    BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		    PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	    Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
		    DevCap:	MaxPayload 128 bytes, PhantFunc 0
			    ExtTag- RBE+
		    DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			    RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			    MaxPayload 128 bytes, MaxReadReq 128 bytes
		    DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ 
TransPend-
		    LnkCap:	Port #4, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency 
L0s <512ns, L1 <16us
			    ClockPM- Surprise- LLActRep+ BwNot+
		    LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
			    ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		    LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ 
BWMgmt+ ABWMgmt-
		    SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			    Slot #3, PowerLimit 10.000W; Interlock- NoCompl+
		    SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- 
LinkChg-
			    Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		    SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ 
Interlock-
			    Changed: MRL- PresDet- LinkState-
		    RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ 
CRSVisible-
		    RootCap: CRSVisible-
		    RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		    DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+, OBFF 
Not Supported ARIFwd-
		    DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF 
Disabled ARIFwd-
		    LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
			     Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
			     Compliance De-emphasis: -6dB
		    LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, 
EqualizationPhase1-
			     EqualizationPhase2-, EqualizationPhase3-, 
LinkEqualizationRequest-
	    Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
		    Address: fee00398  Data: 0000
	    Capabilities: [90] Subsystem: ASUSTeK Computer Inc. Device 11cd
	    Capabilities: [a0] Power Management version 3
		    Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		    Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	    Kernel driver in use: pcieport

     00:1d.0 USB controller: Intel Corporation 8 Series/C220 Series 
Chipset Family USB EHCI #1 (rev 04) (prog-if 20 [EHCI])
	    Subsystem: ASUSTeK Computer Inc. Device 11cd
	    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	    Latency: 0
	    Interrupt: pin A routed to IRQ 23
	    Region 0: Memory at f7a1b000 (32-bit, non-prefetchable) [size=1K]
	    Capabilities: [50] Power Management version 2
		    Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		    Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	    Capabilities: [58] Debug port: BAR=1 offset=00a0
	    Capabilities: [98] PCI Advanced Features
		    AFCap: TP+ FLR+
		    AFCtrl: FLR-
		    AFStatus: TP-
	    Kernel driver in use: ehci-pci

     00:1f.0 ISA bridge: Intel Corporation HM86 Express LPC Controller 
(rev 04)
	    Subsystem: ASUSTeK Computer Inc. Device 11cd
	    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	    Latency: 0
	    Capabilities: [e0] Vendor Specific Information: Len=0c <?>
	    Kernel driver in use: lpc_ich

     00:1f.2 SATA controller: Intel Corporation 8 Series/C220 Series 
Chipset Family 6-port SATA Controller 1 [AHCI mode] (rev 04) (prog-if 01 
[AHCI 1.0])
	    Subsystem: ASUSTeK Computer Inc. Device 11cd
	    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
	    Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	    Latency: 0
	    Interrupt: pin B routed to IRQ 48
	    Region 0: I/O ports at f0b0 [size=8]
	    Region 1: I/O ports at f0a0 [size=4]
	    Region 2: I/O ports at f090 [size=8]
	    Region 3: I/O ports at f080 [size=4]
	    Region 4: I/O ports at f060 [size=32]
	    Region 5: Memory at f7a1a000 (32-bit, non-prefetchable) [size=2K]
	    Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
		    Address: fee003d8  Data: 0000
	    Capabilities: [70] Power Management version 3
		    Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot+,D3cold-)
		    Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	    Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=00000004
	    Kernel driver in use: ahci

     00:1f.3 SMBus: Intel Corporation 8 Series/C220 Series Chipset Family 
SMBus Controller (rev 04)
	    Subsystem: ASUSTeK Computer Inc. Device 11cd
	    Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	    Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	    Interrupt: pin C routed to IRQ 255
	    Region 0: Memory at f7a19000 (64-bit, non-prefetchable) [size=256]
	    Region 4: I/O ports at f040 [size=32]

     01:00.0 3D controller: NVIDIA Corporation GK107M [GeForce GT 750M] 
(rev a1)
	    Subsystem: ASUSTeK Computer Inc. Device 11cd
	    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	    Latency: 0, Cache Line Size: 64 bytes
	    Interrupt: pin A routed to IRQ 255
	    Region 0: Memory at f6000000 (32-bit, non-prefetchable) [size=16M]
	    Region 1: Memory at e0000000 (64-bit, prefetchable) [size=256M]
	    Region 3: Memory at f0000000 (64-bit, prefetchable) [size=32M]
	    Region 5: I/O ports at e000 [size=128]
	    Expansion ROM at f7000000 [disabled] [size=512K]
	    Capabilities: [60] Power Management version 3
		    Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		    Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	    Capabilities: [68] MSI: Enable- Count=1/1 Maskable- 64bit+
		    Address: 0000000000000000  Data: 0000
	    Capabilities: [78] Express (v2) Endpoint, MSI 00
		    DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s unlimited, 
L1 <64us
			    ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		    DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			    RlxdOrd- ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			    MaxPayload 256 bytes, MaxReadReq 512 bytes
		    DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- 
TransPend-
		    LnkCap:	Port #0, Speed 8GT/s, Width x16, ASPM L0s L1, Exit Latency 
L0s <512ns, L1 <4us
			    ClockPM+ Surprise- LLActRep- BwNot-
		    LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
			    ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		    LnkSta:	Speed 8GT/s, Width x16, TrErr- Train- SlotClk+ DLActive- 
BWMgmt- ABWMgmt-
		    DevCap2: Completion Timeout: Range AB, TimeoutDis+, LTR-, OBFF Not 
Supported
		    DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF 
Disabled
		    LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
			     Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
			     Compliance De-emphasis: -6dB
		    LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete+, 
EqualizationPhase1+
			     EqualizationPhase2-, EqualizationPhase3-, 
LinkEqualizationRequest+
	    Capabilities: [b4] Vendor Specific Information: Len=14 <?>
	    Capabilities: [100 v1] Virtual Channel
		    Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		    Arb:	Fixed- WRR32- WRR64- WRR128-
		    Ctrl:	ArbSelect=Fixed
		    Status:	InProgress-
		    VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			    Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			    Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			    Status:	NegoPending- InProgress-
	    Capabilities: [128 v1] Power Budgeting <?>
	    Capabilities: [600 v1] Vendor Specific Information: ID=0001 Rev=1 
Len=024 <?>
	    Capabilities: [900 v1] #19

     04:00.0 Network controller: Qualcomm Atheros AR9485 Wireless Network 
Adapter (rev 01)
	    Subsystem: AzureWave Device 2126
	    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	    Latency: 0, Cache Line Size: 64 bytes
	    Interrupt: pin A routed to IRQ 18
	    Region 0: Memory at f7900000 (64-bit, non-prefetchable) [size=512K]
	    Expansion ROM at f7980000 [disabled] [size=64K]
	    Capabilities: [40] Power Management version 2
		    Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
		    Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	    Capabilities: [50] MSI: Enable- Count=1/4 Maskable+ 64bit+
		    Address: 0000000000000000  Data: 0000
		    Masking: 00000000  Pending: 00000000
	    Capabilities: [70] Express (v2) Endpoint, MSI 00
		    DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, 
L1 <64us
			    ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		    DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			    RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			    MaxPayload 128 bytes, MaxReadReq 512 bytes
		    DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ 
TransPend-
		    LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit 
Latency L0s <4us, L1 <64us
			    ClockPM- Surprise- LLActRep- BwNot-
		    LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
			    ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		    LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- 
BWMgmt- ABWMgmt-
		    DevCap2: Completion Timeout: Not Supported, TimeoutDis+, LTR-, 
OBFF Not Supported
		    DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF 
Disabled
		    LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
			     Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
			     Compliance De-emphasis: -6dB
		    LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, 
EqualizationPhase1-
			     EqualizationPhase2-, EqualizationPhase3-, 
LinkEqualizationRequest-
	    Capabilities: [100 v1] Advanced Error Reporting
		    UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- 
MalfTLP- ECRC- UnsupReq- ACSViol-
		    UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- 
MalfTLP- ECRC- UnsupReq- ACSViol-
		    UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ 
MalfTLP+ ECRC- UnsupReq- ACSViol-
		    CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		    CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		    AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
	    Capabilities: [140 v1] Virtual Channel
		    Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		    Arb:	Fixed- WRR32- WRR64- WRR128-
		    Ctrl:	ArbSelect=Fixed
		    Status:	InProgress-
		    VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			    Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			    Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=01
			    Status:	NegoPending- InProgress-
	    Capabilities: [160 v1] Device Serial Number 00-00-00-00-00-00-00-00
	    Kernel driver in use: ath9k

     05:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 0c)
	    Subsystem: ASUSTeK Computer Inc. Device 11cd
	    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
	    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	    Latency: 0, Cache Line Size: 64 bytes
	    Interrupt: pin A routed to IRQ 49
	    Region 0: I/O ports at d000 [size=256]
	    Region 2: Memory at f7800000 (64-bit, non-prefetchable) [size=4K]
	    Region 4: Memory at f2100000 (64-bit, prefetchable) [size=16K]
	    Capabilities: [40] Power Management version 3
		    Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
		    Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	    Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
		    Address: 00000000fee003f8  Data: 0000
	    Capabilities: [70] Express (v2) Endpoint, MSI 01
		    DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 
<64us
			    ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		    DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			    RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			    MaxPayload 128 bytes, MaxReadReq 4096 bytes
		    DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ 
TransPend-
		    LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit 
Latency L0s unlimited, L1 <64us
			    ClockPM+ Surprise- LLActRep- BwNot-
		    LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
			    ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		    LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- 
BWMgmt- ABWMgmt-
		    DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR+, OBFF 
Via message/WAKE#
		    DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF 
Disabled
		    LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
			     Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
			     Compliance De-emphasis: -6dB
		    LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, 
EqualizationPhase1-
			     EqualizationPhase2-, EqualizationPhase3-, 
LinkEqualizationRequest-
	    Capabilities: [b0] MSI-X: Enable- Count=4 Masked-
		    Vector table: BAR=4 offset=00000000
		    PBA: BAR=4 offset=00000800
	    Capabilities: [d0] Vital Product Data
		    Unknown small resource type 00, will not decode more.
	    Capabilities: [100 v1] Advanced Error Reporting
		    UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- 
MalfTLP- ECRC- UnsupReq- ACSViol-
		    UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- 
MalfTLP- ECRC- UnsupReq- ACSViol-
		    UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ 
MalfTLP+ ECRC- UnsupReq- ACSViol-
		    CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		    CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		    AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	    Capabilities: [140 v1] Virtual Channel
		    Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		    Arb:	Fixed- WRR32- WRR64- WRR128-
		    Ctrl:	ArbSelect=Fixed
		    Status:	InProgress-
		    VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			    Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			    Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=01
			    Status:	NegoPending- InProgress-
	    Capabilities: [160 v1] Device Serial Number 08-24-28-27-68-4c-e0-00
	    Capabilities: [170 v1] Latency Tolerance Reporting
		    Max snoop latency: 71680ns
		    Max no snoop latency: 71680ns
	    Kernel driver in use: r8169

[7.6.] SCSI information (from /proc/scsi/scsi)

     $ cat /proc/scsi/scsi
     Attached devices:
     Host: scsi2 Channel: 00 Id: 00 Lun: 00
       Vendor: MATSHITA Model: BD-CMB UJ162     Rev: 1.01
       Type:   CD-ROM                           ANSI  SCSI revision: 05
     Host: scsi4 Channel: 00 Id: 00 Lun: 00
       Vendor: ATA      Model: HGST HTS541010A9 Rev: JA0O
       Type:   Direct-Access                    ANSI  SCSI revision: 05
     Host: scsi5 Channel: 00 Id: 00 Lun: 00
       Vendor: Generic- Model: xD/SD/M.S.       Rev: 1.00
       Type:   Direct-Access                    ANSI  SCSI revision: 02

[7.7.] Other information that might be relevant to the problem
        (please look in /proc and include all information that you
        think to be relevant):

     $ ls /proc
     1/
     10/
     1001/
     1007/
     1008/
     101/
     1019/
     1020/
     1023/
     1029/
     103/
     104/
     1045/
     105/
     106/
     1068/
     11/
     1114/
     1118/
     1126/
     1127/
     1130/
     1166/
     1181/
     12/
     1204/
     1206/
     1209/
     1214/
     1227/
     1243/
     125/
     126/
     1298/
     13/
     1308/
     1328/
     1378/
     1383/
     14/
     15/
     1526/
     1533/
     1537/
     1577/
     16/
     1631/
     1664/
     17/
     18/
     185/
     186/
     187/
     188/
     189/
     19/
     190/
     191/
     192/
     193/
     194/
     1947/
     195/
     1951/
     1961/
     2/
     20/
     202/
     2037/
     2040/
     2048/
     2051/
     2071/
     2073/
     2075/
     2077/
     2091/
     2095/
     2098/
     2099/
     21/
     210/
     2104/
     2105/
     2109/
     211/
     2114/
     2116/
     2117/
     2119/
     2132/
     2156/
     2160/
     2171/
     2178/
     2182/
     22/
     2209/
     2231/
     2236/
     2237/
     2239/
     2244/
     2247/
     2250/
     2260/
     2269/
     2282/
     23/
     2301/
     2344/
     2347/
     2349/
     2351/
     2357/
     2358/
     2375/
     2380/
     2385/
     24/
     2403/
     2407/
     2413/
     2415/
     2422/
     2428/
     2430/
     2444/
     2447/
     25/
     2519/
     2541/
     2549/
     2556/
     2583/
     2593/
     2594/
     26/
     2639/
     2645/
     27/
     2717/
     2746/
     2754/
     28/
     2801/
     2804/
     2811/
     2838/
     2855/
     2870/
     2871/
     29/
     2908/
     2934/
     2944/
     3/
     3009/
     3034/
     31/
     32/
     33/
     338/
     3389/
     3395/
     3396/
     34/
     343/
     35/
     36/
     37/
     38/
     39/
     399/
     404/
     41/
     411/
     416/
     42/
     43/
     437/
     438/
     44/
     445/
     45/
     46/
     47/
     48/
     49/
     5/
     51/
     52/
     53/
     54/
     55/
     56/
     57/
     58/
     59/
     6/
     60/
     607/
     609/
     61/
     612/
     613/
     619/
     62/
     63/
     64/
     65/
     654/
     659/
     66/
     67/
     68/
     69/
     690/
     691/
     692/
     693/
     7/
     70/
     71/
     72/
     73/
     736/
     737/
     74/
     740/
     741/
     75/
     76/
     77/
     770/
     79/
     8/
     81/
     82/
     83/
     859/
     87/
     885/
     898/
     899/
     9/
     90/
     91/
     913/
     92/
     93/
     944/
     953/
     954/
     961/
     977/
     992/
     998/
     acpi/
     asound/
     bus/
     driver/
     fs/
     ipmi/
     irq/
     scsi/
     sys/
     sysvipc/
     tty/
     buddyinfo
     cgroups
     cmdline
     consoles
     cpuinfo
     crypto
     devices
     diskstats
     dma
     execdomains
     fb
     filesystems
     interrupts
     iomem
     ioports
     kallsyms
     kcore
     key-users
     kmsg
     kpagecount
     kpageflags
     latency_stats
     loadavg
     locks
     mdstat
     meminfo
     misc
     modules
     mounts@
     mtrr
     net@
     pagetypeinfo
     partitions
     sched_debug
     schedstat
     self@
     slabinfo
     softirqs
     stat
     swaps
     sysrq-trigger
     timer_list
     timer_stats
     uptime
     version
     vmallocinfo
     vmstat
     zoneinfo

[X.] Other notes, patches, fixes, workarounds:

     https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1260825


