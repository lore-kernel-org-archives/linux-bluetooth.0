Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 09/11] android/socket: Include HF AG in built-in profiles
Date: Tue, 11 Feb 2014 17:58:19 +0100
Message-ID: <1392137901-3403-10-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1392137901-3403-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1392137901-3403-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds entry for HF AG profile in built-in profiles list. This
it to reserve channel number so it's not assigned to other service
registered by application. Method for creating SDP record is not
provided so it's not possible for application to register HF AG service
by mistake (this can be only done by handsfree profile implementation).
---
 android/socket.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/android/socket.c b/android/socket.c
index 9175bf3..4dcb5fc 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -49,6 +49,7 @@
 
 #define SPP_DEFAULT_CHANNEL	3
 #define OPP_DEFAULT_CHANNEL	9
+#define HFAG_DEFAULT_CHANNEL	13
 #define PBAP_DEFAULT_CHANNEL	15
 #define MAS_DEFAULT_CHANNEL	16
 
@@ -375,6 +376,15 @@ static const struct profile_info {
 } profiles[] = {
 	{
 		.uuid = {
+			0x00, 0x00, 0x11, 0x1F, 0x00, 0x00, 0x10, 0x00,
+			0x80, 0x00, 0x00, 0x80, 0x5F, 0x9B, 0x34, 0xFB
+		},
+		.channel = HFAG_DEFAULT_CHANNEL,
+		.svc_hint = 0,
+		.sec_level = BT_IO_SEC_MEDIUM,
+		.create_record = NULL
+	}, {
+		.uuid = {
 			0x00, 0x00, 0x11, 0x2F, 0x00, 0x00, 0x10, 0x00,
 			0x80, 0x00, 0x00, 0x80, 0x5F, 0x9B, 0x34, 0xFB
 		},
@@ -742,6 +752,9 @@ static uint8_t rfcomm_listen(int chan, const uint8_t *name, const uint8_t *uuid,
 	if (!profile) {
 		sec_level = BT_IO_SEC_MEDIUM;
 	} else {
+		if (!profile->create_record)
+			return HAL_STATUS_INVALID;
+
 		chan = profile->channel;
 		sec_level = profile->sec_level;
 	}
-- 
1.8.5.3

