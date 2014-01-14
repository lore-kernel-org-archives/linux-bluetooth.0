Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ v2 07/12] audio/A2DP: Add implemention of SEP open confirmation
Date: Tue, 14 Jan 2014 12:42:43 +0200
Message-Id: <1389696168-26947-7-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1389696168-26947-1-git-send-email-luiz.dentz@gmail.com>
References: <1389696168-26947-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/a2dp.c | 56 ++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 42 insertions(+), 14 deletions(-)

diff --git a/android/a2dp.c b/android/a2dp.c
index afc6331..59f8bf5 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -657,6 +657,33 @@ static void setup_remove(struct a2dp_setup *setup)
 	setup_free(setup);
 }
 
+static struct a2dp_setup *find_setup(uint8_t id)
+{
+	GSList *l;
+
+	for (l = setups; l; l = g_slist_next(l)) {
+		struct a2dp_setup *setup = l->data;
+
+		if (setup->endpoint->id == id)
+			return setup;
+	}
+
+	return NULL;
+}
+
+static void setup_remove_by_id(uint8_t id)
+{
+	struct a2dp_setup *setup;
+
+	setup = find_setup(id);
+	if (!setup) {
+		error("Unable to find stream setup for endpoint %u", id);
+		return;
+	}
+
+	setup_remove(setup);
+}
+
 static gboolean sep_setconf_ind(struct avdtp *session,
 						struct avdtp_local_sep *sep,
 						struct avdtp_stream *stream,
@@ -711,20 +738,6 @@ static gboolean sep_setconf_ind(struct avdtp *session,
 	return TRUE;
 }
 
-static struct a2dp_setup *find_setup(uint8_t id)
-{
-	GSList *l;
-
-	for (l = setups; l; l = g_slist_next(l)) {
-		struct a2dp_setup *setup = l->data;
-
-		if (setup->endpoint->id == id)
-			return setup;
-	}
-
-	return NULL;
-}
-
 static gboolean sep_open_ind(struct avdtp *session, struct avdtp_local_sep *sep,
 				struct avdtp_stream *stream, uint8_t *err,
 				void *user_data)
@@ -854,8 +867,23 @@ failed:
 	setup_remove(setup);
 }
 
+static void sep_open_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
+			struct avdtp_stream *stream, struct avdtp_error *err,
+			void *user_data)
+{
+	struct a2dp_endpoint *endpoint = user_data;
+
+	DBG("");
+
+	if (!err)
+		return;
+
+	setup_remove_by_id(endpoint->id);
+}
+
 static struct avdtp_sep_cfm sep_cfm = {
 	.set_configuration	= sep_setconf_cfm,
+	.open			= sep_open_cfm,
 };
 
 static uint8_t register_endpoint(const uint8_t *uuid, uint8_t codec,
-- 
1.8.4.2

