Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 11/11] irmc: Remove record details
Date: Wed, 12 Dec 2012 13:52:16 +0200
Message-Id: <1355313136-7891-11-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1355313136-7891-1-git-send-email-luiz.dentz@gmail.com>
References: <1355313136-7891-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Standart service records are already supported by bluetoothd
---
 obexd/plugins/irmc.c | 49 -------------------------------------------------
 1 file changed, 49 deletions(-)

diff --git a/obexd/plugins/irmc.c b/obexd/plugins/irmc.c
index c9c3521..d343977 100644
--- a/obexd/plugins/irmc.c
+++ b/obexd/plugins/irmc.c
@@ -46,52 +46,6 @@
 #include "filesystem.h"
 #include "manager.h"
 
-#define IRMC_CHANNEL	14
-
-#define IRMC_RECORD "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>	\
-<record>								\
-  <attribute id=\"0x0001\">						\
-    <sequence>								\
-      <uuid value=\"0x1104\"/>						\
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
-        <uuid value=\"0x1104\"/>					\
-        <uint16 value=\"0x0100\" name=\"version\"/>			\
-      </sequence>							\
-    </sequence>								\
-  </attribute>								\
-									\
-  <attribute id=\"0x0100\">						\
-    <text value=\"%s\" name=\"name\"/>					\
-  </attribute>								\
-									\
-  <attribute id=\"0x0301\">						\
-    <sequence>								\
-      <uint8 value=\"0x01\"/>						\
-    </sequence>								\
-  </attribute>								\
-</record>"
-
-
 struct aparam_header {
 	uint8_t tag;
 	uint8_t len;
@@ -488,9 +442,6 @@ static struct obex_mime_type_driver irmc_driver = {
 static struct obex_service_driver irmc = {
 	.name = "IRMC Sync server",
 	.service = OBEX_IRMC,
-	.channel = IRMC_CHANNEL,
-	.secure = TRUE,
-	.record = IRMC_RECORD,
 	.target = IRMC_TARGET,
 	.target_size = IRMC_TARGET_SIZE,
 	.connect = irmc_connect,
-- 
1.7.11.7

