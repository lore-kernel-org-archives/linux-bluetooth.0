Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 15/23] client-api: Rename MessageAccess interface to org.bluez.obex.MessageAccess
Date: Tue,  5 Jun 2012 13:57:13 +0300
Message-Id: <1338893841-14234-16-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1338893841-14234-1-git-send-email-luiz.dentz@gmail.com>
References: <1338893841-14234-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 client/map.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/client/map.c b/client/map.c
index 52b7c68..1bf1f4f 100644
--- a/client/map.c
+++ b/client/map.c
@@ -40,7 +40,7 @@
 	"\xBB\x58\x2B\x40\x42\x0C\x11\xDB\xB0\xDE\x08\x00\x20\x0C\x9A\x66"
 #define OBEX_MAS_UUID_LEN 16
 
-#define MAP_INTERFACE  "org.openobex.MessageAccess"
+#define MAP_INTERFACE "org.bluez.obex.MessageAccess"
 #define MAS_UUID "00001132-0000-1000-8000-00805f9b34fb"
 
 struct map_data {
-- 
1.7.10.2

