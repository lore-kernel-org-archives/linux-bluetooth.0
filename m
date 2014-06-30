Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 11/12] android/bas: Read CCC initial value for Battery Level
Date: Mon, 30 Jun 2014 16:47:58 +0300
Message-Id: <1404136079-24846-11-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1404136079-24846-1-git-send-email-luiz.dentz@gmail.com>
References: <1404136079-24846-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This is required by the following test:

- TP/HGRF/HH/BV-11-I [Read Client Characteristic Configuration Descriptor
for Battery Level Characteristic]
---
 android/bas.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/android/bas.c b/android/bas.c
index 996f3c0..7342895 100644
--- a/android/bas.c
+++ b/android/bas.c
@@ -48,6 +48,7 @@ struct bt_bas {
 	GAttrib *attrib;
 	struct gatt_primary *primary;
 	uint16_t handle;
+	uint16_t ccc_handle;
 	guint id;
 };
 
@@ -126,6 +127,20 @@ static void write_ccc(GAttrib *attrib, uint16_t handle, void *user_data)
 								user_data);
 }
 
+
+static void ccc_read_cb(guint8 status, const guint8 *pdu, guint16 len,
+							gpointer user_data)
+{
+	struct bt_bas *bas = user_data;
+
+	if (status != 0) {
+		error("Error reading CCC value: %s", att_ecode2str(status));
+		return;
+	}
+
+	write_ccc(bas->attrib, bas->ccc_handle, bas);
+}
+
 static void discover_descriptor_cb(uint8_t status, GSList *descs,
 								void *user_data)
 {
@@ -139,8 +154,9 @@ static void discover_descriptor_cb(uint8_t status, GSList *descs,
 
 	/* There will be only one descriptor on list and it will be CCC */
 	desc = descs->data;
+	bas->ccc_handle = desc->handle;
 
-	write_ccc(bas->attrib, desc->handle, bas);
+	gatt_read_char(bas->attrib, desc->handle, ccc_read_cb, bas);
 }
 
 static void bas_discovered_cb(uint8_t status, GSList *chars, void *user_data)
-- 
1.9.3

