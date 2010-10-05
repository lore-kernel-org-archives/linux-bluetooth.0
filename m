Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH] Add PSM option for GATT/ATT over BR/EDR on gatttool
Date: Tue,  5 Oct 2010 14:15:58 -0300
Message-Id: <1286298958-21494-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 TODO              |    6 ------
 attrib/gatttool.c |    6 ++++--
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/TODO b/TODO
index 41ec7a7..0a82f5c 100644
--- a/TODO
+++ b/TODO
@@ -40,12 +40,6 @@ ATT/GATT
   Priority: Low
   Complexity: C1
 
-- Add command line support for specifying psm with gatttool (e.g. --psm
-  37)
-
-  Priority: Medium
-  Complexity: C1
-
 - Add command line support to use medium instead of (default) low
   security level with gatttool (--sec-level)
 
diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index 76fe62c..2de3f8b 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -43,7 +43,6 @@
 #include "gattrib.h"
 #include "gatt.h"
 
-#define GATT_PSM 0x1f
 /* Minimum MTU for L2CAP connections over BR/EDR */
 #define ATT_MIN_MTU_L2CAP 48
 #define GATT_CID 4
@@ -55,6 +54,7 @@ static int opt_start = 0x0001;
 static int opt_end = 0xffff;
 static int opt_handle = -1;
 static int opt_mtu = 0;
+static int opt_psm = 0x1f;
 static gboolean opt_primary = FALSE;
 static gboolean opt_characteristics = FALSE;
 static gboolean opt_char_read = FALSE;
@@ -122,7 +122,7 @@ static GIOChannel *do_connect(gboolean le)
 		chan = bt_io_connect(BT_IO_L2CAP, connect_cb, NULL, NULL, &err,
 				BT_IO_OPT_SOURCE_BDADDR, &sba,
 				BT_IO_OPT_DEST_BDADDR, &dba,
-				BT_IO_OPT_PSM, GATT_PSM,
+				BT_IO_OPT_PSM, opt_psm,
 				BT_IO_OPT_OMTU, opt_mtu,
 				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
 				BT_IO_OPT_INVALID);
@@ -518,6 +518,8 @@ static GOptionEntry options[] = {
 		"Specify remote Bluetooth address", "MAC" },
 	{ "mtu", 'm', 0, G_OPTION_ARG_INT, &opt_mtu,
 		"Specify the MTU size", "MTU" },
+	{ "psm", 'p', 0, G_OPTION_ARG_INT, &opt_psm,
+		"Specify the PSM for GATT/ATT over BR/EDR", "PSM" },
 	{ NULL },
 };
 
-- 
1.7.3.1

