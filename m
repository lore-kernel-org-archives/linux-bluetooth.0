Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 12/12] Improve test/simple-player to allow user interaction
Date: Wed, 12 Oct 2011 12:11:22 -0300
Message-Id: <1318432282-25002-12-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1318432282-25002-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1318432282-25002-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Allow user to trigger TrackChanged and PropertyChanged. Calls made by
remote side (coming from D-Bus) are printed to stderr while the ones to
interact with user go to stdout.
---
 test/simple-player |   71 +++++++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 67 insertions(+), 4 deletions(-)

diff --git a/test/simple-player b/test/simple-player
index f483897..209fcdc 100755
--- a/test/simple-player
+++ b/test/simple-player
@@ -1,5 +1,7 @@
 #!/usr/bin/python
 
+from __future__ import print_function
+import os
 import sys
 import dbus
 import dbus.service
@@ -10,9 +12,68 @@ class Player(dbus.service.Object):
 	@dbus.service.method("org.bluez.MediaPlayer",
 					in_signature="sv", out_signature="")
 	def SetProperty(self, key, value):
-		print "SetProperty (%s, %s)" % (key, value)
+		print("SetProperty (%s, %s)" % (key, value), file=sys.stderr)
 		return
 
+	@dbus.service.signal("org.bluez.MediaPlayer", signature="sv")
+	def PropertyChanged(self, setting, value):
+		"""PropertyChanged(setting, value)
+
+		Send a PropertyChanged signal. 'setting' and 'value' are
+		string parameters as specified in doc/media-api.txt.
+		"""
+		pass
+
+	@dbus.service.signal("org.bluez.MediaPlayer", signature="a{sv}")
+	def TrackChanged(self, metadata):
+		"""TrackChanged(metadata)
+
+		Send a TrackChanged signal. 'metadata' parameter is a dictionary,
+		with values as defined in doc/media-api.txt.
+		"""
+		pass
+
+	def help(self, func):
+		help(self.__class__.__dict__[func])
+
+class InputHandler:
+	commands = { 'TrackChanged': '(metadata)',
+					'PropertyChanged': '(key, value)',
+					'help': '(cmd)' }
+	def __init__(self, player):
+		self.player = player
+		print('\n\nAvailable commands:')
+		for cmd in self.commands:
+			print('\t', cmd, self.commands[cmd], sep='')
+
+		print("\nUse python syntax to pass arguments to available methods.\n" \
+                "E.g.: TrackChanged({'Title': 'My title', 'Album': 'my album' })")
+		self.prompt()
+
+	def prompt(self):
+		print('\n>>> ', end='')
+		sys.stdout.flush()
+
+	def handle(self, fd, condition):
+		s = os.read(fd.fileno(), 1024).strip()
+		try:
+			cmd = s[:s.find('(')]
+			if not cmd in self.commands:
+				print("Unknown command ", cmd)
+		except ValueError:
+			print("Malformed command")
+			return True
+
+		try:
+			exec "self.player.%s" % s
+		except Exception as e:
+			print(e)
+			pass
+		self.prompt()
+		return True
+
+
+
 if __name__ == '__main__':
 	dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
 
@@ -39,8 +100,6 @@ if __name__ == '__main__':
 					"Status" : "playing",
 					"Position" : dbus.UInt32(0) })
 
-	print properties
-
 	metadata = dbus.Dictionary({ "Title" : "Title",
 					"Artist" : "Artist",
 					"Album" : "Album",
@@ -49,7 +108,11 @@ if __name__ == '__main__':
 					"Number" : dbus.UInt32(1),
 					"Duration" : dbus.UInt32(10000) })
 
-	print metadata
+	print('Register media player with:\n\tProperties: %s\n\tMetadata: %s' \
+						% (properties, metadata))
+
+	handler = InputHandler(player)
+	gobject.io_add_watch(sys.stdin, gobject.IO_IN, handler.handle)
 
 	media.RegisterPlayer(path, properties, metadata)
 
-- 
1.7.7

