Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 05/11] android/socket: Make servers list as static array
Date: Tue, 11 Feb 2014 17:58:15 +0100
Message-ID: <1392137901-3403-6-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1392137901-3403-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1392137901-3403-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Since there is only small, fixed number of channels to allocate for
RFCOMM servers we can store them in static array. This will make
lookup for free channel simpler once we add support to assign channel
numbers dynamically.

At startup, channels reserved for built-in services which have static
channel number are marked as reserved so they cannot be assigned for
other service.
---
 android/socket.c | 44 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 37 insertions(+), 7 deletions(-)

diff --git a/android/socket.c b/android/socket.c
index 32de91a..4e823dd 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -45,6 +45,8 @@
 #include "utils.h"
 #include "socket.h"
 
+#define RFCOMM_CHANNEL_MAX 30
+
 #define SPP_DEFAULT_CHANNEL	3
 #define OPP_DEFAULT_CHANNEL	9
 #define PBAP_DEFAULT_CHANNEL	15
@@ -64,9 +66,6 @@ static bdaddr_t adapter_addr;
 
 static const uint8_t zero_uuid[16] = { 0 };
 
-/* Simple list of RFCOMM server sockets */
-GList *servers = NULL;
-
 /* Simple list of RFCOMM connected sockets */
 GList *connections = NULL;
 
@@ -90,6 +89,13 @@ struct rfcomm_sock {
 	const struct profile_info *profile;
 };
 
+struct rfcomm_channel {
+	bool reserved;
+	struct rfcomm_sock *rfsock;
+};
+
+static struct rfcomm_channel servers[RFCOMM_CHANNEL_MAX + 1];
+
 static int rfsock_set_buffer(struct rfcomm_sock *rfsock)
 {
 	socklen_t len = sizeof(int);
@@ -599,7 +605,7 @@ static gboolean jv_sock_server_event_cb(GIOChannel *io, GIOCondition cond,
 		return FALSE;
 
 	if (cond & (G_IO_ERR | G_IO_HUP )) {
-		servers = g_list_remove(servers, rfsock);
+		servers[rfsock->channel].rfsock = NULL;
 		cleanup_rfsock(rfsock);
 	}
 
@@ -690,7 +696,8 @@ static uint8_t rfcomm_listen(int chan, const uint8_t *name, const uint8_t *uuid,
 	DBG("chan %d flags 0x%02x uuid %s name %s", chan, flags, uuid_str,
 									name);
 
-	if (!memcmp(uuid, zero_uuid, sizeof(zero_uuid)) && chan <= 0) {
+	if ((!memcmp(uuid, zero_uuid, sizeof(zero_uuid)) && chan <= 0) ||
+			(chan > RFCOMM_CHANNEL_MAX)) {
 		error("Invalid rfcomm listen params");
 		return HAL_STATUS_INVALID;
 	}
@@ -706,12 +713,19 @@ static uint8_t rfcomm_listen(int chan, const uint8_t *name, const uint8_t *uuid,
 		sec_level = profile->sec_level;
 	}
 
+	if (servers[chan].rfsock != NULL) {
+		error("Channel already registered (%d)", chan);
+		return HAL_STATUS_BUSY;
+	}
+
 	DBG("chan %d sec_level %d", chan, sec_level);
 
 	rfsock = create_rfsock(-1, hal_sock);
 	if (!rfsock)
 		return HAL_STATUS_FAILED;
 
+	rfsock->channel = chan;
+
 	io = bt_io_listen(accept_cb, NULL, rfsock, NULL, &err,
 				BT_IO_OPT_SOURCE_BDADDR, &adapter_addr,
 				BT_IO_OPT_CHANNEL, chan,
@@ -750,7 +764,7 @@ static uint8_t rfcomm_listen(int chan, const uint8_t *name, const uint8_t *uuid,
 
 	rfsock->service_handle = sdp_service_register(profile, name);
 
-	servers = g_list_append(servers, rfsock);
+	servers[chan].rfsock = rfsock;
 
 	return HAL_STATUS_SUCCESS;
 
@@ -1050,8 +1064,17 @@ static const struct ipc_handler cmd_handlers[] = {
 
 void bt_socket_register(const bdaddr_t *addr)
 {
+	size_t i;
+
 	DBG("");
 
+	/* make sure channels assigned for profiles are reserved and not used
+	 * for app services
+	 */
+	for (i = 0; i < G_N_ELEMENTS(profiles); i++)
+		if (profiles[i].channel)
+			servers[profiles[i].channel].reserved = true;
+
 	bacpy(&adapter_addr, addr);
 	ipc_register(HAL_SERVICE_ID_SOCK, cmd_handlers,
 						G_N_ELEMENTS(cmd_handlers));
@@ -1059,10 +1082,17 @@ void bt_socket_register(const bdaddr_t *addr)
 
 void bt_socket_unregister(void)
 {
+	int ch;
+
 	DBG("");
 
 	g_list_free_full(connections, cleanup_rfsock);
-	g_list_free_full(servers, cleanup_rfsock);
+
+	for (ch = 0; ch <= RFCOMM_CHANNEL_MAX; ch++)
+		if (servers[ch].rfsock)
+			cleanup_rfsock(&servers[ch]);
+
+	memset(servers, 0, sizeof(servers));
 
 	ipc_unregister(HAL_SERVICE_ID_SOCK);
 }
-- 
1.8.5.3

