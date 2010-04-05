Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <t2xa10be5a01004041832lb2f4a3fen8406ab15f5173e9d@mail.gmail.com>
References: <t2xa10be5a01004041832lb2f4a3fen8406ab15f5173e9d@mail.gmail.com>
From: Manuel Naranjo <manuel@aircable.net>
Date: Sun, 4 Apr 2010 22:38:36 -0300
Message-ID: <k2ta10be5a01004041838yfc98e98q7341739e0bde1560@mail.gmail.com>
Subject: Memory corruptions on sdp resolve
To: linux-bluetooth@vger.kernel.org
Cc: Johan Hedberg <johan.hedberg@nokia.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Oops this time in plain text

Hello everyone,

Yesterday I reported over irc (nickname manuelnaranjo) I was
experiencing some memory corruption problems. Johan was kindly enough
to provide a patch, and I tested it over the day.

I was driving for 2 hours with a netbook scanning the air for obex
capable devices and eventually I was able to get a new crash,
different from the one the other day.

I'm attaching logs so you can help me find the problem.

bluetoothd -n -d output:
bluetoothd[4473]: Creating device /org/bluez/4473/hci1/dev_44_F4_59_BB_09_A6
bluetoothd[4473]: btd_device_ref(0x1a0148): ref=1
bluetoothd[4473]: btd_device_ref(0x1a0148): ref=2
bluetoothd[4473]: Discovery session 0x1a02e8 with :1.132 activated
bluetoothd[4473]: session_ref(0x1a02e8): ref=1
bluetoothd[4473]: adapter_get_device(44:F4:59:BB:09:A6)
bluetoothd[4473]: Removing device /org/bluez/4473/hci1/dev_44_F4_59_BB_09_A6
bluetoothd[4473]: btd_device_unref(0x1a0148): ref=1
bluetoothd[4473]: btd_device_unref(0x1a0148): ref=0
bluetoothd[4473]: device_free(0x1a0148)
bluetoothd[4473]: H: : error updating services: Host is down (112)
process 4473: arguments to dbus_connection_send() were incorrect,
assertion "connection != NULL" failed in file dbus-connection.c line
3139.
This is normally a bug in some application using the D-Bus library.
process 4473: arguments to dbus_message_unref() were incorrect,
assertion "!message->in_cache" failed in file dbus-message.c line
1397.
This is normally a bug in some application using the D-Bus library.
bluetoothd[4473]: btd_device_unref(0x1a0148): ref=343
*** glibc detected *** /opt/bluez/sbin/bluetoothd: corrupted
double-linked list: 0x0019c7a8 ***
======= Backtrace: =========
/lib/tls/i686/cmov/libc.so.6[0xb7dc9ff1]
/lib/tls/i686/cmov/libc.so.6[0xb7dca23a]
/lib/tls/i686/cmov/libc.so.6[0xb7dcc4e2]
/lib/tls/i686/cmov/libc.so.6(__libc_calloc+0xa9)[0xb7dce039]
/lib/tls/i686/cmov/libc.so.6(open_memstream+0x5d)[0xb7dbe66d]
/lib/tls/i686/cmov/libc.so.6(__vsyslog_chk+0x75)[0xb7e27615]
/opt/bluez/sbin/bluetoothd(debug+0x3e)[0x14428e]
/opt/bluez/sbin/bluetoothd[0x158e5c]
/opt/bluez/sbin/bluetoothd[0x1613da]
/opt/bluez/sbin/bluetoothd[0x145ac2]
/lib/libglib-2.0.so.0[0xb7f73dab]
/lib/libglib-2.0.so.0(g_main_context_dispatch+0x1f8)[0xb7f3ce88]
/lib/libglib-2.0.so.0[0xb7f40730]
/lib/libglib-2.0.so.0(g_main_loop_run+0x1bf)[0xb7f40b9f]
/opt/bluez/sbin/bluetoothd[0x143d3e]
/lib/tls/i686/cmov/libc.so.6(__libc_start_main+0xe6)[0xb7d75b56]
/opt/bluez/sbin/bluetoothd[0x117801]
======= Memory map: ========
00110000-0016e000 r-xp 00000000 08:07 321382     /opt/bluez/sbin/bluetoothd
0016e000-0016f000 r-xp 00000000 00:00 0          [vdso]
0016f000-00170000 r--p 0005e000 08:07 321382     /opt/bluez/sbin/bluetoothd
00170000-00172000 rw-p 0005f000 08:07 321382     /opt/bluez/sbin/bluetoothd
00172000-001aa000 rw-p 00000000 00:00 0          [heap]
b7b00000-b7b21000 rw-p 00000000 00:00 0
b7b21000-b7c00000 ---p 00000000 00:00 0
b7c88000-b7ca4000 r-xp 00000000 08:07 285065     /lib/libgcc_s.so.1
b7ca4000-b7ca5000 r--p 0001b000 08:07 285065     /lib/libgcc_s.so.1
b7ca5000-b7ca6000 rw-p 0001c000 08:07 285065     /lib/libgcc_s.so.1
b7ca6000-b7cca000 r-xp 00000000 08:07 310528
/lib/tls/i686/cmov/libm-2.10.1.so
b7cca000-b7ccb000 r--p 00023000 08:07 310528
/lib/tls/i686/cmov/libm-2.10.1.so
b7ccb000-b7ccc000 rw-p 00024000 08:07 310528
/lib/tls/i686/cmov/libm-2.10.1.so
b7ccc000-b7d19000 r-xp 00000000 08:07 26680      /usr/lib/libnl.so.1.1
b7d19000-b7d1a000 r--p 0004c000 08:07 26680      /usr/lib/libnl.so.1.1
b7d1a000-b7d1d000 rw-p 0004d000 08:07 26680      /usr/lib/libnl.so.1.1
b7d2c000-b7d2d000 rw-p 00000000 00:00 0
b7d2d000-b7d5c000 r-xp 00000000 08:07 285168     /lib/libpcre.so.3.12.1
b7d5c000-b7d5d000 r--p 0002e000 08:07 285168     /lib/libpcre.so.3.12.1
b7d5d000-b7d5e000 rw-p 0002f000 08:07 285168     /lib/libpcre.so.3.12.1
b7d5e000-b7d5f000 rw-p 00000000 00:00 0
b7d5f000-b7e9d000 r-xp 00000000 08:07 310524
/lib/tls/i686/cmov/libc-2.10.1.so
b7e9d000-b7e9e000 ---p 0013e000 08:07 310524
/lib/tls/i686/cmov/libc-2.10.1.so
b7e9e000-b7ea0000 r--p 0013e000 08:07 310524
/lib/tls/i686/cmov/libc-2.10.1.so
b7ea0000-b7ea1000 rw-p 00140000 08:07 310524
/lib/tls/i686/cmov/libc-2.10.1.so
b7ea1000-b7ea4000 rw-p 00000000 00:00 0
b7ea4000-b7ea6000 r-xp 00000000 08:07 310527
/lib/tls/i686/cmov/libdl-2.10.1.so
b7ea6000-b7ea7000 r--p 00001000 08:07 310527
/lib/tls/i686/cmov/libdl-2.10.1.so
b7ea7000-b7ea8000 rw-p 00002000 08:07 310527
/lib/tls/i686/cmov/libdl-2.10.1.so
b7ea8000-b7eaf000 r-xp 00000000 08:07 310540
/lib/tls/i686/cmov/librt-2.10.1.so
b7eaf000-b7eb0000 r--p 00006000 08:07 310540
/lib/tls/i686/cmov/librt-2.10.1.so
b7eb0000-b7eb1000 rw-p 00007000 08:07 310540
/lib/tls/i686/cmov/librt-2.10.1.so
b7eb1000-b7ec6000 r-xp 00000000 08:07 310538
/lib/tls/i686/cmov/libpthread-2.10.1.so
b7ec6000-b7ec7000 r--p 00014000 08:07 310538
/lib/tls/i686/cmov/libpthread-2.10.1.so
b7ec7000-b7ec8000 rw-p 00015000 08:07 310538
/lib/tls/i686/cmov/libpthread-2.10.1.so
b7ec8000-b7eca000 rw-p 00000000 00:00 0
b7eca000-b7f01000 r-xp 00000000 08:07 285099     /lib/libdbus-1.so.3.4.0
b7f01000-b7f02000 r--p 00036000 08:07 285099     /lib/libdbus-1.so.3.4.0
b7f02000-b7f03000 rw-p 00037000 08:07 285099     /lib/libdbus-1.so.3.4.0
b7f03000-b7f04000 rw-p 00000000 00:00 0
b7f04000-b7fb9000 r-xp 00000000 08:07 285198     /lib/libglib-2.0.so.0.2200.3
b7fb9000-b7fba000 r--p 000b4000 08:07 285198     /lib/libglib-2.0.so.0.2200.3
b7fba000-b7fbb000 rw-p 000b5000 08:07 285198     /lib/libglib-2.0.so.0.2200.3
b7fbe000-b7fbf000 rw-p 00000000 08:07 336783
/opt/bluez/var/lib/bluetooth/00:25:BF:01:00:9E/profiles
b7fbf000-b7fc0000 rw-p 00000000 08:07 336783
/opt/bluez/var/lib/bluetooth/00:25:BF:01:00:9E/profiles
b7fc0000-b7fc7000 r--s 00000000 08:07 34219
/usr/lib/gconv/gconv-modules.cache
b7fc7000-b7fc8000 r-xp 00000000 08:07 321444
/opt/bluez/lib/bluetooth/plugins/netlink.so
b7fc8000-b7fc9000 r--p 00000000 08:07 321444
/opt/bluez/lib/bluetooth/plugins/netlink.so
b7fc9000-b7fca000 rw-p 00001000 08:07 321444
/opt/bluez/lib/bluetooth/plugins/netlink.so
b7fca000-b7fde000 r-xp 00000000 08:07 313260
/opt/bluez/lib/libbluetooth.so.3.6.0
b7fde000-b7fdf000 r--p 00013000 08:07 313260
/opt/bluez/lib/libbluetooth.so.3.6.0
b7fdf000-b7fe1000 rw-p 00014000 08:07 313260
/opt/bluez/lib/libbluetooth.so.3.6.0
b7fe1000-b7fe3000 rw-p 00000000 00:00 0
b7fe3000-b7ffe000 r-xp 00000000 08:07 285043     /lib/ld-2.10.1.so
b7ffe000-b7fff000 r--p 0001a000 08:07 285043     /lib/ld-2.10.1.so
b7fff000-b8000000 rw-p 0001b000 08:07 285043     /lib/ld-2.10.1.so
bffeb000-c0000000 rw-p 00000000 00:00 0          [stack]

