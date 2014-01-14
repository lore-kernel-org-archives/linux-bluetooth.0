Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ v2 06/12] audio/A2DP: Add implemention of SEP set_configuration confirmation
Date: Tue, 14 Jan 2014 12:42:42 +0200
Message-Id: <1389696168-26947-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1389696168-26947-1-git-send-email-luiz.dentz@gmail.com>
References: <1389696168-26947-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/a2dp.c | 40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/android/a2dp.c b/android/a2dp.c
index 8d0884c..afc6331 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -822,6 +822,42 @@ static struct avdtp_sep_ind sep_ind = {
 	.suspend		= sep_suspend_ind,
 };
 
+static void sep_setconf_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
+				struct avdtp_stream *stream,
+				struct avdtp_error *err, void *user_data)
+{
+	struct a2dp_endpoint *endpoint = user_data;
+	struct a2dp_setup *setup;
+	int ret;
+
+	DBG("");
+
+	setup = find_setup(endpoint->id);
+	if (!setup) {
+		error("Unable to find stream setup for endpoint %u",
+								endpoint->id);
+		return;
+	}
+
+	if (err)
+		goto failed;
+
+	ret = avdtp_open(session, stream);
+	if (ret < 0) {
+		error("avdtp_open: %s", strerror(-ret));
+		goto failed;
+	}
+
+	return;
+
+failed:
+	setup_remove(setup);
+}
+
+static struct avdtp_sep_cfm sep_cfm = {
+	.set_configuration	= sep_setconf_cfm,
+};
+
 static uint8_t register_endpoint(const uint8_t *uuid, uint8_t codec,
 							GSList *presets)
 {
@@ -834,8 +870,8 @@ static uint8_t register_endpoint(const uint8_t *uuid, uint8_t codec,
 	endpoint->codec = codec;
 	endpoint->sep = avdtp_register_sep(AVDTP_SEP_TYPE_SOURCE,
 						AVDTP_MEDIA_TYPE_AUDIO,
-						codec, FALSE, &sep_ind, NULL,
-						endpoint);
+						codec, FALSE, &sep_ind,
+						&sep_cfm, endpoint);
 	endpoint->caps = presets->data;
 	endpoint->presets = g_slist_copy(g_slist_nth(presets, 1));
 
-- 
1.8.4.2

