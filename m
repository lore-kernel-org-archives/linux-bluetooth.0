Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com, johan.hedberg@gmail.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v3 03/12] attrib/gatt: Add wrapper to send signed write command
Date: Thu, 22 May 2014 21:06:17 +0200
Message-Id: <1400785586-22710-4-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1400785586-22710-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1400785586-22710-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/gatt.c | 16 ++++++++++++++++
 attrib/gatt.h |  5 +++++
 2 files changed, 21 insertions(+)

diff --git a/attrib/gatt.c b/attrib/gatt.c
index 73eaf7a..ce08003 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -1065,6 +1065,22 @@ guint gatt_write_cmd(GAttrib *attrib, uint16_t handle, const uint8_t *value,
 	return g_attrib_send(attrib, 0, buf, plen, NULL, user_data, notify);
 }
 
+guint gatt_signed_write_cmd(GAttrib *attrib, uint16_t handle,
+						const uint8_t *value, int vlen,
+						const uint8_t signature[12],
+						GDestroyNotify notify,
+						gpointer user_data)
+{
+	uint8_t *buf;
+	size_t buflen;
+	guint16 plen;
+
+	buf = g_attrib_get_buffer(attrib, &buflen);
+	plen = enc_signed_write_cmd(handle, value, vlen, signature, buf,
+									buflen);
+	return g_attrib_send(attrib, 0, buf, plen, NULL, user_data, notify);
+}
+
 static sdp_data_t *proto_seq_find(sdp_list_t *proto_list)
 {
 	sdp_list_t *list;
diff --git a/attrib/gatt.h b/attrib/gatt.h
index 7d055f0..2d869e3 100644
--- a/attrib/gatt.h
+++ b/attrib/gatt.h
@@ -105,6 +105,11 @@ guint gatt_execute_write(GAttrib *attrib, uint8_t flags,
 guint gatt_write_cmd(GAttrib *attrib, uint16_t handle, const uint8_t *value,
 			int vlen, GDestroyNotify notify, gpointer user_data);
 
+guint gatt_signed_write_cmd(GAttrib *attrib, uint16_t handle,
+						const uint8_t *value, int vlen,
+						const uint8_t signature[12],
+						GDestroyNotify notify,
+						gpointer user_data);
 guint gatt_read_char_by_uuid(GAttrib *attrib, uint16_t start, uint16_t end,
 				bt_uuid_t *uuid, GAttribResultFunc func,
 				gpointer user_data);
-- 
1.8.4