At this point gdb reports a SIGABRT I think comming from glib,
stacktrace at that time is:
Program received signal SIGABRT, Aborted.
0x0016e422 in __kernel_vsyscall ()
(gdb) bt
#0  0x0016e422 in __kernel_vsyscall ()
#1  0xb7d894d1 in *__GI_raise (sig=6) at
../nptl/sysdeps/unix/sysv/linux/raise.c:64
#2  0xb7d8c932 in *__GI_abort () at abort.c:92
#3  0xb7dbfee5 in __libc_message (do_abort=2, fmt=0xb7e83578 "***
glibc detected *** %s: %s: 0x%s ***\n")
    at ../sysdeps/unix/sysv/linux/libc_fatal.c:189
#4  0xb7dc9ff1 in malloc_printerr (action=<value optimized out>,
str=0x6 <Address 0x6 out of bounds>, ptr=0x19c7a8)
    at malloc.c:6217
#5  0xb7dca23a in malloc_consolidate (av=<value optimized out>) at malloc.c:5103
#6  0xb7dcc4e2 in _int_malloc (av=<value optimized out>, bytes=<value
optimized out>) at malloc.c:4338
#7  0xb7dce039 in __libc_calloc (n=1, elem_size=8192) at malloc.c:4041
#8  0xb7dbe66d in *__GI_open_memstream (bufloc=0xbfffe1d4,
sizeloc=0xbfffe1d0) at memstream.c:86
#9  0xb7e27615 in *__GI___vsyslog_chk (pri=31, flag=1, fmt=0x16c8d2
"Removing temporary device %s",
    ap=0xbfffe214 "\340+\032") at ../misc/syslog.c:169
