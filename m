Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH 1/2] Rename gatt_primary_t to more generic name
Date: Mon, 17 Jan 2011 15:37:48 -0400
Message-Id: <1295293069-29637-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The gatt_primary_t typedef was renamed to gatt_cb_t because it will be
used for primary and characteristic callbacks.
---
 attrib/gatt.c |    4 ++--
 attrib/gatt.h |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/attrib/gatt.c b/attrib/gatt.c
index 7d09689..79d8b9d 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -35,7 +35,7 @@ struct discover_primary {
 	GAttrib *attrib;
 	uuid_t uuid;
 	GSList *primaries;
-	gatt_primary_t cb;
+	gatt_cb_t cb;
 	void *user_data;
 };
 
@@ -193,7 +193,7 @@ done:
 	discover_primary_free(dp);
 }
 
-guint gatt_discover_primary(GAttrib *attrib, uuid_t *uuid, gatt_primary_t func,
+guint gatt_discover_primary(GAttrib *attrib, uuid_t *uuid, gatt_cb_t func,
 							gpointer user_data)
 {
 	struct discover_primary *dp;
diff --git a/attrib/gatt.h b/attrib/gatt.h
index 936c592..0bdac77 100644
--- a/attrib/gatt.h
+++ b/attrib/gatt.h
@@ -24,9 +24,9 @@
 
 #define GATT_CID 4
 
-typedef void (*gatt_primary_t) (GSList *l, guint8 status, gpointer user_data);
+typedef void (*gatt_cb_t) (GSList *l, guint8 status, gpointer user_data);
 
-guint gatt_discover_primary(GAttrib *attrib, uuid_t *uuid, gatt_primary_t func,
+guint gatt_discover_primary(GAttrib *attrib, uuid_t *uuid, gatt_cb_t func,
 							gpointer user_data);
 
 guint gatt_discover_char(GAttrib *attrib, uint16_t start, uint16_t end,
-- 
1.7.0.4

