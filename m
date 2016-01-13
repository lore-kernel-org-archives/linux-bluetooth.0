Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1452726452.1830.3.camel@redhat.com>
Subject: bluetoothd crash when registering advertisement
From: Nathaniel McCallum <npmccallum@redhat.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Wed, 13 Jan 2016 18:07:32 -0500
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I added advertisement support to my application today:
https://git.fedorahosted.org/cgit/jelling/linux.git/commit/?id=e04016c8
b7f0d406b39573863cf7d5e15dac53ed

When registering the advertisement with bluez, bluetoothd crashes:
#0  0x00007f1f01ce6618 in __GI_raise (sig=sig@entry=6) at
../sysdeps/unix/sysv/linux/raise.c:54
#1  0x00007f1f01ce821a in __GI_abort () at abort.c:89
#2  0x00007f1f024bc894 in _dbus_abort () at ../../dbus/dbus-
sysdeps.c:91
#3  0x00007f1f024b331e in _dbus_warn_check_failed (
    format=0x7f1f024c2d10 "arguments to %s() were incorrect, assertion
\"%s\" failed in file %s line %d.\nThis is normally a bug in some
application using the D-Bus library.\n") at ../../dbus/dbus-
internals.c:275
#4  0x00007f1f024a6c94 in dbus_message_new_method_return
(method_call=<optimized out>) at ../../dbus/dbus-message.c:1378
#5  0x00005609802d0c6b in add_adverting_complete (status=0 '\000',
ad=0x560980d0a490) at src/advertising.c:413
#6  add_advertising_callback (status=0 '\000', length=<optimized out>,
param=<optimized out>, user_data=0x560980d0a490) at
src/advertising.c:441
#7  0x000056098030af96 in request_complete (mgmt=mgmt@entry=0x560980d04
470, status=<optimized out>, opcode=opcode@entry=62, index=index@entry=
0, length=length@entry=1, 
    param=0x560980d044f9) at src/shared/mgmt.c:261
#8  0x000056098030ba5c in can_read_data (io=<optimized out>,
user_data=0x560980d04470) at src/shared/mgmt.c:353
#9  0x0000560980317765 in watch_callback (channel=<optimized out>,
cond=<optimized out>, user_data=<optimized out>) at src/shared/io-
glib.c:170
#10 0x00007f1f0271e0aa in g_main_dispatch (context=0x560980cf1e80) at
gmain.c:3154
#11 g_main_context_dispatch (context=context@entry=0x560980cf1e80) at
gmain.c:3769
#12 0x00007f1f0271e440 in g_main_context_iterate
(context=0x560980cf1e80, block=block@entry=1, dispatch=dispatch@entry=1
, self=<optimized out>) at gmain.c:3840
#13 0x00007f1f0271e762 in g_main_loop_run (loop=0x560980cf1df0) at
gmain.c:4034
#14 0x0000560980290f0d in main (argc=1, argv=0x7ffe09da1ed8) at
src/main.c:687

As this was my first attempt at implementing advertisement support, I
may be doing something wrong. If I am, your tips are appreciated!
However, in any case, bluez shouldn't crash.

Nathaniel
