Return-Path: <noring@nocrew.org>
Subject: [PATCH] DBus in hcid
From: Fredrik Noring <noring@nocrew.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Cc: Marcel Holtmann <marcel@holtmann.org>
Content-Type: multipart/mixed; boundary="=-EtQgIEzTuWGp04i4XGJj"
Message-Id: <1075749905.27809.28.camel@akka.yeti.nocrew.org>
Mime-Version: 1.0
Date: Mon, 02 Feb 2004 20:25:05 +0100
List-ID: <bluez-devel.lists.sourceforge.net>


--=-EtQgIEzTuWGp04i4XGJj
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi

This patch implements DBus in hcid. A simple interface for keytab is
available. It's possible to list and delete links (key pairs).

It's highly experimental. Only root is currently permitted access to
the DBus. There seem to be serious memory related issues which are not
resolved especially when hcid exists (double frees or similar). I
haven't figured out yet if this is due to hcid or DBus, because it's
DBus that crashes. I've run Valgrind and dmalloc on it.

The hcid DBus is currently available through the socket /tmp/dbus-hcid.
I think the system DBus ought to be connected as well. Next I'll look
into more cleanups, improved interfaces etc.

Marcel, I'm not planning on doing work on the Bluetooth library any
time soon. But I think your ideas for it are excellent. I'll concentrate
on fixing hcid.

Fredrik

 configure.in       |    5
 hcid/Makefile.am   |    9 -
 hcid/dbus.c        |  405 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 hcid/dbus.h        |   32 ++++
 hcid/glib-ectomy.c |  171 ----------------------
 hcid/glib-ectomy.h |  106 -------------
 hcid/hcid.h        |    9 -
 hcid/keytab.c      |  119 +++++++++++++++
 hcid/keytab.h      |    4
 hcid/main.c        |   84 ++++++----
 hcid/security.c    |   78 ++++++----
 hcid/watch.c       |  289 +++++++++++++++++++++++++++++++++++++
 hcid/watch.h       |   75 +++++++++
 13 files changed, 1029 insertions(+), 357 deletions(-)


--=-EtQgIEzTuWGp04i4XGJj
Content-Disposition: attachment; filename=hcid-dbus.2004-02-02.patch
Content-Type: text/x-patch; name=hcid-dbus.2004-02-02.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

diff -Naur bluez-utils-2.4.orig/configure.in bluez-utils-2.4/configure.in
--- bluez-utils-2.4.orig/configure.in	2003-12-17 15:26:35.000000000 +0100
+++ bluez-utils-2.4/configure.in	2004-01-31 12:44:17.000000000 +0100
@@ -54,6 +54,11 @@
 		Please compile and install bluez-libs package.)
 )
 
+dnl Check for packages
+PKG_CHECK_MODULES(DBUS, dbus-1 >= 0.20)
+AC_SUBST(DBUS_CFLAGS)
+AC_SUBST(DBUS_LIBS)
+				
 dnl Check for distro type.
 DISTRO=unknown
 
