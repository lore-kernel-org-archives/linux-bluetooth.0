Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Leonardo Marques Rodrigues <leo.mrodrigues@live.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Bluetooth Qualcomm Atheros QCA9565 / AR9565 [168c:0036] not
 recognized
Date: Thu, 14 Jan 2016 02:21:37 +0000
Message-ID: <56970229.4020703@live.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


 I have installed Ubuntu 14.04 on my Acer Aspire E5-573G, and the bluetooth was not recognized, but wifi is working perfectly. I make tests from  kernel 3.19 - 4.4-rc8 and this occurred on all tests.

I did a bug report on  https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1532267 and I was instructed to report here.

Thank you for your attention.

Below I send some results:

--------------------------------------------------------------------------------------------------------
cat /proc/version:

Linux version 4.4.0-040400-generic (kernel@gomeisa) (gcc version 5.2.1 20151010 (Ubuntu 5.2.1-22ubuntu2) ) #201601101930 SMP Mon Jan 11 00:32:41 UTC 2016

--------------------------------------------------------------------------------------------------------

sh ver_linux:

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux thor 4.4.0-040400-generic #201601101930 SMP Mon Jan 11 00:32:41 UTC 2016 x86_64 x86_64 x86_64 GNU/Linux
 
GNU C            4.8
GNU Make        3.81
Binutils        2.24
Util-linux        2.20.1
Mount            2.20.1
Module-init-tools    15
E2fsprogs        1.42.9
Pcmciautils        018
PPP            2.4.5
Linux C Library        2.19
Dynamic linker (ldd)    2.19
Linux C++ Library    6.0.19
Procps            3.3.9
Net-tools        1.60
Kbd            1.15.5
Console-tools        1.15.5
Sh-utils        8.21
Udev            204
Wireless-tools        30
Modules Loaded        8250_dw ablk_helper acer_wmi acpi_pad aesni_intel aes_x86_64 ahci arc4 ath ath9k ath9k_common ath9k_hw bluetooth bnep btbcm btintel btrtl btusb cfg80211 coretemp crc32_pclmul crct10dif_pclmul cryptd dell_smo8800 drm drm_kms_helper dw_dmac  dw_dmac_core fb_sys_fops fjes gf128mul glue_helper hid hid_generic i2c_algo_bit i2c_designware_core i2c_designware_platform i2c_hid i915 input_leds intel_powerclamp intel_rapl irqbypass joydev kvm kvm_intel libahci lp lpc_ich lrw mac80211 mac_hid media mei  mei_me memstick mii mxm_wmi nls_iso8859_1 nouveau parport parport_pc ppdev psmouse r8169 rfcomm rtsx_usb rtsx_usb_ms rtsx_usb_sdmmc sdhci sdhci_acpi serio_raw shpchp snd snd_hda_codec snd_hda_codec_generic snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_core  snd_hda_intel snd_hwdep snd_pcm snd_rawmidi snd_seq snd_seq_device snd_seq_midi snd_seq_midi_event snd_timer soundcore sparse_keymap spi_pxa2xx_platform syscopyarea sysfillrect sysimgblt tpm_crb ttm uas usbhid usb_sto
 rage uvcvideo v4l2_common video videobuf2_core  videobuf2_memops videobuf2_v4l2 videobuf2_vmalloc videodev wmi x86_pkg_temp_thermal

--------------------------------------------------------------------------------------------------------

cat /proc/modules:

