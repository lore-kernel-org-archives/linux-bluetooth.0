Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv8 06/15] android/socket: Add general service create/remove function
Date: Mon, 25 Nov 2013 11:44:49 +0200
Message-Id: <1385372698-16212-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1385372698-16212-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1385372698-16212-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

create_record function from profile is used to create SDP service record.
The record is removed from rfsock cleanup function.
---
 android/socket.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/android/socket.c b/android/socket.c
index 9f8c535..71dcf4a 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -35,7 +35,9 @@
 #include "lib/sdp.h"
 #include "lib/sdp_lib.h"
 #include "src/sdp-client.h"
+#include "src/sdpd.h"
 
+#include "bluetooth.h"
 #include "log.h"
 #include "hal-msg.h"
 #include "hal-ipc.h"
@@ -63,6 +65,7 @@ struct rfcomm_sock {
 	guint stack_watch;
 
 	bdaddr_t dst;
+	uint32_t service_handle;
 };
 
 static struct rfcomm_sock *create_rfsock(int sock, int *hal_fd)
@@ -102,6 +105,9 @@ static void cleanup_rfsock(struct rfcomm_sock *rfsock)
 		if (!g_source_remove(rfsock->stack_watch))
 			error("stack_watch source was not found");
 
+	if (rfsock->service_handle)
+		bt_adapter_remove_record(rfsock->service_handle);
+
 	g_free(rfsock);
 }
 
@@ -110,7 +116,7 @@ static struct profile_info {
 	uint8_t		channel;
 	uint8_t		svc_hint;
 	BtIOSecLevel	sec_level;
-	sdp_record_t *	(*create_record)(uint8_t chan);
+	sdp_record_t *	(*create_record)(uint8_t chan, const char *svc_name);
 } profiles[] = {
 	{
 		.uuid = {
@@ -127,6 +133,24 @@ static struct profile_info {
 	}
 };
 
+static uint32_t sdp_service_register(struct profile_info *profile,
+							const void *svc_name)
+{
+	sdp_record_t *record;
+
+	record = profile->create_record(profile->channel, svc_name);
+	if (!record)
+		return 0;
+
+	if (bt_adapter_add_record(record, profile->svc_hint) < 0) {
+		error("Failed to register on SDP record");
+		sdp_record_free(record);
+		return 0;
+	}
+
+	return record->handle;
+}
+
 static int bt_sock_send_fd(int sock_fd, const void *buf, int len, int send_fd)
 {
 	ssize_t ret;
@@ -388,7 +412,7 @@ static int handle_listen(void *buf)
 
 	chan = profile->channel;
 
-	DBG("rfcomm channel %d", chan);
+	DBG("rfcomm channel %d svc_name %s", chan, cmd->name);
 
 	rfsock = create_rfsock(-1, &hal_fd);
 	if (!rfsock)
@@ -421,6 +445,8 @@ static int handle_listen(void *buf)
 		return -1;
 	}
 
+	rfsock->service_handle = sdp_service_register(profile, cmd->name);
+
 	return hal_fd;
 }
 
-- 
1.8.3.2

