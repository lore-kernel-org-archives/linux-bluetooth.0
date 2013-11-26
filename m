Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/6] android/socket: Check create_rfsock returns valid structure
Date: Tue, 26 Nov 2013 16:05:48 +0200
Message-Id: <1385474750-18331-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1385474750-18331-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1385474750-18331-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/socket.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/android/socket.c b/android/socket.c
index c4f14ab..772afaa 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -638,6 +638,11 @@ static void accept_cb(GIOChannel *io, GError *err, gpointer user_data)
 
 	sock_acc = g_io_channel_unix_get_fd(io);
 	rfsock_acc = create_rfsock(sock_acc, &hal_fd);
+	if (!rfsock_acc) {
+		g_io_channel_shutdown(io, TRUE, NULL);
+		return;
+	}
+
 	connections = g_list_append(connections, rfsock_acc);
 
 	DBG("rfsock: fd %d real_sock %d chan %u sock %d",
@@ -898,8 +903,11 @@ static int handle_connect(void *buf)
 
 	DBG("");
 
-	android2bdaddr(cmd->bdaddr, &dst);
 	rfsock = create_rfsock(-1, &hal_fd);
+	if (!rfsock)
+		return -1;
+
+	android2bdaddr(cmd->bdaddr, &dst);
 	bacpy(&rfsock->dst, &dst);
 
 	memset(&uuid, 0, sizeof(uuid));
-- 
1.8.3.2