bnep 20480 2 - Live 0x0000000000000000
rfcomm 69632 0 - Live 0x0000000000000000
nls_iso8859_1 16384 2 - Live 0x0000000000000000
snd_hda_codec_hdmi 53248 1 - Live 0x0000000000000000
intel_rapl 20480 0 - Live 0x0000000000000000
x86_pkg_temp_thermal 16384 0 - Live 0x0000000000000000
intel_powerclamp 16384 0 - Live 0x0000000000000000
snd_hda_codec_realtek 81920 1 - Live 0x0000000000000000
arc4 16384 2 - Live 0x0000000000000000
coretemp 16384 0 - Live 0x0000000000000000
snd_hda_codec_generic 77824 1 snd_hda_codec_realtek, Live 0x0000000000000000
ath9k 143360 0 - Live 0x0000000000000000
uvcvideo 90112 0 - Live 0x0000000000000000
snd_hda_intel 36864 5 - Live 0x0000000000000000
rtsx_usb_ms 20480 0 - Live 0x0000000000000000
snd_hda_codec 135168 4 snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel, Live 0x0000000000000000
ath9k_common 36864 1 ath9k, Live 0x0000000000000000
kvm_intel 167936 0 - Live 0x0000000000000000
ath9k_hw 466944 2 ath9k,ath9k_common, Live 0x0000000000000000
ath 32768 3 ath9k,ath9k_common,ath9k_hw, Live 0x0000000000000000
videobuf2_vmalloc 16384 1 uvcvideo, Live 0x0000000000000000
memstick 20480 1 rtsx_usb_ms, Live 0x0000000000000000
acer_wmi 20480 0 - Live 0x0000000000000000
videobuf2_memops 16384 1 videobuf2_vmalloc, Live 0x0000000000000000
mac80211 724992 1 ath9k, Live 0x0000000000000000
snd_hda_core 65536 5 snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,snd_hda_codec, Live 0x0000000000000000
videobuf2_v4l2 28672 1 uvcvideo, Live 0x0000000000000000
kvm 532480 1 kvm_intel, Live 0x0000000000000000
rtsx_usb_sdmmc 28672 0 - Live 0x0000000000000000
videobuf2_core 36864 2 uvcvideo,videobuf2_v4l2, Live 0x0000000000000000
cfg80211 557056 4 ath9k,ath9k_common,ath,mac80211, Live 0x0000000000000000
v4l2_common 16384 1 videobuf2_v4l2, Live 0x0000000000000000
nouveau 1495040 1 - Live 0x0000000000000000
videodev 176128 4 uvcvideo,videobuf2_v4l2,videobuf2_core,v4l2_common, Live 0x0000000000000000
irqbypass 16384 1 kvm, Live 0x0000000000000000
snd_hwdep 16384 1 snd_hda_codec, Live 0x0000000000000000
sparse_keymap 16384 1 acer_wmi, Live 0x0000000000000000
snd_pcm 102400 4 snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec,snd_hda_core, Live 0x0000000000000000
snd_seq_midi 16384 0 - Live 0x0000000000000000
crct10dif_pclmul 16384 0 - Live 0x0000000000000000
mxm_wmi 16384 1 nouveau, Live 0x0000000000000000
snd_seq_midi_event 16384 1 snd_seq_midi, Live 0x0000000000000000
media 24576 2 uvcvideo,videodev, Live 0x0000000000000000
crc32_pclmul 16384 0 - Live 0x0000000000000000
snd_rawmidi 32768 1 snd_seq_midi, Live 0x0000000000000000
aesni_intel 167936 0 - Live 0x0000000000000000
snd_seq 69632 2 snd_seq_midi,snd_seq_midi_event, Live 0x0000000000000000
ttm 94208 1 nouveau, Live 0x0000000000000000
aes_x86_64 20480 1 aesni_intel, Live 0x0000000000000000
rtsx_usb 24576 2 rtsx_usb_ms,rtsx_usb_sdmmc, Live 0x0000000000000000
lrw 16384 1 aesni_intel, Live 0x0000000000000000
i915 1204224 5 - Live 0x0000000000000000
gf128mul 16384 1 lrw, Live 0x0000000000000000
btusb 45056 0 - Live 0x0000000000000000
glue_helper 16384 1 aesni_intel, Live 0x0000000000000000
btrtl 16384 1 btusb, Live 0x0000000000000000
btbcm 16384 1 btusb, Live 0x0000000000000000
snd_seq_device 16384 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 0x0000000000000000
btintel 16384 1 btusb, Live 0x0000000000000000
snd_timer 32768 2 snd_pcm,snd_seq, Live 0x0000000000000000
bluetooth 520192 14 bnep,rfcomm,btusb,btrtl,btbcm,btintel, Live 0x0000000000000000
snd 81920 21 snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_rawmidi,snd_seq,snd_seq_device,snd_timer, Live 0x0000000000000000
soundcore 16384 1 snd, Live 0x0000000000000000
ablk_helper 16384 1 aesni_intel, Live 0x0000000000000000
cryptd 20480 2 aesni_intel,ablk_helper, Live 0x0000000000000000
joydev 20480 0 - Live 0x0000000000000000
drm_kms_helper 135168 2 nouveau,i915, Live 0x0000000000000000
input_leds 16384 0 - Live 0x0000000000000000
drm 360448 9 nouveau,ttm,i915,drm_kms_helper, Live 0x0000000000000000
serio_raw 16384 0 - Live 0x0000000000000000
mei_me 32768 0 - Live 0x0000000000000000
i2c_hid 20480 0 - Live 0x0000000000000000
mei 98304 1 mei_me, Live 0x0000000000000000
lpc_ich 24576 0 - Live 0x0000000000000000
dell_smo8800 16384 0 - Live 0x0000000000000000
spi_pxa2xx_platform 24576 0 - Live 0x0000000000000000
wmi 20480 3 acer_wmi,nouveau,mxm_wmi, Live 0x0000000000000000
dw_dmac 16384 0 - Live 0x0000000000000000
dw_dmac_core 24576 1 dw_dmac, Live 0x0000000000000000
i2c_algo_bit 16384 2 nouveau,i915, Live 0x0000000000000000
parport_pc 32768 0 - Live 0x0000000000000000
shpchp 36864 0 - Live 0x0000000000000000
fb_sys_fops 16384 1 drm_kms_helper, Live 0x0000000000000000
syscopyarea 16384 1 drm_kms_helper, Live 0x0000000000000000
sysfillrect 16384 1 drm_kms_helper, Live 0x0000000000000000
video 40960 3 acer_wmi,nouveau,i915, Live 0x0000000000000000
sysimgblt 16384 1 drm_kms_helper, Live 0x0000000000000000
8250_dw 16384 0 - Live 0x0000000000000000
tpm_crb 16384 0 - Live 0x0000000000000000
mac_hid 16384 0 - Live 0x0000000000000000
ppdev 20480 0 - Live 0x0000000000000000
acpi_pad 20480 0 - Live 0x0000000000000000
i2c_designware_platform 16384 0 - Live 0x0000000000000000
i2c_designware_core 20480 1 i2c_designware_platform, Live 0x0000000000000000
lp 20480 0 - Live 0x0000000000000000
parport 49152 3 parport_pc,ppdev,lp, Live 0x0000000000000000
hid_generic 16384 0 - Live 0x0000000000000000
usbhid 49152 0 - Live 0x0000000000000000
hid 118784 3 i2c_hid,hid_generic,usbhid, Live 0x0000000000000000
uas 24576 0 - Live 0x0000000000000000
usb_storage 69632 2 uas, Live 0x0000000000000000
psmouse 126976 0 - Live 0x0000000000000000
ahci 36864 3 - Live 0x0000000000000000
libahci 32768 1 ahci, Live 0x0000000000000000
r8169 81920 0 - Live 0x0000000000000000
mii 16384 1 r8169, Live 0x0000000000000000
fjes 28672 0 - Live 0x0000000000000000
sdhci_acpi 16384 0 - Live 0x0000000000000000
sdhci 45056 1 sdhci_acpi, Live 0x0000000000000000

