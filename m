Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 08/23] client: Change namespace to org.bluez.obex.client
Date: Tue,  5 Jun 2012 13:57:06 +0300
Message-Id: <1338893841-14234-9-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1338893841-14234-1-git-send-email-luiz.dentz@gmail.com>
References: <1338893841-14234-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 client/manager.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/client/manager.c b/client/manager.c
index 9bb1465..1ae95f5 100644
--- a/client/manager.c
+++ b/client/manager.c
@@ -45,10 +45,10 @@
 #include "sync.h"
 #include "map.h"
 
-#define CLIENT_SERVICE  "org.openobex.client"
+#define CLIENT_SERVICE		"org.bluez.obex.client"
 
-#define CLIENT_INTERFACE  "org.openobex.Client"
-#define CLIENT_PATH       "/"
+#define CLIENT_INTERFACE	"org.bluez.obex.Client"
+#define CLIENT_PATH		"/"
 
 struct send_data {
 	DBusConnection *connection;
-- 
1.7.10.2

