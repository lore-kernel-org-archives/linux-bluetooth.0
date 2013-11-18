Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4 17/17] android/socket: Add MAS uuid to channel mapping
Date: Mon, 18 Nov 2013 15:20:54 +0200
Message-Id: <1384780854-20970-18-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1384780854-20970-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1384780854-20970-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/socket.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/android/socket.c b/android/socket.c
index 5e25b14..3e67a53 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -46,6 +46,7 @@
 
 #define OPP_DEFAULT_CHANNEL	9
 #define PBAP_DEFAULT_CHANNEL	15
+#define MAS_DEFAULT_CHANNEL	16
 
 /* Use Object Transfer for all services */
 #define SVC_HINT_OBEX 0x10
@@ -117,6 +118,12 @@ static struct {
 			0x80, 0x00, 0x00, 0x80, 0x5F, 0x9B, 0x34, 0xFB
 		  },
 		.channel = OPP_DEFAULT_CHANNEL
+	}, {
+		.uuid = {
+			0x00, 0x00, 0x11, 0x32, 0x00, 0x00, 0x10, 0x00,
+			0x80, 0x00, 0x00, 0x80, 0x5F, 0x9B, 0x34, 0xFB
+		},
+		.channel = MAS_DEFAULT_CHANNEL
 	}
 };
 
-- 
1.7.10.4