--------------------------------------------------------------------------------------------------------

 cat /proc/ioports:

0000-0cf7 : PCI Bus 0000:00
  0000-001f : dma1
  0020-0021 : pic1
  0040-0043 : timer0
  0050-0053 : timer1
  0060-0060 : keyboard
  0062-0062 : PNP0C09:00
    0062-0062 : EC data
  0064-0064 : keyboard
  0066-0066 : PNP0C09:00
    0066-0066 : EC cmd
  0070-0077 : rtc0
  0080-008f : dma page reg
  00a0-00a1 : pic2
  00c0-00df : dma2
  00f0-00ff : fpu
  0680-069f : pnp 00:00
0cf8-0cff : PCI conf1
0d00-ffff : PCI Bus 0000:00
  164e-164f : pnp 00:00
  1800-1803 : ACPI PM1a_EVT_BLK
  1804-1805 : ACPI PM1a_CNT_BLK
  1808-180b : ACPI PM_TMR
  1810-1815 : ACPI CPU throttle
  1830-1833 : iTCO_wdt.0.auto
  1850-1850 : ACPI PM2_CNT_BLK
  1854-1857 : pnp 00:02
  1860-187f : iTCO_wdt.0.auto
  1880-189f : ACPI GPE0_BLK
  2000-2fff : PCI Bus 0000:01
  3000-3fff : PCI Bus 0000:04
    3000-307f : 0000:04:00.0
  4000-4fff : PCI Bus 0000:02
    4000-40ff : 0000:02:00.0
      4000-40ff : r8169
  5000-503f : 0000:00:02.0
  5040-505f : 0000:00:1f.3
  5060-507f : 0000:00:1f.2
    5060-507f : ahci
  5080-5087 : 0000:00:1f.2
    5080-5087 : ahci
  5088-508f : 0000:00:1f.2
    5088-508f : ahci
  5090-5093 : 0000:00:1f.2
    5090-5093 : ahci
  5094-5097 : 0000:00:1f.2
    5094-5097 : ahci
  ffff-ffff : pnp 00:00
    ffff-ffff : pnp 00:00
      ffff-ffff : pnp 00:00

--------------------------------------------------------------------------------------------------------

 cat /proc/iomem:

00000000-00000fff : reserved
00001000-00057fff : System RAM
00058000-00058fff : reserved
00059000-00085fff : System RAM
00086000-0009ffff : reserved
000a0000-000bffff : PCI Bus 0000:00
000c0000-000c3fff : PCI Bus 0000:00
000c4000-000c7fff : PCI Bus 0000:00
000c8000-000cbfff : PCI Bus 0000:00
000cc000-000cffff : PCI Bus 0000:00
000d0000-000d3fff : PCI Bus 0000:00
000d4000-000d7fff : PCI Bus 0000:00
000d8000-000dbfff : PCI Bus 0000:00
000dc000-000dffff : PCI Bus 0000:00
000e0000-000e3fff : PCI Bus 0000:00
000e4000-000e7fff : PCI Bus 0000:00
000e8000-000ebfff : PCI Bus 0000:00
000ec000-000effff : PCI Bus 0000:00
000f0000-000fffff : System ROM
00100000-8ebd7fff : System RAM
  02000000-028027ff : Kernel code
  02802800-02f3bd3f : Kernel data
  030b2000-031f4fff : Kernel bss
8ebd8000-8f4d8fff : reserved
8f4d9000-9c3edfff : System RAM
9c3ee000-9c5edfff : reserved
9c5ee000-9cdddfff : reserved
9cdde000-9cfbdfff : ACPI Non-volatile Storage
9cfbe000-9cffdfff : ACPI Tables
9cffe000-9cffefff : System RAM
9cfff000-9cffffff : MSFT0101:00
9d000000-9dffffff : RAM buffer
9e000000-9fffffff : reserved
  9e000000-9fffffff : Graphics Stolen Memory
