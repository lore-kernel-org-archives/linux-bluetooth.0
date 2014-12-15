Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v2 02/12] shared/att: Add err argument to disconnect cb
Date: Mon, 15 Dec 2014 07:29:06 -0800
Message-Id: <1418657356-18967-3-git-send-email-armansito@chromium.org>
In-Reply-To: <1418657356-18967-1-git-send-email-armansito@chromium.org>
References: <1418657356-18967-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds an "int err" argument to the disconnect callback.
shared/att obtains the value of SO_ERROR option for the underlying
fd and passes it to the callbacks.
---
 src/shared/att.c         | 25 ++++++++++++++++++++-----
 src/shared/att.h         |  2 +-
 src/shared/gatt-client.c |  2 +-
 tools/btgatt-client.c    |  4 ++--
 tools/btgatt-server.c    |  4 ++--
 5 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/src/shared/att.c b/src/shared/att.c
index 447863d..6a733fa 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -502,28 +502,43 @@ static void wakeup_writer(struct bt_att *att)
 static void disconn_handler(void *data, void *user_data)
 {
 	struct att_disconn *disconn = data;
+	int err = PTR_TO_INT(user_data);
 
 	if (disconn->removed)
 		return;
 
 	if (disconn->callback)
-		disconn->callback(disconn->user_data);
+		disconn->callback(err, disconn->user_data);
 }
 
 static bool disconnect_cb(struct io *io, void *user_data)
 {
 	struct bt_att *att = user_data;
+	int err;
+	socklen_t len;
 
-	io_destroy(att->io);
-	att->io = NULL;
+	len = sizeof(err);
+
+	if (getsockopt(att->fd, SOL_SOCKET, SO_ERROR, &err, &len) < 0) {
+		util_debug(att->debug_callback, att->debug_data,
+					"Failed to obtain disconnect error: %s",
+					strerror(errno));
+		err = 0;
+	}
 
 	util_debug(att->debug_callback, att->debug_data,
-						"Physical link disconnected");
+					"Physical link disconnected: %s",
+					strerror(err));
+
+	io_destroy(att->io);
+	att->io = NULL;
 
 	bt_att_cancel_all(att);
 
 	bt_att_ref(att);
-	queue_foreach(att->disconn_list, disconn_handler, NULL);
+
+	queue_foreach(att->disconn_list, disconn_handler, INT_TO_PTR(err));
+
 	bt_att_unregister_all(att);
 	bt_att_unref(att);
 
diff --git a/src/shared/att.h b/src/shared/att.h
index 99b5a5b..cd00a1e 100644
--- a/src/shared/att.h
+++ b/src/shared/att.h
@@ -43,7 +43,7 @@ typedef void (*bt_att_destroy_func_t)(void *user_data);
 typedef void (*bt_att_debug_func_t)(const char *str, void *user_data);
 typedef void (*bt_att_timeout_func_t)(unsigned int id, uint8_t opcode,
 							void *user_data);
-typedef void (*bt_att_disconnect_func_t)(void *user_data);
+typedef void (*bt_att_disconnect_func_t)(int err, void *user_data);
 
 bool bt_att_set_debug(struct bt_att *att, bt_att_debug_func_t callback,
 				void *user_data, bt_att_destroy_func_t destroy);
diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index a15f3b8..41df669 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -1436,7 +1436,7 @@ static void bt_gatt_client_free(struct bt_gatt_client *client)
 	free(client);
 }
 
-static void att_disconnect_cb(void *user_data)
+static void att_disconnect_cb(int err, void *user_data)
 {
 	struct bt_gatt_client *client = user_data;
 	bool in_init = client->in_init;
diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index 015142d..e2e0537 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -74,9 +74,9 @@ static void print_prompt(void)
 	fflush(stdout);
 }
 
-static void att_disconnect_cb(void *user_data)
+static void att_disconnect_cb(int err, void *user_data)
 {
-	printf("Device disconnected\n");
+	printf("Device disconnected: %s\n", strerror(err));
 
 	mainloop_quit();
 }
diff --git a/tools/btgatt-server.c b/tools/btgatt-server.c
index 1a9b9fb..f6ad8c3 100644
--- a/tools/btgatt-server.c
+++ b/tools/btgatt-server.c
@@ -101,9 +101,9 @@ static void print_prompt(void)
 	fflush(stdout);
 }
 
-static void att_disconnect_cb(void *user_data)
+static void att_disconnect_cb(int err, void *user_data)
 {
-	printf("Device disconnected\n");
+	printf("Device disconnected: %s\n", strerror(err));
 
 	mainloop_quit();
 }
-- 
2.2.0.rc0.207.ga3a616c

