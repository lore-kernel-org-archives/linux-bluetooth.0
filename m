Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 3/5] Return an error if adapter_create_device fails
Date: Wed, 15 Dec 2010 16:54:10 -0300
Message-Id: <1292442852-26457-3-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1292442852-26457-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1292442852-26457-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This function can fail if the device object is already registered or if
the system doesn't have enough memory. Issue detected due wrong device
object reference counting that doesn't unregister the D-Bus object path
when the device is removed.
---
 src/adapter.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index c1fddce..f71d063 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1595,7 +1595,8 @@ static DBusMessage *create_device(DBusConnection *conn,
 
 	device = adapter_create_device(conn, adapter, address, type);
 	if (!device)
-		return NULL;
+		return btd_error_failed(msg,
+				"Unable to create a new device object");
 
 	if (type == DEVICE_TYPE_LE && !event_is_connectable(dev->evt_type)) {
 		/* Device is not connectable */
@@ -1693,7 +1694,8 @@ static DBusMessage *create_paired_device(DBusConnection *conn,
 
 		device = adapter_create_device(conn, adapter, address, type);
 		if (!device)
-			return NULL;
+			return btd_error_failed(msg,
+				"Unable to create a new device object");
 	} else
 		type = device_get_type(device);
 
-- 
1.7.3.3

