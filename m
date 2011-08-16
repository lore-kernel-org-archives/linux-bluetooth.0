Return-Path: <cyrus@holtmann.org>
From: Prasad Bhat <prasadbhat22@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 6/6] This adds video_sink and video_source to audio_device.
Date: Tue, 16 Aug 2011 19:13:58 +0530
Message-Id: <1313502238-7581-6-git-send-email-prasadbhat22@gmail.com>
In-Reply-To: <1313502238-7581-1-git-send-email-prasadbhat22@gmail.com>
References: <1313502238-7581-1-git-send-email-prasadbhat22@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/device.h |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/audio/device.h b/audio/device.h
index 5117fca..661f112 100644
--- a/audio/device.h
+++ b/audio/device.h
@@ -38,6 +38,11 @@
 #define AVRCP_REMOTE_UUID	"0000110e-0000-1000-8000-00805f9b34fb"
 #define AVRCP_TARGET_UUID	"0000110c-0000-1000-8000-00805f9b34fb"
 
+#define VIDEO_DISTRIBUTION_UUID "00001305-0000-1000-8000-00805f9b34fb"
+
+#define VDP_SOURCE_UUID	"00001303-0000-1000-8000-00805f9b34fb"
+#define VDP_SINK_UUID		"00001304-0000-1000-8000-00805f9b34fb"
+
 struct source;
 struct control;
 struct target;
@@ -62,6 +67,8 @@ struct audio_device {
 	struct source *source;
 	struct control *control;
 	struct target *target;
+	struct video_sink *video_sink;
+	struct video_source *video_source;
 
 	guint hs_preauth_id;
 
-- 
1.7.6

