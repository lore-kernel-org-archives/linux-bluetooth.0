Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 5/6] shared/hfp: Add helper to set disconnect handler
Date: Mon, 29 Sep 2014 15:47:17 +0200
Message-Id: <1411998438-26914-7-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1411998438-26914-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1411998438-26914-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds helper to set disconnect handler which takes struct hfp
as the parameter. This helper will be used also by future hfp_hf.
---
 src/shared/hfp.c | 59 ++++++++++++++++++++++++++++++++------------------------
 1 file changed, 34 insertions(+), 25 deletions(-)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index 5d1f007..a1af841 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -777,53 +777,62 @@ bool hfp_gw_unregister(struct hfp_gw *hfp, const char *prefix)
 
 static void disconnect_watch_destroy(void *user_data)
 {
-	struct hfp_gw *hfp = user_data;
+	struct hfp *hfp = user_data;
 
-	if (hfp->hfp.disconnect_destroy)
-		hfp->hfp.disconnect_destroy(hfp->hfp.disconnect_data);
+	if (hfp->disconnect_destroy)
+		hfp->disconnect_destroy(hfp->disconnect_data);
 
-	if (hfp->hfp.destroyed)
+	if (hfp->destroyed)
 		free(hfp);
 }
 
 static bool io_disconnected(struct io *io, void *user_data)
 {
-	struct hfp_gw *hfp = user_data;
+	struct hfp *hfp = user_data;
 
-	hfp->hfp.in_disconnect = true;
+	hfp->in_disconnect = true;
 
-	if (hfp->hfp.disconnect_callback)
-		hfp->hfp.disconnect_callback(hfp->hfp.disconnect_data);
+	if (hfp->disconnect_callback)
+		hfp->disconnect_callback(hfp->disconnect_data);
 
-	hfp->hfp.in_disconnect = false;
+	hfp->in_disconnect = false;
 
 	return false;
 }
 
-bool hfp_gw_set_disconnect_handler(struct hfp_gw *hfp,
-					hfp_disconnect_func_t callback,
-					void *user_data,
-					hfp_destroy_func_t destroy)
+static bool set_disconnect_handler(struct hfp *hfp,
+						hfp_disconnect_func_t callback,
+						void *user_data,
+						hfp_destroy_func_t destroy)
 {
-	if (!hfp)
-		return false;
+	if (hfp->disconnect_destroy)
+		hfp->disconnect_destroy(hfp->disconnect_data);
 
-	if (hfp->hfp.disconnect_destroy)
-		hfp->hfp.disconnect_destroy(hfp->hfp.disconnect_data);
-
-	if (!io_set_disconnect_handler(hfp->hfp.io, io_disconnected, hfp,
+	if (!io_set_disconnect_handler(hfp->io, io_disconnected, hfp,
 						disconnect_watch_destroy)) {
-		hfp->hfp.disconnect_callback = NULL;
-		hfp->hfp.disconnect_destroy = NULL;
-		hfp->hfp.disconnect_data = NULL;
+		hfp->disconnect_callback = NULL;
+		hfp->disconnect_destroy = NULL;
+		hfp->disconnect_data = NULL;
 		return false;
 	}
 
-	hfp->hfp.disconnect_callback = callback;
-	hfp->hfp.disconnect_destroy = destroy;
-	hfp->hfp.disconnect_data = user_data;
+	hfp->disconnect_callback = callback;
+	hfp->disconnect_destroy = destroy;
+	hfp->disconnect_data = user_data;
 
 	return true;
+
+}
+
+bool hfp_gw_set_disconnect_handler(struct hfp_gw *hfp,
+					hfp_disconnect_func_t callback,
+					void *user_data,
+					hfp_destroy_func_t destroy)
+{
+	if (!hfp)
+		return false;
+
+	return set_disconnect_handler(&hfp->hfp, callback, user_data, destroy);
 }
 
 bool hfp_gw_disconnect(struct hfp_gw *hfp)
-- 
1.8.4

