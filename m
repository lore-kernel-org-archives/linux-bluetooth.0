Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 5/5] Don't trigger the discovering when registering the client
Date: Wed, 24 Nov 2010 00:30:47 -0200
Message-Id: <1290565847-17382-5-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1290565847-17382-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1290565847-17382-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Discover All Primary Services should not be trigged by the attribute
client when a given device is registered. Discover services is now done
by the device entity.
---
 attrib/client.c |   47 +----------------------------------------------
 1 files changed, 1 insertions(+), 46 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index a851a74..a8a4051 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -1322,16 +1322,8 @@ int attrib_client_register(struct btd_device *device, int psm)
 	struct btd_adapter *adapter = device_get_adapter(device);
 	const char *path = device_get_path(device);
 	struct gatt_service *gatt;
-	GError *gerr = NULL;
-	GIOChannel *io;
 	bdaddr_t sba, dba;
 
-	/*
-	 * Registering fake services/characteristics. The following
-	 * paths/interfaces shall be registered after discover primary
-	 * services only.
-	 */
-
 	adapter_get_address(adapter, &sba);
 	device_get_address(device, &dba);
 
@@ -1343,46 +1335,9 @@ int attrib_client_register(struct btd_device *device, int psm)
 	bacpy(&gatt->dba, &dba);
 	gatt->psm = psm;
 
-	if (load_primary_services(gatt)) {
+	if (load_primary_services(gatt))
 		DBG("Primary services loaded");
-		goto done;
-	}
-
-	if (psm < 0) {
-		io = bt_io_connect(BT_IO_L2CAP, connect_cb, gatt, NULL, &gerr,
-					BT_IO_OPT_SOURCE_BDADDR, &sba,
-					BT_IO_OPT_DEST_BDADDR, &dba,
-					BT_IO_OPT_CID, GATT_CID,
-					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
-					BT_IO_OPT_INVALID);
-
-			DBG("GATT over Low Energy");
-	} else {
-		io = bt_io_connect(BT_IO_L2CAP, connect_cb, gatt, NULL, &gerr,
-					BT_IO_OPT_SOURCE_BDADDR, &sba,
-					BT_IO_OPT_DEST_BDADDR, &dba,
-					BT_IO_OPT_PSM, psm,
-					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
-					BT_IO_OPT_INVALID);
-
-		DBG("GATT over Basic Rate");
-	}
-
-	if (!io) {
-		error("%s", gerr->message);
-		g_error_free(gerr);
-		gatt_service_free(gatt);
-		return -1;
-	}
-
-	gatt->attrib = g_attrib_new(io);
-	g_io_channel_unref(io);
 
-	g_attrib_set_destroy_function(gatt->attrib, attrib_destroy, gatt);
-	g_attrib_set_disconnect_function(gatt->attrib, attrib_disconnect,
-									gatt);
-
-done:
 	gatt_services = g_slist_append(gatt_services, gatt);
 
 	return 0;
-- 
1.7.3.2

