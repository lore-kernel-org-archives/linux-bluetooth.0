Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/6] plugins/policy: Disable other connect policies while reconnect is active
Date: Thu, 28 Jul 2016 17:27:49 +0300
Message-Id: <1469716070-16506-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1469716070-16506-1-git-send-email-luiz.dentz@gmail.com>
References: <1469716070-16506-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Other policies shall not interfere while reconnect is active.
---
 plugins/policy.c | 43 ++++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/plugins/policy.c b/plugins/policy.c
index 3058824..0330456 100644
--- a/plugins/policy.c
+++ b/plugins/policy.c
@@ -95,10 +95,29 @@ struct policy_data {
 	uint8_t tg_retries;
 };
 
+static struct reconnect_data *reconnect_find(struct btd_device *dev)
+{
+	GSList *l;
+
+	for (l = reconnects; l; l = g_slist_next(l)) {
+		struct reconnect_data *reconnect = l->data;
+
+		if (reconnect->dev == dev)
+			return reconnect;
+	}
+
+	return NULL;
+}
+
 static void policy_connect(struct policy_data *data,
 						struct btd_service *service)
 {
 	struct btd_profile *profile = btd_service_get_profile(service);
+	struct reconnect_data *reconnect;
+
+	reconnect = reconnect_find(btd_service_get_device(service));
+	if (reconnect && reconnect->active)
+		return;
 
 	DBG("%s profile %s", device_get_path(data->dev), profile->name);
 
@@ -496,6 +515,7 @@ static void target_cb(struct btd_service *service,
 static void reconnect_reset(struct reconnect_data *reconnect)
 {
 	reconnect->attempt = 0;
+	reconnect->active = false;
 
 	if (reconnect->timer > 0) {
 		g_source_remove(reconnect->timer);
@@ -518,20 +538,6 @@ static bool reconnect_match(const char *uuid)
 	return false;
 }
 
-static struct reconnect_data *reconnect_find(struct btd_device *dev)
-{
-	GSList *l;
-
-	for (l = reconnects; l; l = g_slist_next(l)) {
-		struct reconnect_data *reconnect = l->data;
-
-		if (reconnect->dev == dev)
-			return reconnect;
-	}
-
-	return NULL;
-}
-
 static struct reconnect_data *reconnect_add(struct btd_service *service)
 {
 	struct btd_device *dev = btd_service_get_device(service);
@@ -643,7 +649,6 @@ static void service_cb(struct btd_service *service,
 	 */
 	reconnect = reconnect_add(service);
 
-	reconnect->active = false;
 	reconnect_reset(reconnect);
 
 	/*
@@ -675,7 +680,6 @@ static gboolean reconnect_timeout(gpointer data)
 		return FALSE;
 	}
 
-	reconnect->active = true;
 	reconnect->attempt++;
 
 	return FALSE;
@@ -685,10 +689,13 @@ static void reconnect_set_timer(struct reconnect_data *reconnect)
 {
 	static int timeout = 0;
 
+	reconnect->active = true;
+
 	if (reconnect->attempt < reconnect_intervals_len)
 		timeout = reconnect_intervals[reconnect->attempt];
 
-	DBG("%d seconds", timeout);
+	DBG("attempt %u/%zu %d seconds", reconnect->attempt + 1,
+						reconnect_attempts, timeout);
 
 	reconnect->timer = g_timeout_add_seconds(timeout, reconnect_timeout,
 								reconnect);
@@ -726,8 +733,6 @@ static void conn_fail_cb(struct btd_device *dev, uint8_t status)
 	if (!reconnect->active)
 		return;
 
-	reconnect->active = false;
-
 	/* Give up if we were powered off */
 	if (status == MGMT_STATUS_NOT_POWERED) {
 		reconnect_reset(reconnect);
-- 
2.7.4

