Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 11 Dec 2009 10:25:43 +0200
Message-ID: <eb7933e20912110025y20eb4a6aw615660648d4756f8@mail.gmail.com>
Subject: [PATCH] dbus timeout handling
From: =?ISO-8859-1?Q?Daniel_=D6rstadius?= <daniel.orstadius@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

When receiving a file it's possible to crash obexd by letting the
"org.openobex.Error.Rejected" reply from the call to
request_authorization and the obexd timeout for the response occur at
roughly the same time.

No crash seen if the obexd timeout reaches function "agent_reply"
first. But if the agent's response arrives just before the obexd
timeout, the timeout will still be dispatched causing what looks like
an issue in the dbus-obexd integration. Added my own debug output to
show the situation:

obexd[8454]: entering remove_timeout
obexd[8454]: entering timeout_handler_dispatch
obexd[8454]: entering remove_timeout
obexd[8454]: entering timeout_handler_free
obexd[8454]: entering agent_reply
obexd[8454]: Agent replied with an error: org.bluez.Error.Rejected,
request rejected
obexd[8454]: after g_main_context_iteration in request_authorization
[segmentation fault, valgrind complains on two locations in
/lib/libdbus-1.so.3.4.0]

To fix this, there seems to be a chance to  avoid dispatching the
timeout in callback function mainloop.c:remove_timeout (this function
is currently empty, but maybe for good reason?)

After having moved the g_source_remove call on the timer to
"remove_timeout" from "timeout_handler_free" the issue was not
reproduced, although I can't claim to understand the dbus mainloop
integration code completely. It might be a bit awkward to break up the
g_source_remove and g_free of the timer into different callbacks.

Is this an acceptable solution for removing the crash?

Best regards,
Daniel

-----

For reference, the authorization method used to get the crash:

QString Widget::Authorize(QDBusObjectPath transger,QString bdaddr,QString name,
			QString type, int length, int time, QDBusMessage msg)
{	
	QTest::qWait(60000);

	QDBusConnection conn(QDBusConnection::sessionBus());
	QDBusMessage reply(msg.createErrorReply("org.bluez.Error.Rejected","request
rejected"));
	conn.send(reply);
	
	return QString();	
}


------

>From 1ec3f03d3c0d3fa6011db95e329b03e163bd1524 Mon Sep 17 00:00:00 2001
From: Daniel Orstadius <daniel.orstadius@gmail.com>
Date: Fri, 11 Dec 2009 09:50:23 +0200
Subject: [PATCH] dbus timeout handling

---
 gdbus/mainloop.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/gdbus/mainloop.c b/gdbus/mainloop.c
index bd775f8..b583ace 100644
--- a/gdbus/mainloop.c
+++ b/gdbus/mainloop.c
@@ -183,7 +183,6 @@ static void timeout_handler_free(void *data)
 	if (!handler)
 		return;

-	g_source_remove(handler->id);
 	g_free(handler);
 }

@@ -207,6 +206,14 @@ static dbus_bool_t add_timeout(DBusTimeout
*timeout, void *data)

 static void remove_timeout(DBusTimeout *timeout, void *data)
 {
+        timeout_handler_t *handler;
+
+        handler = dbus_timeout_get_data(timeout);
+
+        if (!handler)
+                return;
+
+        g_source_remove(handler->id);
 }

 static void timeout_toggled(DBusTimeout *timeout, void *data)
-- 
1.6.0.4
