Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 2/2] android/a2dp: Fix freeing preset on SEP close
Date: Tue, 14 Jan 2014 17:16:19 +0100
Message-ID: <1389716179-21874-2-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1389716179-21874-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1389716179-21874-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In case SEP was opened from local side, corresponding a2dp_setup
structure has just reference to a2dp_preset which is stored on presets
list. As a result, when closing SEP such preset will be freed leaving
dangling pointer on presets list.

This patch duplicates a2dp_preset in such case so it can be freed
safely.
---
 android/a2dp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/android/a2dp.c b/android/a2dp.c
index 145cd67..63629a0 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -266,6 +266,7 @@ static int select_configuration(struct a2dp_device *dev,
 				struct avdtp_remote_sep *rsep)
 {
 	struct a2dp_preset *preset;
+	struct a2dp_preset *preset_dup;
 	struct avdtp_stream *stream;
 	struct avdtp_service_capability *service;
 	struct avdtp_media_codec_capability *codec;
@@ -298,7 +299,11 @@ static int select_configuration(struct a2dp_device *dev,
 		return err;
 	}
 
-	setup_add(dev, endpoint, preset, stream);
+	preset_dup = g_new0(struct a2dp_preset, 1);
+	preset_dup->len = preset->len;
+	preset_dup->data = g_memdup(preset->data, preset->len);
+
+	setup_add(dev, endpoint, preset_dup, stream);
 
 	return 0;
 }
-- 
1.8.5.2

