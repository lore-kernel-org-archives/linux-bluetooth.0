Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 2/2] heartrate: Remove unused measurement characteristic value handle
Date: Sat, 13 Oct 2012 17:18:22 +0200
Message-Id: <1350141502-4385-2-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1350141502-4385-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1350141502-4385-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Since notification handler is now registered only for measurement
characteristic value handle it's no longer needed to keep this handle.
---
 profiles/heartrate/heartrate.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/profiles/heartrate/heartrate.c b/profiles/heartrate/heartrate.c
index 81ff310..28c1932 100644
--- a/profiles/heartrate/heartrate.c
+++ b/profiles/heartrate/heartrate.c
@@ -66,7 +66,6 @@ struct heartrate {
 
 	struct att_range		*svc_range;	/* primary svc range */
 
-	uint16_t			measurement_val_handle;
 	uint16_t			measurement_ccc_handle;
 	uint16_t			hrcp_val_handle;
 
@@ -478,8 +477,6 @@ static void discover_char_cb(GSList *chars, guint8 status, gpointer user_data)
 			struct gatt_char *c_next =
 				(chars->next ? chars->next->data : NULL);
 
-			hr->measurement_val_handle = c->value_handle;
-
 			hr->attionotid = g_attrib_register(hr->attrib,
 						ATT_OP_HANDLE_NOTIFY,
 						c->value_handle,
-- 
1.7.11.3

