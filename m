Return-Path: <tony@atomide.com>
Date: Wed, 23 Jun 2004 09:45:11 -0700
From: Tony Lindgren <tony@atomide.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] AmbiCom BT2000C works with hciattach
Message-ID: <20040623164511.GE9129@atomide.com>
References: <20040623031119.GA20367@atomide.com> <1087976062.4209.61.camel@pegasus> <20040623161414.GA9129@atomide.com> <1088008008.4209.126.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1088008008.4209.126.camel@pegasus>
Sender: <tony@atomide.com>
List-ID: <bluez-devel.lists.sourceforge.net>

* Marcel Holtmann <marcel@holtmann.org> [040623 09:27]:
> Hi Tony,
> 
> > > how good these news are actually depends on what kernel you are using ;)
> > 
> > Using 2.6.7.
> 
> these are good news, because hci_uart and serial_cs are not working very
> nice together with a 2.6 kernel. May you share some more information
> about your system. For example lspci, lsmod etc.

Sure, it's one of these cheapo emachines m6805 amd64 laptops. Running 
64-bit Gentoo testing. Bluez version: hcidump 1.8, bluez libs
2.7. Bluetooth is compiled into the kernel, PCMCIA is not.

# dmesg | grep -i bluetooth
Bluetooth: Core ver 2.5
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: VHCI driver ver 1.1
Bluetooth: HCI UART driver ver 2.1
Bluetooth: HCI H4 protocol initialized
Bluetooth: HCI BCSP protocol initialized
Bluetooth: Broadcom Blutonium firmware driver ver 1.0
Bluetooth: BlueFRITZ! USB driver ver 1.1
Bluetooth: L2CAP ver 2.2
Bluetooth: L2CAP socket layer initialized
Bluetooth: SCO (Voice Link) ver 0.3
Bluetooth: SCO socket layer initialized
Bluetooth: RFCOMM ver 1.3
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: BNEP (Ethernet Emulation) ver 1.0
Bluetooth: BNEP filters: protocol multicast

# cat /proc/cmdline
root=/dev/hda2 ro psmouse.proto=imps apic console=tty0

# cat /proc/interrupts 
           CPU0       
  0:    2959132    IO-APIC-edge  timer
  1:         12    IO-APIC-edge  i8042
  8:          0    IO-APIC-edge  rtc
 10:          0   IO-APIC-level  acpi
 12:         44    IO-APIC-edge  i8042
 14:      15182    IO-APIC-edge  ide0
 15:         19    IO-APIC-edge  ide1
 17:         29   IO-APIC-level  yenta, serial
 18:         27   IO-APIC-level  wifi0
 21:      13975   IO-APIC-level  ehci_hcd, uhci_hcd, uhci_hcd,
 uhci_hcd
 22:          0   IO-APIC-level  VIA8233
 23:       3691   IO-APIC-level  eth0
NMI:       2473 
LOC:    2958687 
ERR:          0
MIS:          0

# lspci
0000:00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 3188 (rev 01)
0000:00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device b188
0000:00:0a.0 CardBus bridge: ENE Technology Inc CB1410 Cardbus Controller
0000:00:0c.0 Network controller: Harris Semiconductor Prism 2.5 Wavelan chipset (rev 01)
0000:00:10.0 USB Controller: VIA Technologies, Inc. USB (rev 80)
0000:00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 80)
0000:00:10.2 USB Controller: VIA Technologies, Inc. USB (rev 80)
0000:00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82)
0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
0000:00:11.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 06)
0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235 AC97 Audio Controller (rev 50)
0000:00:11.6 Communication controller: VIA Technologies, Inc. Intel 537 [AC97 Modem] (rev 80) 0000:00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 74)
0000:00:13.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 80)
0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:01:00.0 VGA compatible controller: ATI Technologies Inc RV350 [Mobility Radeon 9600 M10]

# lsmod
Module                  Size  Used by
serial_cs              11176  1 
8250                   23904  3 serial_cs
serial_core            26560  1 8250
via_rhine              23304  0 
hostap_pci             58716  0 
hostap                124240  1 hostap_pci
yenta_socket           21696  1 
snd_via82xx            31172  0 
snd_ac97_codec         74372  1 snd_via82xx
snd_mpu401_uart         8832  1 snd_via82xx
snd_rawmidi            28196  1 snd_mpu401_uart
snd_seq_oss            36416  0 
snd_seq_midi_event      9472  1 snd_seq_oss
snd_seq                58304  4 snd_seq_oss,snd_seq_midi_event
snd_seq_device          9164  3 snd_rawmidi,snd_seq_oss,snd_seq
snd_pcm_oss            58344  0 
snd_pcm               109388  2 snd_via82xx,snd_pcm_oss
snd_page_alloc         13200  2 snd_via82xx,snd_pcm
snd_timer              28232  2 snd_seq,snd_pcm
snd_mixer_oss          20480  1 snd_pcm_oss
snd                    61096  12
snd_via82xx,snd_ac97_codec,snd_mpu401_uart,snd_rawmidi,snd_seq_oss,snd_seq_midi_event,snd_seq,snd_seq_device,snd_pcm_oss,snd_pcm,snd_timer,snd_mixer_oss
soundcore              12064  1 snd
powernow_k8            12944  0 
processor              19524  1 powernow_k8
