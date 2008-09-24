Return-Path: <cyrus@holtmann.org>
Subject: bluetoothd crasher
From: Bastien Nocera <hadess@hadess.net>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 24 Sep 2008 16:09:06 -0700
Message-Id: <1222297746.10497.186.camel@snoogens.fab.redhat.com>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Heya,

The current bluetoothd crashes on resume from suspend. Here's the valgrind output:

==10147== 
==10147== Invalid read of size 4
==10147==    at 0x74B739: g_atomic_int_exchange_and_add (in /lib/libglib-2.0.so.0.1800.0)
==10147==    by 0x769011: g_io_channel_unref (in /lib/libglib-2.0.so.0.1800.0)
==10147==    by 0x969E: stop_security_manager (security.c:1022)
==10147==    by 0x8A83: io_stack_event (main.c:567)
==10147==    by 0x7A81CC: (within /lib/libglib-2.0.so.0.1800.0)
==10147==    by 0x7711F7: g_main_context_dispatch (in /lib/libglib-2.0.so.0.1800.0)
==10147==    by 0x7748A2: (within /lib/libglib-2.0.so.0.1800.0)
==10147==    by 0x774DC1: g_main_loop_run (in /lib/libglib-2.0.so.0.1800.0)
==10147==    by 0x9238: main (main.c:761)
==10147==  Address 0x487bcc8 is 0 bytes inside a block of size 64 free'd
==10147==    at 0x480590A: free (vg_replace_malloc.c:323)
==10147==    by 0x779725: g_free (in /lib/libglib-2.0.so.0.1800.0)
==10147==    by 0x7690BC: g_io_channel_unref (in /lib/libglib-2.0.so.0.1800.0)
==10147==    by 0x770BBE: (within /lib/libglib-2.0.so.0.1800.0)
==10147==    by 0x7712C0: g_main_context_dispatch (in /lib/libglib-2.0.so.0.1800.0)
==10147==    by 0x7748A2: (within /lib/libglib-2.0.so.0.1800.0)
==10147==    by 0x774DC1: g_main_loop_run (in /lib/libglib-2.0.so.0.1800.0)
==10147==    by 0x9238: main (main.c:761)
==10147== 
==10147== Invalid read of size 4
==10147==    at 0x74B73B: g_atomic_int_exchange_and_add (in /lib/libglib-2.0.so.0.1800.0)
==10147==    by 0x769011: g_io_channel_unref (in /lib/libglib-2.0.so.0.1800.0)
==10147==    by 0x969E: stop_security_manager (security.c:1022)
==10147==    by 0x8A83: io_stack_event (main.c:567)
==10147==    by 0x7A81CC: (within /lib/libglib-2.0.so.0.1800.0)
==10147==    by 0x7711F7: g_main_context_dispatch (in /lib/libglib-2.0.so.0.1800.0)
==10147==    by 0x7748A2: (within /lib/libglib-2.0.so.0.1800.0)
==10147==    by 0x774DC1: g_main_loop_run (in /lib/libglib-2.0.so.0.1800.0)
==10147==    by 0x9238: main (main.c:761)
==10147==  Address 0x487bcc8 is 0 bytes inside a block of size 64 free'd
==10147==    at 0x480590A: free (vg_replace_malloc.c:323)
==10147==    by 0x779725: g_free (in /lib/libglib-2.0.so.0.1800.0)
==10147==    by 0x7690BC: g_io_channel_unref (in /lib/libglib-2.0.so.0.1800.0)
==10147==    by 0x770BBE: (within /lib/libglib-2.0.so.0.1800.0)
==10147==    by 0x7712C0: g_main_context_dispatch (in /lib/libglib-2.0.so.0.1800.0)
==10147==    by 0x7748A2: (within /lib/libglib-2.0.so.0.1800.0)
==10147==    by 0x774DC1: g_main_loop_run (in /lib/libglib-2.0.so.0.1800.0)
==10147==    by 0x9238: main (main.c:761)
==10147== 
==10147== Invalid write of size 4
==10147==    at 0x74B740: g_atomic_int_exchange_and_add (in /lib/libglib-2.0.so.0.1800.0)
==10147==    by 0x769011: g_io_channel_unref (in /lib/libglib-2.0.so.0.1800.0)
==10147==    by 0x969E: stop_security_manager (security.c:1022)
==10147==    by 0x8A83: io_stack_event (main.c:567)
==10147==    by 0x7A81CC: (within /lib/libglib-2.0.so.0.1800.0)
==10147==    by 0x7711F7: g_main_context_dispatch (in /lib/libglib-2.0.so.0.1800.0)
==10147==    by 0x7748A2: (within /lib/libglib-2.0.so.0.1800.0)
==10147==    by 0x774DC1: g_main_loop_run (in /lib/libglib-2.0.so.0.1800.0)
==10147==    by 0x9238: main (main.c:761)
==10147==  Address 0x487bcc8 is 0 bytes inside a block of size 64 free'd
==10147==    at 0x480590A: free (vg_replace_malloc.c:323)
==10147==    by 0x779725: g_free (in /lib/libglib-2.0.so.0.1800.0)
==10147==    by 0x7690BC: g_io_channel_unref (in /lib/libglib-2.0.so.0.1800.0)
==10147==    by 0x770BBE: (within /lib/libglib-2.0.so.0.1800.0)
==10147==    by 0x7712C0: g_main_context_dispatch (in /lib/libglib-2.0.so.0.1800.0)
==10147==    by 0x7748A2: (within /lib/libglib-2.0.so.0.1800.0)
==10147==    by 0x774DC1: g_main_loop_run (in /lib/libglib-2.0.so.0.1800.0)
==10147==    by 0x9238: main (main.c:761)
bluetoothd[10147]: HCI dev 0 unregistered
bluetoothd[10147]: Unregister path: /org/bluez/hci0
bluetoothd[10147]: HCI dev 0 registered
bluetoothd[10328]: Can't set link policy on hci0: Connection timed out (110)
bluetoothd[10147]: HCI dev 0 up
bluetoothd[10147]: Unable to start SCO server socket

Looks like a double-free on the event channel.