a0000000-dfffffff : PCI Bus 0000:00
  a0000000-a000ffff : pnp 00:06
  a0010000-a001ffff : pnp 00:06
  a0100000-a02fffff : PCI Bus 0000:01
  a0300000-a04fffff : PCI Bus 0000:01
  b0000000-c1ffffff : PCI Bus 0000:04
    b0000000-bfffffff : 0000:04:00.0
    c0000000-c1ffffff : 0000:04:00.0
  c2000000-c2ffffff : 0000:00:02.0
  c3000000-c40fffff : PCI Bus 0000:04
    c3000000-c3ffffff : 0000:04:00.0
    c4000000-c407ffff : 0000:04:00.0
  c4100000-c41fffff : PCI Bus 0000:03
    c4100000-c417ffff : 0000:03:00.0
      c4100000-c417ffff : ath9k
    c4180000-c418ffff : 0000:03:00.0
  c4200000-c42fffff : PCI Bus 0000:02
    c4200000-c4203fff : 0000:02:00.0
      c4200000-c4203fff : r8169
    c4204000-c4204fff : 0000:02:00.0
      c4204000-c4204fff : r8169
  c4300000-c430ffff : 0000:00:14.0
    c4300000-c430ffff : xhci-hcd
  c4310000-c4313fff : 0000:00:03.0
    c4310000-c4313fff : ICH HD audio
  c4314000-c4317fff : 0000:00:1b.0
    c4314000-c4317fff : ICH HD audio
  c4318000-c43187ff : 0000:00:1f.2
    c4318000-c43187ff : ahci
  c4319000-c43193ff : 0000:00:1d.0
    c4319000-c43193ff : ehci_hcd
  c431a000-c431a0ff : 0000:00:1f.3
  c431b000-c431b01f : 0000:00:16.0
    c431b000-c431b01f : mei_me
  d0000000-dfffffff : 0000:00:02.0
e0000000-efffffff : PCI MMCONFIG 0000 [bus 00-ff]
  e0000000-efffffff : reserved
    e0000000-efffffff : pnp 00:06
fe101000-fe113fff : PCI Bus 0000:00
  fe101000-fe101fff : INTL9C60:00
    fe101000-fe101fff : INTL9C60:00
  fe102000-fe102fff : pnp 00:05
  fe103000-fe103fff : INT3432:00
    fe103000-fe103fff : INT3432:00
  fe104000-fe104fff : pnp 00:05
  fe105000-fe105fff : INT3433:00
    fe105000-fe105fff : INT3433:00
  fe106000-fe106fff : pnp 00:05
feb00000-feb03fff : reserved
fec00000-fec00fff : reserved
  fec00000-fec003ff : IOAPIC 0
fed00000-fed003ff : HPET 0
  fed00000-fed003ff : PNP0103:00
fed10000-fed19fff : reserved
  fed10000-fed17fff : pnp 00:06
  fed18000-fed18fff : pnp 00:06
  fed19000-fed19fff : pnp 00:06
fed1c000-fed1ffff : reserved
  fed1c000-fed1ffff : pnp 00:06
    fed1f410-fed1f414 : iTCO_wdt.0.auto
fed20000-fed3ffff : pnp 00:06
fed70000-fed70fff : MSFT0101:00
fed90000-fed90fff : dmar0
fed91000-fed91fff : dmar1
fee00000-fee00fff : Local APIC
  fee00000-fee00fff : reserved
ff000000-ffffffff : INT0800:00
  ffa00000-ffffffff : reserved
100000000-25effffff : System RAM
25f000000-25fffffff : RAM buffer

--------------------------------------------------------------------------------------------------------

sudo lspci -vvvnnk:

00:00.0 Host bridge [0600]: Intel Corporation Broadwell-U Host Bridge -OPI [8086:1604] (rev 09)
    Subsystem: Acer Incorporated [ALI] Device [1025:098a]
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR- INTx-
    Latency: 0
    Capabilities: [e0] Vendor Specific Information: Len=0c <?>
    Kernel driver in use: bdw_uncore

00:02.0 VGA compatible controller [0300]: Intel Corporation Broadwell-U Integrated Graphics [8086:1616] (rev 09) (prog-if 00 [VGA controller])
    Subsystem: Acer Incorporated [ALI] Device [1025:098a]
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 50
    Region 0: Memory at c2000000 (64-bit, non-prefetchable) [size=16M]
    Region 2: Memory at d0000000 (64-bit, prefetchable) [size=256M]
    Region 4: I/O ports at 5000 [size=64]
    Expansion ROM at <unassigned> [disabled]
    Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
        Address: fee00018  Data: 0000
    Capabilities: [d0] Power Management version 2
        Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [a4] PCI Advanced Features
        AFCap: TP+ FLR+
        AFCtrl: FLR-
        AFStatus: TP-
    Kernel driver in use: i915

00:03.0 Audio device [0403]: Intel Corporation Broadwell-U Audio Controller [8086:160c] (rev 09)
    Subsystem: Acer Incorporated [ALI] Device [1025:098a]
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 53
    Region 0: Memory at c4310000 (64-bit, non-prefetchable) [size=16K]
    Capabilities: [50] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit-
        Address: fee00398  Data: 0000
    Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0
            ExtTag- RBE-
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
    Kernel driver in use: snd_hda_intel

