Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH 3/3] Remove flags2type() function
Date: Wed,  4 May 2011 10:13:49 -0400
Message-Id: <1304518429-8527-3-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1304518429-8527-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1304518429-8527-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This function was only being used by create_device_internal(). It is
generating incorrect information when a single mode LE device has flags
0x02 (General Discoverable Mode), it was being "detected" as Dual Mode,
and thus the adapter was attempting to connect through BR/EDR.

This commit fixes CreateDevice() for these devices, but it is a partial
solution. In future, we should drop the "device type" enumeration, as
this information will come from kernel "device found" events.

Also note that the "DEVICE_TYPE_DUALMODE" enumeration is not really
being used, so it will probably disappear too.
---
 src/adapter.c |   22 ++--------------------
 1 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index aa8f5d4..609e3d5 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1631,24 +1631,6 @@ static DBusMessage *cancel_device_creation(DBusConnection *conn,
 	return dbus_message_new_method_return(msg);
 }
 
-static device_type_t flags2type(uint8_t flags)
-{
-	/* Inferring the remote type based on the EIR Flags field */
-
-	/* For LE only and dual mode the following flags must be zero */
-	if (flags & (EIR_SIM_CONTROLLER | EIR_SIM_HOST))
-		return DEVICE_TYPE_UNKNOWN;
-
-	/* Limited or General discoverable mode bit must be enabled */
-	if (!(flags & (EIR_LIM_DISC | EIR_GEN_DISC)))
-		return DEVICE_TYPE_UNKNOWN;
-
-	if (flags & EIR_BREDR_UNSUP)
-		return DEVICE_TYPE_LE;
-	else
-		return DEVICE_TYPE_DUALMODE;
-}
-
 static struct btd_device *create_device_internal(DBusConnection *conn,
 						struct btd_adapter *adapter,
 						const gchar *address, int *err)
@@ -1662,8 +1644,8 @@ static struct btd_device *create_device_internal(DBusConnection *conn,
 	match.name_status = NAME_ANY;
 
 	dev = adapter_search_found_devices(adapter, &match);
-	if (dev && dev->flags)
-		type = flags2type(dev->flags);
+	if (dev && dev->le)
+		type = DEVICE_TYPE_LE;
 	else
 		type = DEVICE_TYPE_BREDR;
 
-- 
1.7.0.4

