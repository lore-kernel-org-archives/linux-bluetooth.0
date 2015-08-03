Return-Path: <cyrus@holtmann.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 73081] Fail to setup Bluetooth on Dell Venue 11 Pro
Date: Mon, 03 Aug 2015 20:06:03 +0000
Message-ID: <bug-73081-62941-uxaG34jEzk@https.bugzilla.kernel.org/>
In-Reply-To: <bug-73081-62941@https.bugzilla.kernel.org/>
References: <bug-73081-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=73081

Dmitry Khromov <icechrome@gmail.com> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |icechrome@gmail.com

--- Comment #1 from Dmitry Khromov <icechrome@gmail.com> ---
Same here, on Venue 8 Pro.
Actually, the protocol Windows is using is H4, nevertheless, it doesn't work
also.
This snippet from DSDT table (BTH0 entry, DLAC3002) specifies the UART settings
that Windows (supposedly) uses:
UartSerialBus (0x0001C200, DataBitsEight, StopBitsOne, 0xC0, LittleEndian,
ParityTypeNone, FlowControlHardware, 0x0020, 0x0020, "\\_SB.URT1", 0x00,
ResourceConsumer, ,)
URT1 is /dev/ttyS4 in my config, the interesting thing is that there's no bytes
inbound at all - looks like the BT module is simply unpowered, no matter if I
attach an rfkill-gpio (like Jin above), or drive GPIOs manually (via
/sys/bus/gpio).
So, it's unlikely a kernel bug (and may be closed as such).

Jin. had you ever succeed in getting this piece working?

-- 
You are receiving this mail because:
You are the assignee for the bug.