diff -Naur bluez-utils-2.4.orig/hcid/dbus.c bluez-utils-2.4/hcid/dbus.c
--- bluez-utils-2.4.orig/hcid/dbus.c	1970-01-01 01:00:00.000000000 +0100
+++ bluez-utils-2.4/hcid/dbus.c	2004-02-02 19:20:40.000000000 +0100
@@ -0,0 +1,405 @@
+/* 
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *  Copyright (C) 2004 Fredrik Noring
+ *  
+ *  Written 2004 by Fredrik Noring <noring@nocrew.org>
+ *  
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <string.h>
+#include <signal.h>
+#include <fcntl.h>
+#include <syslog.h>
+#include <errno.h>
+#include <fcntl.h>
+
+#include <sys/socket.h>
+
+#include "watch.h"
+
+#include "dbus.h"
+
+#define HCID_DBUS_ADDRESS "unix:path=/tmp/dbus-hcid"
+
+struct interface_list {
+	struct interface_dbus *interface_dbus;
+	void *context;
+
+	struct interface_list *next;
+};
+
+static DBusError error;
+static DBusServer *server = 0;
+
+static struct interface_list *interface_list = 0;
+
+/*
+ * Functions type_to_name and print_dbus_message taken from DBus
+ * "tools/dbus-print-message.c" by Philip Blundell and Red Hat, Inc.
+ */
+static const char *type_to_name(int message_type)
+{
+	switch (message_type) {
+		case DBUS_MESSAGE_TYPE_SIGNAL:
+			return "signal";
+		case DBUS_MESSAGE_TYPE_METHOD_CALL:
+			return "method call";
+		case DBUS_MESSAGE_TYPE_METHOD_RETURN:
+			return "method return";
+		case DBUS_MESSAGE_TYPE_ERROR:
+			return "error";
+		default:
+			return "(unknown message type)";
+	}
+}
+
+void print_dbus_message(DBusMessage *message)
+{
+	DBusMessageIter iter;
+	const char *sender;
+	int message_type;
+	
+	message_type = dbus_message_get_type (message);
+	sender = dbus_message_get_sender (message); 
+	
+	switch (message_type) {
+		case DBUS_MESSAGE_TYPE_METHOD_CALL:
+		case DBUS_MESSAGE_TYPE_SIGNAL:
+			printf ("%s interface=%s; member=%s; sender=%s\n",
+				type_to_name (message_type),
+				dbus_message_get_interface (message),
+				dbus_message_get_member (message),
+				sender ? sender : "(no sender)");
+			break;
+			
+		case DBUS_MESSAGE_TYPE_METHOD_RETURN:
+			printf ("%s; sender=%s\n",
+				type_to_name (message_type),
+				sender ? sender : "(no sender)");
+			break;
+			
+		case DBUS_MESSAGE_TYPE_ERROR:
+			printf ("%s name=%s; sender=%s\n",
+				type_to_name (message_type),
+				dbus_message_get_error_name (message),
+				sender ? sender : "(no sender)");
+			break;
+			
+		default:
+			printf ("Message of unknown type %d received\n",
+				message_type);
+			break;
+	}
+	
+	dbus_message_iter_init (message, &iter);
+	
+	do {
+		int type = dbus_message_iter_get_arg_type (&iter);
+		char *str;
+		dbus_uint32_t uint32;
+		dbus_int32_t int32;
+		double d;
+		unsigned char byte;
+		dbus_bool_t boolean;
+		
+		if (type == DBUS_TYPE_INVALID)
+			break;
+		
+		switch (type) {
+			case DBUS_TYPE_STRING:
+				str = dbus_message_iter_get_string (&iter);
+				printf ("string:%s\n", str);
+				break;
+				
+			case DBUS_TYPE_INT32:
+				int32 = dbus_message_iter_get_int32 (&iter);
+				printf ("int32:%d\n", int32);
+				break;
+				
+			case DBUS_TYPE_UINT32:
+				uint32 = dbus_message_iter_get_uint32 (&iter);
+				printf ("int32:%u\n", uint32);
+				break;
+				
+			case DBUS_TYPE_DOUBLE:
+				d = dbus_message_iter_get_double (&iter);
+				printf ("double:%f\n", d);
+				break;
+				
+			case DBUS_TYPE_BYTE:
+				byte = dbus_message_iter_get_byte (&iter);
+				printf ("byte:%d\n", byte);
+				break;
+				
+			case DBUS_TYPE_BOOLEAN:
+				boolean = dbus_message_iter_get_boolean (&iter);
+				printf ("boolean:%s\n", boolean ? "true" : "false");
+				break;
+				
+			default:
+				printf ("(unknown arg type %d)\n", type);
+				break;
+		}
+	} while (dbus_message_iter_next (&iter));
+}
+
+static void handle_watch(struct watch *watch, short flags, void *dbus_watch)
+{
+	unsigned int dbus_flags = 0;
+
+	if(flags & WATCH_IN)
+		dbus_flags |= DBUS_WATCH_READABLE;
+	if(flags & WATCH_OUT)
+		dbus_flags |= DBUS_WATCH_WRITABLE;
+	if(flags & WATCH_ERR)
+		dbus_flags |= DBUS_WATCH_ERROR;
+	if(flags & WATCH_HUP)
+		dbus_flags |= DBUS_WATCH_HANGUP;
+	dbus_watch_handle(dbus_watch, dbus_flags);
+}
+
+static unsigned int watch_dbus_flags(DBusWatch *dbus_watch)
+{
+	unsigned int flags = WATCH_HUP | WATCH_ERR;
+	unsigned int dbus_flags;
+
+	dbus_flags = dbus_watch_get_flags(dbus_watch);
+	if(dbus_flags & DBUS_WATCH_READABLE)
+		flags |= WATCH_IN;
+	if(dbus_flags & DBUS_WATCH_WRITABLE)
+		flags |= WATCH_OUT;
+	return flags;
+}
+
+static dbus_bool_t add_watch(DBusWatch *dbus_watch, void *context)
+{
+	dbus_watch_set_data(dbus_watch,
+			    watch_allocate_fd(dbus_watch_get_fd(dbus_watch),
+					      watch_dbus_flags(dbus_watch),
+					      handle_watch, dbus_watch),
+			    0);
+	return 1;
+}
+
+static void remove_watch(DBusWatch *watch, void *context)
+{
+	watch_free(dbus_watch_get_data(watch));
+}
+
+static void toggle_watch(DBusWatch *dbus_watch, void *context)
+{
+	if(dbus_watch_get_enabled(dbus_watch))
+		watch_set_events(dbus_watch_get_data(dbus_watch),
+				 watch_dbus_flags(dbus_watch));
+	else
+		watch_unset_events(dbus_watch_get_data(dbus_watch));
+}
+
+static void set_dispatch_status(DBusConnection *conn,
+				DBusDispatchStatus new_status,
+				struct watch_dispatch *watch_dispatch)
+{
+	switch(new_status) {
+		case DBUS_DISPATCH_DATA_REMAINS:
+			watch_dispatch_enable(watch_dispatch);
+			break;
+		case DBUS_DISPATCH_COMPLETE:
+			watch_dispatch_disable(watch_dispatch);
+			break;
+		default:
+			fprintf(stderr, "unknown dispatch status\n");
+	}
+}
+
+static dbus_bool_t unix_user_auth(DBusConnection *conn,
+				  unsigned long uid, void *context)
+{
+	/* Allow root access. */
+	if(uid == 0)
+		return TRUE;
+
+	/* Deny anybody else. */
+	syslog(LOG_ERR, "DBUS access denied. "
+	       "Only root has DBus access [uid = %lu denied]", uid);
+	return FALSE;
+}
+
+static DBusHandlerResult message_dbus(DBusConnection *conn,
+				      DBusMessage *message,
+				      struct interface_dbus *interface_dbus)
+{
+	const char *name;
+	DBusMessage *reply = 0;
+	int n;
+
+	reply = dbus_message_new_method_return(message);
+	
+	if(dbus_message_get_type(message) != DBUS_MESSAGE_TYPE_METHOD_CALL) {
+		syslog(LOG_ERR, "DBus unknown message type %d",
+		       dbus_message_get_type(message));
+		
+		/* FIXME: Return error message. */
+		goto send_reply;
+	}
+	
+	name = dbus_message_get_member(message);
+	for(n = 0; interface_dbus->methods[n].name; n++)
+		if(strcmp(name, interface_dbus->methods[n].name) == 0)
+			interface_dbus->methods[n].callback(message, reply);
+	
+	/* FIXME: Return error messages for unknown methods. */
+	
+send_reply:
+	dbus_connection_send(conn, reply, 0);
+	dbus_message_unref(reply);
+	
+	return DBUS_HANDLER_RESULT_HANDLED;
+}
+
+static void unregister_dbus(DBusConnection *conn, void *context)
+{
+	/* Drop the connection. */
+	dbus_connection_unref(conn);
+}
+
+static DBusHandlerResult filter_dbus(DBusConnection *connection,
+				     DBusMessage *message,
+				     void *user_data)
+{
+	/* print_dbus_message(message); */
+	return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
+}
+
+static DBusHandlerResult handle_dbus_disconnect(DBusConnection *conn,
+						DBusMessage *message,
+						void *context)
+{
+	/* FIXME: Check message, but it's probably "Disconnected". */
+	dbus_connection_unref(conn);
+	return DBUS_HANDLER_RESULT_HANDLED;
+}
+
+static void connection_dbus(DBusServer *server, DBusConnection *conn,
+			   void *context)
+{
+	const char *disconnect_path[] =
+		{ "org", "freedesktop", "Local", 0 };
+	char *path[] =
+		{ "org", "bluez", "hcid", 0 /* This one is replaced. */, 0 };
+	DBusObjectPathVTable disconnect_vtable = {
+		message_function:    handle_dbus_disconnect,
+		unregister_function: 0
+	};
+	DBusObjectPathVTable vtable;
+	struct interface_list *if_item;
+
+	/* Accept the connection and keep it alive. */
+	dbus_connection_ref(conn);
+	dbus_connection_set_unix_user_function(conn, unix_user_auth, 0, 0);
+	
+	for(if_item = interface_list; if_item; if_item = if_item->next) {
+		path[3] = if_item->interface_dbus->name;
+		vtable.message_function = message_dbus;
+		vtable.unregister_function = unregister_dbus;
+		dbus_connection_register_object_path(conn, path, &vtable,
+						     if_item->interface_dbus);
+	}
+
+	if (!dbus_connection_add_filter(conn, filter_dbus, 0, 0))
+		goto nomem;
+	if (!dbus_connection_register_object_path(conn,
+						  disconnect_path,
+						  &disconnect_vtable,
+						  0))
+		goto nomem;
+	
+	if(!dbus_connection_set_watch_functions(conn,
+						add_watch,
+						remove_watch,
+						toggle_watch,
+						0, 0))
+		goto nomem;
+	
+	dbus_connection_set_dispatch_status_function
+		(conn, set_dispatch_status,
+		 watch_allocate_dispatch(dbus_connection_dispatch, conn, 0),
+		 watch_free_dispatch);
+	return;
+
+nomem:
+	syslog(LOG_ERR, "DBUS error no memory.");
+	exit(1);
+}
+
+void register_dbus_interface(const struct interface_dbus *interface_dbus,
+			     void *context)
+{
+	struct interface_list *if_item;
+
+	if_item = malloc(sizeof(struct interface_list));
+	if(!if_item) {
+		syslog(LOG_ERR, "Failed to allocate interface_list. "
+		       "Exit. %s(%d)", strerror(errno), errno);
+		exit(1);
+	}
+
+	if_item->interface_dbus = interface_dbus;
+	if_item->context = context;
+
+	if_item->next = interface_list;
+	interface_list = if_item;
+}
+
+void unregister_dbus_interface(const struct interface_dbus *interface_dbus)
+{
+	struct interface_list *if_item;
+	
+	for(if_item = interface_list; if_item; if_item = if_item->next)
+		if(if_item->interface_dbus == interface_dbus) {
+			free(if_item);
+			return;
+		}
+}
+
+int init_dbus(void)
+{
+	dbus_error_init(&error);
+
+	server = dbus_server_listen(HCID_DBUS_ADDRESS, &error);
+	if(dbus_error_is_set(&error)) {
+		syslog(LOG_ERR, "DBUS server_listen error: %s Exit.",
+		       error.message);
+		exit(1);
+	}
+
+	dbus_server_set_new_connection_function(server, connection_dbus, 0, 0);
+	if(!dbus_server_set_watch_functions(server,
+					    add_watch,
+					    remove_watch,
+					    toggle_watch,
+					    0, 0)) {
+		syslog(LOG_ERR, "DBUS dbus_server_set_watch_functions error. "
+		       "Exit.");
+		exit(1);
+	}
+
+	syslog(LOG_INFO, "DBUS server listening");
+
+	return 1;
+}
+
+void exit_dbus(void)
+{
+	dbus_error_free(&error);
+
+	if(server) {
+		dbus_server_unref(server);
+		server = 0;
+	}
+}
diff -Naur bluez-utils-2.4.orig/hcid/dbus.h bluez-utils-2.4/hcid/dbus.h
--- bluez-utils-2.4.orig/hcid/dbus.h	1970-01-01 01:00:00.000000000 +0100
+++ bluez-utils-2.4/hcid/dbus.h	2004-02-02 19:13:40.000000000 +0100
@@ -0,0 +1,32 @@
+/* 
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *  Copyright (C) 2004 Fredrik Noring
+ *  
+ *  Written 2004 by Fredrik Noring <noring@nocrew.org>
+ *  
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ */
+
+#define DBUS_API_SUBJECT_TO_CHANGE
+#include <dbus/dbus.h>
+
+struct method_dbus {
+	char *name;
+	int (*callback)(DBusMessage *message, DBusMessage *reply);
+};
+
+struct interface_dbus {
+	char *name;
+	struct method_dbus *methods;
+};
+
+void print_dbus_message(DBusMessage *message);
+
+void register_dbus_interface(const struct interface_dbus *interface_dbus,
+			     void *context);
+void unregister_dbus_interface(const struct interface_dbus *interface_dbus);
+
+int init_dbus(void);
+void exit_dbus(void);
diff -Naur bluez-utils-2.4.orig/hcid/glib-ectomy.c bluez-utils-2.4/hcid/glib-ectomy.c
--- bluez-utils-2.4.orig/hcid/glib-ectomy.c	2003-07-24 19:15:15.000000000 +0200
+++ bluez-utils-2.4/hcid/glib-ectomy.c	1970-01-01 01:00:00.000000000 +0100
@@ -1,171 +0,0 @@
-#include "glib-ectomy.h"
-
-#include <stdio.h>
-#include <string.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <errno.h>
-#include <fcntl.h>
-#include <limits.h>
-
-// static void remove_watch(int fd);
-
-GIOError    g_io_channel_read   (GIOChannel    *channel, 
-			         gchar         *buf, 
-			         gsize          count,
-			         gsize         *bytes_read)
-{
-	int fd = channel->fd;
-	gssize result;
-	
-  if (count > SSIZE_MAX) /* At least according to the Debian manpage for read */
-    count = SSIZE_MAX;
-
- retry:
-  result = read (fd, buf, count);
- 
-  if (result < 0)
-    {
-      *bytes_read = 0;
-
-      switch (errno)
-        {
-#ifdef EINTR
-          case EINTR:
-            goto retry;
-#endif
-#ifdef EAGAIN
-          case EAGAIN:
-            return G_IO_STATUS_AGAIN;
-#endif
-          default:
-            return G_IO_STATUS_ERROR;
-        }
-    }
-
-  *bytes_read = result;
-
-  return (result > 0) ? G_IO_STATUS_NORMAL : G_IO_STATUS_EOF;
-}
-
-void      g_io_channel_close    (GIOChannel    *channel)
-{
-	int fd = channel->fd;
-
-	close(fd);
-
-	memset(channel, 0, sizeof(channel));
-	free(channel);
-}
-
-GIOChannel* g_io_channel_unix_new    (int         fd)
-{
-	GIOChannel *channel = malloc(sizeof(GIOChannel));
-	channel->fd = fd;
-	return channel;
-}
-
-gint        g_io_channel_unix_get_fd (GIOChannel *channel)
-{
-	return channel->fd;
-}
-
-
-
-struct watch {
-	guint id;
-	GIOChannel *channel;
-	GIOCondition condition;
-	GIOFunc func;
-	gpointer user_data;
-
-	struct watch *next;
-};
-
-static struct watch watch_head = { .id = 0, .next = 0 };
-
-guint     g_io_add_watch        (GIOChannel      *channel,
-				 GIOCondition     condition,
-				 GIOFunc          func,
-				 gpointer         user_data)
-{
-	struct watch *watch = malloc(sizeof(struct watch));
-
-	watch->id = ++watch_head.id;
-	watch->channel = channel;
-	watch->condition = condition;
-	watch->func = func;
-	watch->user_data = user_data;
-
-	watch->next = watch_head.next;
-	watch_head.next = watch;
-
-	return watch->id;
-}
-
-GMainLoop *g_main_loop_new        (GMainContext *context,
-			    	   gboolean      is_running)
-{
-	GMainLoop *ml = malloc(sizeof(GMainLoop));
-
-	ml->bail = 0;
-
-	return ml;
-}
-
-void       g_main_loop_run        (GMainLoop    *loop)
-{
-	int open_max = sysconf(_SC_OPEN_MAX);
-	struct pollfd *ufds = malloc(open_max * sizeof(struct pollfd));
-
-	while (!loop->bail) {
-		int nfds, rc, i;
-		struct watch *p, *w;
-
-		nfds = 0;
-		for (w = watch_head.next; w != NULL; w = w->next) {
-			ufds[nfds].fd = w->channel->fd;
-			ufds[nfds].events = w->condition;
-			ufds[nfds].revents = 0;
-			nfds++;
-		}
-		
-		rc = poll(ufds, nfds, -1);
-
-		if (rc < 0 && (errno == EINTR))
-			continue;
-
-		if (rc < 0) {
-			perror("poll");
-			continue;
-		}
-		
-		p = &watch_head;
-		w = watch_head.next;
-		i = 0;
-		while (w) {
-			if (ufds[i].revents) {
-				gboolean keep = w->func(w->channel, ufds[i].revents, w->user_data);
-				if (!keep) {
-					 p->next = w->next;
-					 memset(w, 0, sizeof(*w));
-					 w = p->next;
-					 i++;
-					 continue;
-				}
-			}	
-		
-			p = w;
-			w = w->next;
-			i++;
-		}
-
-	}
-
-	free(ufds);
-}
-
-void       g_main_loop_quit       (GMainLoop    *loop)
-{
-	loop->bail = 1;
-}
diff -Naur bluez-utils-2.4.orig/hcid/glib-ectomy.h bluez-utils-2.4/hcid/glib-ectomy.h
--- bluez-utils-2.4.orig/hcid/glib-ectomy.h	2003-04-27 17:46:45.000000000 +0200
+++ bluez-utils-2.4/hcid/glib-ectomy.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,106 +0,0 @@
-#ifndef _GLIB_ECTOMY_H_
-#define _GLIB_ECTOMY_H_
-
-#include <stdlib.h>
-#include <sys/poll.h>
-
-typedef char   gchar;
-typedef short  gshort;
-typedef long   glong;
-typedef int    gint;
-typedef gint   gboolean;
-
-typedef unsigned char   guchar;
-typedef unsigned short  gushort;
-typedef unsigned long   gulong;
-typedef unsigned int    guint;
-
-typedef float   gfloat;
-typedef double  gdouble;
-
-typedef void* gpointer;
-typedef const void *gconstpointer;
-
-typedef size_t gsize;
-typedef ssize_t gssize;
-
-#ifndef SSIZE_MAX
-#define SSIZE_MAX	INT_MAX
-#endif
-
-
-typedef struct _GIOChannel {
-	int fd;
-} GIOChannel;
-
-typedef struct _GMainContext {
-	int dummy;
-} GMainContext;
-
-typedef struct _GMainLoop {
-	int bail;
-} GMainLoop;
-
-typedef enum
-{
-  G_IO_ERROR_NONE,
-  G_IO_ERROR_AGAIN,
-  G_IO_ERROR_INVAL,
-  G_IO_ERROR_UNKNOWN
-} GIOError;
-
-typedef enum
-{
-  G_IO_STATUS_ERROR = -1,
-  G_IO_STATUS_NORMAL = 0,
-  G_IO_STATUS_EOF = 1,
-  G_IO_STATUS_AGAIN = 2
-} GIOStatus;
-
-#ifndef	FALSE
-#define	FALSE	(0)
-#endif
-
-#ifndef	TRUE
-#define	TRUE	(!FALSE)
-#endif
-
-
-typedef enum
-{
-  G_IO_IN	= POLLIN,
-  G_IO_OUT	= POLLOUT,
-  G_IO_PRI	= POLLPRI,
-  G_IO_ERR	= POLLERR,
-  G_IO_HUP	= POLLHUP,
-  G_IO_NVAL	= POLLNVAL
-} GIOCondition;
-
-typedef gboolean (*GIOFunc) (GIOChannel   *source,
-			     GIOCondition  condition,
-			     gpointer      data);
-
-GIOError    g_io_channel_read   (GIOChannel    *channel, 
-			         gchar         *buf, 
-			         gsize          count,
-			         gsize         *bytes_read);
-void      g_io_channel_close    (GIOChannel    *channel);
-
-GIOChannel* g_io_channel_unix_new    (int         fd);
-gint        g_io_channel_unix_get_fd (GIOChannel *channel);
-guint     g_io_add_watch        (GIOChannel      *channel,
-				 GIOCondition     condition,
-				 GIOFunc          func,
-				 gpointer         user_data);
-
-
-GMainLoop *g_main_loop_new        (GMainContext *context,
-			    	   gboolean      is_running);
-void       g_main_loop_run        (GMainLoop    *loop);
-void       g_main_loop_quit       (GMainLoop    *loop);
-
-#define 	g_main_new(is_running)	g_main_loop_new (NULL, is_running);
-#define         g_main_run(loop)        g_main_loop_run(loop)
-#define         g_main_quit(loop)       g_main_loop_quit(loop)
-
-#endif
diff -Naur bluez-utils-2.4.orig/hcid/hcid.h bluez-utils-2.4/hcid/hcid.h
--- bluez-utils-2.4.orig/hcid/hcid.h	2004-02-01 21:20:41.000000000 +0100
+++ bluez-utils-2.4/hcid/hcid.h	2004-02-02 19:13:40.000000000 +0100
@@ -26,7 +26,7 @@
 
 #include <sys/types.h>
 
