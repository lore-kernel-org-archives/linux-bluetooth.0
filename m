Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 07/11] opp: Remove record details
Date: Wed, 12 Dec 2012 13:52:12 +0200
Message-Id: <1355313136-7891-7-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1355313136-7891-1-git-send-email-luiz.dentz@gmail.com>
References: <1355313136-7891-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Standart service records are already supported by bluetoothd
---
 obexd/plugins/opp.c | 56 -----------------------------------------------------
 1 file changed, 56 deletions(-)

diff --git a/obexd/plugins/opp.c b/obexd/plugins/opp.c
index c7ddc63..faa4437 100644
--- a/obexd/plugins/opp.c
+++ b/obexd/plugins/opp.c
@@ -44,59 +44,6 @@
 #define VCARD_TYPE "text/x-vcard"
 #define VCARD_FILE CONFIGDIR "/vcard.vcf"
 
-#define OPP_CHANNEL	9
-#define OPP_RECORD "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>	\
-<record>							\
-  <attribute id=\"0x0001\">					\
-    <sequence>							\
-      <uuid value=\"0x1105\"/>					\
-    </sequence>							\
-  </attribute>							\
-								\
-  <attribute id=\"0x0004\">					\
-    <sequence>							\
-      <sequence>						\
-        <uuid value=\"0x0100\"/>				\
-      </sequence>						\
-      <sequence>						\
-        <uuid value=\"0x0003\"/>				\
-        <uint8 value=\"%u\" name=\"channel\"/>			\
-      </sequence>						\
-      <sequence>						\
-        <uuid value=\"0x0008\"/>				\
-      </sequence>						\
-    </sequence>							\
-  </attribute>							\
-								\
-  <attribute id=\"0x0009\">					\
-    <sequence>							\
-      <sequence>						\
-        <uuid value=\"0x1105\"/>				\
-        <uint16 value=\"0x0102\" name=\"version\"/>		\
-      </sequence>						\
-    </sequence>							\
-  </attribute>							\
-								\
-  <attribute id=\"0x0100\">					\
-    <text value=\"%s\" name=\"name\"/>				\
-  </attribute>							\
-								\
-  <attribute id=\"0x0303\">					\
-    <sequence>							\
-      <uint8 value=\"0x01\"/>					\
-      <uint8 value=\"0x02\"/>					\
-      <uint8 value=\"0x03\"/>					\
-      <uint8 value=\"0x04\"/>					\
-      <uint8 value=\"0x05\"/>					\
-      <uint8 value=\"0x06\"/>					\
-      <uint8 value=\"0xff\"/>					\
-    </sequence>							\
-  </attribute>							\
-  <attribute id=\"0x0200\">					\
-    <uint16 value=\"%u\" name=\"psm\"/>				\
-  </attribute>							\
-</record>"
-
 static void *opp_connect(struct obex_session *os, int *err)
 {
 	manager_register_transfer(os);
@@ -219,9 +166,6 @@ static void opp_reset(struct obex_session *os, void *user_data)
 static struct obex_service_driver driver = {
 	.name = "Object Push server",
 	.service = OBEX_OPP,
-	.channel = OPP_CHANNEL,
-	.port = OBEX_PORT_RANDOM,
-	.record = OPP_RECORD,
 	.connect = opp_connect,
 	.progress = opp_progress,
 	.disconnect = opp_disconnect,
-- 
1.7.11.7

