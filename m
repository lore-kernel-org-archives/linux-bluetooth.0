Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ 2/5] scan: Use the per handle GATT event notifier
Date: Wed, 10 Oct 2012 20:55:54 -0300
Message-Id: <1349913357-25547-2-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1349913357-25547-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1349913357-25547-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/scanparam/scan.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/profiles/scanparam/scan.c b/profiles/scanparam/scan.c
index bbf646c..09fbe1f 100644
--- a/profiles/scanparam/scan.c
+++ b/profiles/scanparam/scan.c
@@ -83,17 +83,6 @@ static void refresh_value_cb(const uint8_t *pdu, uint16_t len,
 						gpointer user_data)
 {
 	struct scan *scan = user_data;
-	uint16_t handle;
-
-	if (len < 4) { /* 1-byte opcode + 2-byte handle + refresh */
-		error("Malformed ATT notification");
-		return;
-	}
-
-	handle = att_get_u16(&pdu[1]);
-
-	if (handle != scan->refresh_handle)
-		return;
 
 	DBG("Server requires refresh: %d", pdu[3]);
 
@@ -115,8 +104,8 @@ static void ccc_written_cb(guint8 status, const guint8 *pdu,
 	DBG("Scan Refresh: notification enabled");
 
 	scan->refresh_cb_id = g_attrib_register(scan->attrib,
-				ATT_OP_HANDLE_NOTIFY, GATTRIB_ALL_HANDLES,
-				refresh_value_cb, user_data, NULL);
+				ATT_OP_HANDLE_NOTIFY, scan->refresh_handle,
+				refresh_value_cb, scan, NULL);
 }
 
 static void discover_descriptor_cb(guint8 status, const guint8 *pdu,
-- 
1.7.12.3

