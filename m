Return-Path: <cyrus@holtmann.org>
From: Rakesh M K <rakesh.mk@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Rakesh M K <rakesh.mk@samsung.com>
Subject: [PATCH 1] src/profile: Add HSP default record for external profiles
Date: Tue, 25 Nov 2014 17:08:28 +0530
Message-id: <1416915508-27250-1-git-send-email-rakesh.mk@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/profile.c |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/src/profile.c b/src/profile.c
index 252063b..6e272c4 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -153,6 +153,44 @@
 		</attribute>						\
 	</record>"
 
+#define HSP_AG_RECORD							\
+	"<?xml version=\"1.0\" encoding=\"UTF-8\" ?>			\
+	<record>							\
+		<attribute id=\"0x0001\">				\
+			<sequence>					\
+				<uuid value=\"0x1112\" />		\
+				<uuid value=\"0x1203\" />		\
+			</sequence>					\
+		</attribute>						\
+		<attribute id=\"0x0004\">				\
+			<sequence>					\
+				<sequence>				\
+					<uuid value=\"0x0100\" />	\
+				</sequence>				\
+				<sequence>				\
+					<uuid value=\"0x0003\" />	\
+					<uint8 value=\"0x%02x\" />	\
+				</sequence>				\
+			</sequence>					\
+		</attribute>						\
+		<attribute id=\"0x0005\">				\
+			<sequence>					\
+				<uuid value=\"0x1002\" />		\
+			</sequence>					\
+		</attribute>						\
+		<attribute id=\"0x0009\">				\
+			<sequence>					\
+				<sequence>				\
+					<uuid value=\"0x1108\" />	\
+					<uint16 value=\"0x%04x\" />	\
+				</sequence>				\
+			</sequence>					\
+		</attribute>						\
+		<attribute id=\"0x0100\">				\
+			<text value=\"%s\" />				\
+		</attribute>						\
+	</record>"
+
 #define SPP_RECORD							\
 	"<?xml version=\"1.0\" encoding=\"UTF-8\" ?>			\
 	<record>							\
@@ -1704,6 +1742,13 @@ static char *get_hfp_ag_record(struct ext_profile *ext, struct ext_io *l2cap,
 						ext->name, ext->features);
 }
 
+static char *get_hsp_ag_record(struct ext_profile *ext, struct ext_io *l2cap,
+							struct ext_io *rfcomm)
+{
+	return g_strdup_printf(HSP_AG_RECORD, rfcomm->chan, ext->version,
+						ext->name);
+}
+
 static char *get_spp_record(struct ext_profile *ext, struct ext_io *l2cap,
 							struct ext_io *rfcomm)
 {
@@ -1913,6 +1958,8 @@ static struct default_settings {
 		.channel	= HSP_AG_DEFAULT_CHANNEL,
 		.authorize	= true,
 		.auto_connect	= true,
+		.get_record	= get_hsp_ag_record,
+		.version	= 0x0102,
 	}, {
 		.uuid		= OBEX_OPP_UUID,
 		.name		= "Object Push",
-- 
1.7.9.5

