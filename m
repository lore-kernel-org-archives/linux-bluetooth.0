Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2] android/health: Cache MDL file desciptor
Date: Mon, 25 Aug 2014 15:54:30 +0300
Message-Id: <1408971270-21895-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

PTS expects to close all data channels before sending delete confirmation
to peer. But file descriptor passed over IPC to hal needs to be closed.
Due to timing issue IPC notification is triggering after sending
confirmation. So cache fd and shutdown on channel free will solve the issue.
---
v2: Fixed Szymon's comments.
---
 android/health.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/android/health.c b/android/health.c
index f49110a..2b068fe 100644
--- a/android/health.c
+++ b/android/health.c
@@ -102,6 +102,7 @@ struct health_channel {
 	struct mcap_mdl *mdl;
 	bool mdl_conn;
 	uint16_t mdl_id; /* MDL ID */
+	int fd;
 
 	uint16_t id; /* channel id */
 };
@@ -168,6 +169,11 @@ static void free_health_channel(void *data)
 	if (!channel)
 		return;
 
+	if (channel->fd >= 0) {
+		shutdown(channel->fd, SHUT_RDWR);
+		close(channel->fd);
+	}
+
 	unref_mdl(channel);
 	free(channel);
 }
@@ -1222,12 +1228,15 @@ static void mcap_mdl_connected_cb(struct mcap_mdl *mdl, void *data)
 		goto fail;
 	}
 
+	channel->fd = fd;
+
 	if (channel->mdep_id == MDEP_ECHO) {
 		GIOChannel *io;
 
 		io = g_io_channel_unix_new(fd);
 		g_io_add_watch(io, G_IO_ERR | G_IO_HUP | G_IO_NVAL | G_IO_IN,
 							serve_echo, channel);
+		g_io_channel_set_close_on_unref(io, FALSE);
 		g_io_channel_unref(io);
 
 		return;
@@ -1357,6 +1366,7 @@ static struct health_channel *create_channel(struct health_app *app,
 	channel->type = mdep->channel_type;
 	channel->id = channel_id++;
 	channel->dev = dev;
+	channel->fd = -1;
 
 	if (!queue_push_tail(dev->channels, channel)) {
 		free_health_channel(channel);
@@ -1547,6 +1557,7 @@ static void connect_mdl_cb(struct mcap_mdl *mdl, GError *gerr, gpointer data)
 		if (channel->type != CHANNEL_TYPE_RELIABLE)
 			goto fail;
 
+	channel->fd = fd;
 	send_channel_state_notify(channel, HAL_HEALTH_CHANNEL_CONNECTED, fd);
 
 	return;
-- 
1.9.1

