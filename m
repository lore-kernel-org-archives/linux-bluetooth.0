Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 05/10] android/socket: Cleanup sockets on unregister
Date: Thu, 28 Nov 2013 16:38:01 +0200
Message-Id: <1385649486-19978-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1385649486-19978-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1385649486-19978-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

This cleans up rfsock structures closing all sockets and making general cleanup
for servers and for connections. This will be called form socket unregister.
---
 android/socket.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/android/socket.c b/android/socket.c
index 1fb154d..d55db54 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -943,7 +943,27 @@ bool bt_socket_register(int sk, const bdaddr_t *addr)
 	return true;
 }
 
+static void free_connection(gpointer data, gpointer user_data)
+{
+	struct rfcomm_sock *rfsock = data;
+
+	connections = g_list_remove(connections, rfsock);
+	cleanup_rfsock(rfsock);
+}
+
+static void free_server(gpointer data, gpointer user_data)
+{
+	struct rfcomm_sock *rfsock = data;
+
+	servers = g_list_remove(servers, rfsock);
+	cleanup_rfsock(rfsock);
+}
+
 void bt_socket_unregister(void)
 {
 	DBG("");
+
+	g_list_foreach(connections, free_connection, NULL);
+
+	g_list_foreach(servers, free_server, NULL);
 }
-- 
1.8.3.2

