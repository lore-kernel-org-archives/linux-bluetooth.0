Return-Path: <cyrus@holtmann.org>
Message-ID: <95c807760809281058y3c9b15d3j19ebc4bbe9df59b2@mail.gmail.com>
Date: Sun, 28 Sep 2008 13:58:29 -0400
From: "Tim Dempsey" <trdempsey@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Bluez 4.7 crash pairing Motorola S9 w/bt
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I was attempting to pair a set of Motorola S9 headphones using bluez 4.7
and received the following crash. Attached is the output of 'bluetoothd -nd'
under gdb, with a bt. I also included the output of
"dbus-monitor --system sender='org.bluez'". I made the following patch and
thought I'm sure it's not the right fix it allowed me to pair/play sound
though the S9.

diff -Naur bluez-4.7/src/dbus-common.c
bluez-4.7-work/src/dbus-common.c
--- bluez-4.7/src/dbus-common.c 2008-09-14 15:03:18.000000000 -0400
+++ bluez-4.7-work/src/dbus-common.c    2008-09-28 12:00:38.000000000
-0400
@@ -318,7 +318,7 @@
 {
        DBusMessage *signal;
        DBusMessageIter iter;
-       gboolean ret;
+       gboolean ret=FALSE;

        signal = dbus_message_new_signal(path, interface,
"PropertyChanged");

@@ -332,8 +332,9 @@

        dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING,
&name);
        dbus_message_iter_append_variant(&iter, type, value);
-
-       ret = dbus_connection_send(conn, signal, NULL);
+
+       if(conn)
+         ret = dbus_connection_send(conn, signal, NULL);

        dbus_message_unref(signal);
        return ret;

