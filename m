Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 5 Mar 2010 20:48:54 -0800
Message-ID: <49bf44f11003052048s5f5192ebkad57359274241e4@mail.gmail.com>
Subject: Backtrace: _dbus_check_is_valid_path
From: Grant <emailgrant@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I get the following backtrace when running /usr/sbin/bluetoothd:

process 3759: arguments to dbus_message_new_signal() were incorrect,
assertion "_dbus_check_is_valid_path (path)" failed in file
dbus-message.c line 1161.
This is normally a bug in some application using the D-Bus library.
  /usr/lib/libdbus-1.so.3 [0x7bd6ea11b797]
  /usr/lib/libdbus-1.so.3 [0x7bd6ea11ad39]
  /usr/lib/libdbus-1.so.3 [0x7bd6ea11039d]
  /usr/lib/libdbus-1.so.3(dbus_message_new_signal+0x183) [0x7bd6ea100883]
  /usr/sbin/bluetoothd(emit_property_changed+0x37) [0xe8eacada59c]
  /usr/sbin/bluetoothd [0xe8eacad6de9]
  /usr/sbin/bluetoothd(device_add_connection+0x72) [0xe8eacad6eac]
  /usr/sbin/bluetoothd(adapter_add_connection+0x55) [0xe8eacad56e6]
  /usr/sbin/bluetoothd(hcid_dbus_conn_complete+0x9e) [0xe8eacadbd76]
  /usr/sbin/bluetoothd [0xe8eacac6095]
  /usr/sbin/bluetoothd [0xe8eacac5770]
  /usr/lib/libglib-2.0.so.0(g_main_context_dispatch+0x24a) [0x7bd6ea37565a]
  /usr/lib/libglib-2.0.so.0 [0x7bd6ea378ca8]
  /usr/lib/libglib-2.0.so.0(g_main_loop_run+0x1bd) [0x7bd6ea37917d]
  /usr/sbin/bluetoothd(main+0x2a9) [0xe8eacac46fa]
  /lib/libc.so.6(__libc_start_main+0xe6) [0x7bd6e997fa26]
  /usr/sbin/bluetoothd [0xe8eacac39c9]

Program received signal SIGABRT, Aborted.
0x00007bd6e9993315 in ?? ()

Can anyone tell me how to fix this?  It used to work.

- Grant
