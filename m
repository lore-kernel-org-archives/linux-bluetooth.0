Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: [BUG] unit/test-gatt failure uninitialized pointer(?)
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <2992e569-78e1-ea64-52b5-a2df11a6c948@message-id.googlemail.com>
 <CABBYNZ+90yuLCDhEskujMK0jbqAM=VoGQYj6AQqz=Np8wyEhnw@mail.gmail.com>
 <fa6ffb78-74c9-6797-5a69-c46948341b2a@message-id.googlemail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: Stefan Seyfried <stefan.seyfried@googlemail.com>
Message-ID: <a26a80a9-f727-785b-4baa-62a9dc83bf56@message-id.googlemail.com>
Date: Mon, 29 May 2017 11:06:12 +0200
MIME-Version: 1.0
In-Reply-To: <fa6ffb78-74c9-6797-5a69-c46948341b2a@message-id.googlemail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 29.05.2017 09:14, Stefan Seyfried wrote:
> I did not yet use valgrind inside the OBS build VM, but I can try to do that, that might give additional hints.

/robustness/unkown-request - init
/robustness/unkown-request - setup
/robustness/unkown-request - setup complete
/robustness/unkown-request - run
==12262== Invalid read of size 8
==12262==    at 0x13FF29: timeout_cb (att.c:405)
==12262==    by 0x14C45C: timeout_callback (timeout-glib.c:34)
==12262==    by 0x4E86412: ??? (in /usr/lib64/libglib-2.0.so.0.5200.2)
==12262==    by 0x4E85994: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.5200.2)
==12262==    by 0x4E85D57: ??? (in /usr/lib64/libglib-2.0.so.0.5200.2)
==12262==    by 0x4E86071: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.5200.2)
==12262==    by 0x13FBAB: tester_run (tester.c:830)
==12262==    by 0x13C83D: main (test-gatt.c:4488)
==12262==  Address 0x5a9c970 is 32 bytes inside a block of size 192 free'd
==12262==    at 0x4C2D27B: free (in /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
==12262==    by 0x1414EB: can_read_data (att.c:920)
==12262==    by 0x14C022: watch_callback (io-glib.c:170)
==12262==    by 0x4E85994: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.5200.2)
==12262==    by 0x4E85D57: ??? (in /usr/lib64/libglib-2.0.so.0.5200.2)
==12262==    by 0x4E86071: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.5200.2)
==12262==    by 0x13FBAB: tester_run (tester.c:830)
==12262==    by 0x13C83D: main (test-gatt.c:4488)
==12262==  Block was alloc'd at
==12262==    at 0x4C2C04F: malloc (in /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
==12262==    by 0x13E90D: btd_malloc (util.c:45)
==12262==    by 0x14052E: bt_att_new (att.c:1000)
==12262==    by 0x13E3F1: create_context.constprop.27 (test-gatt.c:670)
==12262==    by 0x13ED57: run_callback (tester.c:415)
==12262==    by 0x4E85994: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.5200.2)
==12262==    by 0x4E85D57: ??? (in /usr/lib64/libglib-2.0.so.0.5200.2)
==12262==    by 0x4E86071: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.5200.2)
==12262==    by 0x13FBAB: tester_run (tester.c:830)
==12262==    by 0x13C83D: main (test-gatt.c:4488)
==12262==
==12262== Invalid read of size 8
==12262==    at 0x13FF39: timeout_cb (att.c:408)
==12262==    by 0x14C45C: timeout_callback (timeout-glib.c:34)
==12262==    by 0x4E86412: ??? (in /usr/lib64/libglib-2.0.so.0.5200.2)
==12262==    by 0x4E85994: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.5200.2)
==12262==    by 0x4E85D57: ??? (in /usr/lib64/libglib-2.0.so.0.5200.2)
==12262==    by 0x4E86071: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.5200.2)
==12262==    by 0x13FBAB: tester_run (tester.c:830)
==12262==    by 0x13C83D: main (test-gatt.c:4488)
==12262==  Address 0x5a9c980 is 48 bytes inside a block of size 192 free'd
==12262==    at 0x4C2D27B: free (in /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
==12262==    by 0x1414EB: can_read_data (att.c:920)
==12262==    by 0x14C022: watch_callback (io-glib.c:170)
==12262==    by 0x4E85994: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.5200.2)
==12262==    by 0x4E85D57: ??? (in /usr/lib64/libglib-2.0.so.0.5200.2)
==12262==    by 0x4E86071: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.5200.2)
==12262==    by 0x13FBAB: tester_run (tester.c:830)
==12262==    by 0x13C83D: main (test-gatt.c:4488)
==12262==  Block was alloc'd at
==12262==    at 0x4C2C04F: malloc (in /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
==12262==    by 0x13E90D: btd_malloc (util.c:45)
==12262==    by 0x14052E: bt_att_new (att.c:1000)
==12262==    by 0x13E3F1: create_context.constprop.27 (test-gatt.c:670)
==12262==    by 0x13ED57: run_callback (tester.c:415)
==12262==    by 0x4E85994: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.5200.2)
==12262==    by 0x4E85D57: ??? (in /usr/lib64/libglib-2.0.so.0.5200.2)
==12262==    by 0x4E86071: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.5200.2)
==12262==    by 0x13FBAB: tester_run (tester.c:830)
==12262==    by 0x13C83D: main (test-gatt.c:4488)
==12262==

it does not crash under valgrind, but also does not finish, I aborted it with ctrl-C after a few minutes.

It seems to hit a 30 seconds timeout btw, if that's of any use:

abuild@susi:~/rpmbuild/BUILD/bluez-5.45> time unit/test-gatt >/dev/null
Segmentation fault (core dumped)

real	0m30.061s
user	0m0.044s
sys	0m0.024s

Hope this sheds some light on the issue.

Best regards,

	Stefan
-- 
Stefan Seyfried

"For a successful technology, reality must take precedence over
 public relations, for nature cannot be fooled." -- Richard Feynman
