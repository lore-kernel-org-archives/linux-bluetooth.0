Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] Mark Headset.Play method deprecated
Date: Mon, 27 Jun 2011 12:25:54 +0300
Message-Id: <1309166754-6473-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

SCO socket should be connected using either unix socket ipc or Media API
---
 audio/headset.c   |    3 ++-
 doc/audio-api.txt |    2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/audio/headset.c b/audio/headset.c
index 2864257..664f393 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -2060,7 +2060,8 @@ static GDBusMethodTable headset_methods[] = {
 	{ "IndicateCall",	"",	"",	hs_ring },
 	{ "CancelCall",		"",	"",	hs_cancel_call },
 	{ "Play",		"",	"",	hs_play,
-						G_DBUS_METHOD_FLAG_ASYNC },
+						G_DBUS_METHOD_FLAG_ASYNC |
+						G_DBUS_METHOD_FLAG_DEPRECATED },
 	{ "Stop",		"",	"",	hs_stop },
 	{ "IsPlaying",		"",	"b",	hs_is_playing,
 						G_DBUS_METHOD_FLAG_DEPRECATED },
diff --git a/doc/audio-api.txt b/doc/audio-api.txt
index d2f3996..0cf7884 100644
--- a/doc/audio-api.txt
+++ b/doc/audio-api.txt
@@ -81,7 +81,7 @@ Methods		void Connect()
 
 			Cancel the incoming call indication.
 
-		void Play()
+		void Play() {deprecated}
 
 			Open the audio connection to the headset.
 
-- 
1.7.5.4