-#include "glib-ectomy.h"
+#include "watch.h"
 
 #include <bluetooth/bluetooth.h>
 
@@ -103,10 +103,11 @@
 void free_device_opts(void);
 struct device_opts *allocate_device_opts(char *bdaddr);
 
-gboolean io_stack_event(GIOChannel *chan, GIOCondition cond, gpointer data);
-gboolean io_security_event(GIOChannel *chan, GIOCondition cond, gpointer data);
-
+/* These really belongs in security.h. */
 void init_security_data(void);
 void start_security_manager(int hdev);
 void stop_security_manager(int hdev);
 void toggle_pairing(int enable);
+void init_security(void);
+void reset_security(void);
+void exit_security(void);
diff -Naur bluez-utils-2.4.orig/hcid/keytab.c bluez-utils-2.4/hcid/keytab.c
--- bluez-utils-2.4.orig/hcid/keytab.c	2004-02-01 21:20:41.000000000 +0100
+++ bluez-utils-2.4/hcid/keytab.c	2004-02-02 19:38:19.000000000 +0100
@@ -26,6 +26,7 @@
 #include <bluetooth/hci_lib.h>
 
 #include "hcid.h"
+#include "dbus.h"
 #include "lib.h"
 #include "file.h"
 
@@ -267,7 +268,7 @@
  */
 static struct link_key_list *load_keys(void)
 {
-	struct link_key_list *link_key_list;
+	struct link_key_list *link_key_list = 0;
 	struct file *key_file;
 	
 	/* Read "keytab" file first... */
@@ -392,12 +393,12 @@
 	close(keytab_fd);
 }
 
