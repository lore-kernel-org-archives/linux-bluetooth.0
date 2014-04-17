Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 1/5] attrib: Add API for reliable write
Date: Thu, 17 Apr 2014 13:57:44 +0200
Message-Id: <1397735868-19092-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1397735868-19092-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1397735868-19092-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Android expose to application api for reliable write. Therefore we need
to add this support to gattrib
---
 attrib/gatt.c | 18 ++++++++++++++++++
 attrib/gatt.h |  5 +++++
 2 files changed, 23 insertions(+)

diff --git a/attrib/gatt.c b/attrib/gatt.c
index 49cd1a3..e461ab7 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -871,6 +871,24 @@ guint gatt_write_char(GAttrib *attrib, uint16_t handle, const uint8_t *value,
 	return prepare_write(long_write);
 }
 
+guint gatt_reliable_write_char(GAttrib *attrib, uint16_t handle,
+					const uint8_t *value, size_t vlen,
+					GAttribResultFunc func,
+					gpointer user_data)
+{
+	uint8_t *buf;
+	guint16 plen;
+	size_t buflen;
+
+	buf = g_attrib_get_buffer(attrib, &buflen);
+
+	plen = enc_prep_write_req(handle, 0, value, vlen, buf, buflen);
+	if (!plen)
+		return 0;
+
+	return g_attrib_send(attrib, 0, buf, plen, func, user_data, NULL);
+}
+
 guint gatt_exchange_mtu(GAttrib *attrib, uint16_t mtu, GAttribResultFunc func,
 							gpointer user_data)
 {
diff --git a/attrib/gatt.h b/attrib/gatt.h
index c65bf6c..585a876 100644
--- a/attrib/gatt.h
+++ b/attrib/gatt.h
@@ -84,6 +84,11 @@ guint gatt_write_char(GAttrib *attrib, uint16_t handle, const uint8_t *value,
 					size_t vlen, GAttribResultFunc func,
 					gpointer user_data);
 
+guint gatt_reliable_write_char(GAttrib *attrib, uint16_t handle,
+					const uint8_t *value, size_t vlen,
+					GAttribResultFunc func,
+					gpointer user_data);
+
 guint gatt_discover_char_desc(GAttrib *attrib, uint16_t start, uint16_t end,
 				GAttribResultFunc func, gpointer user_data);
 
-- 
1.8.4

