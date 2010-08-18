Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH 4/5] Add set fast connectable to audio manager
Date: Wed, 18 Aug 2010 13:35:59 +0300
Message-Id: <1282127760-12655-5-git-send-email-dmitriy.paliy@nokia.com>
In-Reply-To: <1282127760-12655-1-git-send-email-dmitriy.paliy@nokia.com>
References: <1282127760-12655-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Set fast connectable added to audio manager interface. Enables
fast connectable mode for all audio adapters or sets respective
values to default when disabled. It does not interfere with any
other audio manager's interfaces, modes, or states.
---
 audio/manager.c |   14 ++++++++++++++
 audio/manager.h |    4 ++++
 2 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/audio/manager.c b/audio/manager.c
index 6dd0f87..3db5987 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -1290,3 +1290,17 @@ gboolean manager_allow_headset_connection(struct audio_device *device)
 
 	return TRUE;
 }
+
+void manager_set_fast_connectable(gboolean enable)
+{
+	GSList *l;
+
+	for (l = adapters; l != NULL; l = l->next) {
+		struct audio_adapter *adapter = l->data;
+
+		if (btd_adapter_set_fast_connectable(adapter->btd_adapter,
+								enable))
+			error("Changing fast connectable for hci%d failed",
+				adapter_get_dev_id(adapter->btd_adapter));
+	}
+}
diff --git a/audio/manager.h b/audio/manager.h
index 8e1abf4..90fe6f0 100644
--- a/audio/manager.h
+++ b/audio/manager.h
@@ -48,3 +48,7 @@ struct audio_device *manager_get_device(const bdaddr_t *src,
 					gboolean create);
 
 gboolean manager_allow_headset_connection(struct audio_device *device);
+
+/* TRUE to enable fast connectable and FALSE to disable fast connectable for all
+ * audio adapters. */
+void manager_set_fast_connectable(gboolean enable);
-- 
1.7.0.4

