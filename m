Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 14/23 v2] client-api: Rename Synchronization interface to org.bluez.obex.Synchronization
Date: Tue,  5 Jun 2012 16:03:02 +0300
Message-Id: <1338901391-17138-15-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1338901391-17138-1-git-send-email-luiz.dentz@gmail.com>
References: <1338901391-17138-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 client/sync.c      |    2 +-
 doc/client-api.txt |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/client/sync.c b/client/sync.c
index 035ab2e..65c9210 100644
--- a/client/sync.c
+++ b/client/sync.c
@@ -42,7 +42,7 @@
 #define OBEX_SYNC_UUID "IRMC-SYNC"
 #define OBEX_SYNC_UUID_LEN 9
 
-#define SYNC_INTERFACE	"org.openobex.Synchronization"
+#define SYNC_INTERFACE "org.bluez.obex.Synchronization"
 #define ERROR_INF SYNC_INTERFACE ".Error"
 #define SYNC_UUID "00001104-0000-1000-8000-00805f9b34fb"
 
diff --git a/doc/client-api.txt b/doc/client-api.txt
index 5a6189d..76bf722 100644
--- a/doc/client-api.txt
+++ b/doc/client-api.txt
@@ -298,7 +298,7 @@ Synchronization hierarchy
 =======================
 
 Service		org.bluez.obex.client
-Interface	org.openobex.Synchronization
+Interface	org.bluez.obex.Synchronization
 Object path	[variable prefix]/{session0,session1,...}
 
 Methods		void SetLocation(string location)
-- 
1.7.10.2

