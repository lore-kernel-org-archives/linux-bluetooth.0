Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 1/2] attrib/gatt.c: Fix for attrib ref
Date: Tue,  9 Dec 2014 09:40:24 +0100
Message-Id: <1418114425-22455-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch makes sure that attrib instance will not disappear while
reading characteristic
---
 attrib/gatt.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/attrib/gatt.c b/attrib/gatt.c
index f8ff2a5..0e633f7 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -673,6 +673,8 @@ static void read_long_destroy(gpointer user_data)
 	if (__sync_sub_and_fetch(&long_read->ref, 1) > 0)
 		return;
 
+	g_attrib_unref(long_read->attrib);
+
 	if (long_read->buffer != NULL)
 		g_free(long_read->buffer);
 
@@ -776,7 +778,7 @@ guint gatt_read_char(GAttrib *attrib, uint16_t handle, GAttribResultFunc func,
 	if (long_read == NULL)
 		return 0;
 
-	long_read->attrib = attrib;
+	long_read->attrib = g_attrib_ref(attrib);
 	long_read->func = func;
 	long_read->user_data = user_data;
 	long_read->handle = handle;
@@ -785,9 +787,10 @@ guint gatt_read_char(GAttrib *attrib, uint16_t handle, GAttribResultFunc func,
 	plen = enc_read_req(handle, buf, buflen);
 	id = g_attrib_send(attrib, 0, buf, plen, read_char_helper,
 						long_read, read_long_destroy);
-	if (id == 0)
+	if (id == 0) {
+		g_attrib_unref(long_read->attrib);
 		g_free(long_read);
-	else {
+	} else {
 		__sync_fetch_and_add(&long_read->ref, 1);
 		long_read->id = id;
 	}
-- 
1.8.4

