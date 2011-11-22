Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 22 Nov 2011 00:59:04 +0000
Message-ID: <CAKU8hCtjvexS6a9WpvQkcwFDhAagtqRYyFiX2De77ZYOVx8bBw@mail.gmail.com>
Subject: Help troubleshooting Bluetooth on the Asus Zenbook UX31
From: Eran Mes <eran.mes@gmail.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
I'm having trouble getting the built-in Bluetooth module on the Asus
Zenbook UX31 to function: According to hciconfig there is a valid,
active interface. However, no devices are detected when scanning
through the command line / GUI. It's also impossible to establish
connections using 'hci cc <btaddr>' manually (I/O timeout error).

I'll appreciate any advice anyone can provide on how to further troubleshoot.
Basic device info (more info below):
ID 13d3:3375 IMC Networks
  iManufacturer           1 Atheros Communications
  iProduct                2 Bluetooth USB Host Controller
  iSerial                 3 Alaska Day 2006

What I tried:
* verifying with rfkill that all wireless interfaces are enabled.
* Trying out with various kernels: 3.0.0-1, 3.0.4, 3.0.9, 3.1.1
* Looking up for bluetooth issues on other Asus laptops yielded the
suggestion that I should use the 'ath3k' module to load a firmware
first [1] [2] [3].
* Based on the linuxwireless page description on 'AR3011 with SFLASH
configurations' [4], I suspected this is the case with this module as
well.
* I did use the '13d3 3375' identifier rather than '13d3 3304' in the links.
* However, the ath3k fails to load the firmware:
Nov 21 01:01:18 fremkit kernel: [  911.283280] ath3k_load_firmware:
Error in firmware loading err = -110,len = 0, size = 4096
Nov 21 01:01:18 fremkit kernel: [  911.283346] ath3k: probe of
1-1.8:1.0 failed with error -110
* I dug up a different firmware, ath3k-2.fw. That failed loading in a
similar way.

Detailed information about the device:
lsusb dump: http://pastebin.com/KnPNxB61
lspci output: http://pastebin.com/0qAxuqX3
hciconfig output (including features, version, revision):
http://pastebin.com/WzwV028T
dmesg: http://pastebin.com/RsykRfCz
dmesg snippet with firmware loading failure: http://pastebin.com/NnUxsqAu
version of userspace programs: http://pastebin.com/wJuYrqm4

At this point, I could do with help on the following:
* Confirming that this bluetooth module does, indeed, require firmware upload.
* Getting a hold of the firmware file for this module.

I'd be otherwise happy to dig into the kernel's code, if some pointers
can be provided.

Thanks,
Eran

[1] http://www.phlerion.com/blog/2011/02/04/bluetooth-for-exopc-in-ubuntu/
[2] https://help.ubuntu.com/community/Asus_N53#Bluetooth
[3] http://christianleber.blogspot.com/2011/06/asus-s1-s1-at5nm10e-bluetooth-with.html
[4] http://linuxwireless.org/en/users/Drivers/ath3k
