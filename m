Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 10/13] media-api: Change RegisterPlayer to use MPRIS spec
Date: Thu, 10 Jan 2013 15:24:40 +0200
Message-Id: <1357824283-19233-13-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1357824283-19233-1-git-send-email-luiz.dentz@gmail.com>
References: <1357824283-19233-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

RegisterPlayer now expect registered paths to implement
org.mpris.MediaPlayer2.player interface accourding to MPRIS spec:

http://specifications.freedesktop.org/mpris-spec/latest/
---
 doc/media-api.txt | 70 ++++---------------------------------------------------
 1 file changed, 5 insertions(+), 65 deletions(-)

diff --git a/doc/media-api.txt b/doc/media-api.txt
index d3bd915..714e87c 100644
--- a/doc/media-api.txt
+++ b/doc/media-api.txt
@@ -45,78 +45,18 @@ Methods		void RegisterEndpoint(object endpoint, dict properties)
 
 			Unregister sender end point.
 
-		void RegisterPlayer(object player, dict properties,
-								dict metadata)
+		void RegisterPlayer(object player, dict properties)
 
 			Register a media player object to sender, the sender
 			can register as many objects as it likes.
 
+			Object must implement at least
+			org.mpris.MediaPlayer2.Player as defined in MPRIS 2.2
+			spec.
+
 			Note: If the sender disconnects its objects are
 			automatically unregistered.
 
-			Properties:
-
-				string Equalizer:
-
-					Possible values: "off" or "on"
-
-				string Repeat:
-
-					Possible values: "off", "singletrack",
-							"alltracks" or "group"
-
-				string Shuffle:
-
-					Possible values: "off", "alltracks" or
-							"group"
-
-				string Scan:
-
-					Possible values: "off", "alltracks" or
-							"group"
-
-				string Status:
-
-					Possible values: "playing", "stopped",
-							"paused",
-							"forward-seek",
-							"reverse-seek" or
-							"error"
-
-				uint32 Position
-
-					Playback position in milliseconds
-
-			Metadata:
-
-				string Title:
-
-					Track title name
-
-				string Artist:
-
-					Track artist name
-
-				string Album:
-
-					Track album name
-
-				string Genre:
-
-					Track genre name
-
-				uint32 NumberOfTracks:
-
-					Number of tracks in total
-
-				uint32 Number:
-
-					Track number
-
-				uint32 Duration:
-
-					Track duration in milliseconds
-
 			Possible Errors: org.bluez.Error.InvalidArguments
 					 org.bluez.Error.NotSupported
 
-- 
1.8.0.1

