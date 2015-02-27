Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC] android/avdtp: Move bluetooth service code to callback
Date: Fri, 27 Feb 2015 10:45:29 +0200
Message-Id: <1425026729-11189-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Move bluetooth device and service code out of avdtp. The code would be
run from endpoint_setconf_ind() callback.
---
 profiles/audio/a2dp.c  | 29 +++++++++++++++++++++++++++++
 profiles/audio/avdtp.c | 32 --------------------------------
 2 files changed, 29 insertions(+), 32 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 03eeaba..ed69c7b 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -452,7 +452,9 @@ static gboolean endpoint_setconf_ind(struct avdtp *session,
 						avdtp_set_configuration_cb cb,
 						void *user_data)
 {
+	struct btd_device *device = avdtp_get_device(session);
 	struct a2dp_sep *a2dp_sep = user_data;
+	struct btd_service *service;
 	struct a2dp_setup *setup;
 
 	if (a2dp_sep->type == AVDTP_SEP_TYPE_SINK)
@@ -460,6 +462,33 @@ static gboolean endpoint_setconf_ind(struct avdtp *session,
 	else
 		DBG("Source %p: Set_Configuration_Ind", sep);
 
+	switch (a2dp_sep->type) {
+	case AVDTP_SEP_TYPE_SOURCE:
+		service = btd_device_get_service(device, A2DP_SINK_UUID);
+		if (service == NULL) {
+			btd_device_add_uuid(device, A2DP_SINK_UUID);
+			service = btd_device_get_service(device,
+							A2DP_SINK_UUID);
+			if (service == NULL) {
+				error("Unable to get a audio sink object");
+				return FALSE;
+			}
+		}
+		break;
+	case AVDTP_SEP_TYPE_SINK:
+		service = btd_device_get_service(device, A2DP_SOURCE_UUID);
+		if (service == NULL) {
+			btd_device_add_uuid(device, A2DP_SOURCE_UUID);
+			service = btd_device_get_service(device,
+							A2DP_SOURCE_UUID);
+			if (service == NULL) {
+				error("Unable to get a audio source object");
+				return FALSE;
+			}
+		}
+		break;
+	}
+
 	setup = a2dp_setup_get(session);
 	if (!session)
 		return FALSE;
diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index a8444ed..725a3e1 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -1441,7 +1441,6 @@ static gboolean avdtp_setconf_cmd(struct avdtp *session, uint8_t transaction,
 	struct avdtp_local_sep *sep;
 	struct avdtp_stream *stream;
 	uint8_t err, category = 0x00;
-	struct btd_service *service;
 	GSList *l;
 
 	DBG("");
@@ -1462,37 +1461,6 @@ static gboolean avdtp_setconf_cmd(struct avdtp *session, uint8_t transaction,
 		goto failed;
 	}
 
-	switch (sep->info.type) {
-	case AVDTP_SEP_TYPE_SOURCE:
-		service = btd_device_get_service(session->device,
-							A2DP_SINK_UUID);
-		if (service == NULL) {
-			btd_device_add_uuid(session->device, A2DP_SINK_UUID);
-			service = btd_device_get_service(session->device,
-							A2DP_SINK_UUID);
-			if (service == NULL) {
-				error("Unable to get a audio sink object");
-				err = AVDTP_BAD_STATE;
-				goto failed;
-			}
-		}
-		break;
-	case AVDTP_SEP_TYPE_SINK:
-		service = btd_device_get_service(session->device,
-							A2DP_SOURCE_UUID);
-		if (service == NULL) {
-			btd_device_add_uuid(session->device, A2DP_SOURCE_UUID);
-			service = btd_device_get_service(session->device,
-							A2DP_SOURCE_UUID);
-			if (service == NULL) {
-				error("Unable to get a audio source object");
-				err = AVDTP_BAD_STATE;
-				goto failed;
-			}
-		}
-		break;
-	}
-
 	stream = g_new0(struct avdtp_stream, 1);
 	stream->session = session;
 	stream->lsep = sep;
-- 
2.1.0

