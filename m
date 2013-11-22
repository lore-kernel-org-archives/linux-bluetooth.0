Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv7 08/14] android/socket: Add MAS uuid to profile table
Date: Fri, 22 Nov 2013 10:34:49 +0200
Message-Id: <1385109295-11445-9-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1385109295-11445-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1385109295-11445-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/socket.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/android/socket.c b/android/socket.c
index a652a11..fa1aa3c 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -47,6 +47,7 @@
 
 #define OPP_DEFAULT_CHANNEL	9
 #define PBAP_DEFAULT_CHANNEL	15
+#define MAS_DEFAULT_CHANNEL	16
 
 #define SVC_HINT_OBEX 0x10
 
@@ -205,6 +206,12 @@ static struct profile_info {
 		.channel = OPP_DEFAULT_CHANNEL,
 		.svc_hint = SVC_HINT_OBEX,
 		.create_record = create_opp_record
+	}, {
+		.uuid = {
+			0x00, 0x00, 0x11, 0x32, 0x00, 0x00, 0x10, 0x00,
+			0x80, 0x00, 0x00, 0x80, 0x5F, 0x9B, 0x34, 0xFB
+		},
+		.channel = MAS_DEFAULT_CHANNEL
 	}
 };
 
-- 
1.8.3.2

