Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 02/11] core: Add MAS record
Date: Wed, 12 Dec 2012 13:52:07 +0200
Message-Id: <1355313136-7891-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1355313136-7891-1-git-send-email-luiz.dentz@gmail.com>
References: <1355313136-7891-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds MAS record to detault settings
---
 src/profile.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/src/profile.c b/src/profile.c
index fba894c..a3dd372 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -395,6 +395,47 @@
 		</attribute>						\
 	</record>"
 
+#define MAS_RECORD							\
+	"<?xml version=\"1.0\" encoding=\"UTF-8\" ?>			\
+	<record>							\
+		<attribute id=\"0x0001\">				\
+			<sequence>					\
+				<uuid value=\"0x1132\"/>		\
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
+					<uuid value=\"0x1134\"/>	\
+					<uint16 value=\"0x%04x\" />	\
+				</sequence>				\
+			</sequence>					\
+		</attribute>						\
+		<attribute id=\"0x0100\">				\
+			<text value=\"%s\"/>				\
+		</attribute>						\
+		<attribute id=\"0x0315\">				\
+			<uint8 value=\"0x00\"/>				\
+		</attribute>						\
+		<attribute id=\"0x0316\">				\
+			<uint8 value=\"0x0F\"/>				\
+		</attribute>						\
+	</record>"
+
 #define GENERIC_RECORD							\
 	"<?xml version=\"1.0\" encoding=\"UTF-8\" ?>			\
 	<record>							\
@@ -1570,6 +1611,13 @@ static char *get_pse_record(struct ext_profile *ext, struct ext_io *l2cap,
 								ext->name);
 }
 
+static char *get_mas_record(struct ext_profile *ext, struct ext_io *l2cap,
+							struct ext_io *rfcomm)
+{
+	return g_strdup_printf(MAS_RECORD, rfcomm->chan, ext->version,
+								ext->name);
+}
+
 static char *get_opp_record(struct ext_profile *ext, struct ext_io *l2cap,
 							struct ext_io *rfcomm)
 {
@@ -1745,6 +1793,8 @@ static struct default_settings {
 		.uuid		= OBEX_MAS_UUID,
 		.name		= "Message Access",
 		.channel	= MAS_DEFAULT_CHANNEL,
+		.get_record	= get_mas_record,
+		.version	= 0x0100
 	}, {
 		.uuid		= OBEX_MNS_UUID,
 		.name		= "Message Notification",
-- 
1.7.11.7

