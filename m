Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH 5/5] Add fast connectable support to HFP
Date: Wed, 18 Aug 2010 13:36:00 +0300
Message-Id: <1282127760-12655-6-git-send-email-dmitriy.paliy@nokia.com>
In-Reply-To: <1282127760-12655-1-git-send-email-dmitriy.paliy@nokia.com>
References: <1282127760-12655-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Audio.conf is updated to support fast connectable mode. Set
FastConnectable to true to enable and to false to disable. Headset
initialization and call indicators are updated respectively. It is
disabled by default.
---
 audio/audio.conf |    7 +++++++
 audio/headset.c  |   20 ++++++++++++++++++++
 2 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/audio/audio.conf b/audio/audio.conf
index a64fb66..302e046 100644
--- a/audio/audio.conf
+++ b/audio/audio.conf
@@ -32,6 +32,13 @@ HFP=true
 # Maximum number of connected HSP/HFP devices per adapter. Defaults to 1
 MaxConnected=1
 
+# Set to true to enable use of fast connectable mode (faster page scanning)
+# for HFP when incomming call starts. Default settings are restored after
+# call is answered or rejected. Page scan interval is much shorter and page
+# scan type changed to interlaced. Such allows faster connection initiated
+# by a headset.
+FastConnectable=false
+
 # Just an example of potential config options for the other interfaces
 #[A2DP]
 #SBCSources=1
diff --git a/audio/headset.c b/audio/headset.c
index 99d4c7a..cdb3370 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -95,6 +95,7 @@ static struct {
 };
 
 static gboolean sco_hci = TRUE;
+static gboolean fast_connectable = FALSE;
 
 static GSList *active_devices = NULL;
 
@@ -2262,6 +2263,19 @@ uint32_t headset_config_init(GKeyFile *config)
 		g_free(str);
 	}
 
+	/* Init fast connectable option */
+	str = g_key_file_get_string(config, "Headset", "FastConnectable",
+					&err);
+	if (err) {
+		DBG("audio.conf: %s", err->message);
+		g_clear_error(&err);
+	} else {
+		fast_connectable = strcmp(str, "true") == 0;
+		if (fast_connectable)
+			manager_set_fast_connectable(FALSE);
+		g_free(str);
+	}
+
 	return ag.features;
 }
 
@@ -2743,6 +2757,9 @@ int telephony_incoming_call_ind(const char *number, int type)
 	struct headset *hs;
 	struct headset_slc *slc;
 
+	if (fast_connectable)
+		manager_set_fast_connectable(TRUE);
+
 	if (!active_devices)
 		return -ENODEV;
 
@@ -2782,6 +2799,9 @@ int telephony_calling_stopped_ind(void)
 {
 	struct audio_device *dev;
 
+	if (fast_connectable)
+		manager_set_fast_connectable(FALSE);
+
 	if (ag.ring_timer) {
 		g_source_remove(ag.ring_timer);
 		ag.ring_timer = 0;
-- 
1.7.0.4

