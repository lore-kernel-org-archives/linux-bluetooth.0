Return-Path: <cyrus@holtmann.org>
From: Sheldon Demario <sheldon.demario@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Sheldon Demario <sheldon.demario@openbossa.org>
Subject: [PATCH] Adding a new option to specify medium security level for gatttool
Date: Wed, 10 Nov 2010 16:21:35 -0500
Message-Id: <1289424095-26628-1-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 TODO              |    6 ------
 attrib/gatttool.c |   11 +++++++++--
 2 files changed, 9 insertions(+), 8 deletions(-)

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
index b9f5138..929ee5d 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -54,6 +54,7 @@ static int opt_end = 0xffff;
 static int opt_handle = -1;
 static int opt_mtu = 0;
 static int opt_psm = 0x1f;
+static gboolean opt_medium_sec = FALSE;
 static gboolean opt_primary = FALSE;
 static gboolean opt_characteristics = FALSE;
 static gboolean opt_char_read = FALSE;
@@ -84,6 +85,7 @@ static GIOChannel *do_connect(gboolean le)
 	GIOChannel *chan;
 	bdaddr_t sba, dba;
 	GError *err = NULL;
+	BtIOSecLevel sec_level;
 
 	/* This check is required because currently setsockopt() returns no
 	 * errors for MTU values smaller than the allowed minimum. */
@@ -109,13 +111,15 @@ static GIOChannel *do_connect(gboolean le)
 	} else
 		bacpy(&sba, BDADDR_ANY);
 
+	sec_level = opt_medium_sec ? BT_IO_SEC_MEDIUM : BT_IO_SEC_LOW;
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
@@ -123,7 +127,7 @@ static GIOChannel *do_connect(gboolean le)
 				BT_IO_OPT_DEST_BDADDR, &dba,
 				BT_IO_OPT_PSM, opt_psm,
 				BT_IO_OPT_OMTU, opt_mtu,
-				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
+				BT_IO_OPT_SEC_LEVEL, sec_level,
 				BT_IO_OPT_INVALID);
 
 	if (err) {
@@ -519,6 +523,9 @@ static GOptionEntry options[] = {
 		"Specify the MTU size", "MTU" },
 	{ "psm", 'p', 0, G_OPTION_ARG_INT, &opt_psm,
 		"Specify the PSM for GATT/ATT over BR/EDR", "PSM" },
+	{ "sec-medium", 's', 0, G_OPTION_ARG_NONE, &opt_medium_sec,
+		"Use medium instead of default low security level",
+		NULL},
 	{ NULL },
 };
 
-- 
1.6.2.rc2

