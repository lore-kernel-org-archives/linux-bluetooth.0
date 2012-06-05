Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 11/23] client-api: Rename ObjectPush interface to org.bluez.obex.ObjectPush
Date: Tue,  5 Jun 2012 13:57:09 +0300
Message-Id: <1338893841-14234-12-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1338893841-14234-1-git-send-email-luiz.dentz@gmail.com>
References: <1338893841-14234-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 client/opp.c       |    2 +-
 doc/client-api.txt |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/client/opp.c b/client/opp.c
index a3899f8..5e84f41 100644
--- a/client/opp.c
+++ b/client/opp.c
@@ -36,7 +36,7 @@
 #include "opp.h"
 
 #define OPP_UUID "00001105-0000-1000-8000-00805f9b34fb"
-#define OPP_INTERFACE "org.openobex.ObjectPush"
+#define OPP_INTERFACE "org.bluez.obex.ObjectPush"
 #define ERROR_INF OPP_INTERFACE ".Error"
 
 struct opp_data {
diff --git a/doc/client-api.txt b/doc/client-api.txt
index 23d05dd..09aab87 100644
--- a/doc/client-api.txt
+++ b/doc/client-api.txt
@@ -61,7 +61,7 @@ Object Push hierarchy
 =====================
 
 Service		org.bluez.obex.client
-Interface	org.openobex.ObjectPush
+Interface	org.bluez.obex.ObjectPush
 Object path	[variable prefix]/{session0,session1,...}
 
 Methods		object, dict SendFile(string sourcefile)
-- 
1.7.10.2

