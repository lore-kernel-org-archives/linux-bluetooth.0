Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH] src/profile: Add GoepL2CapPsm in SDP record
Date: Wed, 05 Aug 2015 18:26:15 +0530
Message-id: <1438779375-12187-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

As per the MAP & PBAP v1.2 SDP table, it should contain the GoepL2CapPsm
in its SDP record. This patch adds the same.

The below test cases verifies the presence of GoepL2CapPsm attribute is
in SDP record.
TC_PSE_CON_BV_02_C - PASS
TC_MSE_CON_BV_02_C - PASS
---
 src/profile.c | 38 +++++++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 7 deletions(-)

diff --git a/src/profile.c b/src/profile.c
index 4b73026..f54749e 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -435,6 +435,9 @@
 		<attribute id=\"0x0317\">				\
 			<uint32 value=\"0x00000003\"/>			\
 		</attribute>						\
+		<attribute id=\"0x0200\">				\
+			<uint16 value=\"%u\" name=\"psm\"/>		\
+		</attribute>						\
 	</record>"
 
 #define MAS_RECORD							\
@@ -484,6 +487,9 @@
 		<attribute id=\"0x0317\">				\
 			<uint32 value=\"0x0000007f\"/>			\
 		</attribute>						\
+		<attribute id=\"0x0200\">				\
+			<uint16 value=\"%u\" name=\"psm\"/>		\
+		</attribute>						\
 	</record>"
 
 #define MNS_RECORD							\
@@ -524,12 +530,12 @@
 		<attribute id=\"0x0100\">				\
 			<text value=\"%s\"/>				\
 		</attribute>						\
-		<attribute id=\"0x0200\">				\
-			<uint16 value=\"%u\" name=\"psm\"/>		\
-		</attribute>						\
 		<attribute id=\"0x0317\">				\
 			<uint32 value=\"0x0000007f\"/>			\
 		</attribute>						\
+		<attribute id=\"0x0200\">				\
+			<uint16 value=\"%u\" name=\"psm\"/>		\
+		</attribute>						\
 	</record>"
 
 #define SYNC_RECORD							\
@@ -1792,15 +1798,29 @@ static char *get_pce_record(struct ext_profile *ext, struct ext_io *l2cap,
 static char *get_pse_record(struct ext_profile *ext, struct ext_io *l2cap,
 							struct ext_io *rfcomm)
 {
-	return g_strdup_printf(PSE_RECORD, rfcomm->chan, ext->version,
-								ext->name);
+	uint16_t psm = 0;
+	uint8_t chan = 0;
+
+	if (l2cap)
+		psm = l2cap->psm;
+	if (rfcomm)
+		chan = rfcomm->chan;
+
+	return g_strdup_printf(PSE_RECORD, chan, ext->version, ext->name, psm);
 }
 
 static char *get_mas_record(struct ext_profile *ext, struct ext_io *l2cap,
 							struct ext_io *rfcomm)
 {
-	return g_strdup_printf(MAS_RECORD, rfcomm->chan, ext->version,
-								ext->name);
+	uint16_t psm = 0;
+	uint8_t chan = 0;
+
+	if (l2cap)
+		psm = l2cap->psm;
+	if (rfcomm)
+		chan = rfcomm->chan;
+
+	return g_strdup_printf(MAS_RECORD, chan, ext->version, ext->name, psm);
 }
 
 static char *get_mns_record(struct ext_profile *ext, struct ext_io *l2cap,
@@ -2001,6 +2021,8 @@ static struct default_settings {
 		.uuid		= OBEX_PSE_UUID,
 		.name		= "Phone Book Access",
 		.channel	= PBAP_DEFAULT_CHANNEL,
+		.psm		= BTD_PROFILE_PSM_AUTO,
+		.mode		= BT_IO_MODE_ERTM,
 		.authorize	= true,
 		.get_record	= get_pse_record,
 		.version	= 0x0101,
@@ -2015,6 +2037,8 @@ static struct default_settings {
 		.uuid		= OBEX_MAS_UUID,
 		.name		= "Message Access",
 		.channel	= MAS_DEFAULT_CHANNEL,
+		.psm		= BTD_PROFILE_PSM_AUTO,
+		.mode		= BT_IO_MODE_ERTM,
 		.authorize	= true,
 		.get_record	= get_mas_record,
 		.version	= 0x0100
-- 
1.9.1

