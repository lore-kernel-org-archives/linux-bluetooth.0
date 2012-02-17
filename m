Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] audio: Fix signature of MediaTransport.Acquire method
Date: Fri, 17 Feb 2012 16:17:36 +0200
Message-Id: <1329488256-12998-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Acquire returns the input and output MTUs in addition to the file
descriptor, but the signature doesn't indicate that.
---
 audio/transport.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/audio/transport.c b/audio/transport.c
index 2092644..b319e0e 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -916,7 +916,7 @@ static DBusMessage *get_properties(DBusConnection *conn, DBusMessage *msg,
 
 static GDBusMethodTable transport_methods[] = {
 	{ "GetProperties",	"",	"a{sv}",	get_properties },
-	{ "Acquire",		"s",	"h",		acquire,
+	{ "Acquire",		"s",	"hqq",		acquire,
 						G_DBUS_METHOD_FLAG_ASYNC},
 	{ "Release",		"s",	"",		release,
 						G_DBUS_METHOD_FLAG_ASYNC},
-- 
1.7.7.6

