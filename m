Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: multipart/mixed; boundary="===============5562411942861578980=="
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Message-ID: <150361093443.32113.1085159792572233585@david-x220.localdomain>
From: =?utf-8?b?RGF2aWQgxIxlcGVsw61r?= <d@dcepelik.cz>
Subject: BlueZ segfault with a Jolla phone
Date: Thu, 24 Aug 2017 23:42:14 +0200
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--===============5562411942861578980==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello BlueZ devs,

I have run into a segfault trying to connect to a Jolla
phone today.

I am using BlueZ 5.46 as packaged for Arch Linux. I have
recompiled the package with debug symbols and ran in gdb
and Valgrind. The gdb backtrace and Valgrind output are
attached.

The question is, given the number of errors reported by
Valgrind, am I looking for a single bug, or is BlueZ
rather cavalier when it comes to memory safety?
(No offense, just asking.)

From=20what I was able to find out, the problem is that
bluetoothd attempts to print an adapter's address in ba2str,
but the argument it gets is rubbish. More precisely, in

        ba2str(btd_adapter_get_address(device->adapter), srcaddr);

device->adapter contains random data.

I'd like to find the issue, any help is appreciated.

                              -- David

--===============5562411942861578980==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="backtrace"
Content-Disposition: attachment; filename="backtrace"

(gdb) bt
#0  ba2str (ba=3D0x10, str=3Dstr@entry=3D0x7fffffffbef0 "\200Q3") at lib/bl=
uetooth.c:79
#1  0x000000010007ce95 in update_bredr_services (req=3Dreq@entry=3D0x100302=
dd0, =

    recs=3Drecs@entry=3D0x1003369b0) at src/device.c:4356
#2  0x000000010007d625 in browse_cb (recs=3D0x1003369b0, err=3D0, user_data=
=3D0x100302dd0)
    at src/device.c:4587
#3  0x00000001000578e0 in search_completed_cb (type=3D<optimized out>, =

    status=3D<optimized out>, rsp=3D<optimized out>, size=3D<optimized out>=
, =

    user_data=3D0x100300db0) at src/sdp-client.c:205
#4  0x000000010008dc2a in sdp_process (session=3D<optimized out>) at lib/sd=
p.c:4354
#5  0x0000000100057a36 in search_process_cb (chan=3D<optimized out>, =

    cond=3D<optimized out>, user_data=3D<optimized out>) at src/sdp-client.=
c:230
#6  0x00007f03896fb8c5 in g_main_context_dispatch () from /usr/lib/libglib-=
2.0.so.0
#7  0x00007f03896fbc88 in ?? () from /usr/lib/libglib-2.0.so.0
#8  0x00007f03896fbfa2 in g_main_loop_run () from /usr/lib/libglib-2.0.so.0
#9  0x0000000100017e0c in main (argc=3D<optimized out>, argv=3D<optimized o=
ut>)
    at src/main.c:733

--===============5562411942861578980==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="valgrind-errors"
Content-Disposition: attachment; filename="valgrind-errors"

=3D=3D30400=3D=3D Memcheck, a memory error detector
=3D=3D30400=3D=3D Copyright (C) 2002-2017, and GNU GPL'd, by Julian Seward =
et al.
=3D=3D30400=3D=3D Using Valgrind-3.13.0 and LibVEX; rerun with -h for copyr=
ight info
=3D=3D30400=3D=3D Command: /usr/lib/bluetooth/bluetoothd
=3D=3D30400=3D=3D =

