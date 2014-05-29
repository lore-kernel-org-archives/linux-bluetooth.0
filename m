Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: johan.hedberg@gmail.com, szymon.janc@tieto.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 03/10] android/gatt: Fix signed write command encoding
Date: Thu, 29 May 2014 15:49:37 +0200
Message-Id: <1401371384-10427-4-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1401371384-10427-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1401371384-10427-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

As per spec (BT spec 4.1 Vol[3], Part F, chapter 3.4.5.4) we need to
take opcode, handle and parameters to generate signature.
In order to support it signing is moved to att.c, place where pdu is
encoded
---
 Makefile.am    |  3 ++-
 Makefile.tools |  4 +++-
 android/gatt.c | 13 ++-----------
 attrib/att.c   | 11 +++++++----
 attrib/att.h   |  6 +++++-
 attrib/gatt.c  | 11 ++++++++---
 attrib/gatt.h  |  4 +++-
 7 files changed, 30 insertions(+), 22 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 4e77019..dc88816 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -98,7 +98,8 @@ gdbus_libgdbus_internal_la_SOURCES = gdbus/gdbus.h \
 attrib_sources = attrib/att.h attrib/att-database.h attrib/att.c \
 		attrib/gatt.h attrib/gatt.c \
 		attrib/gattrib.h attrib/gattrib.c \
-		attrib/gatt-service.h attrib/gatt-service.c
+		attrib/gatt-service.h attrib/gatt-service.c \
+		src/shared/crypto.h src/shared/crypto.c
 
 btio_sources = btio/btio.h btio/btio.c
 
diff --git a/Makefile.tools b/Makefile.tools
index 412a998..c24bdf7 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -356,7 +356,9 @@ attrib_gatttool_SOURCES = attrib/gatttool.c attrib/att.c attrib/gatt.c \
 				attrib/gattrib.c btio/btio.c \
 				attrib/gatttool.h attrib/interactive.c \
 				attrib/utils.c src/log.c client/display.c \
-				client/display.h
+				client/display.h \
+				src/shared/crypto.h src/shared/crypto.c
+
 attrib_gatttool_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@ -lreadline
 
 tools_obex_client_tool_SOURCES = $(gobex_sources) $(btio_sources) \
diff --git a/android/gatt.c b/android/gatt.c
index b18ca4a..4de4357 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -44,7 +44,6 @@
 #include "src/shared/util.h"
 #include "src/shared/queue.h"
 #include "src/shared/gatt-db.h"
-#include "src/shared/crypto.h"
 #include "attrib/gattrib.h"
 #include "attrib/att.h"
 #include "attrib/gatt.h"