Output of "bluetooth -nd"
Starting program: /usr/sbin/bluetoothd -nd
bluetoothd[18495]: Bluetooth daemon
bluetoothd[18495]: Enabling debug information
bluetoothd[18495]: parsing main.conf
bluetoothd[18495]: offmode=NoScan
bluetoothd[18495]: discovto=0
bluetoothd[18495]: pageto=8192
bluetoothd[18495]: name=%h-%d
bluetoothd[18495]: class=0x000100
bluetoothd[18495]: inqmode=0
bluetoothd[18495]: Starting SDP server
bluetoothd[18495]: Loading plugins /usr/lib/bluetooth/plugins
bluetoothd[18495]: /usr/lib/bluetooth/plugins/audio.so
bluetoothd[18495]: Unix socket created: 14
bluetoothd[18495]: Telephony plugin initialized
bluetoothd[18495]: HFP AG features: (none)
bluetoothd[18495]: /usr/lib/bluetooth/plugins/input.so
bluetoothd[18495]: input.conf: Key file does not have key 'IdleTimeout'
bluetoothd[18495]: /usr/lib/bluetooth/plugins/hal.so
bluetoothd[18495]: /usr/lib/bluetooth/plugins/service.so
bluetoothd[18495]: /usr/lib/bluetooth/plugins/serial.so
bluetoothd[18495]: /usr/lib/bluetooth/plugins/network.so
bluetoothd[18495]: Parsing /etc/bluetooth/network.conf failed: No such
file or directory
bluetoothd[18495]: Config options: InterfacePrefix=bnep%d,
PANU_Script=(null), GN_Script=(null), NAP_Script=(null),
GN_Interface=pan0, NAP_Interface=pan1, Security=true
bluetoothd[18495]: Can't create GN bridge
bluetoothd[18495]: HCI dev 0 registered
bluetoothd[18495]: child 18496 forked
bluetoothd[18495]: HCI dev 0 already up
bluetoothd[18495]: headset_server_probe: path /org/bluez/hci0
bluetoothd[18495]: audio.conf: Key file does not have key 'Master'
bluetoothd[18495]: Adding record with handle 0x10000
bluetoothd[18495]: audio.conf: Key file does not have key 'SCORouting'
bluetoothd[18495]: a2dp_server_probe: path /org/bluez/hci0
bluetoothd[18495]: audio.conf: Key file does not have key 'Disable'
bluetoothd[18495]: audio.conf: Key file does not have group 'A2DP'
bluetoothd[18495]: audio.conf: Key file does not have group 'A2DP'
bluetoothd[18495]: audio.conf: Key file does not have group 'A2DP'
bluetoothd[18495]: audio.conf: Key file does not have group 'A2DP'
bluetoothd[18495]: audio.conf: Key file does not have key 'Master'
bluetoothd[18495]: SEP 0xb8b3bf10 registered: type:0 codec:0 seid:1
bluetoothd[18495]: Adding record with handle 0x10001
bluetoothd[18495]: avrcp_server_probe: path /org/bluez/hci0
bluetoothd[18495]: audio.conf: Key file does not have key 'Master'
bluetoothd[18495]: Adding record with handle 0x10002
bluetoothd[18495]: Adding record with handle 0x10003
bluetoothd[18495]: service_probe: path /org/bluez/hci0
bluetoothd[18495]: Registered interface org.bluez.Service on path
/org/bluez/hci0
bluetoothd[18495]: proxy_probe: path /org/bluez/hci0
bluetoothd[18495]: Registered interface org.bluez.SerialProxyManager
on path /org/bluez/hci0
bluetoothd[18495]: network_server_probe: path /org/bluez/hci0
bluetoothd[18495]: Adding record with handle 0x10004
bluetoothd[18495]: register_server_record: got record id 0x10004
bluetoothd[18495]: Registered interface org.bluez.NetworkPeer on path
/org/bluez/hci0
bluetoothd[18495]: network_server_probe: path /org/bluez/hci0
bluetoothd[18495]: Adding record with handle 0x10005
bluetoothd[18495]: register_server_record: got record id 0x10005
bluetoothd[18495]: Registered interface org.bluez.NetworkHub on path
/org/bluez/hci0
bluetoothd[18495]: network_server_probe: path /org/bluez/hci0
bluetoothd[18495]: Adding record with handle 0x10006
bluetoothd[18495]: register_server_record: got record id 0x10006
bluetoothd[18495]: Registered interface org.bluez.NetworkRouter on
path /org/bluez/hci0
bluetoothd[18495]: Creating device
/org/bluez/hci0/dev_00_0D_FD_19_0F_67
bluetoothd[18495]: Adapter /org/bluez/hci0 has been enabled
bluetoothd[18495]: Starting security manager 0
bluetoothd[18495]: child 18496 exited
bluetoothd[18495]: Agent registered for hci0 at :1.118:/test/agent
bluetoothd[18495]: adapter_get_device(00:0D:FD:19:0F:67)
bluetoothd[18495]: link_key_request (sba=00:19:7D:E8:C7:0E,
dba=00:0D:FD:19:0F:67)
bluetoothd[18495]: kernel auth requirements = 0x00
bluetoothd[18495]: stored link key type = 0x00
bluetoothd[18495]: adapter_get_device(00:0D:FD:19:0F:67)
bluetoothd[18495]: pin_code_request (sba=00:19:7D:E8:C7:0E,
dba=00:0D:FD:19:0F:67)
bluetoothd[18495]: hcid_dbus_new_auth_request
bluetoothd[18495]: link_key_notify (sba=00:19:7D:E8:C7:0E,
dba=00:0D:FD:19:0F:67)
bluetoothd[18495]: adapter_get_device(00:0D:FD:19:0F:67)
bluetoothd[18495]: hcid_dbus_bonding_process_complete: status=00
bluetoothd[18495]: adapter_get_device(00:0D:FD:19:0F:67)
bluetoothd[18495]: Probe drivers for
/org/bluez/hci0/dev_00_0D_FD_19_0F_67
bluetoothd[18495]: Found Headset record
bluetoothd[18495]: Discovered Headset service on RFCOMM channel 2
bluetoothd[18495]: Registered interface org.bluez.Headset on path
/org/bluez/hci0/dev_00_0D_FD_19_0F_67
bluetoothd[18495]: Found Audio Sink
bluetoothd[18495]: Registered interface org.bluez.AudioSink on path
/org/bluez/hci0/dev_00_0D_FD_19_0F_67
bluetoothd[18495]: Found AV Target
bluetoothd[18495]: Registered interface org.bluez.Control on path
/org/bluez/hci0/dev_00_0D_FD_19_0F_67
bluetoothd[18495]: Found AV Remote
bluetoothd[18495]: headset_probe: path
/org/bluez/hci0/dev_00_0D_FD_19_0F_67
bluetoothd[18495]: Registered interface org.bluez.Input on path
/org/bluez/hci0/dev_00_0D_FD_19_0F_67
process 18495: arguments to dbus_connection_send() were incorrect,
assertion "connection != NULL" failed in file dbus-connection.c line
3081.
This is normally a bug in some application using the D-Bus library.
  /usr/lib/libdbus-1.so.3 [0xb7e14ac1]
  /usr/lib/libdbus-1.so.3 [0xb7e13df8]
  /usr/lib/libdbus-1.so.3 [0xb7e07e98]
  /usr/lib/libdbus-1.so.3(dbus_connection_send+0x7b) [0xb7de5b67]
  /usr/sbin/bluetoothd(dbus_connection_emit_property_changed+0xb4)
