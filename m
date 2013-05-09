Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ 14/26] gatt: Get rid of guint* types
Date: Thu,  9 May 2013 01:16:44 -0300
Message-Id: <1368073016-28434-14-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1368073016-28434-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1368073016-28434-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

guint -> unsigned int
guint8 -> uint8_t
guint16 -> uint16_t
guint32 -> uint32_t
guint64 -> uint64_t

Add "#include <inttypes.h>" where appropriate.
---
 profiles/gatt/gas.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/profiles/gatt/gas.c b/profiles/gatt/gas.c
index 2ed837f..ca261c7 100644
--- a/profiles/gatt/gas.c
+++ b/profiles/gatt/gas.c
@@ -24,6 +24,7 @@
 #include <config.h>
 #endif
 
+#include <inttypes.h>
 #include <stdbool.h>
 #include <stdlib.h>
 #include <sys/types.h>
@@ -53,8 +54,8 @@ struct gas {
 	struct att_range gap;	/* GAP Primary service range */
 	struct att_range gatt;	/* GATT Primary service range */
 	GAttrib *attrib;
-	guint attioid;
-	guint changed_ind;
+	unsigned int attioid;
+	unsigned int changed_ind;
 	uint16_t changed_handle;
 	uint16_t mtu;
 };
@@ -141,7 +142,7 @@ static int read_ctp_handle(struct btd_device *device, uint16_t uuid,
 	return err;
 }
 
-static void gap_appearance_cb(guint8 status, const guint8 *pdu, guint16 plen,
+static void gap_appearance_cb(uint8_t status, const uint8_t *pdu, uint16_t plen,
 							gpointer user_data)
 {
 	struct gas *gas = user_data;
@@ -205,7 +206,7 @@ static void indication_cb(const uint8_t *pdu, uint16_t len, gpointer user_data)
 	btd_device_gatt_set_service_changed(gas->device, start, end);
 }
 
-static void ccc_written_cb(guint8 status, const guint8 *pdu, guint16 plen,
+static void ccc_written_cb(uint8_t status, const uint8_t *pdu, uint16_t plen,
 							gpointer user_data)
 {
 	struct gas *gas = user_data;
@@ -235,8 +236,8 @@ static void write_ccc(GAttrib *attrib, uint16_t handle, gpointer user_data)
 								user_data);
 }
 
-static void gatt_descriptors_cb(guint8 status, const guint8 *pdu, guint16 len,
-							gpointer user_data)
+static void gatt_descriptors_cb(uint8_t status, const uint8_t *pdu,
+					uint16_t len, gpointer user_data)
 {
 	struct gas *gas = user_data;
 	struct att_data_list *list;
@@ -271,7 +272,7 @@ done:
 	att_data_list_free(list);
 }
 
-static void gatt_characteristic_cb(GSList *characteristics, guint8 status,
+static void gatt_characteristic_cb(GSList *characteristics, uint8_t status,
 							gpointer user_data)
 {
 	struct gas *gas = user_data;
@@ -297,7 +298,7 @@ static void gatt_characteristic_cb(GSList *characteristics, guint8 status,
 	gatt_find_info(gas->attrib, start, end, gatt_descriptors_cb, gas);
 }
 
-static void exchange_mtu_cb(guint8 status, const guint8 *pdu, guint16 plen,
+static void exchange_mtu_cb(uint8_t status, const uint8_t *pdu, uint16_t plen,
 							gpointer user_data)
 {
 	struct gas *gas = user_data;
-- 
1.8.2.2