@@ -2642,7 +2641,6 @@ static void write_char_cb(guint8 status, const guint8 *pdu, guint16 len,
 static bool signed_write_cmd(struct gatt_device *dev, uint16_t handle,
 					const uint8_t *value, uint16_t vlen)
 {
-	uint8_t s[ATT_SIGNATURE_LEN];
 	uint8_t csrk[16];
 	uint32_t sign_cnt;
 
@@ -2653,15 +2651,8 @@ static bool signed_write_cmd(struct gatt_device *dev, uint16_t handle,
 		return false;
 	}
 
-	memset(s, 0, ATT_SIGNATURE_LEN);
-
-	if (!bt_crypto_sign_att(crypto, csrk, value, vlen, sign_cnt, s)) {
-		error("gatt: Could not sign att data");
-		return false;
-	}
-
-	if (!gatt_signed_write_cmd(dev->attrib, handle, value, vlen, s, NULL,
-									NULL)) {
+	if (!gatt_signed_write_cmd(dev->attrib, handle, value, vlen, crypto,
+					csrk, sign_cnt, NULL, NULL)) {
 		error("gatt: Could write signed cmd");
 		return false;
 	}
diff --git a/attrib/att.c b/attrib/att.c
index e7d5682..2680458 100644
--- a/attrib/att.c
+++ b/attrib/att.c
@@ -561,9 +561,10 @@ uint16_t dec_write_cmd(const uint8_t *pdu, size_t len, uint16_t *handle,
 	return len;
 }
 
-uint16_t enc_signed_write_cmd(uint16_t handle,
-					const uint8_t *value, size_t vlen,
-					const uint8_t signature[12],
+uint16_t enc_signed_write_cmd(uint16_t handle, const uint8_t *value,
+					size_t vlen, struct bt_crypto *crypto,
+					const uint8_t csrk[16],
+					uint32_t sign_cnt,
 					uint8_t *pdu, size_t len)
 {
 	const uint16_t hdr_len = sizeof(pdu[0]) + sizeof(handle);
@@ -581,7 +582,9 @@ uint16_t enc_signed_write_cmd(uint16_t handle,
 	if (vlen > 0)
 		memcpy(&pdu[hdr_len], value, vlen);
 
-	memcpy(&pdu[hdr_len + vlen], signature, ATT_SIGNATURE_LEN);
+	if (!bt_crypto_sign_att(crypto, csrk, pdu, hdr_len + vlen, sign_cnt,
+							&pdu[hdr_len + vlen]))
+		return 0;
 
 	return min_len + vlen;
 }
diff --git a/attrib/att.h b/attrib/att.h
index c92cd5d..2311aaf 100644
--- a/attrib/att.h
+++ b/attrib/att.h
@@ -22,6 +22,8 @@
  *
  */
 
+#include "src/shared/crypto.h"
+
 /* Len of signature in write signed packet */
 #define ATT_SIGNATURE_LEN		12
 
@@ -134,7 +136,9 @@ uint16_t dec_write_cmd(const uint8_t *pdu, size_t len, uint16_t *handle,
 						uint8_t *value, size_t *vlen);
 uint16_t enc_signed_write_cmd(uint16_t handle,
 					const uint8_t *value, size_t vlen,
-					const uint8_t signature[12],
+					struct bt_crypto *crypto,
+					const uint8_t csrk[16],
+					uint32_t sign_cnt,
 					uint8_t *pdu, size_t len);
 uint16_t dec_signed_write_cmd(const uint8_t *pdu, size_t len,
 						uint16_t *handle,
diff --git a/attrib/gatt.c b/attrib/gatt.c
index ce08003..27fb0b3 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -1067,7 +1067,9 @@ guint gatt_write_cmd(GAttrib *attrib, uint16_t handle, const uint8_t *value,
 
 guint gatt_signed_write_cmd(GAttrib *attrib, uint16_t handle,
 						const uint8_t *value, int vlen,
-						const uint8_t signature[12],
+						struct bt_crypto *crypto,
+						const uint8_t csrk[16],
+						uint32_t sign_cnt,
 						GDestroyNotify notify,
 						gpointer user_data)
 {
@@ -1076,8 +1078,11 @@ guint gatt_signed_write_cmd(GAttrib *attrib, uint16_t handle,
 	guint16 plen;
 
 	buf = g_attrib_get_buffer(attrib, &buflen);
-	plen = enc_signed_write_cmd(handle, value, vlen, signature, buf,
-									buflen);
+	plen = enc_signed_write_cmd(handle, value, vlen, crypto, csrk, sign_cnt,
+								buf, buflen);
+	if (plen == 0)
+		return 0;
+
 	return g_attrib_send(attrib, 0, buf, plen, NULL, user_data, notify);
 }
 
diff --git a/attrib/gatt.h b/attrib/gatt.h
index 2d869e3..f6db10f 100644
--- a/attrib/gatt.h
+++ b/attrib/gatt.h
@@ -107,7 +107,9 @@ guint gatt_write_cmd(GAttrib *attrib, uint16_t handle, const uint8_t *value,
 
 guint gatt_signed_write_cmd(GAttrib *attrib, uint16_t handle,
 						const uint8_t *value, int vlen,
-						const uint8_t signature[12],
+						struct bt_crypto *crypto,
+						const uint8_t csrk[16],
+						uint32_t sign_cnt,
 						GDestroyNotify notify,
 						gpointer user_data);
 guint gatt_read_char_by_uuid(GAttrib *attrib, uint16_t start, uint16_t end,
-- 
1.8.4

