Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 4/6] android/socket: Reserve channel for HSP AG
Date: Fri, 28 Feb 2014 17:19:32 +0100
Message-Id: <1393604374-10127-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1393604374-10127-1-git-send-email-szymon.janc@tieto.com>
References: <1393604374-10127-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/socket.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/android/socket.c b/android/socket.c
index ee98b54..f6863c8 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -47,8 +47,9 @@
 
 #define RFCOMM_CHANNEL_MAX 30
 
+#define HSP_AG_DEFAULT_CHANNEL	11
 #define OPP_DEFAULT_CHANNEL	12
-#define HFAG_DEFAULT_CHANNEL	13
+#define HFP_AG_DEFAULT_CHANNEL	13
 #define PBAP_DEFAULT_CHANNEL	19
 
 #define SVC_HINT_OBEX 0x10
@@ -373,10 +374,19 @@ static const struct profile_info {
 } profiles[] = {
 	{
 		.uuid = {
+			0x00, 0x00, 0x11, 0x08, 0x00, 0x00, 0x10, 0x00,
+			0x80, 0x00, 0x00, 0x80, 0x5F, 0x9B, 0x34, 0xFB
+		},
+		.channel = HSP_AG_DEFAULT_CHANNEL,
+		.svc_hint = 0,
+		.sec_level = BT_IO_SEC_MEDIUM,
+		.create_record = NULL
+	}, {
+		.uuid = {
 			0x00, 0x00, 0x11, 0x1F, 0x00, 0x00, 0x10, 0x00,
 			0x80, 0x00, 0x00, 0x80, 0x5F, 0x9B, 0x34, 0xFB
 		},
-		.channel = HFAG_DEFAULT_CHANNEL,
+		.channel = HFP_AG_DEFAULT_CHANNEL,
 		.svc_hint = 0,
 		.sec_level = BT_IO_SEC_MEDIUM,
 		.create_record = NULL
-- 
1.8.3.2

