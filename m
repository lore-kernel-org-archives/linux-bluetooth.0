Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Mark Spruiell <mes@zeroc.com>
Date: Wed, 31 May 2017 10:53:24 -0700
Message-ID: <CABOZqngNPTEnvJvtvLn0UcTsGt7+Tsorptjav2ohAyDaUYTY5A@mail.gmail.com>
Subject: Segfault in BlueZ 5.45
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I built BlueZ 5.45 from source on Ubuntu 16.04 and ran the daemon in
the foreground with

$ sudo src/bluetoothd -d -n

I then ran a program that uses the ConnectProfile API to connect to
another device. It succeeds most of the time but occasionally crashes
with a segfault. Here is the stack trace:

#0  sprintf (__fmt=<optimized out>, __s=<optimized out>) at
/usr/include/x86_64-linux-gnu/bits/stdio2.h:33
#1  ba2str (ba=0x5f46305f43445f52, str=str@entry=0x7fffdeb4c350 "") at
lib/bluetooth.c:79
#2  0x0000000000469ac3 in update_bredr_services
(req=req@entry=0x23a59c0, recs=recs@entry=0x23a60e0)
    at src/device.c:4305
#3  0x000000000046a1d2 in browse_cb (recs=0x23a60e0, err=0,
user_data=0x23a59c0) at src/device.c:4536
#4  0x0000000000447403 in search_completed_cb (type=<optimized out>,
status=<optimized out>, rsp=<optimized out>,
    size=<optimized out>, user_data=0x23a0810) at src/sdp-client.c:205
#5  0x000000000047a88d in sdp_process (session=<optimized out>) at
lib/sdp.c:4354
#6  0x0000000000447545 in search_process_cb (chan=<optimized out>,
cond=<optimized out>, user_data=0x23a0810)
    at src/sdp-client.c:230
#7  0x00007f8cbe0b704a in g_main_context_dispatch () from
/lib/x86_64-linux-gnu/libglib-2.0.so.0
#8  0x00007f8cbe0b73f0 in ?? () from /lib/x86_64-linux-gnu/libglib-2.0.so.0
#9  0x00007f8cbe0b7712 in g_main_loop_run () from
/lib/x86_64-linux-gnu/libglib-2.0.so.0
#10 0x000000000040b38e in main (argc=1, argv=0x7fffdeb4e898) at src/main.c:708

The call to ConnectProfile is always to the same remote device
address, which is paired and trusted.

I tried it with BlueZ 5.44 and got a crash similar to this report:

http://marc.info/?l=linux-bluetooth&m=149286683912995&w=2

Here is the stack trace from 5.44:

#0  browse_cb (recs=0xc78d90, err=0, user_data=0xc77510) at src/device.c:4523
#1  0x0000000000447423 in search_completed_cb (type=<optimized out>,
status=<optimized out>, rsp=<optimized out>,
    size=<optimized out>, user_data=0xc6dcc0) at src/sdp-client.c:205
#2  0x000000000047a65d in sdp_process (session=<optimized out>) at
lib/sdp.c:4354
#3  0x0000000000447565 in search_process_cb (chan=<optimized out>,
cond=<optimized out>, user_data=0xc6dcc0)
    at src/sdp-client.c:230
#4  0x00007f1cfa74b04a in g_main_context_dispatch () from
/lib/x86_64-linux-gnu/libglib-2.0.so.0
#5  0x00007f1cfa74b3f0 in ?? () from /lib/x86_64-linux-gnu/libglib-2.0.so.0
#6  0x00007f1cfa74b712 in g_main_loop_run () from
/lib/x86_64-linux-gnu/libglib-2.0.so.0
#7  0x000000000040b38e in main (argc=1, argv=0x7ffd26bdf7f8) at src/main.c:708

This problem has not occurred yet with BlueZ 5.43.

Let me know if you need any other information.

Thanks,
Mark
