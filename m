Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/5] profile: Add MNS server record
Date: Tue,  9 Apr 2013 13:51:33 +0200
Message-Id: <1365508297-13032-2-git-send-email-christian.fetzer@oss.bmw-carit.de>
In-Reply-To: <1365508297-13032-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1365508297-13032-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

This adds the MNS server record to the profile default settings.
---
 src/profile.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/src/profile.c b/src/profile.c
index 29f9ee6..55e72dd 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -435,6 +435,44 @@
 		</attribute>						\
 	</record>"
 
+#define MNS_RECORD							\
+	"<?xml version=\"1.0\" encoding=\"UTF-8\" ?>			\
+	<record>							\
+		<attribute id=\"0x0001\">				\
+			<sequence>					\
+				<uuid value=\"0x1133\"/>		\
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
+					<uint16 value=\"0x%04x\"/>	\
+				</sequence>				\
+			</sequence>					\
+		</attribute>						\
+		<attribute id=\"0x0100\">				\
+			<text value=\"%s\"/>				\
+		</attribute>						\
+		<attribute id=\"0x0200\">				\
+			<uint16 value=\"%u\" name=\"psm\"/>		\
+		</attribute>						\
+	</record>"
+
 #define SYNC_RECORD							\
 	"<?xml version=\"1.0\" encoding=\"UTF-8\" ?>			\
 	<record>							\
@@ -1709,6 +1747,20 @@ static char *get_mas_record(struct ext_profile *ext, struct ext_io *l2cap,
 								ext->name);
 }
 
+static char *get_mns_record(struct ext_profile *ext, struct ext_io *l2cap,
+							struct ext_io *rfcomm)
+{
+	uint16_t psm = 0;
+	uint8_t chan = 0;
+
+	if (l2cap)
+		psm = l2cap->psm;
+	if (rfcomm)
+		chan = rfcomm->chan;
+
+	return g_strdup_printf(MNS_RECORD, chan, ext->version, ext->name, psm);
+}
+
 static char *get_sync_record(struct ext_profile *ext, struct ext_io *l2cap,
 							struct ext_io *rfcomm)
 {
@@ -1899,6 +1951,9 @@ static struct default_settings {
 		.uuid		= OBEX_MNS_UUID,
 		.name		= "Message Notification",
 		.channel	= MNS_DEFAULT_CHANNEL,
+		.psm		= BTD_PROFILE_PSM_AUTO,
+		.get_record	= get_mns_record,
+		.version	= 0x0100
 	},
 };
 
-- 
1.8.2.1

