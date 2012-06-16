Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Benjamin Kerensa <bkerensa@ubuntu.com>
Date: Sat, 16 Jun 2012 13:32:21 -0700
Message-ID: <CAGOdq5n+1=p5_PW9h9D84-nn4pVCqFNza1O+n6DpJifuz1QspQ@mail.gmail.com>
Subject: 8086:0189 Intel Corp. pairs with Bluetooth Audio Headsets although is
 not seen in pulseaudio
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

[1.] One line summary of the problem:  8086:0189 Intel Corp. can pair
with Bluetooth Audio Devices but not see them for pulseaudio
[2.] Full description of the problem/report: Intel Bluetooth/Wireless
Chip in Dell Inspiron 14z can pair with Bluetooth Audio devices
however
the devices do not list in Pulseaudio and no audio is emitted from them
[3.] Keywords (i.e., modules, networking, kernel): kernel, blueooth
[4.] Kernel version (from /proc/version): Linux version 3.2.0-26-generic
[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)
[6.] A small shell script or example program which triggers the
     problem (if possible)
[7.] Environment: Ubuntu 12.04
[7.1.] Software (add the output of the ver_linux script here)
[7.2.] Processor information (from /proc/cpuinfo): Intel(R) Core(TM)
i5-2410M CPU @ 2.30GHz
[7.3.] Module information (from /proc/modules):
usbhid 47199 0 - Live 0x0000000000000000
snd_usb_audio 122982 0 - Live 0x0000000000000000
hid 99559 1 usbhid, Live 0x0000000000000000
snd_usbmidi_lib 25395 1 snd_usb_audio, Live 0x0000000000000000
pci_stub 12622 1 - Live 0x0000000000000000
vboxpci 23200 0 - Live 0x0000000000000000 (O)
vboxnetadp 13382 0 - Live 0x0000000000000000 (O)
vboxnetflt 23441 0 - Live 0x0000000000000000 (O)
vboxdrv 287082 3 vboxpci,vboxnetadp,vboxnetflt, Live 0x0000000000000000 (O)
parport_pc 32866 0 - Live 0x0000000000000000
ppdev 17113 0 - Live 0x0000000000000000
dm_crypt 23125 1 - Live 0x0000000000000000
snd_hda_codec_hdmi 32474 1 - Live 0x0000000000000000
rfcomm 47604 12 - Live 0x0000000000000000
snd_hda_codec_conexant 62311 1 - Live 0x0000000000000000
bnep 18281 2 - Live 0x0000000000000000
joydev 17693 0 - Live 0x0000000000000000
snd_hda_intel 33773 4 - Live 0x0000000000000000
snd_hda_codec 127706 3
snd_hda_codec_hdmi,snd_hda_codec_conexant,snd_hda_intel, Live
0x0000000000000000
snd_hwdep 13668 2 snd_usb_audio,snd_hda_codec, Live 0x0000000000000000
snd_pcm 97188 5
snd_usb_audio,snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec, Live
0x0000000000000000
snd_seq_midi 13324 0 - Live 0x0000000000000000
snd_rawmidi 30748 2 snd_usbmidi_lib,snd_seq_midi, Live 0x0000000000000000
arc4 12529 2 - Live 0x0000000000000000
snd_seq_midi_event 14899 1 snd_seq_midi, Live 0x0000000000000000
psmouse 87692 0 - Live 0x0000000000000000
iwlwifi 332672 0 - Live 0x0000000000000000
dell_laptop 18119 0 - Live 0x0000000000000000
btusb 18288 2 - Live 0x0000000000000000
uvcvideo 72627 0 - Live 0x0000000000000000
videodev 98259 1 uvcvideo, Live 0x0000000000000000
snd_seq 61896 2 snd_seq_midi,snd_seq_midi_event, Live 0x0000000000000000
mei 41616 0 - Live 0x0000000000000000 (C)
serio_raw 13211 0 - Live 0x0000000000000000
v4l2_compat_ioctl32 17128 1 videodev, Live 0x0000000000000000
dell_wmi 12681 0 - Live 0x0000000000000000
snd_timer 29990 2 snd_pcm,snd_seq, Live 0x0000000000000000
snd_seq_device 14540 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 0x0000000000000000
mac80211 506816 1 iwlwifi, Live 0x0000000000000000
snd 78855 19 snd_usb_audio,snd_usbmidi_lib,snd_hda_codec_hdmi,snd_hda_codec_conexant,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_rawmidi,snd_seq,snd_timer,snd_seq_device,
Live 0x0000000000000000
dcdbas 14490 1 dell_laptop, Live 0x0000000000000000
bluetooth 180104 23 rfcomm,bnep,btusb, Live 0x0000000000000000
sparse_keymap 13890 1 dell_wmi, Live 0x0000000000000000
cfg80211 205544 2 iwlwifi,mac80211, Live 0x0000000000000000
soundcore 15091 1 snd, Live 0x0000000000000000
snd_page_alloc 18529 2 snd_hda_intel,snd_pcm, Live 0x0000000000000000
lp 17799 0 - Live 0x0000000000000000
parport 46562 3 parport_pc,ppdev,lp, Live 0x0000000000000000
mac_hid 13253 0 - Live 0x0000000000000000
ums_realtek 18248 0 - Live 0x0000000000000000
usb_storage 49198 1 ums_realtek, Live 0x0000000000000000
uas 18180 0 - Live 0x0000000000000000
atl1c 41717 0 - Live 0x0000000000000000
i915 468737 3 - Live 0x0000000000000000
wmi 19256 1 dell_wmi, Live 0x0000000000000000
drm_kms_helper 46978 1 i915, Live 0x0000000000000000
drm 242038 4 i915,drm_kms_helper, Live 0x0000000000000000
i2c_algo_bit 13423 1 i915, Live 0x0000000000000000
video 19596 1 i915, Live 0x0000000000000000
[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
[X.] Other notes, patches, fixes, workarounds:
https://bugs.launchpad.net/ubuntu/+source/bluez/+bug/972063
