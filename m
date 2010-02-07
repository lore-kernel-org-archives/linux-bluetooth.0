Return-Path: <cyrus@holtmann.org>
From: =?utf-8?Q?=C5=81ukasz?= Stelmach <stlman@poczta.fm>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] PullBusinessCard
Date: Sun, 07 Feb 2010 23:10:08 +0100
Message-ID: <87vde8g0jj.fsf@kotik.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello.

There is a method named org.openobex.Client.PullBusinessCard in obexd
which should write downloaded vcard to a named file. At least that's what
client-api.txt says. This patch makes the method actually do what it is
supposed to. Please, however, check the way I open the file for I am not
sure of security implications.

--8<---------------cut here---------------start------------->8---
--- client/main.c	2009-09-25 22:33:18.000000000 +0200
+++ client/main.c	2010-02-07 22:47:09.486448554 +0100
@@ -29,6 +29,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <signal.h>
+#include <fcntl.h>
 
 #include <glib.h>
 #include <gdbus.h>
@@ -204,7 +205,24 @@
 static void pull_complete_callback(struct session_data *session,
 							void *user_data)
 {
+	DBusMessageIter iter;
 	struct send_data *data = user_data;
+	char* filename;
+
+	dbus_message_iter_init(data->message, &iter);
+
+	if(dbus_message_iter_next(&iter) &&
+		   DBUS_TYPE_STRING == dbus_message_iter_get_arg_type(&iter)) {
+		dbus_message_iter_get_basic(&iter, &filename);
+		int fd;
+
+		/* XXX This must be done the safest way possible. */
+		fd = open(filename, O_WRONLY | O_CREAT | O_EXCL, 0600);
+		if (fd >= 0) {
+			write(fd, session->buffer, session->filled);
+			close(fd);
+		}
+	}
 
 	g_dbus_send_reply(data->connection, data->message, DBUS_TYPE_INVALID);
 
--8<---------------cut here---------------end--------------->8---

-- 
Było mi bardzo miło.                 Young man and young woman,
>Łukasz<               Wszyscy ci co słuchają Marylina Mansona.


----------------------------------------------------------------------
Sprawdz warunki na drogach!
Kliknij >>> http://link.interia.pl/f259f

