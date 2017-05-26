Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
From: Stefan Seyfried <stefan.seyfried@googlemail.com>
Subject: [BUG] unit/test-gatt failure uninitialized pointer(?)
Message-ID: <2992e569-78e1-ea64-52b5-a2df11a6c948@message-id.googlemail.com>
Date: Fri, 26 May 2017 09:45:18 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

in the Open Build Service packages for openSUSE are built in VMs without network connection. This leads to failure in "make check". Debugging found:

/robustness/unkown-request - init
/robustness/unkown-request - setup
/robustness/unkown-request - setup complete
/robustness/unkown-request - run

Program received signal SIGSEGV, Segmentation fault.
0x0000555555598225 in timeout_cb (user_data=0x5555557c82f0) at src/shared/att.c:405
405             if (att->pending_req && att->pending_req->id == timeout->id) {
(gdb) print att->pending_req->id
Cannot access memory at address 0x4545454545454545
(gdb) print att->pending_req  
$1 = (struct att_send_op *) 0x4545454545454545
(gdb) print timeout->id
$2 = 12
(gdb) bt
#0  0x0000555555598225 in timeout_cb (user_data=0x5555557c82f0) at src/shared/att.c:405
#1  0x00005555555a499d in timeout_callback (user_data=<optimized out>) at src/shared/timeout-glib.c:34
#2  0x00007ffff7b101d3 in ?? () from /usr/lib64/libglib-2.0.so.0
#3  0x00007ffff7b0f75a in g_main_context_dispatch () from /usr/lib64/libglib-2.0.so.0
#4  0x00007ffff7b0fb10 in ?? () from /usr/lib64/libglib-2.0.so.0
#5  0x00007ffff7b0fe32 in g_main_loop_run () from /usr/lib64/libglib-2.0.so.0
#6  0x0000555555597e84 in tester_run () at src/shared/tester.c:830
#7  0x0000555555594a4c in main (argc=<optimized out>, argv=<optimized out>) at unit/test-gatt.c:4474
(gdb) 

This started after I tried to update the package to bluez-5.45, it
still happens with current bluez git master.

Hope this helps, I am now commenting out this test for now.
-- 
Stefan Seyfried

"For a successful technology, reality must take precedence over
 public relations, for nature cannot be fooled." -- Richard Feynman
