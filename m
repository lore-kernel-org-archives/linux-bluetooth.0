Return-Path: <cyrus@holtmann.org>
Date: Sun, 7 Sep 2008 04:01:34 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: linux-bluetooth@vger.kernel.org
Cc: bugme-daemon@bugzilla.kernel.org, kernel6org@pook.es
Subject: Re: [Bugme-new] [Bug 11514] New: bluetooth headset works with
 2.6.26, only hisses with 2.6.27-rc5
Message-Id: <20080907040134.732f925c.akpm@linux-foundation.org>
In-Reply-To: <bug-11514-10286@http.bugzilla.kernel.org/>
References: <bug-11514-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


(switched to email.  Please respond via emailed reply-to-all, not via the
bugzilla web interface).

On Sun,  7 Sep 2008 03:33:23 -0700 (PDT) bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=11514
> 
>            Summary: bluetooth headset works with 2.6.26, only hisses with
>                     2.6.27-rc5
>            Product: Drivers
>            Version: 2.5
>      KernelVersion: 2.6.27-rc5
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: Bluetooth
>         AssignedTo: drivers_bluetooth@kernel-bugs.osdl.org
>         ReportedBy: kernel6org@pook.es
> 
> 
> Latest working kernel version: 2.6.26-1-686 (Debian)
> Earliest failing kernel version: 2.6.27-rc5 (vanilla)

A post-2.6.26 regression.

