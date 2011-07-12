Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 08/11] Change GAttrib ref counting in Generic Attribute
Date: Tue, 12 Jul 2011 17:28:38 -0300
Message-Id: <1310502521-462-9-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1310502521-462-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1310502521-462-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/client.c |   12 ------------
 1 files changed, 0 insertions(+), 12 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index 7f0dac4..5177524 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -130,7 +130,6 @@ static void gatt_service_free(struct gatt_service *gatt)
 	g_slist_free_full(gatt->watchers, watcher_free);
 	g_slist_free_full(gatt->chars, characteristic_free);
 	g_free(gatt->path);
-	g_attrib_unref(gatt->attrib);
 	btd_device_unref(gatt->dev);
 	dbus_connection_unref(gatt->conn);
 	g_free(gatt);
@@ -207,8 +206,6 @@ static void watcher_exit(DBusConnection *conn, void *user_data)
 	DBG("%s watcher %s exited", gatt->path, watcher->name);
 
 	gatt->watchers = g_slist_remove(gatt->watchers, watcher);
-
-	g_attrib_unref(gatt->attrib);
 }
 
 static int characteristic_set_value(struct characteristic *chr,
@@ -579,7 +576,6 @@ static void update_char_desc(guint8 status, const guint8 *pdu, guint16 len,
 		}
 	}
 
-	g_attrib_unref(gatt->attrib);
 	g_free(current);
 }
 
@@ -605,7 +601,6 @@ static void update_char_format(guint8 status, const guint8 *pdu, guint16 len,
 				(void *) chr->format, sizeof(*chr->format));
 
 done:
-	g_attrib_unref(gatt->attrib);
 	g_free(current);
 }
 
@@ -630,7 +625,6 @@ static void update_char_value(guint8 status, const guint8 *pdu,
 		}
 	}
 
-	g_attrib_unref(gatt->attrib);
 	g_free(current);
 }
 
@@ -684,11 +678,9 @@ static void descriptor_cb(guint8 status, const guint8 *pdu, guint16 plen,
 		qfmt->handle = handle;
 
 		if (uuid_desc16_cmp(&uuid, GATT_CHARAC_USER_DESC_UUID) == 0) {
-			gatt->attrib = g_attrib_ref(gatt->attrib);
 			gatt_read_char(gatt->attrib, handle, 0, update_char_desc,
 									qfmt);
 		} else if (uuid_desc16_cmp(&uuid, GATT_CHARAC_FMT_UUID) == 0) {
-			gatt->attrib = g_attrib_ref(gatt->attrib);
 			gatt_read_char(gatt->attrib, handle, 0,
 						update_char_format, qfmt);
 		} else
@@ -697,7 +689,6 @@ static void descriptor_cb(guint8 status, const guint8 *pdu, guint16 plen,
 
 	att_data_list_free(list);
 done:
-	g_attrib_unref(gatt->attrib);
 	g_free(current);
 }
 
@@ -711,7 +702,6 @@ static void update_all_chars(gpointer data, gpointer user_data)
 	qdesc->gatt = gatt;
 	qdesc->chr = chr;
 
-	gatt->attrib = g_attrib_ref(gatt->attrib);
 	gatt_find_info(gatt->attrib, chr->handle + 1, chr->end, descriptor_cb,
 									qdesc);
 
@@ -719,7 +709,6 @@ static void update_all_chars(gpointer data, gpointer user_data)
 	qvalue->gatt = gatt;
 	qvalue->chr = chr;
 
-	gatt->attrib = g_attrib_ref(gatt->attrib);
 	gatt_read_char(gatt->attrib, chr->handle, 0, update_char_value, qvalue);
 }
 
@@ -796,7 +785,6 @@ static void char_discovered_cb(GSList *characteristics, guint8 status,
 
 fail:
 	g_dbus_send_message(gatt->conn, reply);
-	g_attrib_unref(gatt->attrib);
 	g_free(current);
 }
 
-- 
1.7.6

