Return-Path: <cyrus@holtmann.org>
From: Sheldon Demario <sheldon.demario@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Sheldon Demario <sheldon.demario@openbossa.org>
Subject: [PATCH 2/7] Move do_connect from gatttool to gtcommon
Date: Fri, 21 Jan 2011 10:46:21 -0300
Message-Id: <1295617586-3398-2-git-send-email-sheldon.demario@openbossa.org>
In-Reply-To: <1295617586-3398-1-git-send-email-sheldon.demario@openbossa.org>
References: <1295617586-3398-1-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/gatttool.c |   70 +----------------------------------------------------
 attrib/gtcommon.c |   63 +++++++++++++++++++++++++++++++++++++++++++++++
 attrib/gtcommon.h |    5 ++++
 3 files changed, 69 insertions(+), 69 deletions(-)

diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index e5ebad1..e87ff0c 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -40,13 +40,9 @@
 #include "att.h"
 #include "btio.h"
 #include "gattrib.h"
-#include "glib-helper.h"
 #include "gatt.h"
 #include "gtcommon.h"
 
-/* Minimum MTU for L2CAP connections over BR/EDR */
-#define ATT_MIN_MTU_L2CAP 48
-
 static GMainLoop *event_loop;
 static gboolean got_error = FALSE;
 
@@ -65,70 +61,6 @@ static void connect_cb(GIOChannel *io, GError *err, gpointer user_data)
 	}
 }
 
-static GIOChannel *do_connect(gboolean le)
-{
-	GIOChannel *chan;
-	bdaddr_t sba, dba;
-	GError *err = NULL;
-	BtIOSecLevel sec_level;
-
-	/* This check is required because currently setsockopt() returns no
-	 * errors for MTU values smaller than the allowed minimum. */
-	if (opt_mtu != 0 && opt_mtu < ATT_MIN_MTU_L2CAP) {
-		g_printerr("MTU cannot be smaller than %d\n",
-							ATT_MIN_MTU_L2CAP);
-		return NULL;
-	}
-
-	/* Remote device */
-	if (opt_dst == NULL) {
-		g_printerr("Remote Bluetooth address required\n");
-		return NULL;
-	}
-	str2ba(opt_dst, &dba);
-
-	/* Local adapter */
-	if (opt_src != NULL) {
-		if (!strncmp(opt_src, "hci", 3))
-			hci_devba(atoi(opt_src + 3), &sba);
-		else
-			str2ba(opt_src, &sba);
-	} else
-		bacpy(&sba, BDADDR_ANY);
-
-	if (strcmp(opt_sec_level, "medium") == 0)
-		sec_level = BT_IO_SEC_MEDIUM;
-	else if (strcmp(opt_sec_level, "high") == 0)
-		sec_level = BT_IO_SEC_HIGH;
-	else
-		sec_level = BT_IO_SEC_LOW;
-
-	if (le)
-		chan = bt_io_connect(BT_IO_L2CAP, connect_cb, NULL, NULL, &err,
-				BT_IO_OPT_SOURCE_BDADDR, &sba,
-				BT_IO_OPT_DEST_BDADDR, &dba,
-				BT_IO_OPT_CID, GATT_CID,
-				BT_IO_OPT_OMTU, opt_mtu,
-				BT_IO_OPT_SEC_LEVEL, sec_level,
-				BT_IO_OPT_INVALID);
-	else
-		chan = bt_io_connect(BT_IO_L2CAP, connect_cb, NULL, NULL, &err,
-				BT_IO_OPT_SOURCE_BDADDR, &sba,
-				BT_IO_OPT_DEST_BDADDR, &dba,
-				BT_IO_OPT_PSM, opt_psm,
-				BT_IO_OPT_OMTU, opt_mtu,
-				BT_IO_OPT_SEC_LEVEL, sec_level,
-				BT_IO_OPT_INVALID);
-
-	if (err) {
-		g_printerr("%s\n", err->message);
-		g_error_free(err);
-		return NULL;
-	}
-
-	return chan;
-}
-
 static void primary_all_cb(GSList *services, guint8 status, gpointer user_data)
 {
 	GSList *l;
@@ -529,7 +461,7 @@ int main(int argc, char *argv[])
 		goto done;
 	}
 