#10 0x0014428e in vsyslog (format=0x16c8d2 "Removing temporary device
%s") at /usr/include/bits/syslog.h:48
#11 debug (format=0x16c8d2 "Removing temporary device %s") at src/logging.c:72
#12 0x00158e5c in adapter_remove_connection (adapter=0x1a5c60,
device=0x19a170, handle=<value optimized out>)
    at src/adapter.c:2835
#13 0x001613da in hcid_dbus_disconn_complete (local=0x19b69a, status=0
'\000', handle=42, reason=8 '\b')
    at src/dbus-hci.c:773
#14 0x00145ac2 in disconn_complete (chan=0x19e1e8, cond=<value
optimized out>, data=0x19b690) at src/security.c:901
#15 io_security_event (chan=0x19e1e8, cond=<value optimized out>,
data=0x19b690) at src/security.c:1032
#16 0xb7f73dab in g_io_unix_dispatch (source=0x178bb0,
callback=0x144ef0 <io_security_event>, user_data=0x19b690)
    at /build/buildd/glib2.0-2.22.3/glib/giounix.c:162
#17 0xb7f3ce88 in g_main_dispatch (context=0x178b30) at
/build/buildd/glib2.0-2.22.3/glib/gmain.c:1960
#18 IA__g_main_context_dispatch (context=0x178b30) at
/build/buildd/glib2.0-2.22.3/glib/gmain.c:2513
#19 0xb7f40730 in g_main_context_iterate (context=0x178b30,
block=<value optimized out>, dispatch=1, self=0x174b08)
    at /build/buildd/glib2.0-2.22.3/glib/gmain.c:2591
