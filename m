Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/6] shared/att: Make use of io_send
Date: Mon, 29 Sep 2014 17:57:41 +0300
Message-Id: <1412002664-28253-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1412002664-28253-1-git-send-email-luiz.dentz@gmail.com>
References: <1412002664-28253-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 src/shared/att.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/src/shared/att.c b/src/shared/att.c
index a5cab45..de35aef 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -422,16 +422,20 @@ static bool can_write_data(struct io *io, void *user_data)
 	struct bt_att *att = user_data;
 	struct att_send_op *op;
 	struct timeout_data *timeout;
-	ssize_t bytes_written;
+	ssize_t ret;
+	struct iovec iov;
 
 	op = pick_next_send_op(att);
 	if (!op)
 		return false;
 
-	bytes_written = write(att->fd, op->pdu, op->len);
-	if (bytes_written < 0) {
+	iov.iov_base = op->pdu;
+	iov.iov_len = op->len;
+
+	ret = io_send(io, &iov, 1);
+	if (ret < 0) {
 		util_debug(att->debug_callback, att->debug_data,
-					"write failed: %s", strerror(errno));
+					"write failed: %s", strerror(-ret));
 		if (op->callback)
 			op->callback(BT_ATT_OP_ERROR_RSP, NULL, 0,
 							op->user_data);
@@ -443,8 +447,7 @@ static bool can_write_data(struct io *io, void *user_data)
 	util_debug(att->debug_callback, att->debug_data,
 					"ATT op 0x%02x", op->opcode);
 
-	util_hexdump('<', op->pdu, bytes_written,
-					att->debug_callback, att->debug_data);
+	util_hexdump('<', op->pdu, ret, att->debug_callback, att->debug_data);
 
 	/* Based on the operation type, set either the pending request or the
 	 * pending indication. If it came from the write queue, then there is
-- 
1.9.3