-void init_link_key(void)
+static void convert_deprecate_key_list(void)
 {
 	struct link_key_list *link_key_list;
 
-	/* Convert deprecated key_list file if needed. */
 	link_key_list = load_keys();
+
 	if(!link_key_list) {
 		link_key_list = load_deprecated_link_keys();
 		if(link_key_list) {
@@ -406,7 +407,9 @@
 			save_keys(link_key_list);
 		}
 	}
-	free_link_key_list(link_key_list);
+
+	if(link_key_list)
+		free_link_key_list(link_key_list);
 }
 
 int get_link_key(struct link_key *link_key, bdaddr_t *sba, bdaddr_t *dba)
@@ -426,6 +429,16 @@
 	return 1;
 }
 
+void delete_key(struct link_key_list *keys, struct link_key *del_key)
+{
+	struct link_key_list *key;
+
+	for(key = keys; key; key = key->next)
+		if(key->has_key && &key->link_key == del_key)
+			key->has_key = 0;
+	                /* Continue as there may be duplicates... */
+}
+
 void set_link_key(struct link_key *key)
 {
 	struct link_key_list *link_key_list;
@@ -455,3 +468,101 @@
 	syslog(LOG_INFO, "%s link key %s %s",
 	       exists ? "Replacing" : "Saving", sba, dba);
 }
