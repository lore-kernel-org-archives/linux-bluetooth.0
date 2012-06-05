Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 18/23 v2] test: Use org.bluez.obex namespace in list-folders script
Date: Tue,  5 Jun 2012 16:03:06 +0300
Message-Id: <1338901391-17138-19-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1338901391-17138-1-git-send-email-luiz.dentz@gmail.com>
References: <1338901391-17138-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 test/list-folders |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/test/list-folders b/test/list-folders
index 7239d6d..ecd456c 100755
--- a/test/list-folders
+++ b/test/list-folders
@@ -6,13 +6,13 @@ import dbus
 
 def list_folder(folder):
 	bus = dbus.SessionBus()
-	client = dbus.Interface(bus.get_object("org.openobex.client", "/"),
-				"org.openobex.Client")
+	client = dbus.Interface(bus.get_object("org.bluez.obex.client", "/"),
+				"org.bluez.obex.Client")
 
-	session_path = client.CreateSession(sys.argv[1], { "Target": "ftp" })
+	path = client.CreateSession(sys.argv[1], { "Target": "ftp" })
 
-	ftp = dbus.Interface(bus.get_object("org.openobex.client", session_path),
-			     "org.openobex.FileTransfer")
+	ftp = dbus.Interface(bus.get_object("org.bluez.obex.client", path),
+				"org.bluez.obex.FileTransfer")
 
 	if folder:
 		for node in folder.split("/"):
-- 
1.7.10.2