00:14.0 USB controller [0c03]: Intel Corporation Wildcat Point-LP USB xHCI Controller [8086:9cb1] (rev 03) (prog-if 30 [XHCI])
    Subsystem: Acer Incorporated [ALI] Device [1025:098a]
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 46
    Region 0: Memory at c4300000 (64-bit, non-prefetchable) [size=64K]
    Capabilities: [70] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [80] MSI: Enable+ Count=1/8 Maskable- 64bit+
        Address: 00000000fee00298  Data: 0000
    Kernel driver in use: xhci_hcd

00:16.0 Communication controller [0780]: Intel Corporation Wildcat Point-LP MEI Controller #1 [8086:9cba] (rev 03)
    Subsystem: Acer Incorporated [ALI] Device [1025:098a]
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 49
    Region 0: Memory at c431b000 (64-bit, non-prefetchable) [size=32]
    Capabilities: [50] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [8c] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Address: 00000000fee00318  Data: 0000
    Kernel driver in use: mei_me

00:1b.0 Audio device [0403]: Intel Corporation Wildcat Point-LP High Definition Audio Controller [8086:9ca0] (rev 03)
    Subsystem: Acer Incorporated [ALI] Device [1025:098a]
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 64, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 51
    Region 0: Memory at c4314000 (64-bit, non-prefetchable) [size=16K]
    Capabilities: [50] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Address: 00000000fee00358  Data: 0000
    Kernel driver in use: snd_hda_intel

00:1c.0 PCI bridge [0604]: Intel Corporation Wildcat Point-LP PCI Express Root Port #1 [8086:9c90] (rev e3) (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
    I/O behind bridge: 00002000-00002fff
    Memory behind bridge: a0100000-a02fffff
    Prefetchable memory behind bridge: 00000000a0300000-00000000a04fffff
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
    BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0
            ExtTag- RBE+
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
        LnkCap:    Port #1, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <1us, L1 <4us
            ClockPM- Surprise- LLActRep+ BwNot+
        LnkCtl:    ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk-
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
        SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
            Slot #0, PowerLimit 0.000W; Interlock- NoCompl+
        SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq+ LinkChg+
            Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
        SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
            Changed: MRL- PresDet- LinkState-
        RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-
        RootCap: CRSVisible-
        RootSta: PME ReqID 0000, PMEStatus- PMEPending-
        DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+, OBFF Via WAKE# ARIFwd-
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF Disabled ARIFwd-
        LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
             Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
             EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
    Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
        Address: fee00218  Data: 0000
    Capabilities: [90] Subsystem: Acer Incorporated [ALI] Device [1025:098a]
    Capabilities: [a0] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Kernel driver in use: pcieport

00:1c.2 PCI bridge [0604]: Intel Corporation Wildcat Point-LP PCI Express Root Port #3 [8086:9c94] (rev e3) (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
    I/O behind bridge: 00004000-00004fff
    Memory behind bridge: c4200000-c42fffff
    Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
    BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0
            ExtTag- RBE+
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
        LnkCap:    Port #3, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <512ns, L1 <16us
            ClockPM- Surprise- LLActRep+ BwNot+
        LnkCtl:    ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
        SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
            Slot #2, PowerLimit 10.000W; Interlock- NoCompl+
        SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
            Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
        SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
            Changed: MRL- PresDet- LinkState+
        RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-
        RootCap: CRSVisible-
        RootSta: PME ReqID 0000, PMEStatus- PMEPending-
        DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+, OBFF Not Supported ARIFwd-
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF Disabled ARIFwd-
        LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
             Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
             EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
    Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
        Address: fee00238  Data: 0000
    Capabilities: [90] Subsystem: Acer Incorporated [ALI] Device [1025:098a]
    Capabilities: [a0] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [100 v0] #00
    Capabilities: [200 v1] L1 PM Substates
        L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
              PortCommonModeRestoreTime=40us PortTPowerOnTime=10us
    Kernel driver in use: pcieport

00:1c.3 PCI bridge [0604]: Intel Corporation Wildcat Point-LP PCI Express Root Port #4 [8086:9c96] (rev e3) (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
    I/O behind bridge: 0000f000-00000fff
    Memory behind bridge: c4100000-c41fffff
    Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
    BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0
            ExtTag- RBE+
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
        LnkCap:    Port #4, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <512ns, L1 <16us
            ClockPM- Surprise- LLActRep+ BwNot+
        LnkCtl:    ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
        SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
            Slot #3, PowerLimit 10.000W; Interlock- NoCompl+
        SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
            Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
        SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
            Changed: MRL- PresDet- LinkState+
        RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-
        RootCap: CRSVisible-
        RootSta: PME ReqID 0000, PMEStatus- PMEPending-
        DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+, OBFF Not Supported ARIFwd-
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF Disabled ARIFwd-
        LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
             Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
             EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
    Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
        Address: fee00258  Data: 0000
    Capabilities: [90] Subsystem: Acer Incorporated [ALI] Device [1025:098a]
    Capabilities: [a0] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [100 v0] #00
    Capabilities: [200 v1] L1 PM Substates
        L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
              PortCommonModeRestoreTime=40us PortTPowerOnTime=10us
    Kernel driver in use: pcieport

