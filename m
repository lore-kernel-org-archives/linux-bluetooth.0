Return-Path: <cyrus@holtmann.org>
From: Sheldon Demario <sheldon.demario@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Sheldon Demario <sheldon.demario@openbossa.org>
Subject: [PATCH] Add discover characteristics by uuid to gattool
Date: Wed, 16 Mar 2011 14:40:46 -0300
Message-Id: <1300297246-11056-1-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/client.c      |    2 +-
 attrib/gatt.c        |   16 +++++++++++-----
 attrib/gatt.h        |    3 ++-
 attrib/gatttool.c    |    3 ++-
 attrib/interactive.c |   18 ++++++++++++++++--
 5 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index 3237a6b..54bdc79 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -960,7 +960,7 @@ static DBusMessage *discover_char(DBusConnection *conn, DBusMessage *msg,
 	qchr->prim = prim;
 	qchr->msg = dbus_message_ref(msg);
 
-	gatt_discover_char(gatt->attrib, att->start, att->end,
+	gatt_discover_char(gatt->attrib, att->start, att->end, NULL,
 						char_discovered_cb, qchr);
 
 	return NULL;
diff --git a/attrib/gatt.c b/attrib/gatt.c
index 32bd4a0..b328c72 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -40,7 +40,7 @@ struct discover_primary {
 
 struct discover_char {
 	GAttrib *attrib;
-	bt_uuid_t uuid;
+	bt_uuid_t *uuid;
 	uint16_t end;
 	GSList *characteristics;
 	gatt_cb_t cb;
@@ -59,6 +59,7 @@ static void discover_char_free(struct discover_char *dc)
 	g_slist_foreach(dc->characteristics, (GFunc) g_free, NULL);
 	g_slist_free(dc->characteristics);
 	g_attrib_unref(dc->attrib);
+	g_free(dc->uuid);
 	g_free(dc);
 }
 
@@ -281,6 +282,9 @@ static void char_discovered_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
 			goto done;
 		}
 
+		if (dc->uuid && bt_uuid_cmp(dc->uuid, &uuid))
+			break;
+
 		chars->handle = last;
 		chars->properties = value[2];
 		chars->value_handle = att_get_u16(&value[3]);
@@ -313,16 +317,17 @@ done:
 }
 
 guint gatt_discover_char(GAttrib *attrib, uint16_t start, uint16_t end,
-					gatt_cb_t func, gpointer user_data)
+						bt_uuid_t *uuid, gatt_cb_t func,
+						gpointer user_data)
 {
 	uint8_t pdu[ATT_DEFAULT_LE_MTU];
 	struct discover_char *dc;
+	bt_uuid_t type_uuid;
 	guint16 plen;
-	bt_uuid_t uuid;
 
-	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
+	bt_uuid16_create(&type_uuid, GATT_CHARAC_UUID);
 
-	plen = enc_read_by_type_req(start, end, &uuid, pdu, sizeof(pdu));
+	plen = enc_read_by_type_req(start, end, &type_uuid, pdu, sizeof(pdu));
 	if (plen == 0)
 		return 0;
 
@@ -334,6 +339,7 @@ guint gatt_discover_char(GAttrib *attrib, uint16_t start, uint16_t end,
 	dc->cb = func;
 	dc->user_data = user_data;
 	dc->end = end;
+	dc->uuid = uuid;
 
 	return g_attrib_send(attrib, 0, pdu[0], pdu, plen, char_discovered_cb,
 								dc, NULL);
diff --git a/attrib/gatt.h b/attrib/gatt.h
index 730de7e..c6d3843 100644
--- a/attrib/gatt.h
+++ b/attrib/gatt.h
@@ -30,7 +30,8 @@ guint gatt_discover_primary(GAttrib *attrib, bt_uuid_t *uuid, gatt_cb_t func,
 							gpointer user_data);
 
 guint gatt_discover_char(GAttrib *attrib, uint16_t start, uint16_t end,
-					gatt_cb_t func, gpointer user_data);
+					bt_uuid_t *uuid, gatt_cb_t func,
+					gpointer user_data);
 
 guint gatt_read_char(GAttrib *attrib, uint16_t handle, uint16_t offset,
 				GAttribResultFunc func, gpointer user_data);
diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index 729e18d..0dfbc04 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -206,7 +206,8 @@ static gboolean characteristics(gpointer user_data)
 {
 	GAttrib *attrib = user_data;
 
-	gatt_discover_char(attrib, opt_start, opt_end, char_discovered_cb, NULL);
+	gatt_discover_char(attrib, opt_start, opt_end, opt_uuid,
+						char_discovered_cb, NULL);
 
 	return FALSE;
 }
diff --git a/attrib/interactive.c b/attrib/interactive.c
index b32e9e7..7e5aa4c 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -431,7 +431,21 @@ static void cmd_char(int argcp, char **argvp)
 		}
 	}
 
-	gatt_discover_char(attrib, start, end, char_cb, NULL);
+	if (argcp > 3) {
+		bt_uuid_t *uuid;
+
+		uuid = g_try_new(bt_uuid_t, 1);
+		if (bt_string_to_uuid(uuid, argvp[3]) < 0) {
+			g_free(uuid);
+			printf("Invalid UUID\n");
+			return;
+		}
+
+		gatt_discover_char(attrib, start, end, uuid, char_cb, NULL);
+		return;
+	}
+
+	gatt_discover_char(attrib, start, end, NULL, char_cb, NULL);
 }
 
 static void cmd_char_desc(int argcp, char **argvp)
@@ -658,7 +672,7 @@ static struct {
 		"Disconnect from a remote device" },
 	{ "primary",		cmd_primary,	"[UUID]",
 		"Primary Service Discovery" },
-	{ "characteristics",	cmd_char,	"[start hnd] [end hnd]",
+	{ "characteristics",	cmd_char,	"[start hnd [end hnd [UUID]]]",
 		"Characteristics Discovery" },
 	{ "char-desc",		cmd_char_desc,	"[start hnd] [end hnd]",
 		"Characteristics Descriptor Discovery" },
-- 
1.7.1

