Return-Path: <cyrus@holtmann.org>
Message-ID: <1356109042.4447.14.camel@dellpc>
Subject: Bluetooth stack issues across suspend/resume
From: Karl Relton <karllinuxtest.relton@ntlworld.com>
To: linux-bluetooth@vger.kernel.org
Date: Fri, 21 Dec 2012 16:57:22 +0000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With various testing and investigation, it seems that there are 3
different issues that can plague a user who has bluetooth keyboard/mouse
and wants to do a suspend/resume on their computer.

1) On resume, a kernel OOPS in the hidp module in linux 3.3 and above.
  see https://bugzilla.kernel.org/show_bug.cgi?id=50541

  This obviously kills the users system completely (repeatable for me on
vast majority of resumes).


2) If #1 is worked around, then a race in the hci system of the
keyboard/mouse device being deleted/re-added. I can't find a kernel bug
report for it, but this msg is on the case, albeit with a rejected
patch:

  http://www.spinics.net/lists/linux-bluetooth/msg16303.html

  There seem to be various downstream reports - this is one:

   https://bugs.launchpad.net/ubuntu/+source/linux/+bug/888828


3) If you get past 2), then you would hope all would be well. However
now the Xserver refuses to receive events from the re-added
mouse/keyboard.

The Xorg log file reports:

[  2149.898] (**) evdev: Apple Wireless Keyboard: Device:
"/dev/input/event10"
[  2149.898] (WW) evdev: Apple Wireless Keyboard: device file is
duplicate. Ignoring.
[  2149.904] (EE) PreInit returned 8 for "Apple Wireless Keyboard"
[  2149.904] (II) UnloadModule: "evdev"


The reason is discussed by google chrome developers here:

http://code.google.com/p/chromium-os/issues/detail?id=33813

The udev events for the mouse/keyboard removal have their prefix
removed, which means they are ignored by the Xserver.

The google developers are correct - on my system I can see (for Linux
3.7 at least):

KERNEL[2213.152339] remove   /hci0/hci0:46/input14/mouse2 (input)
UDEV  [2213.152975] remove   /hci0/hci0:46/input14/mouse2 (input)
KERNEL[2213.160374] remove   /hci0/hci0:46/input14/event10 (input)
UDEV  [2213.160919] remove   /hci0/hci0:46/input14/event10 (input)


Note with Linux 3.2 the remove events have the full path (back in 3.2 it
all just works for me, btw).


I'm guessing the 3) may be 'deliberate' in the way the driver code is
handling device removal (when the bluetooth adaptor is reset),
'orphaning' the keyboard/mouse devices before they later get properly
removed. It is having an unfortunate effect on the userspace software
that needs them however.

Issues 1) and 2) are certainly problems with the driver itself - making
systems unusable across suspend/resume.


Regards
Karl