00:1c.4 PCI bridge [0604]: Intel Corporation Wildcat Point-LP PCI Express Root Port #5 [8086:9c98] (rev e3) (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
    I/O behind bridge: 00003000-00003fff
    Memory behind bridge: c3000000-c40fffff
    Prefetchable memory behind bridge: 00000000b0000000-00000000c1ffffff
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
    BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0
            ExtTag- RBE+
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
        LnkCap:    Port #5, Speed 5GT/s, Width x4, ASPM L0s L1, Exit Latency L0s <512ns, L1 <16us
            ClockPM- Surprise- LLActRep+ BwNot+
        LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- CommClk+
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x4, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
        SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
            Slot #4, PowerLimit 25.000W; Interlock- NoCompl+
        SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
            Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
        SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
            Changed: MRL- PresDet+ LinkState+
        RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-
        RootCap: CRSVisible-
        RootSta: PME ReqID 0000, PMEStatus- PMEPending-
        DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR-, OBFF Not Supported ARIFwd-
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
        LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
             Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
             EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
    Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
        Address: fee00278  Data: 0000
    Capabilities: [90] Subsystem: Acer Incorporated [ALI] Device [1025:098a]
    Capabilities: [a0] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [100 v0] #00
    Capabilities: [200 v1] L1 PM Substates
        L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
              PortCommonModeRestoreTime=40us PortTPowerOnTime=10us
    Kernel driver in use: pcieport

00:1d.0 USB controller [0c03]: Intel Corporation Wildcat Point-LP USB EHCI Controller [8086:9ca6] (rev 03) (prog-if 20 [EHCI])
    Subsystem: Acer Incorporated [ALI] Device [1025:098a]
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 23
    Region 0: Memory at c4319000 (32-bit, non-prefetchable) [size=1K]
    Capabilities: [50] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [58] Debug port: BAR=1 offset=00a0
    Capabilities: [98] PCI Advanced Features
        AFCap: TP+ FLR+
        AFCtrl: FLR-
        AFStatus: TP-
    Kernel driver in use: ehci-pci

00:1f.0 ISA bridge [0601]: Intel Corporation Wildcat Point-LP LPC Controller [8086:9cc3] (rev 03)
    Subsystem: Acer Incorporated [ALI] Device [1025:098a]
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Capabilities: [e0] Vendor Specific Information: Len=0c <?>
    Kernel driver in use: lpc_ich

00:1f.2 SATA controller [0106]: Intel Corporation Wildcat Point-LP SATA Controller [AHCI Mode] [8086:9c83] (rev 03) (prog-if 01 [AHCI 1.0])
    Subsystem: Acer Incorporated [ALI] Device [1025:098a]
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin B routed to IRQ 47
    Region 0: I/O ports at 5088 [size=8]
    Region 1: I/O ports at 5094 [size=4]
    Region 2: I/O ports at 5080 [size=8]
    Region 3: I/O ports at 5090 [size=4]
    Region 4: I/O ports at 5060 [size=32]
    Region 5: Memory at c4318000 (32-bit, non-prefetchable) [size=2K]
    Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
        Address: fee002f8  Data: 0000
    Capabilities: [70] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=00000004
    Kernel driver in use: ahci

00:1f.3 SMBus [0c05]: Intel Corporation Wildcat Point-LP SMBus Controller [8086:9ca2] (rev 03)
    Subsystem: Acer Incorporated [ALI] Device [1025:098a]
    Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
    Interrupt: pin C routed to IRQ 255
    Region 0: Memory at c431a000 (64-bit, non-prefetchable) [size=256]
    Region 4: I/O ports at 5040 [size=32]

02:00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller [10ec:8168] (rev 15)
    Subsystem: Acer Incorporated [ALI] Device [1025:098a]
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 48
    Region 0: I/O ports at 4000 [size=256]
    Region 2: Memory at c4204000 (64-bit, non-prefetchable) [size=4K]
    Region 4: Memory at c4200000 (64-bit, non-prefetchable) [size=16K]
    Capabilities: [40] Power Management version 3
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Address: 00000000fee002d8  Data: 0000
    Capabilities: [70] Express (v2) Endpoint, MSI 01
        DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
            ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
            RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 4096 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
        LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s unlimited, L1 <64us
            ClockPM+ Surprise- LLActRep- BwNot-
        LnkCtl:    ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
            ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
        DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR+, OBFF Via message/WAKE#
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF Disabled
        LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
             Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
             EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
    Capabilities: [b0] MSI-X: Enable- Count=4 Masked-
        Vector table: BAR=4 offset=00000000
        PBA: BAR=4 offset=00000800
    Capabilities: [100 v2] Advanced Error Reporting
        UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
        CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
        CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
        AERCap:    First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
    Capabilities: [140 v1] Virtual Channel
        Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
        Arb:    Fixed- WRR32- WRR64- WRR128-
        Ctrl:    ArbSelect=Fixed
        Status:    InProgress-
        VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
            Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
            Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
            Status:    NegoPending- InProgress-
    Capabilities: [160 v1] Device Serial Number 00-00-00-00-00-00-00-00
    Capabilities: [170 v1] Latency Tolerance Reporting
        Max snoop latency: 3145728ns
        Max no snoop latency: 3145728ns
    Capabilities: [178 v1] L1 PM Substates
        L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
              PortCommonModeRestoreTime=150us PortTPowerOnTime=150us
    Kernel driver in use: r8169

