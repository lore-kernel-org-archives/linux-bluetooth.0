Return-Path: <cyrus@holtmann.org>
Message-ID: <1386594975.32408.39.camel@nuvo>
Subject: Crasher when cancelling pairing
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Date: Mon, 09 Dec 2013 14:16:15 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Heya,

When a remote pairing is cancelled, bluetoothd will go in a loop, or
crash.

1. Start pairing from a non-SSP remote device (such as my old phone)
2. Enter the PIN on the phone
3. When the RequestPinCode callback is called on the computer, kill the
agent (simple-agent for example).
4. bluetoothd goes in a loop or crashes as it does in:
https://bugzilla.redhat.com/show_bug.cgi?id=1027365

Applying this patch gives more reasonable backtraces:
diff --git a/src/agent.c b/src/agent.c
index bcba969..b292881 100644
--- a/src/agent.c
+++ b/src/agent.c
@@ -203,6 +203,8 @@ void agent_unref(struct agent *agent)
        if (agent->ref > 0)
                return;
 
+       g_assert (agent->ref == 0);
+
        if (agent->request) {
                DBusError err;
                agent_pincode_cb pincode_cb;

And asserts nicely before looping forever:
bluetoothd[28090]: src/agent.c:agent_unref() 0x6c5f90: ref=-1
**
ERROR:src/agent.c:206:agent_unref: assertion failed: (agent->ref == 0)

The backtrace:
#0  0x00000033f2835c59 in raise () from /lib64/libc.so.6
#1  0x00000033f2837368 in abort () from /lib64/libc.so.6
#2  0x00007ffff7d000ed in _g_log_abort () from /lib64/libglib-2.0.so.0
#3  0x00007ffff7d1dc97 in g_assertion_message () from /lib64/libglib-2.0.so.0
#4  0x00007ffff7d1dcfa in g_assertion_message_expr () from /lib64/libglib-2.0.so.0
#5  0x00000000004529f4 in agent_unref (agent=0x6c5f90) at src/agent.c:206
#6  0x00000000004621d7 in pincode_cb (agent=<optimized out>, err=<optimized out>, pin=0x0, data=<optimized out>) at src/device.c:3979
#7  0x000000000045297d in agent_unref (agent=0x6c5f90) at src/agent.c:221
#8  0x00000000004621d7 in pincode_cb (agent=<optimized out>, err=<optimized out>, pin=0x0, data=<optimized out>) at src/device.c:3979
#9  0x0000000000452236 in pincode_reply (call=<optimized out>, user_data=0x6f2790) at src/agent.c:445
#10 0x00000033f780c782 in complete_pending_call_and_unlock (connection=connection@entry=0x6c6320, pending=0x6eb100, message=message@entry=0x6ce680) at dbus-connection.c:2314
#11 0x00000033f780f9b1 in dbus_connection_dispatch (connection=connection@entry=0x6c6320) at dbus-connection.c:4580
#12 0x0000000000474ea8 in message_dispatch (data=0x6c6320) at gdbus/mainloop.c:76
#13 0x00007ffff7cf9e43 in g_timeout_dispatch () from /lib64/libglib-2.0.so.0
#14 0x00007ffff7cf92a6 in g_main_context_dispatch () from /lib64/libglib-2.0.so.0
#15 0x00007ffff7cf9628 in g_main_context_iterate.isra.24 () from /lib64/libglib-2.0.so.0
#16 0x00007ffff7cf9a3a in g_main_loop_run () from /lib64/libglib-2.0.so.0
#17 0x000000000040a530 in main (argc=1, argv=0x7fffffffe518) at src/main.c:587

Cheers

