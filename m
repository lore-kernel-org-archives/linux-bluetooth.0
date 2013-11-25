Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv2 4/7] android/socket: Use security level for connect
Date: Mon, 25 Nov 2013 13:22:54 +0200
Message-Id: <1385378577-20503-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1385378577-20503-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1385378577-20503-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Use low security level for connections without profile and default
sec_level for others. rfsock now has pointer to profile info for
outcoming connections.
---
 android/socket.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/android/socket.c b/android/socket.c
index 399590e..24503c5 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -60,6 +60,8 @@ GList *servers = NULL;
 /* Simple list of RFCOMM connected sockets */
 GList *connections = NULL;
 
+struct profile_info;
+
 struct rfcomm_sock {
 	int fd;		/* descriptor for communication with Java framework */
 	int real_sock;	/* real RFCOMM socket */
@@ -70,6 +72,8 @@ struct rfcomm_sock {
 
 	bdaddr_t dst;
 	uint32_t service_handle;
+
+	struct profile_info *profile;
 };
 
 static struct rfcomm_sock *create_rfsock(int sock, int *hal_fd)
@@ -785,6 +789,7 @@ fail:
 static void sdp_search_cb(sdp_list_t *recs, int err, gpointer data)
 {
 	struct rfcomm_sock *rfsock = data;
+	BtIOSecLevel sec_level = BT_IO_SEC_LOW;
 	GError *gerr = NULL;
 	sdp_list_t *list;
 	GIOChannel *io;
@@ -828,11 +833,14 @@ static void sdp_search_cb(sdp_list_t *recs, int err, gpointer data)
 
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
@@ -874,6 +882,8 @@ static int handle_connect(void *buf)
 	uuid.type = SDP_UUID128;
 	memcpy(&uuid.value.uuid128, cmd->uuid, sizeof(uint128_t));
 
+	rfsock->profile = get_profile_by_uuid(cmd->uuid);
+
 	if (bt_search_service(&adapter_addr, &dst, &uuid, sdp_search_cb, rfsock,
 								NULL) < 0) {
 		error("Failed to search SDP records");
-- 
1.8.3.2

