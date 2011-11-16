Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 17/17] Fix return value check for bt_audio_service_open()
Date: Wed, 16 Nov 2011 09:20:04 -0400
Message-Id: <1321449604-4188-18-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1321449604-4188-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1321449604-4188-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Only negative values (namely -1) are errors for this function.
---
 audio/gstavdtpsink.c  |    2 +-
 audio/pcm_bluetooth.c |    2 +-
 test/ipctest.c        |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/audio/gstavdtpsink.c b/audio/gstavdtpsink.c
index f379469..dca9d67 100644
--- a/audio/gstavdtpsink.c
+++ b/audio/gstavdtpsink.c
@@ -1448,7 +1448,7 @@ static gboolean gst_avdtp_sink_start(GstBaseSink *basesink)
 	self->watch_id = 0;
 
 	sk = bt_audio_service_open();
-	if (sk <= 0) {
+	if (sk < 0) {
 		err = -errno;
 		GST_ERROR_OBJECT(self, "Cannot open connection to bt "
 			"audio service: %s %d", strerror(-err), -err);
diff --git a/audio/pcm_bluetooth.c b/audio/pcm_bluetooth.c
index 4d85f33..85566a3 100644
--- a/audio/pcm_bluetooth.c
+++ b/audio/pcm_bluetooth.c
@@ -1666,7 +1666,7 @@ static int bluetooth_init(struct bluetooth_data *data,
 	data->stream.fd = -1;
 
 	sk = bt_audio_service_open();
-	if (sk <= 0) {
+	if (sk < 0) {
 		err = -errno;
 		goto failed;
 	}
diff --git a/test/ipctest.c b/test/ipctest.c
index 4968443..cbfd78d 100644
--- a/test/ipctest.c
+++ b/test/ipctest.c
@@ -214,7 +214,7 @@ static int init_bt(struct userdata *u)
 	DBG("bt_audio_service_open");
 
 	u->service_fd = bt_audio_service_open();
-	if (u->service_fd <= 0) {
+	if (u->service_fd < 0) {
 		int err = -errno;
 
 		ERR("bt_audio_service_open() failed: %s (%d)", strerror(-err),
-- 
1.7.0.4

