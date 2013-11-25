Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv10 1/4] android/socket: Use security level for connect / listen
Date: Mon, 25 Nov 2013 16:10:22 +0200
Message-Id: <1385388625-3156-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <20131125134005.GB19445@x220.p-661hnu-f1>
References: <20131125134005.GB19445@x220.p-661hnu-f1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Use MEDIUM security level for connections without profile and default
sec_level for others. rfsock now has pointer to profile info.
---
 android/socket.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/android/socket.c b/android/socket.c
index 83e6996..e31e391 100644
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
@@ -667,7 +671,7 @@ static int handle_listen(void *buf)
 			return -1;
 		else {
 			chan = cmd->channel;
-			sec_level = BT_IO_SEC_LOW;
+			sec_level = BT_IO_SEC_MEDIUM;
 		}
 	} else {
 		chan = profile->channel;
@@ -786,6 +790,7 @@ fail:
 static void sdp_search_cb(sdp_list_t *recs, int err, gpointer data)
 {
 	struct rfcomm_sock *rfsock = data;
+	BtIOSecLevel sec_level = BT_IO_SEC_MEDIUM;
 	GError *gerr = NULL;
 	sdp_list_t *list;
 	GIOChannel *io;
@@ -829,11 +834,14 @@ static void sdp_search_cb(sdp_list_t *recs, int err, gpointer data)
 
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
@@ -875,6 +883,8 @@ static int handle_connect(void *buf)
 	uuid.type = SDP_UUID128;
 	memcpy(&uuid.value.uuid128, cmd->uuid, sizeof(uint128_t));
 
+	rfsock->profile = get_profile_by_uuid(cmd->uuid);
+
 	if (bt_search_service(&adapter_addr, &dst, &uuid, sdp_search_cb, rfsock,
 								NULL) < 0) {
 		error("Failed to search SDP records");
-- 
1.8.3.2