[0xb7f7b39a]
  /usr/sbin/bluetoothd [0xb7f79a30]
  /usr/sbin/bluetoothd [0xb7f7a04d]
  /usr/sbin/bluetoothd [0xb7f7a406]
  /usr/sbin/bluetoothd [0xb7f7f5c7]
  /usr/lib/libbluetooth.so.3(sdp_process+0x5c8) [0xb7dc7c31]
  /usr/sbin/bluetoothd [0xb7f7f633]
  /usr/lib/libglib-2.0.so.0 [0xb7ea7271]
  /usr/lib/libglib-2.0.so.0 [0xb7e69af2]
  /usr/lib/libglib-2.0.so.0(g_main_context_dispatch+0x89) [0xb7e6afbb]
  /usr/lib/libglib-2.0.so.0 [0xb7e6b50f]
  /usr/lib/libglib-2.0.so.0(g_main_loop_run+0x3a5) [0xb7e6bce6]
  /usr/sbin/bluetoothd(main+0x531) [0xb7f65915]
  /lib/libc.so.6(__libc_start_main+0xdc) [0xb7c9cfdc]
  /usr/sbin/bluetoothd [0xb7f64001]

Program received signal SIGABRT, Aborted.
0xb7f3e424 in __kernel_vsyscall ()
(gdb) bt
#0  0xb7f3e424 in __kernel_vsyscall ()
#1  0xb7cb0101 in *__GI_raise (sig=6) at
../nptl/sysdeps/unix/sysv/linux/raise.c:64
#2  0xb7cb18e8 in *__GI_abort () at abort.c:88
#3  0xb7e13e44 in _dbus_abort () at dbus-sysdeps.c:86
#4  0xb7e07e98 in _dbus_warn_check_failed (
    format=0xb7e26940 "arguments to %s() were incorrect, assertion
\"%s\" failed in file %s line %d.\nThis is normally a bug in some
application using the D-Bus library.\n") at dbus-internals.c:283
#5  0xb7de5b67 in dbus_connection_send (connection=0x0,
message=0xb8b39350, serial=0x0) at dbus-connection.c:3081
#6  0xb7f7b39a in dbus_connection_emit_property_changed (conn=0x0,
    path=0xb8b40a60 "/org/bluez/hci0/dev_00_0D_FD_19_0F_67",
interface=0xb7f88114 "org.bluez.Device",
    name=0xb7f880ee "UUIDs", type=97, value=0xbf887a84) at
