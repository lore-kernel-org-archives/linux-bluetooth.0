Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 8/9] android/health: Add handling for ECHO service
Date: Fri, 27 Jun 2014 10:40:02 +0300
Message-Id: <1403854803-28850-8-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1403854803-28850-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1403784265-1455-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1403854803-28850-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Reply received buffer back for ECHO service.
---
 android/health.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 62 insertions(+), 1 deletion(-)

diff --git a/android/health.c b/android/health.c
index 4f15f93..9631d9e 100644
--- a/android/health.c
+++ b/android/health.c
@@ -1054,9 +1054,70 @@ static int get_dcpsm(sdp_list_t *recs, uint16_t *dcpsm)
 	return -1;
 }
 
+static int send_echo_data(int sock, const void *buf, uint32_t size)
+{
+	const uint8_t *buf_b = buf;
+	uint32_t sent = 0;
+
+	while (sent < size) {
+		int n = write(sock, buf_b + sent, size - sent);
+		if (n < 0)
+			return -1;
+		sent += n;
+	}
+
+	return 0;
+}
+
+static gboolean serve_echo(GIOChannel *io, GIOCondition cond, gpointer data)
+{
+	struct health_channel *channel = data;
+	uint8_t buf[MCAP_DC_MTU];
+	int fd, len;
+
+	DBG("channel %p", channel);
+
+	if (cond & (G_IO_ERR | G_IO_HUP | G_IO_NVAL)) {
+		DBG("Error condition on channel");
+		return FALSE;
+	}
+
+	fd = g_io_channel_unix_get_fd(io);
+
+	len = read(fd, buf, sizeof(buf));
+	if (len < 0)
+		goto fail;
+
+	if (send_echo_data(fd, buf, len)  >= 0)
+		return TRUE;
+
+fail:
+	free_health_device(channel->dev);
+	return FALSE;
+}
+
 static void mcap_mdl_connected_cb(struct mcap_mdl *mdl, void *data)
 {
-	DBG("Not Implemeneted");
+	struct health_channel *channel = data;
+
+	if (!channel->mdl)
+		channel->mdl = mcap_mdl_ref(mdl);
+
+	DBG("Data channel connected: mdl %p channel %p", mdl, channel);
+
+	if (channel->mdep_id == HDP_MDEP_ECHO) {
+		GIOChannel *io;
+		int fd;
+
+		fd = mcap_mdl_get_fd(channel->mdl);
+		if (fd < 0)
+			return;
+
+		io = g_io_channel_unix_new(fd);
+		g_io_add_watch(io, G_IO_ERR | G_IO_HUP | G_IO_NVAL | G_IO_IN,
+							serve_echo, channel);
+		g_io_channel_unref(io);
+	}
 }
 
 static void mcap_mdl_closed_cb(struct mcap_mdl *mdl, void *data)
-- 
1.8.3.2

