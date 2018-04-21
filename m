Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@kernel.org
Subject: [Bug 199459] New: Bluetooth on BCM43228 with firmware loaded only
 works with disabled Wi-Fi
Date: Sat, 21 Apr 2018 22:45:41 +0000
Message-ID: <bug-199459-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=199459

            Bug ID: 199459
           Summary: Bluetooth on BCM43228 with firmware loaded only works
                    with disabled Wi-Fi
           Product: Drivers
           Version: 2.5
    Kernel Version: 4.14.34
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: krnekit@gmail.com
        Regression: No

I have a laptop with the Broadcom BCM43228 Wi-Fi + Bluetooth and I use the b43
driver for it.

I found, that when I connected a bluetooth speaker (with a microphone), it
works fine in A2DP mode, but in HFP/HSP mode neither playback nor recording
works, though speaker indicates, that it's in HFP/HSP mode. I use a PulseAudio
mixer to switch modes.

I found information, that Broadcom bluetooth chips requires firmware to work in
HFP/HSP mode. And indeed, in the dmesg output I see the following:

bluetooth hci0: Direct firmware load for brcm/BCM20702A1-0489-e046.hcd failed
with error -2
Bluetooth: hci0: BCM: Patch brcm/BCM20702A1-0489-e046.hcd not found

That firmware file should be placed to the /lib/firmware/brcm/ It can be
extracted from a Windows driver and converted using the hex2hcd utility. Also,
ready firmware available here:
https://github.com/winterheart/broadcom-bt-firmware I tried both and they are
the same.

With the firmware both A2DP and HFP/HSP mode works, but more serious issue
arises: when I enable Wi-Fi, Bluetooth fails to connect to speaker (and to
other devices) and cannot even find it during scan. Once I disable the Wi-Fi,
Bluetooth starts to work. Without the firmware they are work fine
simultaneously, only the HFP/HSP support is missing.

I also discovered, the once I copy the firmware an enable the Bluetooth, it
seems like the firmware loaded into the device memory and stay there even after
 reboot. So if I delete the firmware file and reboot my laptop, Bluetooth still
works like the firmware loaded. The only thing that helps to get rid of that is
to suspend my laptop and to resume it back, that seems to load the default
firmware.

With "loaded" firmware I see this in dmesg:

Bluetooth: hci0: Acer Laptop
Bluetooth: hci0: BCM20702A1 (001.002.014) build 1465

After I suspend/resume my laptop, I see thin in dmesg:

Bluetooth: hci0: BCM20702A
Bluetooth: hci0: BCM20702A1 (001.002.014) build 0000

Additional information:

Laptop: Acer Aspire V5-552G
Distribution: Mageia Cauldron x86_64
Kernel: 4.14.34-desktop-1.mga7
Output of `lspci -vv` for the device:

04:00.0 Network controller: Broadcom Limited BCM43228 802.11a/b/g/n
        Subsystem: Foxconn International, Inc. Device e04b
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 17
        Region 0: Memory at f0000000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: <access denied>
        Kernel driver in use: bcma-pci-bridge
        Kernel modules: bcma

-- 
You are receiving this mail because:
You are the assignee for the bug.