=3D=3D30400=3D=3D Invalid read of size 8
=3D=3D30400=3D=3D    at 0x1855EA: browse_cb (device.c:4573)
=3D=3D30400=3D=3D    by 0x15F8DF: search_completed_cb (sdp-client.c:205)
=3D=3D30400=3D=3D    by 0x195C29: sdp_process (sdp.c:4354)
=3D=3D30400=3D=3D    by 0x15FA35: search_process_cb (sdp-client.c:230)
=3D=3D30400=3D=3D    by 0x4E828C4: g_main_context_dispatch (in /usr/lib/lib=
glib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82C87: ??? (in /usr/lib/libglib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82FA1: g_main_loop_run (in /usr/lib/libglib-2.0=
.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x11FE0B: main (main.c:733)
=3D=3D30400=3D=3D  Address 0x6c91428 is 8 bytes inside a block of size 64 f=
ree'd
=3D=3D30400=3D=3D    at 0x4C2D16B: free (in /usr/lib/valgrind/vgpreload_mem=
check-amd64-linux.so)
=3D=3D30400=3D=3D    by 0x1830B8: gatt_client_ready_cb (device.c:4692)
=3D=3D30400=3D=3D    by 0x1A57BE: notify_client_ready.part.11 (gatt-client.=
c:1129)
=3D=3D30400=3D=3D    by 0x1A352F: discovery_op_complete (gatt-client.c:379)
=3D=3D30400=3D=3D    by 0x1A4078: discover_primary_cb (gatt-client.c:1101)
=3D=3D30400=3D=3D    by 0x1ACDC6: discovery_op_complete (gatt-helpers.c:628)
=3D=3D30400=3D=3D    by 0x1ACFF8: read_by_grp_type_cb (gatt-helpers.c:730)
=3D=3D30400=3D=3D    by 0x1A2DA0: handle_rsp (att.c:707)
=3D=3D30400=3D=3D    by 0x1A2DA0: can_read_data (att.c:879)
=3D=3D30400=3D=3D    by 0x1ABCD2: watch_callback (io-glib.c:170)
=3D=3D30400=3D=3D    by 0x4E828C4: g_main_context_dispatch (in /usr/lib/lib=
glib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82C87: ??? (in /usr/lib/libglib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82FA1: g_main_loop_run (in /usr/lib/libglib-2.0=
.so.0.5200.3)
=3D=3D30400=3D=3D  Block was alloc'd at
=3D=3D30400=3D=3D    at 0x4C2DF55: calloc (in /usr/lib/valgrind/vgpreload_m=
emcheck-amd64-linux.so)
=3D=3D30400=3D=3D    by 0x4E88080: g_malloc0 (in /usr/lib/libglib-2.0.so.0.=
5200.3)
=3D=3D30400=3D=3D    by 0x17DF2D: browse_request_new.part.26 (device.c:5016)
=3D=3D30400=3D=3D    by 0x17DFCD: browse_request_new (device.c:5013)
=3D=3D30400=3D=3D    by 0x17DFCD: device_browse_sdp (device.c:5116)
=3D=3D30400=3D=3D    by 0x182A31: connect_profiles (device.c:1772)
=3D=3D30400=3D=3D    by 0x19AA5A: process_message.isra.6 (object.c:259)
=3D=3D30400=3D=3D    by 0x51708D2: ??? (in /usr/lib/libdbus-1.so.3.14.11)
=3D=3D30400=3D=3D    by 0x5161F53: dbus_connection_dispatch (in /usr/lib/li=
bdbus-1.so.3.14.11)
=3D=3D30400=3D=3D    by 0x197150: message_dispatch (mainloop.c:72)
=3D=3D30400=3D=3D    by 0x4E828C4: g_main_context_dispatch (in /usr/lib/lib=
glib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82C87: ??? (in /usr/lib/libglib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82FA1: g_main_loop_run (in /usr/lib/libglib-2.0=
.so.0.5200.3)
=3D=3D30400=3D=3D =

=3D=3D30400=3D=3D Invalid read of size 4
=3D=3D30400=3D=3D    at 0x185610: browse_cb (device.c:4579)
=3D=3D30400=3D=3D    by 0x15F8DF: search_completed_cb (sdp-client.c:205)
=3D=3D30400=3D=3D    by 0x195C29: sdp_process (sdp.c:4354)
=3D=3D30400=3D=3D    by 0x15FA35: search_process_cb (sdp-client.c:230)
=3D=3D30400=3D=3D    by 0x4E828C4: g_main_context_dispatch (in /usr/lib/lib=
glib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82C87: ??? (in /usr/lib/libglib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82FA1: g_main_loop_run (in /usr/lib/libglib-2.0=
.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x11FE0B: main (main.c:733)
=3D=3D30400=3D=3D  Address 0x6c91450 is 48 bytes inside a block of size 64 =
free'd
=3D=3D30400=3D=3D    at 0x4C2D16B: free (in /usr/lib/valgrind/vgpreload_mem=
check-amd64-linux.so)
=3D=3D30400=3D=3D    by 0x1830B8: gatt_client_ready_cb (device.c:4692)
=3D=3D30400=3D=3D    by 0x1A57BE: notify_client_ready.part.11 (gatt-client.=
c:1129)
=3D=3D30400=3D=3D    by 0x1A352F: discovery_op_complete (gatt-client.c:379)
=3D=3D30400=3D=3D    by 0x1A4078: discover_primary_cb (gatt-client.c:1101)
=3D=3D30400=3D=3D    by 0x1ACDC6: discovery_op_complete (gatt-helpers.c:628)
=3D=3D30400=3D=3D    by 0x1ACFF8: read_by_grp_type_cb (gatt-helpers.c:730)
=3D=3D30400=3D=3D    by 0x1A2DA0: handle_rsp (att.c:707)
=3D=3D30400=3D=3D    by 0x1A2DA0: can_read_data (att.c:879)
=3D=3D30400=3D=3D    by 0x1ABCD2: watch_callback (io-glib.c:170)
=3D=3D30400=3D=3D    by 0x4E828C4: g_main_context_dispatch (in /usr/lib/lib=
glib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82C87: ??? (in /usr/lib/libglib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82FA1: g_main_loop_run (in /usr/lib/libglib-2.0=
.so.0.5200.3)
=3D=3D30400=3D=3D  Block was alloc'd at
=3D=3D30400=3D=3D    at 0x4C2DF55: calloc (in /usr/lib/valgrind/vgpreload_m=
emcheck-amd64-linux.so)
=3D=3D30400=3D=3D    by 0x4E88080: g_malloc0 (in /usr/lib/libglib-2.0.so.0.=
5200.3)
=3D=3D30400=3D=3D    by 0x17DF2D: browse_request_new.part.26 (device.c:5016)
=3D=3D30400=3D=3D    by 0x17DFCD: browse_request_new (device.c:5013)
=3D=3D30400=3D=3D    by 0x17DFCD: device_browse_sdp (device.c:5116)
=3D=3D30400=3D=3D    by 0x182A31: connect_profiles (device.c:1772)
=3D=3D30400=3D=3D    by 0x19AA5A: process_message.isra.6 (object.c:259)
=3D=3D30400=3D=3D    by 0x51708D2: ??? (in /usr/lib/libdbus-1.so.3.14.11)
=3D=3D30400=3D=3D    by 0x5161F53: dbus_connection_dispatch (in /usr/lib/li=
bdbus-1.so.3.14.11)
=3D=3D30400=3D=3D    by 0x197150: message_dispatch (mainloop.c:72)
=3D=3D30400=3D=3D    by 0x4E828C4: g_main_context_dispatch (in /usr/lib/lib=
glib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82C87: ??? (in /usr/lib/libglib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82FA1: g_main_loop_run (in /usr/lib/libglib-2.0=
.so.0.5200.3)
=3D=3D30400=3D=3D =

=3D=3D30400=3D=3D Invalid read of size 8
=3D=3D30400=3D=3D    at 0x184E47: update_bredr_services (device.c:4346)
=3D=3D30400=3D=3D    by 0x185624: browse_cb (device.c:4587)
=3D=3D30400=3D=3D    by 0x15F8DF: search_completed_cb (sdp-client.c:205)
=3D=3D30400=3D=3D    by 0x195C29: sdp_process (sdp.c:4354)
=3D=3D30400=3D=3D    by 0x15FA35: search_process_cb (sdp-client.c:230)
=3D=3D30400=3D=3D    by 0x4E828C4: g_main_context_dispatch (in /usr/lib/lib=
glib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82C87: ??? (in /usr/lib/libglib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82FA1: g_main_loop_run (in /usr/lib/libglib-2.0=
.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x11FE0B: main (main.c:733)
=3D=3D30400=3D=3D  Address 0x6c91428 is 8 bytes inside a block of size 64 f=
ree'd
=3D=3D30400=3D=3D    at 0x4C2D16B: free (in /usr/lib/valgrind/vgpreload_mem=
check-amd64-linux.so)
=3D=3D30400=3D=3D    by 0x1830B8: gatt_client_ready_cb (device.c:4692)
=3D=3D30400=3D=3D    by 0x1A57BE: notify_client_ready.part.11 (gatt-client.=
c:1129)
=3D=3D30400=3D=3D    by 0x1A352F: discovery_op_complete (gatt-client.c:379)
=3D=3D30400=3D=3D    by 0x1A4078: discover_primary_cb (gatt-client.c:1101)
=3D=3D30400=3D=3D    by 0x1ACDC6: discovery_op_complete (gatt-helpers.c:628)
=3D=3D30400=3D=3D    by 0x1ACFF8: read_by_grp_type_cb (gatt-helpers.c:730)
=3D=3D30400=3D=3D    by 0x1A2DA0: handle_rsp (att.c:707)
=3D=3D30400=3D=3D    by 0x1A2DA0: can_read_data (att.c:879)
=3D=3D30400=3D=3D    by 0x1ABCD2: watch_callback (io-glib.c:170)
=3D=3D30400=3D=3D    by 0x4E828C4: g_main_context_dispatch (in /usr/lib/lib=
glib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82C87: ??? (in /usr/lib/libglib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82FA1: g_main_loop_run (in /usr/lib/libglib-2.0=
.so.0.5200.3)
=3D=3D30400=3D=3D  Block was alloc'd at
=3D=3D30400=3D=3D    at 0x4C2DF55: calloc (in /usr/lib/valgrind/vgpreload_m=
emcheck-amd64-linux.so)
=3D=3D30400=3D=3D    by 0x4E88080: g_malloc0 (in /usr/lib/libglib-2.0.so.0.=
5200.3)
=3D=3D30400=3D=3D    by 0x17DF2D: browse_request_new.part.26 (device.c:5016)
=3D=3D30400=3D=3D    by 0x17DFCD: browse_request_new (device.c:5013)
=3D=3D30400=3D=3D    by 0x17DFCD: device_browse_sdp (device.c:5116)
=3D=3D30400=3D=3D    by 0x182A31: connect_profiles (device.c:1772)
=3D=3D30400=3D=3D    by 0x19AA5A: process_message.isra.6 (object.c:259)
=3D=3D30400=3D=3D    by 0x51708D2: ??? (in /usr/lib/libdbus-1.so.3.14.11)
=3D=3D30400=3D=3D    by 0x5161F53: dbus_connection_dispatch (in /usr/lib/li=
bdbus-1.so.3.14.11)
=3D=3D30400=3D=3D    by 0x197150: message_dispatch (mainloop.c:72)
=3D=3D30400=3D=3D    by 0x4E828C4: g_main_context_dispatch (in /usr/lib/lib=
glib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82C87: ??? (in /usr/lib/libglib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82FA1: g_main_loop_run (in /usr/lib/libglib-2.0=
.so.0.5200.3)
=3D=3D30400=3D=3D =

=3D=3D30400=3D=3D Invalid read of size 8
=3D=3D30400=3D=3D    at 0x184FE7: update_record (device.c:4324)
=3D=3D30400=3D=3D    by 0x184FE7: update_bredr_services (device.c:4416)
=3D=3D30400=3D=3D    by 0x185624: browse_cb (device.c:4587)
=3D=3D30400=3D=3D    by 0x15F8DF: search_completed_cb (sdp-client.c:205)
=3D=3D30400=3D=3D    by 0x195C29: sdp_process (sdp.c:4354)
=3D=3D30400=3D=3D    by 0x15FA35: search_process_cb (sdp-client.c:230)
=3D=3D30400=3D=3D    by 0x4E828C4: g_main_context_dispatch (in /usr/lib/lib=
glib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82C87: ??? (in /usr/lib/libglib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82FA1: g_main_loop_run (in /usr/lib/libglib-2.0=
.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x11FE0B: main (main.c:733)
=3D=3D30400=3D=3D  Address 0x6c91448 is 40 bytes inside a block of size 64 =
free'd
=3D=3D30400=3D=3D    at 0x4C2D16B: free (in /usr/lib/valgrind/vgpreload_mem=
check-amd64-linux.so)
=3D=3D30400=3D=3D    by 0x1830B8: gatt_client_ready_cb (device.c:4692)
=3D=3D30400=3D=3D    by 0x1A57BE: notify_client_ready.part.11 (gatt-client.=
c:1129)
=3D=3D30400=3D=3D    by 0x1A352F: discovery_op_complete (gatt-client.c:379)
=3D=3D30400=3D=3D    by 0x1A4078: discover_primary_cb (gatt-client.c:1101)
=3D=3D30400=3D=3D    by 0x1ACDC6: discovery_op_complete (gatt-helpers.c:628)
=3D=3D30400=3D=3D    by 0x1ACFF8: read_by_grp_type_cb (gatt-helpers.c:730)
=3D=3D30400=3D=3D    by 0x1A2DA0: handle_rsp (att.c:707)
=3D=3D30400=3D=3D    by 0x1A2DA0: can_read_data (att.c:879)
=3D=3D30400=3D=3D    by 0x1ABCD2: watch_callback (io-glib.c:170)
=3D=3D30400=3D=3D    by 0x4E828C4: g_main_context_dispatch (in /usr/lib/lib=
glib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82C87: ??? (in /usr/lib/libglib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82FA1: g_main_loop_run (in /usr/lib/libglib-2.0=
.so.0.5200.3)
=3D=3D30400=3D=3D  Block was alloc'd at
=3D=3D30400=3D=3D    at 0x4C2DF55: calloc (in /usr/lib/valgrind/vgpreload_m=
emcheck-amd64-linux.so)
=3D=3D30400=3D=3D    by 0x4E88080: g_malloc0 (in /usr/lib/libglib-2.0.so.0.=
5200.3)
=3D=3D30400=3D=3D    by 0x17DF2D: browse_request_new.part.26 (device.c:5016)
=3D=3D30400=3D=3D    by 0x17DFCD: browse_request_new (device.c:5013)
=3D=3D30400=3D=3D    by 0x17DFCD: device_browse_sdp (device.c:5116)
=3D=3D30400=3D=3D    by 0x182A31: connect_profiles (device.c:1772)
=3D=3D30400=3D=3D    by 0x19AA5A: process_message.isra.6 (object.c:259)
=3D=3D30400=3D=3D    by 0x51708D2: ??? (in /usr/lib/libdbus-1.so.3.14.11)
=3D=3D30400=3D=3D    by 0x5161F53: dbus_connection_dispatch (in /usr/lib/li=
bdbus-1.so.3.14.11)
=3D=3D30400=3D=3D    by 0x197150: message_dispatch (mainloop.c:72)
=3D=3D30400=3D=3D    by 0x4E828C4: g_main_context_dispatch (in /usr/lib/lib=
glib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82C87: ??? (in /usr/lib/libglib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82FA1: g_main_loop_run (in /usr/lib/libglib-2.0=
.so.0.5200.3)
=3D=3D30400=3D=3D =

=3D=3D30400=3D=3D Invalid read of size 8
=3D=3D30400=3D=3D    at 0x18501D: update_record (device.c:4328)
=3D=3D30400=3D=3D    by 0x18501D: update_bredr_services (device.c:4416)
=3D=3D30400=3D=3D    by 0x185624: browse_cb (device.c:4587)
=3D=3D30400=3D=3D    by 0x15F8DF: search_completed_cb (sdp-client.c:205)
=3D=3D30400=3D=3D    by 0x195C29: sdp_process (sdp.c:4354)
=3D=3D30400=3D=3D    by 0x15FA35: search_process_cb (sdp-client.c:230)
=3D=3D30400=3D=3D    by 0x4E828C4: g_main_context_dispatch (in /usr/lib/lib=
glib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82C87: ??? (in /usr/lib/libglib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82FA1: g_main_loop_run (in /usr/lib/libglib-2.0=
.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x11FE0B: main (main.c:733)
=3D=3D30400=3D=3D  Address 0x6c91448 is 40 bytes inside a block of size 64 =
free'd
=3D=3D30400=3D=3D    at 0x4C2D16B: free (in /usr/lib/valgrind/vgpreload_mem=
check-amd64-linux.so)
=3D=3D30400=3D=3D    by 0x1830B8: gatt_client_ready_cb (device.c:4692)
=3D=3D30400=3D=3D    by 0x1A57BE: notify_client_ready.part.11 (gatt-client.=
c:1129)
=3D=3D30400=3D=3D    by 0x1A352F: discovery_op_complete (gatt-client.c:379)
=3D=3D30400=3D=3D    by 0x1A4078: discover_primary_cb (gatt-client.c:1101)
=3D=3D30400=3D=3D    by 0x1ACDC6: discovery_op_complete (gatt-helpers.c:628)
=3D=3D30400=3D=3D    by 0x1ACFF8: read_by_grp_type_cb (gatt-helpers.c:730)
=3D=3D30400=3D=3D    by 0x1A2DA0: handle_rsp (att.c:707)
=3D=3D30400=3D=3D    by 0x1A2DA0: can_read_data (att.c:879)
=3D=3D30400=3D=3D    by 0x1ABCD2: watch_callback (io-glib.c:170)
=3D=3D30400=3D=3D    by 0x4E828C4: g_main_context_dispatch (in /usr/lib/lib=
glib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82C87: ??? (in /usr/lib/libglib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82FA1: g_main_loop_run (in /usr/lib/libglib-2.0=
.so.0.5200.3)
=3D=3D30400=3D=3D  Block was alloc'd at
=3D=3D30400=3D=3D    at 0x4C2DF55: calloc (in /usr/lib/valgrind/vgpreload_m=
emcheck-amd64-linux.so)
=3D=3D30400=3D=3D    by 0x4E88080: g_malloc0 (in /usr/lib/libglib-2.0.so.0.=
5200.3)
=3D=3D30400=3D=3D    by 0x17DF2D: browse_request_new.part.26 (device.c:5016)
=3D=3D30400=3D=3D    by 0x17DFCD: browse_request_new (device.c:5013)
=3D=3D30400=3D=3D    by 0x17DFCD: device_browse_sdp (device.c:5116)
=3D=3D30400=3D=3D    by 0x182A31: connect_profiles (device.c:1772)
=3D=3D30400=3D=3D    by 0x19AA5A: process_message.isra.6 (object.c:259)
=3D=3D30400=3D=3D    by 0x51708D2: ??? (in /usr/lib/libdbus-1.so.3.14.11)
=3D=3D30400=3D=3D    by 0x5161F53: dbus_connection_dispatch (in /usr/lib/li=
bdbus-1.so.3.14.11)
=3D=3D30400=3D=3D    by 0x197150: message_dispatch (mainloop.c:72)
=3D=3D30400=3D=3D    by 0x4E828C4: g_main_context_dispatch (in /usr/lib/lib=
glib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82C87: ??? (in /usr/lib/libglib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82FA1: g_main_loop_run (in /usr/lib/libglib-2.0=
.so.0.5200.3)
=3D=3D30400=3D=3D =

=3D=3D30400=3D=3D Invalid write of size 8
=3D=3D30400=3D=3D    at 0x18502A: update_record (device.c:4328)
=3D=3D30400=3D=3D    by 0x18502A: update_bredr_services (device.c:4416)
=3D=3D30400=3D=3D    by 0x185624: browse_cb (device.c:4587)
=3D=3D30400=3D=3D    by 0x15F8DF: search_completed_cb (sdp-client.c:205)
=3D=3D30400=3D=3D    by 0x195C29: sdp_process (sdp.c:4354)
=3D=3D30400=3D=3D    by 0x15FA35: search_process_cb (sdp-client.c:230)
=3D=3D30400=3D=3D    by 0x4E828C4: g_main_context_dispatch (in /usr/lib/lib=
glib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82C87: ??? (in /usr/lib/libglib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82FA1: g_main_loop_run (in /usr/lib/libglib-2.0=
.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x11FE0B: main (main.c:733)
=3D=3D30400=3D=3D  Address 0x6c91448 is 40 bytes inside a block of size 64 =
free'd
=3D=3D30400=3D=3D    at 0x4C2D16B: free (in /usr/lib/valgrind/vgpreload_mem=
check-amd64-linux.so)
=3D=3D30400=3D=3D    by 0x1830B8: gatt_client_ready_cb (device.c:4692)
=3D=3D30400=3D=3D    by 0x1A57BE: notify_client_ready.part.11 (gatt-client.=
c:1129)
=3D=3D30400=3D=3D    by 0x1A352F: discovery_op_complete (gatt-client.c:379)
=3D=3D30400=3D=3D    by 0x1A4078: discover_primary_cb (gatt-client.c:1101)
=3D=3D30400=3D=3D    by 0x1ACDC6: discovery_op_complete (gatt-helpers.c:628)
=3D=3D30400=3D=3D    by 0x1ACFF8: read_by_grp_type_cb (gatt-helpers.c:730)
=3D=3D30400=3D=3D    by 0x1A2DA0: handle_rsp (att.c:707)
=3D=3D30400=3D=3D    by 0x1A2DA0: can_read_data (att.c:879)
=3D=3D30400=3D=3D    by 0x1ABCD2: watch_callback (io-glib.c:170)
=3D=3D30400=3D=3D    by 0x4E828C4: g_main_context_dispatch (in /usr/lib/lib=
glib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82C87: ??? (in /usr/lib/libglib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82FA1: g_main_loop_run (in /usr/lib/libglib-2.0=
.so.0.5200.3)
=3D=3D30400=3D=3D  Block was alloc'd at
=3D=3D30400=3D=3D    at 0x4C2DF55: calloc (in /usr/lib/valgrind/vgpreload_m=
emcheck-amd64-linux.so)
=3D=3D30400=3D=3D    by 0x4E88080: g_malloc0 (in /usr/lib/libglib-2.0.so.0.=
5200.3)
=3D=3D30400=3D=3D    by 0x17DF2D: browse_request_new.part.26 (device.c:5016)
=3D=3D30400=3D=3D    by 0x17DFCD: browse_request_new (device.c:5013)
=3D=3D30400=3D=3D    by 0x17DFCD: device_browse_sdp (device.c:5116)
=3D=3D30400=3D=3D    by 0x182A31: connect_profiles (device.c:1772)
=3D=3D30400=3D=3D    by 0x19AA5A: process_message.isra.6 (object.c:259)
=3D=3D30400=3D=3D    by 0x51708D2: ??? (in /usr/lib/libdbus-1.so.3.14.11)
=3D=3D30400=3D=3D    by 0x5161F53: dbus_connection_dispatch (in /usr/lib/li=
bdbus-1.so.3.14.11)
=3D=3D30400=3D=3D    by 0x197150: message_dispatch (mainloop.c:72)
=3D=3D30400=3D=3D    by 0x4E828C4: g_main_context_dispatch (in /usr/lib/lib=
glib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82C87: ??? (in /usr/lib/libglib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82FA1: g_main_loop_run (in /usr/lib/libglib-2.0=
.so.0.5200.3)
=3D=3D30400=3D=3D =

=3D=3D30400=3D=3D Invalid read of size 8
=3D=3D30400=3D=3D    at 0x18502E: update_record (device.c:4331)
=3D=3D30400=3D=3D    by 0x18502E: update_bredr_services (device.c:4416)
=3D=3D30400=3D=3D    by 0x185624: browse_cb (device.c:4587)
=3D=3D30400=3D=3D    by 0x15F8DF: search_completed_cb (sdp-client.c:205)
=3D=3D30400=3D=3D    by 0x195C29: sdp_process (sdp.c:4354)
=3D=3D30400=3D=3D    by 0x15FA35: search_process_cb (sdp-client.c:230)
=3D=3D30400=3D=3D    by 0x4E828C4: g_main_context_dispatch (in /usr/lib/lib=
glib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82C87: ??? (in /usr/lib/libglib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82FA1: g_main_loop_run (in /usr/lib/libglib-2.0=
.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x11FE0B: main (main.c:733)
=3D=3D30400=3D=3D  Address 0x6c91428 is 8 bytes inside a block of size 64 f=
ree'd
=3D=3D30400=3D=3D    at 0x4C2D16B: free (in /usr/lib/valgrind/vgpreload_mem=
check-amd64-linux.so)
=3D=3D30400=3D=3D    by 0x1830B8: gatt_client_ready_cb (device.c:4692)
=3D=3D30400=3D=3D    by 0x1A57BE: notify_client_ready.part.11 (gatt-client.=
c:1129)
=3D=3D30400=3D=3D    by 0x1A352F: discovery_op_complete (gatt-client.c:379)
=3D=3D30400=3D=3D    by 0x1A4078: discover_primary_cb (gatt-client.c:1101)
=3D=3D30400=3D=3D    by 0x1ACDC6: discovery_op_complete (gatt-helpers.c:628)
=3D=3D30400=3D=3D    by 0x1ACFF8: read_by_grp_type_cb (gatt-helpers.c:730)
=3D=3D30400=3D=3D    by 0x1A2DA0: handle_rsp (att.c:707)
=3D=3D30400=3D=3D    by 0x1A2DA0: can_read_data (att.c:879)
=3D=3D30400=3D=3D    by 0x1ABCD2: watch_callback (io-glib.c:170)
=3D=3D30400=3D=3D    by 0x4E828C4: g_main_context_dispatch (in /usr/lib/lib=
glib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82C87: ??? (in /usr/lib/libglib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82FA1: g_main_loop_run (in /usr/lib/libglib-2.0=
.so.0.5200.3)
=3D=3D30400=3D=3D  Block was alloc'd at
=3D=3D30400=3D=3D    at 0x4C2DF55: calloc (in /usr/lib/valgrind/vgpreload_m=
emcheck-amd64-linux.so)
=3D=3D30400=3D=3D    by 0x4E88080: g_malloc0 (in /usr/lib/libglib-2.0.so.0.=
5200.3)
=3D=3D30400=3D=3D    by 0x17DF2D: browse_request_new.part.26 (device.c:5016)
=3D=3D30400=3D=3D    by 0x17DFCD: browse_request_new (device.c:5013)
=3D=3D30400=3D=3D    by 0x17DFCD: device_browse_sdp (device.c:5116)
=3D=3D30400=3D=3D    by 0x182A31: connect_profiles (device.c:1772)
=3D=3D30400=3D=3D    by 0x19AA5A: process_message.isra.6 (object.c:259)
=3D=3D30400=3D=3D    by 0x51708D2: ??? (in /usr/lib/libdbus-1.so.3.14.11)
=3D=3D30400=3D=3D    by 0x5161F53: dbus_connection_dispatch (in /usr/lib/li=
bdbus-1.so.3.14.11)
=3D=3D30400=3D=3D    by 0x197150: message_dispatch (mainloop.c:72)
=3D=3D30400=3D=3D    by 0x4E828C4: g_main_context_dispatch (in /usr/lib/lib=
glib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82C87: ??? (in /usr/lib/libglib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82FA1: g_main_loop_run (in /usr/lib/libglib-2.0=
.so.0.5200.3)
=3D=3D30400=3D=3D =

=3D=3D30400=3D=3D Invalid read of size 8
=3D=3D30400=3D=3D    at 0x1853A0: update_record (device.c:4333)
=3D=3D30400=3D=3D    by 0x1853A0: update_bredr_services (device.c:4416)
=3D=3D30400=3D=3D    by 0x185624: browse_cb (device.c:4587)
=3D=3D30400=3D=3D    by 0x15F8DF: search_completed_cb (sdp-client.c:205)
=3D=3D30400=3D=3D    by 0x195C29: sdp_process (sdp.c:4354)
=3D=3D30400=3D=3D    by 0x15FA35: search_process_cb (sdp-client.c:230)
=3D=3D30400=3D=3D    by 0x4E828C4: g_main_context_dispatch (in /usr/lib/lib=
glib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82C87: ??? (in /usr/lib/libglib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82FA1: g_main_loop_run (in /usr/lib/libglib-2.0=
.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x11FE0B: main (main.c:733)
=3D=3D30400=3D=3D  Address 0x6c91440 is 32 bytes inside a block of size 64 =
free'd
=3D=3D30400=3D=3D    at 0x4C2D16B: free (in /usr/lib/valgrind/vgpreload_mem=
check-amd64-linux.so)
=3D=3D30400=3D=3D    by 0x1830B8: gatt_client_ready_cb (device.c:4692)
=3D=3D30400=3D=3D    by 0x1A57BE: notify_client_ready.part.11 (gatt-client.=
c:1129)
=3D=3D30400=3D=3D    by 0x1A352F: discovery_op_complete (gatt-client.c:379)
=3D=3D30400=3D=3D    by 0x1A4078: discover_primary_cb (gatt-client.c:1101)
=3D=3D30400=3D=3D    by 0x1ACDC6: discovery_op_complete (gatt-helpers.c:628)
=3D=3D30400=3D=3D    by 0x1ACFF8: read_by_grp_type_cb (gatt-helpers.c:730)
=3D=3D30400=3D=3D    by 0x1A2DA0: handle_rsp (att.c:707)
=3D=3D30400=3D=3D    by 0x1A2DA0: can_read_data (att.c:879)
=3D=3D30400=3D=3D    by 0x1ABCD2: watch_callback (io-glib.c:170)
=3D=3D30400=3D=3D    by 0x4E828C4: g_main_context_dispatch (in /usr/lib/lib=
glib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82C87: ??? (in /usr/lib/libglib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82FA1: g_main_loop_run (in /usr/lib/libglib-2.0=
.so.0.5200.3)
=3D=3D30400=3D=3D  Block was alloc'd at
=3D=3D30400=3D=3D    at 0x4C2DF55: calloc (in /usr/lib/valgrind/vgpreload_m=
emcheck-amd64-linux.so)
=3D=3D30400=3D=3D    by 0x4E88080: g_malloc0 (in /usr/lib/libglib-2.0.so.0.=
5200.3)
=3D=3D30400=3D=3D    by 0x17DF2D: browse_request_new.part.26 (device.c:5016)
=3D=3D30400=3D=3D    by 0x17DFCD: browse_request_new (device.c:5013)
=3D=3D30400=3D=3D    by 0x17DFCD: device_browse_sdp (device.c:5116)
=3D=3D30400=3D=3D    by 0x182A31: connect_profiles (device.c:1772)
=3D=3D30400=3D=3D    by 0x19AA5A: process_message.isra.6 (object.c:259)
=3D=3D30400=3D=3D    by 0x51708D2: ??? (in /usr/lib/libdbus-1.so.3.14.11)
=3D=3D30400=3D=3D    by 0x5161F53: dbus_connection_dispatch (in /usr/lib/li=
bdbus-1.so.3.14.11)
=3D=3D30400=3D=3D    by 0x197150: message_dispatch (mainloop.c:72)
=3D=3D30400=3D=3D    by 0x4E828C4: g_main_context_dispatch (in /usr/lib/lib=
glib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82C87: ??? (in /usr/lib/libglib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82FA1: g_main_loop_run (in /usr/lib/libglib-2.0=
.so.0.5200.3)
=3D=3D30400=3D=3D =

=3D=3D30400=3D=3D Invalid read of size 8
=3D=3D30400=3D=3D    at 0x1853C6: update_record (device.c:4337)
=3D=3D30400=3D=3D    by 0x1853C6: update_bredr_services (device.c:4416)
=3D=3D30400=3D=3D    by 0x185624: browse_cb (device.c:4587)
=3D=3D30400=3D=3D    by 0x15F8DF: search_completed_cb (sdp-client.c:205)
=3D=3D30400=3D=3D    by 0x195C29: sdp_process (sdp.c:4354)
=3D=3D30400=3D=3D    by 0x15FA35: search_process_cb (sdp-client.c:230)
=3D=3D30400=3D=3D    by 0x4E828C4: g_main_context_dispatch (in /usr/lib/lib=
glib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82C87: ??? (in /usr/lib/libglib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82FA1: g_main_loop_run (in /usr/lib/libglib-2.0=
.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x11FE0B: main (main.c:733)
=3D=3D30400=3D=3D  Address 0x6c91440 is 32 bytes inside a block of size 64 =
free'd
=3D=3D30400=3D=3D    at 0x4C2D16B: free (in /usr/lib/valgrind/vgpreload_mem=
check-amd64-linux.so)
=3D=3D30400=3D=3D    by 0x1830B8: gatt_client_ready_cb (device.c:4692)
=3D=3D30400=3D=3D    by 0x1A57BE: notify_client_ready.part.11 (gatt-client.=
c:1129)
=3D=3D30400=3D=3D    by 0x1A352F: discovery_op_complete (gatt-client.c:379)
=3D=3D30400=3D=3D    by 0x1A4078: discover_primary_cb (gatt-client.c:1101)
=3D=3D30400=3D=3D    by 0x1ACDC6: discovery_op_complete (gatt-helpers.c:628)
=3D=3D30400=3D=3D    by 0x1ACFF8: read_by_grp_type_cb (gatt-helpers.c:730)
=3D=3D30400=3D=3D    by 0x1A2DA0: handle_rsp (att.c:707)
=3D=3D30400=3D=3D    by 0x1A2DA0: can_read_data (att.c:879)
=3D=3D30400=3D=3D    by 0x1ABCD2: watch_callback (io-glib.c:170)
=3D=3D30400=3D=3D    by 0x4E828C4: g_main_context_dispatch (in /usr/lib/lib=
glib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82C87: ??? (in /usr/lib/libglib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82FA1: g_main_loop_run (in /usr/lib/libglib-2.0=
.so.0.5200.3)
=3D=3D30400=3D=3D  Block was alloc'd at
=3D=3D30400=3D=3D    at 0x4C2DF55: calloc (in /usr/lib/valgrind/vgpreload_m=
emcheck-amd64-linux.so)
=3D=3D30400=3D=3D    by 0x4E88080: g_malloc0 (in /usr/lib/libglib-2.0.so.0.=
5200.3)
=3D=3D30400=3D=3D    by 0x17DF2D: browse_request_new.part.26 (device.c:5016)
=3D=3D30400=3D=3D    by 0x17DFCD: browse_request_new (device.c:5013)
=3D=3D30400=3D=3D    by 0x17DFCD: device_browse_sdp (device.c:5116)
=3D=3D30400=3D=3D    by 0x182A31: connect_profiles (device.c:1772)
=3D=3D30400=3D=3D    by 0x19AA5A: process_message.isra.6 (object.c:259)
=3D=3D30400=3D=3D    by 0x51708D2: ??? (in /usr/lib/libdbus-1.so.3.14.11)
=3D=3D30400=3D=3D    by 0x5161F53: dbus_connection_dispatch (in /usr/lib/li=
bdbus-1.so.3.14.11)
=3D=3D30400=3D=3D    by 0x197150: message_dispatch (mainloop.c:72)
=3D=3D30400=3D=3D    by 0x4E828C4: g_main_context_dispatch (in /usr/lib/lib=
glib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82C87: ??? (in /usr/lib/libglib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82FA1: g_main_loop_run (in /usr/lib/libglib-2.0=
.so.0.5200.3)
=3D=3D30400=3D=3D =

=3D=3D30400=3D=3D Invalid write of size 8
=3D=3D30400=3D=3D    at 0x1853D3: update_record (device.c:4337)
=3D=3D30400=3D=3D    by 0x1853D3: update_bredr_services (device.c:4416)
=3D=3D30400=3D=3D    by 0x185624: browse_cb (device.c:4587)
=3D=3D30400=3D=3D    by 0x15F8DF: search_completed_cb (sdp-client.c:205)
=3D=3D30400=3D=3D    by 0x195C29: sdp_process (sdp.c:4354)
=3D=3D30400=3D=3D    by 0x15FA35: search_process_cb (sdp-client.c:230)
=3D=3D30400=3D=3D    by 0x4E828C4: g_main_context_dispatch (in /usr/lib/lib=
glib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82C87: ??? (in /usr/lib/libglib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82FA1: g_main_loop_run (in /usr/lib/libglib-2.0=
.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x11FE0B: main (main.c:733)
=3D=3D30400=3D=3D  Address 0x6c91440 is 32 bytes inside a block of size 64 =
free'd
=3D=3D30400=3D=3D    at 0x4C2D16B: free (in /usr/lib/valgrind/vgpreload_mem=
check-amd64-linux.so)
=3D=3D30400=3D=3D    by 0x1830B8: gatt_client_ready_cb (device.c:4692)
=3D=3D30400=3D=3D    by 0x1A57BE: notify_client_ready.part.11 (gatt-client.=
c:1129)
=3D=3D30400=3D=3D    by 0x1A352F: discovery_op_complete (gatt-client.c:379)
=3D=3D30400=3D=3D    by 0x1A4078: discover_primary_cb (gatt-client.c:1101)
=3D=3D30400=3D=3D    by 0x1ACDC6: discovery_op_complete (gatt-helpers.c:628)
=3D=3D30400=3D=3D    by 0x1ACFF8: read_by_grp_type_cb (gatt-helpers.c:730)
=3D=3D30400=3D=3D    by 0x1A2DA0: handle_rsp (att.c:707)
=3D=3D30400=3D=3D    by 0x1A2DA0: can_read_data (att.c:879)
=3D=3D30400=3D=3D    by 0x1ABCD2: watch_callback (io-glib.c:170)
=3D=3D30400=3D=3D    by 0x4E828C4: g_main_context_dispatch (in /usr/lib/lib=
glib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82C87: ??? (in /usr/lib/libglib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82FA1: g_main_loop_run (in /usr/lib/libglib-2.0=
.so.0.5200.3)
=3D=3D30400=3D=3D  Block was alloc'd at
=3D=3D30400=3D=3D    at 0x4C2DF55: calloc (in /usr/lib/valgrind/vgpreload_m=
emcheck-amd64-linux.so)
=3D=3D30400=3D=3D    by 0x4E88080: g_malloc0 (in /usr/lib/libglib-2.0.so.0.=
5200.3)
=3D=3D30400=3D=3D    by 0x17DF2D: browse_request_new.part.26 (device.c:5016)
=3D=3D30400=3D=3D    by 0x17DFCD: browse_request_new (device.c:5013)
=3D=3D30400=3D=3D    by 0x17DFCD: device_browse_sdp (device.c:5116)
=3D=3D30400=3D=3D    by 0x182A31: connect_profiles (device.c:1772)
=3D=3D30400=3D=3D    by 0x19AA5A: process_message.isra.6 (object.c:259)
=3D=3D30400=3D=3D    by 0x51708D2: ??? (in /usr/lib/libdbus-1.so.3.14.11)
=3D=3D30400=3D=3D    by 0x5161F53: dbus_connection_dispatch (in /usr/lib/li=
bdbus-1.so.3.14.11)
=3D=3D30400=3D=3D    by 0x197150: message_dispatch (mainloop.c:72)
=3D=3D30400=3D=3D    by 0x4E828C4: g_main_context_dispatch (in /usr/lib/lib=
glib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82C87: ??? (in /usr/lib/libglib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82FA1: g_main_loop_run (in /usr/lib/libglib-2.0=
.so.0.5200.3)
=3D=3D30400=3D=3D =

=3D=3D30400=3D=3D Invalid read of size 4
=3D=3D30400=3D=3D    at 0x185625: browse_cb (device.c:4590)
=3D=3D30400=3D=3D    by 0x15F8DF: search_completed_cb (sdp-client.c:205)
=3D=3D30400=3D=3D    by 0x195C29: sdp_process (sdp.c:4354)
=3D=3D30400=3D=3D    by 0x15FA35: search_process_cb (sdp-client.c:230)
=3D=3D30400=3D=3D    by 0x4E828C4: g_main_context_dispatch (in /usr/lib/lib=
glib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82C87: ??? (in /usr/lib/libglib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82FA1: g_main_loop_run (in /usr/lib/libglib-2.0=
.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x11FE0B: main (main.c:733)
=3D=3D30400=3D=3D  Address 0x6c91450 is 48 bytes inside a block of size 64 =
free'd
=3D=3D30400=3D=3D    at 0x4C2D16B: free (in /usr/lib/valgrind/vgpreload_mem=
check-amd64-linux.so)
=3D=3D30400=3D=3D    by 0x1830B8: gatt_client_ready_cb (device.c:4692)
=3D=3D30400=3D=3D    by 0x1A57BE: notify_client_ready.part.11 (gatt-client.=
c:1129)
=3D=3D30400=3D=3D    by 0x1A352F: discovery_op_complete (gatt-client.c:379)
=3D=3D30400=3D=3D    by 0x1A4078: discover_primary_cb (gatt-client.c:1101)
=3D=3D30400=3D=3D    by 0x1ACDC6: discovery_op_complete (gatt-helpers.c:628)
=3D=3D30400=3D=3D    by 0x1ACFF8: read_by_grp_type_cb (gatt-helpers.c:730)
=3D=3D30400=3D=3D    by 0x1A2DA0: handle_rsp (att.c:707)
=3D=3D30400=3D=3D    by 0x1A2DA0: can_read_data (att.c:879)
=3D=3D30400=3D=3D    by 0x1ABCD2: watch_callback (io-glib.c:170)
=3D=3D30400=3D=3D    by 0x4E828C4: g_main_context_dispatch (in /usr/lib/lib=
glib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82C87: ??? (in /usr/lib/libglib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82FA1: g_main_loop_run (in /usr/lib/libglib-2.0=
.so.0.5200.3)
=3D=3D30400=3D=3D  Block was alloc'd at
=3D=3D30400=3D=3D    at 0x4C2DF55: calloc (in /usr/lib/valgrind/vgpreload_m=
emcheck-amd64-linux.so)
=3D=3D30400=3D=3D    by 0x4E88080: g_malloc0 (in /usr/lib/libglib-2.0.so.0.=
5200.3)
=3D=3D30400=3D=3D    by 0x17DF2D: browse_request_new.part.26 (device.c:5016)
=3D=3D30400=3D=3D    by 0x17DFCD: browse_request_new (device.c:5013)
=3D=3D30400=3D=3D    by 0x17DFCD: device_browse_sdp (device.c:5116)
=3D=3D30400=3D=3D    by 0x182A31: connect_profiles (device.c:1772)
=3D=3D30400=3D=3D    by 0x19AA5A: process_message.isra.6 (object.c:259)
=3D=3D30400=3D=3D    by 0x51708D2: ??? (in /usr/lib/libdbus-1.so.3.14.11)
=3D=3D30400=3D=3D    by 0x5161F53: dbus_connection_dispatch (in /usr/lib/li=
bdbus-1.so.3.14.11)
=3D=3D30400=3D=3D    by 0x197150: message_dispatch (mainloop.c:72)
=3D=3D30400=3D=3D    by 0x4E828C4: g_main_context_dispatch (in /usr/lib/lib=
glib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82C87: ??? (in /usr/lib/libglib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82FA1: g_main_loop_run (in /usr/lib/libglib-2.0=
.so.0.5200.3)
=3D=3D30400=3D=3D =

=3D=3D30400=3D=3D Invalid write of size 4
=3D=3D30400=3D=3D    at 0x185918: browse_cb (device.c:4591)
=3D=3D30400=3D=3D    by 0x15F8DF: search_completed_cb (sdp-client.c:205)
=3D=3D30400=3D=3D    by 0x195C29: sdp_process (sdp.c:4354)
=3D=3D30400=3D=3D    by 0x15FA35: search_process_cb (sdp-client.c:230)
=3D=3D30400=3D=3D    by 0x4E828C4: g_main_context_dispatch (in /usr/lib/lib=
glib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82C87: ??? (in /usr/lib/libglib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82FA1: g_main_loop_run (in /usr/lib/libglib-2.0=
.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x11FE0B: main (main.c:733)
=3D=3D30400=3D=3D  Address 0x6c91450 is 48 bytes inside a block of size 64 =
free'd
=3D=3D30400=3D=3D    at 0x4C2D16B: free (in /usr/lib/valgrind/vgpreload_mem=
check-amd64-linux.so)
=3D=3D30400=3D=3D    by 0x1830B8: gatt_client_ready_cb (device.c:4692)
=3D=3D30400=3D=3D    by 0x1A57BE: notify_client_ready.part.11 (gatt-client.=
c:1129)
=3D=3D30400=3D=3D    by 0x1A352F: discovery_op_complete (gatt-client.c:379)
=3D=3D30400=3D=3D    by 0x1A4078: discover_primary_cb (gatt-client.c:1101)
=3D=3D30400=3D=3D    by 0x1ACDC6: discovery_op_complete (gatt-helpers.c:628)
=3D=3D30400=3D=3D    by 0x1ACFF8: read_by_grp_type_cb (gatt-helpers.c:730)
=3D=3D30400=3D=3D    by 0x1A2DA0: handle_rsp (att.c:707)
=3D=3D30400=3D=3D    by 0x1A2DA0: can_read_data (att.c:879)
=3D=3D30400=3D=3D    by 0x1ABCD2: watch_callback (io-glib.c:170)
=3D=3D30400=3D=3D    by 0x4E828C4: g_main_context_dispatch (in /usr/lib/lib=
glib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82C87: ??? (in /usr/lib/libglib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82FA1: g_main_loop_run (in /usr/lib/libglib-2.0=
.so.0.5200.3)
=3D=3D30400=3D=3D  Block was alloc'd at
=3D=3D30400=3D=3D    at 0x4C2DF55: calloc (in /usr/lib/valgrind/vgpreload_m=
emcheck-amd64-linux.so)
=3D=3D30400=3D=3D    by 0x4E88080: g_malloc0 (in /usr/lib/libglib-2.0.so.0.=
5200.3)
=3D=3D30400=3D=3D    by 0x17DF2D: browse_request_new.part.26 (device.c:5016)
=3D=3D30400=3D=3D    by 0x17DFCD: browse_request_new (device.c:5013)
=3D=3D30400=3D=3D    by 0x17DFCD: device_browse_sdp (device.c:5116)
=3D=3D30400=3D=3D    by 0x182A31: connect_profiles (device.c:1772)
=3D=3D30400=3D=3D    by 0x19AA5A: process_message.isra.6 (object.c:259)
=3D=3D30400=3D=3D    by 0x51708D2: ??? (in /usr/lib/libdbus-1.so.3.14.11)
=3D=3D30400=3D=3D    by 0x5161F53: dbus_connection_dispatch (in /usr/lib/li=
bdbus-1.so.3.14.11)
=3D=3D30400=3D=3D    by 0x197150: message_dispatch (mainloop.c:72)
=3D=3D30400=3D=3D    by 0x4E828C4: g_main_context_dispatch (in /usr/lib/lib=
glib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82C87: ??? (in /usr/lib/libglib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82FA1: g_main_loop_run (in /usr/lib/libglib-2.0=
.so.0.5200.3)
=3D=3D30400=3D=3D =

=3D=3D30400=3D=3D Invalid read of size 2
=3D=3D30400=3D=3D    at 0x185924: browse_cb (device.c:4592)
=3D=3D30400=3D=3D    by 0x15F8DF: search_completed_cb (sdp-client.c:205)
=3D=3D30400=3D=3D    by 0x195C29: sdp_process (sdp.c:4354)
=3D=3D30400=3D=3D    by 0x15FA35: search_process_cb (sdp-client.c:230)
=3D=3D30400=3D=3D    by 0x4E828C4: g_main_context_dispatch (in /usr/lib/lib=
glib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82C87: ??? (in /usr/lib/libglib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82FA1: g_main_loop_run (in /usr/lib/libglib-2.0=
.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x11FE0B: main (main.c:733)
=3D=3D30400=3D=3D  Address 0x6c9145c is 60 bytes inside a block of size 64 =
free'd
=3D=3D30400=3D=3D    at 0x4C2D16B: free (in /usr/lib/valgrind/vgpreload_mem=
check-amd64-linux.so)
=3D=3D30400=3D=3D    by 0x1830B8: gatt_client_ready_cb (device.c:4692)
=3D=3D30400=3D=3D    by 0x1A57BE: notify_client_ready.part.11 (gatt-client.=
c:1129)
=3D=3D30400=3D=3D    by 0x1A352F: discovery_op_complete (gatt-client.c:379)
=3D=3D30400=3D=3D    by 0x1A4078: discover_primary_cb (gatt-client.c:1101)
=3D=3D30400=3D=3D    by 0x1ACDC6: discovery_op_complete (gatt-helpers.c:628)
=3D=3D30400=3D=3D    by 0x1ACFF8: read_by_grp_type_cb (gatt-helpers.c:730)
=3D=3D30400=3D=3D    by 0x1A2DA0: handle_rsp (att.c:707)
=3D=3D30400=3D=3D    by 0x1A2DA0: can_read_data (att.c:879)
=3D=3D30400=3D=3D    by 0x1ABCD2: watch_callback (io-glib.c:170)
=3D=3D30400=3D=3D    by 0x4E828C4: g_main_context_dispatch (in /usr/lib/lib=
glib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82C87: ??? (in /usr/lib/libglib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82FA1: g_main_loop_run (in /usr/lib/libglib-2.0=
.so.0.5200.3)
=3D=3D30400=3D=3D  Block was alloc'd at
=3D=3D30400=3D=3D    at 0x4C2DF55: calloc (in /usr/lib/valgrind/vgpreload_m=
emcheck-amd64-linux.so)
=3D=3D30400=3D=3D    by 0x4E88080: g_malloc0 (in /usr/lib/libglib-2.0.so.0.=
5200.3)
=3D=3D30400=3D=3D    by 0x17DF2D: browse_request_new.part.26 (device.c:5016)
=3D=3D30400=3D=3D    by 0x17DFCD: browse_request_new (device.c:5013)
=3D=3D30400=3D=3D    by 0x17DFCD: device_browse_sdp (device.c:5116)
=3D=3D30400=3D=3D    by 0x182A31: connect_profiles (device.c:1772)
=3D=3D30400=3D=3D    by 0x19AA5A: process_message.isra.6 (object.c:259)
=3D=3D30400=3D=3D    by 0x51708D2: ??? (in /usr/lib/libdbus-1.so.3.14.11)
=3D=3D30400=3D=3D    by 0x5161F53: dbus_connection_dispatch (in /usr/lib/li=
bdbus-1.so.3.14.11)
=3D=3D30400=3D=3D    by 0x197150: message_dispatch (mainloop.c:72)
=3D=3D30400=3D=3D    by 0x4E828C4: g_main_context_dispatch (in /usr/lib/lib=
glib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82C87: ??? (in /usr/lib/libglib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82FA1: g_main_loop_run (in /usr/lib/libglib-2.0=
.so.0.5200.3)
=3D=3D30400=3D=3D =

=3D=3D30400=3D=3D Invalid read of size 8
=3D=3D30400=3D=3D    at 0x185840: browse_cb (device.c:4579)
=3D=3D30400=3D=3D    by 0x15F8DF: search_completed_cb (sdp-client.c:205)
=3D=3D30400=3D=3D    by 0x195C29: sdp_process (sdp.c:4354)
=3D=3D30400=3D=3D    by 0x15FA35: search_process_cb (sdp-client.c:230)
=3D=3D30400=3D=3D    by 0x4E828C4: g_main_context_dispatch (in /usr/lib/lib=
glib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82C87: ??? (in /usr/lib/libglib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82FA1: g_main_loop_run (in /usr/lib/libglib-2.0=
.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x11FE0B: main (main.c:733)
=3D=3D30400=3D=3D  Address 0x6c91448 is 40 bytes inside a block of size 64 =
free'd
=3D=3D30400=3D=3D    at 0x4C2D16B: free (in /usr/lib/valgrind/vgpreload_mem=
check-amd64-linux.so)
=3D=3D30400=3D=3D    by 0x1830B8: gatt_client_ready_cb (device.c:4692)
=3D=3D30400=3D=3D    by 0x1A57BE: notify_client_ready.part.11 (gatt-client.=
c:1129)
=3D=3D30400=3D=3D    by 0x1A352F: discovery_op_complete (gatt-client.c:379)
=3D=3D30400=3D=3D    by 0x1A4078: discover_primary_cb (gatt-client.c:1101)
=3D=3D30400=3D=3D    by 0x1ACDC6: discovery_op_complete (gatt-helpers.c:628)
=3D=3D30400=3D=3D    by 0x1ACFF8: read_by_grp_type_cb (gatt-helpers.c:730)
=3D=3D30400=3D=3D    by 0x1A2DA0: handle_rsp (att.c:707)
=3D=3D30400=3D=3D    by 0x1A2DA0: can_read_data (att.c:879)
=3D=3D30400=3D=3D    by 0x1ABCD2: watch_callback (io-glib.c:170)
=3D=3D30400=3D=3D    by 0x4E828C4: g_main_context_dispatch (in /usr/lib/lib=
glib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82C87: ??? (in /usr/lib/libglib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82FA1: g_main_loop_run (in /usr/lib/libglib-2.0=
.so.0.5200.3)
=3D=3D30400=3D=3D  Block was alloc'd at
=3D=3D30400=3D=3D    at 0x4C2DF55: calloc (in /usr/lib/valgrind/vgpreload_m=
emcheck-amd64-linux.so)
=3D=3D30400=3D=3D    by 0x4E88080: g_malloc0 (in /usr/lib/libglib-2.0.so.0.=
5200.3)
=3D=3D30400=3D=3D    by 0x17DF2D: browse_request_new.part.26 (device.c:5016)
=3D=3D30400=3D=3D    by 0x17DFCD: browse_request_new (device.c:5013)
=3D=3D30400=3D=3D    by 0x17DFCD: device_browse_sdp (device.c:5116)
=3D=3D30400=3D=3D    by 0x182A31: connect_profiles (device.c:1772)
=3D=3D30400=3D=3D    by 0x19AA5A: process_message.isra.6 (object.c:259)
=3D=3D30400=3D=3D    by 0x51708D2: ??? (in /usr/lib/libdbus-1.so.3.14.11)
=3D=3D30400=3D=3D    by 0x5161F53: dbus_connection_dispatch (in /usr/lib/li=
bdbus-1.so.3.14.11)
=3D=3D30400=3D=3D    by 0x197150: message_dispatch (mainloop.c:72)
=3D=3D30400=3D=3D    by 0x4E828C4: g_main_context_dispatch (in /usr/lib/lib=
glib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82C87: ??? (in /usr/lib/libglib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82FA1: g_main_loop_run (in /usr/lib/libglib-2.0=
.so.0.5200.3)
=3D=3D30400=3D=3D =

=3D=3D30400=3D=3D Invalid read of size 8
=3D=3D30400=3D=3D    at 0x184E47: update_bredr_services (device.c:4346)
=3D=3D30400=3D=3D    by 0x18566C: search_cb (device.c:4535)
=3D=3D30400=3D=3D    by 0x18566C: browse_cb (device.c:4600)
=3D=3D30400=3D=3D    by 0x15F8DF: search_completed_cb (sdp-client.c:205)
=3D=3D30400=3D=3D    by 0x195C29: sdp_process (sdp.c:4354)
=3D=3D30400=3D=3D    by 0x15FA35: search_process_cb (sdp-client.c:230)
=3D=3D30400=3D=3D    by 0x4E828C4: g_main_context_dispatch (in /usr/lib/lib=
glib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82C87: ??? (in /usr/lib/libglib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82FA1: g_main_loop_run (in /usr/lib/libglib-2.0=
.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x11FE0B: main (main.c:733)
=3D=3D30400=3D=3D  Address 0x6c91428 is 8 bytes inside a block of size 64 f=
ree'd
=3D=3D30400=3D=3D    at 0x4C2D16B: free (in /usr/lib/valgrind/vgpreload_mem=
check-amd64-linux.so)
=3D=3D30400=3D=3D    by 0x1830B8: gatt_client_ready_cb (device.c:4692)
=3D=3D30400=3D=3D    by 0x1A57BE: notify_client_ready.part.11 (gatt-client.=
c:1129)
=3D=3D30400=3D=3D    by 0x1A352F: discovery_op_complete (gatt-client.c:379)
=3D=3D30400=3D=3D    by 0x1A4078: discover_primary_cb (gatt-client.c:1101)
=3D=3D30400=3D=3D    by 0x1ACDC6: discovery_op_complete (gatt-helpers.c:628)
=3D=3D30400=3D=3D    by 0x1ACFF8: read_by_grp_type_cb (gatt-helpers.c:730)
=3D=3D30400=3D=3D    by 0x1A2DA0: handle_rsp (att.c:707)
=3D=3D30400=3D=3D    by 0x1A2DA0: can_read_data (att.c:879)
=3D=3D30400=3D=3D    by 0x1ABCD2: watch_callback (io-glib.c:170)
=3D=3D30400=3D=3D    by 0x4E828C4: g_main_context_dispatch (in /usr/lib/lib=
glib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82C87: ??? (in /usr/lib/libglib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82FA1: g_main_loop_run (in /usr/lib/libglib-2.0=
.so.0.5200.3)
=3D=3D30400=3D=3D  Block was alloc'd at
=3D=3D30400=3D=3D    at 0x4C2DF55: calloc (in /usr/lib/valgrind/vgpreload_m=
emcheck-amd64-linux.so)
=3D=3D30400=3D=3D    by 0x4E88080: g_malloc0 (in /usr/lib/libglib-2.0.so.0.=
5200.3)
=3D=3D30400=3D=3D    by 0x17DF2D: browse_request_new.part.26 (device.c:5016)
=3D=3D30400=3D=3D    by 0x17DFCD: browse_request_new (device.c:5013)
=3D=3D30400=3D=3D    by 0x17DFCD: device_browse_sdp (device.c:5116)
=3D=3D30400=3D=3D    by 0x182A31: connect_profiles (device.c:1772)
=3D=3D30400=3D=3D    by 0x19AA5A: process_message.isra.6 (object.c:259)
=3D=3D30400=3D=3D    by 0x51708D2: ??? (in /usr/lib/libdbus-1.so.3.14.11)
=3D=3D30400=3D=3D    by 0x5161F53: dbus_connection_dispatch (in /usr/lib/li=
bdbus-1.so.3.14.11)
=3D=3D30400=3D=3D    by 0x197150: message_dispatch (mainloop.c:72)
=3D=3D30400=3D=3D    by 0x4E828C4: g_main_context_dispatch (in /usr/lib/lib=
glib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82C87: ??? (in /usr/lib/libglib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82FA1: g_main_loop_run (in /usr/lib/libglib-2.0=
.so.0.5200.3)
=3D=3D30400=3D=3D =

=3D=3D30400=3D=3D Invalid read of size 8
=3D=3D30400=3D=3D    at 0x185686: search_cb (device.c:4544)
=3D=3D30400=3D=3D    by 0x185686: browse_cb (device.c:4600)
=3D=3D30400=3D=3D    by 0x15F8DF: search_completed_cb (sdp-client.c:205)
=3D=3D30400=3D=3D    by 0x195C29: sdp_process (sdp.c:4354)
=3D=3D30400=3D=3D    by 0x15FA35: search_process_cb (sdp-client.c:230)
=3D=3D30400=3D=3D    by 0x4E828C4: g_main_context_dispatch (in /usr/lib/lib=
glib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82C87: ??? (in /usr/lib/libglib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82FA1: g_main_loop_run (in /usr/lib/libglib-2.0=
.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x11FE0B: main (main.c:733)
=3D=3D30400=3D=3D  Address 0x6c91440 is 32 bytes inside a block of size 64 =
free'd
=3D=3D30400=3D=3D    at 0x4C2D16B: free (in /usr/lib/valgrind/vgpreload_mem=
check-amd64-linux.so)
=3D=3D30400=3D=3D    by 0x1830B8: gatt_client_ready_cb (device.c:4692)
=3D=3D30400=3D=3D    by 0x1A57BE: notify_client_ready.part.11 (gatt-client.=
c:1129)
=3D=3D30400=3D=3D    by 0x1A352F: discovery_op_complete (gatt-client.c:379)
=3D=3D30400=3D=3D    by 0x1A4078: discover_primary_cb (gatt-client.c:1101)
=3D=3D30400=3D=3D    by 0x1ACDC6: discovery_op_complete (gatt-helpers.c:628)
=3D=3D30400=3D=3D    by 0x1ACFF8: read_by_grp_type_cb (gatt-helpers.c:730)
=3D=3D30400=3D=3D    by 0x1A2DA0: handle_rsp (att.c:707)
=3D=3D30400=3D=3D    by 0x1A2DA0: can_read_data (att.c:879)
=3D=3D30400=3D=3D    by 0x1ABCD2: watch_callback (io-glib.c:170)
=3D=3D30400=3D=3D    by 0x4E828C4: g_main_context_dispatch (in /usr/lib/lib=
glib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82C87: ??? (in /usr/lib/libglib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82FA1: g_main_loop_run (in /usr/lib/libglib-2.0=
.so.0.5200.3)
=3D=3D30400=3D=3D  Block was alloc'd at
=3D=3D30400=3D=3D    at 0x4C2DF55: calloc (in /usr/lib/valgrind/vgpreload_m=
emcheck-amd64-linux.so)
=3D=3D30400=3D=3D    by 0x4E88080: g_malloc0 (in /usr/lib/libglib-2.0.so.0.=
5200.3)
=3D=3D30400=3D=3D    by 0x17DF2D: browse_request_new.part.26 (device.c:5016)
=3D=3D30400=3D=3D    by 0x17DFCD: browse_request_new (device.c:5013)
=3D=3D30400=3D=3D    by 0x17DFCD: device_browse_sdp (device.c:5116)
=3D=3D30400=3D=3D    by 0x182A31: connect_profiles (device.c:1772)
=3D=3D30400=3D=3D    by 0x19AA5A: process_message.isra.6 (object.c:259)
=3D=3D30400=3D=3D    by 0x51708D2: ??? (in /usr/lib/libdbus-1.so.3.14.11)
=3D=3D30400=3D=3D    by 0x5161F53: dbus_connection_dispatch (in /usr/lib/li=
bdbus-1.so.3.14.11)
=3D=3D30400=3D=3D    by 0x197150: message_dispatch (mainloop.c:72)
=3D=3D30400=3D=3D    by 0x4E828C4: g_main_context_dispatch (in /usr/lib/lib=
glib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82C87: ??? (in /usr/lib/libglib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82FA1: g_main_loop_run (in /usr/lib/libglib-2.0=
.so.0.5200.3)
=3D=3D30400=3D=3D =

=3D=3D30400=3D=3D Invalid read of size 8
=3D=3D30400=3D=3D    at 0x18568A: search_cb (device.c:4541)
=3D=3D30400=3D=3D    by 0x18568A: browse_cb (device.c:4600)
=3D=3D30400=3D=3D    by 0x15F8DF: search_completed_cb (sdp-client.c:205)
=3D=3D30400=3D=3D    by 0x195C29: sdp_process (sdp.c:4354)
=3D=3D30400=3D=3D    by 0x15FA35: search_process_cb (sdp-client.c:230)
=3D=3D30400=3D=3D    by 0x4E828C4: g_main_context_dispatch (in /usr/lib/lib=
glib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82C87: ??? (in /usr/lib/libglib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82FA1: g_main_loop_run (in /usr/lib/libglib-2.0=
.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x11FE0B: main (main.c:733)
=3D=3D30400=3D=3D  Address 0x6c91448 is 40 bytes inside a block of size 64 =
free'd
=3D=3D30400=3D=3D    at 0x4C2D16B: free (in /usr/lib/valgrind/vgpreload_mem=
check-amd64-linux.so)
=3D=3D30400=3D=3D    by 0x1830B8: gatt_client_ready_cb (device.c:4692)
=3D=3D30400=3D=3D    by 0x1A57BE: notify_client_ready.part.11 (gatt-client.=
c:1129)
=3D=3D30400=3D=3D    by 0x1A352F: discovery_op_complete (gatt-client.c:379)
=3D=3D30400=3D=3D    by 0x1A4078: discover_primary_cb (gatt-client.c:1101)
=3D=3D30400=3D=3D    by 0x1ACDC6: discovery_op_complete (gatt-helpers.c:628)
=3D=3D30400=3D=3D    by 0x1ACFF8: read_by_grp_type_cb (gatt-helpers.c:730)
=3D=3D30400=3D=3D    by 0x1A2DA0: handle_rsp (att.c:707)
=3D=3D30400=3D=3D    by 0x1A2DA0: can_read_data (att.c:879)
=3D=3D30400=3D=3D    by 0x1ABCD2: watch_callback (io-glib.c:170)
=3D=3D30400=3D=3D    by 0x4E828C4: g_main_context_dispatch (in /usr/lib/lib=
glib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82C87: ??? (in /usr/lib/libglib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82FA1: g_main_loop_run (in /usr/lib/libglib-2.0=
.so.0.5200.3)
=3D=3D30400=3D=3D  Block was alloc'd at
=3D=3D30400=3D=3D    at 0x4C2DF55: calloc (in /usr/lib/valgrind/vgpreload_m=
emcheck-amd64-linux.so)
=3D=3D30400=3D=3D    by 0x4E88080: g_malloc0 (in /usr/lib/libglib-2.0.so.0.=
5200.3)
=3D=3D30400=3D=3D    by 0x17DF2D: browse_request_new.part.26 (device.c:5016)
=3D=3D30400=3D=3D    by 0x17DFCD: browse_request_new (device.c:5013)
=3D=3D30400=3D=3D    by 0x17DFCD: device_browse_sdp (device.c:5116)
=3D=3D30400=3D=3D    by 0x182A31: connect_profiles (device.c:1772)
=3D=3D30400=3D=3D    by 0x19AA5A: process_message.isra.6 (object.c:259)
=3D=3D30400=3D=3D    by 0x51708D2: ??? (in /usr/lib/libdbus-1.so.3.14.11)
=3D=3D30400=3D=3D    by 0x5161F53: dbus_connection_dispatch (in /usr/lib/li=
bdbus-1.so.3.14.11)
=3D=3D30400=3D=3D    by 0x197150: message_dispatch (mainloop.c:72)
=3D=3D30400=3D=3D    by 0x4E828C4: g_main_context_dispatch (in /usr/lib/lib=
glib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82C87: ??? (in /usr/lib/libglib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82FA1: g_main_loop_run (in /usr/lib/libglib-2.0=
.so.0.5200.3)
=3D=3D30400=3D=3D =

=3D=3D30400=3D=3D Invalid write of size 8
=3D=3D30400=3D=3D    at 0x185698: search_cb (device.c:4542)
=3D=3D30400=3D=3D    by 0x185698: browse_cb (device.c:4600)
=3D=3D30400=3D=3D    by 0x15F8DF: search_completed_cb (sdp-client.c:205)
=3D=3D30400=3D=3D    by 0x195C29: sdp_process (sdp.c:4354)
=3D=3D30400=3D=3D    by 0x15FA35: search_process_cb (sdp-client.c:230)
=3D=3D30400=3D=3D    by 0x4E828C4: g_main_context_dispatch (in /usr/lib/lib=
glib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82C87: ??? (in /usr/lib/libglib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82FA1: g_main_loop_run (in /usr/lib/libglib-2.0=
.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x11FE0B: main (main.c:733)
=3D=3D30400=3D=3D  Address 0x6c91448 is 40 bytes inside a block of size 64 =
free'd
=3D=3D30400=3D=3D    at 0x4C2D16B: free (in /usr/lib/valgrind/vgpreload_mem=
check-amd64-linux.so)
=3D=3D30400=3D=3D    by 0x1830B8: gatt_client_ready_cb (device.c:4692)
=3D=3D30400=3D=3D    by 0x1A57BE: notify_client_ready.part.11 (gatt-client.=
c:1129)
=3D=3D30400=3D=3D    by 0x1A352F: discovery_op_complete (gatt-client.c:379)
=3D=3D30400=3D=3D    by 0x1A4078: discover_primary_cb (gatt-client.c:1101)
=3D=3D30400=3D=3D    by 0x1ACDC6: discovery_op_complete (gatt-helpers.c:628)
=3D=3D30400=3D=3D    by 0x1ACFF8: read_by_grp_type_cb (gatt-helpers.c:730)
=3D=3D30400=3D=3D    by 0x1A2DA0: handle_rsp (att.c:707)
=3D=3D30400=3D=3D    by 0x1A2DA0: can_read_data (att.c:879)
=3D=3D30400=3D=3D    by 0x1ABCD2: watch_callback (io-glib.c:170)
=3D=3D30400=3D=3D    by 0x4E828C4: g_main_context_dispatch (in /usr/lib/lib=
glib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82C87: ??? (in /usr/lib/libglib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82FA1: g_main_loop_run (in /usr/lib/libglib-2.0=
.so.0.5200.3)
=3D=3D30400=3D=3D  Block was alloc'd at
=3D=3D30400=3D=3D    at 0x4C2DF55: calloc (in /usr/lib/valgrind/vgpreload_m=
emcheck-amd64-linux.so)
=3D=3D30400=3D=3D    by 0x4E88080: g_malloc0 (in /usr/lib/libglib-2.0.so.0.=
5200.3)
=3D=3D30400=3D=3D    by 0x17DF2D: browse_request_new.part.26 (device.c:5016)
=3D=3D30400=3D=3D    by 0x17DFCD: browse_request_new (device.c:5013)
=3D=3D30400=3D=3D    by 0x17DFCD: device_browse_sdp (device.c:5116)
=3D=3D30400=3D=3D    by 0x182A31: connect_profiles (device.c:1772)
=3D=3D30400=3D=3D    by 0x19AA5A: process_message.isra.6 (object.c:259)
=3D=3D30400=3D=3D    by 0x51708D2: ??? (in /usr/lib/libdbus-1.so.3.14.11)
=3D=3D30400=3D=3D    by 0x5161F53: dbus_connection_dispatch (in /usr/lib/li=
bdbus-1.so.3.14.11)
=3D=3D30400=3D=3D    by 0x197150: message_dispatch (mainloop.c:72)
=3D=3D30400=3D=3D    by 0x4E828C4: g_main_context_dispatch (in /usr/lib/lib=
glib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82C87: ??? (in /usr/lib/libglib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82FA1: g_main_loop_run (in /usr/lib/libglib-2.0=
.so.0.5200.3)
=3D=3D30400=3D=3D =

=3D=3D30400=3D=3D Invalid read of size 8
=3D=3D30400=3D=3D    at 0x1857D4: search_cb (device.c:4560)
=3D=3D30400=3D=3D    by 0x1857D4: browse_cb (device.c:4600)
=3D=3D30400=3D=3D    by 0x15F8DF: search_completed_cb (sdp-client.c:205)
=3D=3D30400=3D=3D    by 0x195C29: sdp_process (sdp.c:4354)
=3D=3D30400=3D=3D    by 0x15FA35: search_process_cb (sdp-client.c:230)
=3D=3D30400=3D=3D    by 0x4E828C4: g_main_context_dispatch (in /usr/lib/lib=
glib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82C87: ??? (in /usr/lib/libglib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82FA1: g_main_loop_run (in /usr/lib/libglib-2.0=
.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x11FE0B: main (main.c:733)
=3D=3D30400=3D=3D  Address 0x6c91440 is 32 bytes inside a block of size 64 =
free'd
=3D=3D30400=3D=3D    at 0x4C2D16B: free (in /usr/lib/valgrind/vgpreload_mem=
check-amd64-linux.so)
=3D=3D30400=3D=3D    by 0x1830B8: gatt_client_ready_cb (device.c:4692)
=3D=3D30400=3D=3D    by 0x1A57BE: notify_client_ready.part.11 (gatt-client.=
c:1129)
=3D=3D30400=3D=3D    by 0x1A352F: discovery_op_complete (gatt-client.c:379)
=3D=3D30400=3D=3D    by 0x1A4078: discover_primary_cb (gatt-client.c:1101)
=3D=3D30400=3D=3D    by 0x1ACDC6: discovery_op_complete (gatt-helpers.c:628)
=3D=3D30400=3D=3D    by 0x1ACFF8: read_by_grp_type_cb (gatt-helpers.c:730)
=3D=3D30400=3D=3D    by 0x1A2DA0: handle_rsp (att.c:707)
=3D=3D30400=3D=3D    by 0x1A2DA0: can_read_data (att.c:879)
=3D=3D30400=3D=3D    by 0x1ABCD2: watch_callback (io-glib.c:170)
=3D=3D30400=3D=3D    by 0x4E828C4: g_main_context_dispatch (in /usr/lib/lib=
glib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82C87: ??? (in /usr/lib/libglib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82FA1: g_main_loop_run (in /usr/lib/libglib-2.0=
.so.0.5200.3)
=3D=3D30400=3D=3D  Block was alloc'd at
=3D=3D30400=3D=3D    at 0x4C2DF55: calloc (in /usr/lib/valgrind/vgpreload_m=
emcheck-amd64-linux.so)
=3D=3D30400=3D=3D    by 0x4E88080: g_malloc0 (in /usr/lib/libglib-2.0.so.0.=
5200.3)
=3D=3D30400=3D=3D    by 0x17DF2D: browse_request_new.part.26 (device.c:5016)
=3D=3D30400=3D=3D    by 0x17DFCD: browse_request_new (device.c:5013)
=3D=3D30400=3D=3D    by 0x17DFCD: device_browse_sdp (device.c:5116)
=3D=3D30400=3D=3D    by 0x182A31: connect_profiles (device.c:1772)
=3D=3D30400=3D=3D    by 0x19AA5A: process_message.isra.6 (object.c:259)
=3D=3D30400=3D=3D    by 0x51708D2: ??? (in /usr/lib/libdbus-1.so.3.14.11)
=3D=3D30400=3D=3D    by 0x5161F53: dbus_connection_dispatch (in /usr/lib/li=
bdbus-1.so.3.14.11)
=3D=3D30400=3D=3D    by 0x197150: message_dispatch (mainloop.c:72)
=3D=3D30400=3D=3D    by 0x4E828C4: g_main_context_dispatch (in /usr/lib/lib=
glib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82C87: ??? (in /usr/lib/libglib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82FA1: g_main_loop_run (in /usr/lib/libglib-2.0=
.so.0.5200.3)
=3D=3D30400=3D=3D =

=3D=3D30400=3D=3D Invalid read of size 8
=3D=3D30400=3D=3D    at 0x1857E0: search_cb (device.c:4563)
=3D=3D30400=3D=3D    by 0x1857E0: browse_cb (device.c:4600)
=3D=3D30400=3D=3D    by 0x15F8DF: search_completed_cb (sdp-client.c:205)
=3D=3D30400=3D=3D    by 0x195C29: sdp_process (sdp.c:4354)
=3D=3D30400=3D=3D    by 0x15FA35: search_process_cb (sdp-client.c:230)
=3D=3D30400=3D=3D    by 0x4E828C4: g_main_context_dispatch (in /usr/lib/lib=
glib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82C87: ??? (in /usr/lib/libglib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82FA1: g_main_loop_run (in /usr/lib/libglib-2.0=
.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x11FE0B: main (main.c:733)
=3D=3D30400=3D=3D  Address 0x6c91428 is 8 bytes inside a block of size 64 f=
ree'd
=3D=3D30400=3D=3D    at 0x4C2D16B: free (in /usr/lib/valgrind/vgpreload_mem=
check-amd64-linux.so)
=3D=3D30400=3D=3D    by 0x1830B8: gatt_client_ready_cb (device.c:4692)
=3D=3D30400=3D=3D    by 0x1A57BE: notify_client_ready.part.11 (gatt-client.=
c:1129)
=3D=3D30400=3D=3D    by 0x1A352F: discovery_op_complete (gatt-client.c:379)
=3D=3D30400=3D=3D    by 0x1A4078: discover_primary_cb (gatt-client.c:1101)
=3D=3D30400=3D=3D    by 0x1ACDC6: discovery_op_complete (gatt-helpers.c:628)
=3D=3D30400=3D=3D    by 0x1ACFF8: read_by_grp_type_cb (gatt-helpers.c:730)
=3D=3D30400=3D=3D    by 0x1A2DA0: handle_rsp (att.c:707)
=3D=3D30400=3D=3D    by 0x1A2DA0: can_read_data (att.c:879)
=3D=3D30400=3D=3D    by 0x1ABCD2: watch_callback (io-glib.c:170)
=3D=3D30400=3D=3D    by 0x4E828C4: g_main_context_dispatch (in /usr/lib/lib=
glib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82C87: ??? (in /usr/lib/libglib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82FA1: g_main_loop_run (in /usr/lib/libglib-2.0=
.so.0.5200.3)
=3D=3D30400=3D=3D  Block was alloc'd at
=3D=3D30400=3D=3D    at 0x4C2DF55: calloc (in /usr/lib/valgrind/vgpreload_m=
emcheck-amd64-linux.so)
=3D=3D30400=3D=3D    by 0x4E88080: g_malloc0 (in /usr/lib/libglib-2.0.so.0.=
5200.3)
=3D=3D30400=3D=3D    by 0x17DF2D: browse_request_new.part.26 (device.c:5016)
=3D=3D30400=3D=3D    by 0x17DFCD: browse_request_new (device.c:5013)
=3D=3D30400=3D=3D    by 0x17DFCD: device_browse_sdp (device.c:5116)
=3D=3D30400=3D=3D    by 0x182A31: connect_profiles (device.c:1772)
=3D=3D30400=3D=3D    by 0x19AA5A: process_message.isra.6 (object.c:259)
=3D=3D30400=3D=3D    by 0x51708D2: ??? (in /usr/lib/libdbus-1.so.3.14.11)
=3D=3D30400=3D=3D    by 0x5161F53: dbus_connection_dispatch (in /usr/lib/li=
bdbus-1.so.3.14.11)
=3D=3D30400=3D=3D    by 0x197150: message_dispatch (mainloop.c:72)
=3D=3D30400=3D=3D    by 0x4E828C4: g_main_context_dispatch (in /usr/lib/lib=
glib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82C87: ??? (in /usr/lib/libglib-2.0.so.0.5200.3)
=3D=3D30400=3D=3D    by 0x4E82FA1: g_main_loop_run (in /usr/lib/libglib-2.0=
.so.0.5200.3)
=3D=3D30400=3D=3D =

=3D=3D30400=3D=3D =

=3D=3D30400=3D=3D HEAP SUMMARY:
=3D=3D30400=3D=3D     in use at exit: 43,207 bytes in 337 blocks
=3D=3D30400=3D=3D   total heap usage: 8,283 allocs, 7,946 frees, 682,147 by=
tes allocated
=3D=3D30400=3D=3D =

=3D=3D30400=3D=3D LEAK SUMMARY:
=3D=3D30400=3D=3D    definitely lost: 16 bytes in 1 blocks
=3D=3D30400=3D=3D    indirectly lost: 302 bytes in 11 blocks
=3D=3D30400=3D=3D      possibly lost: 0 bytes in 0 blocks
=3D=3D30400=3D=3D    still reachable: 42,889 bytes in 325 blocks
=3D=3D30400=3D=3D         suppressed: 0 bytes in 0 blocks
=3D=3D30400=3D=3D Rerun with --leak-check=3Dfull to see details of leaked m=
emory
=3D=3D30400=3D=3D =

=3D=3D30400=3D=3D For counts of detected and suppressed errors, rerun with:=
 -v
=3D=3D30400=3D=3D ERROR SUMMARY: 57 errors from 20 contexts (suppressed: 0 =
from 0)

--===============5562411942861578980==--
