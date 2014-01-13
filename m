Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 01/12] audio/A2DP: Add implemention of SEP open indication
Date: Mon, 13 Jan 2014 19:32:02 +0200
Message-Id: <1389634333-25870-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/a2dp.c | 49 +++++++++++++++++++++++++++++++++++--------------
 1 file changed, 35 insertions(+), 14 deletions(-)

diff --git a/android/a2dp.c b/android/a2dp.c
index 1f7678a..1a9adb8 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -581,9 +581,44 @@ static gboolean sep_setconf_ind(struct avdtp *session,
 	return TRUE;
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
+static gboolean sep_open_ind(struct avdtp *session, struct avdtp_local_sep *sep,
+				struct avdtp_stream *stream, uint8_t *err,
+				void *user_data)
+{
+	struct a2dp_endpoint *endpoint = user_data;
+	struct a2dp_setup *setup;
+
+	DBG("");
+
+	setup = find_setup(endpoint->id);
+	if (!setup) {
+		error("Unable to find stream setup for endpoint %u",
+								endpoint->id);
+		*err = AVDTP_SEP_NOT_IN_USE;
+		return FALSE;
+	}
+
+	return TRUE;
+}
+
 static struct avdtp_sep_ind sep_ind = {
 	.get_capability		= sep_getcap_ind,
 	.set_configuration	= sep_setconf_ind,
+	.open			= sep_open_ind,
 };
 
 static uint8_t register_endpoint(const uint8_t *uuid, uint8_t codec,
@@ -713,20 +748,6 @@ static void bt_audio_close(const void *buf, uint16_t len)
 	audio_ipc_send_rsp(AUDIO_OP_CLOSE, AUDIO_STATUS_SUCCESS);
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
 static void bt_stream_open(const void *buf, uint16_t len)
 {
 	const struct audio_cmd_open_stream *cmd = buf;
-- 
1.8.4.2

