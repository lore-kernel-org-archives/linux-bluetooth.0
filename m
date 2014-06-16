Return-Path: <cyrus@holtmann.org>
Message-ID: <539F80DB.2070707@entiance.com>
Date: Tue, 17 Jun 2014 09:42:19 +1000
From: Russell McLernon <russell@entiance.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Bluetooth on Ubuntu 14.04 uses 100% cpu on HID disconnect
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all, I noticed that bluetoothd was jumping to 100% cpu usage when I 
switch my bluetooth keyboard off.  Then when I turn it back on the CPU 
drops back down.

Details:
Ubuntu 14.04 32bit
bluetoothd 4.101
default kernel 3.13, bluetooth module 2.17

I upgraded to bluetoothd 5.19 and it does the same thing.

here is a backtrace from gdb (bluetoothd 5.19):

#0  0x00007ffff71a8fa0 in __poll_nocancel () at 
../sysdeps/unix/syscall-template.S:81
#1  0x00007ffff7b1afe4 in ?? () from /lib/x86_64-linux-gnu/libglib-2.0.so.0
#2  0x00007ffff7b1b30a in g_main_loop_run () from 
/lib/x86_64-linux-gnu/libglib-2.0.so.0
#3  0x000000000040a983 in ?? ()
#4  0x00007fffffffe748 in ?? ()
#5  0x0000000100000000 in ?? ()
#6  0x00007fff00000001 in ?? ()
#7  0x00007ffff7ffe1c8 in _r_debug ()
#8  0x0000000000000000 in ?? ()
