Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 08/11] ftp: Remove record details
Date: Wed, 12 Dec 2012 13:52:13 +0200
Message-Id: <1355313136-7891-8-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1355313136-7891-1-git-send-email-luiz.dentz@gmail.com>
References: <1355313136-7891-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Standart service records are already supported by bluetoothd
---
 obexd/plugins/ftp.c | 45 ---------------------------------------------
 1 file changed, 45 deletions(-)

diff --git a/obexd/plugins/ftp.c b/obexd/plugins/ftp.c
index ff4b761..d53774d 100644
--- a/obexd/plugins/ftp.c
+++ b/obexd/plugins/ftp.c
@@ -53,47 +53,6 @@
 #define LST_TYPE "x-obex/folder-listing"
 #define CAP_TYPE "x-obex/capability"
 
-#define FTP_CHANNEL 10
-#define FTP_RECORD "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>		\
-<record>								\
-  <attribute id=\"0x0001\">						\
-    <sequence>								\
-      <uuid value=\"0x1106\"/>						\
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
-        <uuid value=\"0x1106\"/>					\
-        <uint16 value=\"0x0102\" name=\"version\"/>			\
-      </sequence>							\
-    </sequence>								\
-  </attribute>								\
-									\
-  <attribute id=\"0x0100\">						\
-    <text value=\"%s\" name=\"name\"/>					\
-  </attribute>								\
-  <attribute id=\"0x0200\">						\
-    <uint16 value=\"%u\" name=\"psm\"/>					\
-  </attribute>								\
-</record>"
-
 static const uint8_t FTP_TARGET[TARGET_SIZE] = {
 			0xF9, 0xEC, 0x7B, 0xC4, 0x95, 0x3C, 0x11, 0xD2,
 			0x98, 0x4E, 0x52, 0x54, 0x00, 0xDC, 0x9E, 0x09 };
@@ -519,10 +478,6 @@ void ftp_disconnect(struct obex_session *os, void *user_data)
 static struct obex_service_driver ftp = {
 	.name = "File Transfer server",
 	.service = OBEX_FTP,
-	.channel = FTP_CHANNEL,
-	.port = OBEX_PORT_RANDOM,
-	.secure = TRUE,
-	.record = FTP_RECORD,
 	.target = FTP_TARGET,
 	.target_size = TARGET_SIZE,
 	.connect = ftp_connect,
-- 
1.7.11.7

