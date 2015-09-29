Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/4] doc/media-api: Add Player property to MediaControl1
Date: Tue, 29 Sep 2015 16:45:29 +0300
Message-Id: <1443534331-27997-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1443534331-27997-1-git-send-email-luiz.dentz@gmail.com>
References: <1443534331-27997-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Player property is use to inform the current addressed player which is
necessary in case more than one player is available.

This is also remove the deprecated status of MediaControl1 and instead
deprecated just its methods which similar functionality have been moved
to MediaPlayer1.
---
 doc/media-api.txt | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/doc/media-api.txt b/doc/media-api.txt
index b17a151..b5ad2db 100644
--- a/doc/media-api.txt
+++ b/doc/media-api.txt
@@ -71,43 +71,43 @@ Media Control hierarchy
 =======================
 
 Service		org.bluez
-Interface	org.bluez.MediaControl1 [Deprecated]
+Interface	org.bluez.MediaControl1
 Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
 
-Methods		void Play()
+Methods		void Play() [Deprecated]
 
 			Resume playback.
 
-		void Pause()
+		void Pause() [Deprecated]
 
 			Pause playback.
 
-		void Stop()
+		void Stop() [Deprecated]
 
 			Stop playback.
 
-		void Next()
+		void Next() [Deprecated]
 
 			Next item.
 
-		void Previous()
+		void Previous() [Deprecated]
 
 			Previous item.
 
-		void VolumeUp()
+		void VolumeUp() [Deprecated]
 
 			Adjust remote volume one step up
 
-		void VolumeDown()
+		void VolumeDown() [Deprecated]
 
 			Adjust remote volume one step down
 
-		void FastForward()
+		void FastForward() [Deprecated]
 
 			Fast forward playback, this action is only stopped
 			when another method in this interface is called.
 
-		void Rewind()
+		void Rewind() [Deprecated]
 
 			Rewind playback, this action is only stopped
 			when another method in this interface is called.
@@ -116,6 +116,10 @@ Properties
 
 		boolean Connected [readonly]
 
+		object Player [readonly, optional]
+
+			Addressed Player object path.
+
 
 MediaPlayer1 hierarchy
 ======================
-- 
2.4.3

