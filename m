Return-Path: <cyrus@holtmann.org>
From: Bharat Panda <bharat.panda@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: cpgs@samsung.com, Bharat Panda <bharat.panda@samsung.com>
Subject: [PATCH ] profiles/audio: Fix bluetoothd crash in a2dp
Date: Wed, 29 Oct 2014 15:33:35 +0530
Message-id: <1414577015-11215-1-git-send-email-bharat.panda@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Checks for NULL session before calling avdtp_get_device, as
setup->session will be NULL if configuraion was aborted.
---
 profiles/audio/a2dp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index c9dac9a..810d1e6 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -379,7 +379,7 @@ static void stream_state_changed(struct avdtp_stream *stream,
 static gboolean auto_config(gpointer data)
 {
 	struct a2dp_setup *setup = data;
-	struct btd_device *dev = avdtp_get_device(setup->session);
+	struct btd_device *dev = NULL;
 	struct btd_service *service;
 
 	/* Check if configuration was aborted */
@@ -389,6 +389,10 @@ static gboolean auto_config(gpointer data)
 	if (setup->err != NULL)
 		goto done;
 
+	/* session will be NULL if configuration was aborted */
+	if (setup->session)
+		dev = avdtp_get_device(setup->session);
+
 	avdtp_stream_add_cb(setup->session, setup->stream,
 				stream_state_changed, setup->sep);
 
-- 
1.9.1