#20 0xb7f40b9f in IA__g_main_loop_run (loop=0x1795f0) at
/build/buildd/glib2.0-2.22.3/glib/gmain.c:2799
#21 0x00143d3e in main (argc=1, argv=0xbffff794) at src/main.c:451

I've been moving through the stack and discovered that variable path
isn't actually corrupted:
(gdb) up
#12 0x00158e5c in adapter_remove_connection (adapter=0x1a5c60,
device=0x19a170, handle=<value optimized out>)
    at src/adapter.c:2835
2835            debug("Removing temporary device %s", path);
(gdb) print *device
$5 = {bdaddr = {b = "\246\t\273Y\364D"}, path = 0x1a2be0
"/org/bluez/4473/hci0/dev_44_F4_59_BB_09_A6",
  name = '\000' <repetidos 248 veces>, adapter = 0x1a5c60, uuids =
0x0, drivers = 0x0, watches = 0x0, temporary = 1,
  agent = 0x0, disconn_timer = 0, discov_timer = 0, browse = 0x19e000,
bonding = 0x0, authr = 0x0, disconnects = 0x0,
  cap = 0 '\000', auth = 255 '\377', handle = 0, secmode3 = 0,
tmp_records = 0x0, paired = 0, renewed_key = 0,
  authorizing = 0, ref = 2}

I guess this problem is related to a broken reference counting, and
glib keeping references coherents. I will take a more cloose look
tomorrow.

Regards,

Manuel Naranjo

--
Manuel Francisco Naranjo
Software Department Argentina
Wireless Cables Inc
www.aircable.net
cel: +5493412010019
skype: naranjomanuelfrancisco



--
Manuel Francisco Naranjo
Software Department Argentina
Wireless Cables Inc
www.aircable.net
cel: +5493412010019
skype: naranjomanuelfrancisco
