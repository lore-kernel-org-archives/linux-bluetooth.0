Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 03/15] attrib: Check if attrib is NULL in functions
Date: Mon,  8 Dec 2014 16:40:43 -0800
Message-Id: <1418085655-7304-4-git-send-email-armansito@chromium.org>
In-Reply-To: <1418085655-7304-1-git-send-email-armansito@chromium.org>
References: <1418085655-7304-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds an early return to attrib/gattrib functions if the
attrib argument is NULL.
---
 attrib/gattrib.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index f3b1366..b76d0a4 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -266,6 +266,9 @@ guint g_attrib_send(GAttrib *attrib, guint id, const guint8 *pdu, guint16 len,
 	bt_att_response_func_t response_cb = NULL;
 	bt_att_destroy_func_t destroy_cb = NULL;
 
+	if (!attrib)
+		return 0;
+
 	if (!pdu || !len)
 		return 0;
 
@@ -288,11 +291,17 @@ guint g_attrib_send(GAttrib *attrib, guint id, const guint8 *pdu, guint16 len,
 
 gboolean g_attrib_cancel(GAttrib *attrib, guint id)
 {
+	if (!attrib)
+		return FALSE;
+
 	return bt_att_cancel(attrib->att, id);
 }
 
 gboolean g_attrib_cancel_all(GAttrib *attrib)
 {
+	if (!attrib)
+		return FALSE;
+
 	return bt_att_cancel_all(attrib->att);
 }
 
@@ -302,6 +311,9 @@ guint g_attrib_register(GAttrib *attrib, guint8 opcode, guint16 handle,
 {
 	struct attrib_callbacks *cb = NULL;
 
+	if (!attrib)
+		return 0;
+
 	if (func || notify) {
 		cb = new0(struct attrib_callbacks, 1);
 		if (!cb)
@@ -323,7 +335,7 @@ guint g_attrib_register(GAttrib *attrib, guint8 opcode, guint16 handle,
 
 uint8_t *g_attrib_get_buffer(GAttrib *attrib, size_t *len)
 {
-	if (!len)
+	if (!attrib || !len)
 		return NULL;
 
 	*len = attrib->buflen;
@@ -332,6 +344,9 @@ uint8_t *g_attrib_get_buffer(GAttrib *attrib, size_t *len)
 
 gboolean g_attrib_set_mtu(GAttrib *attrib, int mtu)
 {
+	if (!attrib)
+		return FALSE;
+
 	/*
 	 * Clients of this expect a buffer to use.
 	 *
@@ -349,10 +364,16 @@ gboolean g_attrib_set_mtu(GAttrib *attrib, int mtu)
 
 gboolean g_attrib_unregister(GAttrib *attrib, guint id)
 {
+	if (!attrib)
+		return FALSE;
+
 	return bt_att_unregister(attrib->att, id);
 }
 
 gboolean g_attrib_unregister_all(GAttrib *attrib)
 {
+	if (!attrib)
+		return false;
+
 	return bt_att_unregister_all(attrib->att);
 }
-- 
2.2.0.rc0.207.ga3a616c

