Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 2/2] Change security level on demand when reading characteristic descriptor
Date: Thu, 30 Dec 2010 18:22:10 -0300
Message-Id: <1293744130-21124-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1293744130-21124-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1293744130-21124-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/client.c |   33 ++++++++++++++++++++++-----------
 1 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index 3297a0c..644cd62 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -693,18 +693,29 @@ static void update_char_desc(guint8 status, const guint8 *pdu, guint16 len,
 	struct gatt_service *gatt = current->prim->gatt;
 	struct characteristic *chr = current->chr;
 
-	if (status != 0)
-		goto done;
+	if (status == 0) {
 
-	g_free(chr->desc);
+		g_free(chr->desc);
 
-	chr->desc = g_malloc(len);
-	memcpy(chr->desc, pdu + 1, len - 1);
-	chr->desc[len - 1] = '\0';
+		chr->desc = g_malloc(len);
+		memcpy(chr->desc, pdu + 1, len - 1);
+		chr->desc[len - 1] = '\0';
+
+		store_attribute(gatt, current->handle,
+				GATT_CHARAC_USER_DESC_UUID,
+				(void *) chr->desc, len);
+	} else if (status == ATT_ECODE_INSUFF_ENC) {
+		GIOChannel *io = g_attrib_get_channel(gatt->attrib);
+
+		if (bt_io_set(io, BT_IO_L2CAP, NULL,
+				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_HIGH,
+				BT_IO_OPT_INVALID)) {
+			gatt_read_char(gatt->attrib, current->handle,
+					update_char_desc, current);
+			return;
+		}
+	}
 
-	store_attribute(gatt, current->handle, GATT_CHARAC_USER_DESC_UUID,
-						(void *) chr->desc, len);
-done:
 	g_attrib_unref(gatt->attrib);
 	g_free(current);
 }
-- 
1.7.3.4

