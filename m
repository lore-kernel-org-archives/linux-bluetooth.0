Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 11/13] sap: Append version to SimAccess interfaces
Date: Fri, 14 Dec 2012 11:13:05 +0200
Message-Id: <1355476387-2165-11-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1355476387-2165-1-git-send-email-luiz.dentz@gmail.com>
References: <1355476387-2165-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 doc/sap-api.txt          | 2 +-
 profiles/sap/sap-dummy.c | 2 +-
 profiles/sap/server.c    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/doc/sap-api.txt b/doc/sap-api.txt
index 92bdd9e..6bd8034 100644
--- a/doc/sap-api.txt
+++ b/doc/sap-api.txt
@@ -8,7 +8,7 @@ Sim Access Profile hierarchy
 ============================
 
 Service		org.bluez
-Interface	org.bluez.SimAccess
+Interface	org.bluez.SimAccess1
 Object path	[variable prefix]/{hci0,hci1,...}
 
 Methods		void Disconnect()
diff --git a/profiles/sap/sap-dummy.c b/profiles/sap/sap-dummy.c
index 6c717dc..ffaf847 100644
--- a/profiles/sap/sap-dummy.c
+++ b/profiles/sap/sap-dummy.c
@@ -34,7 +34,7 @@
 #include "log.h"
 #include "sap.h"
 
-#define SAP_DUMMY_IFACE "org.bluez.SimAccessTest"
+#define SAP_DUMMY_IFACE "org.bluez.SimAccessTest1"
 #define SAP_DUMMY_PATH "/org/bluez/test"
 
 enum {
diff --git a/profiles/sap/server.c b/profiles/sap/server.c
index d075e40..01caa33 100644
--- a/profiles/sap/server.c
+++ b/profiles/sap/server.c
@@ -43,7 +43,7 @@
 #include "sap.h"
 #include "server.h"
 
-#define SAP_SERVER_INTERFACE	"org.bluez.SimAccess"
+#define SAP_SERVER_INTERFACE	"org.bluez.SimAccess1"
 #define SAP_SERVER_CHANNEL	8
 
 #define PADDING4(x) ((4 - ((x) & 0x03)) & 0x03)
-- 
1.7.11.7

