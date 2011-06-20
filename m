Return-Path: <cyrus@holtmann.org>
From: Nami <nami.li@atheros.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <haijun@qca.qualcomm.com>, <yongli@qca.qualcomm.com>,
	Nami <nami.li@atheros.com>
Subject: [PATCH obexd 04/14] FTP and OPP service register GoepL2capPsm attribute.
Date: Mon, 20 Jun 2011 17:44:50 +0800
Message-ID: <1308563100-18917-4-git-send-email-nami.li@atheros.com>
In-Reply-To: <1308563100-18917-1-git-send-email-nami.li@atheros.com>
References: <1308563100-18917-1-git-send-email-nami.li@atheros.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/bluetooth.c |    5 +++--
 plugins/ftp.c       |    2 ++
 plugins/opp.c       |    2 ++
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
index 851daa2..7f81e14 100644
--- a/plugins/bluetooth.c
+++ b/plugins/bluetooth.c
@@ -175,7 +175,7 @@ static void register_record(struct obex_server *server)
 			continue;

 		xml = g_markup_printf_escaped(driver->record, driver->channel,
-						driver->name);
+						driver->name, driver->psm);
 		add_record(any->path, xml, service);
 		g_free(xml);
 	}
@@ -207,7 +207,8 @@ static void find_adapter_any_reply(DBusPendingCall *call, void *user_data)

 		xml = g_markup_printf_escaped(service->driver->record,
 						service->driver->channel,
-						service->driver->name);
+						service->driver->name,
+						service->driver->psm);
 		add_record(any->path, xml, service);
 		g_free(xml);
 	}
diff --git a/plugins/ftp.c b/plugins/ftp.c
index d8e5356..c057fae 100644
--- a/plugins/ftp.c
+++ b/plugins/ftp.c
@@ -56,6 +56,7 @@
 #define CAP_TYPE "x-obex/capability"

 #define FTP_CHANNEL 10
+#define FTP_PSM 	0x1015
 #define FTP_RECORD "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>		\
 <record>								\
   <attribute id=\"0x0001\">						\
@@ -423,6 +424,7 @@ static struct obex_service_driver ftp = {
 	.name = "File Transfer server",
 	.service = OBEX_FTP,
 	.channel = FTP_CHANNEL,
+	.psm = FTP_PSM,
 	.record = FTP_RECORD,
 	.target = FTP_TARGET,
 	.target_size = TARGET_SIZE,
diff --git a/plugins/opp.c b/plugins/opp.c
index 7ea7e18..6fa71c3 100644
--- a/plugins/opp.c
+++ b/plugins/opp.c
@@ -44,6 +44,7 @@
 #define VCARD_FILE CONFIGDIR "/vcard.vcf"

 #define OPP_CHANNEL	9
+#define OPP_PSM		0x1009
 #define OPP_RECORD "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>	\
 <record>							\
   <attribute id=\"0x0001\">					\
@@ -214,6 +215,7 @@ static struct obex_service_driver driver = {
 	.name = "Object Push server",
 	.service = OBEX_OPP,
 	.channel = OPP_CHANNEL,
+	.psm = OPP_PSM,
 	.record = OPP_RECORD,
 	.connect = opp_connect,
 	.progress = opp_progress,
--
1.7.1

