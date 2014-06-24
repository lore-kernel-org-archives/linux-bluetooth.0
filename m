Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/7] HDP: Fix possible memory leak
Date: Tue, 24 Jun 2014 15:07:44 +0300
Message-Id: <1403611666-26060-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1403611666-26060-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1403611666-26060-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 profiles/health/hdp_util.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/profiles/health/hdp_util.c b/profiles/health/hdp_util.c
index 5676eee..e3e0830 100644
--- a/profiles/health/hdp_util.c
+++ b/profiles/health/hdp_util.c
@@ -598,6 +598,13 @@ fail:
 	return NULL;
 }
 
+static void free_hdp_list(void *list)
+{
+	sdp_list_t *hdp_list = list;
+
+	sdp_list_free(hdp_list, (sdp_free_func_t)sdp_data_free);
+}
+
 static gboolean register_features(struct hdp_application *app,
 						sdp_list_t **sup_features)
 {
@@ -620,16 +627,11 @@ static gboolean register_features(struct hdp_application *app,
 fail:
 	if (hdp_feature != NULL)
 		sdp_list_free(hdp_feature, (sdp_free_func_t)sdp_data_free);
+	if (*sup_features != NULL)
+		sdp_list_free(*sup_features, free_hdp_list);
 	return FALSE;
 }
 
-static void free_hdp_list(void *list)
-{
-	sdp_list_t *hdp_list = list;
-
-	sdp_list_free(hdp_list, (sdp_free_func_t)sdp_data_free);
-}
-
 static gboolean register_service_sup_features(GSList *app_list,
 						sdp_record_t *sdp_record)
 {
-- 
1.8.3.2

