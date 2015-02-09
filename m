Return-Path: <cyrus@holtmann.org>
From: Sagar Nageshmurthy <s.nageshmurt@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sagar Nageshmurthy <s.nageshmurt@samsung.com>
Subject: [PATCH 1/1] doc/media-api: Add RegisterTrackList method
Date: Mon, 09 Feb 2015 11:21:15 +0530
Message-id: <1423461075-13898-1-git-send-email-s.nageshmurt@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Provides access to a short list of tracks which were recently played
or will be played shortly.
---
 doc/media-api.txt |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/doc/media-api.txt b/doc/media-api.txt
index b17a151..9830136 100644
--- a/doc/media-api.txt
+++ b/doc/media-api.txt
@@ -62,6 +62,21 @@ Methods		void RegisterEndpoint(object endpoint, dict properties)
 			Possible Errors: org.bluez.Error.InvalidArguments
 					 org.bluez.Error.NotSupported
 
+		void RegisterTrackList(object player, dict properties)
+
+			Register a media player object to TrackList interface.
+
+			Object must be registered to sender using
+			RegisterPlayer.
+
+			Object must implement org.mpris.MediaPlayer2.TrackList
+			as defined in MPRIS 2.2 spec:
+
+			http://specifications.freedesktop.org/mpris-spec/latest/
+
+			Possible Errors: org.bluez.Error.NotAuthorized
+					 org.bluez.Error.InvalidArguments
+
 		void UnregisterPlayer(object player)
 
 			Unregister sender media player.
-- 
1.7.9.5

