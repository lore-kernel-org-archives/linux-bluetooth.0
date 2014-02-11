Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 10/11] android/socket: Update channel numbers
Date: Tue, 11 Feb 2014 17:58:20 +0100
Message-ID: <1392137901-3403-11-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1392137901-3403-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1392137901-3403-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

OPP and PBAP channel numbers are set to same values as in Bluedroid.
Both MAP and SPP use channel numbers assigned dynamically.
---
 android/socket.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/android/socket.c b/android/socket.c
index 4dcb5fc..c790c24 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -47,11 +47,9 @@
 
 #define RFCOMM_CHANNEL_MAX 30
 
-#define SPP_DEFAULT_CHANNEL	3
-#define OPP_DEFAULT_CHANNEL	9
+#define OPP_DEFAULT_CHANNEL	12
 #define HFAG_DEFAULT_CHANNEL	13
-#define PBAP_DEFAULT_CHANNEL	15
-#define MAS_DEFAULT_CHANNEL	16
+#define PBAP_DEFAULT_CHANNEL	19
 
 #define SVC_HINT_OBEX 0x10
 
@@ -406,7 +404,7 @@ static const struct profile_info {
 			0x00, 0x00, 0x11, 0x32, 0x00, 0x00, 0x10, 0x00,
 			0x80, 0x00, 0x00, 0x80, 0x5F, 0x9B, 0x34, 0xFB
 		},
-		.channel = MAS_DEFAULT_CHANNEL,
+		.channel = 0,
 		.svc_hint = SVC_HINT_OBEX,
 		.sec_level = BT_IO_SEC_MEDIUM,
 		.create_record = create_mas_record
@@ -415,7 +413,7 @@ static const struct profile_info {
 			0x00, 0x00, 0x11, 0x01, 0x00, 0x00, 0x10, 0x00,
 			0x80, 0x00, 0x00, 0x80, 0x5F, 0x9B, 0x34, 0xFB
 		},
-		.channel = SPP_DEFAULT_CHANNEL,
+		.channel = 0,
 		.svc_hint = 0,
 		.sec_level = BT_IO_SEC_MEDIUM,
 		.create_record = create_spp_record
-- 
1.8.5.3

