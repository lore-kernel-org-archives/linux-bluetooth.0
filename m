Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [RFC 4/5] plugins/policy: Disable policies on authentication failure
Date: Thu,  4 Aug 2016 15:28:38 +0200
Message-Id: <1470317319-3985-5-git-send-email-szymon.janc@codecoup.pl>
In-Reply-To: <1470317319-3985-1-git-send-email-szymon.janc@codecoup.pl>
References: <1470317319-3985-1-git-send-email-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If remote device was disconnected due to authentication failure (lost
bond) there is no point in trying to reconnect.
---
 plugins/policy.c | 58 +++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 43 insertions(+), 15 deletions(-)

diff --git a/plugins/policy.c b/plugins/policy.c
index 0330456..933a968 100644
--- a/plugins/policy.c
+++ b/plugins/policy.c
@@ -93,6 +93,8 @@ struct policy_data {
 	uint8_t ct_retries;
 	guint tg_timer;
 	uint8_t tg_retries;
+
+	bool auth_failure;
 };
 
 static struct reconnect_data *reconnect_find(struct btd_device *dev)
@@ -172,22 +174,34 @@ static struct policy_data *find_data(struct btd_device *dev)
 	return NULL;
 }
 
-static void policy_remove(void *user_data)
+static void policy_reset(struct policy_data *data)
 {
-	struct policy_data *data = user_data;
-
-	if (data->source_timer > 0)
+	if (data->source_timer > 0) {
 		g_source_remove(data->source_timer);
+		data->source_timer = 0;
+	}
 
-	if (data->sink_timer > 0)
+	if (data->sink_timer > 0) {
 		g_source_remove(data->sink_timer);
+		data->sink_timer = 0;
+	}
 
-	if (data->ct_timer > 0)
+	if (data->ct_timer > 0) {
 		g_source_remove(data->ct_timer);
+		data->ct_timer = 0;
+	}
 
-	if (data->tg_timer > 0)
+	if (data->tg_timer > 0) {
 		g_source_remove(data->tg_timer);
+		data->tg_timer = 0;
+	}
+}
 
+static void policy_remove(void *user_data)
+{
+	struct policy_data *data = user_data;
+
+	policy_reset(data);
 	g_free(data);
 }
 
@@ -606,6 +620,11 @@ static void service_cb(struct btd_service *service,
 {
 	struct btd_profile *profile = btd_service_get_profile(service);
 	struct reconnect_data *reconnect;
+	struct policy_data *policy;
+
+	policy = find_data(btd_service_get_device(service));
+	if (policy && policy->auth_failure)
+		return;
 
 	if (g_str_equal(profile->remote_uuid, A2DP_SINK_UUID))
 		sink_cb(service, old_state, new_state);
@@ -704,20 +723,29 @@ static void reconnect_set_timer(struct reconnect_data *reconnect)
 static void disconnect_cb(struct btd_device *dev, uint8_t reason)
 {
 	struct reconnect_data *reconnect;
+	struct policy_data *policy;
 
 	DBG("reason %u", reason);
 
-	if (reason != MGMT_DEV_DISCONN_TIMEOUT)
-		return;
-
-	reconnect = reconnect_find(dev);
-	if (!reconnect || !reconnect->reconnect)
-		return;
+	switch (reason) {
+	case MGMT_DEV_DISCONN_AUTH_FAILURE:
+		policy = policy_get_data(dev);
+		policy_reset(policy);
+		policy->auth_failure = true;
+		break;
+	case MGMT_DEV_DISCONN_TIMEOUT:
+		reconnect = reconnect_find(dev);
+		if (!reconnect || !reconnect->reconnect)
+			break;
 
-	DBG("Device %s identified for auto-reconnection",
+		DBG("Device %s identified for auto-reconnection",
 							device_get_path(dev));
 
-	reconnect_set_timer(reconnect);
+		reconnect_set_timer(reconnect);
+		break;
+	default:
+		break;
+	}
 }
 
 static void conn_fail_cb(struct btd_device *dev, uint8_t status)
-- 
2.7.4

