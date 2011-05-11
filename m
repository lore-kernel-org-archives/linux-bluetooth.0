Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Fix not indicating audio connection problems on Headset interface
Date: Wed, 11 May 2011 18:15:29 +0300
Message-Id: <1305126930-1926-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

There is no D-Bus signal when attempting to connect SCO leaving
application unable to detect any problem if they were not directly using
Media API or unix socket.
---
 audio/headset.c   |    9 ++++++---
 doc/audio-api.txt |    7 +++++--
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/audio/headset.c b/audio/headset.c
index 1a3c365..b28667e 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -276,8 +276,9 @@ static const char *state2str(headset_state_t state)
 	case HEADSET_STATE_CONNECTING:
 		return "connecting";
 	case HEADSET_STATE_CONNECTED:
-	case HEADSET_STATE_PLAY_IN_PROGRESS:
 		return "connected";
+	case HEADSET_STATE_PLAY_IN_PROGRESS:
+		return "resuming";
 	case HEADSET_STATE_PLAYING:
 		return "playing";
 	}
@@ -2522,8 +2523,7 @@ void headset_set_state(struct audio_device *dev, headset_state_t state)
 		break;
 	case HEADSET_STATE_CONNECTED:
 		close_sco(dev);
-		if (hs->state != HEADSET_STATE_PLAY_IN_PROGRESS)
-			emit_property_changed(dev->conn, dev->path,
+		emit_property_changed(dev->conn, dev->path,
 					AUDIO_HEADSET_INTERFACE, "State",
 					DBUS_TYPE_STRING, &state_str);
 		if (hs->state < state) {
@@ -2555,6 +2555,9 @@ void headset_set_state(struct audio_device *dev, headset_state_t state)
 		}
 		break;
 	case HEADSET_STATE_PLAY_IN_PROGRESS:
+		emit_property_changed(dev->conn, dev->path,
+					AUDIO_HEADSET_INTERFACE, "State",
+					DBUS_TYPE_STRING, &state_str);
 		break;
 	case HEADSET_STATE_PLAYING:
 		value = TRUE;
diff --git a/doc/audio-api.txt b/doc/audio-api.txt
index e7991f3..1eed843 100644
--- a/doc/audio-api.txt
+++ b/doc/audio-api.txt
@@ -164,7 +164,7 @@ Signals		void AnswerRequested()
 properties	string State [readonly]
 
 			Possible values: "disconnected", "connecting",
-			"connected", "playing"
+			"connected", "resuming", "playing"
 
 			"disconnected" -> "connecting"
 				Either an incoming or outgoing connection
@@ -176,7 +176,10 @@ properties	string State [readonly]
 			"connecting" -> "connected"
 				Successfully connected
 
-			"connected" -> "playing"
+			"resuming" -> "connected"
+				SCO connection attempt failed
+
+			"resuming" -> "playing"
 				SCO audio connection successfully opened
 
 			"playing" -> "connected"
-- 
1.7.1

