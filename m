Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] doc/media-api: Include possible errors
Date: Thu, 13 Mar 2014 15:32:29 +0200
Message-Id: <1394717549-32065-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1394717549-32065-1-git-send-email-luiz.dentz@gmail.com>
References: <1394717549-32065-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 doc/media-api.txt | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/doc/media-api.txt b/doc/media-api.txt
index 05f90e3..07ea991 100644
--- a/doc/media-api.txt
+++ b/doc/media-api.txt
@@ -128,32 +128,53 @@ Methods		void Play()
 
 			Resume playback.
 
+			Possible Errors: org.bluez.Error.NotSupported
+					 org.bluez.Error.Failed
+
 		void Pause()
 
 			Pause playback.
 
+			Possible Errors: org.bluez.Error.NotSupported
+					 org.bluez.Error.Failed
+
 		void Stop()
 
 			Stop playback.
 
+			Possible Errors: org.bluez.Error.NotSupported
+					 org.bluez.Error.Failed
+
 		void Next()
 
 			Next item.
 
+			Possible Errors: org.bluez.Error.NotSupported
+					 org.bluez.Error.Failed
+
 		void Previous()
 
 			Previous item.
 
+			Possible Errors: org.bluez.Error.NotSupported
+					 org.bluez.Error.Failed
+
 		void FastForward()
 
 			Fast forward playback, this action is only stopped
 			when another method in this interface is called.
 
+			Possible Errors: org.bluez.Error.NotSupported
+					 org.bluez.Error.Failed
+
 		void Rewind()
 
 			Rewind playback, this action is only stopped
 			when another method in this interface is called.
 
+			Possible Errors: org.bluez.Error.NotSupported
+					 org.bluez.Error.Failed
+
 Properties	string Equalizer [readwrite]
 
 			Possible values: "off" or "on"
@@ -300,10 +321,17 @@ Methods		object Search(string value, dict filter)
 			To list the items found use the folder object returned
 			and pass to ChangeFolder.
 
+			Possible Errors: org.bluez.Error.NotSupported
+					 org.bluez.Error.Failed
+
 		array{objects, properties} ListItems(dict filter)
 
 			Return a list of items found
 
+			Possible Errors: org.bluez.Error.InvalidArguments
+					 org.bluez.Error.NotSupported
+					 org.bluez.Error.Failed
+
 		void ChangeFolder(object folder)
 
 			Change current folder.
@@ -313,6 +341,10 @@ Methods		object Search(string value, dict filter)
 			exception is NowPlaying folder which should be always
 			present while the player is active.
 
+			Possible Errors: org.bluez.Error.InvalidArguments
+					 org.bluez.Error.NotSupported
+					 org.bluez.Error.Failed
+
 Properties	uint32 NumberOfItems [readonly]
 
 			Number of items in the folder
@@ -368,10 +400,16 @@ Methods		void Play()
 
 			Play item
 
+			Possible Errors: org.bluez.Error.NotSupported
+					 org.bluez.Error.Failed
+
 		void AddtoNowPlaying()
 
 			Add item to now playing list
 
+			Possible Errors: org.bluez.Error.NotSupported
+					 org.bluez.Error.Failed
+
 Properties	object Player [readonly]
 
 			Player object path the item belongs to
-- 
1.8.5.3

