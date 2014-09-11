Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 09/14] android/gatt: Fix sending Get Descriptor callback
Date: Thu, 11 Sep 2014 08:08:47 +0200
Message-Id: <1410415732-23212-9-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1410415732-23212-1-git-send-email-marcin.kraglak@tieto.com>
References: <1410415732-23212-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

GATT_STATUS_SUCCESS or GATT_STATUS_FAILURE should be send in this
callback.
---
 android/gatt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 4ef2b5f..5a1d215 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -2772,9 +2772,9 @@ static void gatt_discover_desc_cb(guint8 status, GSList *descs,
 reply:
 	descr = queue_peek_head(ch->descriptors);
 
-	send_client_descr_notify(status, conn->id, srvc->primary, &srvc->id,
-						&ch->id,
-						descr ? &descr->id : NULL);
+	send_client_descr_notify(status ? GATT_FAILURE : GATT_SUCCESS, conn->id,
+					srvc->primary, &srvc->id, &ch->id,
+					descr ? &descr->id : NULL);
 
 	free(data);
 }
-- 
1.9.3

