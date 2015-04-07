Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] policy: Add parameters to control reconnection
Date: Tue,  7 Apr 2015 10:27:04 +0300
Message-Id: <1428391624-25864-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1428391624-25864-1-git-send-email-luiz.dentz@gmail.com>
References: <1428391624-25864-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds ReconnectAttempts and ReconnectIntervals so platforms can fine
tune the reconnection strategy.
---
 plugins/policy.c | 85 +++++++++++++++++++++++++++++++++++++-------------------
 src/main.conf    | 10 +++++++
 2 files changed, 67 insertions(+), 28 deletions(-)

diff --git a/plugins/policy.c b/plugins/policy.c
index 45706f6..8098689 100644
--- a/plugins/policy.c
+++ b/plugins/policy.c
@@ -55,24 +55,26 @@
 #define CT_RETRIES 1
 #define TG_RETRIES CT_RETRIES
 
-/* Tracking of remote services to be auto-reconnected upon link loss */
-
-#define RECONNECT_GIVE_UP (3 * 60)
-#define RECONNECT_TIMEOUT 1
-
 struct reconnect_data {
 	struct btd_device *dev;
 	bool reconnect;
 	GSList *services;
 	guint timer;
 	bool active;
-	time_t start;
-	int timeout;
+	int attempt;
 };
 
 static const char *default_reconnect[] = {
 			HSP_AG_UUID, HFP_AG_UUID, A2DP_SOURCE_UUID, NULL };
 static char **reconnect_uuids = NULL;
+
+static const int default_attempts = 7;
+static int reconnect_attempts = 0;
+
+static const int default_intervals[] = { 1, 2, 4, 8, 16, 32, 64 };
+static int *reconnect_intervals = NULL;
+static int reconnect_intervals_len = 0;
+
 static GSList *reconnects = NULL;
 
 static unsigned int service_id = 0;
