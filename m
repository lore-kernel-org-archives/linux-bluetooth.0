Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 03/11] android/socket: Improve logging
Date: Tue, 11 Feb 2014 17:58:13 +0100
Message-ID: <1392137901-3403-4-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1392137901-3403-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1392137901-3403-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch makes logging more consistent by including rfsock pointer in
most messages which identifies socket structure unambigously (instead
of using bunch of file descriptors for the same purpose) and puts other
parameters in order in some cases.

Additionally, some new logs are introduced to better track socket
structures and connections lifetime.
---
 android/socket.c | 71 ++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 43 insertions(+), 28 deletions(-)

diff --git a/android/socket.c b/android/socket.c
index 107042e..5045911 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -121,8 +121,8 @@ static void cleanup_rfsock(gpointer data)
 {
 	struct rfcomm_sock *rfsock = data;
 
-	DBG("rfsock: %p jv_sock %d bt_sock %d chan %u",
-		rfsock, rfsock->jv_sock, rfsock->bt_sock, rfsock->channel);
+	DBG("rfsock %p bt_sock %d jv_sock %d", rfsock, rfsock->bt_sock,
+							rfsock->jv_sock);
 
 	if (rfsock->jv_sock >= 0)
 		if (close(rfsock->jv_sock) < 0)
@@ -167,6 +167,8 @@ static struct rfcomm_sock *create_rfsock(int bt_sock, int *hal_sock)
 	*hal_sock = fds[1];
 	rfsock->bt_sock = bt_sock;
 
+	DBG("rfsock %p", rfsock);
+
 	if (bt_sock < 0)
 		return rfsock;
 
@@ -619,8 +621,7 @@ static gboolean jv_sock_client_event_cb(GIOChannel *io, GIOCondition cond,
 	}
 
 	if (cond & (G_IO_ERR | G_IO_NVAL)) {
-		error("Socket error: sock %d cond %d",
-					g_io_channel_unix_get_fd(io), cond);
+		error("Socket %d error", g_io_channel_unix_get_fd(io));
 		goto fail;
 	}
 
@@ -639,6 +640,8 @@ static gboolean jv_sock_client_event_cb(GIOChannel *io, GIOCondition cond,
 
 	return TRUE;
 fail:
+	DBG("rfsock %p jv_sock %d cond %d", rfsock, rfsock->jv_sock, cond);
+
 	connections = g_list_remove(connections, rfsock);
 	cleanup_rfsock(rfsock);
 
@@ -657,8 +660,7 @@ static gboolean bt_sock_event_cb(GIOChannel *io, GIOCondition cond,
 	}
 
 	if (cond & (G_IO_ERR | G_IO_NVAL)) {
-		error("Socket error: sock %d cond %d",
-					g_io_channel_unix_get_fd(io), cond);
+		error("Socket %d error", g_io_channel_unix_get_fd(io));
 		goto fail;
 	}
 
@@ -677,6 +679,8 @@ static gboolean bt_sock_event_cb(GIOChannel *io, GIOCondition cond,
 
 	return TRUE;
 fail:
+	DBG("rfsock %p bt_sock %d cond %d", rfsock, rfsock->bt_sock, cond);
+
 	connections = g_list_remove(connections, rfsock);
 	cleanup_rfsock(rfsock);
 
@@ -710,7 +714,7 @@ static gboolean jv_sock_server_event_cb(GIOChannel *io, GIOCondition cond,
 {
 	struct rfcomm_sock *rfsock = data;
 
-	DBG("sock %d cond %d", g_io_channel_unix_get_fd(io), cond);
+	DBG("rfsock %p jv_sock %d cond %d", rfsock, rfsock->jv_sock, cond);
 
 	if (cond & G_IO_NVAL)
 		return FALSE;
@@ -752,7 +756,8 @@ static void accept_cb(GIOChannel *io, GError *err, gpointer user_data)
 	}
 
 	ba2str(&dst, address);
-	DBG("Incoming connection from %s rfsock %p", address, rfsock);
+	DBG("Incoming connection from %s on channel %d (rfsock %p)", address,
+						rfsock->channel, rfsock);
 
 	new_sock = g_io_channel_unix_get_fd(io);
 	new_rfsock = create_rfsock(new_sock, &hal_sock);
@@ -761,9 +766,8 @@ static void accept_cb(GIOChannel *io, GError *err, gpointer user_data)
 		return;
 	}
 
-	DBG("rfsock: jv_sock %d bt_sock %d chan %u new_sock %d",
-		rfsock->jv_sock, rfsock->bt_sock, rfsock->channel,
-		new_sock);
+	DBG("new rfsock %p bt_sock %d jv_sock %d hal_sock %d", new_rfsock,
+			new_rfsock->bt_sock, new_rfsock->jv_sock, hal_sock);
 
 	if (!sock_send_accept(rfsock, &dst, hal_sock)) {
 		cleanup_rfsock(new_rfsock);
@@ -786,10 +790,6 @@ static void accept_cb(GIOChannel *io, GError *err, gpointer user_data)
 	g_io_channel_set_close_on_unref(io, FALSE);
 
 	new_rfsock->bt_watch = id;
-
-	DBG("rfsock %p rfsock_acc %p jv_watch %d bt_watch %d",
-		rfsock, new_rfsock, new_rfsock->jv_watch,
-		new_rfsock->bt_watch);
 }
 
 static uint8_t rfcomm_listen(int chan, const uint8_t *name, const uint8_t *uuid,
@@ -802,8 +802,14 @@ static uint8_t rfcomm_listen(int chan, const uint8_t *name, const uint8_t *uuid,
 	GIOCondition cond;
 	GError *err = NULL;
 	guint id;
+	uuid_t uu;
+	char uuid_str[32];
 
-	DBG("");
+	sdp_uuid128_create(&uu, uuid);
+	sdp_uuid2strn(&uu, uuid_str, sizeof(uuid_str));
+
+	DBG("chan %d flags 0x%02x uuid %s name %s", chan, flags, uuid_str,
+									name);
 
 	if (!memcmp(uuid, zero_uuid, sizeof(zero_uuid)) && chan <= 0) {
 		error("Invalid rfcomm listen params");
@@ -821,7 +827,7 @@ static uint8_t rfcomm_listen(int chan, const uint8_t *name, const uint8_t *uuid,
 		sec_level = profile->sec_level;
 	}
 
-	DBG("rfcomm channel %d svc_name %s", chan, name);
+	DBG("chan %d sec_level %d", chan, sec_level);
 
 	rfsock = create_rfsock(-1, hal_sock);
 	if (!rfsock)
@@ -853,8 +859,10 @@ static uint8_t rfcomm_listen(int chan, const uint8_t *name, const uint8_t *uuid,
 
 	rfsock->jv_watch = id;
 
-	DBG("bt_sock %d jv_sock %d hal_sock %d", rfsock->bt_sock,
-						rfsock->jv_sock, *hal_sock);
+	DBG("rfsock %p bt_sock %d jv_sock %d hal_sock %d", rfsock,
+								rfsock->bt_sock,
+								rfsock->jv_sock,
+								*hal_sock);
 
 	if (write(rfsock->jv_sock, &chan, sizeof(chan)) != sizeof(chan)) {
 		error("Error sending RFCOMM channel");
@@ -948,11 +956,8 @@ static void connect_cb(GIOChannel *io, GError *err, gpointer user_data)
 	}
 
 	ba2str(dst, address);
-	DBG("Connected to %s", address);
-
-	DBG("rfsock: jv_sock %d bt_sock %d chan %u sock %d",
-		rfsock->jv_sock, rfsock->bt_sock, rfsock->channel,
-		g_io_channel_unix_get_fd(io));
+	DBG("Connected to %s on channel %d (rfsock %p)", address,
+						rfsock->channel, rfsock);
 
 	if (!sock_send_connect(rfsock, dst))
 		goto fail;
@@ -987,6 +992,8 @@ static bool do_rfcomm_connect(struct rfcomm_sock *rfsock, int chan)
 	if (rfsock->profile)
 		sec_level = rfsock->profile->sec_level;
 
+	DBG("rfsock %p sec_level %d chan %d", rfsock, sec_level, chan);
+
 	io = bt_io_connect(connect_cb, rfsock, NULL, &gerr,
 				BT_IO_OPT_SOURCE_BDADDR, &adapter_addr,
 				BT_IO_OPT_DEST_BDADDR, &rfsock->dst,
@@ -1070,7 +1077,16 @@ static uint8_t connect_rfcomm(const bdaddr_t *addr, int chan,
 					int *hal_sock)
 {
 	struct rfcomm_sock *rfsock;
+	char address[18];
 	uuid_t uu;
+	char uuid_str[32];
+
+	sdp_uuid128_create(&uu, uuid);
+	sdp_uuid2strn(&uu, uuid_str, sizeof(uuid_str));
+	ba2str(addr, address);
+
+	DBG("addr %s chan %d flags 0x%02x uuid %s", address, chan, flags,
+								uuid_str);
 
 	if ((!memcmp(uuid, zero_uuid, sizeof(zero_uuid)) && chan <= 0) ||
 						!bacmp(addr, BDADDR_ANY)) {
@@ -1082,16 +1098,15 @@ static uint8_t connect_rfcomm(const bdaddr_t *addr, int chan,
 	if (!rfsock)
 		return HAL_STATUS_FAILED;
 
+	DBG("rfsock %p jv_sock %d hal_sock %d", rfsock, rfsock->jv_sock,
+							*hal_sock);
+
 	bacpy(&rfsock->dst, addr);
 
 	if (!memcmp(uuid, zero_uuid, sizeof(zero_uuid))) {
 		if (!do_rfcomm_connect(rfsock, chan))
 			goto failed;
 	} else {
-		memset(&uu, 0, sizeof(uu));
-		uu.type = SDP_UUID128;
-		memcpy(&uu.value.uuid128, uuid, sizeof(uint128_t));
-
 		rfsock->profile = get_profile_by_uuid(uuid);
 
 		if (bt_search_service(&adapter_addr, &rfsock->dst, &uu,
-- 
1.8.5.3

