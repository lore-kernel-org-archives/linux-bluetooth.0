Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] core: Add mode option to external profile default configuration
Date: Thu, 20 Jun 2013 13:50:47 +0300
Message-Id: <1371725447-5581-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Some external profiles, FTP and OPP, require a different L2CAP mode such
as ERTM to interoperate properly.
---
 src/profile.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/profile.c b/src/profile.c
index 9f98d65..52ef775 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -562,6 +562,7 @@ struct ext_profile {
 
 	guint id;
 
+	BtIOMode mode;
 	BtIOSecLevel sec_level;
 	bool authorize;
 
@@ -1260,6 +1261,7 @@ static uint32_t ext_start_servers(struct ext_profile *ext,
 		io = bt_io_listen(connect, confirm, l2cap, NULL, &err,
 					BT_IO_OPT_SOURCE_BDADDR,
 					adapter_get_address(adapter),
+					BT_IO_OPT_MODE, ext->mode,
 					BT_IO_OPT_PSM, psm,
 					BT_IO_OPT_SEC_LEVEL, ext->sec_level,
 					BT_IO_OPT_INVALID);
@@ -1891,6 +1893,7 @@ static struct default_settings {
 	const char	*remote_uuid;
 	int		channel;
 	int		psm;
+	BtIOMode	mode;
 	BtIOSecLevel	sec_level;
 	bool		authorize;
 	bool		auto_connect;
@@ -1942,6 +1945,7 @@ static struct default_settings {
 		.name		= "Object Push",
 		.channel	= OPP_DEFAULT_CHANNEL,
 		.psm		= BTD_PROFILE_PSM_AUTO,
+		.mode		= BT_IO_MODE_ERTM,
 		.sec_level	= BT_IO_SEC_LOW,
 		.authorize	= false,
 		.get_record	= get_opp_record,
@@ -1951,6 +1955,7 @@ static struct default_settings {
 		.name		= "File Transfer",
 		.channel	= FTP_DEFAULT_CHANNEL,
 		.psm		= BTD_PROFILE_PSM_AUTO,
+		.mode		= BT_IO_MODE_ERTM,
 		.get_record	= get_ftp_record,
 		.version	= 0x0102,
 	}, {
@@ -2020,6 +2025,9 @@ static void ext_set_defaults(struct ext_profile *ext)
 		if (settings->sec_level)
 			ext->sec_level = settings->sec_level;
 
+		if (settings->mode)
+			ext->mode = settings->mode;
+
 		if (settings->auto_connect)
 			ext->p.auto_connect = true;
 
-- 
1.8.1.4