> Distribution: Debian
> Hardware Environment: Intel Core2 Duo CPU E6550
> Software Environment: Debian unstable + bluez-4.4
> Problem Description: my Jabra JX10 bluetooth works with 2.6.26-1-686 and
> bluez-4.4. With 2.6.27-rc5 (btusb) it only hisses.
> 
> Steps to reproduce: install bluez-4.4 http://www.bluez.org/ and
> add the following to ~/.asoundrc
> pcm.JX10 {
>         type bluetooth
>         device "00:1A:45:2F:49:98" # Jabra JX10 series 2
> }
> as root run bluetoothd -dn
> run aplay -D JX10 alarm.wav
> 
> with 2.6.26-1-686 I could hear the music, now I just hear a soft hiss during 40
> seconds and then get an error message.
> 
> hcitool shows 2 connections during the 40 seconds:
> :; hcitool con
> Connections:
>         < SCO 00:1A:45:2F:49:98 handle 44 state 1 lm SLAVE 
>         < ACL 00:1A:45:2F:49:98 handle 41 state 1 lm MASTER 
> 
> In /var/log/kern.log
> 
> Sep  7 12:16:08 kooka kernel: [ 1250.901715] Bluetooth: SCO (Voice Link) ver
> 0.6
> Sep  7 12:16:08 kooka kernel: [ 1250.901719] Bluetooth: SCO socket layer
> initialized
> 
> in /var/log/kern.log I sometimes see 
> hci_scodata_packet: hci0 SCO packet for unknown connection handle 44
> btusb_isoc_complete: hci0 corrupted SCO packet
> 
> :; aplay -vvv -D JX10 lib/alarm.wav 
> Playing WAVE 'lib/alarm.wav' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono
> aplay: set_params:979: Unable to install hw params:
> ACCESS:  RW_INTERLEAVED
> FORMAT:  S16_LE
> SUBFORMAT:  STD
> SAMPLE_BITS: 16
> FRAME_BITS: 16
> CHANNELS: 1
> RATE: 8000
> PERIOD_TIME: 125000
> PERIOD_SIZE: 1000
> PERIOD_BYTES: 2000
> PERIODS: 4
> BUFFER_TIME: 500000
> BUFFER_SIZE: 4000
> BUFFER_BYTES: 8000
> TICK_TIME: [0 0]
> 
> bluetoothd says
> 
> bluetoothd[4944]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98:
> HEADSET_STATE_CONNECTED -> HEADSET_STATE_PLAY_IN_PROGRESS
> bluetoothd[4944]: Received AT+VGS=15
> bluetoothd[4944]: connect(): Connection timed out (110)
> bluetoothd[4944]: Audio API: sending BT_SETCONFIGURATION_RSP
> bluetoothd[4944]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98:
> HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_CONNECTED
> 
> :; /usr/local/sbin/hciconfig hci0 version
> hci0:   Type: USB
>         BD Address: 00:0C:41:E1:FF:30 ACL MTU: 192:8 SCO MTU: 64:8
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver: 0x20d
>         Manufacturer: Cambridge Silicon Radio (10)
> :; /usr/local/sbin/hciconfig hci0
> hci0:   Type: USB
>         BD Address: 00:0C:41:E1:FF:30 ACL MTU: 192:8 SCO MTU: 64:8
>         UP RUNNING 
>         RX bytes:666323 acl:16 sco:13034 events:64 errors:0
>         TX bytes:910 acl:19 sco:0 commands:33 errors:0
> :; /usr/local/sbin/hciconfig hci0 features
> hci0:   Type: USB
>         BD Address: 00:0C:41:E1:FF:30 ACL MTU: 192:8 SCO MTU: 64:8
>         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
>                 <3-slot packets> <5-slot packets> <encryption> <slot offset> 
>                 <timing accuracy> <role switch> <hold mode> <sniff mode> 
>                 <park state> <RSSI> <channel quality> <SCO link> <HV2 packets> 
>                 <HV3 packets> <u-law log> <A-law log> <CVSD> <paging scheme> 
>                 <power control> <transparent SCO> 
> :; lsusb | grep Blue
> Bus 001 Device 003: ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth Dongle
> (HCI mode)
> :; hcitool info  $JX10
> Requesting information ...
>         BD Address:  00:1A:45:2F:49:98
>         Device Name: Jabra JX10 series 2
>         LMP Version: 2.0 (0x3) LMP Subversion: 0x106e
>         Manufacturer: Cambridge Silicon Radio (10)
>         Features: 0xbf 0xfe 0x8b 0xf8 0x1b 0x18 0x00 0x80
>                 <3-slot packets> <5-slot packets> <encryption> <slot offset> 
>                 <timing accuracy> <role switch> <sniff mode> <RSSI> 
>                 <channel quality> <SCO link> <HV2 packets> <HV3 packets> 
>                 <u-law log> <A-law log> <CVSD> <paging scheme> 
>                 <transparent SCO> <broadcast encrypt> <enhanced iscan> 
>                 <interlaced iscan> <interlaced pscan> <inquiry with RSSI> 
>                 <extended SCO> <EV4 packets> <EV5 packets> <AFH cap. slave> 
>                 <AFH class. slave> <AFH cap. master> <AFH class. master> 
>                 <extended features> 
> :; sdptool records  00:1A:45:2F:49:98
> Service Name: Hands-Free unit
> Service RecHandle: 0x10000
> Service Class ID List:
>   "Handsfree" (0x111e)
>   "Generic Audio" (0x1203)
> Protocol Descriptor List:
>   "L2CAP" (0x0100)
>   "RFCOMM" (0x0003)
>     Channel: 1
> Language Base Attr List:
>   code_ISO639: 0x656e
>   encoding:    0x6a
>   base_offset: 0x100
> Profile Descriptor List:
>   "Handsfree" (0x111e)
>     Version: 0x0105
> 
> Service Name: Headset
> Service RecHandle: 0x10001
> Service Class ID List:
>   "Headset" (0x1108)
>   "Generic Audio" (0x1203)
> Protocol Descriptor List:
>   "L2CAP" (0x0100)
>   "RFCOMM" (0x0003)
>     Channel: 2
> Language Base Attr List:
>   code_ISO639: 0x656e
>   encoding:    0x6a
>   base_offset: 0x100
> Profile Descriptor List:
>   "Headset" (0x1108)
>     Version: 0x0100
> 
> :; lsmod | grep usb
> usb_storage            77960  1 
> snd_usb_audio          72288  0 
> snd_usb_lib            15168  1 snd_usb_audio
> snd_rawmidi            20512  2 snd_usb_lib,snd_seq_midi
> snd_hwdep               8004  1 snd_usb_audio
> usbhid                 37924  0 
> hid                    35660  1 usbhid
> ff_memless              6216  1 usbhid
> btusb                  11864  3 
> bluetooth              49184  9 sco,bnep,rfcomm,l2cap,btusb
> snd_pcm                64708  2 snd_usb_audio,snd_hda_intel
> snd                    47480  10
> snd_usb_audio,snd_seq_oss,snd_seq,snd_rawmidi,snd_seq_device,snd_hwdep,snd_hda_intel,snd_mixer_oss,snd_pcm,snd_timer
> 
> :; lsmod | grep hcd
> uhci_hcd               20816  0 
> 
> Note that I have removed ehci_hcd because it seems to cause problems with
> 2.6.27-rc5. More on that later :-(
> 

