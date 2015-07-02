Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vcgomes@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vcgomes@gmail.com>
Subject: [RFC BlueZ 03/13] peripheral/gatt: Fix usage of mainloop_ functions
Date: Thu,  2 Jul 2015 11:33:44 -0300
Message-Id: <1435847634-22831-4-git-send-email-vcgomes@gmail.com>
In-Reply-To: <1435847634-22831-1-git-send-email-vcgomes@gmail.com>
References: <1435847634-22831-1-git-send-email-vcgomes@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If we want that this example is mainloop agnostic, it should use the
mainloop agnostic functions.
---
 peripheral/gatt.c | 72 +++++++++++++++++++++++++++++++++----------------------
 1 file changed, 43 insertions(+), 29 deletions(-)

diff --git a/peripheral/gatt.c b/peripheral/gatt.c
index 4c5531d..a66292f 100644
--- a/peripheral/gatt.c
+++ b/peripheral/gatt.c
@@ -25,6 +25,7 @@
 #include <config.h>
 #endif
 
+#include <errno.h>
 #include <stdio.h>
 #include <unistd.h>
 #include <stdlib.h>
@@ -34,7 +35,7 @@
 #include "lib/bluetooth.h"
 #include "lib/l2cap.h"
 #include "lib/uuid.h"
-#include "src/shared/mainloop.h"
+#include "src/shared/io.h"
 #include "src/shared/util.h"
 #include "src/shared/queue.h"
 #include "src/shared/att.h"
@@ -53,7 +54,7 @@ struct gatt_conn {
 	struct bt_gatt_client *client;
 };
 
-static int att_fd = -1;
+static struct io *att_io = NULL;
 static struct queue *conn_list = NULL;
 static struct gatt_db *gatt_db = NULL;
 static struct gatt_db *gatt_cache = NULL;
@@ -153,41 +154,43 @@ static struct gatt_conn *gatt_conn_new(int fd)
 	return conn;
 }
 
-static void att_conn_callback(int fd, uint32_t events, void *user_data)
+static bool att_conn_callback(struct io *io, void *user_data)
 {
 	struct gatt_conn *conn;
 	struct sockaddr_l2 addr;
 	socklen_t addrlen;
-	int new_fd;
+	int fd, new_fd;
 
-	if (events & (EPOLLERR | EPOLLHUP)) {
-		mainloop_remove_fd(fd);
-		return;
-	}
+	fd = io_get_fd(io);
+
+	fprintf(stderr, "att_conn_callback io %p\n", io);
 
 	memset(&addr, 0, sizeof(addr));
 	addrlen = sizeof(addr);
 
-	new_fd = accept(att_fd, (struct sockaddr *) &addr, &addrlen);
+	new_fd = accept(fd, (struct sockaddr *) &addr, &addrlen);
 	if (new_fd < 0) {
 		fprintf(stderr, "Failed to accept new ATT connection: %m\n");
-		return;
+		return true;
 	}
 
 	conn = gatt_conn_new(new_fd);
 	if (!conn) {
 		fprintf(stderr, "Failed to create GATT connection\n");
 		close(new_fd);
-		return;
+		return true;
 	}
 
 	if (!queue_push_tail(conn_list, conn)) {
 		fprintf(stderr, "Failed to add GATT connection\n");
 		gatt_conn_destroy(conn);
 		close(new_fd);
+		return true;
 	}
 
 	printf("New device connected\n");
+
+	return true;
 }
 
 static void gap_device_name_read(struct gatt_db_attribute *attrib,
@@ -243,13 +246,16 @@ static void populate_devinfo_service(struct gatt_db *db)
 void gatt_server_start(void)
 {
 	struct sockaddr_l2 addr;
+	int fd;
+
+	fprintf(stderr, "gatt_server_start\n");
 
-	if (att_fd >= 0)
+	if (att_io)
 		return;
 
-	att_fd = socket(PF_BLUETOOTH, SOCK_SEQPACKET | SOCK_CLOEXEC,
+	fd = socket(PF_BLUETOOTH, SOCK_SEQPACKET | SOCK_CLOEXEC | SOCK_NONBLOCK,
 							BTPROTO_L2CAP);
-	if (att_fd < 0) {
+	if (fd < 0) {
 		fprintf(stderr, "Failed to create ATT server socket: %m\n");
 		return;
 	}
@@ -260,24 +266,21 @@ void gatt_server_start(void)
 	memcpy(&addr.l2_bdaddr, static_addr, 6);
 	addr.l2_bdaddr_type = BDADDR_LE_RANDOM;
 
-	if (bind(att_fd, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
+	if (bind(fd, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
 		fprintf(stderr, "Failed to bind ATT server socket: %m\n");
-		close(att_fd);
-		att_fd = -1;
+		close(fd);
 		return;
 	}
 
-	if (listen(att_fd, 1) < 0) {
+	if (listen(fd, 1) < 0) {
 		fprintf(stderr, "Failed to listen on ATT server socket: %m\n");
-		close(att_fd);
-		att_fd = -1;
+		close(fd);
 		return;
 	}
 
 	gatt_db = gatt_db_new();
 	if (!gatt_db) {
-		close(att_fd);
-		att_fd = -1;
+		close(fd);
 		return;
 	}
 
@@ -290,20 +293,33 @@ void gatt_server_start(void)
 	if (!conn_list) {
 		gatt_db_unref(gatt_db);
 		gatt_db = NULL;
-		close(att_fd);
-		att_fd = -1;
+		close(fd);
+		return;
+	}
+
+	att_io = io_new(fd);
+
+	fprintf(stderr, "att_io %p\n", att_io);
+
+	if (!att_io) {
+		gatt_db_unref(gatt_db);
+		gatt_db = NULL;
+		close(fd);
+		queue_destroy(conn_list, NULL);
 		return;
 	}
 
-	mainloop_add_fd(att_fd, EPOLLIN, att_conn_callback, NULL, NULL);
+	if (!io_set_read_handler(att_io, att_conn_callback, NULL, NULL))
+		fprintf(stderr, "Failed to add read handler\n");
 }
 
 void gatt_server_stop(void)
 {
-	if (att_fd < 0)
+	if (!att_io)
 		return;
 
-	mainloop_remove_fd(att_fd);
+	io_destroy(att_io);
+	att_io = NULL;
 
 	queue_destroy(conn_list, gatt_conn_destroy);
 
@@ -313,6 +329,4 @@ void gatt_server_stop(void)
 	gatt_db_unref(gatt_db);
 	gatt_db = NULL;
 
-	close(att_fd);
-	att_fd = -1;
 }
-- 
2.4.5

