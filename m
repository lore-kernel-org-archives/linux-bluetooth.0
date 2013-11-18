Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 07/16] android/socket: Implement RFCOMM events
Date: Mon, 18 Nov 2013 10:26:10 +0200
Message-Id: <1384763179-2218-8-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1384763179-2218-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1384763179-2218-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Copy data from RFCOMM socket to Android framework. Consider splice
in the future.
---
 android/socket.c |   38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/android/socket.c b/android/socket.c
index 027b519..eba50f6 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -185,6 +185,44 @@ static gboolean sock_stack_event_cb(GIOChannel *io, GIOCondition cond,
 static gboolean sock_rfcomm_event_cb(GIOChannel *io, GIOCondition cond,
 								gpointer data)
 {
+	struct rfcomm_slot *rfslot = data;
+	unsigned char buf[1024];
+	int len, sent;
+
+	DBG("rfslot: fd %d real_sock %d chan %u sock %d",
+		rfslot->fd, rfslot->real_sock, rfslot->channel,
+		g_io_channel_unix_get_fd(io));
+
+	if (!g_list_find(rfcomm_connected_list, rfslot)) {
+		error("rfslot %p not found in the list", rfslot);
+		return FALSE;
+	}
+
+	if (cond & (G_IO_ERR | G_IO_HUP | G_IO_NVAL)) {
+		error("Socket error: sock %d cond %d",
+					g_io_channel_unix_get_fd(io), cond);
+		rfcomm_connected_list = g_list_remove(rfcomm_connected_list,
+								rfslot);
+		cleanup_rfslot(rfslot);
+		return FALSE;
+	}
+
+	len = read(rfslot->real_sock, buf, sizeof(buf));
+	if (len <= 0) {
+		error("read(): %s", strerror(errno));
+		return FALSE;
+	}
+
+	DBG("read %d bytes, write to fd %d", len, rfslot->fd);
+
+	sent = try_write_all(rfslot->fd, buf, len);
+	if (sent < 0) {
+		error("write(): %s", strerror(errno));
+		return FALSE;
+	}
+
+	DBG("Written %d bytes", sent);
+
 	return TRUE;
 }
 
-- 
1.7.10.4

