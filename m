Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1497994305.1739.6.camel@localhost>
Subject: BT Mouse intermittent disconnects
From: bryan@varnernet.com
To: linux-bluetooth@vger.kernel.org
Date: Tue, 20 Jun 2017 17:31:45 -0400
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Greetz.

To start: Just picked up a new laptop with built in BT. woo!

Paired a mouse I've been using with OS X for years. On OS X if it was
idle for a while, it would take a _long_ time to reconnect, and I'd see
the blue 'pairing' light flash a few times.


So with the new laptop on Linux 4.11.6 (and 4.9.30 -- from debian 9)
i'm seeing the following end-user behavior:

While using the mouse to interact with the system, it will just
disconnect and repair. I can be in the middle of a window drag, and it
drops.

I've spent the last day or so doing all the input driver debugging to
rule out:
    * HID driver issues
    * USB Power Management

I've tried using HIDP in the kernel, UHID out of kernel.
What I saw from uhid was that the read() call would return '0',
resulting in a 'disconnect reason 2'. In kernel mode, it's a bit less
verbose about things.

Since I'd rather not dump btmon dumps into the mailing list, here's a
link to the raw output of a mon session when the issue occurs.

https://pastebin.com/raw/x7nMmL0p


I'm pretty much a newb when it comes to BT stuff, but from the looks of
it, things seem to regularly go wonky when there's a sniff mode
transition.

I also have a BT keyboard that likkkkkkes to occccasssssssssssionally
expresssss a desire to stiiiiiiick. I didn't have the keyboard paired
(or powered on) during the above session. I've been unable to find a
reason for the keyboard to be acting funny.

What can I do to improve the situation for myself and others?

Can you folks point me in the right direction to try to troubleshoot /
understand / fix this?

Regards,
-Bryan



