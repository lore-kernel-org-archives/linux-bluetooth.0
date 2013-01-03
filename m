Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 6/8] control: Mark all members of MediaControl1 as deprecated
Date: Thu,  3 Jan 2013 21:46:09 +0200
Message-Id: <1357242371-6752-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1357242371-6752-1-git-send-email-luiz.dentz@gmail.com>
References: <1357242371-6752-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 profiles/audio/control.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/profiles/audio/control.c b/profiles/audio/control.c
index 642fdd5..70faab8 100644
--- a/profiles/audio/control.c
+++ b/profiles/audio/control.c
@@ -222,20 +222,23 @@ static gboolean control_property_get_connected(
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
 
 static const GDBusPropertyTable control_properties[] = {
-	{ "Connected", "b", control_property_get_connected },
+	{ "Connected", "b", control_property_get_connected, NULL, NULL,
+					G_DBUS_PROPERTY_FLAG_DEPRECATED },
 	{ }
 };
 
-- 
1.8.0.1

