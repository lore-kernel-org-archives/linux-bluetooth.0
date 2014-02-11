Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 07/11] android/socket: Add support for dynamic channel numbers
Date: Tue, 11 Feb 2014 17:58:17 +0100
Message-ID: <1392137901-3403-8-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1392137901-3403-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1392137901-3403-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds support to register server with channel number assigned
dynamically, i.e. first free number is assigned. Channels which are
reserved for built-in services are not assigned for other services.
---
 android/socket.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/android/socket.c b/android/socket.c
index 4e823dd..e560609 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -677,6 +677,21 @@ static void accept_cb(GIOChannel *io, GError *err, gpointer user_data)
 	new_rfsock->bt_watch = id;
 }
 
+static int find_free_channel(void)
+{
+	int ch;
+
+	/* channel 0 is reserver so we don't use it */
+	for (ch = 1; ch <= RFCOMM_CHANNEL_MAX; ch++) {
+		struct rfcomm_channel *srv = &servers[ch];
+
+		if (!srv->reserved && srv->rfsock == NULL)
+			return ch;
+	}
+
+	return 0;
+}
+
 static uint8_t rfcomm_listen(int chan, const uint8_t *name, const uint8_t *uuid,
 						uint8_t flags, int *hal_sock)
 {
@@ -704,15 +719,20 @@ static uint8_t rfcomm_listen(int chan, const uint8_t *name, const uint8_t *uuid,
 
 	profile = get_profile_by_uuid(uuid);
 	if (!profile) {
-		if (chan <= 0)
-			return HAL_STATUS_INVALID;
-
 		sec_level = BT_IO_SEC_MEDIUM;
 	} else {
 		chan = profile->channel;
 		sec_level = profile->sec_level;
 	}
 
+	if (chan <= 0)
+		chan = find_free_channel();
+
+	if (!chan) {
+		error("No free channels");
+		return HAL_STATUS_BUSY;
+	}
+
 	if (servers[chan].rfsock != NULL) {
 		error("Channel already registered (%d)", chan);
 		return HAL_STATUS_BUSY;
-- 
1.8.5.3

