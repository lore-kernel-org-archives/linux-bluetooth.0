Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v1 06/12] core: Rename device_attach_attrib
Date: Tue,  9 Dec 2014 15:00:59 -0800
Message-Id: <1418166065-21055-7-git-send-email-armansito@chromium.org>
In-Reply-To: <1418166065-21055-1-git-send-email-armansito@chromium.org>
References: <1418166065-21055-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch renames the device_attach_attrib function to
device_attach_att_transport to remove ambiguities arise from the word
"attrib".
---
 src/attrib-server.c | 2 +-
 src/device.c        | 4 ++--
 src/device.h        | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index 6571577..e73850d 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -1300,7 +1300,7 @@ static void connect_event(GIOChannel *io, GError *gerr, void *user_data)
 	if (!device)
 		return;
 
-	device_attach_attrib(device, io);
+	device_attach_att_transport(device, io);
 }
 
 static gboolean register_core_services(struct gatt_server *server)
diff --git a/src/device.c b/src/device.c
index bb80409..3bd3939 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3637,7 +3637,7 @@ static void gatt_client_init(struct btd_device *device)
 	DBG("gatt-client created");
 }
 
-bool device_attach_attrib(struct btd_device *dev, GIOChannel *io)
+bool device_attach_att_transport(struct btd_device *dev, GIOChannel *io)
 {
 	GError *gerr = NULL;
 	GAttrib *attrib;
@@ -3725,7 +3725,7 @@ static void att_connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 		goto done;
 	}
 
-	if (!device_attach_attrib(device, io))
+	if (!device_attach_att_transport(device, io))
 		goto done;
 
 	if (attcb->success)
diff --git a/src/device.h b/src/device.h
index 2e0473e..10c4951 100644
--- a/src/device.h
+++ b/src/device.h
@@ -69,7 +69,7 @@ struct gatt_primary *btd_device_get_primary(struct btd_device *device,
 GSList *btd_device_get_primaries(struct btd_device *device);
 void btd_device_gatt_set_service_changed(struct btd_device *device,
 						uint16_t start, uint16_t end);
-bool device_attach_attrib(struct btd_device *dev, GIOChannel *io);
+bool device_attach_att_transport(struct btd_device *dev, GIOChannel *io);
 void btd_device_add_uuid(struct btd_device *device, const char *uuid);
 void device_add_eir_uuids(struct btd_device *dev, GSList *uuids);
 void device_probe_profile(gpointer a, gpointer b);
-- 
2.2.0.rc0.207.ga3a616c

