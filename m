Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/5] android/socket: Move statics declarations after types definitions
Date: Tue, 18 Feb 2014 11:05:21 +0100
Message-Id: <1392717924-7712-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1392717924-7712-1-git-send-email-szymon.janc@tieto.com>
References: <1392717924-7712-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This also makes connections list static.
---
 android/socket.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/android/socket.c b/android/socket.c
index 1551e9b..36fffbd 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -60,14 +60,6 @@
 #define MAP_MSG_TYPE_SMS_CDMA	0x04
 #define DEFAULT_MAS_MSG_TYPE	(MAP_MSG_TYPE_SMS_GSM | MAP_MSG_TYPE_SMS_CDMA)
 
-
-static bdaddr_t adapter_addr;
-
-static const uint8_t zero_uuid[16] = { 0 };
-
-/* Simple list of RFCOMM connected sockets */
-GList *connections = NULL;
-
 struct rfcomm_sock {
 	int channel;	/* RFCOMM channel */
 	BtIOSecLevel sec_level;
@@ -92,6 +84,13 @@ struct rfcomm_channel {
 	struct rfcomm_sock *rfsock;
 };
 
+static bdaddr_t adapter_addr;
+
+static const uint8_t zero_uuid[16] = { 0 };
+
+/* Simple list of RFCOMM connected sockets */
+static GList *connections = NULL;
+
 static struct rfcomm_channel servers[RFCOMM_CHANNEL_MAX + 1];
 
 static int rfsock_set_buffer(struct rfcomm_sock *rfsock)
-- 
1.8.3.2