+
+/*
+ * DBus interface to keytab
+ */
+
+static int method_dbus_list(DBusMessage *message, DBusMessage *reply)
+{
+	DBusMessageIter iter, iter2, iter3;
+	struct link_key_list *keys, *key;
+	
+	keys = load_keys();
+
+	dbus_message_append_iter_init(reply, &iter);
+	if(keys) {
+		dbus_message_iter_append_array(&iter, &iter2, DBUS_TYPE_ARRAY);
+		for(key = keys; key; key = key->next) {
+			char sba_str[18], dba_str[18];
+			
+			dbus_message_iter_append_array(&iter2, &iter3,
+						       DBUS_TYPE_STRING);
+			
+			ba2str(&key->link_key.sba, sba_str);
+			ba2str(&key->link_key.dba, dba_str);
+			dbus_message_iter_append_string(&iter3, sba_str);
+			dbus_message_iter_append_string(&iter3, dba_str);
+		}
+	} else
+		dbus_message_iter_append_nil(&iter);
+	
+	if(keys)
+		free_link_key_list(keys);
+	
+	return 1;
+}
+
+static int method_dbus_delete(DBusMessage *message, DBusMessage *reply)
+{
+	struct link_key_list *keys;
+	DBusMessageIter iter;
+	char **keypair;
+	int len;
+	
+	dbus_message_iter_init(message, &iter);
+	if(dbus_message_iter_get_string_array(&iter, &keypair, &len)) {
+		struct link_key *key;
+		bdaddr_t sba, dba;
+		
+		if(len != 2)
+			return 0;
+		
+		keys = load_keys();
+		if(!keys)
+			return 0;
+
+		str2ba(keypair[0], &sba);
+		str2ba(keypair[1], &dba);
+		
+		key = get_key(keys, &sba, &dba);
+		if(key) {
+			syslog(LOG_INFO, "Delete key pair %s %s",
+			       keypair[0], keypair[1]);
+	
+			delete_key(keys, key);
+			save_keys(keys);
+		}
+		
+		free_link_key_list(keys);
+	}
+	
+	return 1;
+}
+
+/*
+ * Init and exit keytab
+ */
+
+static struct method_dbus methods[] = {
+	{ name:     "list",   callback: method_dbus_list   },
+	{ name:     "delete", callback: method_dbus_delete },
+	{ 0                                                }
+};
+
+static struct interface_dbus interface = {
+	name: "keytab"
+};
+
+void init_keytab(void)
+{
+	convert_deprecate_key_list();
+
+	interface.methods = methods;
+	register_dbus_interface(&interface, 0);
+}
+
+void exit_keytab(void)
+{
+	unregister_dbus_interface(&interface);
+}
diff -Naur bluez-utils-2.4.orig/hcid/keytab.h bluez-utils-2.4/hcid/keytab.h
--- bluez-utils-2.4.orig/hcid/keytab.h	2004-02-01 21:20:41.000000000 +0100
+++ bluez-utils-2.4/hcid/keytab.h	2004-02-02 19:13:40.000000000 +0100
@@ -9,6 +9,8 @@
  *  published by the Free Software Foundation.
  */
 
-void init_link_key(void);
 void set_link_key(struct link_key *key);
 int get_link_key(struct link_key *link_key, bdaddr_t *sba, bdaddr_t *dba);
+
+void init_keytab(void);
+void exit_keytab(void);
diff -Naur bluez-utils-2.4.orig/hcid/Makefile.am bluez-utils-2.4/hcid/Makefile.am
--- bluez-utils-2.4.orig/hcid/Makefile.am	2004-02-01 21:19:36.000000000 +0100
+++ bluez-utils-2.4/hcid/Makefile.am	2004-02-02 19:13:40.000000000 +0100
@@ -4,13 +4,18 @@
 
 sbin_PROGRAMS = hcid
 
-hcid_SOURCES = main.c security.c hcid.h lib.c lib.h parser.h parser.y lexer.l kword.h kword.c glib-ectomy.h glib-ectomy.c file.c keytab.c
+hcid_SOURCES = main.c security.c hcid.h lib.c lib.h parser.h parser.y \
+               lexer.l kword.h kword.c glib-ectomy.h watch.c file.c   \
+               keytab.c dbus.c
 hcid_CONFIG  = hcid.conf
 
-AM_YFLAGS   = -d
+AM_YFLAGS = -d
 
 CLEANFILES = lexer.c parser.c parser.h
 
+AM_CFLAGS  = $(DBUS_CFLAGS)
+hcid_LDADD = $(DBUS_LIBS)
+
 EXTRA_DIST = $(hcid_CONFIG)
 
 #
diff -Naur bluez-utils-2.4.orig/hcid/security.c bluez-utils-2.4/hcid/security.c
--- bluez-utils-2.4.orig/hcid/security.c	2004-02-01 21:20:41.000000000 +0100
+++ bluez-utils-2.4/hcid/security.c	2004-02-02 19:13:40.000000000 +0100
@@ -46,14 +46,12 @@
 #include <bluetooth/hci.h>
 #include <bluetooth/hci_lib.h>
 
-#include "glib-ectomy.h"
-
 #include "hcid.h"
 #include "lib.h"
 #include "file.h"
 #include "keytab.h"
 
-static GIOChannel *io_chan[HCI_MAX_DEV];
+static struct watch *hci_watch_list[HCI_MAX_DEV];
 
 static int pairing;
 
@@ -281,37 +279,37 @@
 	return;
 }
 
