Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 1/2] attrib: Use const source data pointer for write
Date: Thu, 27 Mar 2014 15:03:28 +0100
Message-Id: <1395929009-23366-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Source buffer for write operations should be immutable.
---
 attrib/gatt.c | 6 +++---
 attrib/gatt.h | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/attrib/gatt.c b/attrib/gatt.c
index 7363b4b..5ae20f4 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -840,7 +840,7 @@ static guint prepare_write(struct write_long_data *long_write)
 									NULL);
 }
 
-guint gatt_write_char(GAttrib *attrib, uint16_t handle, uint8_t *value,
+guint gatt_write_char(GAttrib *attrib, uint16_t handle, const uint8_t *value,
 			size_t vlen, GAttribResultFunc func, gpointer user_data)
 {
 	uint8_t *buf;
@@ -904,8 +904,8 @@ guint gatt_discover_char_desc(GAttrib *attrib, uint16_t start, uint16_t end,
 	return g_attrib_send(attrib, 0, buf, plen, func, user_data, NULL);
 }
 
-guint gatt_write_cmd(GAttrib *attrib, uint16_t handle, uint8_t *value, int vlen,
-				GDestroyNotify notify, gpointer user_data)
+guint gatt_write_cmd(GAttrib *attrib, uint16_t handle, const uint8_t *value,
+			int vlen, GDestroyNotify notify, gpointer user_data)
 {
 	uint8_t *buf;
 	size_t buflen;
diff --git a/attrib/gatt.h b/attrib/gatt.h
index a11e473..c65bf6c 100644
--- a/attrib/gatt.h
+++ b/attrib/gatt.h
@@ -80,15 +80,15 @@ guint gatt_discover_char(GAttrib *attrib, uint16_t start, uint16_t end,
 guint gatt_read_char(GAttrib *attrib, uint16_t handle, GAttribResultFunc func,
 							gpointer user_data);
 
-guint gatt_write_char(GAttrib *attrib, uint16_t handle, uint8_t *value,
+guint gatt_write_char(GAttrib *attrib, uint16_t handle, const uint8_t *value,
 					size_t vlen, GAttribResultFunc func,
 					gpointer user_data);
 
 guint gatt_discover_char_desc(GAttrib *attrib, uint16_t start, uint16_t end,
 				GAttribResultFunc func, gpointer user_data);
 
-guint gatt_write_cmd(GAttrib *attrib, uint16_t handle, uint8_t *value, int vlen,
-				GDestroyNotify notify, gpointer user_data);
+guint gatt_write_cmd(GAttrib *attrib, uint16_t handle, const uint8_t *value,
+			int vlen, GDestroyNotify notify, gpointer user_data);
 
 guint gatt_read_char_by_uuid(GAttrib *attrib, uint16_t start, uint16_t end,
 				bt_uuid_t *uuid, GAttribResultFunc func,
-- 
1.9.0

