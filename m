Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: Re: [PATCH BlueZ] gdbus: Fix segfault when D-Bus daemon exits
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1367692601-3578-1-git-send-email-anderson.lizardo@openbossa.org>
Date: Sat, 4 May 2013 12:08:32 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <776BEEA5-8007-4BC5-90CC-7C00E9F61B95@holtmann.org>
References: <1367692601-3578-1-git-send-email-anderson.lizardo@openbossa.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

> Fix this crash if D-Bus exits while the client is still connected to it:
> 
> ==5570== Invalid read of size 1
> ==5570==    at 0x402D28E: strcmp (in
> /usr/lib/valgrind/vgpreload_memcheck-x86-linux.so)
> ==5570==    by 0x4070E22: g_str_equal (ghash.c:1704)
> ==5570==    by 0x8055F61: message_filter (client.c:1123)
> ==5570==    by 0x4141500: dbus_connection_dispatch (in
> /lib/i386-linux-gnu/libdbus-1.so.3.5.8)
> ==5570==    by 0x80506F7: message_dispatch (mainloop.c:76)
> ==5570==    by 0x4081A7E: g_timeout_dispatch (gmain.c:3882)
> ==5570==    by 0x4080D85: g_main_context_dispatch (gmain.c:2539)
> ==5570==    by 0x4081124: g_main_context_iterate.isra.21 (gmain.c:3146)
> ==5570==    by 0x408156A: g_main_loop_run (gmain.c:3340)
> ==5570==    by 0x41BF4D2: (below main) (libc-start.c:226)
> ==5570==  Address 0x0 is not stack'd, malloc'd or (recently) free'd
> ==5570==
> ==5570==
> 
> Also make sure that dbus_pending_call_set_notify() and
> dbus_pending_call_unref() are not called on a NULL DBusPendingCall. From
> D-Bus documentation for dbus_connection_send_with_reply():
> 
> "Warning: if the connection is disconnected or you try to send Unix file
> descriptors on a connection that does not support them, the
> DBusPendingCall will be set to NULL, so be careful with this."

what stupid non-sense is this. Why the heck is dbus_connection_send_with_reply not returning FALSE in that case? This makes no sense.

> ---
> gdbus/client.c |    9 +++++++--
> 1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/gdbus/client.c b/gdbus/client.c
> index 55f1d89..b5e2ebc 100644
> --- a/gdbus/client.c
> +++ b/gdbus/client.c
> @@ -105,8 +105,11 @@ static gboolean modify_match(DBusConnection *conn, const char *member,
> 		return FALSE;
> 	}
> 
> -	dbus_pending_call_set_notify(call, modify_match_reply, NULL, NULL);
> -	dbus_pending_call_unref(call);
> +	if (call != NULL) {
> +		dbus_pending_call_set_notify(call, modify_match_reply, NULL,
> +									NULL);
> +		dbus_pending_call_unref(call);
> +	}

If we really have to check then make it a case where we return FALSE and not a success case.

	if (call == NULL) {
		dbus_message_unref(msg);
		return FALSE;

	}

I still maintain that this should not return NULL and TRUE at the same time. That is just plain stupid.

Have you actually seen it crashing with call == NULL?

> 
> 	dbus_message_unref(msg);
> 
> @@ -1119,6 +1122,8 @@ static DBusHandlerResult message_filter(DBusConnection *connection,
> 		return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
> 
> 	sender = dbus_message_get_sender(message);
> +	if (sender == NULL)
> +		return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
> 
> 	if (g_str_equal(sender, DBUS_SERVICE_DBUS) == TRUE) {
> 		const char *interface, *member;

These are two independent fixes. So make it two patches.

Regards

Marcel