-	chan = do_connect(opt_le);
+	chan = do_connect(opt_le, opt_dst, connect_cb);
 	if (chan == NULL) {
 		got_error = TRUE;
 		goto done;
diff --git a/attrib/gtcommon.c b/attrib/gtcommon.c
index ebf47e9..0759990 100644
--- a/attrib/gtcommon.c
+++ b/attrib/gtcommon.c
@@ -128,3 +128,66 @@ GOptionEntry options[] = {
 	{ NULL },
 };
 
+GIOChannel *do_connect(gboolean le, gchar *dest, BtIOConnect connect_cb)
+{
+	GIOChannel *chan;
+	bdaddr_t sba, dba;
+	GError *err = NULL;
+	BtIOSecLevel sec_level;
+
+	/* This check is required because currently setsockopt() returns no
+	 * errors for MTU values smaller than the allowed minimum. */
+	if (opt_mtu != 0 && opt_mtu < ATT_MIN_MTU_L2CAP) {
+		g_printerr("MTU cannot be smaller than %d\n",
+							ATT_MIN_MTU_L2CAP);
+		return NULL;
+	}
+
+	/* Remote device */
+	if (dest == NULL) {
+		g_printerr("Remote Bluetooth address required\n");
+		return NULL;
+	}
+	str2ba(dest, &dba);
+
+	/* Local adapter */
+	if (opt_src != NULL) {
+		if (!strncmp(opt_src, "hci", 3))
+			hci_devba(atoi(opt_src + 3), &sba);
+		else
+			str2ba(opt_src, &sba);
+	} else
+		bacpy(&sba, BDADDR_ANY);
+
+	if (strcmp(opt_sec_level, "medium") == 0)
+		sec_level = BT_IO_SEC_MEDIUM;
+	else if (strcmp(opt_sec_level, "high") == 0)
+		sec_level = BT_IO_SEC_HIGH;
+	else
+		sec_level = BT_IO_SEC_LOW;
+
+	if (le)
+		chan = bt_io_connect(BT_IO_L2CAP, connect_cb, NULL, NULL, &err,
+				BT_IO_OPT_SOURCE_BDADDR, &sba,
+				BT_IO_OPT_DEST_BDADDR, &dba,
+				BT_IO_OPT_CID, GATT_CID,
+				BT_IO_OPT_OMTU, opt_mtu,
+				BT_IO_OPT_SEC_LEVEL, sec_level,
+				BT_IO_OPT_INVALID);
+	else
+		chan = bt_io_connect(BT_IO_L2CAP, connect_cb, NULL, NULL, &err,
+				BT_IO_OPT_SOURCE_BDADDR, &sba,
+				BT_IO_OPT_DEST_BDADDR, &dba,
+				BT_IO_OPT_PSM, opt_psm,
+				BT_IO_OPT_OMTU, opt_mtu,
+				BT_IO_OPT_SEC_LEVEL, sec_level,
+				BT_IO_OPT_INVALID);
+
+	if (err) {
+		g_printerr("%s\n", err->message);
+		g_error_free(err);
+		return NULL;
+	}
+
+	return chan;
+}
diff --git a/attrib/gtcommon.h b/attrib/gtcommon.h
index 30e8e37..ead2f5b 100644
--- a/attrib/gtcommon.h
+++ b/attrib/gtcommon.h
@@ -21,6 +21,9 @@
  *
  */
 
+/* Minimum MTU for L2CAP connections over BR/EDR */
+#define ATT_MIN_MTU_L2CAP 48
+
 extern gchar *opt_src;
 extern gchar *opt_dst;
 extern gchar *opt_value;
@@ -39,6 +42,8 @@ extern gboolean opt_char_desc;
 extern gboolean opt_le;
 extern gboolean opt_char_write;
 
+GIOChannel *do_connect(gboolean le, gchar *dest, BtIOConnect connect_db);
+
 extern GOptionEntry primary_char_options[];
 extern GOptionEntry char_rw_options[];
 extern GOptionEntry gatt_options[];
-- 
1.7.1

