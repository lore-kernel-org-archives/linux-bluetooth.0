Return-Path: <cyrus@holtmann.org>
From: Sheldon Demario <sheldon.demario@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Sheldon Demario <sheldon.demario@openbossa.org>
Subject: [PATCH v3] Adding a new option to specify security level for gatttool
Date: Wed, 17 Nov 2010 08:26:40 -0500
Message-Id: <1290000400-20001-1-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 TODO              |    6 ------
 attrib/gatttool.c |   15 +++++++++++++--
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/TODO b/TODO
index c0a25f1..49a9e76 100644
--- a/TODO
+++ b/TODO
@@ -123,12 +123,6 @@ ATT/GATT
   Priority: Low
   Complexity: C1
 
-- Add command line support to use medium instead of (default) low
-  security level with gatttool (--sec-level)
-
-  Priority: Low
-  Complexity: C1
-
 - Implement Server characteristic Configuration support in the attribute
   server to manage characteristic value broadcasting. There is a single
   instance of the Server Characteristic Configuration for all clients.
diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index b9f5138..636e0c3 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -49,6 +49,7 @@
 static gchar *opt_src = NULL;
 static gchar *opt_dst = NULL;
 static gchar *opt_value = NULL;
+static gchar *opt_sec_level = "low";
 static int opt_start = 0x0001;
 static int opt_end = 0xffff;
 static int opt_handle = -1;
@@ -84,6 +85,7 @@ static GIOChannel *do_connect(gboolean le)
 	GIOChannel *chan;
 	bdaddr_t sba, dba;
 	GError *err = NULL;
+	BtIOSecLevel sec_level;
 
 	/* This check is required because currently setsockopt() returns no
 	 * errors for MTU values smaller than the allowed minimum. */
@@ -109,13 +111,20 @@ static GIOChannel *do_connect(gboolean le)
 	} else
 		bacpy(&sba, BDADDR_ANY);
 
+	if (strcmp(opt_sec_level, "medium") == 0)
+		sec_level = BT_IO_SEC_MEDIUM;
+	else if (strcmp(opt_sec_level, "high") == 0)
+		sec_level = BT_IO_SEC_HIGH;
+	else
+		sec_level = BT_IO_SEC_LOW;
+
 	if (le)
 		chan = bt_io_connect(BT_IO_L2CAP, connect_cb, NULL, NULL, &err,
 				BT_IO_OPT_SOURCE_BDADDR, &sba,
 				BT_IO_OPT_DEST_BDADDR, &dba,
 				BT_IO_OPT_CID, GATT_CID,
 				BT_IO_OPT_OMTU, opt_mtu,
-				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
+				BT_IO_OPT_SEC_LEVEL, sec_level,
 				BT_IO_OPT_INVALID);
 	else
 		chan = bt_io_connect(BT_IO_L2CAP, connect_cb, NULL, NULL, &err,
@@ -123,7 +132,7 @@ static GIOChannel *do_connect(gboolean le)
 				BT_IO_OPT_DEST_BDADDR, &dba,
 				BT_IO_OPT_PSM, opt_psm,
 				BT_IO_OPT_OMTU, opt_mtu,
-				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
+				BT_IO_OPT_SEC_LEVEL, sec_level,
 				BT_IO_OPT_INVALID);
 
 	if (err) {
@@ -519,6 +528,8 @@ static GOptionEntry options[] = {
 		"Specify the MTU size", "MTU" },
 	{ "psm", 'p', 0, G_OPTION_ARG_INT, &opt_psm,
 		"Specify the PSM for GATT/ATT over BR/EDR", "PSM" },
+	{ "sec-level", 'l', 0, G_OPTION_ARG_STRING, &opt_sec_level,
+		"Set security level. Default: low", "[low | medium | high]"},
 	{ NULL },
 };
 
-- 
1.7.3.2

