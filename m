Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] core/device: Don't set MTU when acting as a peripheral
Date: Fri,  4 Mar 2016 14:24:27 +0200
Message-Id: <1457094267-5925-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1457094267-5925-1-git-send-email-luiz.dentz@gmail.com>
References: <1457094267-5925-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Some Android versions don't seem to cope well with the fact that the
peripheral can actually set a MTU thus leave the MTU as the default.
---
 src/attrib-server.c | 2 +-
 src/device.c        | 8 +++++---
 src/device.h        | 2 +-
 src/gatt-database.c | 2 +-
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index 4439c27..e92ca5c 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -1281,7 +1281,7 @@ static void connect_event(GIOChannel *io, GError *gerr, void *user_data)
 	if (!device)
 		return;
 
-	device_attach_att(device, io);
+	device_attach_att(device, io, false);
 }
 
 static gboolean register_core_services(struct gatt_server *server)
diff --git a/src/device.c b/src/device.c
index 14e850e..b4bc593 100644
--- a/src/device.c
+++ b/src/device.c
@@ -4664,7 +4664,7 @@ static bool remote_counter(uint32_t *sign_cnt, void *user_data)
 	return true;
 }
 
-bool device_attach_att(struct btd_device *dev, GIOChannel *io)
+bool device_attach_att(struct btd_device *dev, GIOChannel *io, bool initiator)
 {
 	GError *gerr = NULL;
 	GAttrib *attrib;
@@ -4699,7 +4699,9 @@ bool device_attach_att(struct btd_device *dev, GIOChannel *io)
 		}
 	}
 
-	dev->att_mtu = MIN(mtu, BT_ATT_MAX_LE_MTU);
+	/* Only attempt to set MTU if initiator/central */
+	dev->att_mtu = initiator ? MIN(mtu, BT_ATT_MAX_LE_MTU) :
+							BT_ATT_DEFAULT_LE_MTU;
 	attrib = g_attrib_new(io, dev->att_mtu, false);
 	if (!attrib) {
 		error("Unable to create new GAttrib instance");
@@ -4768,7 +4770,7 @@ static void att_connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 		goto done;
 	}
 
-	if (!device_attach_att(device, io))
+	if (!device_attach_att(device, io, true))
 		goto done;
 
 	if (attcb->success)
diff --git a/src/device.h b/src/device.h
index db10827..5c01ed0 100644
--- a/src/device.h
+++ b/src/device.h
@@ -72,7 +72,7 @@ struct bt_gatt_client *btd_device_get_gatt_client(struct btd_device *device);
 struct bt_gatt_server *btd_device_get_gatt_server(struct btd_device *device);
 void btd_device_gatt_set_service_changed(struct btd_device *device,
 						uint16_t start, uint16_t end);
-bool device_attach_att(struct btd_device *dev, GIOChannel *io);
+bool device_attach_att(struct btd_device *dev, GIOChannel *io, bool initiator);
 void btd_device_add_uuid(struct btd_device *device, const char *uuid);
 void device_add_eir_uuids(struct btd_device *dev, GSList *uuids);
 void device_set_manufacturer_data(struct btd_device *dev, GSList *list);
diff --git a/src/gatt-database.c b/src/gatt-database.c
index d906e2b..4df4a16 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -499,7 +499,7 @@ static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 	if (!device)
 		return;
 
-	device_attach_att(device, io);
+	device_attach_att(device, io, false);
 }
 
 static void gap_device_name_read_cb(struct gatt_db_attribute *attrib,
-- 
2.5.0

