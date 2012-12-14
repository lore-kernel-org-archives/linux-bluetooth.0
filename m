Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 01/13] network: Append version to Network and NetworkServer interfaces
Date: Fri, 14 Dec 2012 11:12:55 +0200
Message-Id: <1355476387-2165-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 doc/network-api.txt           | 4 ++--
 profiles/network/connection.c | 2 +-
 profiles/network/server.c     | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/doc/network-api.txt b/doc/network-api.txt
index b640b9a..1c9d889 100644
--- a/doc/network-api.txt
+++ b/doc/network-api.txt
@@ -8,7 +8,7 @@ Network hierarchy
 =================
 
 Service		org.bluez
-Interface	org.bluez.Network
+Interface	org.bluez.Network1
 Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
 
 Properties	boolean Connected [readonly]
@@ -28,7 +28,7 @@ Network server hierarchy
 ========================
 
 Service		org.bluez
-Interface	org.bluez.NetworkServer
+Interface	org.bluez.NetworkServer1
 Object path	/org/bluez/{hci0,hci1,...}
 
 Methods		void Register(string uuid, string bridge)
diff --git a/profiles/network/connection.c b/profiles/network/connection.c
index 3157e31..5fa3e1b 100644
--- a/profiles/network/connection.c
+++ b/profiles/network/connection.c
@@ -49,7 +49,7 @@
 #include "manager.h"
 #include "connection.h"
 
-#define NETWORK_PEER_INTERFACE "org.bluez.Network"
+#define NETWORK_PEER_INTERFACE "org.bluez.Network1"
 #define CON_SETUP_RETRIES      3
 #define CON_SETUP_TO           9
 
diff --git a/profiles/network/server.c b/profiles/network/server.c
index e32e51d..2869c28 100644
--- a/profiles/network/server.c
+++ b/profiles/network/server.c
@@ -51,7 +51,7 @@
 #include "common.h"
 #include "server.h"
 
-#define NETWORK_SERVER_INTERFACE "org.bluez.NetworkServer"
+#define NETWORK_SERVER_INTERFACE "org.bluez.NetworkServer1"
 #define SETUP_TIMEOUT		1
 
 /* Pending Authorization */
-- 
1.7.11.7

