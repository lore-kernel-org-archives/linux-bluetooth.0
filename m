Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 11/11] android/socket: Fix sockets security
Date: Tue, 11 Feb 2014 17:58:21 +0100
Message-ID: <1392137901-3403-12-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1392137901-3403-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1392137901-3403-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Socket security shall be based on flags passed from HAL.

Android public API uses both encrypt and auth flags for "secure"
sockets which should be mapped to high security on our side, but since
this would also trigger requirement for 16-digits pin code (which is
not used in Android) we'll ignore auth flag and use either low or
medium security based on encrypt flag value only.
---
 android/hal-msg.h |  3 +++
 android/socket.c  | 29 +++++++++++++++++++----------
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index aba98ed..6ef00f9 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -235,6 +235,9 @@ struct hal_cmd_le_test_mode {
 #define HAL_SOCK_SCO		0x02
 #define HAL_SOCK_L2CAP		0x03
 
+#define HAL_SOCK_FLAG_ENCRYPT	0x01
+#define HAL_SOCK_FLAG_AUTH	0x02
+
 #define HAL_OP_SOCK_LISTEN		0x01
 struct hal_cmd_sock_listen {
 	uint8_t type;
diff --git a/android/socket.c b/android/socket.c
index c790c24..4e9121d 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -70,6 +70,7 @@ GList *connections = NULL;
 
 struct rfcomm_sock {
 	int channel;	/* RFCOMM channel */
+	BtIOSecLevel sec_level;
 
 	/* for socket to BT */
 	int bt_sock;
@@ -84,8 +85,6 @@ struct rfcomm_sock {
 
 	uint8_t *buf;
 	int buf_size;
-
-	const struct profile_info *profile;
 };
 
 struct rfcomm_channel {
@@ -721,6 +720,19 @@ static int find_free_channel(void)
 	return 0;
 }
 
+static BtIOSecLevel get_sec_level(uint8_t flags)
+{
+	/* HAL_SOCK_FLAG_AUTH should require MITM but in our case setting
+	 * security to BT_IO_SEC_HIGH would also require 16-digits PIN code
+	 * for pre-2.1 devices which is not what Android expects. For this
+	 * reason we ignore this flag to not break apps which use "secure"
+	 * sockets (have both auth and encrypt flags set, there is no public
+	 * API in Android which should provide proper high security socket).
+	 */
+	return flags & HAL_SOCK_FLAG_ENCRYPT ? BT_IO_SEC_MEDIUM :
+							BT_IO_SEC_LOW;
+}
+
 static uint8_t rfcomm_listen(int chan, const uint8_t *name, const uint8_t *uuid,
 						uint8_t flags, int *hal_sock)
 {
@@ -748,7 +760,7 @@ static uint8_t rfcomm_listen(int chan, const uint8_t *name, const uint8_t *uuid,
 
 	profile = get_profile_by_uuid(uuid);
 	if (!profile) {
-		sec_level = BT_IO_SEC_MEDIUM;
+		sec_level = get_sec_level(flags);
 	} else {
 		if (!profile->create_record)
 			return HAL_STATUS_INVALID;
@@ -931,20 +943,16 @@ fail:
 
 static bool do_rfcomm_connect(struct rfcomm_sock *rfsock, int chan)
 {
-	BtIOSecLevel sec_level = BT_IO_SEC_MEDIUM;
 	GIOChannel *io;
 	GError *gerr = NULL;
 
-	if (rfsock->profile)
-		sec_level = rfsock->profile->sec_level;
-
-	DBG("rfsock %p sec_level %d chan %d", rfsock, sec_level, chan);
+	DBG("rfsock %p sec_level %d chan %d", rfsock, rfsock->sec_level, chan);
 
 	io = bt_io_connect(connect_cb, rfsock, NULL, &gerr,
 				BT_IO_OPT_SOURCE_BDADDR, &adapter_addr,
 				BT_IO_OPT_DEST_BDADDR, &rfsock->dst,
 				BT_IO_OPT_CHANNEL, chan,
-				BT_IO_OPT_SEC_LEVEL, sec_level,
+				BT_IO_OPT_SEC_LEVEL, rfsock->sec_level,
 				BT_IO_OPT_INVALID);
 	if (!io) {
 		error("Failed connect: %s", gerr->message);
@@ -1047,13 +1055,14 @@ static uint8_t connect_rfcomm(const bdaddr_t *addr, int chan,
 	DBG("rfsock %p jv_sock %d hal_sock %d", rfsock, rfsock->jv_sock,
 							*hal_sock);
 
+	rfsock->sec_level = get_sec_level(flags);
+
 	bacpy(&rfsock->dst, addr);
 
 	if (!memcmp(uuid, zero_uuid, sizeof(zero_uuid))) {
 		if (!do_rfcomm_connect(rfsock, chan))
 			goto failed;
 	} else {
-		rfsock->profile = get_profile_by_uuid(uuid);
 
 		if (bt_search_service(&adapter_addr, &rfsock->dst, &uu,
 					sdp_search_cb, rfsock, NULL, 0) < 0) {
-- 
1.8.5.3

