Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/6] shared/mgmt: Make use of io_send
Date: Mon, 29 Sep 2014 17:57:43 +0300
Message-Id: <1412002664-28253-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1412002664-28253-1-git-send-email-luiz.dentz@gmail.com>
References: <1412002664-28253-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 src/shared/mgmt.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/src/shared/mgmt.c b/src/shared/mgmt.c
index ae90b89..5dae7a9 100644
--- a/src/shared/mgmt.c
+++ b/src/shared/mgmt.c
@@ -162,7 +162,8 @@ static bool can_write_data(struct io *io, void *user_data)
 {
 	struct mgmt *mgmt = user_data;
 	struct mgmt_request *request;
-	ssize_t bytes_written;
+	struct iovec iov;
+	ssize_t ret;
 
 	request = queue_pop_head(mgmt->reply_queue);
 	if (!request) {
@@ -175,10 +176,13 @@ static bool can_write_data(struct io *io, void *user_data)
 			return false;
 	}
 
-	bytes_written = write(mgmt->fd, request->buf, request->len);
-	if (bytes_written < 0) {
+	iov.iov_base = request->buf;
+	iov.iov_len = request->len;
+
+	ret = io_send(io, &iov, 1);
+	if (ret < 0) {
 		util_debug(mgmt->debug_callback, mgmt->debug_data,
-				"write failed: %s", strerror(errno));
+				"write failed: %s", strerror(-ret));
 		if (request->callback)
 			request->callback(MGMT_STATUS_FAILED, 0, NULL,
 							request->user_data);
@@ -190,8 +194,8 @@ static bool can_write_data(struct io *io, void *user_data)
 				"[0x%04x] command 0x%04x",
 				request->index, request->opcode);
 
-	util_hexdump('<', request->buf, bytes_written,
-				mgmt->debug_callback, mgmt->debug_data);
+	util_hexdump('<', request->buf, ret, mgmt->debug_callback,
+							mgmt->debug_data);
 
 	queue_push_tail(mgmt->pending_list, request);
 
-- 
1.9.3