03:00.0 Network controller [0280]: Qualcomm Atheros QCA9565 / AR9565 Wireless Network Adapter [168c:0036] (rev 01)
    Subsystem: Lite-On Communications Inc Device [11ad:0803]
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 19
    Region 0: Memory at c4100000 (64-bit, non-prefetchable) [size=512K]
    Expansion ROM at c4180000 [disabled] [size=64K]
    Capabilities: [40] Power Management version 2
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [50] MSI: Enable- Count=1/4 Maskable+ 64bit+
        Address: 0000000000000000  Data: 0000
        Masking: 00000000  Pending: 00000000
    Capabilities: [70] Express (v2) Endpoint, MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 <64us
            ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
            RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 512 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
        LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <4us, L1 <64us
            ClockPM- Surprise- LLActRep- BwNot-
        LnkCtl:    ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
        DevCap2: Completion Timeout: Not Supported, TimeoutDis+, LTR-, OBFF Not Supported
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
        LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
             Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
             EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
    Capabilities: [100 v1] Advanced Error Reporting
        UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
        CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
        CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
        AERCap:    First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
    Capabilities: [140 v1] Virtual Channel
        Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
        Arb:    Fixed- WRR32- WRR64- WRR128-
        Ctrl:    ArbSelect=Fixed
        Status:    InProgress-
        VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
            Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
            Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
            Status:    NegoPending- InProgress-
    Capabilities: [160 v1] Device Serial Number 00-00-00-00-00-00-00-00
    Kernel driver in use: ath9k

04:00.0 3D controller [0302]: NVIDIA Corporation Device [10de:1299] (rev a1)
    Subsystem: Acer Incorporated [ALI] Device [1025:098b]
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 52
    Region 0: Memory at c3000000 (32-bit, non-prefetchable) [size=16M]
    Region 1: Memory at b0000000 (64-bit, prefetchable) [size=256M]
    Region 3: Memory at c0000000 (64-bit, prefetchable) [size=32M]
    Region 5: I/O ports at 3000 [size=128]
    Expansion ROM at c4000000 [disabled] [size=512K]
    Capabilities: [60] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [68] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Address: 00000000fee00378  Data: 0000
    Capabilities: [78] Express (v2) Endpoint, MSI 00
        DevCap:    MaxPayload 256 bytes, PhantFunc 0, Latency L0s unlimited, L1 <64us
            ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
            RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
            MaxPayload 128 bytes, MaxReadReq 512 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
        LnkCap:    Port #0, Speed 8GT/s, Width x8, ASPM L0s L1, Exit Latency L0s <512ns, L1 <4us
            ClockPM+ Surprise- LLActRep- BwNot-
        LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- CommClk+
            ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x4, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
        DevCap2: Completion Timeout: Range AB, TimeoutDis+, LTR-, OBFF Not Supported
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
        LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
             Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
             EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
    Capabilities: [100 v1] Virtual Channel
        Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
        Arb:    Fixed- WRR32- WRR64- WRR128-
        Ctrl:    ArbSelect=Fixed
        Status:    InProgress-
        VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
            Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
            Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
            Status:    NegoPending- InProgress-
    Capabilities: [128 v1] Power Budgeting <?>
    Capabilities: [600 v1] Vendor Specific Information: ID=0001 Rev=1 Len=024 <?>
    Capabilities: [900 v1] #19
    Kernel driver in use: nouveau

--------------------------------------------------------------------------------------------------------

sudo cat /sys/kernel/debug/usb/devices:

T:  Bus=03 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=5000 MxCh= 4
B:  Alloc=  0/800 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 3.00 Cls=09(hub  ) Sub=00 Prot=03 MxPS= 9 #Cfgs=  1
P:  Vendor=1d6b ProdID=0003 Rev= 4.04
S:  Manufacturer=Linux 4.4.0-040400-generic xhci-hcd
S:  Product=xHCI Host Controller
S:  SerialNumber=0000:00:14.0
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:* If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   4 Ivl=256ms

T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=480  MxCh=11
B:  Alloc=  0/800 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=1d6b ProdID=0002 Rev= 4.04
S:  Manufacturer=Linux 4.4.0-040400-generic xhci-hcd
S:  Product=xHCI Host Controller
S:  SerialNumber=0000:00:14.0
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:* If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   4 Ivl=256ms

T:  Bus=02 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=480  MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=0781 ProdID=5567 Rev= 1.26
S:  Manufacturer=SanDisk
S:  Product=Cruzer Blade
S:  SerialNumber=2006258500142B407A44
C:* #Ifs= 1 Cfg#= 1 Atr=80 MxPwr=200mA
I:* If#= 0 Alt= 0 #EPs= 2 Cls=08(stor.) Sub=06 Prot=50 Driver=usb-storage
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=125us

