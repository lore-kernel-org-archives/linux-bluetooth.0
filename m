Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 10/11] gatt: Remove gatt_discover_char_desc
Date: Fri,  2 May 2014 12:57:41 +0200
Message-Id: <1399028262-17187-10-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1399028262-17187-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1399028262-17187-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This function is no longer used since all code is changed to use
gatt_discover_desc instead.
---
 attrib/gatt.c | 15 ---------------
 attrib/gatt.h |  3 ---
 2 files changed, 18 deletions(-)

diff --git a/attrib/gatt.c b/attrib/gatt.c
index f766617..73eaf7a 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -1053,21 +1053,6 @@ guint gatt_discover_desc(GAttrib *attrib, uint16_t start, uint16_t end,
 				discover_desc_ref(dd), discover_desc_unref);
 }
 
-guint gatt_discover_char_desc(GAttrib *attrib, uint16_t start, uint16_t end,
-				GAttribResultFunc func, gpointer user_data)
-{
-	uint8_t *buf;
-	size_t buflen;
-	guint16 plen;
-
-	buf = g_attrib_get_buffer(attrib, &buflen);
-	plen = enc_find_info_req(start, end, buf, buflen);
-	if (plen == 0)
-		return 0;
-
-	return g_attrib_send(attrib, 0, buf, plen, func, user_data, NULL);
-}
-
 guint gatt_write_cmd(GAttrib *attrib, uint16_t handle, const uint8_t *value,
 			int vlen, GDestroyNotify notify, gpointer user_data)
 {
diff --git a/attrib/gatt.h b/attrib/gatt.h
index 533bfd7..7d055f0 100644
--- a/attrib/gatt.h
+++ b/attrib/gatt.h
@@ -102,9 +102,6 @@ guint gatt_reliable_write_char(GAttrib *attrib, uint16_t handle,
 guint gatt_execute_write(GAttrib *attrib, uint8_t flags,
 				GAttribResultFunc func, gpointer user_data);
 
-guint gatt_discover_char_desc(GAttrib *attrib, uint16_t start, uint16_t end,
-				GAttribResultFunc func, gpointer user_data);
-
 guint gatt_write_cmd(GAttrib *attrib, uint16_t handle, const uint8_t *value,
 			int vlen, GDestroyNotify notify, gpointer user_data);
 
-- 
1.9.2

