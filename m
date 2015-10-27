Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 27 Oct 2015 12:52:36 -0700
Message-ID: <CAJa1xEoqLbN_sNJsvPWMS=XUMd5An7x4MKvS5iYFA30=5-TjoQ@mail.gmail.com>
Subject: 04ca:3011 device not working
From: John Salatas <jsalatas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi!

My laptop (Acer Aspire VN7-591G-77FS) has a combo Atheros
Wireles/Bluetooth card. In the back of the laptop it has a sticker
saying "This device contains WLAN-Bluetooth module QCNFA344".

I'm running kernel 3.19.0-31-generic (Linux Mint 17.2) with
backports-20150903, and the card id recognised as follows

1) lspci
07:00.0 Network controller: Qualcomm Atheros Device 003e (rev 20)
        Subsystem: Lite-On Communications Inc Device 0804
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx+
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 36
        Region 0: Memory at d1400000 (64-bit, non-prefetchable) [size=2M]
        Capabilities: <access denied>
        Kernel driver in use: ath10k_pci

2) lsusb
Bus 001 Device 005: ID 04ca:3011 Lite-On Technology Corp.
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass         224 Wireless
  bDeviceSubClass         1 Radio Frequency
  bDeviceProtocol         1 Bluetooth
  bMaxPacketSize0        64
  idVendor           0x04ca Lite-On Technology Corp.
  idProduct          0x3011
  bcdDevice            0.01
  iManufacturer           0
  iProduct                0
  iSerial                 0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength          177
    bNumInterfaces          2
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           3
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0010  1x 16 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0000  1x 0 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0000  1x 0 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       1
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0009  1x 9 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0009  1x 9 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       2
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0011  1x 17 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0011  1x 17 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       3
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0019  1x 25 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0019  1x 25 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       4
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0021  1x 33 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0021  1x 33 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       5
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0031  1x 49 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0031  1x 49 bytes
        bInterval               1
Device Status:     0x0001
  Self Powered


3) rfkill list
0: acer-wireless: Wireless LAN
        Soft blocked: no
        Hard blocked: no
2: phy0: Wireless LAN
        Soft blocked: no
        Hard blocked: no
3: hci0: Bluetooth
        Soft blocked: no
        Hard blocked: no


