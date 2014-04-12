Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com, johan.hedberg@gmail.com,
	claudio.takahasi@openbossa.org, anderson.lizardo@openbossa.org,
	armansito@chromium.org,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 01/10] attrib: Add API for reliable write
Date: Sun, 13 Apr 2014 00:00:22 +0200
Message-Id: <1397340031-29711-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1397340031-29711-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1397340031-29711-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Android expose to application api for reliable write. Therefore we need
to add this support to gattrib
---
 attrib/gatt.c | 18 ++++++++++++++++++
 attrib/gatt.h |  6 ++++++
 2 files changed, 24 insertions(+)

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
index c65bf6c..76820e0 100644
--- a/attrib/gatt.h
+++ b/attrib/gatt.h
@@ -84,6 +84,12 @@ guint gatt_write_char(GAttrib *attrib, uint16_t handle, const uint8_t *value,
 					size_t vlen, GAttribResultFunc func,
 					gpointer user_data);
 
+guint gatt_reliable_write_char(GAttrib *attrib, uint16_t handle,
+					const uint8_t *value, size_t vlen,
+					GAttribResultFunc func,
+					gpointer user_data);
+
+
 guint gatt_discover_char_desc(GAttrib *attrib, uint16_t start, uint16_t end,
 				GAttribResultFunc func, gpointer user_data);
 
-- 
1.8.4

