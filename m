Return-Path: <cyrus@holtmann.org>
Message-ID: <54D4D012.4050108@endlessm.com>
Date: Fri, 06 Feb 2015 14:30:42 +0000
From: Mario Sanchez Prada <mario@endlessm.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: No SCO packets while trying to use a Bluetooth headset
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I have a problem with one Bluetooth host (chipset Realtek RTL8723BE) and a Bluetooth headset (Plantronics M50) I've been trying to find a solution for in the last days, without much success yet:

Basically, I can pair the computer with the headset from my Linux machine, connect to it without trouble and select it as a PulseAudio output sink and input source using the HSP/HFP profile, but then I can not hear any sound coming out of the headphones, nor I can capture any sound with the microphone.

For what I can see with hcidump, there seems to be BT traffic when connecting/disconnecting the headset, but no traffic at all once I try to play any sound through them with paplay, nor when trying to use the microphone.

Also, I've observed that everything works fine if I used an external USB Bluetooth dongle in the same machine instead, which produces a slightly different dump with hcidump while connecting to the headset and then, of course, a lot of traffic once paplay is running (lots of SCO packets), which I can't see with the internal chipset.

See the output of lsusb -vvv too for both devices:
 * lsusb for the internal BT device: http://goo.gl/bvBsr7
 * lsusb for the external BT dongle: http://goo.gl/gNT3oZ

Also, here you can see the verbose logs of hcidump -X for both scenarios:
 * Not working (internal chipset): http://goo.gl/34hzQz
 * Working (external dongle): http://goo.gl/HeZPmM

Besides these tests,  I've also ruled out a problem with the actual hardware by checking that the device actually works as expected when booting into Windows 7 and installing the Realtek drivers: no problems there.

Surprisingly, that experiment with Windows provided me an interesting hint: yesterday morning, after using the headset perfectly in Windows, I've rebooted again into Linux and everything worked just fine there at that point, not sure why. I could see SCO packets being transmitted when using the headset both as an output sink and an input source, meaning I could both play sounds through the headphones and capture data with the microphone.

Unfortunately, it stopped working after I powered off the machine and then powered on back again, and I could not reproduce this working scenario either ever since. So, I sadly don't have any log I can attach here now, but the fact that it worked for a while makes me think whether Windows would not have somehow initialized something in the chipset, or even in the headset itself, that persisted across reboots, going away when powering off.

I'm not sure what that really means, just mentioning in case it rings any bell, because I've heard of other situations where some hardware X would work in Linux after rebooting from Windows, so perhaps this could be the case too? Here you have a dump of the USB/HCI traffic in Windows while installing the Realtek driver and connecting to the headset, as a .pcap file that can be examined with Wireshark: http://goo.gl/u6KBy2

I've being studying all this data for a while already, but my knowledge in this matter is still quite limited and so I'd appreciate a few words of direction from someone more experienced to better know how to proceed now.

Of course, feel free to ask for more information if needed.

Thanks in advance,
Mario

PS: I'm using a Debian based distribution with a 3.13.0 kernel and BlueZ 5.23 as packaged by Ubuntu, although I've tried using the latest 5.28 release as well, but that did not get things any better either.
