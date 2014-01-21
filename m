Return-Path: <cyrus@holtmann.org>
Message-ID: <52DE5ADD.2050904@ahsoftware.de>
Date: Tue, 21 Jan 2014 12:32:45 +0100
From: Alexander Holler <holler@ahsoftware.de>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: unknown main item tag 0x0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I can't remember since when I'm seeing the kernel message "unknown main 
item tag 0x0" for many Bluetooth input devices, but it is since quiet 
some time.

Has someone already tried to find out where that does come from?

My first guess would be that bluez misses one or more bytes a connection 
startup, which is based on the fact that, since ever, it misses the 
first keystroke of BT-keyboards too (the keystroke which wakes up the 
keyboard and initiates the connection). And I'm pretty sure my keyboard 
does transmit that initiating keystroke, because Windows receives it. ;)

Besides that, that guess isn't based on anything. I neither have tried 
to search through the source nor did I run some tests.

But because I'm curious I can't completely ignore that kernel message, 
even if I haven't experienced any obvious problems. So here is the 
question if someone else has a pointer or has already searched what the 
reason for that message is. I don't think it's a fault of the used 
device(s), as I see this message for multiple bt-input-devices.

Regards,

Alexander Holler
