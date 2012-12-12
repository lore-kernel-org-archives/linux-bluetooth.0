Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 03/11] core: Add SYNC record
Date: Wed, 12 Dec 2012 13:52:08 +0200
Message-Id: <1355313136-7891-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1355313136-7891-1-git-send-email-luiz.dentz@gmail.com>
References: <1355313136-7891-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds SYNC record to detault settings
---
 src/profile.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/src/profile.c b/src/profile.c
index a3dd372..53d32b6 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -436,6 +436,46 @@
 		</attribute>						\
 	</record>"
 
+#define SYNC_RECORD							\
+	"<?xml version=\"1.0\" encoding=\"UTF-8\" ?>			\
+	<record>							\
+		<attribute id=\"0x0001\">				\
+			<sequence>					\
+				<uuid value=\"0x1104\"/>		\
+			</sequence>					\
+		</attribute>						\
+		<attribute id=\"0x0004\">				\
+			<sequence>					\
+				<sequence>				\
+					<uuid value=\"0x0100\"/>	\
+				</sequence>				\
+				<sequence>				\
+					<uuid value=\"0x0003\"/>	\
+					<uint8 value=\"0x%02x\"/>	\
+				</sequence>				\
+				<sequence>				\
+					<uuid value=\"0x0008\"/>	\
+				</sequence>				\
+			</sequence>					\
+		</attribute>						\
+		<attribute id=\"0x0009\">				\
+			<sequence>					\
+				<sequence>				\
+					<uuid value=\"0x1104\"/>	\
+					<uint16 value=\"0x%04x\" />	\
+				 </sequence>				\
+			</sequence>					\
+		</attribute>						\
+		<attribute id=\"0x0100\">				\
+			<text value=\"%s\"/>				\
+		</attribute>						\
+		<attribute id=\"0x0301\">				\
+			<sequence>					\
+				<uint8 value=\"0x01\"/>			\
+			</sequence>					\
+		</attribute>						\
+	</record>"
+
 #define GENERIC_RECORD							\
 	"<?xml version=\"1.0\" encoding=\"UTF-8\" ?>			\
 	<record>							\
@@ -1618,6 +1658,13 @@ static char *get_mas_record(struct ext_profile *ext, struct ext_io *l2cap,
 								ext->name);
 }
 
+static char *get_sync_record(struct ext_profile *ext, struct ext_io *l2cap,
+							struct ext_io *rfcomm)
+{
+	return g_strdup_printf(SYNC_RECORD, rfcomm->chan, ext->version,
+								ext->name);
+}
+
 static char *get_opp_record(struct ext_profile *ext, struct ext_io *l2cap,
 							struct ext_io *rfcomm)
 {
@@ -1777,6 +1824,8 @@ static struct default_settings {
 		.uuid		= OBEX_SYNC_UUID,
 		.name		= "Synchronization",
 		.channel	= SYNC_DEFAULT_CHANNEL,
+		.get_record	= get_sync_record,
+		.version	= 0x0100,
 	}, {
 		.uuid		= OBEX_PSE_UUID,
 		.name		= "Phone Book Access",
-- 
1.7.11.7

