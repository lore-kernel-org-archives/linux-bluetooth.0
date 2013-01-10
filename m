Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 11/13 v2] test: Update test-player to register using MPRIS interface
Date: Thu, 10 Jan 2013 15:37:16 +0200
Message-Id: <1357825038-21970-11-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1357825038-21970-1-git-send-email-luiz.dentz@gmail.com>
References: <1357825038-21970-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 test/simple-player | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/test/simple-player b/test/simple-player
index e331c52..01bec06 100755
--- a/test/simple-player
+++ b/test/simple-player
@@ -29,23 +29,30 @@ class Player(dbus.service.Object):
 				signal_name = "PropertiesChanged")
 		else:
 			track = dbus.Dictionary({
-					"Title" : "Title",
-					"Artist" : "Artist",
-					"Album" : "Album",
-					"Genre" : "Genre",
-					"NumberOfTracks" : dbus.UInt32(10),
-					"TrackNumber" : dbus.UInt32(1),
-					"Duration" : dbus.UInt32(10000) },
+					"xesam:title" : "Title",
+					"xesam:artist" : "Artist",
+					"xesam:album" : "Album",
+					"xesam:genre" : "Genre",
+					"xesam:trackNumber" : dbus.Int32(1),
+					"mpris:length" : dbus.Int64(10000) },
 					signature="sv")
 
 			self.properties = dbus.Dictionary({
-					"Equalizer" : "off",
-					"Repeat" : "off",
-					"Shuffle" : "off",
-					"Scan" : "off",
-					"Status" : "playing",
+					"PlaybackStatus" : "playing",
+					"LoopStatus" : "None",
+					"Rate" : dbus.Double(1.0),
+					"Shuffle" : dbus.Boolean(False),
+					"Metadata" : track,
+					"Volume" : dbus.Double(1.0),
 					"Position" : dbus.UInt32(0),
-					"Track" : track },
+					"MinimumRate" : dbus.Double(1.0),
+					"MaximumRate" : dbus.Double(1.0),
+					"CanGoNext" : dbus.Boolean(False),
+					"CanGoPrevious" : dbus.Boolean(False),
+					"CanPlay" : dbus.Boolean(False),
+					"CanSeek" : dbus.Boolean(False),
+					"CanControl" : dbus.Boolean(False),
+					},
 					signature="sv")
 
 			handler = InputHandler(self)
@@ -87,7 +94,7 @@ class InputHandler:
 			print('\t', cmd, self.commands[cmd], sep='')
 
 		print("\nUse python syntax to pass arguments to available methods.\n" \
-                "E.g.: PropertiesChanged({'Track' : {'Title': 'My title', \
+                "E.g.: PropertiesChanged({'Metadata' : {'Title': 'My title', \
 		'Album': 'my album' }})")
 		self.prompt()
 
-- 
1.8.0.1

