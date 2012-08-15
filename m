Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ] lib: Rename GAP UUID
Date: Wed, 15 Aug 2012 11:19:39 -0300
Message-Id: <1345040379-17704-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1345040379-17704-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1345040379-17704-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Cosmetic patch changing the GAP UUID declaration to follow the same
standard of the others GATT based services.
---
 lib/uuid.h   |    2 +-
 src/device.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/uuid.h b/lib/uuid.h
index 2c2b351..3bad8cc 100644
--- a/lib/uuid.h
+++ b/lib/uuid.h
@@ -80,7 +80,7 @@ extern "C" {
 
 #define DUN_GW_UUID		"00001103-0000-1000-8000-00805f9b34fb"
 
-#define GAP_SVC_UUID		"00001800-0000-1000-8000-00805f9b34fb"
+#define GAP_UUID		"00001800-0000-1000-8000-00805f9b34fb"
 #define PNP_UUID		"00001200-0000-1000-8000-00805f9b34fb"
 
 typedef struct {
diff --git a/src/device.c b/src/device.c
index dad9c79..f781298 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1894,7 +1894,7 @@ static void primary_cb(GSList *services, guint8 status, gpointer user_data)
 	for (l = services; l; l = l->next) {
 		struct gatt_primary *prim = l->data;
 
-		if (strcmp(prim->uuid, GAP_SVC_UUID) == 0)
+		if (strcmp(prim->uuid, GAP_UUID) == 0)
 			gap_prim = prim;
 
 		uuids = g_slist_append(uuids, prim->uuid);
-- 
1.7.8.6

