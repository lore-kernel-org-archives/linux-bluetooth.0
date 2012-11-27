Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/6] media-api: Update documentation of MediaPlayer interface
Date: Tue, 27 Nov 2012 14:51:23 +0200
Message-Id: <1354020685-17028-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1354020685-17028-1-git-send-email-luiz.dentz@gmail.com>
References: <1354020685-17028-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 doc/media-api.txt | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/doc/media-api.txt b/doc/media-api.txt
index b4f2fc6..a814b60 100644
--- a/doc/media-api.txt
+++ b/doc/media-api.txt
@@ -133,24 +133,12 @@ Object path	freely definable (Target role)
 		[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/playerX
 		(Controller role)
 
-Methods		dict GetProperties()
-
-			Returns all properties for the interface. See the
-			properties section for available properties.
-
-		dict GetTrack()
+Methods		dict GetTrack()
 
 			Returns known metadata of the current track.
 
 			See TrackChanged for possible values.
 
-		void SetProperty(string property, variant value)
-
-			Changes the value of the specified property. Only
-			properties that are listed as read-write can be changed.
-
-			On success this will emit a PropertyChanged signal.
-
 		void Release()
 
 			This method gets called when the service daemon
@@ -159,12 +147,7 @@ Methods		dict GetProperties()
 			player, because when this method gets called it has
 			already been unregistered.
 
-Signals		PropertyChanged(string setting, variant value)
-
-			This signal indicates a changed value of the given
-			property.
-
-		TrackChanged(dict metadata)
+Signals		TrackChanged(dict metadata)
 
 			This signal indicates that current track has changed.
 			All available metadata for the new track shall be set
-- 
1.7.11.7