T:  Bus=02 Lev=01 Prnt=01 Port=01 Cnt=02 Dev#=  3 Spd=12   MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=046d ProdID=c534 Rev=29.00
S:  Manufacturer=Logitech
S:  Product=USB Receiver
C:* #Ifs= 2 Cfg#= 1 Atr=a0 MxPwr= 98mA
I:* If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=01 Driver=usbhid
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=8ms
I:* If#= 1 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=02 Driver=usbhid
E:  Ad=82(I) Atr=03(Int.) MxPS=  20 Ivl=2ms

T:  Bus=02 Lev=01 Prnt=01 Port=06 Cnt=03 Dev#=  5 Spd=480  MxCh= 0
D:  Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=1bcf ProdID=2c81 Rev= 0.05
S:  Manufacturer=NC2141103M51007A70LM05
S:  Product=HD WebCam
C:* #Ifs= 2 Cfg#= 1 Atr=80 MxPwr=500mA
A:  FirstIf#= 0 IfCount= 2 Cls=0e(video) Sub=03 Prot=00
I:* If#= 0 Alt= 0 #EPs= 1 Cls=0e(video) Sub=01 Prot=00 Driver=uvcvideo
E:  Ad=87(I) Atr=03(Int.) MxPS=  16 Ivl=16ms
I:* If#= 1 Alt= 0 #EPs= 0 Cls=0e(video) Sub=02 Prot=00 Driver=uvcvideo
I:  If#= 1 Alt= 1 #EPs= 1 Cls=0e(video) Sub=02 Prot=00 Driver=uvcvideo
E:  Ad=81(I) Atr=05(Isoc) MxPS= 192 Ivl=125us
I:  If#= 1 Alt= 2 #EPs= 1 Cls=0e(video) Sub=02 Prot=00 Driver=uvcvideo
E:  Ad=81(I) Atr=05(Isoc) MxPS= 384 Ivl=125us
I:  If#= 1 Alt= 3 #EPs= 1 Cls=0e(video) Sub=02 Prot=00 Driver=uvcvideo
E:  Ad=81(I) Atr=05(Isoc) MxPS= 512 Ivl=125us
I:  If#= 1 Alt= 4 #EPs= 1 Cls=0e(video) Sub=02 Prot=00 Driver=uvcvideo
E:  Ad=81(I) Atr=05(Isoc) MxPS= 640 Ivl=125us
I:  If#= 1 Alt= 5 #EPs= 1 Cls=0e(video) Sub=02 Prot=00 Driver=uvcvideo
E:  Ad=81(I) Atr=05(Isoc) MxPS= 800 Ivl=125us
I:  If#= 1 Alt= 6 #EPs= 1 Cls=0e(video) Sub=02 Prot=00 Driver=uvcvideo
E:  Ad=81(I) Atr=05(Isoc) MxPS= 944 Ivl=125us
I:  If#= 1 Alt= 7 #EPs= 1 Cls=0e(video) Sub=02 Prot=00 Driver=uvcvideo
E:  Ad=81(I) Atr=05(Isoc) MxPS=1280 Ivl=125us
I:  If#= 1 Alt= 8 #EPs= 1 Cls=0e(video) Sub=02 Prot=00 Driver=uvcvideo
E:  Ad=81(I) Atr=05(Isoc) MxPS=1600 Ivl=125us
I:  If#= 1 Alt= 9 #EPs= 1 Cls=0e(video) Sub=02 Prot=00 Driver=uvcvideo
E:  Ad=81(I) Atr=05(Isoc) MxPS=1984 Ivl=125us
I:  If#= 1 Alt=10 #EPs= 1 Cls=0e(video) Sub=02 Prot=00 Driver=uvcvideo
E:  Ad=81(I) Atr=05(Isoc) MxPS=2880 Ivl=125us
I:  If#= 1 Alt=11 #EPs= 1 Cls=0e(video) Sub=02 Prot=00 Driver=uvcvideo
E:  Ad=81(I) Atr=05(Isoc) MxPS=3060 Ivl=125us

T:  Bus=02 Lev=01 Prnt=01 Port=07 Cnt=04 Dev#=  6 Spd=480  MxCh= 0
D:  Ver= 2.00 Cls=ff(vend.) Sub=ff Prot=ff MxPS=64 #Cfgs=  1
P:  Vendor=0bda ProdID=0129 Rev=39.60
S:  Manufacturer=Generic
S:  Product=USB2.0-CRW
S:  SerialNumber=20100201396000000
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr=500mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=06 Prot=50 Driver=rtsx_usb
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=83(I) Atr=03(Int.) MxPS=   3 Ivl=64ms

T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=480  MxCh= 2
B:  Alloc=  0/800 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1d6b ProdID=0002 Rev= 4.04
S:  Manufacturer=Linux 4.4.0-040400-generic ehci_hcd
S:  Product=EHCI Host Controller
S:  SerialNumber=0000:00:1d.0
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:* If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   4 Ivl=256ms

T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=480  MxCh= 8
D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=8087 ProdID=8001 Rev= 0.03
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:* If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=256ms

