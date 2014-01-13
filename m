Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 04/12] audio/A2DP: Add implemention of SEP suspend indication
Date: Mon, 13 Jan 2014 19:32:05 +0200
Message-Id: <1389634333-25870-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1389634333-25870-1-git-send-email-luiz.dentz@gmail.com>
References: <1389634333-25870-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/a2dp.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/android/a2dp.c b/android/a2dp.c
index 1b12767..a483514 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -667,12 +667,35 @@ static gboolean sep_start_ind(struct avdtp *session,
 	return TRUE;
 }
 
+static gboolean sep_suspend_ind(struct avdtp *session,
+						struct avdtp_local_sep *sep,
+						struct avdtp_stream *stream,
+						uint8_t *err,
+						void *user_data)
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
 	.open			= sep_open_ind,
 	.close			= sep_close_ind,
 	.start			= sep_start_ind,
+	.suspend		= sep_suspend_ind,
 };
 
 static uint8_t register_endpoint(const uint8_t *uuid, uint8_t codec,
-- 
1.8.4.2

