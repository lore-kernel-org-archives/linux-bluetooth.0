Return-Path: <cyrus@holtmann.org>
From: martin.xu@linux.intel.com
To: linux-bluetooth@vger.kernel.org
Cc: Martin <martin.xu@linux.intel.com>
Subject: [PATCH 1/3] Profile: fix set default exteranl profile authorize
Date: Mon, 15 Jul 2013 11:06:08 +0800
Message-Id: <1373857569-4191-1-git-send-email-martin.xu@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Martin <martin.xu@linux.intel.com>

authorize is always set as "true" in function ext_set_defaults().

the static variable authorize of default_settings will be 0(false),
if it is not initialized. So item authorize needs to be initized if
the value is true (non-0).
And then function ext_set_defaults() can set default authorize properly
---
 src/profile.c |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/src/profile.c b/src/profile.c
index c745811..8e69790 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -1907,12 +1907,14 @@ static struct default_settings {
 		.uuid		= SPP_UUID,
 		.name		= "Serial Port",
 		.channel	= SPP_DEFAULT_CHANNEL,
+		.authorize	= true,
 		.get_record	= get_spp_record,
 		.version	= 0x0102,
 	}, {
 		.uuid		= DUN_GW_UUID,
 		.name		= "Dial-Up Networking",
 		.channel	= DUN_DEFAULT_CHANNEL,
+		.authorize	= true,
 		.get_record	= get_dun_record,
 		.version	= 0x0102,
 	}, {
@@ -1921,6 +1923,7 @@ static struct default_settings {
 		.priority	= BTD_PROFILE_PRIORITY_HIGH,
 		.remote_uuid	= HFP_AG_UUID,
 		.channel	= HFP_HF_DEFAULT_CHANNEL,
+		.authorize	= true,
 		.auto_connect	= true,
 		.get_record	= get_hfp_hf_record,
 		.version	= 0x0105,
@@ -1930,6 +1933,7 @@ static struct default_settings {
 		.priority	= BTD_PROFILE_PRIORITY_HIGH,
 		.remote_uuid	= HFP_HS_UUID,
 		.channel	= HFP_AG_DEFAULT_CHANNEL,
+		.authorize	= true,
 		.auto_connect	= true,
 		.get_record	= get_hfp_ag_record,
 		.version	= 0x0105,
@@ -1939,6 +1943,7 @@ static struct default_settings {
 		.priority	= BTD_PROFILE_PRIORITY_HIGH,
 		.remote_uuid	= HSP_HS_UUID,
 		.channel	= HSP_AG_DEFAULT_CHANNEL,
+		.authorize	= true,
 		.auto_connect	= true,
 	}, {
 		.uuid		= OBEX_OPP_UUID,
@@ -1947,7 +1952,6 @@ static struct default_settings {
 		.psm		= BTD_PROFILE_PSM_AUTO,
 		.mode		= BT_IO_MODE_ERTM,
 		.sec_level	= BT_IO_SEC_LOW,
-		.authorize	= false,
 		.get_record	= get_opp_record,
 		.version	= 0x0102,
 	}, {
@@ -1956,30 +1960,35 @@ static struct default_settings {
 		.channel	= FTP_DEFAULT_CHANNEL,
 		.psm		= BTD_PROFILE_PSM_AUTO,
 		.mode		= BT_IO_MODE_ERTM,
+		.authorize	= true,
 		.get_record	= get_ftp_record,
 		.version	= 0x0102,
 	}, {
 		.uuid		= OBEX_SYNC_UUID,
 		.name		= "Synchronization",
 		.channel	= SYNC_DEFAULT_CHANNEL,
+		.authorize	= true,
 		.get_record	= get_sync_record,
 		.version	= 0x0100,
 	}, {
 		.uuid		= OBEX_PSE_UUID,
 		.name		= "Phone Book Access",
 		.channel	= PBAP_DEFAULT_CHANNEL,
+		.authorize	= true,
 		.get_record	= get_pse_record,
 		.version	= 0x0101,
 	}, {
 		.uuid		= OBEX_PCE_UUID,
 		.name		= "Phone Book Access Client",
 		.remote_uuid	= OBEX_PSE_UUID,
+		.authorize	= true,
 		.get_record	= get_pce_record,
 		.version	= 0x0101,
 	}, {
 		.uuid		= OBEX_MAS_UUID,
 		.name		= "Message Access",
 		.channel	= MAS_DEFAULT_CHANNEL,
+		.authorize	= true,
 		.get_record	= get_mas_record,
 		.version	= 0x0100
 	}, {
@@ -1987,6 +1996,7 @@ static struct default_settings {
 		.name		= "Message Notification",
 		.channel	= MNS_DEFAULT_CHANNEL,
 		.psm		= BTD_PROFILE_PSM_AUTO,
+		.authorize	= true,
 		.get_record	= get_mns_record,
 		.version	= 0x0100
 	},
@@ -1998,7 +2008,6 @@ static void ext_set_defaults(struct ext_profile *ext)
 
 	ext->mode = BT_IO_MODE_BASIC;
 	ext->sec_level = BT_IO_SEC_MEDIUM;
-	ext->authorize = true;
 	ext->enable_client = true;
 	ext->enable_server = true;
 	ext->remote_uuid = NULL;
@@ -2029,6 +2038,8 @@ static void ext_set_defaults(struct ext_profile *ext)
 		if (settings->mode)
 			ext->mode = settings->mode;
 
+		ext->authorize = settings->authorize;
+
 		if (settings->auto_connect)
 			ext->p.auto_connect = true;
 
-- 
1.7.10.4

