Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/4] audio/control: Mark all methods of MediaControl1 as deprecated
Date: Tue, 29 Sep 2015 16:45:30 +0300
Message-Id: <1443534331-27997-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1443534331-27997-1-git-send-email-luiz.dentz@gmail.com>
References: <1443534331-27997-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

MediaControl1 is deprecated according to its documentation.
---
 profiles/audio/control.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/profiles/audio/control.c b/profiles/audio/control.c
index f4656d8..d109d1f 100644
--- a/profiles/audio/control.c
+++ b/profiles/audio/control.c
@@ -216,15 +216,17 @@ static gboolean control_property_get_connected(
 }
 
 static const GDBusMethodTable control_methods[] = {
-	{ GDBUS_METHOD("Play", NULL, NULL, control_play) },
-	{ GDBUS_METHOD("Pause", NULL, NULL, control_pause) },
-	{ GDBUS_METHOD("Stop", NULL, NULL, control_stop) },
-	{ GDBUS_METHOD("Next", NULL, NULL, control_next) },
-	{ GDBUS_METHOD("Previous", NULL, NULL, control_previous) },
-	{ GDBUS_METHOD("VolumeUp", NULL, NULL, control_volume_up) },
-	{ GDBUS_METHOD("VolumeDown", NULL, NULL, control_volume_down) },
-	{ GDBUS_METHOD("FastForward", NULL, NULL, control_fast_forward) },
-	{ GDBUS_METHOD("Rewind", NULL, NULL, control_rewind) },
+	{ GDBUS_DEPRECATED_METHOD("Play", NULL, NULL, control_play) },
+	{ GDBUS_DEPRECATED_METHOD("Pause", NULL, NULL, control_pause) },
+	{ GDBUS_DEPRECATED_METHOD("Stop", NULL, NULL, control_stop) },
+	{ GDBUS_DEPRECATED_METHOD("Next", NULL, NULL, control_next) },
+	{ GDBUS_DEPRECATED_METHOD("Previous", NULL, NULL, control_previous) },
+	{ GDBUS_DEPRECATED_METHOD("VolumeUp", NULL, NULL, control_volume_up) },
+	{ GDBUS_DEPRECATED_METHOD("VolumeDown", NULL, NULL,
+							control_volume_down) },
+	{ GDBUS_DEPRECATED_METHOD("FastForward", NULL, NULL,
+							control_fast_forward) },
+	{ GDBUS_DEPRECATED_METHOD("Rewind", NULL, NULL, control_rewind) },
 	{ }
 };
 
-- 
2.4.3

