Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 31 Aug 2011 14:47:28 +0200
Message-ID: <CACLukzL-HFzeVuW4t7LVZWZ2=Kz4M1OTjGyYPUBDF8o5gPBYhw@mail.gmail.com>
Subject: GATT segmentation fault.
From: Santiago Carot <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello.

I'm working in a GATT based profile and I have observed an anomalous
behavior in GATT related to the timeouts between requestes and
replies. I've checked that if a request is sent and no reply is
received in a 30 seconds (GATT_TIMEOUT macro) the callback
disconnect_timeout in gattrib.c is invoked, in this function the
GAttrib structure is destroyed witouth having in account the
references held in other parts of the bluetooth daemon like proximity,
device or attribute plugin. As far as I have seen, the attrib_destroy
function only uses the destroy callback reference to notify when the
GAttrib structure is released, but there are no place in the code when
this callback is set. Only the disconnect fuction is set in device.c
through the g_attrib_set_disconnect_function but it isn't called at
this point.

I'm not sure about the right patch to solve this issue due that it
seems to be a problem with the GAttrib references in gattrib.c code.
May be change the original function:

static gboolean disconnect_timeout(gpointer data)
{
	struct _GAttrib *attrib = data;

	attrib_destroy(attrib);

	return FALSE;
}

for another one wich only closes the IOchannel and notify about the
disconnection:

static gboolean disconnect_timeout(gpointer data)
{
	struct _GAttrib *attrib = data;

	g_io_channel_flush (attrib->io);
        g_io_channel_ref(io);
        attrib->io = NULL;
        if (attrib->disconnect)
			attrib->disconnect(attrib->disc_user_data);
	return FALSE;
}

May be we have to release pending events and so on. I'm not sure.

Here you are a trace with this problem.

#0  0xb7c8ff10 in ?? () from /lib/libc.so.6
No symbol table info available.
#1  0xb7c90ea7 in ?? () from /lib/libc.so.6
No symbol table info available.
#2  0xb7c925d7 in realloc () from /lib/libc.so.6
No symbol table info available.
#3  0xb7e45243 in ?? () from /usr/lib/libglib-2.0.so.0
No symbol table info available.
#4  0xb7e45ad9 in g_realloc () from /usr/lib/libglib-2.0.so.0
No symbol table info available.
#5  0xb7e60887 in ?? () from /usr/lib/libglib-2.0.so.0
No symbol table info available.
#6  0xb7e60f93 in g_string_insert_len () from /usr/lib/libglib-2.0.so.0
No symbol table info available.
#7  0xb7e6115b in g_string_append () from /usr/lib/libglib-2.0.so.0
No symbol table info available.
#8  0xb7e47003 in g_log_default_handler () from /usr/lib/libglib-2.0.so.0
No symbol table info available.
#9  0xb7e479c0 in g_logv () from /usr/lib/libglib-2.0.so.0
No symbol table info available.
#10 0xb7e47d13 in g_log () from /usr/lib/libglib-2.0.so.0
No symbol table info available.
#11 0xb7e47f1d in g_return_if_fail_warning () from /usr/lib/libglib-2.0.so.0
No symbol table info available.
#12 0xb7e4e682 in g_queue_get_length () from /usr/lib/libglib-2.0.so.0
No symbol table info available.
#13 0xb7f96663 in g_attrib_send (attrib=0xb8036f08, id=0, opcode=18
'\022', pdu=0xb803d580 "\022\024", len=5, func=0xb7f850f0
<final_measurement_cb>, user_data=0xb803d948,
    notify=0) at attrib/gattrib.c:451
        __btd_debug_desc = {file = 0xb7fdbf9c "attrib/gattrib.c", flags = 1}
        c = 0xb80322e0
        __FUNCTION__ = "g_attrib_send"
#14 0xb7f957c3 in gatt_write_char (attrib=0xb8036f08, handle=20,
value=0xbffff80e "", vlen=2, func=0xb7f850f0 <final_measurement_cb>,
user_data=0xb803d948) at attrib/gatt.c:540
        buf = 0xb803d580 "\022\024"
        buflen = 256
        plen = <optimized out>
        __FUNCTION__ = "gatt_write_char"
#15 0xb7f8526e in disable_final_measurement (t=0xb803c940) at
thermometer/thermometer.c:629
        ch = 0xb800ac98
        desc = 0xb800ac98
        btuuid = {type = BT_UUID16, value = {u16 = 10498, u32 = 10498,
u128 = {data = "\002)", '\000' <repeats 13 times>}}}
        atval = "\000"
        msg = <optimized out>
        __FUNCTION__ = "disable_final_measurement"
#16 0xb7f4766a in service_filter (connection=0xb800a6f0,
message=0xb800cf18, user_data=0xb800ced8) at gdbus/watch.c:477
        data = 0xb800ced8
        cb = 0xb803d928
        name = 0xb803d6e4 ":1.260"
        old = 0xb803d6f0 ":1.260"
        new = 0xb803d6fc ""
#17 0xb7f4730d in message_filter (connection=0xb800a6f0,
message=0xb800cf18, user_data=0x0) at gdbus/watch.c:527
        data = 0xb800ced8
        sender = <optimized out>
        path = <optimized out>
        iface = 0xb800cfd8 "org.freedesktop.DBus"
        member = <optimized out>
        arg = 0xb803d6e4 ":1.260"
#18 0xb7dc4c31 in dbus_connection_dispatch () from /usr/lib/libdbus-1.so.3
No symbol table info available.
#19 0xb7f45e88 in message_dispatch (data=0xb800a6f0) at gdbus/mainloop.c:80
        conn = 0xb800a6f0
#20 0xb7e4053f in ?? () from /usr/lib/libglib-2.0.so.0
No symbol table info available.
#21 0xb7e3ec4f in g_main_context_dispatch () from /usr/lib/libglib-2.0.so.0
No symbol table info available.
#22 0xb7e3f3b0 in ?? () from /usr/lib/libglib-2.0.so.0
No symbol table info available.
#23 0xb7e3faeb in g_main_loop_run () from /usr/lib/libglib-2.0.so.0
No symbol table info available.
#24 0xb7f45321 in main (argc=1, argv=0xbffffc54) at src/main.c:473
        context = <optimized out>
        err = 0x0
        sa = {__sigaction_handler = {sa_handler = 0x1, sa_sigaction =
0x1}, sa_mask = {__val = {0 <repeats 32 times>}}, sa_flags = 1,
sa_restorer = 0}
        config = 0xb8007600
        __FUNCTION__ = "main"

What it is happening is that the GAttrib is released when timeout
expires but the plugin still keeps a reference to the Gattrib memory.
Next time any gattrib function is invoked the memory fault happens. In
this case in g_attrib_send function.

Another less important issue is related to the internal GIOChannel
reference in _GAttrib. This reference is increased when the GAttrib is
created but never decremented when is destroyed.

Please let me know If I can help in any other way.
Regards.
