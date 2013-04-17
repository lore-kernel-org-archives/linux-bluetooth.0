Return-Path: <cyrus@holtmann.org>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [PATCH BlueZ v3 10/16] attrib: Change g_attrib_set_mtu return type from gboolean
Date: Wed, 17 Apr 2013 10:03:13 -0400
Message-Id: <1366207399-29536-11-git-send-email-jefferson.delfes@openbossa.org>
In-Reply-To: <1366207399-29536-1-git-send-email-jefferson.delfes@openbossa.org>
References: <1365621421-1422-1-git-send-email-jefferson.delfes@openbossa.org>
 <1366207399-29536-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is no reason to use gboolean in return type of g_attrib_set_mtu.
---
 attrib/gattrib.c | 6 +++---
 attrib/gattrib.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index 51d6bca..1689c72 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -657,16 +657,16 @@ uint8_t *g_attrib_get_buffer(GAttrib *attrib, size_t *len)
 	return attrib->buf;
 }
 
-gboolean g_attrib_set_mtu(GAttrib *attrib, int mtu)
+bool g_attrib_set_mtu(GAttrib *attrib, int mtu)
 {
 	if (mtu < ATT_DEFAULT_LE_MTU)
-		return FALSE;
+		return false;
 
 	attrib->buf = g_realloc(attrib->buf, mtu);
 
 	attrib->buflen = mtu;
 
-	return TRUE;
+	return true;
 }
 
 guint g_attrib_register(GAttrib *attrib, guint8 opcode, guint16 handle,
diff --git a/attrib/gattrib.h b/attrib/gattrib.h
index d3d6d0d..70c730f 100644
--- a/attrib/gattrib.h
+++ b/attrib/gattrib.h
@@ -68,7 +68,7 @@ guint g_attrib_register(GAttrib *attrib, guint8 opcode, guint16 handle,
 gboolean g_attrib_is_encrypted(GAttrib *attrib);
 
 uint8_t *g_attrib_get_buffer(GAttrib *attrib, size_t *len);
-gboolean g_attrib_set_mtu(GAttrib *attrib, int mtu);
+bool g_attrib_set_mtu(GAttrib *attrib, int mtu);
 
 bool g_attrib_unregister(GAttrib *attrib, guint id);
 bool g_attrib_unregister_all(GAttrib *attrib);
-- 
1.8.2

