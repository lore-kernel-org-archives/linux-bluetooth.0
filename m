Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 2/6] android/health: Add channel_notify for incoming connections
Date: Mon, 30 Jun 2014 15:53:45 +0300
Message-Id: <1404132829-5670-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1404132829-5670-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1404132829-5670-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

For other then ECHO mdep send send_channel_state_notify with fd.
---
 android/health.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/android/health.c b/android/health.c
index fcb40f2..94d3804 100644
--- a/android/health.c
+++ b/android/health.c
@@ -1136,25 +1136,36 @@ static gboolean serve_echo(GIOChannel *io, GIOCondition cond, gpointer data)
 static void mcap_mdl_connected_cb(struct mcap_mdl *mdl, void *data)
 {
 	struct health_channel *channel = data;
+	int fd;
 
 	if (!channel->mdl)
 		channel->mdl = mcap_mdl_ref(mdl);
 
 	DBG("Data channel connected: mdl %p channel %p", mdl, channel);
 
+	fd = mcap_mdl_get_fd(channel->mdl);
+	if (fd < 0) {
+		error("health: error retrieving fd");
+		goto fail;
+	}
+
 	if (channel->mdep_id == MDEP_ECHO) {
 		GIOChannel *io;
-		int fd;
-
-		fd = mcap_mdl_get_fd(channel->mdl);
-		if (fd < 0)
-			return;
 
 		io = g_io_channel_unix_new(fd);
 		g_io_add_watch(io, G_IO_ERR | G_IO_HUP | G_IO_NVAL | G_IO_IN,
 							serve_echo, channel);
 		g_io_channel_unref(io);
+
+		return;
 	}
+
+	send_channel_state_notify(channel, HAL_HEALTH_CHANNEL_CONNECTED, fd);
+
+	return;
+fail:
+	/* TODO: mcap_mdl_abort */
+	destroy_channel(channel);
 }
 
 static void mcap_mdl_closed_cb(struct mcap_mdl *mdl, void *data)
-- 
1.8.3.2

