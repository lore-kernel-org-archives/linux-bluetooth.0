Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 08/12] audio/A2DP: Add implemention of SEP start confirmation
Date: Mon, 13 Jan 2014 19:32:09 +0200
Message-Id: <1389634333-25870-8-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1389634333-25870-1-git-send-email-luiz.dentz@gmail.com>
References: <1389634333-25870-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/a2dp.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/android/a2dp.c b/android/a2dp.c
index a1d1bb8..0a316c3 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -881,9 +881,24 @@ static void sep_open_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 	setup_remove_by_id(endpoint->id);
 }
 
+static void sep_start_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
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
 	.open			= sep_open_cfm,
+	.start			= sep_start_cfm,
 };
 
 static uint8_t register_endpoint(const uint8_t *uuid, uint8_t codec,
-- 
1.8.4.2

