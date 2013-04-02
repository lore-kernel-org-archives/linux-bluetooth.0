Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [RFC BlueZ 07/18] core: Do not pass around memory allocated internally by GATT API
Date: Tue,  2 Apr 2013 12:50:54 -0400
Message-Id: <1364921465-31182-8-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1364921465-31182-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1364921465-31182-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Instead, do a "deep copy" of the list of GATT services. While this
generates extra heap allocations, it also allows proper cleanup in case
of ATT or link errors. In other words, memory allocated by GATT API will
be freed by GATT API after callback returns.
---
 src/device.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index 6fd255a..3b4d66b 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3078,11 +3078,16 @@ static void find_included_services(struct included_search *search,
 {
 	struct btd_device *device = search->req->device;
 	struct gatt_primary *prim;
+	GSList *l;
 
 	if (services == NULL)
 		return;
 
-	search->services = g_slist_copy(services);
+	for (l = services; l != NULL; l = l->next) {
+		prim = l->data;
+		search->services = g_slist_append(search->services,
+						g_memdup(prim, sizeof(*prim)));
+	}
 	search->current = search->services;
 
 	prim = search->current->data;
@@ -3108,6 +3113,7 @@ static bool primary_cb(GSList *services, guint8 status, gpointer user_data)
 
 		device->browse = NULL;
 		browse_request_free(req);
+		g_slist_free_full(search->services, g_free);
 		g_free(search);
 
 		return false;
-- 
1.7.9.5