-gboolean io_security_event(GIOChannel *chan, GIOCondition cond, gpointer data)
+void io_security_event(struct watch *watch, short events,
+		       struct hci_dev_info *di)
 {
 	char buf[HCI_MAX_EVENT_SIZE], *ptr = buf;
-	struct hci_dev_info *di = (void *) data;
 	int len, type, dev;
 	hci_event_hdr *eh;
-	GIOError err;
+	int err;
 
-	if (cond & (G_IO_NVAL | G_IO_HUP | G_IO_ERR)) {
-		g_io_channel_close(chan);
-		free(data);
-		return FALSE;
+	if (events & (WATCH_NVAL | WATCH_HUP | WATCH_ERR)) {
+		watch_free(watch);
+		free(di);
+		return;
 	}
 	
-	if ((err = g_io_channel_read(chan, buf, sizeof(buf), &len))) {
-		if (err == G_IO_ERROR_AGAIN)
-			return TRUE;
-		g_io_channel_close(chan);
-		free(data);
-		return FALSE;
+	if ((err = watch_read(watch, buf, sizeof(buf), &len))) {
+		if (err == WATCH_ERROR_AGAIN)
+			return;
+		watch_free(watch);
+		free(di);
+		return;
 	}
 
 	type = *ptr++;
 
 	if (type != HCI_EVENT_PKT)
-		return TRUE;
+		return;
 
 	eh = (hci_event_hdr *) ptr;
 	ptr += HCI_EVENT_HDR_SIZE;
 
-	dev = g_io_channel_unix_get_fd(chan);
+	dev = watch_get_fd(watch);
 
 	switch (eh->evt) {
 	case EVT_PIN_CODE_REQ:
@@ -327,12 +325,12 @@
 		break;
 	}
 		
-	return TRUE;
+	return;
 }
 
 void start_security_manager(int hdev)
 {
-	GIOChannel *chan = io_chan[hdev];
+	struct watch *chan = hci_watch_list[hdev];
 	struct hci_dev_info *di;
 	struct hci_filter flt;
 	int dev;
@@ -342,8 +340,6 @@
 	
 	syslog(LOG_INFO, "Starting security manager %d", hdev);
 
-	init_link_key();
-	
 	if ((dev = hci_open_dev(hdev)) < 0) {
 		syslog(LOG_ERR, "Can't open device hci%d. %s(%d)",
 				hdev, strerror(errno), errno);
@@ -379,18 +375,18 @@
 		return;
 	}
 	
-	chan = g_io_channel_unix_new(dev);
-	g_io_add_watch(chan, G_IO_IN | G_IO_NVAL | G_IO_HUP | G_IO_ERR,
-			io_security_event, (void *) di);
+	chan = watch_allocate_fd(dev,
+				 WATCH_IN | WATCH_NVAL | WATCH_HUP | WATCH_ERR,
+				 io_security_event, di);
 
-	io_chan[hdev] = chan;
+	hci_watch_list[hdev] = chan;
 }
 
 void stop_security_manager(int hdev)
 {
-	GIOChannel *chan = io_chan[hdev];
+	struct watch *watch = hci_watch_list[hdev];
 
-	if (!chan)
+	if (!watch)
 		return;
 
 	syslog(LOG_INFO, "Stoping security manager %d", hdev);
@@ -398,11 +394,13 @@
 	/* this is a bit sneaky. closing the fd will cause the event
 	   loop to call us right back with G_IO_NVAL set, at which
 	   point we will see it and clean things up */
-	close(g_io_channel_unix_get_fd(chan));
-	io_chan[hdev] = NULL;
+	close(watch_get_fd(watch));
+	free(watch_get_context(watch));
+	watch_free(watch);
+	hci_watch_list[hdev] = NULL;
 }
 
-void init_security_data(void)
+void reset_security(void)
 {
 	/* Set local PIN code */
 	if (read_pin_code() < 0) {
@@ -411,5 +409,21 @@
 	}
 
 	pairing = hcid.pairing;
-	return;
+}
+
+void init_security(void)
+{
+	/* Setting hci_watch_list to zero isn't needed because it's a
+	 * global variable. */
+
+	reset_security();
+}
+
+void exit_security(void)
+{
+	int hdev;
+
+	for(hdev = 0; hdev < HCI_MAX_DEV; hdev++)
+		if(hci_watch_list[hdev])
+			stop_security_manager(hdev);
 }
diff -Naur bluez-utils-2.4.orig/hcid/watch.c bluez-utils-2.4/hcid/watch.c
--- bluez-utils-2.4.orig/hcid/watch.c	1970-01-01 01:00:00.000000000 +0100
+++ bluez-utils-2.4/hcid/watch.c	2004-02-02 19:32:32.000000000 +0100
@@ -0,0 +1,289 @@
+/* 
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *  Copyright (C) 2004 Fredrik Noring
+ *  
+ *  Written 2004 by Fredrik Noring <noring@nocrew.org>
+ *  
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ */
+
+#include <syslog.h>
+
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <limits.h>
+
+#include "hcid.h"
+
+struct watch_list {
+	short events;
+	
+	void (*callback)(struct watch *watch, short flags, void *context);
+
+	struct watch_list *next;
+	struct watch watch;
+};
+
+struct watch_dispatch_list {
+	int is_active;
+	
+	void (*callback)(void *context);
+	void *context;
+
+	struct watch_dispatch_list *next;
+	struct watch_dispatch watch_dispatch;
+};
+
+static struct watch_list *watch_list = 0;
+static struct watch_dispatch_list *watch_dispatch_list = 0;
+
+/*
+ * count > SSIZE_MAX gives unspecified results (according to "man s 2 read")
+ */
+int watch_read(struct watch *watch, void *buf,
+	       size_t count, size_t *bytes_read)
+{
+	ssize_t result;
+
+	*bytes_read = 0;
+retry:
+	result = read(watch->fd, buf, count);
+ 	if (result < 0)
+		switch (errno) {
+			case EINTR:
+				goto retry;
+
+			case EAGAIN:
+				return WATCH_STATUS_AGAIN;
+
+			default:
+				return WATCH_STATUS_ERROR;
+		}
+	
+	*bytes_read = result;
+	return result > 0 ? WATCH_STATUS_NORMAL : WATCH_STATUS_EOF;
+}
+
+struct watch* watch_allocate_fd(int fd, short events,
+				void (*callback)(struct watch *watch,
+						 short flags,
+						 void *context),
+				void *context)
+{
+	struct watch_list *wl_item;
+	
+	wl_item = malloc(sizeof(struct watch_list));
+	if(!wl_item) {
+		syslog(LOG_ERR, "Failed to allocate watch_list. Exit. %s(%d)",
+		       strerror(errno), errno);
+		exit(1);
+	}
+
+	wl_item->watch.fd = fd;
+	wl_item->watch.context = context;
+	wl_item->events = events;
+	wl_item->watch.is_invalid = 0;
+	wl_item->callback = callback;
+
+	wl_item->next = watch_list;
+	watch_list = wl_item;
+
+	return &wl_item->watch;
+}
+
+void watch_free(struct watch *watch)
+{
+	/* Delayed freeing because there are most likely loops using
+	 * it right now. */
+	watch->is_invalid = 1;
+}
+
+static void watch_free_invalid(void)
+{
+	struct watch_list *wl_item, **prev, *next;
+
+	prev = &watch_list;
+	for(wl_item = watch_list; wl_item; wl_item = next) {
+		next = wl_item->next;
+		if(wl_item->watch.is_invalid) {
+			*prev = next;
+			free(wl_item);
+		} else
+			prev = &wl_item->next;
+	}
+}
+
+void watch_set_events(struct watch *watch, short events)
+{
+	struct watch_list *wl_item;
+
+	for(wl_item = watch_list; wl_item; wl_item = wl_item->next)
+		if(&wl_item->watch == watch) {
+			wl_item->events = events;
+			return;
+		}
+	
+	syslog(LOG_ERR, "Failed to set events on watch %p.", watch);
+}
+
+void watch_unset_events(struct watch *watch)
+{
+	watch_set_events(watch, 0);
+}
+
+int watch_get_fd(struct watch *watch)
+{
+	return watch->fd;
+}
+
+void *watch_get_context(struct watch *watch)
+{
+	return watch->context;
+}
+
+struct watch_dispatch *watch_allocate_dispatch(void (*callback)(void *context),
+					       void *context, int is_active)
+{
+	struct watch_dispatch_list *dp_item;
+
+	dp_item = malloc(sizeof(struct watch_dispatch_list));
+	if(!dp_item) {
+		syslog(LOG_ERR, "Failed to allocate watch_dispatch_list. "
+		       "Exit. %s(%d)", strerror(errno), errno);
+		exit(1);
+	}
+
+	dp_item->is_active = is_active;
+	dp_item->callback = callback;
+	dp_item->context = context;
+	dp_item->watch_dispatch.is_invalid = 0;
+	
+	dp_item->next = watch_dispatch_list;
+	watch_dispatch_list = dp_item;
+
+	return &dp_item->watch_dispatch;
+}
+
+void watch_free_dispatch(struct watch_dispatch *watch_dispatch)
+{
+	/* Delayed freeing because there are most likely loops using
+	 * it right now. */
+	watch_dispatch->is_invalid = 1;
+}
+
+static void watch_free_invalid_dispatches(void)
+{
+	struct watch_dispatch_list *dp_item, **prev, *next;
+
+	prev = &watch_dispatch_list;
+	for(dp_item = watch_dispatch_list; dp_item; dp_item = next) {
+		next = dp_item->next;
+		if(dp_item->watch_dispatch.is_invalid) {
+			*prev = next;
+			free(dp_item);
+		} else
+			prev = &dp_item->next;
+	}
+}
+
+static void watch_dispatch_set_status(struct watch_dispatch *watch_dispatch,
+				      int is_active)
+{
+	struct watch_dispatch_list *dp_item;
+	
+	for(dp_item = watch_dispatch_list; dp_item; dp_item = dp_item->next)
+		if(&dp_item->watch_dispatch == watch_dispatch) {
+			dp_item->is_active = is_active;
+			return;
+		}
+	
+	syslog(LOG_ERR, "Failed dispatch_set_status %p [%d].",
+	       watch_dispatch, is_active);
+}
+
+void watch_dispatch_enable(struct watch_dispatch *watch_dispatch)
+{
+	watch_dispatch_set_status(watch_dispatch, 1);
+}
+
+void watch_dispatch_disable(struct watch_dispatch *watch_dispatch)
+{
+	watch_dispatch_set_status(watch_dispatch, 0);
+}
+
+static void watch_run_dispatches(void)
+{
+	struct watch_dispatch_list *dp_item;
+	
+	for(dp_item = watch_dispatch_list; dp_item; dp_item = dp_item->next)
+		if(dp_item->is_active)
+			dp_item->callback(dp_item->context);
+}
+
+void watch_run(struct watch_loop *watch_loop)
+{
+	struct pollfd *ufds =
+		malloc(sysconf(_SC_OPEN_MAX) * sizeof(struct pollfd));
+
+	while (!watch_loop->exit) {
+		struct watch_list *wl_item, *next;
+		int n;
+
+		n = 0;
+		for(wl_item = watch_list; wl_item; wl_item = wl_item->next)
+			if(wl_item->events) {
+				ufds[n].fd = wl_item->watch.fd;
+				ufds[n].events = wl_item->events;
+				ufds[n].revents = 0;
+				n++;
+			}
+		
+		n = poll(ufds, n, -1);
+		if (n < 0 && errno == EINTR)
+			continue;
+		if (n < 0) {
+			perror("poll");
+			continue;
+		}
+		
+		n = 0;
+		for(wl_item = watch_list; wl_item; wl_item = next) {
+			next = wl_item->next;
+
+			if(!wl_item->events)
+				continue;
+			if (ufds[n].revents && !wl_item->watch.is_invalid)
+				wl_item->callback(&wl_item->watch,
+						  ufds[n].revents,
+						  wl_item->watch.context);
+			n++;
+		}
+
+		watch_run_dispatches();
+		
+		watch_free_invalid();
+		watch_free_invalid_dispatches();
+	}
+
+	free(ufds);
+}
+
+void watch_exit_loop(struct watch_loop *watch_loop)
+{
+	watch_loop->exit = 1;
+}
+
+void init_watch(struct watch_loop *watch_loop)
+{
+	watch_loop->exit = 0;
+}
+
+void exit_watch(struct watch_loop *watch_loop)
+{
+}
diff -Naur bluez-utils-2.4.orig/hcid/watch.h bluez-utils-2.4/hcid/watch.h
--- bluez-utils-2.4.orig/hcid/watch.h	1970-01-01 01:00:00.000000000 +0100
+++ bluez-utils-2.4/hcid/watch.h	2004-02-02 19:24:24.000000000 +0100
@@ -0,0 +1,75 @@
+/* 
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *  Copyright (C) 2004 Fredrik Noring
+ *  
+ *  Written 2004 by Fredrik Noring <noring@nocrew.org>
+ *  
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ */
+
+#include <stdlib.h>
+#include <sys/poll.h>
+
+struct watch {
+	int fd;
+	void *context;
+	int is_invalid;
+};
+
+struct watch_loop {
+	int exit;
+};
+
+struct watch_dispatch {
+	int is_invalid;
+};
+
+enum {
+	WATCH_ERROR_NONE,
+	WATCH_ERROR_AGAIN,
+	WATCH_ERROR_INVAL,
+	WATCH_ERROR_UNKNOWN
+};
+
+#define WATCH_STATUS_ERROR  -1
+#define WATCH_STATUS_NORMAL  0
+#define WATCH_STATUS_EOF     1
+#define WATCH_STATUS_AGAIN   2
+
+#define WATCH_IN   POLLIN
+#define WATCH_OUT  POLLOUT
+#define WATCH_PRI  POLLPRI
+#define WATCH_ERR  POLLERR
+#define WATCH_HUP  POLLHUP
+#define WATCH_NVAL POLLNVAL
+
+/* Watch functions */
+int watch_read(struct watch *channel, void *buf,
+	       size_t count, size_t *bytes_read);
+struct watch* watch_allocate_fd(int fd, short events,
+				void (*callback)(struct watch *watch,
+						 short flags,
+						 void *context),
+				void *context);
+void watch_free(struct watch *watch);
+int watch_get_fd(struct watch *watch);
+void *watch_get_context(struct watch *watch);
+void watch_set_events(struct watch *watch, short events);
+void watch_unset_events(struct watch *watch);
+
+/* Watch loop functions */
+void watch_exit_loop(struct watch_loop *watch_loop);
+void watch_run(struct watch_loop *watch_loop);
+
+/* Watch dispatch functions */
+struct watch_dispatch *watch_allocate_dispatch(void (*callback)(void *context),
+					       void *context, int is_active);
+void watch_free_dispatch(struct watch_dispatch *watch_dispatch);
+void watch_dispatch_enable(struct watch_dispatch *watch_dispatch);
+void watch_dispatch_disable(struct watch_dispatch *watch_dispatch);
+
+/* Init and exit functions */
+void init_watch(struct watch_loop *watch_loop);
+void exit_watch(struct watch_loop *watch_loop);
diff -Naur bluez-utils-2.4.orig/hcid/main.c bluez-utils-2.4/hcid/main.c
--- bluez-utils-2.4.orig/hcid/main.c	2004-02-01 21:19:36.000000000 +0100
+++ bluez-utils-2.4/hcid/main.c	2004-02-02 19:58:15.000000000 +0100
@@ -44,20 +44,18 @@
 #include <bluetooth/hci.h>
 #include <bluetooth/hci_lib.h>
 
-#include "glib-ectomy.h"
-
 #include "hcid.h"
+#include "dbus.h"
 #include "lib.h"
 
+#include "keytab.h"
+
 struct hcid_opts hcid;
 struct device_opts default_device;
 struct device_opts *parser_device;
 static struct device_list *device_list = 0;
 
-static GMainLoop *event_loop;
-
-gboolean io_stack_event(GIOChannel *chan, GIOCondition cond, gpointer data);
-gboolean io_security_event(GIOChannel *chan, GIOCondition cond, gpointer data);
+static struct watch_loop watch_loop;
 
 static void usage(void)
 {
@@ -94,7 +92,7 @@
 
 static struct device_opts *get_device_opts(int sock, int hdev)
 {
-        struct device_opts *device_opts = 0;
+	struct device_opts *device_opts = 0;
 	struct hci_dev_info di;
 
 	di.dev_id = hdev;
@@ -312,8 +310,7 @@
 	struct device_list *device;
 	
 	device = malloc(sizeof(struct device_list));
-	if (!device)
-	{
+	if (!device) {
 		syslog(LOG_INFO, "Can't allocate devlist opts buffer. %s(%d)", 
 			strerror(errno), errno);
 		exit(1);
@@ -332,10 +329,8 @@
 	struct device_list *device, *next;
 
 	if(default_device.name)
-	{
 		free(default_device.name);
-		default_device.name = 0;
-	}
+	init_defaults();
 	
 	for (device = device_list; device; device = next) {
 		free(device->ref);
@@ -359,22 +354,21 @@
 
 static void sig_term(int sig)
 {
-	g_main_quit(event_loop);
+	watch_exit_loop(&watch_loop);
 }
 
 static void sig_hup(int sig)
 {
 	syslog(LOG_INFO, "Reloading config file");
-	init_defaults();
 	if (read_config(hcid.config_file) < 0)
 		syslog(LOG_ERR, "Config reload failed");
 
-	init_security_data();
+	reset_security();
 
 	init_all_devices(hcid.sock);
 }
 
-static inline void device_event(GIOChannel *chan, evt_stack_internal *si)
+static inline void device_event(struct watch *chan, evt_stack_internal *si)
 {
 	evt_si_device *sd = (void *) &si->data;
 
@@ -405,45 +399,46 @@
 	}
 }
 
-gboolean io_stack_event(GIOChannel *chan, GIOCondition cond, gpointer data)
+void io_stack_event(struct watch *watch, short events, void *data)
 {
 	char buf[HCI_MAX_FRAME_SIZE], *ptr;
 	evt_stack_internal *si;
 	hci_event_hdr *eh;
 	int  len, type;
-	GIOError err;
+	int err;
 
 	ptr = buf;
 
-	if ((err = g_io_channel_read(chan, buf, sizeof(buf), &len))) {
-		if (err == G_IO_ERROR_AGAIN)
-			return TRUE;
+	if ((err = watch_read(watch, buf, sizeof(buf), &len))) {
+		if (err == WATCH_ERROR_AGAIN)
+			return;
 
 		syslog(LOG_ERR, "Read from control socket failed. %s(%d)", 
 				strerror(errno), errno);
-		g_main_quit(event_loop);
-		return FALSE;
+		watch_exit_loop(&watch_loop);
+		watch_free(watch);
+		return;
 	}
 
 	type = *ptr++;
 
 	if (type != HCI_EVENT_PKT)
-		return TRUE;
+		return;
 
 	eh = (hci_event_hdr *) ptr;
 	if (eh->evt != EVT_STACK_INTERNAL)
-		return TRUE;
+		return;
 
 	ptr += HCI_EVENT_HDR_SIZE;
 
 	si = (evt_stack_internal *) ptr;
 	switch (si->type) {
 	case EVT_SI_DEVICE:
-		device_event(chan, si);
+		device_event(watch, si);
 		break;
 	}
 
-	return TRUE;
+	return;
 }
 
 extern int optind,opterr,optopt;
@@ -455,7 +450,7 @@
 	struct sockaddr_hci addr;
 	struct hci_filter flt;
 	struct sigaction sa;
-	GIOChannel *ctl_io;
+	struct watch *ctl_io;
 
 	daemon = 1; dofork = 1;
 
@@ -549,24 +544,39 @@
 	if (read_config(hcid.config_file) < 0)
 		syslog(LOG_ERR, "Config load failed");
 
-	init_security_data();
-
-	/* Create event loop */
-	event_loop = g_main_new(FALSE);
+	init_security();
+	init_watch(&watch_loop);
 
 	/* Initialize already connected devices */
 	init_all_devices(hcid.sock);
-
+	init_dbus();
+	
 	set_title("processing events");
 
-	ctl_io = g_io_channel_unix_new(hcid.sock);
-	g_io_add_watch(ctl_io, G_IO_IN, io_stack_event, NULL);
-
+	ctl_io = watch_allocate_fd(hcid.sock, WATCH_IN, io_stack_event, 0);
+	
+	init_keytab();
+	
 	/* Start event processor */
-	g_main_run(event_loop);
+	watch_run(&watch_loop);
+
+	exit_dbus();
+
+	exit_keytab();
+	
+	watch_free(ctl_io);
 
 	free_device_opts();
 	
+	exit_watch(&watch_loop);
+	exit_security();
+
+	close(hcid.sock);
+	free(hcid.host_name);
+	free(hcid.key_file);
+	free(hcid.pin_helper);
+	free(hcid.pin_file);
+	
 	syslog(LOG_INFO, "Exit.");
 	return 0;
 }

--=-EtQgIEzTuWGp04i4XGJj--
