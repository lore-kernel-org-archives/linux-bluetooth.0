Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ] Fix simple-player test script to make it work with dbus-python-0.84
Date: Thu, 10 Nov 2011 21:58:35 -0300
Message-Id: <1320973115-13322-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
In every machine that I tried with dbus-python 0.84, something like this was
needed, but I didn't find out why nobody complained about this earlier.


 test/simple-player |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/test/simple-player b/test/simple-player
index 166caff..70701da 100755
--- a/test/simple-player
+++ b/test/simple-player
@@ -104,7 +104,7 @@ if __name__ == '__main__':
 					"Shuffle" : "off",
 					"Scan" : "off",
 					"Status" : "playing",
-					"Position" : dbus.UInt32(0) })
+					"Position" : dbus.UInt32(0) }, signature="sv")

 	metadata = dbus.Dictionary({ "Title" : "Title",
 					"Artist" : "Artist",
@@ -112,7 +112,7 @@ if __name__ == '__main__':
 					"Genre" : "Genre",
 					"NumberOfTracks" : dbus.UInt32(10),
 					"Number" : dbus.UInt32(1),
-					"Duration" : dbus.UInt32(10000) })
+					"Duration" : dbus.UInt32(10000) }, signature="sv")

 	print('Register media player with:\n\tProperties: %s\n\tMetadata: %s' \
 						% (properties, metadata))
@@ -120,6 +120,6 @@ if __name__ == '__main__':
 	handler = InputHandler(player)
 	gobject.io_add_watch(sys.stdin, gobject.IO_IN, handler.handle)

-	media.RegisterPlayer(path, properties, metadata)
+	media.RegisterPlayer(dbus.ObjectPath(path), properties, metadata)

 	mainloop.run()
--
1.7.7

