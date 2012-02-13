Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 3/5] ftp: Update record to support version 1.2 with GoepL2capPsm attribute
Date: Mon, 13 Feb 2012 13:37:48 +0200
Message-Id: <1329133070-30003-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1329133070-30003-1-git-send-email-luiz.dentz@gmail.com>
References: <1329133070-30003-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 plugins/ftp.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/plugins/ftp.c b/plugins/ftp.c
index 9b102d0..56cedb9 100644
--- a/plugins/ftp.c
+++ b/plugins/ftp.c
@@ -81,7 +81,7 @@
     <sequence>								\
       <sequence>							\
         <uuid value=\"0x1106\"/>					\
-        <uint16 value=\"0x0100\" name=\"version\"/>			\
+        <uint16 value=\"0x0102\" name=\"version\"/>			\
       </sequence>							\
     </sequence>								\
   </attribute>								\
@@ -89,6 +89,9 @@
   <attribute id=\"0x0100\">						\
     <text value=\"%s\" name=\"name\"/>					\
   </attribute>								\
+  <attribute id=\"0x0200\">						\
+    <uint16 value=\"%u\" name=\"psm\"/>					\
+  </attribute>								\
 </record>"
 
 static const uint8_t FTP_TARGET[TARGET_SIZE] = {
@@ -517,6 +520,7 @@ static struct obex_service_driver ftp = {
 	.name = "File Transfer server",
 	.service = OBEX_FTP,
 	.channel = FTP_CHANNEL,
+	.port = OBEX_PORT_RANDOM,
 	.secure = TRUE,
 	.record = FTP_RECORD,
 	.target = FTP_TARGET,
-- 
1.7.7.6

