Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 05/16] android/hal-sock: Initial listen handle
Date: Thu, 14 Nov 2013 17:11:44 +0200
Message-Id: <1384441915-23966-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1384441915-23966-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1384441915-23966-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Handle HAL socket listen call. Create RFCOMM socket and wait for events.
---
 android/socket.c |  106 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 104 insertions(+), 2 deletions(-)

diff --git a/android/socket.c b/android/socket.c
index 4699dce..276c78c 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -27,8 +27,12 @@
 
 #include <glib.h>
 #include <stdbool.h>
+#include <unistd.h>
+#include <errno.h>
 
 #include "lib/bluetooth.h"
+#include "btio/btio.h"
+#include "lib/sdp.h"
 #include "log.h"
 #include "hal-msg.h"
 #include "hal-ipc.h"
@@ -49,13 +53,111 @@ struct rfcomm_slot {
 	int channel;	/* RFCOMM channel */
 };
 
-static int handle_listen(void *buf)
+static struct rfcomm_slot *create_rfslot(int sock, int *hal_fd)
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
+	*hal_fd = fds[1];
+	rfslot->real_sock = sock;
+
+	return rfslot;
+}
+
+static void cleanup_rfslot(struct rfcomm_slot *rfslot)
+{
+	DBG("Cleanup: rfslot: %p fd %d real_sock %d chan %u",
+		rfslot, rfslot->fd, rfslot->real_sock, rfslot->channel);
+
+	if (rfslot->fd > 0)
+		close(rfslot->fd);
+	if (rfslot->real_sock > 0)
+		close(rfslot->real_sock);
+
+	g_free(rfslot);
+}
+
+static struct {
+	uint8_t uuid[16];
+	uint8_t channel;
+} uuid_to_chan[] = {
+	{ .uuid = {
+	0x00, 0x00, 0x11, 0x2F, 0x00, 0x00, 0x10, 0x00,
+	0x80, 0x00, 0x00, 0x80, 0x5F, 0x9B, 0x34, 0xFB
+	},
+#define PBAP_DEFAULT_CHANNEL	15
+	.channel = PBAP_DEFAULT_CHANNEL },
+	{ .uuid = {
+	0x00, 0x00, 0x11, 0x05, 0x00, 0x00, 0x10, 0x00,
+	0x80, 0x00, 0x00, 0x80, 0x5F, 0x9B, 0x34, 0xFB
+	},
+#define OPP_DEFAULT_CHANNEL	9
+	.channel = OPP_DEFAULT_CHANNEL },
+	{ {0} }
+};
+
+static int get_rfcomm_default_chan(const uint8_t *uuid)
+{
+	int i;
+
+	for (i = 0; uuid_to_chan[i].channel; i++) {
+		if (!memcmp(uuid_to_chan[i].uuid, uuid, 16))
+			return uuid_to_chan[i].channel;
+	}
 
 	return -1;
 }
 
+static void accept_cb(GIOChannel *io, GError *err, gpointer user_data)
+{
+}
+
+static int handle_listen(void *buf)
+{
+	struct hal_cmd_sock_listen *cmd = buf;
+	struct rfcomm_slot *rfslot;
+	GIOChannel *io;
+	GError *err = NULL;
+	int hal_fd = -1;
+	int chan;
+
+	DBG("");
+
+	chan = get_rfcomm_default_chan(cmd->uuid);
+	if (chan < 0)
+		return -1;
+
+	DBG("rfcomm channel %d", chan);
+
+	rfslot = create_rfslot(-1, &hal_fd);
+
+	io = bt_io_listen(accept_cb, NULL, rfslot, NULL, &err,
+				BT_IO_OPT_SOURCE_BDADDR, &adapter_addr,
+				BT_IO_OPT_CHANNEL, chan,
+				BT_IO_OPT_INVALID);
+	if (!io) {
+		error("Failed listen: %s", err->message);
+		g_error_free(err);
+		cleanup_rfslot(rfslot);
+		return -1;
+	}
+
+	rfslot->real_sock = g_io_channel_unix_get_fd(io);
+	rfcomm_srv_list = g_list_append(rfcomm_srv_list, rfslot);
+
+	DBG("real_sock %d fd %d hal_fd %d",
+				rfslot->real_sock, rfslot->fd, hal_fd);
+
+	return hal_fd;
+}
+
 static int handle_connect(void *buf)
 {
 	DBG("Not implemented");
-- 
1.7.10.4

