Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv2 2/7] android/socket: Use default sec_level for listen
Date: Mon, 25 Nov 2013 13:22:52 +0200
Message-Id: <1385378577-20503-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1385378577-20503-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1385378577-20503-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Set default security level low for OPP and SPP and medium for PBAP and MAS.
Default security level would be low for listening without profile.
---
 android/socket.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/android/socket.c b/android/socket.c
index 63587ee..0885fa2 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -344,6 +344,7 @@ static struct profile_info {
 		},
 		.channel = PBAP_DEFAULT_CHANNEL,
 		.svc_hint = SVC_HINT_OBEX,
+		.sec_level = BT_IO_SEC_MEDIUM,
 		.create_record = create_pbap_record
 	}, {
 		.uuid = {
@@ -352,13 +353,17 @@ static struct profile_info {
 		  },
 		.channel = OPP_DEFAULT_CHANNEL,
 		.svc_hint = SVC_HINT_OBEX,
+		.sec_level = BT_IO_SEC_LOW,
 		.create_record = create_opp_record
 	}, {
 		.uuid = {
 			0x00, 0x00, 0x11, 0x32, 0x00, 0x00, 0x10, 0x00,
 			0x80, 0x00, 0x00, 0x80, 0x5F, 0x9B, 0x34, 0xFB
 		},
-		.channel = MAS_DEFAULT_CHANNEL
+		.channel = MAS_DEFAULT_CHANNEL,
+		.svc_hint = 0,
+		.sec_level = BT_IO_SEC_MEDIUM,
+		.create_record = NULL
 	}, {
 		.uuid = {
 			0x00, 0x00, 0x11, 0x01, 0x00, 0x00, 0x10, 0x00,
@@ -366,6 +371,7 @@ static struct profile_info {
 		},
 		.channel = SPP_DEFAULT_CHANNEL,
 		.svc_hint = 0,
+		.sec_level = BT_IO_SEC_LOW,
 		.create_record = create_spp_record
 	},
 };
@@ -639,6 +645,7 @@ static int handle_listen(void *buf)
 	struct hal_cmd_sock_listen *cmd = buf;
 	struct profile_info *profile;
 	struct rfcomm_sock *rfsock;
+	BtIOSecLevel sec_level;
 	GIOChannel *io;
 	GError *err = NULL;
 	int hal_fd;
@@ -650,10 +657,14 @@ static int handle_listen(void *buf)
 	if (!profile) {
 		if (!cmd->channel)
 			return -1;
-		else
+		else {
 			chan = cmd->channel;
-	} else
+			sec_level = BT_IO_SEC_LOW;
+		}
+	} else {
 		chan = profile->channel;
+		sec_level = profile->sec_level;
+	}
 
 	DBG("rfcomm channel %d svc_name %s", chan, cmd->name);
 
@@ -664,6 +675,7 @@ static int handle_listen(void *buf)
 	io = bt_io_listen(accept_cb, NULL, rfsock, NULL, &err,
 				BT_IO_OPT_SOURCE_BDADDR, &adapter_addr,
 				BT_IO_OPT_CHANNEL, chan,
+				BT_IO_OPT_SEC_LEVEL, sec_level,
 				BT_IO_OPT_INVALID);
 	if (!io) {
 		error("Failed listen: %s", err->message);
-- 
1.8.3.2

