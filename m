Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v0 10/15] input: Trivial function rename
Date: Fri, 19 Oct 2012 17:39:27 +0200
Message-Id: <1350661172-18125-11-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1350661172-18125-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1350661172-18125-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Use the local_ name prefix for functions implementing the D-Bus API.
---
 profiles/input/device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index 9dd8002..7df92e2 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -700,7 +700,7 @@ static DBusMessage *local_connect(DBusConnection *conn, DBusMessage *msg,
 	return NULL;
 }
 
-static DBusMessage *input_device_disconnect(DBusConnection *conn,
+static DBusMessage *local_disconnect(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
 	struct input_device *idev = data;
@@ -742,7 +742,7 @@ static const GDBusMethodTable device_methods[] = {
 	{ GDBUS_ASYNC_METHOD("Connect",
 				NULL, NULL, local_connect) },
 	{ GDBUS_METHOD("Disconnect",
-				NULL, NULL, input_device_disconnect) },
+				NULL, NULL, local_disconnect) },
 	{ }
 };
 
-- 
1.7.11.7

