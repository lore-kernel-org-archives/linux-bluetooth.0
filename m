Return-Path: <cyrus@holtmann.org>
From: Bharat Bhusan Panda <bharat.panda@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: 'Luiz Augusto von Dentz' <luiz.dentz@gmail.com>
References: <041c01d0a35e$eedcb780$cc962680$@samsung.com>
In-reply-to: <041c01d0a35e$eedcb780$cc962680$@samsung.com>
Subject: RE: Query on AVRCP PTS testing
Date: Wed, 10 Jun 2015 16:28:11 +0530
Message-id: <043001d0a36c$5e8b3040$1ba190c0$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

Please find below logs with valgrind,

==19866== Invalid read of size 8
==19866==    at 0x426817: avrcp_handle_event (avrcp.c:3102)
==19866==    by 0x4208B3: session_cb (avctp.c:831)
==19866==    by 0x4E7FCE4: g_main_context_dispatch (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.4002.0)
==19866==    by 0x4E80047: g_main_context_iterate.isra.24 (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.4002.0)
==19866==    by 0x4E80309: g_main_loop_run (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.4002.0)
==19866==    by 0x40B2AE: main (main.c:661)
==19866==  Address 0x50 is not stack'd, malloc'd or (recently) free'd
==19866== 
==19866== 
==19866== Process terminating with default action of signal 11 (SIGSEGV)
==19866==  Access not within mapped region at address 0x50
==19866==    at 0x426817: avrcp_handle_event (avrcp.c:3102)
==19866==    by 0x4208B3: session_cb (avctp.c:831)
==19866==    by 0x4E7FCE4: g_main_context_dispatch (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.4002.0)
==19866==    by 0x4E80047: g_main_context_iterate.isra.24 (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.4002.0)
==19866==    by 0x4E80309: g_main_loop_run (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.4002.0)
==19866==    by 0x40B2AE: main (main.c:661)
==19866==  If you believe this happened as a result of a stack
==19866==  overflow in your program's main thread (unlikely but
==19866==  possible), you can try to increase the size of the
==19866==  main thread stack using the --main-stacksize= flag.
==19866==  The main thread stack size used in this run was 8388608.
==19866== 
==19866== FILE DESCRIPTORS: 27 open at exit.
==19866== Open pf-31 socket 26:
==19866==    at 0x588B6B7: socket (syscall-template.S:81)
==19866==    by 0x44A6E8: create_io (btio.c:1532)
==19866==    by 0x44C84E: bt_io_connect (btio.c:1606)
==19866==    by 0x422B69: avctp_connect_browsing (avctp.c:2028)
==19866==    by 0x4265CD: avrcp_get_capabilities_resp (avrcp.c:3260)
==19866==    by 0x4208B3: session_cb (avctp.c:831)
==19866==    by 0x4E7FCE4: g_main_context_dispatch (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.4002.0)
==19866==    by 0x4E80047: g_main_context_iterate.isra.24 (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.4002.0)
==19866==    by 0x4E80309: g_main_loop_run (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.4002.0)
==19866==    by 0x40B2AE: main (main.c:661)
==19866== 
==19866== Open file descriptor 25: /dev/uinput
==19866==    at 0x587B620: __open_nocancel (syscall-template.S:81)
==19866==    by 0x422580: avctp_connect_cb (fcntl2.h:53)
==19866==    by 0x449A3B: accept_cb (btio.c:203)
==19866==    by 0x4E7FCE4: g_main_context_dispatch (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.4002.0)
==19866==    by 0x4E80047: g_main_context_iterate.isra.24 (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.4002.0)
==19866==    by 0x4E80309: g_main_loop_run (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.4002.0)
==19866==    by 0x40B2AE: main (main.c:661)
==19866== 
==19866== Open pf-31 socket 24:
==19866==    at 0x588B1D0: __accept_nocancel (syscall-template.S:81)
==19866==    by 0x449EB2: server_cb (btio.c:252)
==19866==    by 0x4E7FCE4: g_main_context_dispatch (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.4002.0)
==19866==    by 0x4E80047: g_main_context_iterate.isra.24 (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.4002.0)
==19866==    by 0x4E80309: g_main_loop_run (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.4002.0)
==19866==    by 0x40B2AE: main (main.c:661)
==19866== 
==19866== Open pf-31 socket 23:
==19866==    at 0x588B6B7: socket (syscall-template.S:81)
==19866==    by 0x484935: sdp_connect (sdp.c:4687)
==19866==    by 0x458520: bt_search_service (sdp-client.c:308)
==19866==    by 0x4728BF: device_browse_sdp (device.c:4661)
==19866==    by 0x475BD4: start_discovery (device.c:4849)
==19866==    by 0x4E7FCE4: g_main_context_dispatch (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.4002.0)
==19866==    by 0x4E80047: g_main_context_iterate.isra.24 (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.4002.0)
==19866==    by 0x4E80309: g_main_loop_run (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.4002.0)
==19866==    by 0x40B2AE: main (main.c:661)
==19866== 
==19866== Open pf-31 socket 22:
==19866==    at 0x588B1D0: __accept_nocancel (syscall-template.S:81)
==19866==    by 0x449EB2: server_cb (btio.c:252)
==19866==    by 0x4E7FCE4: g_main_context_dispatch (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.4002.0)
==19866==    by 0x4E80047: g_main_context_iterate.isra.24 (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.4002.0)
==19866==    by 0x4E80309: g_main_loop_run (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.4002.0)
==19866==    by 0x40B2AE: main (main.c:661)
==19866== 
==19866== Open pf-31 socket 21:
==19866==    at 0x588B6B7: socket (syscall-template.S:81)
==19866==    by 0x44A6E8: create_io (btio.c:1532)
==19866==    by 0x44CB3C: bt_io_listen (btio.c:1658)
==19866==    by 0x41655F: a2dp_add_sep (a2dp.c:1522)
==19866==    by 0x41D72B: register_endpoint (media.c:612)
==19866==    by 0x48A8B3: process_message.isra.5 (object.c:259)
==19866==    by 0x515AE95: ??? (in /lib/x86_64-linux-gnu/libdbus-1.so.3.7.6)
==19866==    by 0x514DA20: dbus_connection_dispatch (in
/lib/x86_64-linux-gnu/libdbus-1.so.3.7.6)
==19866==    by 0x48751F: message_dispatch (mainloop.c:72)
==19866==    by 0x4E7FCE4: g_main_context_dispatch (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.4002.0)
==19866==    by 0x4E80047: g_main_context_iterate.isra.24 (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.4002.0)
==19866==    by 0x4E80309: g_main_loop_run (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.4002.0)
==19866== 
==19866== Open pf-31 socket 20:
==19866==    at 0x588B6B7: socket (syscall-template.S:81)
==19866==    by 0x44A7C3: create_io (btio.c:1547)
==19866==    by 0x44CB3C: bt_io_listen (btio.c:1658)
==19866==    by 0x411BF0: sap_server_register (server.c:1378)
==19866==    by 0x462796: probe_profile (adapter.c:3649)
==19866==    by 0x46CB4B: btd_profile_foreach (profile.c:702)
==19866==    by 0x468E69: read_info_complete (adapter.c:7367)
==19866==    by 0x48E225: request_complete (mgmt.c:242)
==19866==    by 0x48EB9C: can_read_data (mgmt.c:321)
==19866==    by 0x49A1E4: watch_callback (io-glib.c:170)
==19866==    by 0x4E7FCE4: g_main_context_dispatch (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.4002.0)
==19866==    by 0x4E80047: g_main_context_iterate.isra.24 (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.4002.0)
==19866== 
==19866== Open pf-31 socket 19:
==19866==    at 0x588B6B7: socket (syscall-template.S:81)
==19866==    by 0x44A6E8: create_io (btio.c:1532)
==19866==    by 0x44CB3C: bt_io_listen (btio.c:1658)
==19866==    by 0x42021A: avctp_server_socket (avctp.c:1464)
==19866==    by 0x421EA4: avctp_register (avctp.c:1493)
==19866==    by 0x423582: avrcp_server_register (avrcp.c:3652)
==19866==    by 0x425C27: avrcp_controller_server_probe (avrcp.c:3952)
==19866==    by 0x462796: probe_profile (adapter.c:3649)
==19866==    by 0x46CB4B: btd_profile_foreach (profile.c:702)
==19866==    by 0x468E69: read_info_complete (adapter.c:7367)
==19866==    by 0x48E225: request_complete (mgmt.c:242)
==19866==    by 0x48EB9C: can_read_data (mgmt.c:321)
==19866== 
==19866== Open pf-31 socket 18:
==19866==    at 0x588B6B7: socket (syscall-template.S:81)
==19866==    by 0x44A6E8: create_io (btio.c:1532)
==19866==    by 0x44CB3C: bt_io_listen (btio.c:1658)
==19866==    by 0x42021A: avctp_server_socket (avctp.c:1464)
==19866==    by 0x421E86: avctp_register (avctp.c:1487)
==19866==    by 0x423582: avrcp_server_register (avrcp.c:3652)
==19866==    by 0x425C27: avrcp_controller_server_probe (avrcp.c:3952)
==19866==    by 0x462796: probe_profile (adapter.c:3649)
==19866==    by 0x46CB4B: btd_profile_foreach (profile.c:702)
==19866==    by 0x468E69: read_info_complete (adapter.c:7367)
==19866==    by 0x48E225: request_complete (mgmt.c:242)
==19866==    by 0x48EB9C: can_read_data (mgmt.c:321)
==19866== 
==19866== Open pf-31 socket 17:
==19866==    at 0x588B6B7: socket (syscall-template.S:81)
==19866==    by 0x44A6E8: create_io (btio.c:1532)
==19866==    by 0x44CB3C: bt_io_listen (btio.c:1658)
==19866==    by 0x42C52D: server_register (server.c:668)
==19866==    by 0x462796: probe_profile (adapter.c:3649)
==19866==    by 0x46CB4B: btd_profile_foreach (profile.c:702)
==19866==    by 0x468E69: read_info_complete (adapter.c:7367)
==19866==    by 0x48E225: request_complete (mgmt.c:242)
==19866==    by 0x48EB9C: can_read_data (mgmt.c:321)
==19866==    by 0x49A1E4: watch_callback (io-glib.c:170)
==19866==    by 0x4E7FCE4: g_main_context_dispatch (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.4002.0)
==19866==    by 0x4E80047: g_main_context_iterate.isra.24 (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.4002.0)
==19866== 
==19866== Open pf-31 socket 16:
==19866==    at 0x588B6B7: socket (syscall-template.S:81)
==19866==    by 0x44A6E8: create_io (btio.c:1532)
==19866==    by 0x44CB3C: bt_io_listen (btio.c:1658)
==19866==    by 0x42DBCA: server_start (server.c:308)
==19866==    by 0x462796: probe_profile (adapter.c:3649)
==19866==    by 0x46CB4B: btd_profile_foreach (profile.c:702)
==19866==    by 0x468E69: read_info_complete (adapter.c:7367)
==19866==    by 0x48E225: request_complete (mgmt.c:242)
==19866==    by 0x48EB9C: can_read_data (mgmt.c:321)
==19866==    by 0x49A1E4: watch_callback (io-glib.c:170)
==19866==    by 0x4E7FCE4: g_main_context_dispatch (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.4002.0)
==19866==    by 0x4E80047: g_main_context_iterate.isra.24 (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.4002.0)
==19866== 
==19866== Open pf-31 socket 15:
==19866==    at 0x588B6B7: socket (syscall-template.S:81)
==19866==    by 0x44A6E8: create_io (btio.c:1532)
==19866==    by 0x44CB3C: bt_io_listen (btio.c:1658)
==19866==    by 0x42DB94: server_start (server.c:295)
==19866==    by 0x462796: probe_profile (adapter.c:3649)
==19866==    by 0x46CB4B: btd_profile_foreach (profile.c:702)
==19866==    by 0x468E69: read_info_complete (adapter.c:7367)
==19866==    by 0x48E225: request_complete (mgmt.c:242)
==19866==    by 0x48EB9C: can_read_data (mgmt.c:321)
==19866==    by 0x49A1E4: watch_callback (io-glib.c:170)
==19866==    by 0x4E7FCE4: g_main_context_dispatch (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.4002.0)
==19866==    by 0x4E80047: g_main_context_iterate.isra.24 (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.4002.0)
==19866== 
==19866== Open socket 14:
==19866==    at 0x588B6B7: socket (syscall-template.S:81)
==19866==    by 0x48E3B8: mgmt_new_default (mgmt.c:439)
==19866==    by 0x45B0E4: btd_advertising_manager_new (advertising.c:770)
==19866==    by 0x468DF9: read_info_complete (adapter.c:7353)
==19866==    by 0x48E225: request_complete (mgmt.c:242)
==19866==    by 0x48EB9C: can_read_data (mgmt.c:321)
==19866==    by 0x49A1E4: watch_callback (io-glib.c:170)
==19866==    by 0x4E7FCE4: g_main_context_dispatch (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.4002.0)
==19866==    by 0x4E80047: g_main_context_iterate.isra.24 (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.4002.0)
==19866==    by 0x4E80309: g_main_loop_run (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.4002.0)
==19866==    by 0x40B2AE: main (main.c:661)
==19866== 
==19866== Open pf-31 socket 13:
==19866==    at 0x588B6B7: socket (syscall-template.S:81)
==19866==    by 0x44A6E8: create_io (btio.c:1532)
==19866==    by 0x44CB3C: bt_io_listen (btio.c:1658)
==19866==    by 0x456591: btd_gatt_database_new (gatt-database.c:2527)
==19866==    by 0x468DCE: read_info_complete (adapter.c:7342)
==19866==    by 0x48E225: request_complete (mgmt.c:242)
==19866==    by 0x48EB9C: can_read_data (mgmt.c:321)
==19866==    by 0x49A1E4: watch_callback (io-glib.c:170)
==19866==    by 0x4E7FCE4: g_main_context_dispatch (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.4002.0)
==19866==    by 0x4E80047: g_main_context_iterate.isra.24 (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.4002.0)
==19866==    by 0x4E80309: g_main_loop_run (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.4002.0)
==19866==    by 0x40B2AE: main (main.c:661)
==19866== 
==19866== Open pf-31 socket 12:
==19866==    at 0x588B6B7: socket (syscall-template.S:81)
==19866==    by 0x44A6E8: create_io (btio.c:1532)
==19866==    by 0x44CB3C: bt_io_listen (btio.c:1658)
==19866==    by 0x456557: btd_gatt_database_new (gatt-database.c:2514)
==19866==    by 0x468DCE: read_info_complete (adapter.c:7342)
==19866==    by 0x48E225: request_complete (mgmt.c:242)
==19866==    by 0x48EB9C: can_read_data (mgmt.c:321)
==19866==    by 0x49A1E4: watch_callback (io-glib.c:170)
==19866==    by 0x4E7FCE4: g_main_context_dispatch (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.4002.0)
==19866==    by 0x4E80047: g_main_context_iterate.isra.24 (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.4002.0)
==19866==    by 0x4E80309: g_main_loop_run (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.4002.0)
==19866==    by 0x40B2AE: main (main.c:661)
==19866== 
==19866== Open file descriptor 11: /dev/rfkill
==19866==    at 0x587B620: __open_nocancel (syscall-template.S:81)
==19866==    by 0x44D621: rfkill_init (fcntl2.h:53)
==19866==    by 0x40B221: main (main.c:640)
==19866== 
==19866== Open pf-16 socket 10:
==19866==    at 0x588B6B7: socket (syscall-template.S:81)
==19866==    by 0x67C04B3: ??? (in /lib/x86_64-linux-gnu/libudev.so.1.3.5)
==19866==    by 0x65B4EF1: sixaxis_init (sixaxis.c:555)
==19866==    by 0x459B19: plugin_init (plugin.c:200)
==19866==    by 0x40B1D7: main (main.c:635)
==19866== 
==19866== Open socket 9:
==19866==    at 0x588B6B7: socket (syscall-template.S:81)
==19866==    by 0x42AC79: bnep_init (bnep.c:79)
==19866==    by 0x42A255: network_init (manager.c:176)
==19866==    by 0x459B19: plugin_init (plugin.c:200)
==19866==    by 0x40B1D7: main (main.c:635)
==19866== 
==19866== Open pf-31 socket 8:
==19866==    at 0x588B6B7: socket (syscall-template.S:81)
==19866==    by 0x44D8E0: start_sdp_server (sdpd-server.c:71)
==19866==    by 0x40B1A6: main (main.c:622)
==19866== 
==19866== Open socket 7:
==19866==    at 0x588B6B7: socket (syscall-template.S:81)
==19866==    by 0x48E3B8: mgmt_new_default (mgmt.c:439)
==19866==    by 0x469BD1: adapter_init (adapter.c:8151)
==19866==    by 0x40B17B: main (main.c:610)
==19866== 
==19866== Open AF_UNIX socket 6: <unknown>
==19866==    at 0x588B6B7: socket (syscall-template.S:81)
==19866==    by 0x516964F: ??? (in /lib/x86_64-linux-gnu/libdbus-1.so.3.7.6)
==19866==    by 0x51699A1: ??? (in /lib/x86_64-linux-gnu/libdbus-1.so.3.7.6)
==19866==    by 0x516BDB7: ??? (in /lib/x86_64-linux-gnu/libdbus-1.so.3.7.6)
==19866==    by 0x516C098: ??? (in /lib/x86_64-linux-gnu/libdbus-1.so.3.7.6)
==19866==    by 0x5160C1E: ??? (in /lib/x86_64-linux-gnu/libdbus-1.so.3.7.6)
==19866==    by 0x514D05A: ??? (in /lib/x86_64-linux-gnu/libdbus-1.so.3.7.6)
==19866==    by 0x514906F: ??? (in /lib/x86_64-linux-gnu/libdbus-1.so.3.7.6)
==19866==    by 0x487891: g_dbus_setup_bus (mainloop.c:291)
==19866==    by 0x40B136: main (main.c:499)
==19866== 
==19866== Open AF_UNIX socket 5: <unknown>
==19866==    at 0x588B6B7: socket (syscall-template.S:81)
==19866==    by 0x5883F59: openlog_internal (syslog.c:353)
==19866==    by 0x58846DE: openlog (syslog.c:414)
==19866==    by 0x44D1E3: __btd_log_init (log.c:134)
==19866==    by 0x40AD10: main (main.c:592)
==19866== 
==19866== Open file descriptor 4:
==19866==    at 0x588A70F: signalfd (signalfd.c:29)
==19866==    by 0x40ACAA: main (main.c:432)
==19866== 
==19866== Open file descriptor 3:
==19866==    at 0x588A7A5: eventfd (eventfd.c:28)
==19866==    by 0x4EC0B27: g_wakeup_new (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.4002.0)
==19866==    by 0x4E7DA96: g_main_context_new (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.4002.0)
==19866==    by 0x4E7DB6C: g_main_context_default (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.4002.0)
==19866==    by 0x4E801A4: g_main_loop_new (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.4002.0)
==19866==    by 0x40AC45: main (main.c:588)
==19866== 
==19866== Open file descriptor 2: /dev/pts/1
==19866==    <inherited from parent>
==19866== 
==19866== Open file descriptor 1: /dev/pts/1
==19866==    <inherited from parent>
==19866== 
==19866== Open file descriptor 0: /dev/pts/1
==19866==    <inherited from parent>
==19866== 
==19866== 
==19866== HEAP SUMMARY:
==19866==     in use at exit: 122,717 bytes in 1,693 blocks
==19866==   total heap usage: 14,700 allocs, 13,007 frees, 4,877,751 bytes
allocated
==19866== 
==19866== LEAK SUMMARY:
==19866==    definitely lost: 0 bytes in 0 blocks
==19866==    indirectly lost: 0 bytes in 0 blocks
==19866==      possibly lost: 0 bytes in 0 blocks
==19866==    still reachable: 122,717 bytes in 1,693 blocks
==19866==         suppressed: 0 bytes in 0 blocks
==19866== Reachable blocks (those to which a pointer was found) are not
shown.
==19866== To see them, rerun with: --leak-check=full --show-leak-kinds=all
==19866== 
==19866== For counts of detected and suppressed errors, rerun with: -v
==19866== ERROR SUMMARY: 1 errors from 1 contexts (suppressed: 0 from 0)


> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Bharat Bhusan Panda
> Sent: Wednesday, June 10, 2015 2:52 PM
> To: linux-bluetooth@vger.kernel.org
> Cc: Luiz Augusto von Dentz
> Subject: Query on AVRCP PTS testing
> 
> Hi Luiz,
> 
> We have done some implementation for AVRCP 1.6 feature
> GetTotalNUmItems, for which we are setting up complete testing setup for
> AVRCP.
> 
> As CT side, on linux box,
> 1. bluetoothd up and running
> 2. Registered endpoint with test/simple-endpoint 3. Running bluetoothctl
> with agent registered as default agent 4. bluetooth player is also running
and
> waiting for list of available player
> 
> On TG side, PTS test suite, triggered below related test cases,
> TC_CT_MCN_NP_BV_10_C or TC_CT_MCN_CB_BV_12_C
> 
> We got the AVDTP channels connected, AVCTP connected, and PTS is waiting
> for command set browsed player to select the player
> 
> on CT side, bluez, before calling set_browsed player, bluetoothd exits
> abnormally. I could not find it why is it so.
> captured bluetoothd logs;
> 
> bluetoothd[29843]: src/adapter.c:connected_callback() hci0 device
> 00:1B:DC:07:33:50 connected eir_len 25
> bluetoothd[29843]: profiles/audio/a2dp.c:confirm_cb() AVDTP: incoming
> connect from 00:1B:DC:07:33:50
> bluetoothd[29843]: profiles/audio/source.c:source_set_state() State
> changed
> /org/bluez/hci0/dev_00_1B_DC_07_33_50: SOURCE_STATE_DISCONNECTED
> -> SOURCE_STATE_CONNECTING
> bluetoothd[29843]: profiles/audio/sink.c:sink_set_state() State changed
> /org/bluez/hci0/dev_00_1B_DC_07_33_50: SINK_STATE_DISCONNECTED ->
> SINK_STATE_CONNECTING
> bluetoothd[29843]: profiles/audio/avdtp.c:avdtp_connect_cb() AVDTP:
> connected signaling channel to 00:1B:DC:07:33:50
> bluetoothd[29843]: profiles/audio/avdtp.c:avdtp_connect_cb() AVDTP
> imtu=672,
> omtu=672
> bluetoothd[29843]: profiles/audio/avctp.c:avctp_confirm_cb() AVCTP:
> incoming connect from 00:1B:DC:07:33:50
> bluetoothd[29843]: profiles/audio/avctp.c:avctp_set_state() AVCTP
> Connecting
> bluetoothd[29843]: profiles/audio/avctp.c:avctp_connect_cb() AVCTP:
> connected to 00:1B:DC:07:33:50
> bluetoothd[29843]: profiles/audio/avctp.c:init_uinput() AVRCP: uinput
> initialized for 00:1B:DC:07:33:50
> bluetoothd[29843]: profiles/audio/avrcp.c:controller_init() 0x84dd10
version
> 0x0104
> bluetoothd[29843]:
> profiles/audio/player.c:media_player_controller_create()
> /org/bluez/hci0/dev_00_1B_DC_07_33_50/player0
> bluetoothd[29843]: profiles/audio/avrcp.c:target_init() 0x837fe0 version
> 0x0000
> bluetoothd[29843]: profiles/audio/avctp.c:avctp_set_state() AVCTP
> Connected
> bluetoothd[29843]: profiles/audio/avctp.c:avctp_set_state() AVCTP
> Browsing Connecting
> bluetoothd[29843]: profiles/audio/avctp.c:avctp_connect_browsing_cb()
> AVCTP
> Browsing: connected to 00:1B:DC:07:33:50
> bluetoothd[29843]: profiles/audio/avctp.c:avctp_set_state() AVCTP
> Browsing Connected
> bluetoothd[29843]:
> profiles/audio/player.c:media_player_controller_create()
> /org/bluez/hci0/dev_00_1B_DC_07_33_50/player1
> bluetoothd[29843]: profiles/audio/player.c:media_player_set_type() Audio,
> Video
> bluetoothd[29843]: profiles/audio/player.c:media_player_set_subtype()
> Audio Book
> bluetoothd[29843]: profiles/audio/player.c:media_player_set_status()
> stopped
> bluetoothd[29843]: profiles/audio/player.c:media_player_set_browsable()
> true
> bluetoothd[29843]: profiles/audio/player.c:media_folder_create_item()
> /Filesystem type folder uid 0
> bluetoothd[29843]: profiles/audio/player.c:media_folder_create_item()
> /org/bluez/hci0/dev_00_1B_DC_07_33_50/player1/Filesystem
> bluetoothd[29843]: profiles/audio/player.c:media_folder_create_item()
> /NowPlaying type folder uid 0
> bluetoothd[29843]: profiles/audio/player.c:media_folder_create_item()
> /org/bluez/hci0/dev_00_1B_DC_07_33_50/player1/NowPlaying
> bluetoothd[29843]: profiles/audio/player.c:media_player_set_playlist()
> /NowPlaying
> bluetoothd[29843]: profiles/audio/player.c:media_player_set_name()
> Browsed Player
> bluetoothd[29843]: profiles/audio/player.c:media_player_destroy()
> /org/bluez/hci0/dev_00_1B_DC_07_33_50/player0
> bharat.panda@bharat-ubuntu:~/bluez_avrcp/bluez$
> 
> PTS log,
> 
>                 - MTC: SDP Service record was successfully registered.
>                 - A2DP SRC SDP Service record successfully registered
>                 - A2DP SRCsuccessfully registered
>                 - MTC: IUT successfully responded to AVDTP CONNECT.
>                 - MTC: IUT successfully accepted AVCTP channel connection.
>                 - IUT disconnected AVDTP SIGNALING channel.
>                 - User canceled the current operation MMI.
>                 - AVCTP: Exiting AVCTP1 PTC
>                 - AVDTP: Exiting AVDTP1 PTC
>                 - CM_PTC_EXIT
>                 - MMI CM_EXIT
>                 - MTC: Test case ended
>                 -Final Verdict: INCONC
> 
> Any clue on this? Is there anything we missed in AVRCP setup?
> 
> Thanks
> Best Regards
> Bharat
> 
--Regards
Bharat

