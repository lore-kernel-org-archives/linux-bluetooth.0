Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: 'BlueZ devel list' <linux-bluetooth@vger.kernel.org>
Cc: 'Bharat Bhusan Panda' <bharat.panda@samsung.com>
Subject: Found few memory leaks in gatt-client
Date: Thu, 02 Apr 2015 15:31:40 +0530
Message-id: <000a01d06d2c$05c04660$1140d320$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

Found few memory leaks when testing the prepare write and execute write
using btgatt-client tool with PTS 6.0.1. Below are the logs for the same.

~/latest_bluez/bluez$  MALLOC_CHECK_=3 MALLOC_PERTURB_=69 valgrind
--trace-children=yes --track-origins=yes --show-possibly-lost=no
--leak-check=full -v ./tools/btgatt-client -i hci0 -d 00:1B:DC:07:33:4E

[GATT client]# write-prepare -s 0 0x00cd 00 00 03
--18895-- REDIR: 0x4ec2c10 (memchr) redirected to 0x4c2f390 (memchr)
--18895-- REDIR: 0x4ec8780 (__GI_memcpy) redirected to 0x4c2fc90
(__GI_memcpy)
--18895-- REDIR: 0x4ebe070 (strcmp) redirected to 0x4a25720
(_vgnU_ifunc_wrapper)
--18895-- REDIR: 0x4eced20 (__strcmp_sse2_unaligned) redirected to 0x4c2f1b0
(strcmp)
Prepare write success.
Session id: 1 to be used on next write
[GATT client]# Write successful
[GATT client]# write-execute 1 1 
[GATT client]# 
Write successful
[GATT client]# ^C

Shutting down...
==18895== 
==18895== HEAP SUMMARY:
==18895==     in use at exit: 2,862 bytes in 86 blocks
==18895==   total heap usage: 1,305 allocs, 1,219 frees, 49,976 bytes
allocated
==18895== 
==18895== Searching for pointers to 86 not-freed blocks
==18895== Checked 91,288 bytes
==18895== 
==18895== 46 (40 direct, 6 indirect) bytes in 1 blocks are definitely lost
in loss record 2 of 4
==18895==    at 0x4C2CC70: calloc (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==18895==    by 0x4093E0: bt_gatt_client_prepare_write (gatt-client.c:2690)
==18895==    by 0x4031A7: cmd_write_prepare (btgatt-client.c:1015)
==18895==    by 0x4028F0: prompt_read_cb (btgatt-client.c:1402)
==18895==    by 0x40C7B2: mainloop_run (mainloop.c:157)
==18895==    by 0x401FC4: main (btgatt-client.c:1658)
==18895== 
==18895== 2,656 bytes in 83 blocks are definitely lost in loss record 4 of 4
==18895==    at 0x4C2AB80: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==18895==    by 0x40C8D9: mainloop_add_timeout (mainloop.c:327)
==18895==    by 0x40C342: timeout_add (timeout-mainloop.c:69)
==18895==    by 0x404AE2: can_write_data (att.c:504)
==18895==    by 0x40BEDE: io_callback (io-mainloop.c:138)
==18895==    by 0x40C7B2: mainloop_run (mainloop.c:157)
==18895==    by 0x401FC4: main (btgatt-client.c:1658)
==18895== 
==18895== LEAK SUMMARY:
==18895==    definitely lost: 2,696 bytes in 84 blocks
==18895==    indirectly lost: 6 bytes in 1 blocks
==18895==      possibly lost: 0 bytes in 0 blocks
==18895==    still reachable: 160 bytes in 1 blocks
==18895==         suppressed: 0 bytes in 0 blocks
==18895== Reachable blocks (those to which a pointer was found) are not
shown.
==18895== To see them, rerun with: --leak-check=full --show-leak-kinds=all
==18895== 
==18895== ERROR SUMMARY: 2 errors from 2 contexts (suppressed: 0 from 0)
==18895== ERROR SUMMARY: 2 errors from 2 contexts (suppressed: 0 from 0)

git - up-to-date
gcc - 4.9.2

Regards
Gowtham Anandha Babu