4) lsmod
Module                  Size  Used by
hid_generic            16384  0
ctr                    16384  2
ccm                    20480  2
nvram                  16384  0
msr                    16384  0
arc4                   16384  2
rtsx_usb_ms            20480  0
memstick               20480  1 rtsx_usb_ms
uvcvideo               90112  0
videobuf2_vmalloc      16384  1 uvcvideo
videobuf2_memops       16384  1 videobuf2_vmalloc
videobuf2_core         53248  1 uvcvideo
v4l2_common            16384  1 videobuf2_core
videodev              159744  3 uvcvideo,v4l2_common,videobuf2_core
media                  24576  2 uvcvideo,videodev
btusb                  40960  0
hid_multitouch         20480  0
bbswitch               16384  0
rfcomm                 69632  12
bnep                   20480  2
bluetooth             491520  22 bnep,btusb,rfcomm
joydev                 20480  0
binfmt_misc            20480  1
nls_iso8859_1          16384  1
acer_wmi               20480  0
sparse_keymap          16384  1 acer_wmi
intel_rapl             20480  0
iosf_mbi               16384  1 intel_rapl
x86_pkg_temp_thermal    16384  0
ath10k_pci             45056  0
ath10k_core           323584  1 ath10k_pci
intel_powerclamp       20480  0
ath                    32768  1 ath10k_core
coretemp               16384  0
kvm_intel             151552  0
kvm                   479232  1 kvm_intel
mac80211              643072  1 ath10k_core
crct10dif_pclmul       16384  0
crc32_pclmul           16384  0
ghash_clmulni_intel    16384  0
cfg80211              532480  3 ath,mac80211,ath10k_core
snd_hda_codec_hdmi     53248  1
aesni_intel           172032  5
compat                 28672  4 cfg80211,mac80211,ath10k_pci,ath10k_core
aes_x86_64             20480  1 aesni_intel
lrw                    16384  1 aesni_intel
gf128mul               16384  1 lrw
glue_helper            16384  1 aesni_intel
ablk_helper            16384  1 aesni_intel
cryptd                 20480  3 ghash_clmulni_intel,aesni_intel,ablk_helper
snd_hda_codec_realtek    81920  1
snd_hda_codec_generic    69632  1 snd_hda_codec_realtek
serio_raw              16384  0
lpc_ich                24576  0
wmi                    20480  1 acer_wmi
soc_button_array       16384  0
snd_hda_intel          36864  6 snd_hda_codec_hdmi
mac_hid                16384  0
snd_hda_controller     32768  1 snd_hda_intel
snd_hda_codec         143360  5
snd_hda_codec_realtek,snd_hda_codec_hdmi,snd_hda_codec_generic,snd_hda_intel,snd_hda_controller
mei_me                 20480  0
snd_hwdep              20480  1 snd_hda_codec
mei                    90112  1 mei_me
snd_pcm               106496  4
snd_hda_codec_hdmi,snd_hda_codec,snd_hda_intel,snd_hda_controller
snd_seq_midi           16384  0
snd_seq_midi_event     16384  1 snd_seq_midi
snd_rawmidi            32768  1 snd_seq_midi
snd_seq                65536  2 snd_seq_midi_event,snd_seq_midi
snd_seq_device         16384  3 snd_seq,snd_rawmidi,snd_seq_midi
snd_timer              32768  2 snd_pcm,snd_seq
snd                    86016  21
snd_hda_codec_realtek,snd_hwdep,snd_timer,snd_hda_codec_hdmi,snd_pcm,snd_seq,snd_rawmidi,snd_hda_codec_generic,snd_hda_codec,snd_hda_intel,snd_seq_device
soundcore              16384  2 snd,snd_hda_codec
shpchp                 40960  0
ie31200_edac           16384  0
edac_core              53248  1 ie31200_edac
parport_pc             32768  0
ppdev                  20480  0
lp                     20480  0
parport                45056  3 lp,ppdev,parport_pc
btrfs                 937984  0
xor                    24576  1 btrfs
raid6_pq               98304  1 btrfs
usbhid                 53248  0
hid                   110592  3 hid_multitouch,hid_generic,usbhid
bcache                229376  8
rtsx_usb_sdmmc         28672  0
rtsx_usb               24576  2 rtsx_usb_sdmmc,rtsx_usb_ms
i915                 1048576  3
i2c_algo_bit           16384  1 i915
drm_kms_helper        126976  1 i915
drm                   344064  4 i915,drm_kms_helper
ahci                   36864  7
r8169                  81920  0
libahci                32768  1 ahci
mii                    16384  1 r8169
video                  20480  2 i915,acer_wmi


The problem is that bluetooth doesn't work although it seems that it
is being recognised. As it is actually a USB device, I tried to attach
it in a VirtualBox machine running windows 10 which recognised the
device and installed the drivers. After that if I detach it from the
VM, it works ok in linux until a reboot.

I'm guessing that it needs some kind of firmware in order to work. As
it seems to me (based on
https://wireless.wiki.kernel.org/en/users/drivers/ath3k#how_to_tell_ar3011_and_ar3012)
this is an AR3011 device, and so I added it's id in ath3k.c and
btusb.c in a similar way as here:
http://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.git/commit/?id=6eda541d12116b4772baa09d3e8d7b0389df4289

After rebooting, I didn't get any errors in dmesg but the device is
not recognised at all know. Eg rfkill list gives the following
0: acer-wireless: Wireless LAN
        Soft blocked: no
        Hard blocked: no
2: phy0: Wireless LAN
        Soft blocked: no
        Hard blocked: no
3: hci0: Bluetooth
        Soft blocked: no
        Hard blocked: no

It doesn't work any more even if I do the attach to VM trick.

My assumption here is that the provided firmware (ath3k-1.fw) doesn't
work with this particular card. Am I right?

If this is the case, is there any way to extract/dump the firmware or
any other initialization commands that windows is sending to the
device? I used Wireshark in combination with usbmon to capture the
traffic but I cannot make sense of the captured packets.

Any help/suggestion would be highly appreciated.

Thank you in advance,

John Salatas
