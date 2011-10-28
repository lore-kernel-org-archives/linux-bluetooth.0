Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/4] Add support for MediaPlayer.Release to simple-player
Date: Fri, 28 Oct 2011 10:49:22 +0300
Message-Id: <1319788162-5606-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1319788162-5606-1-git-send-email-luiz.dentz@gmail.com>
References: <1319788162-5606-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 test/simple-player |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/test/simple-player b/test/simple-player
index 209fcdc..166caff 100755
--- a/test/simple-player
+++ b/test/simple-player
@@ -10,6 +10,12 @@ import gobject
 
 class Player(dbus.service.Object):
 	@dbus.service.method("org.bluez.MediaPlayer",
+					in_signature="", out_signature="")
+	def Release(self):
+		print("Release")
+		mainloop.quit()
+
+	@dbus.service.method("org.bluez.MediaPlayer",
 					in_signature="sv", out_signature="")
 	def SetProperty(self, key, value):
 		print("SetProperty (%s, %s)" % (key, value), file=sys.stderr)
-- 
1.7.6.4

