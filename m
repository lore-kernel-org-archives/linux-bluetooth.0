Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 4/9] android/hal-sock: Initial listen handle
Date: Mon, 11 Nov 2013 14:37:13 +0200
Message-Id: <1384173438-21708-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1384173438-21708-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1384173438-21708-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Handle HAL socket listen call. Create RFCOMM socket and wait for events.
---
 android/socket.c |   94 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 92 insertions(+), 2 deletions(-)

diff --git a/android/socket.c b/android/socket.c
index c283c5f..80cb39e 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -27,22 +27,112 @@
 
 #include <glib.h>
 #include <stdbool.h>
+#include <errno.h>
 
 #include "lib/bluetooth.h"
+#include "btio/btio.h"
 #include "log.h"
 #include "hal-msg.h"
 #include "hal-ipc.h"
 #include "ipc.h"
+#include "adapter.h"
 #include "socket.h"
 
+/* Simple list of RFCOMM server sockets */
+GList *rfcomm_srv_list = NULL;
+/* Simple list of RFCOMM accepted sockets */
+GList *rfcomm_accepted_list = NULL;
 
-static int handle_listen(void *buf)
+struct rfcomm_slot {
+	int fd;
+	int hal_fd;
+	int real_sock;
+	uint32_t channel;
+};
+
+static struct rfcomm_slot *create_rfslot(int sock)
 {
-	DBG("Not implemented");
+	int fds[2] = {-1, -1};
+	struct rfcomm_slot *rfslot;
+
+	if (socketpair(AF_LOCAL, SOCK_STREAM, 0, fds) < 0) {
+		error("socketpair(): %s", strerror(errno));
+		return NULL;
+	}
+
+	rfslot = g_malloc0(sizeof(*rfslot));
+	rfslot->fd = fds[0];
+	rfslot->hal_fd = fds[1];
+	rfslot->real_sock = sock;
+
+	return rfslot;
+}
+
+static const uint8_t UUID_PBAP[] = {
+	0x00, 0x00, 0x11, 0x2F, 0x00, 0x00, 0x10, 0x00,
+	0x80, 0x00, 0x00, 0x80, 0x5F, 0x9B, 0x34, 0xFB
+};
+#define RFCOMM_CHAN_PBAP 19
+
+static const uint8_t UUID_OPP[] = {
+	0x00, 0x00, 0x11, 0x05, 0x00, 0x00, 0x10, 0x00,
+	0x80, 0x00, 0x00, 0x80, 0x5F, 0x9B, 0x34, 0xFB
+};
+#define RFCOMM_CHAN_OPP 12
+
+static int get_rfcomm_chan(const uint8_t *uuid)
+{
+	if (!memcmp(UUID_PBAP, uuid, sizeof(UUID_PBAP)))
+		return RFCOMM_CHAN_PBAP;
+
+	if (!memcmp(UUID_OPP, uuid, sizeof(UUID_OPP)))
+		return RFCOMM_CHAN_OPP;
 
 	return -1;
 }
 
+static void connect_cb(GIOChannel *io, GError *err, gpointer user_data)
+{
+}
+
+static int handle_listen(void *buf)
+{
+	struct hal_cmd_sock_listen *cmd = buf;
+	const bdaddr_t *src = bt_adapter_get_address();
+	struct rfcomm_slot *rfslot;
+	GIOChannel *io;
+	GError *err = NULL;
+	int ch;
+
+	DBG("");
+
+	ch = get_rfcomm_chan(cmd->uuid);
+	if (ch < 0)
+		return -1;
+
+	DBG("rfcomm channel %u", ch);
+
+	rfslot = create_rfslot(-1);
+
+	io = bt_io_listen(connect_cb, NULL, rfslot, NULL, &err,
+				BT_IO_OPT_SOURCE_BDADDR, src,
+				BT_IO_OPT_CHANNEL, ch,
+				BT_IO_OPT_INVALID);
+	if (!io) {
+		error("Failed listen: %s", err->message);
+		g_error_free(err);
+		return -1;
+	}
+
+	rfslot->real_sock = g_io_channel_unix_get_fd(io);
+	rfcomm_srv_list = g_list_append(rfcomm_srv_list, rfslot);
+
+	DBG("real_sock %d fd %d hal_fd %d",
+				rfslot->real_sock, rfslot->fd, rfslot->hal_fd);
+
+	return rfslot->hal_fd;
+}
+
 static int handle_connect(void *buf)
 {
 	DBG("Not implemented");
-- 
1.7.10.4

