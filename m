Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 7/8 v2] ftp: remove pcsuite code
Date: Wed,  2 Nov 2011 15:58:12 +0200
Message-Id: <1320242292-2461-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

pcsuite code has been moved to pcsuite plugin and this code is no
longer used.
---
Add description

 plugins/ftp.c |   55 -------------------------------------------------------
 1 files changed, 0 insertions(+), 55 deletions(-)

diff --git a/plugins/ftp.c b/plugins/ftp.c
index aebe411..30edc6b 100644
--- a/plugins/ftp.c
+++ b/plugins/ftp.c
@@ -95,70 +95,15 @@
   </attribute>								\
 </record>"
 
-#define PCSUITE_CHANNEL 24
-#define PCSUITE_WHO_SIZE 8
-
-#define PCSUITE_RECORD "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>	\
-<record>								\
-  <attribute id=\"0x0001\">						\
-    <sequence>								\
-      <uuid value=\"00005005-0000-1000-8000-0002ee000001\"/>		\
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
-  <attribute id=\"0x0005\">						\
-    <sequence>								\
-      <uuid value=\"0x1002\"/>						\
-    </sequence>								\
-  </attribute>								\
-									\
-  <attribute id=\"0x0009\">						\
-    <sequence>								\
-      <sequence>							\
-        <uuid value=\"00005005-0000-1000-8000-0002ee000001\"/>		\
-        <uint16 value=\"0x0100\" name=\"version\"/>			\
-      </sequence>							\
-    </sequence>								\
-  </attribute>								\
-									\
-  <attribute id=\"0x0100\">						\
-    <text value=\"%s\" name=\"name\"/>					\
-  </attribute>								\
-</record>"
-
 static const uint8_t FTP_TARGET[TARGET_SIZE] = {
 			0xF9, 0xEC, 0x7B, 0xC4, 0x95, 0x3C, 0x11, 0xD2,
 			0x98, 0x4E, 0x52, 0x54, 0x00, 0xDC, 0x9E, 0x09 };
 
-static const uint8_t PCSUITE_WHO[PCSUITE_WHO_SIZE] = {
-			'P', 'C', ' ', 'S', 'u', 'i', 't', 'e' };
-
 struct ftp_session {
 	struct obex_session *os;
 	char *folder;
 };
 
-struct pcsuite_session {
-	struct ftp_session *ftp;
-	char *lock_file;
-	int fd;
-};
-
 static void set_folder(struct ftp_session *ftp, const char *new_folder)
 {
 	DBG("%p folder %s", ftp, new_folder);
-- 
1.7.6.4

