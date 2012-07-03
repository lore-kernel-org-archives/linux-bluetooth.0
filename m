Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH] test-audio: Add --interface option
Date: Tue,  3 Jul 2012 17:18:31 +0200
Message-Id: <1341328711-3572-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 test/test-audio |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/test/test-audio b/test/test-audio
index 1ba2042..e302264 100755
--- a/test/test-audio
+++ b/test/test-audio
@@ -13,6 +13,8 @@ manager = dbus.Interface(bus.get_object("org.bluez", "/"), "org.bluez.Manager")
 option_list = [
 		make_option("-i", "--device", action="store",
 				type="string", dest="dev_id"),
+		make_option("-f", "--interface", action="store",
+				type="string", dest="dev_if"),
 		]
 parser = OptionParser(option_list=option_list)
 
@@ -23,6 +25,11 @@ if options.dev_id:
 else:
 	adapter_path = manager.DefaultAdapter()
 
+if options.dev_if:
+	interface = "org.bluez." + options.dev_if
+else:
+	interface = "org.bluez.Audio"
+
 adapter = dbus.Interface(bus.get_object("org.bluez", adapter_path),
 							"org.bluez.Adapter")
 
@@ -35,8 +42,7 @@ if len(args) < 2:
 	sys.exit(1)
 
 device = adapter.FindDevice(args[1])
-audio = dbus.Interface(bus.get_object("org.bluez", device),
-				"org.bluez.Audio")
+audio = dbus.Interface(bus.get_object("org.bluez", device), interface)
 
 if args[0] == "connect":
 	audio.Connect()
-- 
1.7.9.5