dbus-common.c:336
#7  0xb7f79a30 in services_changed (req=0xb8b39318) at device.c:869
#8  0xb7f7a04d in search_cb (recs=0x0, err=0, user_data=0xb8b39318) at
device.c:1028
#9  0xb7f7a406 in browse_cb (recs=0x0, err=0, user_data=0xb8b39318) at
device.c:1129
#10 0xb7f7f5c7 in search_completed_cb (type=7 '\a', status=0,
rsp=0xb8b39340 "", size=2, user_data=0xb8b3a680)
    at glib-helper.c:167
#11 0xb7dc7c31 in sdp_process (session=0xb8b442a8) at sdp.c:3997
#12 0xb7f7f633 in search_process_cb (chan=0xb8b413c8, cond=G_IO_IN,
user_data=0xb8b3a680) at glib-helper.c:186
#13 0xb7ea7271 in g_io_unix_dispatch (source=0xb8b436d0,
callback=0xb7f7f5f3 <search_process_cb>,
    user_data=0xb8b3a680) at giounix.c:162
#14 0xb7e69af2 in g_main_dispatch (context=0xb8b36320) at gmain.c:2012
#15 0xb7e6afbb in IA__g_main_context_dispatch (context=0xb8b36320) at
gmain.c:2564
#16 0xb7e6b50f in g_main_context_iterate (context=0xb8b36320, block=1,
dispatch=1, self=0xb8b37308) at gmain.c:2645
---Type <return> to continue, or q <return> to quit---
#17 0xb7e6bce6 in IA__g_main_loop_run (loop=0xb8b3ae90) at
gmain.c:2853
#18 0xb7f65915 in main (argc=1, argv=0xbf887fd4) at main.c:750


dbus-monitor --system sender='org.bluez'
signal sender=org.freedesktop.DBus -> dest=:1.116
path=/org/freedesktop/DBus; interface=org.freedesktop.DBus;
member=NameAcquired
   string ":1.116"
signal sender=:1.117 -> dest=(null destination) path=/;
interface=org.bluez.Manager; member=AdapterAdded
   object path "/org/bluez/hci0"
signal sender=:1.117 -> dest=(null destination) path=/org/bluez/hci0;
interface=org.bluez.Adapter; member=PropertyChanged
   string "Mode"
   variant       string "connectable"
signal sender=:1.117 -> dest=(null destination) path=/org/bluez/hci0;
interface=org.bluez.Adapter; member=PropertyChanged
   string "Powered"
   variant       boolean true
signal sender=:1.117 -> dest=(null destination) path=/org/bluez/hci0;
interface=org.bluez.Adapter; member=PropertyChanged
   string "Discoverable"
   variant       boolean false
signal sender=:1.117 -> dest=(null destination) path=/;
interface=org.bluez.Manager; member=DefaultAdapterChanged
   object path "/org/bluez/hci0"
signal sender=:1.117 -> dest=(null destination)
path=/org/bluez/hci0/dev_00_0D_FD_19_0F_67;
interface=org.bluez.Device; member=PropertyChanged
   string "Connected"
   variant       boolean true
signal sender=:1.117 -> dest=(null destination)
path=/org/bluez/hci0/dev_00_0D_FD_19_0F_67;
interface=org.bluez.Device; member=PropertyChanged
   string "Name"
   variant       string "Motorola S9"
signal sender=:1.117 -> dest=(null destination)
path=/org/bluez/hci0/dev_00_0D_FD_19_0F_67;
interface=org.bluez.Device; member=PropertyChanged
   string "Connected"
   variant       boolean false
signal sender=:1.117 -> dest=(null destination)
path=/org/bluez/hci0/dev_00_0D_FD_19_0F_67;
interface=org.bluez.Device; member=PropertyChanged
   string "Connected"
   variant       boolean true
signal sender=:1.117 -> dest=(null destination)
path=/org/bluez/hci0/dev_00_0D_FD_19_0F_67;
interface=org.bluez.Device; member=PropertyChanged
   string "Paired"
   variant       boolean true
signal sender=:1.117 -> dest=(null destination)
path=/org/bluez/hci0/dev_00_0D_FD_19_0F_67;
interface=org.bluez.Device; member=PropertyChanged
   string "Name"
   variant       string "Motorola S9"
