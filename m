Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH] Enable GATT over LE link on the attribute client
Date: Thu,  4 Nov 2010 19:43:29 +0000
Message-Id: <1288899810-18722-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1288899810-18722-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1288899810-18722-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/client.c   |   22 ++++++++++++----------
 attrib/gatt.h     |    2 ++
 attrib/gatttool.c |    1 -
 3 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index cd720e6..bcc903b 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -1352,23 +1352,25 @@ int attrib_client_register(struct btd_device *device, int psm)
 	}
 
 	if (psm < 0) {
-		/*
-		 * FIXME: when PSM is not given means that L2CAP fixed
-		 * channel shall be used. For this case, ATT CID(0x0004).
-		 */
-
-		DBG("GATT over LE");
-
-		return 0;
-	}
+		io = bt_io_connect(BT_IO_L2CAP, connect_cb, gatt, NULL, &gerr,
+					BT_IO_OPT_SOURCE_BDADDR, &sba,
+					BT_IO_OPT_DEST_BDADDR, &dba,
+					BT_IO_OPT_CID, GATT_CID,
+					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
+					BT_IO_OPT_INVALID);
 
-	io = bt_io_connect(BT_IO_L2CAP, connect_cb, gatt, NULL, &gerr,
+			DBG("GATT over Low Energy");
+	} else {
+		io = bt_io_connect(BT_IO_L2CAP, connect_cb, gatt, NULL, &gerr,
 					BT_IO_OPT_SOURCE_BDADDR, &sba,
 					BT_IO_OPT_DEST_BDADDR, &dba,
 					BT_IO_OPT_PSM, psm,
 					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
 					BT_IO_OPT_INVALID);
 
+		DBG("GATT over Basic Rate");
+	}
+
 	if (!io) {
 		error("%s", gerr->message);
 		g_error_free(gerr);
diff --git a/attrib/gatt.h b/attrib/gatt.h
index a357f58..f1599c2 100644
--- a/attrib/gatt.h
+++ b/attrib/gatt.h
@@ -22,6 +22,8 @@
  *
  */
 
+#define GATT_CID 4
+
 guint gatt_discover_primary(GAttrib *attrib, uint16_t start,
 		uint16_t end, GAttribResultFunc func, gpointer user_data);
 
diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index 2de3f8b..b9f5138 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -45,7 +45,6 @@
 
 /* Minimum MTU for L2CAP connections over BR/EDR */
 #define ATT_MIN_MTU_L2CAP 48
-#define GATT_CID 4
 
 static gchar *opt_src = NULL;
 static gchar *opt_dst = NULL;
-- 
1.7.3.2

