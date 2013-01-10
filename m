Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 01/13 v2] media-api: Add playback control methods to MediaPlayer1
Date: Thu, 10 Jan 2013 15:37:06 +0200
Message-Id: <1357825038-21970-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds methods such as Play, Pause directly in MediaPlayer1, in
addition to that Track is now turn into a property to take advantage of
ObjectManager and document the interface as experimental.
---
v2: Fix removing experimental flags, add patches to mpris-player and remove
VolumeUp and VolumeDown as they don't make sense to controller to send them.

 doc/media-api.txt | 99 +++++++++++++++++++++++++++++--------------------------
 1 file changed, 53 insertions(+), 46 deletions(-)

diff --git a/doc/media-api.txt b/doc/media-api.txt
index bb5ced0..ae4b0dd 100644
--- a/doc/media-api.txt
+++ b/doc/media-api.txt
@@ -129,7 +129,7 @@ Media Control hierarchy
 =======================
 
 Service		org.bluez
-Interface	org.bluez.MediaControl1
+Interface	org.bluez.MediaControl1 [Deprecated]
 Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
 
 Methods		void Play()
@@ -178,65 +178,39 @@ Properties
 MediaPlayer1 hierarchy
 ======================
 
-Service		unique name (Target role)
-Interface	org.bluez.MediaPlayer1
-Object path	freely definable
-
 Service		org.bluez (Controller role)
-Interface	org.bluez.MediaPlayer1
+Interface	org.bluez.MediaPlayer1 [Experimental]
 Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/playerX
 
-Methods		dict GetTrack()
-
-			Returns known metadata of the current track.
-
-			See TrackChanged for possible values.
-
-		void Release()
-
-			This method gets called when the service daemon
-			unregisters the player which can then perform
-			cleanup tasks. There is no need to unregister the
-			player, because when this method gets called it has
-			already been unregistered.
-
-Signals		TrackChanged(dict metadata)
-
-			This signal indicates that current track has changed.
-			All available metadata for the new track shall be set
-			at once in the metadata argument. Metadata cannot be
-			updated in parts, otherwise it will be interpreted as
-			multiple track changes.
-
-			Possible values:
-
-				string Title:
+Methods		void Play()
 
-					Track title name
+			Resume playback.
 
-				string Artist:
+		void Pause()
 
-					Track artist name
+			Pause playback.
 
-				string Album:
+		void Stop()
 
-					Track album name
+			Stop playback.
 
-				string Genre:
+		void Next()
 
-					Track genre name
+			Next item.
 
-				uint32 NumberOfTracks:
+		void Previous()
 
-					Number of tracks in total
+			Previous item.
 
-				uint32 Number:
+		void FastForward()
 
-					Track number
+			Fast forward playback, this action is only stopped
+			when another method in this interface is called.
 
-				uint32 Duration:
+		void Rewind()
 
-					Track duration in milliseconds
+			Rewind playback, this action is only stopped
+			when another method in this interface is called.
 
 Properties	string Equalizer [readwrite]
 
@@ -258,8 +232,8 @@ Properties	string Equalizer [readwrite]
 		string Status [readonly]
 
 			Possible status: "playing", "stopped", "paused",
-					"forward-seek", "reverse-seek" or
-					"error"
+					"forward-seek", "reverse-seek"
+					or "error"
 
 		uint32 Position [readonly]
 
@@ -272,6 +246,39 @@ Properties	string Equalizer [readwrite]
 			possible to signal its end by setting position to the
 			maximum uint32 value.
 
+		dict Track [readonly]
+
+			Track metadata.
+
+			Possible values:
+
+				string Title:
+
+					Track title name
+
+				string Artist:
+
+					Track artist name
+
+				string Album:
+
+					Track album name
+
+				string Genre:
+
+					Track genre name
+
+				uint32 NumberOfTracks:
+
+					Number of tracks in total
+
+				uint32 Number:
+
+					Track number
+
+				uint32 Duration:
+
+					Track duration in milliseconds
 
 MediaEndpoint1 hierarchy
 ========================
-- 
1.8.0.1

