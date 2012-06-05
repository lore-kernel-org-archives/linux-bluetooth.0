Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 23/23 v2] test: Use org.bluez.obex namespace in get-capabilities script
Date: Tue,  5 Jun 2012 16:03:11 +0300
Message-Id: <1338901391-17138-24-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1338901391-17138-1-git-send-email-luiz.dentz@gmail.com>
References: <1338901391-17138-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 test/get-capabilities |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/test/get-capabilities b/test/get-capabilities
index 09e2d24..a06f2eb 100755
--- a/test/get-capabilities
+++ b/test/get-capabilities
@@ -4,8 +4,8 @@ import sys
 import dbus
 
 bus = dbus.SessionBus()
-client = dbus.Interface(bus.get_object("org.openobex.client", "/"),
-					"org.openobex.Client")
+client = dbus.Interface(bus.get_object("org.bluez.obex.client", "/"),
+					"org.bluez.obex.Client")
 
 if (len(sys.argv) < 3):
 	print "Usage: %s <device> <target>" % (sys.argv[0])
@@ -13,7 +13,7 @@ if (len(sys.argv) < 3):
 
 print "Creating Session"
 session_path = client.CreateSession(sys.argv[1], { "Target": sys.argv[2] })
-session = dbus.Interface(bus.get_object("org.openobex.client", session_path),
-							"org.openobex.Session")
+session = dbus.Interface(bus.get_object("org.bluez.obex.client", session_path),
+					"org.bluez.obex.Session")
 
 print session.GetCapabilities()
-- 
1.7.10.2

