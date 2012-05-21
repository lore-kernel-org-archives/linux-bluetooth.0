Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v0 12/12] client-test: Replace CreateSession parameter dict
Date: Mon, 21 May 2012 11:07:14 +0200
Message-Id: <1337591234-24919-13-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1337591234-24919-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1337591234-24919-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

---
 test/exchange-business-cards |    3 +--
 test/ftp-client              |    3 +--
 test/get-capabilities        |    3 +--
 test/list-folders            |    2 +-
 test/map-client              |    3 +--
 test/pbap-client             |    2 +-
 test/pull-business-card      |    3 +--
 test/send-files              |    3 +--
 8 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/test/exchange-business-cards b/test/exchange-business-cards
index 548ad2d..4abe426 100755
--- a/test/exchange-business-cards
+++ b/test/exchange-business-cards
@@ -12,8 +12,7 @@ if (len(sys.argv) < 4):
 	sys.exit(1)
 
 print "Creating Session"
-session_path = client.CreateSession({"Destination": sys.argv[1],
-					"Target": "OPP"})
+session_path = client.CreateSession(sys.argv[1], { "Target": "OPP" })
 opp = dbus.Interface(bus.get_object("org.openobex.client",
 					session_path),
 					"org.openobex.ObjectPush")
diff --git a/test/ftp-client b/test/ftp-client
index 9bc038d..825f591 100755
--- a/test/ftp-client
+++ b/test/ftp-client
@@ -135,8 +135,7 @@ if  __name__ == '__main__':
     client = dbus.Interface(bus.get_object("org.openobex.client", "/"),
                             "org.openobex.Client")
 
-    session_path = client.CreateSession({ "Destination": options.device,
-                                          "Target": "ftp"})
+    session_path = client.CreateSession(options.device, { "Target": "ftp" })
 
     session = dbus.Interface(bus.get_object("org.openobex.client", session_path),
                  "org.openobex.Session")
diff --git a/test/get-capabilities b/test/get-capabilities
index 29120f1..09e2d24 100755
--- a/test/get-capabilities
+++ b/test/get-capabilities
@@ -12,8 +12,7 @@ if (len(sys.argv) < 3):
 	sys.exit(1)
 
 print "Creating Session"
-session_path = client.CreateSession({"Destination": sys.argv[1],
-						"Target": sys.argv[2]})
+session_path = client.CreateSession(sys.argv[1], { "Target": sys.argv[2] })
 session = dbus.Interface(bus.get_object("org.openobex.client", session_path),
 							"org.openobex.Session")
 
diff --git a/test/list-folders b/test/list-folders
index c7eec10..7239d6d 100755
--- a/test/list-folders
+++ b/test/list-folders
@@ -9,7 +9,7 @@ def list_folder(folder):
 	client = dbus.Interface(bus.get_object("org.openobex.client", "/"),
 				"org.openobex.Client")
 
-	session_path = client.CreateSession({ "Destination": sys.argv[1], "Target": "ftp"})
+	session_path = client.CreateSession(sys.argv[1], { "Target": "ftp" })
 
 	ftp = dbus.Interface(bus.get_object("org.openobex.client", session_path),
 			     "org.openobex.FileTransfer")
diff --git a/test/map-client b/test/map-client
index 5c7c447..cf006b6 100755
--- a/test/map-client
+++ b/test/map-client
@@ -41,8 +41,7 @@ if  __name__ == '__main__':
     client = dbus.Interface(bus.get_object("org.openobex.client", "/"),
                             "org.openobex.Client")
 
-    session_path = client.CreateSession({ "Destination": options.device,
-                                          "Target": "map"})
+    session_path = client.CreateSession( options.device, { "Target": "map" })
 
     session = dbus.Interface(bus.get_object("org.openobex.client", session_path),
                  "org.openobex.Session")
diff --git a/test/pbap-client b/test/pbap-client
index 7456c01..ecca14f 100755
--- a/test/pbap-client
+++ b/test/pbap-client
@@ -9,7 +9,7 @@ client = dbus.Interface(bus.get_object("org.openobex.client", "/"),
 						"org.openobex.Client")
 
 print "Creating Session"
-session_path = client.CreateSession({"Destination": sys.argv[1], "Target": "PBAP"})
+session_path = client.CreateSession(sys.argv[1], { "Target": "PBAP" })
 pbap = dbus.Interface(bus.get_object("org.openobex.client", session_path),
 						"org.openobex.PhonebookAccess")
 session = dbus.Interface(bus.get_object("org.openobex.client", session_path),
diff --git a/test/pull-business-card b/test/pull-business-card
index 5912155..6f9267b 100755
--- a/test/pull-business-card
+++ b/test/pull-business-card
@@ -29,8 +29,7 @@ if __name__ == '__main__':
 		sys.exit(1)
 
 	print "Creating Session"
-	session_path = client.CreateSession({"Destination": sys.argv[1],
-						"Target": "OPP"})
+	session_path = client.CreateSession(sys.argv[1], { "Target": "OPP" })
 	opp = dbus.Interface(bus.get_object("org.openobex.client",
 						session_path),
 						"org.openobex.ObjectPush")
diff --git a/test/send-files b/test/send-files
index aa4862f..5310c06 100755
--- a/test/send-files
+++ b/test/send-files
@@ -15,8 +15,7 @@ if (len(sys.argv) < 3):
 files = [os.path.realpath(f) for f in sys.argv[2:]]
 
 print "Creating Session"
-session_path = client.CreateSession({"Destination": sys.argv[1],
-					"Target": "OPP"})
+session_path = client.CreateSession(sys.argv[1], { "Target": "OPP" })
 opp = dbus.Interface(bus.get_object("org.openobex.client", session_path),
 					"org.openobex.ObjectPush")
 
-- 
1.7.7.6

