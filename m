Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 10/11] mas: Remove record details
Date: Wed, 12 Dec 2012 13:52:15 +0200
Message-Id: <1355313136-7891-10-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1355313136-7891-1-git-send-email-luiz.dentz@gmail.com>
References: <1355313136-7891-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Standart service records are already supported by bluetoothd
---
 obexd/plugins/mas.c | 51 ---------------------------------------------------
 1 file changed, 51 deletions(-)

diff --git a/obexd/plugins/mas.c b/obexd/plugins/mas.c
index 1b18059..3270edd 100644
--- a/obexd/plugins/mas.c
+++ b/obexd/plugins/mas.c
@@ -49,54 +49,6 @@
 #define READ_STATUS_REQ 0
 #define DELETE_STATUS_REQ 1
 
-/* Channel number according to bluez doc/assigned-numbers.txt */
-#define MAS_CHANNEL	16
-
-#define MAS_RECORD "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>		\
-<record>								\
-  <attribute id=\"0x0001\">						\
-    <sequence>								\
-      <uuid value=\"0x1132\"/>						\
-    </sequence>								\
-  </attribute>								\
-									\
-  <attribute id=\"0x0004\">						\
-    <sequence>								\
-      <sequence>							\
-        <uuid value=\"0x0100\"/>					\
-      </sequence>							\
-      <sequence>							\
-        <uuid value=\"0x0003\"/>					\
-        <uint8 value=\"%u\" name=\"channel\"/>				\
-      </sequence>							\
-      <sequence>							\
-        <uuid value=\"0x0008\"/>					\
-      </sequence>							\
-    </sequence>								\
-  </attribute>								\
-									\
-  <attribute id=\"0x0009\">						\
-    <sequence>								\
-      <sequence>							\
-        <uuid value=\"0x1134\"/>					\
-        <uint16 value=\"0x0100\" name=\"version\"/>			\
-      </sequence>							\
-    </sequence>								\
-  </attribute>								\
-									\
-  <attribute id=\"0x0100\">						\
-    <text value=\"%s\" name=\"name\"/>					\
-  </attribute>								\
-									\
-  <attribute id=\"0x0315\">						\
-    <uint8 value=\"0x00\"/>						\
-  </attribute>								\
-									\
-  <attribute id=\"0x0316\">						\
-    <uint8 value=\"0x0F\"/>						\
-  </attribute>								\
-</record>"
-
 #define XML_DECL "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
 
 /* Building blocks for x-obex/folder-listing */
@@ -764,9 +716,6 @@ static int any_close(void *obj)
 static struct obex_service_driver mas = {
 	.name = "Message Access server",
 	.service = OBEX_MAS,
-	.channel = MAS_CHANNEL,
-	.secure = TRUE,
-	.record = MAS_RECORD,
 	.target = MAS_TARGET,
 	.target_size = TARGET_SIZE,
 	.connect = mas_connect,
-- 
1.7.11.7

