Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC BlueZ 1/3] device: Add btd_ prefix to device_set_pnpid()
Date: Fri, 23 Nov 2012 17:30:30 -0300
Message-Id: <1353702632-7960-2-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1353702632-7960-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1353702632-7960-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

As device_set_pnpid() is used inside a plugin it should have the btd_
prefix.
---
 profiles/deviceinfo/deviceinfo.c | 2 +-
 src/device.c                     | 4 ++--
 src/device.h                     | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/profiles/deviceinfo/deviceinfo.c b/profiles/deviceinfo/deviceinfo.c
index 9910533..da27df8 100644
--- a/profiles/deviceinfo/deviceinfo.c
+++ b/profiles/deviceinfo/deviceinfo.c
@@ -106,7 +106,7 @@ static void read_pnpid_cb(guint8 status, const guint8 *pdu, guint16 len,
 		return;
 	}
 
-	device_set_pnpid(ch->d->dev, value[0], att_get_u16(&value[1]),
+	btd_device_set_pnpid(ch->d->dev, value[0], att_get_u16(&value[1]),
 				att_get_u16(&value[3]), att_get_u16(&value[5]));
 }
 
diff --git a/src/device.c b/src/device.c
index f0223c8..a196af4 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2349,7 +2349,7 @@ static void update_bredr_services(struct browse_req *req, sdp_list_t *recs)
 			version = pdlist ? pdlist->val.uint16 : 0x0000;
 
 			if (source || vendor || product || version)
-				device_set_pnpid(device, source, vendor,
+				btd_device_set_pnpid(device, source, vendor,
 							product, version);
 		}
 
@@ -4101,7 +4101,7 @@ gboolean btd_device_remove_attio_callback(struct btd_device *device, guint id)
 	return TRUE;
 }
 
-void device_set_pnpid(struct btd_device *device, uint8_t vendor_id_src,
+void btd_device_set_pnpid(struct btd_device *device, uint8_t vendor_id_src,
 			uint16_t vendor_id, uint16_t product_id,
 			uint16_t product_ver)
 {
diff --git a/src/device.h b/src/device.h
index 3715698..703dfcf 100644
--- a/src/device.h
+++ b/src/device.h
@@ -116,7 +116,7 @@ void btd_device_unref(struct btd_device *device);
 int device_block(struct btd_device *device, gboolean update_only);
 int device_unblock(struct btd_device *device, gboolean silent,
 							gboolean update_only);
-void device_set_pnpid(struct btd_device *device, uint8_t vendor_id_src,
+void btd_device_set_pnpid(struct btd_device *device, uint8_t vendor_id_src,
 			uint16_t vendor_id, uint16_t product_id,
 			uint16_t product_ver);
 GIOChannel *device_att_connect(gpointer user_data);
-- 
1.8.0

