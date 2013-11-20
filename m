Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv6 17/19] android/socket: Add SPP uuid to profile table
Date: Wed, 20 Nov 2013 12:24:35 +0200
Message-Id: <1384943077-5366-18-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1384943077-5366-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1384943077-5366-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/socket.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/android/socket.c b/android/socket.c
index 07588d5..32b2db6 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -45,6 +45,7 @@
 #include "utils.h"
 #include "socket.h"
 
+#define SPP_DEFAULT_CHANNEL	3
 #define OPP_DEFAULT_CHANNEL	9
 #define PBAP_DEFAULT_CHANNEL	15
 #define MAS_DEFAULT_CHANNEL	16
@@ -209,7 +210,13 @@ static struct profile_info {
 			0x80, 0x00, 0x00, 0x80, 0x5F, 0x9B, 0x34, 0xFB
 		},
 		.channel = MAS_DEFAULT_CHANNEL
-	}
+	}, {
+		.uuid = {
+			0x00, 0x00, 0x11, 0x01, 0x00, 0x00, 0x10, 0x00,
+			0x80, 0x00, 0x00, 0x80, 0x5F, 0x9B, 0x34, 0xFB
+		},
+		.channel = SPP_DEFAULT_CHANNEL
+	},
 };
 
 static uint32_t sdp_service_register(struct profile_info *profile)
-- 
1.7.10.4

