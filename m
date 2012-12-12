Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 09/11] pbap: Remove record details
Date: Wed, 12 Dec 2012 13:52:14 +0200
Message-Id: <1355313136-7891-9-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1355313136-7891-1-git-send-email-luiz.dentz@gmail.com>
References: <1355313136-7891-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Standart service records are already supported by bluetoothd
---
 obexd/plugins/pbap.c | 46 ----------------------------------------------
 1 file changed, 46 deletions(-)

diff --git a/obexd/plugins/pbap.c b/obexd/plugins/pbap.c
index 4d4f0b8..4740188 100644
--- a/obexd/plugins/pbap.c
+++ b/obexd/plugins/pbap.c
@@ -65,49 +65,6 @@
 #define PHONEBOOKSIZE_TAG	0X08
 #define NEWMISSEDCALLS_TAG	0X09
 
-#define PBAP_CHANNEL	15
-
-#define PBAP_RECORD "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>	\
-<record>								\
-  <attribute id=\"0x0001\">						\
-    <sequence>								\
-      <uuid value=\"0x112f\"/>						\
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
-        <uuid value=\"0x1130\"/>					\
-        <uint16 value=\"0x0100\" name=\"version\"/>			\
-      </sequence>							\
-    </sequence>								\
-  </attribute>								\
-									\
-  <attribute id=\"0x0100\">						\
-    <text value=\"%s\" name=\"name\"/>					\
-  </attribute>								\
-									\
-  <attribute id=\"0x0314\">						\
-    <uint8 value=\"0x01\"/>						\
-  </attribute>								\
-</record>"
-
 struct cache {
 	gboolean valid;
 	uint32_t index;
@@ -664,9 +621,6 @@ static int pbap_chkput(struct obex_session *os, void *user_data)
 static struct obex_service_driver pbap = {
 	.name = "Phonebook Access server",
 	.service = OBEX_PBAP,
-	.channel = PBAP_CHANNEL,
-	.secure = TRUE,
-	.record = PBAP_RECORD,
 	.target = PBAP_TARGET,
 	.target_size = TARGET_SIZE,
 	.connect = pbap_connect,
-- 
1.7.11.7

