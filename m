Return-Path: <cyrus@holtmann.org>
Message-id: <4EE22B99.10600@samsung.com>
Date: Sat, 10 Dec 2011 00:39:05 +0900
From: Chanyeol Park <chanyeol.park@samsung.com>
MIME-version: 1.0
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?B?7ISc7Zi47LKg?= <hocheol.seo@samsung.com>,
	=?UTF-8?B?7Y6464+E?= =?UTF-8?B?7ZiE?= <dh79.pyun@samsung.com>
Subject: How about adding Dbus log in gdbus?
Content-type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello

How about adding dbus log in gdbus when we get method call from the 
remote peer(application)?

Personally It could be very useful for begginer.Based on it many people 
could understand
call procedure easily. As far as I know this was removed when bluez 
3.xx. but compared to the days,
recently many dbus APIs have been introduced.

But I know it is relatetd to many projects(bluez,obexd,connman,ofono).
So we need to consider a few things such as dependency managing and user 
preference.
because curren gdbus does not have dependency with log.c/log.h.

Is there good idea about this?


BR
Chanyeol Park.

diff --git a/gdbus/object.c b/gdbus/object.c
index 8bc12f5..ac7f448 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -33,9 +33,7 @@

  #include "gdbus.h"

-#define info(fmt...)
-#define error(fmt...)
-#define debug(fmt...)
+#include "log.h"

  struct generic_data {
         unsigned int refcount;
@@ -444,6 +442,9 @@ static DBusHandlerResult 
generic_message(DBusConnection *connection,
                                                 iface->user_data) == TRUE)
                         return DBUS_HANDLER_RESULT_HANDLED;

+               DBG("%s: %s.%s()",dbus_message_get_path(message),
+                                               iface->name,method->name);
+
                 return process_message(connection, message, method,
                                                         iface->user_data);
         }


Thanks
Chanyeol Park
