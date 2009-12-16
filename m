Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <eb7933e20912110025y20eb4a6aw615660648d4756f8@mail.gmail.com>
References: <eb7933e20912110025y20eb4a6aw615660648d4756f8@mail.gmail.com>
Date: Wed, 16 Dec 2009 12:11:21 +0200
Message-ID: <eb7933e20912160211h165d90f2s4969c6cfea2d9b01@mail.gmail.com>
Subject: Re: [PATCH] dbus timeout handling
From: =?ISO-8859-1?Q?Daniel_=D6rstadius?= <daniel.orstadius@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Dec 11, 2009 at 10:25 AM, Daniel Örstadius
<daniel.orstadius@gmail.com> wrote:

> When receiving a file it's possible to crash obexd by letting the
> "org.openobex.Error.Rejected" reply from the call to
> request_authorization and the obexd timeout for the response occur at
> roughly the same time.
>

Making a new patch proposal for this after discussion with Johan.

The patch concerns how dbus timeouts are stopped in obexd in the
functions remove_timeout and timeout_handler_free. Without this patch
it is all done in the latter. Using the patch it is done in both, with
the freeing being made in timeout_handler_free.

The reason for making this modification is that in at least one corner
case it looks to be possible for obexd to dispatch (by
timeout_handler_dispatch) a timeout on which dbus has called
remove_timeout (which is currently empty).

Compared the obexd-dbus mainloop integration with the dbus-glib
implementation at
http://cgit.freedesktop.org/dbus/dbus-glib/tree/dbus/dbus-gmain.c

Its corresponding callbacks for obexd's remove_timeout and
timeout_handler_free both do the same thing as far as I understood the
code.

>From the dbus-glib code:

dbus_connection_set_timeout_functions (.., remove_timeout,..)
leading to

remove_timeout ->
connection_setup_remove_timeout ->
timeout_handler_destroy_source ->
g_source_destroy

and
add_timeout -> dbus_timeout_set_data (.., timeout_handler_timeout_freed)
leading to

timeout_handler_timeout_freed ->
timeout_handler_destroy_source ->
g_source_destroy

They both stop the timeout, but do not free the timeout_handler
structure. This is done in timeout_handler_source_finalized which is
set via

g_source_set_callback (.., timeout_handler_source_finalized) in add_timeout.

obexd does not use this kind of finalize callback. Other than this,
the intention is for the patch to map to the dbus-glib implementation
by removing the timer in both callbacks.

(I'm not an expert in dbus nor glib, there could be pitfalls with this
modification)

/Daniel

---------

>From 70cc29c724c089e1468a6670c53e1f77d5b3ebcc Mon Sep 17 00:00:00 2001
From: Daniel Orstadius <daniel.orstadius@gmail.com>
Date: Wed, 16 Dec 2009 11:23:46 +0200
Subject: [PATCH] dbus timeout handling

---
 gdbus/mainloop.c |   17 ++++++++++++++++-
 1 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/gdbus/mainloop.c b/gdbus/mainloop.c
index bd775f8..f808f5d 100644
--- a/gdbus/mainloop.c
+++ b/gdbus/mainloop.c
@@ -183,7 +183,11 @@ static void timeout_handler_free(void *data)
 	if (!handler)
 		return;

-	g_source_remove(handler->id);
+	if (handler->id != 0) {
+		g_source_remove(handler->id);
+		handler->id = 0;
+	}
+
 	g_free(handler);
 }

@@ -207,6 +211,17 @@ static dbus_bool_t add_timeout(DBusTimeout
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
+        if (handler->id != 0) {
+                g_source_remove(handler->id);
+                handler->id = 0;
+        }
 }

 static void timeout_toggled(DBusTimeout *timeout, void *data)
-- 
1.6.0.4
