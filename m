Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 20/23 v2] test: Use org.bluez.obex namespace in map-client script
Date: Tue,  5 Jun 2012 16:03:08 +0300
Message-Id: <1338901391-17138-21-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1338901391-17138-1-git-send-email-luiz.dentz@gmail.com>
References: <1338901391-17138-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 test/map-client |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/test/map-client b/test/map-client
index d66cb9f..ca8e478 100755
--- a/test/map-client
+++ b/test/map-client
@@ -38,14 +38,14 @@ if  __name__ == '__main__':
 	bus = dbus.SessionBus()
 	mainloop = gobject.MainLoop()
 
-	client = dbus.Interface(bus.get_object("org.openobex.client", "/"),
-				"org.openobex.Client")
+	client = dbus.Interface(bus.get_object("org.bluez.obex.client", "/"),
+				"org.bluez.obex.Client")
 
 	path = client.CreateSession(options.device, { "Target": "map" })
 
-	obj = bus.get_object("org.openobex.client", path)
-	session = dbus.Interface(obj, "org.openobex.Session")
-	map = dbus.Interface(obj, "org.openobex.MessageAccess")
+	obj = bus.get_object("org.bluez.obex.client", path)
+	session = dbus.Interface(obj, "org.bluez.obex.Session")
+	map = dbus.Interface(obj, "org.bluez.obex.MessageAccess")
 
 	if options.new_dir:
 		set_folder(map, options.new_dir)
-- 
1.7.10.2

