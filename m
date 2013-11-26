Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/6] android/socket: Use security level for connect / listen
Date: Tue, 26 Nov 2013 16:05:46 +0200
Message-Id: <1385474750-18331-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1385474750-18331-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1385474750-18331-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Use MEDIUM security level for connections without profile and default
sec_level for others. rfsock now has pointer to profile info.
---
 android/socket.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/android/socket.c b/android/socket.c
index 184deae..20dbc5e 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -70,6 +70,8 @@ struct rfcomm_sock {
 
 	bdaddr_t dst;
 	uint32_t service_handle;
+
+	const struct profile_info *profile;
 };
 
 static struct rfcomm_sock *create_rfsock(int sock, int *hal_fd)
@@ -667,7 +669,7 @@ static int handle_listen(void *buf)
 			return -1;
 		else {
 			chan = cmd->channel;
-			sec_level = BT_IO_SEC_LOW;
+			sec_level = BT_IO_SEC_MEDIUM;
 		}
 	} else {
 		chan = profile->channel;
@@ -786,6 +788,7 @@ fail:
 static void sdp_search_cb(sdp_list_t *recs, int err, gpointer data)
 {
 	struct rfcomm_sock *rfsock = data;
+	BtIOSecLevel sec_level = BT_IO_SEC_MEDIUM;
 	GError *gerr = NULL;
 	sdp_list_t *list;
 	GIOChannel *io;
@@ -829,11 +832,14 @@ static void sdp_search_cb(sdp_list_t *recs, int err, gpointer data)
 
 	DBG("Got RFCOMM channel %d", chan);
 
+	if (rfsock->profile)
+		sec_level = rfsock->profile->sec_level;
+
 	io = bt_io_connect(connect_cb, rfsock, NULL, &gerr,
 				BT_IO_OPT_SOURCE_BDADDR, &adapter_addr,
 				BT_IO_OPT_DEST_BDADDR, &rfsock->dst,
 				BT_IO_OPT_CHANNEL, chan,
-				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
+				BT_IO_OPT_SEC_LEVEL, sec_level,
 				BT_IO_OPT_INVALID);
 	if (!io) {
 		error("Failed connect: %s", gerr->message);
@@ -875,6 +881,8 @@ static int handle_connect(void *buf)
 	uuid.type = SDP_UUID128;
 	memcpy(&uuid.value.uuid128, cmd->uuid, sizeof(uint128_t));
 
+	rfsock->profile = get_profile_by_uuid(cmd->uuid);
+
 	if (bt_search_service(&adapter_addr, &dst, &uuid, sdp_search_cb, rfsock,
 								NULL) < 0) {
 		error("Failed to search SDP records");
-- 
1.8.3.2