@@ -491,8 +493,7 @@ static void target_cb(struct btd_service *service,
 
 static void reconnect_reset(struct reconnect_data *reconnect)
 {
-	reconnect->start = 0;
-	reconnect->timeout = 1;
+	reconnect->attempt = 0;
 
 	if (reconnect->timer > 0) {
 		g_source_remove(reconnect->timer);
@@ -664,9 +665,6 @@ static gboolean reconnect_timeout(gpointer data)
 	/* Mark the GSource as invalid */
 	reconnect->timer = 0;
 
-	/* Increase timeout for the next attempt if this * one fails. */
-	reconnect->timeout *= 2;
-
 	err = btd_device_connect_services(reconnect->dev, reconnect->services);
 	if (err < 0) {
 		error("Reconnecting services failed: %s (%d)",
@@ -676,13 +674,24 @@ static gboolean reconnect_timeout(gpointer data)
 	}
 
 	reconnect->active = true;
-
-	if (!reconnect->start)
-		reconnect->start = time(NULL);
+	reconnect->attempt++;
 
 	return FALSE;
 }
 
+static void reconnect_set_timer(struct reconnect_data *reconnect)
+{
+	static int timeout = 0;
+
+	if (reconnect->attempt < reconnect_intervals_len)
+		timeout = reconnect_intervals[reconnect->attempt];
+
+	DBG("%d seconds", timeout);
+
+	reconnect->timer = g_timeout_add_seconds(timeout, reconnect_timeout,
+								reconnect);
+}
+
 static void disconnect_cb(struct btd_device *dev, uint8_t reason)
 {
 	struct reconnect_data *reconnect;
@@ -699,15 +708,12 @@ static void disconnect_cb(struct btd_device *dev, uint8_t reason)
 	DBG("Device %s identified for auto-reconnection",
 							device_get_path(dev));
 
-	reconnect->timer = g_timeout_add_seconds(reconnect->timeout,
-							reconnect_timeout,
-							reconnect);
+	reconnect_set_timer(reconnect);
 }
 
 static void conn_fail_cb(struct btd_device *dev, uint8_t status)
 {
 	struct reconnect_data *reconnect;
-	time_t duration;
 
 	DBG("status %u", status);
 
@@ -726,16 +732,13 @@ static void conn_fail_cb(struct btd_device *dev, uint8_t status)
 		return;
 	}
 
-	/* Give up if we've tried for too long */
-	duration = time(NULL) - reconnect->start;
-	if (duration + reconnect->timeout >= RECONNECT_GIVE_UP) {
+	/* Reset if ReconnectAttempts was reached */
+	if (reconnect->attempt == reconnect_attempts) {
 		reconnect_reset(reconnect);
 		return;
 	}
 
-	reconnect->timer = g_timeout_add_seconds(reconnect->timeout,
-							reconnect_timeout,
-							reconnect);
+	reconnect_set_timer(reconnect);
 }
 
 static int policy_init(void)
@@ -748,6 +751,11 @@ static int policy_init(void)
 	conf = btd_get_main_conf();
 	if (!conf) {
 		reconnect_uuids = g_strdupv((char **) default_reconnect);
+		reconnect_attempts = default_attempts;
+		reconnect_intervals_len = sizeof(default_intervals) /
+						sizeof(*reconnect_intervals);
+		reconnect_intervals = g_memdup(default_intervals,
+						reconnect_intervals_len);
 		goto add_cb;
 	}
 
@@ -755,12 +763,31 @@ static int policy_init(void)
 							"ReconnectUUIDs",
 							NULL, &gerr);
 	if (gerr) {
-		g_error_free(gerr);
+		g_clear_error(&gerr);
 		reconnect_uuids = g_strdupv((char **) default_reconnect);
-		goto add_cb;
 	}
+
+	reconnect_attempts = g_key_file_get_integer(conf, "Policy",
+							"ReconnectAttempts",
+							&gerr);
+	if (gerr) {
+		g_clear_error(&gerr);
+		reconnect_attempts = default_attempts;
+	}
+
+	reconnect_intervals = g_key_file_get_integer_list(conf, "Policy",
+					"ReconnectIntervals",
+					(size_t *) &reconnect_intervals_len,
+					&gerr);
+	if (gerr) {
+		g_clear_error(&gerr);
+		reconnect_intervals_len = sizeof(default_intervals);
+		reconnect_intervals = g_memdup(default_intervals,
+						reconnect_intervals_len);
+	}
+
 add_cb:
-	if (reconnect_uuids && reconnect_uuids[0]) {
+	if (reconnect_uuids && reconnect_uuids[0] && reconnect_attempts) {
 		btd_add_disconnect_cb(disconnect_cb);
 		btd_add_conn_fail_cb(conn_fail_cb);
 	}
@@ -776,6 +803,8 @@ static void policy_exit(void)
 	if (reconnect_uuids)
 		g_strfreev(reconnect_uuids);
 
+	g_free(reconnect_intervals);
+
 	g_slist_free_full(reconnects, reconnect_destroy);
 
 	g_slist_free_full(devices, policy_remove);
diff --git a/src/main.conf b/src/main.conf
index 2e696ff..11db383 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -74,3 +74,13 @@
 # default, but this list can be overridden here. By setting the list to
 # empty the reconnection feature gets disabled.
 #ReconnectUUIDs=00001112-0000-1000-8000-00805f9b34fb, 0000111f-0000-1000-8000-00805f9b34fb, 0000110a-0000-1000-8000-00805f9b34fb
+
+# ReconnectAttempts define the number of attempts to reconnect after a link
+# lost. Setting the value to 0 disables reconnecting feature.
+#ReconnectAttempts=7
+
+# ReconnectIntervals define the set of intervals in seconds to use in between
+# attempts.
+# If the number of attempts defined in ReconnectAttempts is bigger than the
+# set of intervals the last interval is repeated until the last attempt.
+#ReconnectIntervals=1, 2, 4, 8, 16, 32, 64
-- 
2.1.0

