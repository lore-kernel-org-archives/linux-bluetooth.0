Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/6] android/socket: Make profile struct const
Date: Tue, 26 Nov 2013 16:05:45 +0200
Message-Id: <1385474750-18331-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

We are not supposed to change profile structure, make it const.
---
 android/socket.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/android/socket.c b/android/socket.c
index 83e6996..184deae 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -335,7 +335,7 @@ static sdp_record_t *create_spp_record(uint8_t chan, const char *svc_name)
 	return record;
 }
 
-static struct profile_info {
+static const struct profile_info {
 	uint8_t		uuid[16];
 	uint8_t		channel;
 	uint8_t		svc_hint;
@@ -381,7 +381,7 @@ static struct profile_info {
 	},
 };
 
-static uint32_t sdp_service_register(struct profile_info *profile,
+static uint32_t sdp_service_register(const struct profile_info *profile,
 							const void *svc_name)
 {
 	sdp_record_t *record;
@@ -444,7 +444,7 @@ static int bt_sock_send_fd(int sock_fd, const void *buf, int len, int send_fd)
 	return ret;
 }
 
-static struct profile_info *get_profile_by_uuid(const uint8_t *uuid)
+static const struct profile_info *get_profile_by_uuid(const uint8_t *uuid)
 {
 	unsigned int i;
 
@@ -651,7 +651,7 @@ static void accept_cb(GIOChannel *io, GError *err, gpointer user_data)
 static int handle_listen(void *buf)
 {
 	struct hal_cmd_sock_listen *cmd = buf;
-	struct profile_info *profile;
+	const struct profile_info *profile;
 	struct rfcomm_sock *rfsock;
 	BtIOSecLevel sec_level;
 	GIOChannel *io;
-- 
1.8.3.2

